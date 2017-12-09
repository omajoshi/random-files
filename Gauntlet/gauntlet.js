if (!window._gauntlet_positions) {
    _gauntlet_positions = {
        'QB': '1',
        'HB': '2',
        'FB': '3',
        'WR': '4',
        'TE': '5',
        'LT': '6',
        'LG': '7',
        'C': '8',
        'RG': '9',
        'RT': '10',
        'LE': '11',
        'RE': '12',
        'DT': '13',
        'LOLB': '14',
        'MLB': '15',
        'ROLB': '16',
        'CB': '17',
        'FS': '18',
        'SS': '19',
        'K': '20',
        'P': '21'
    }
}
if (!window._gauntlet_ratings) {
    _gauntlet_ratings = {
        '': '',
        'acc': '1',
        'agi': '2',
        'awr': '3',
        'bcv': '4',
        'bks': '5',
        'car': '6',
        'cit': '7',
        'cth': '8',
        'elu': '9',
        'fnm': '10',
        'ht': '11',
        'pow': '24',
        'imp': '12',
        'inj': '13',
        'jkm': '14',
        'jmp': '15',
        'kac': '16',
        'kpw': '17',
        'kr': '31',
        'mcv': '18',
        'pbk': '21',
        'pbf': '20',
        'pbs': '22',
        'pac': '19',
        'prc': '25',
        'pwm': '23',
        'prs': '26',
        'pur': '27',
        'rls': '32',
        'rte': '33',
        'rbk': '29',
        'rbf': '28',
        'rbs': '30',
        'spc': '34',
        'spd': '35',
        'spm': '36',
        'sta': '37',
        'sfa': '38',
        'str': '39',
        'tak': '42',
        'tha': '40',
        'tad': '41',
        'tam': '43',
        'tas': '44',
        'tor': '46',
        'thp': '45',
        'trk': '47',
        'wt': '48',
        'zcv': '49'
    }
}
stats = []
if (!window._gauntlet_getStat) {
    function _gauntlet_getStat(cards, highestStat) {
        if (cards[0]) {
            t = $('.' + cards[0].classList.value.replace(/ /g, '.'))
            name = t.find('.first-and-last-name').text()
            salary = t.find('.cap-hit').text()
            ovr = t.find('.overall').text()
            stat = $('.question').text().split(/[()]/)[1].toLowerCase()
            pos = t.find('.position').text()
            query = {
                'filter-search': name,
                'filter-salary-min': salary,
                'filter-salary-max': salary,
                'filter-ovr-min': ovr,
                'filter-ovr-max': ovr,
                'filter-madden-rating': _gauntlet_ratings[stat],
                'filter-position': 2 ** _gauntlet_positions[pos] / 2,
            }
            $.get('http://www.muthead.com/18/players', query).done(function(data) {
    			d = $(data)
                o = d.find('.col-overall')[1].innerHTML.trim()
                n = d.find('.name-program a')[0].innerHTML.trim()
                r = d.find('.col-madden-rating')[1].innerHTML.trim()
                p = d.find('.col-position')[1].innerHTML.trim()
                console.log(o, n, p, r, stat)
    			stats.push(r*1)
                _gauntlet_getStat(cards.slice(1), r > highestStat ? r : 0)
            })
        } else {
    		$('.mut-item')[stats.indexOf(Math.max(...stats))].click()
        }
    }
}
if ($('.continue-button').length) {
    $('.continue-button').each(function(a,b){b.click()})
} else {
    _gauntlet_getStat($('.mut-item').toArray(), 0)
}
