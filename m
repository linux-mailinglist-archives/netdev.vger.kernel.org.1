Return-Path: <netdev+bounces-208277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC247B0ACAD
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 02:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20615641F9
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926A3FE4;
	Sat, 19 Jul 2025 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2LLgmh5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5223DE;
	Sat, 19 Jul 2025 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883456; cv=none; b=XdQcIU2U9LwkPHYXqgBXqsTODrqQQlLvSqmwHTSyg0U7ye+to+YVbSf4WIdUnn0wwe9nZLzkG4w2R6KQNlz6VMqfkmO2Xecq591DMKJkyHgAP39xXF+JGx/No8t0ipTtt7wD5Lvz9KevVovLlJwecy3tbt8ZjOcMRDZT6Jo8vuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883456; c=relaxed/simple;
	bh=geY2NGe5vQ3XPgTxB6ZhxhNVRj0H/L4vp2+xB8yVe0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8Ppo0ENY1wWgAjHaQ9fI9Z4Eb/+U2U+a1YmEnueawQ2HJnaDn8udS1ix0+QcWZb3YNtoDyJKYBVsPCNWFJUqy7CYteL+kqF67nwLl42329FbTcwUydV6/J5uwmbz0Ss9oAx5a3V6iJMiZoT9Qi/56L0KcLFx5i+X8fuQpp/KK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2LLgmh5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752883455; x=1784419455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=geY2NGe5vQ3XPgTxB6ZhxhNVRj0H/L4vp2+xB8yVe0M=;
  b=R2LLgmh5hRK8/TFaHq9g3NTf9bydU/EBp/1EmuUOz52qIi554xYlWhMn
   v2KMUngBCQpfy71HmkiBVkTtzWjC/zw/MvXBuvAaM7vbTiUxpay9fiqgM
   COwtfL03rm/I8pq15LQCQ/4HA9xCUmAeEpyngnzSs8dWWn3dbdpie3r5G
   yInjyP1dUHgAsxhUn5PxETAwudgwX1fuyAzzhU9GctwrMxH53cCuIhYvz
   6HEoXQM1CkTwmYUegbkp+VF/pVby7c9xR4h8S5352+5a1O2gsEVfzKCF5
   clDrzBR+SiMbF0X+cJ/2s0cBIYcUag0Sv8DTFJmHtY1S3wskVULTn30AM
   A==;
X-CSE-ConnectionGUID: vnEb+wtSSJqdNZGyr+Ii8g==
X-CSE-MsgGUID: Lmmqhw40R2mc7AjTMkQPwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="65445122"
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="65445122"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 17:04:14 -0700
X-CSE-ConnectionGUID: lDH6Bw+nTDSSHbYmn62MNw==
X-CSE-MsgGUID: P4LeLxcjSpiz1bOcFzKGKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="189300274"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jul 2025 17:04:10 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucv3g-000F9P-2p;
	Sat, 19 Jul 2025 00:04:08 +0000
Date: Sat, 19 Jul 2025 08:03:49 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/5] netconsole: move netpoll_parse_ip_addr()
 earlier for reuse
Message-ID: <202507190704.mjDNQvmd-lkp@intel.com>
References: <20250718-netconsole_ref-v1-2-86ef253b7a7a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-netconsole_ref-v1-2-86ef253b7a7a@debian.org>

Hi Breno,

kernel test robot noticed the following build errors:

[auto build test ERROR on d61f6cb6f6ef3c70d2ccc0d9c85c508cb8017da9]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/netpoll-Remove-unused-fields-from-inet_addr-union/20250718-195552
base:   d61f6cb6f6ef3c70d2ccc0d9c85c508cb8017da9
patch link:    https://lore.kernel.org/r/20250718-netconsole_ref-v1-2-86ef253b7a7a%40debian.org
patch subject: [PATCH net-next 2/5] netconsole: move netpoll_parse_ip_addr() earlier for reuse
config: arc-randconfig-002-20250719 (https://download.01.org/0day-ci/archive/20250719/202507190704.mjDNQvmd-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250719/202507190704.mjDNQvmd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507190704.mjDNQvmd-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/netconsole.c: In function 'netconsole_parser_cmdline':
>> drivers/net/netconsole.c:1789:24: error: implicit declaration of function 'netpoll_parse_ip_addr' [-Wimplicit-function-declaration]
    1789 |                 ipv6 = netpoll_parse_ip_addr(cur, &np->local_ip);
         |                        ^~~~~~~~~~~~~~~~~~~~~


vim +/netpoll_parse_ip_addr +1789 drivers/net/netconsole.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  1764  
abebef96aab12da Breno Leitao   2025-06-13  1765  static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
5a34c9a8536511b Breno Leitao   2025-06-13  1766  {
5a34c9a8536511b Breno Leitao   2025-06-13  1767  	bool ipversion_set = false;
abebef96aab12da Breno Leitao   2025-06-13  1768  	char *cur = opt;
abebef96aab12da Breno Leitao   2025-06-13  1769  	char *delim;
abebef96aab12da Breno Leitao   2025-06-13  1770  	int ipv6;
5a34c9a8536511b Breno Leitao   2025-06-13  1771  
5a34c9a8536511b Breno Leitao   2025-06-13  1772  	if (*cur != '@') {
d79206451f4f99a Breno Leitao   2025-06-13  1773  		delim = strchr(cur, '@');
d79206451f4f99a Breno Leitao   2025-06-13  1774  		if (!delim)
5a34c9a8536511b Breno Leitao   2025-06-13  1775  			goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1776  		*delim = 0;
5a34c9a8536511b Breno Leitao   2025-06-13  1777  		if (kstrtou16(cur, 10, &np->local_port))
5a34c9a8536511b Breno Leitao   2025-06-13  1778  			goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1779  		cur = delim;
5a34c9a8536511b Breno Leitao   2025-06-13  1780  	}
5a34c9a8536511b Breno Leitao   2025-06-13  1781  	cur++;
5a34c9a8536511b Breno Leitao   2025-06-13  1782  
5a34c9a8536511b Breno Leitao   2025-06-13  1783  	if (*cur != '/') {
5a34c9a8536511b Breno Leitao   2025-06-13  1784  		ipversion_set = true;
d79206451f4f99a Breno Leitao   2025-06-13  1785  		delim = strchr(cur, '/');
d79206451f4f99a Breno Leitao   2025-06-13  1786  		if (!delim)
5a34c9a8536511b Breno Leitao   2025-06-13  1787  			goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1788  		*delim = 0;
5a34c9a8536511b Breno Leitao   2025-06-13 @1789  		ipv6 = netpoll_parse_ip_addr(cur, &np->local_ip);
5a34c9a8536511b Breno Leitao   2025-06-13  1790  		if (ipv6 < 0)
5a34c9a8536511b Breno Leitao   2025-06-13  1791  			goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1792  		else
5a34c9a8536511b Breno Leitao   2025-06-13  1793  			np->ipv6 = (bool)ipv6;
5a34c9a8536511b Breno Leitao   2025-06-13  1794  		cur = delim;
5a34c9a8536511b Breno Leitao   2025-06-13  1795  	}
5a34c9a8536511b Breno Leitao   2025-06-13  1796  	cur++;
5a34c9a8536511b Breno Leitao   2025-06-13  1797  
5a34c9a8536511b Breno Leitao   2025-06-13  1798  	if (*cur != ',') {
5a34c9a8536511b Breno Leitao   2025-06-13  1799  		/* parse out dev_name or dev_mac */
d79206451f4f99a Breno Leitao   2025-06-13  1800  		delim = strchr(cur, ',');
d79206451f4f99a Breno Leitao   2025-06-13  1801  		if (!delim)
5a34c9a8536511b Breno Leitao   2025-06-13  1802  			goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1803  		*delim = 0;
5a34c9a8536511b Breno Leitao   2025-06-13  1804  
5a34c9a8536511b Breno Leitao   2025-06-13  1805  		np->dev_name[0] = '\0';
5a34c9a8536511b Breno Leitao   2025-06-13  1806  		eth_broadcast_addr(np->dev_mac);
5a34c9a8536511b Breno Leitao   2025-06-13  1807  		if (!strchr(cur, ':'))
5a34c9a8536511b Breno Leitao   2025-06-13  1808  			strscpy(np->dev_name, cur, sizeof(np->dev_name));
5a34c9a8536511b Breno Leitao   2025-06-13  1809  		else if (!mac_pton(cur, np->dev_mac))
5a34c9a8536511b Breno Leitao   2025-06-13  1810  			goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1811  
5a34c9a8536511b Breno Leitao   2025-06-13  1812  		cur = delim;
5a34c9a8536511b Breno Leitao   2025-06-13  1813  	}
5a34c9a8536511b Breno Leitao   2025-06-13  1814  	cur++;
5a34c9a8536511b Breno Leitao   2025-06-13  1815  
5a34c9a8536511b Breno Leitao   2025-06-13  1816  	if (*cur != '@') {
5a34c9a8536511b Breno Leitao   2025-06-13  1817  		/* dst port */
d79206451f4f99a Breno Leitao   2025-06-13  1818  		delim = strchr(cur, '@');
d79206451f4f99a Breno Leitao   2025-06-13  1819  		if (!delim)
5a34c9a8536511b Breno Leitao   2025-06-13  1820  			goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1821  		*delim = 0;
5a34c9a8536511b Breno Leitao   2025-06-13  1822  		if (*cur == ' ' || *cur == '\t')
5a34c9a8536511b Breno Leitao   2025-06-13  1823  			np_info(np, "warning: whitespace is not allowed\n");
5a34c9a8536511b Breno Leitao   2025-06-13  1824  		if (kstrtou16(cur, 10, &np->remote_port))
5a34c9a8536511b Breno Leitao   2025-06-13  1825  			goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1826  		cur = delim;
5a34c9a8536511b Breno Leitao   2025-06-13  1827  	}
5a34c9a8536511b Breno Leitao   2025-06-13  1828  	cur++;
5a34c9a8536511b Breno Leitao   2025-06-13  1829  
5a34c9a8536511b Breno Leitao   2025-06-13  1830  	/* dst ip */
d79206451f4f99a Breno Leitao   2025-06-13  1831  	delim = strchr(cur, '/');
d79206451f4f99a Breno Leitao   2025-06-13  1832  	if (!delim)
5a34c9a8536511b Breno Leitao   2025-06-13  1833  		goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1834  	*delim = 0;
5a34c9a8536511b Breno Leitao   2025-06-13  1835  	ipv6 = netpoll_parse_ip_addr(cur, &np->remote_ip);
5a34c9a8536511b Breno Leitao   2025-06-13  1836  	if (ipv6 < 0)
5a34c9a8536511b Breno Leitao   2025-06-13  1837  		goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1838  	else if (ipversion_set && np->ipv6 != (bool)ipv6)
5a34c9a8536511b Breno Leitao   2025-06-13  1839  		goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1840  	else
5a34c9a8536511b Breno Leitao   2025-06-13  1841  		np->ipv6 = (bool)ipv6;
5a34c9a8536511b Breno Leitao   2025-06-13  1842  	cur = delim + 1;
5a34c9a8536511b Breno Leitao   2025-06-13  1843  
5a34c9a8536511b Breno Leitao   2025-06-13  1844  	if (*cur != 0) {
5a34c9a8536511b Breno Leitao   2025-06-13  1845  		/* MAC address */
5a34c9a8536511b Breno Leitao   2025-06-13  1846  		if (!mac_pton(cur, np->remote_mac))
5a34c9a8536511b Breno Leitao   2025-06-13  1847  			goto parse_failed;
5a34c9a8536511b Breno Leitao   2025-06-13  1848  	}
5a34c9a8536511b Breno Leitao   2025-06-13  1849  
abebef96aab12da Breno Leitao   2025-06-13  1850  	netconsole_print_banner(np);
5a34c9a8536511b Breno Leitao   2025-06-13  1851  
5a34c9a8536511b Breno Leitao   2025-06-13  1852  	return 0;
5a34c9a8536511b Breno Leitao   2025-06-13  1853  
5a34c9a8536511b Breno Leitao   2025-06-13  1854   parse_failed:
5a34c9a8536511b Breno Leitao   2025-06-13  1855  	np_info(np, "couldn't parse config at '%s'!\n", cur);
5a34c9a8536511b Breno Leitao   2025-06-13  1856  	return -1;
5a34c9a8536511b Breno Leitao   2025-06-13  1857  }
5a34c9a8536511b Breno Leitao   2025-06-13  1858  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

