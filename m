Return-Path: <netdev+bounces-184138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F394CA93709
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00FB188BEA8
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D22749F2;
	Fri, 18 Apr 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="qL35lBxh"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E392741D4;
	Fri, 18 Apr 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979179; cv=none; b=sPlB2kipTIJmfkoT4oEQfRmBk/KZPVb3EFytiI7/+SSgdXiOaSIXS9o6Lh3SYSDz9U64GiaWSxdO6Zp/bYYqrDMi5+S6HKxr6PPxVBlC1DKqsIKATSLvIBkjxfVlT+Pqb4cIhhsqouPl/MLj/2ryc0JpPunMqux/Mx8ozF/KCJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979179; c=relaxed/simple;
	bh=pLMUnkQ7i8zl1lKTBgrZZ9T1S73Ro147jf8kegIJRpk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=B13EwEamsBqq6uOj6k0/eV8gTC1PsK+E4NGKmV3jmOiwyTIeSWQ1C/iYkCm/jZXeGELFFSckW5UCBp2Z0Y6Pn5UawctSWmqtwcn7lwR9y/ZSK+cktcnZG/59500UVSUlS8yHTKxCZu+1BNtbpF6IsFueQ7brGaXcOPOAWTvZfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=qL35lBxh; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zgYuDIxcDeA+599F/9fuaQ38vA4OYPsLsjN7kvIiw/A=; b=qL35lBxh8HZH+xEXQjiD+NBNXE
	wNElmDImRWWhkgSUAkTAKAvD4A2Bg1rFoFY72ssTci5CgP6FLHMs+ECg9A7qt9ivU53nw324XanVl
	qkpsYTci/5Bna7eT0uxaPi5epE6P1BeIjQR71beALBzkYZ2aAYbp1PBiNpCwVmanuGA/7a8sBD982
	7NUOj/9M2EWXaP9/0ICVQZiW64P8hMvBaW8vil5Fh1bh98tAuiJVjnYU0Ry0EacdiyadJFKbKp0Sm
	xrYduuzHfoPDbx8i2FSvqP9QcBSait/nAkIxKOPnaG+iiS5vRVAOAndvnwGe0qhomfYqyGB8xpfxb
	EepeXgKg==;
Received: from [122.175.9.182] (port=48418 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1u5knI-000000004eF-42yZ;
	Fri, 18 Apr 2025 17:56:09 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id E862917823F4;
	Fri, 18 Apr 2025 17:55:57 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id BEABC1783F61;
	Fri, 18 Apr 2025 17:55:57 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hhW7TFWjAhWH; Fri, 18 Apr 2025 17:55:57 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 7D65F17823F4;
	Fri, 18 Apr 2025 17:55:57 +0530 (IST)
Date: Fri, 18 Apr 2025 17:55:57 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: horms <horms@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, nm <nm@ti.com>, 
	ssantosh <ssantosh@kernel.org>, tony <tony@atomide.com>, 
	richardcochran <richardcochran@gmail.com>, 
	glaroque <glaroque@baylibre.com>, schnelle <schnelle@linux.ibm.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	rdunlap <rdunlap@infradead.org>, diogo ivo <diogo.ivo@siemens.com>, 
	basharath <basharath@couthit.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	m-malladi <m-malladi@ti.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	afd <afd@ti.com>, s-anna <s-anna@ti.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <2126437499.1093120.1744979157393.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250415195756.GI395307@horms.kernel.org>
References: <20250414113458.1913823-1-parvathi@couthit.com> <20250414130237.1915448-8-parvathi@couthit.com> <20250415195756.GI395307@horms.kernel.org>
Subject: Re: [PATCH net-next v5 07/11] net: ti: prueth: Adds support for
 network filters for traffic control supported by PRU-ICSS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds support for network filters for traffic control supported by PRU-ICSS
Thread-Index: N2IoJ9p4SeRG9XkM6ibtWxtAWdIZLA==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On Mon, Apr 14, 2025 at 06:32:33PM +0530, Parvathi Pudi wrote:
>> From: Roger Quadros <rogerq@ti.com>
>> 
>> Driver updates to enable/disable network filters and traffic control
>> features supported by the firmware running on PRU-ICSS.
>> 
>> Control of the following features are now supported:
>> 1. Promiscuous mode
>> 2. Network Storm prevention
>> 3. Multicast filtering and
>> 4. VLAN filtering
>> 
>> Firmware running on PRU-ICSS will go through all these filter checks
>> prior to sending the rx packets to the host.
>> 
>> Ethtool or dev ioctl can be used to enable/disable these features from
>> the user space.
>> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_dos.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth_dos.c
> 
> ...
> 
>> +static int icssm_emac_configure_clsflower(struct prueth_emac *emac,
>> +					  struct flow_cls_offload *cls)
>> +{
>> +	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
>> +	struct netlink_ext_ack *extack = cls->common.extack;
>> +	const struct flow_action_entry *act;
>> +	int i;
>> +
>> +	flow_action_for_each(i, act, &rule->action) {
>> +		switch (act->id) {
>> +		case FLOW_ACTION_POLICE:
>> +			return icssm_emac_flower_parse_policer
>> +				(emac, extack, cls,
>> +				 act->police.rate_bytes_ps);
>> +		default:
>> +			NL_SET_ERR_MSG_MOD(extack,
>> +					   "Action not supported");
>> +			return -EOPNOTSUPP;
>> +		}
>> +	}
>> +	return -EOPNOTSUPP;
> 
> nit: This line cannot be reached.
>     I think you can just remove it.
> 
>     Flagged by Smatch.
> 

We will cleanup this in the next version.

Thanks and Regards,
Parvathi.


