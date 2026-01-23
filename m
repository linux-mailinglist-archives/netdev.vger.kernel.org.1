Return-Path: <netdev+bounces-252869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFUoFgWWc2lgxQAAu9opvQ
	(envelope-from <netdev+bounces-252869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:38:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB94077DAF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42687301C88A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138042E6CD0;
	Fri, 23 Jan 2026 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lZAfsdEp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422AC2848A7;
	Fri, 23 Jan 2026 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182723; cv=none; b=rF7570i0YkhKi75awhTVyAc9NGxhqa2Vhehe+/QMDgS9X12da5WPaI/5JPg8mru2bUON0rI4GZ5MMMxirmUj7C0jrjd3Fwuhmz0bWHYL4stNOLijqs0qA02YUfKztB25EfUsLhZOzkK1+2adEr4lGX4PQCaotwPALWAclq3L9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182723; c=relaxed/simple;
	bh=ligd+DkqjAfDYe2oulm4WqGstAU+y2nraN7ZOoZyYGg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlFG3nEecqOi+ZhKGaLDkO9z7In7OGYvqLpjHUaFKckW703OC1nLHd2Hb3usVlWGdfZYDp30536ghy6zNx7bDNNnA/ksDLaSk4qLBqqfyyGZEk7I8IWoW9DpDFYOwmBm8QsKYaxPjr4jf4u8Q1FBdHRziPeWJDvbuFJNBvc12i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lZAfsdEp; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NCoCEc1043944;
	Fri, 23 Jan 2026 07:38:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=xluiIiDSfAbm0Ri56qq5nrt3R
	fTJ9dmzbXiFfn4lHJU=; b=lZAfsdEpn52fs6kL7+DoLaXW40RKr25jcfXyv4IHO
	VxN6cFLOM8h/fi+i4r6BRD4Un3EHEJCXTAUEkW4+1aJ3mYPLC0OGhCkFKVrYmMm0
	I/JeW9XdDjO4vj+AKvxr2qKCs9Cz80cnQVgh7SR5DEs+4DKvYjM9zTvQJHZPLp8Y
	jyxIb0niyP0yyF3HibKoC9DZO6u36tCm0R55qBI+UFxOdc5QqGrOo9xChRAKKyl4
	O9SuSrkovlJJQ64xo85V/pH83JNiTzrqb0wWWNkG+ZYt3ZLufpcKGpWWAOWX4W+P
	LnHO7VkJ9iWkTFPfSSOG/fzOmQTeFpPVIgYOk5KOhnkWg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bv6550n0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 07:38:25 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 Jan 2026 07:38:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 23 Jan 2026 07:38:25 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 940F15C68E1;
	Fri, 23 Jan 2026 07:38:21 -0800 (PST)
Date: Fri, 23 Jan 2026 21:08:20 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: kernel test robot <lkp@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Saeed
 Mahameed" <saeedm@nvidia.com>
Subject: Re: [PATCH net-next] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <aXOV7MNtiYgjO5SJ@rkannoth-OptiPlex-7090>
References: <20260123065257.2993735-1-rkannoth@marvell.com>
 <202601232029.nwwE5gfM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202601232029.nwwE5gfM-lkp@intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDExOSBTYWx0ZWRfX13qDq8jRmTm9
 GbdSl8M0NUXzwFMU3O+AqTMw4PpEwsem8S6cYMVGVil9aEcRfhcuwonVxMduNqWKxblvq35KuT+
 4nh6Nc4cL3VhMIcl6mJcSso70/28rbkAGpeZ6EmKboCPGX2xGar21yegG94Dg+3vsXjJywKXJDg
 J6saLN2Y7k9mpZz+luZP5bAbdPGPmvMXhVlEIUxuzHDtlVqYBs1RkxRNXWuwc5Zo0LQN33NTDoh
 O7lLassaZvS/tZJ8w0/UMMynWMB408p9L4snf6azd44UlBewywoNo4vn+6IrSCQo1LGRKiNv+2N
 ZW05Olf5vZXHfgdh1Ifsgwp0KydDA2jmSIH1AXpFHcjAEupppzo4jFJs8m8/Ozxsd3CenvsRvYy
 EfPQndxAHvHv6JGo6chl1GZprdAViOZOufLuN6qgAwOq1/TpsJ2Yf1Ty2I1MBxi5ySsZFrOv3ss
 82p5lQK6KYCUiQjSI4Q==
X-Authority-Analysis: v=2.4 cv=EJILElZC c=1 sm=1 tr=0 ts=697395f1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=QyXUC8HyAAAA:8 a=YN0CIDPOErFAZuSUtY0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: mpE77NKjGOl98Ia6Qk08_MN6Qu9tsqKY
X-Proofpoint-ORIG-GUID: mpE77NKjGOl98Ia6Qk08_MN6Qu9tsqKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252869-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,marvell.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: AB94077DAF
X-Rspamd-Action: no action

On 2026-01-23 at 18:18:15, kernel test robot (lkp@intel.com) wrote:
> Hi Ratheesh,
>
> kernel test robot noticed the following build warnings:
> All warnings (new ones prefixed by >>):
>
> >> net/devlink/param.c:305:12: warning: stack frame size (1464) exceeds limit (1280) in 'devlink_nl_param_fill' [-Wframe-larger-than]
>      305 | static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
>          |            ^
>    1 warning generated.

Jakub,
shall i modify to heap allocation and push v2 ?

-Ratheesh

>
>
> vim +/devlink_nl_param_fill +305 net/devlink/param.c
>
> 830c41e1e987d9 Jiri Pirko   2023-08-28  304
> 830c41e1e987d9 Jiri Pirko   2023-08-28 @305  static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
> 830c41e1e987d9 Jiri Pirko   2023-08-28  306  				 unsigned int port_index,
> 830c41e1e987d9 Jiri Pirko   2023-08-28  307  				 struct devlink_param_item *param_item,
> 830c41e1e987d9 Jiri Pirko   2023-08-28  308  				 enum devlink_command cmd,
> 011d133bb988f8 Daniel Zahka 2025-11-18  309  				 u32 portid, u32 seq, int flags,
> 011d133bb988f8 Daniel Zahka 2025-11-18  310  				 struct netlink_ext_ack *extack)
> 830c41e1e987d9 Jiri Pirko   2023-08-28  311  {
> 2a367002ed321e Daniel Zahka 2025-11-18  312  	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
> 830c41e1e987d9 Jiri Pirko   2023-08-28  313  	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
> 2a367002ed321e Daniel Zahka 2025-11-18  314  	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
> 830c41e1e987d9 Jiri Pirko   2023-08-28  315  	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
> 830c41e1e987d9 Jiri Pirko   2023-08-28  316  	const struct devlink_param *param = param_item->param;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  317  	struct devlink_param_gset_ctx ctx;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  318  	struct nlattr *param_values_list;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  319  	struct nlattr *param_attr;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  320  	void *hdr;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  321  	int err;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  322  	int i;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  323
> 830c41e1e987d9 Jiri Pirko   2023-08-28  324  	/* Get value from driver part to driverinit configuration mode */
> 830c41e1e987d9 Jiri Pirko   2023-08-28  325  	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
> 830c41e1e987d9 Jiri Pirko   2023-08-28  326  		if (!devlink_param_cmode_is_supported(param, i))
> 830c41e1e987d9 Jiri Pirko   2023-08-28  327  			continue;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  328  		if (i == DEVLINK_PARAM_CMODE_DRIVERINIT) {
> 830c41e1e987d9 Jiri Pirko   2023-08-28  329  			if (param_item->driverinit_value_new_valid)
> 830c41e1e987d9 Jiri Pirko   2023-08-28  330  				param_value[i] = param_item->driverinit_value_new;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  331  			else if (param_item->driverinit_value_valid)
> 830c41e1e987d9 Jiri Pirko   2023-08-28  332  				param_value[i] = param_item->driverinit_value;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  333  			else
> 830c41e1e987d9 Jiri Pirko   2023-08-28  334  				return -EOPNOTSUPP;
> 2a367002ed321e Daniel Zahka 2025-11-18  335
> 2a367002ed321e Daniel Zahka 2025-11-18  336  			if (param_item->driverinit_value_valid) {
> 2a367002ed321e Daniel Zahka 2025-11-18  337  				default_value[i] = param_item->driverinit_default;
> 2a367002ed321e Daniel Zahka 2025-11-18  338  				default_value_set[i] = true;
> 2a367002ed321e Daniel Zahka 2025-11-18  339  			}
> 830c41e1e987d9 Jiri Pirko   2023-08-28  340  		} else {
> 830c41e1e987d9 Jiri Pirko   2023-08-28  341  			ctx.cmode = i;
> 011d133bb988f8 Daniel Zahka 2025-11-18  342  			err = devlink_param_get(devlink, param, &ctx, extack);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  343  			if (err)
> 830c41e1e987d9 Jiri Pirko   2023-08-28  344  				return err;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  345  			param_value[i] = ctx.val;
> 2a367002ed321e Daniel Zahka 2025-11-18  346
> 2a367002ed321e Daniel Zahka 2025-11-18  347  			err = devlink_param_get_default(devlink, param, &ctx,
> 2a367002ed321e Daniel Zahka 2025-11-18  348  							extack);
> 2a367002ed321e Daniel Zahka 2025-11-18  349  			if (!err) {
> 2a367002ed321e Daniel Zahka 2025-11-18  350  				default_value[i] = ctx.val;
> 2a367002ed321e Daniel Zahka 2025-11-18  351  				default_value_set[i] = true;
> 2a367002ed321e Daniel Zahka 2025-11-18  352  			} else if (err != -EOPNOTSUPP) {
> 2a367002ed321e Daniel Zahka 2025-11-18  353  				return err;
> 2a367002ed321e Daniel Zahka 2025-11-18  354  			}
> 830c41e1e987d9 Jiri Pirko   2023-08-28  355  		}
> 830c41e1e987d9 Jiri Pirko   2023-08-28  356  		param_value_set[i] = true;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  357  	}
> 830c41e1e987d9 Jiri Pirko   2023-08-28  358
> 830c41e1e987d9 Jiri Pirko   2023-08-28  359  	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  360  	if (!hdr)
> 830c41e1e987d9 Jiri Pirko   2023-08-28  361  		return -EMSGSIZE;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  362
> 830c41e1e987d9 Jiri Pirko   2023-08-28  363  	if (devlink_nl_put_handle(msg, devlink))
> 830c41e1e987d9 Jiri Pirko   2023-08-28  364  		goto genlmsg_cancel;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  365
> 830c41e1e987d9 Jiri Pirko   2023-08-28  366  	if (cmd == DEVLINK_CMD_PORT_PARAM_GET ||
> 830c41e1e987d9 Jiri Pirko   2023-08-28  367  	    cmd == DEVLINK_CMD_PORT_PARAM_NEW ||
> 830c41e1e987d9 Jiri Pirko   2023-08-28  368  	    cmd == DEVLINK_CMD_PORT_PARAM_DEL)
> 830c41e1e987d9 Jiri Pirko   2023-08-28  369  		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, port_index))
> 830c41e1e987d9 Jiri Pirko   2023-08-28  370  			goto genlmsg_cancel;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  371
> 830c41e1e987d9 Jiri Pirko   2023-08-28  372  	param_attr = nla_nest_start_noflag(msg, DEVLINK_ATTR_PARAM);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  373  	if (!param_attr)
> 830c41e1e987d9 Jiri Pirko   2023-08-28  374  		goto genlmsg_cancel;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  375  	if (nla_put_string(msg, DEVLINK_ATTR_PARAM_NAME, param->name))
> 830c41e1e987d9 Jiri Pirko   2023-08-28  376  		goto param_nest_cancel;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  377  	if (param->generic && nla_put_flag(msg, DEVLINK_ATTR_PARAM_GENERIC))
> 830c41e1e987d9 Jiri Pirko   2023-08-28  378  		goto param_nest_cancel;
> f9e78932eac650 Jiri Pirko   2025-05-05  379  	if (nla_put_u8(msg, DEVLINK_ATTR_PARAM_TYPE, param->type))
> 830c41e1e987d9 Jiri Pirko   2023-08-28  380  		goto param_nest_cancel;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  381
> 830c41e1e987d9 Jiri Pirko   2023-08-28  382  	param_values_list = nla_nest_start_noflag(msg,
> 830c41e1e987d9 Jiri Pirko   2023-08-28  383  						  DEVLINK_ATTR_PARAM_VALUES_LIST);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  384  	if (!param_values_list)
> 830c41e1e987d9 Jiri Pirko   2023-08-28  385  		goto param_nest_cancel;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  386
> 830c41e1e987d9 Jiri Pirko   2023-08-28  387  	for (i = 0; i <= DEVLINK_PARAM_CMODE_MAX; i++) {
> 830c41e1e987d9 Jiri Pirko   2023-08-28  388  		if (!param_value_set[i])
> 830c41e1e987d9 Jiri Pirko   2023-08-28  389  			continue;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  390  		err = devlink_nl_param_value_fill_one(msg, param->type,
> 2a367002ed321e Daniel Zahka 2025-11-18  391  						      i, param_value[i],
> 2a367002ed321e Daniel Zahka 2025-11-18  392  						      default_value[i],
> 2a367002ed321e Daniel Zahka 2025-11-18  393  						      default_value_set[i]);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  394  		if (err)
> 830c41e1e987d9 Jiri Pirko   2023-08-28  395  			goto values_list_nest_cancel;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  396  	}
> 830c41e1e987d9 Jiri Pirko   2023-08-28  397
> 830c41e1e987d9 Jiri Pirko   2023-08-28  398  	nla_nest_end(msg, param_values_list);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  399  	nla_nest_end(msg, param_attr);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  400  	genlmsg_end(msg, hdr);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  401  	return 0;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  402
> 830c41e1e987d9 Jiri Pirko   2023-08-28  403  values_list_nest_cancel:
> 830c41e1e987d9 Jiri Pirko   2023-08-28  404  	nla_nest_end(msg, param_values_list);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  405  param_nest_cancel:
> 830c41e1e987d9 Jiri Pirko   2023-08-28  406  	nla_nest_cancel(msg, param_attr);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  407  genlmsg_cancel:
> 830c41e1e987d9 Jiri Pirko   2023-08-28  408  	genlmsg_cancel(msg, hdr);
> 830c41e1e987d9 Jiri Pirko   2023-08-28  409  	return -EMSGSIZE;
> 830c41e1e987d9 Jiri Pirko   2023-08-28  410  }
> 830c41e1e987d9 Jiri Pirko   2023-08-28  411
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

