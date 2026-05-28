Return-Path: <netdev+bounces-292738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ByAAKBZGGq9jQgAu9opvQ
	(envelope-from <netdev+bounces-292738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:05:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B455F41EE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CCE6303EB9E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E305A3F6C55;
	Thu, 28 May 2026 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HDHcRRS+"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278C3F6C4B
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980277; cv=none; b=Q3ilf28gaPeRlrhxKBVS/f2qx6utsgCM1n9kcj5ZyWouPmtwMi5cIFOBQ2zrBEOpaaHYaHZyBe8CwmmoUtUXo3n+nmDN0QvoTZfUvl0U6xm2qsky+Yk68b8b7/lw6P5iiqTiiGOuaIp484IIQLyxJT72MzUGKQCozukuf5gAqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980277; c=relaxed/simple;
	bh=WkU9xz1SrrYw3PUW/US9XbneITDyH6Un2MuRfmc6BpU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Q09s2favGgiJz5GZ4JctlpCfekw+PX2YK3DAKwJn0G+bgtHP6KBxPbBeL1P3zFdAPNn65gU4xEsMqYW/i4Iopbx45XIv1dwkQYRCSz6U19ofHsrWQI664+YElhd0VQu4iRkn+vbaSvRV0Wd7KwKbemuz+azAfzViyHM+LCL/++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HDHcRRS+; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260528145743euoutp02670c2fc4b091e0c4042eb75a6c9bc382~zwp5aE8cc0048700487euoutp029
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:57:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260528145743euoutp02670c2fc4b091e0c4042eb75a6c9bc382~zwp5aE8cc0048700487euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779980263;
	bh=r8mIV8ufMduGj/medyNOciSStQq0smXmRTboOYXyU58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HDHcRRS+zBXh2RyGK8RBYXremq7uAMsJQPT3ALuD+w8siSGtXzjDaQ3bhWruX197O
	 xyC4J3YkYQMuit/XJ4C+eTuvlS2dPdLil4iPMY3wYKrFX5Qxb36g/cyBUghhkZPUZC
	 6QX0MguYU47hlos0PTUkTPeJfHoX/iLbe0+stZdg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260528145742eucas1p25c5d23dd93d0946689a8867fd95c5db7~zwp5GPv8W2557225572eucas1p2s;
	Thu, 28 May 2026 14:57:42 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260528145741eusmtip2de8ddf36bc1db3efa926a8877ed46464~zwp4P6Aw61359913599eusmtip2b;
	Thu, 28 May 2026 14:57:41 +0000 (GMT)
Date: Thu, 28 May 2026 16:57:38 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Ding Hui <dinghui1111@163.com>
Cc: andrew@lunn.ch, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Ding Hui <dinghui@lixiang.com>, "open
 list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, "moderated
 list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>, xiasanbo@lixiang.com,
	yangchen11@lixiang.com, liuxuanjun@lixiang.com
Subject: Re: [PATCH v2] net: stmmac: fix fatal bus error on resume by
 reinitializing RX buffers
Message-ID: <ahhX4lIpHwhVekMc@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260526022620.501229-1-dinghui1111@163.com>
X-CMS-MailID: 20260528145742eucas1p25c5d23dd93d0946689a8867fd95c5db7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="-----ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_b9169_"
X-RootMTR: 20260528145742eucas1p25c5d23dd93d0946689a8867fd95c5db7
X-EPHeader: CA
X-CMS-RootMailID: 20260528145742eucas1p25c5d23dd93d0946689a8867fd95c5db7
References: <20260526022620.501229-1-dinghui1111@163.com>
	<CGME20260528145742eucas1p25c5d23dd93d0946689a8867fd95c5db7@eucas1p2.samsung.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,lixiang.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292738-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[samsung.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 71B455F41EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_b9169_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, May 26, 2026 at 10:26:17AM +0800, Ding Hui wrote:
> From: Ding Hui <dinghui@lixiang.com>
> +		} else {
> +			/* Theoretically unreachable: napi_disable() in
> +			 * stmmac_suspend() ensures all initialized slots
> +			 * have a valid page before we get here.
> +			 * Defensive check only.
> +			 */
> +			if (!buf->page)
> +				continue;
> +
> +			stmmac_set_desc_addr(priv, p, buf->addr);
> +			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr,
> +						 priv->sph_active &&
> +						 buf->sec_page);

It this generally sufficient?  Or, in fact, isn't that overkill?
stmmac_rx_refill() generally does a bit more preparation of descriptors.
The issue seems to be that during suspend there is mismatch,
caused by writeback format, between rx_dirty and rx_cur pointers and
there is bad handling of this case, since there is no verification
of leftover stuff and there will be leftover bad address crashing platform.
So stmmac needs to refill/reinit descriptors that were consumed but not
refilled. So isn't going through whole dma_rx_size overkill?
Wouldn't it be better to iterate over buffer from cur_rx as long as descriptors
are 0 and only apply refill to those corrupted?

Could you paste panic that occurs during this issue?
You mention "fatal bus error" which I would assume is system panic?

Thanks

BR
Jakub Raczynski

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_b9169_
Content-Type: text/plain; charset="utf-8"


-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_b9169_--

