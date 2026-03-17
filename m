Return-Path: <netdev+bounces-268607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHYHN59XuWnYAgIAu9opvQ
	(envelope-from <netdev+bounces-268607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:31:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 822632AAE5A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4CAC301CCB2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B325A62E;
	Tue, 17 Mar 2026 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5/D/0lT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52633264A9D;
	Tue, 17 Mar 2026 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754268; cv=none; b=KOR1ubEnWamUna0f75DjmXa3b73z9SrxJgIFRbkgYFvkh/iqftjtham4vBxDaJzc2glZ0JRocu0xi8cC5IErJVFbm+MbF179flJKLAp+RBgbSjqWU4SYb5MRBgYNq4Q7yDmaszL3Ei+Y+DpmOQgjO/qIQxy0n+SbqQ2MOBTljsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754268; c=relaxed/simple;
	bh=lIWsD2ci2/DmvQPAIxFhRhk/jEMsvah2g+VU1OXqBHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAm3zKpnH4NXCeDKNHO+I5vzgpps8qKOFqQI5ba05kl29ND7vKpb2/2OliXWXVbDFiqlyhFR9yD/pchfRUyzVpX8/+dtC5biXh4A7xNR6dUaNsljzD2IRzzjPpW4Yv0egxTR42HefeGRzS1E50oDdb+XMpc8xnHsJHTPwEn0bY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5/D/0lT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773754266; x=1805290266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lIWsD2ci2/DmvQPAIxFhRhk/jEMsvah2g+VU1OXqBHM=;
  b=Q5/D/0lTKYGdD71rnTyTW4M/Vl/G3CpgrexpdMHX2PKMoE43BxbhSvZY
   BpTQ2VWMQgtoM3fZW71BD0M/eIEWUDCkukghVSAPmFqA8ZFT/f5I9mnbU
   wAxsHo2YN6jXt7yVNOmBqg13uxgngPKVM4RZrmKnLqUupPb0crCDYNY8O
   kNuJl1W3HvF0mZrCdjuFd2HJzciEzuBZhD6yVeoStlKg03QZHnZKmHt3F
   7D6XS1/nMroNA/Q2KqU+XLPXtrEQWLHl9Px2A6bik3PwM4nOeHPoJcWwV
   u5I3mHqvMPBhNMpBhEdBe7qQdBI96vx6TsweoRzsgeOaP82eWusL3iMnH
   Q==;
X-CSE-ConnectionGUID: Pt13bwh4TK2RyjV9UQMJlg==
X-CSE-MsgGUID: k14SCLzbT22XwmLWXut9SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74864521"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74864521"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 06:31:05 -0700
X-CSE-ConnectionGUID: tOdRrbAJSgilkEWdhpJ4kw==
X-CSE-MsgGUID: iW5TAUcCSFynXaZPGd9kSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222225635"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Mar 2026 06:31:02 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2UVf-000000000Sr-19nC;
	Tue, 17 Mar 2026 13:30:59 +0000
Date: Tue, 17 Mar 2026 21:30:00 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Adrian Moreno <amorenoz@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: openvswitch: decouple flow_table from
 ovs_mutex
Message-ID: <202603172153.FuWl19zD-lkp@intel.com>
References: <20260313173114.1220551-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313173114.1220551-1-amorenoz@redhat.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268607-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 822632AAE5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Adrian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Moreno/net-openvswitch-decouple-flow_table-from-ovs_mutex/20260314-152511
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260313173114.1220551-1-amorenoz%40redhat.com
patch subject: [PATCH net-next v1] net: openvswitch: decouple flow_table from ovs_mutex
config: arm-randconfig-r132-20260317 (https://download.01.org/0day-ci/archive/20260317/202603172153.FuWl19zD-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project f46a5153850c1303d687233d4adf699b01041da8)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260317/202603172153.FuWl19zD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603172153.FuWl19zD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/openvswitch/datapath.c:2016:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct flow_table *table @@     got struct flow_table [noderef] __rcu *table @@
   net/openvswitch/datapath.c:2016:28: sparse:     expected struct flow_table *table
   net/openvswitch/datapath.c:2016:28: sparse:     got struct flow_table [noderef] __rcu *table

vim +2016 net/openvswitch/datapath.c

  1913	
  1914	static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
  1915	{
  1916		struct nlattr **a = info->attrs;
  1917		struct flow_table *table;
  1918		struct vport_parms parms;
  1919		struct sk_buff *reply;
  1920		struct datapath *dp;
  1921		struct vport *vport;
  1922		struct ovs_net *ovs_net;
  1923		int err;
  1924	
  1925		err = -EINVAL;
  1926		if (!a[OVS_DP_ATTR_NAME] || !a[OVS_DP_ATTR_UPCALL_PID])
  1927			goto err;
  1928	
  1929		reply = ovs_dp_cmd_alloc_info();
  1930		if (!reply)
  1931			return -ENOMEM;
  1932	
  1933		err = -ENOMEM;
  1934		dp = kzalloc_obj(*dp);
  1935		if (dp == NULL)
  1936			goto err_destroy_reply;
  1937	
  1938		ovs_dp_set_net(dp, sock_net(skb->sk));
  1939	
  1940		/* Allocate table. */
  1941		table = ovs_flow_tbl_alloc();
  1942		if (IS_ERR(table)) {
  1943			err = PTR_ERR(table);
  1944			goto err_destroy_dp;
  1945		}
  1946		rcu_assign_pointer(dp->table, table);
  1947	
  1948		err = ovs_dp_stats_init(dp);
  1949		if (err)
  1950			goto err_destroy_table;
  1951	
  1952		err = ovs_dp_vport_init(dp);
  1953		if (err)
  1954			goto err_destroy_stats;
  1955	
  1956		err = ovs_meters_init(dp);
  1957		if (err)
  1958			goto err_destroy_ports;
  1959	
  1960		/* Set up our datapath device. */
  1961		parms.name = nla_data(a[OVS_DP_ATTR_NAME]);
  1962		parms.type = OVS_VPORT_TYPE_INTERNAL;
  1963		parms.options = NULL;
  1964		parms.dp = dp;
  1965		parms.port_no = OVSP_LOCAL;
  1966		parms.upcall_portids = a[OVS_DP_ATTR_UPCALL_PID];
  1967		parms.desired_ifindex = nla_get_s32_default(a[OVS_DP_ATTR_IFINDEX], 0);
  1968	
  1969		/* So far only local changes have been made, now need the lock. */
  1970		ovs_lock();
  1971	
  1972		err = ovs_dp_change(dp, a);
  1973		if (err)
  1974			goto err_unlock_and_destroy_meters;
  1975	
  1976		vport = new_vport(&parms);
  1977		if (IS_ERR(vport)) {
  1978			err = PTR_ERR(vport);
  1979			if (err == -EBUSY)
  1980				err = -EEXIST;
  1981	
  1982			if (err == -EEXIST) {
  1983				/* An outdated user space instance that does not understand
  1984				 * the concept of user_features has attempted to create a new
  1985				 * datapath and is likely to reuse it. Drop all user features.
  1986				 */
  1987				if (info->genlhdr->version < OVS_DP_VER_FEATURES)
  1988					ovs_dp_reset_user_features(skb, info);
  1989			}
  1990	
  1991			goto err_destroy_portids;
  1992		}
  1993	
  1994		err = ovs_dp_cmd_fill_info(dp, reply, info->snd_portid,
  1995					   info->snd_seq, 0, OVS_DP_CMD_NEW);
  1996		BUG_ON(err < 0);
  1997	
  1998		ovs_net = net_generic(ovs_dp_get_net(dp), ovs_net_id);
  1999		list_add_tail_rcu(&dp->list_node, &ovs_net->dps);
  2000	
  2001		ovs_unlock();
  2002	
  2003		ovs_notify(&dp_datapath_genl_family, reply, info);
  2004		return 0;
  2005	
  2006	err_destroy_portids:
  2007		kfree(rcu_dereference_raw(dp->upcall_portids));
  2008	err_unlock_and_destroy_meters:
  2009		ovs_unlock();
  2010		ovs_meters_exit(dp);
  2011	err_destroy_ports:
  2012		kfree(dp->ports);
  2013	err_destroy_stats:
  2014		free_percpu(dp->stats_percpu);
  2015	err_destroy_table:
> 2016		ovs_flow_tbl_put(dp->table);
  2017	err_destroy_dp:
  2018		kfree(dp);
  2019	err_destroy_reply:
  2020		kfree_skb(reply);
  2021	err:
  2022		return err;
  2023	}
  2024	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

