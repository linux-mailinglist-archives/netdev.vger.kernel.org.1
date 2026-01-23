Return-Path: <netdev+bounces-252843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB74MDt2c2kEwAAAu9opvQ
	(envelope-from <netdev+bounces-252843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:23:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39308762E8
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C938301A535
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E42E6CAB;
	Fri, 23 Jan 2026 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpM1733F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CD29AB02;
	Fri, 23 Jan 2026 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174583; cv=none; b=boilbJ4bmrfPD0SX4twcEN7e6K+xkjxdvyueT88FtPHTykRNSPvls62myUlNG/QECKEayRC3ZzS3a6XvHGLpsAdOJEmvLfbSDZcDT91tFrjZELboExWDgodz6eeF7V6ty4h+sglyq40E2B3ZCv+8vERinEbJN80sE+DvUSUlcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174583; c=relaxed/simple;
	bh=R30KX4+8mtSuQxUCOYXGRi/E2OHWVlkbi4zsYYYbcLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx1BS9ZCZpPjtZOy88zc894qVew3qmsQobf3V3hQ0is4LGHhTdM5xU+JfF0gwmxkgai2uXaERebK+qaFOxDYp8H3iOJqMpLauL+EmVuTP/2p1zmqqc7ue/z9SEKr5CCzid5WqXUuLUIUXZw6ZDPxd4shjOYktBKflP3oNtwwh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpM1733F; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769174580; x=1800710580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R30KX4+8mtSuQxUCOYXGRi/E2OHWVlkbi4zsYYYbcLY=;
  b=LpM1733FsRYg0xXVSb2Md7sEP0yWTVAHeiZ+3cv6Ww+8rlQX0918vG2C
   U1lhR+ya9MEuLzulfHA81b+W4ipGYb3nVbQvuzT+1FavZtekqeS12rIYO
   hUyR/0bYxoZeQ8mjDmJWHuqlkIfZc1+jjQG8FbQIG51F3INpWpsqgd2b5
   KblLLGFUAzmb3GHOFHhERCZs497XCLr6WVbZX1v6e28HxKstH5CrVrHho
   oqN2UoGRo0y158QoC/qIb4bNIru0uSyLbEaj76JeggQCpaHrjV8Rdgo7C
   kXBl86Q1F2M5Lg1QuS14D3ZHVl63McgKwAap8Kl2dVOmKrByYq0ZNgg36
   w==;
X-CSE-ConnectionGUID: jq5Pyxj/QLuxYb1Tah5+qA==
X-CSE-MsgGUID: qRdR1fYBRpK5GYZwGdInQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70146799"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70146799"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 05:22:59 -0800
X-CSE-ConnectionGUID: yBgXnFLASAKzAaMJ4vgRhQ==
X-CSE-MsgGUID: v4rCm2mbRpKWnuOe/rZsNg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jan 2026 05:22:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjH7m-00000000Tyg-0ip6;
	Fri, 23 Jan 2026 13:22:54 +0000
Date: Fri, 23 Jan 2026 21:22:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sgoutham@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [PATCH net-next] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <202601232124.fqzsosEi-lkp@intel.com>
References: <20260123065257.2993735-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123065257.2993735-1-rkannoth@marvell.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252843-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 39308762E8
X-Rspamd-Action: no action

Hi Ratheesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ratheesh-Kannoth/devlink-Implement-devlink-param-multi-attribute-nested-data-values/20260123-145646
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260123065257.2993735-1-rkannoth%40marvell.com
patch subject: [PATCH net-next] devlink: Implement devlink param multi attribute nested data values
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20260123/202601232124.fqzsosEi-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601232124.fqzsosEi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601232124.fqzsosEi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/devlink/param.c: In function 'devlink_nl_param_fill.constprop':
>> net/devlink/param.c:410:1: warning: the frame size of 1300 bytes is larger than 1280 bytes [-Wframe-larger-than=]
     410 | }
         | ^


vim +410 net/devlink/param.c

830c41e1e987d9 Jiri Pirko   2023-08-28  304  
830c41e1e987d9 Jiri Pirko   2023-08-28  305  static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
830c41e1e987d9 Jiri Pirko   2023-08-28  306  				 unsigned int port_index,
830c41e1e987d9 Jiri Pirko   2023-08-28  307  				 struct devlink_param_item *param_item,
830c41e1e987d9 Jiri Pirko   2023-08-28  308  				 enum devlink_command cmd,
011d133bb988f8 Daniel Zahka 2025-11-18  309  				 u32 portid, u32 seq, int flags,
011d133bb988f8 Daniel Zahka 2025-11-18  310  				 struct netlink_ext_ack *extack)
830c41e1e987d9 Jiri Pirko   2023-08-28  311  {
2a367002ed321e Daniel Zahka 2025-11-18  312  	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
830c41e1e987d9 Jiri Pirko   2023-08-28  313  	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
2a367002ed321e Daniel Zahka 2025-11-18  314  	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
830c41e1e987d9 Jiri Pirko   2023-08-28  315  	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
830c41e1e987d9 Jiri Pirko   2023-08-28  316  	const struct devlink_param *param = param_item->param;
830c41e1e987d9 Jiri Pirko   2023-08-28  317  	struct devlink_param_gset_ctx ctx;
830c41e1e987d9 Jiri Pirko   2023-08-28  318  	struct nlattr *param_values_list;
830c41e1e987d9 Jiri Pirko   2023-08-28  319  	struct nlattr *param_attr;
830c41e1e987d9 Jiri Pirko   2023-08-28  320  	void *hdr;
830c41e1e987d9 Jiri Pirko   2023-08-28  321  	int err;
830c41e1e987d9 Jiri Pirko   2023-08-28  322  	int i;
830c41e1e987d9 Jiri Pirko   2023-08-28  323  
830c41e1e987d9 Jiri Pirko   2023-08-28  324  	/* Get value from driver part to driverinit configuration mode */
830c41e1e987d9 Jiri Pirko   2023-08-28  325  	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
830c41e1e987d9 Jiri Pirko   2023-08-28  326  		if (!devlink_param_cmode_is_supported(param, i))
830c41e1e987d9 Jiri Pirko   2023-08-28  327  			continue;
830c41e1e987d9 Jiri Pirko   2023-08-28  328  		if (i == DEVLINK_PARAM_CMODE_DRIVERINIT) {
830c41e1e987d9 Jiri Pirko   2023-08-28  329  			if (param_item->driverinit_value_new_valid)
830c41e1e987d9 Jiri Pirko   2023-08-28  330  				param_value[i] = param_item->driverinit_value_new;
830c41e1e987d9 Jiri Pirko   2023-08-28  331  			else if (param_item->driverinit_value_valid)
830c41e1e987d9 Jiri Pirko   2023-08-28  332  				param_value[i] = param_item->driverinit_value;
830c41e1e987d9 Jiri Pirko   2023-08-28  333  			else
830c41e1e987d9 Jiri Pirko   2023-08-28  334  				return -EOPNOTSUPP;
2a367002ed321e Daniel Zahka 2025-11-18  335  
2a367002ed321e Daniel Zahka 2025-11-18  336  			if (param_item->driverinit_value_valid) {
2a367002ed321e Daniel Zahka 2025-11-18  337  				default_value[i] = param_item->driverinit_default;
2a367002ed321e Daniel Zahka 2025-11-18  338  				default_value_set[i] = true;
2a367002ed321e Daniel Zahka 2025-11-18  339  			}
830c41e1e987d9 Jiri Pirko   2023-08-28  340  		} else {
830c41e1e987d9 Jiri Pirko   2023-08-28  341  			ctx.cmode = i;
011d133bb988f8 Daniel Zahka 2025-11-18  342  			err = devlink_param_get(devlink, param, &ctx, extack);
830c41e1e987d9 Jiri Pirko   2023-08-28  343  			if (err)
830c41e1e987d9 Jiri Pirko   2023-08-28  344  				return err;
830c41e1e987d9 Jiri Pirko   2023-08-28  345  			param_value[i] = ctx.val;
2a367002ed321e Daniel Zahka 2025-11-18  346  
2a367002ed321e Daniel Zahka 2025-11-18  347  			err = devlink_param_get_default(devlink, param, &ctx,
2a367002ed321e Daniel Zahka 2025-11-18  348  							extack);
2a367002ed321e Daniel Zahka 2025-11-18  349  			if (!err) {
2a367002ed321e Daniel Zahka 2025-11-18  350  				default_value[i] = ctx.val;
2a367002ed321e Daniel Zahka 2025-11-18  351  				default_value_set[i] = true;
2a367002ed321e Daniel Zahka 2025-11-18  352  			} else if (err != -EOPNOTSUPP) {
2a367002ed321e Daniel Zahka 2025-11-18  353  				return err;
2a367002ed321e Daniel Zahka 2025-11-18  354  			}
830c41e1e987d9 Jiri Pirko   2023-08-28  355  		}
830c41e1e987d9 Jiri Pirko   2023-08-28  356  		param_value_set[i] = true;
830c41e1e987d9 Jiri Pirko   2023-08-28  357  	}
830c41e1e987d9 Jiri Pirko   2023-08-28  358  
830c41e1e987d9 Jiri Pirko   2023-08-28  359  	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
830c41e1e987d9 Jiri Pirko   2023-08-28  360  	if (!hdr)
830c41e1e987d9 Jiri Pirko   2023-08-28  361  		return -EMSGSIZE;
830c41e1e987d9 Jiri Pirko   2023-08-28  362  
830c41e1e987d9 Jiri Pirko   2023-08-28  363  	if (devlink_nl_put_handle(msg, devlink))
830c41e1e987d9 Jiri Pirko   2023-08-28  364  		goto genlmsg_cancel;
830c41e1e987d9 Jiri Pirko   2023-08-28  365  
830c41e1e987d9 Jiri Pirko   2023-08-28  366  	if (cmd == DEVLINK_CMD_PORT_PARAM_GET ||
830c41e1e987d9 Jiri Pirko   2023-08-28  367  	    cmd == DEVLINK_CMD_PORT_PARAM_NEW ||
830c41e1e987d9 Jiri Pirko   2023-08-28  368  	    cmd == DEVLINK_CMD_PORT_PARAM_DEL)
830c41e1e987d9 Jiri Pirko   2023-08-28  369  		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, port_index))
830c41e1e987d9 Jiri Pirko   2023-08-28  370  			goto genlmsg_cancel;
830c41e1e987d9 Jiri Pirko   2023-08-28  371  
830c41e1e987d9 Jiri Pirko   2023-08-28  372  	param_attr = nla_nest_start_noflag(msg, DEVLINK_ATTR_PARAM);
830c41e1e987d9 Jiri Pirko   2023-08-28  373  	if (!param_attr)
830c41e1e987d9 Jiri Pirko   2023-08-28  374  		goto genlmsg_cancel;
830c41e1e987d9 Jiri Pirko   2023-08-28  375  	if (nla_put_string(msg, DEVLINK_ATTR_PARAM_NAME, param->name))
830c41e1e987d9 Jiri Pirko   2023-08-28  376  		goto param_nest_cancel;
830c41e1e987d9 Jiri Pirko   2023-08-28  377  	if (param->generic && nla_put_flag(msg, DEVLINK_ATTR_PARAM_GENERIC))
830c41e1e987d9 Jiri Pirko   2023-08-28  378  		goto param_nest_cancel;
f9e78932eac650 Jiri Pirko   2025-05-05  379  	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_TYPE, param->type))
830c41e1e987d9 Jiri Pirko   2023-08-28  380  		goto param_nest_cancel;
830c41e1e987d9 Jiri Pirko   2023-08-28  381  
830c41e1e987d9 Jiri Pirko   2023-08-28  382  	param_values_list = nla_nest_start_noflag(msg,
830c41e1e987d9 Jiri Pirko   2023-08-28  383  						  DEVLINK_ATTR_PARAM_VALUES_LIST);
830c41e1e987d9 Jiri Pirko   2023-08-28  384  	if (!param_values_list)
830c41e1e987d9 Jiri Pirko   2023-08-28  385  		goto param_nest_cancel;
830c41e1e987d9 Jiri Pirko   2023-08-28  386  
830c41e1e987d9 Jiri Pirko   2023-08-28  387  	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
830c41e1e987d9 Jiri Pirko   2023-08-28  388  		if (!param_value_set[i])
830c41e1e987d9 Jiri Pirko   2023-08-28  389  			continue;
830c41e1e987d9 Jiri Pirko   2023-08-28  390  		err = devlink_nl_param_value_fill_one(msg, param->type,
2a367002ed321e Daniel Zahka 2025-11-18  391  						      i, param_value[i],
2a367002ed321e Daniel Zahka 2025-11-18  392  						      default_value[i],
2a367002ed321e Daniel Zahka 2025-11-18  393  						      default_value_set[i]);
830c41e1e987d9 Jiri Pirko   2023-08-28  394  		if (err)
830c41e1e987d9 Jiri Pirko   2023-08-28  395  			goto values_list_nest_cancel;
830c41e1e987d9 Jiri Pirko   2023-08-28  396  	}
830c41e1e987d9 Jiri Pirko   2023-08-28  397  
830c41e1e987d9 Jiri Pirko   2023-08-28  398  	nla_nest_end(msg, param_values_list);
830c41e1e987d9 Jiri Pirko   2023-08-28  399  	nla_nest_end(msg, param_attr);
830c41e1e987d9 Jiri Pirko   2023-08-28  400  	genlmsg_end(msg, hdr);
830c41e1e987d9 Jiri Pirko   2023-08-28  401  	return 0;
830c41e1e987d9 Jiri Pirko   2023-08-28  402  
830c41e1e987d9 Jiri Pirko   2023-08-28  403  values_list_nest_cancel:
830c41e1e987d9 Jiri Pirko   2023-08-28  404  	nla_nest_end(msg, param_values_list);
830c41e1e987d9 Jiri Pirko   2023-08-28  405  param_nest_cancel:
830c41e1e987d9 Jiri Pirko   2023-08-28  406  	nla_nest_cancel(msg, param_attr);
830c41e1e987d9 Jiri Pirko   2023-08-28  407  genlmsg_cancel:
830c41e1e987d9 Jiri Pirko   2023-08-28  408  	genlmsg_cancel(msg, hdr);
830c41e1e987d9 Jiri Pirko   2023-08-28  409  	return -EMSGSIZE;
830c41e1e987d9 Jiri Pirko   2023-08-28 @410  }
830c41e1e987d9 Jiri Pirko   2023-08-28  411  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

