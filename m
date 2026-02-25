Return-Path: <netdev+bounces-260816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKfwDEu9nmnYXAQAu9opvQ
	(envelope-from <netdev+bounces-260816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:13:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAA194B9A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB9A030210D5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CF12561A7;
	Wed, 25 Feb 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PLaTp9+I"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6343806D8;
	Wed, 25 Feb 2026 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010822; cv=none; b=V7buga4LLIqnHOLZTLFAmAeeL39DbwAjX1yVwCf2JNdphYy2xTmDOaChYFNdk/dvzRZkf1vLuUIod72zw4vcUTCTS+RWP37fZt3vmke1JvwT3W0t8o75971SPXUFStcHr6fctW6V5/cW5evBqfA6qYn/+hJ0xar3puQXjndZpVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010822; c=relaxed/simple;
	bh=fcYQNX+dsQkTsWfuCFVmKfA1rruaZ9TkRJ9npZsfuNk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jcV1vVuh/CiqfCRtcIIXaZHf5RCk2Oyjndu/+Xk/5+ISpR6Jj0r0KjQVdUCeq11UcbyRX8Xt7oDE9K2mrpbAqNT1KCk/lTBvnTIoXF2UTiZJFHO49qk8NPkALlZ+Hnf8VqGTN2Tfw1coPCur7gp2fid4u4bueL8zQsWgRyAsmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PLaTp9+I; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4/dgtOlrG2tnOFcCm68A8jmq/5buZwuVT1Nvka9+ekM=;
	b=PLaTp9+I18iY81SzhfnUgxsAkhi56nf5XkEBxZQ8v02we3EPPDztxYGJVoMR0Tp1Wob2Idg71
	CFKfV5k00acNO1T0MxO4dxJx5y3Ut5SzczK+zjUHwQPLlRlJHiQ6yph3ygEx2VwWwN3DeVnjj4T
	qGpdNR+DuIxGqDjjJhG3aVM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fLTKX5WHFz1cyQF;
	Wed, 25 Feb 2026 17:08:48 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5971F40561;
	Wed, 25 Feb 2026 17:13:35 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Feb 2026 17:13:34 +0800
Message-ID: <5191a479-fd32-4e64-b0b1-af013412b989@huawei.com>
Date: Wed, 25 Feb 2026 17:13:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, "maintainer:OCELOT ETHERNET SWITCH DRIVER"
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: felix: use kmalloc_flex helper
To: Rosen Penev <rosenp@gmail.com>, <netdev@vger.kernel.org>
References: <20260225040323.69497-1-rosenp@gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260225040323.69497-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260816-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 40DAA194B9A
X-Rspamd-Action: no action


on 2026/2/25 12:03, Rosen Penev wrote:
> A little simpler than using a separate size variable.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/dsa/ocelot/felix_vsc9959.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
> index 8387dd208adb..cb132679fd99 100644
> --- a/drivers/net/dsa/ocelot/felix_vsc9959.c
> +++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
> @@ -2254,7 +2254,7 @@ static int vsc9959_psfp_filter_add(struct ocelot *ocelot, int port,
>   	struct felix_stream_gate *sgi;
>   	struct ocelot_psfp_list *psfp;
>   	struct ocelot_policer pol;
> -	int ret, i, size;
> +	int ret, i;
>   	u64 rate, burst;
>   	u32 index;
>   
> @@ -2271,8 +2271,7 @@ static int vsc9959_psfp_filter_add(struct ocelot *ocelot, int port,
>   	flow_action_for_each(i, a, &f->rule->action) {
>   		switch (a->id) {
>   		case FLOW_ACTION_GATE:
> -			size = struct_size(sgi, entries, a->gate.num_entries);
> -			sgi = kzalloc(size, GFP_KERNEL);
> +			sgi = kzalloc_flex(*sgi, entries, a->gate.num_entries, GFP_KERNEL);

Sorry, the subject is kmalloc_flex but code is kzalloc_flex

>   			if (!sgi) {
>   				ret = -ENOMEM;
>   				goto err;

