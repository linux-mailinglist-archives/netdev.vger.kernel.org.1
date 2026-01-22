Return-Path: <netdev+bounces-252306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFE9I+ITcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:11:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460766717
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90731688336
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027D3176EB;
	Thu, 22 Jan 2026 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hnUBiP76"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320D358D13;
	Thu, 22 Jan 2026 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081542; cv=none; b=OaEMnJQghCNMg8QDbZzeSDgBaBtnHQcJEeNBpRma/UNA0mShG0zh+iTqdy11Kw4Ldm9VBi4uPx5NWXJnzAn5xAzc/HyYAUy/cfQXoOXEmlw5dI9kunaf5VV/PV0dryVW23iD8VKYFdC8eus1/6x4jdNxKRF3B/fD3coXgGlA1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081542; c=relaxed/simple;
	bh=Oef5xctHI8v7fFpqPEZMrxAZOxlin0yJSzkc/GnLVPA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+nAawwUDGFWKgXDKJXl0kiswBKr38uKPA5h9yf98bJn3wbybY1tS9K5D57V7YpGlzEpeGyrREOmv0r4eLyal2pHoGG8nm3muszyLOv26mnpiXe+/YP19GnvtRcsYDjWQaTW/wMFazz4jKikUlAb6PYqJEqmJhmanfx5rwFbrWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hnUBiP76; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5591420612;
	Thu, 22 Jan 2026 12:32:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ABFtNYbnaoXt; Thu, 22 Jan 2026 12:32:17 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CEC902088E;
	Thu, 22 Jan 2026 12:32:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CEC902088E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769081537;
	bh=/eq8UMKclos0k96diblmhWZCbedG/oCLn4nWsSqxvYA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=hnUBiP7609lQ5lU5VbPxTw/jRKvNHhfC7oGRM9qRaXsiUCzRaGCTRhTocY5Ob7/sm
	 J8KBdN08PWQm+te8rGMC5N/swmjvh1pRI32OJbqQoKVGsCX/Ftq180DYYUvfuCs5fE
	 7vlueCWAbr4dghISr0Giq+1uMkclaZfj87M5TIeeNmHUCeLDWx1wOMcy9IHzsKnUX6
	 VUdbdYY2XvfZW0EVXsjkOUsPUJppHLYKRPFJabnaLNhYnCc0C/2qYQhN3MOp1tpD0/
	 /GxOA13X9n5KtbDBSgDIaSLfQuX+kWBz/7RJnSQl+A89YBbY47sXhLuC2VJj/y3x/Z
	 6/EC/XqkDXmYQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 12:32:17 +0100
Received: (nullmailer pid 1712837 invoked by uid 1000);
	Thu, 22 Jan 2026 11:32:16 -0000
Date: Thu, 22 Jan 2026 12:32:16 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: Boris Pismenny <borisp@mellanox.com>, "David S. Miller"
	<davem@davemloft.net>, Florian Westphal <fw@strlen.de>, Kristian Evensen
	<kristian.evensen@gmail.com>, Leon Romanovsky <leon@kernel.org>, Leon
 Romanovsky <leonro@nvidia.com>, Raed Salem <raeds@mellanox.com>, Raed Salem
	<raeds@nvidia.com>, Saeed Mahameed <saeedm@mellanox.com>, Yossi Kuperman
	<yossiku@mellanox.com>, Network Development <netdev@vger.kernel.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Aviad Yehezkel
	<aviadye@nvidia.com>
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
Message-ID: <aXIKwNJv59KnsnLw@secunet.com>
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
 <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp>
 <aXIGxmCB2QU86-iA@secunet.com>
 <447378de-3cc9-44f5-872e-a1fc477f591e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <447378de-3cc9-44f5-872e-a1fc477f591e@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mellanox.com,davemloft.net,strlen.de,gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252306-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[secunet.com,none];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5460766717
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 08:28:31PM +0900, Tetsuo Handa wrote:
> On 2026/01/22 20:15, Steffen Klassert wrote:
> > Hm, I'd say we should not try to offload to a device that does
> > not support NETIF_F_HW_ESP.
> 
> I was about to post the patch below, but you are suggesting that "do not allow calling
> xfrm_dev_state_add()/xfrm_dev_policy_add() if (dev->features & NETIF_F_HW_ESP) == 0" ?

As said, I think this is the correct way to do it. But let's wait
on opinions from the hardware people.

