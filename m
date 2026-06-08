Return-Path: <netdev+bounces-296438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MUFDMk+OJmrAYgIAu9opvQ
	(envelope-from <netdev+bounces-296438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:41:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F31654AD0
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:41:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=CtDu0a8c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296438-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296438-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0C1F300988E
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCAA3A7591;
	Mon,  8 Jun 2026 09:41:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0243A9612
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 09:41:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911692; cv=none; b=bYaDA5zlVX1zdFbQ5PlTFFoRTTUuLK+ziXOdw0HDn4IiscczI+02hN4zzjwHgCERZFu4CpgD12LxZY8E3jWbS5Sa1SpdiAd+1P03sk6YDRf3ChF/vE/kGv/vfFvEcEDENwqe/IDnhe73za2dL56bo3zXCytH2CMoDmbjhEWIjRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911692; c=relaxed/simple;
	bh=ufd81KgSNqUt7oA0teLIU8hZnm4GyP2aNNp6eUAyI2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=lycTcEnTaVk1o79CHC8mF6Bm9nPWfVyknUtyRbHkfyuRoKHtsuPkr4KJmqY3WNArBSjGPg0QAper3UH9kB6n2T+dMFA2HNnCzd5EPeWzgorN8OwciUs4+vb/U+uAjZobTlK2DQXZRGkFR5uu8QnmsuWSF6bt7M8/guE9rj3vphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CtDu0a8c; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260608094127euoutp01030cddce6c9be97d2d0343493bad1d38~3Eb6RUL9b1854418544euoutp017
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 09:41:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260608094127euoutp01030cddce6c9be97d2d0343493bad1d38~3Eb6RUL9b1854418544euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780911687;
	bh=obEQVdyJXAFkEI0Je/LnT9feisCX7gXrGWaTmDNS/as=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CtDu0a8cImy5JxUjV9LlIN1j5eGanH+PqXyibLEZXNH9fJe274NoQAk/Q2h19A2Im
	 7QyqlhJENEB6aMlSbzDiBLNNr6vHhfJ3ksGVoYNZQy2OCt9DlE9s9uTni76Rni1MPt
	 LbC0RGfORp+p2SBwZJHvG/Z6YosO+MwklwkJR46I=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260608094127eucas1p1c139d6aec7fe2c8dd308e1885033ff6e~3Eb56fxPn2011920119eucas1p1x;
	Mon,  8 Jun 2026 09:41:27 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260608094126eusmtip2229735d838ef62408503f8ed036fe734~3Eb4yXZk_2588725887eusmtip2-;
	Mon,  8 Jun 2026 09:41:26 +0000 (GMT)
Date: Mon, 8 Jun 2026 11:41:25 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Ding Hui <dinghui1111@163.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
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
Subject: Re: [PATCH v3] net: stmmac: fix fatal bus error on resume by
 reinitializing RX buffers
Message-ID: <aiaORbb0lZVxDg8L@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260604144557.3175399-1-dinghui1111@163.com>
X-CMS-MailID: 20260608094127eucas1p1c139d6aec7fe2c8dd308e1885033ff6e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----ri_B_5NHaOs85FNcStlWAa-YkdjA1OEu4E44JRLWFc1KTRWK=_126c1_"
X-RootMTR: 20260604144752eucas1p180b6c1b783450a11e78584257e023f69
X-EPHeader: CA
X-CMS-RootMailID: 20260604144752eucas1p180b6c1b783450a11e78584257e023f69
References: <CGME20260604144752eucas1p180b6c1b783450a11e78584257e023f69@eucas1p1.samsung.com>
	<20260604144557.3175399-1-dinghui1111@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296438-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dinghui1111@163.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:dinghui@lixiang.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:xiasanbo@lixiang.com,m:yangchen11@lixiang.com,m:liuxuanjun@lixiang.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,lixiang.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FREEMAIL_TO(0.00)[163.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,samsung.com:dkim,samsung.com:from_mime,samsung.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lixiang.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68F31654AD0

------ri_B_5NHaOs85FNcStlWAa-YkdjA1OEu4E44JRLWFc1KTRWK=_126c1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Jun 04, 2026 at 10:45:54PM +0800, Ding Hui wrote:
> From: Ding Hui <dinghui@lixiang.com>
> +	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++) {
> +		ret = stmmac_reinit_rx_descriptors(priv, &priv->dma_conf,
> +						   queue);
> +		if (ret) {
> +			netdev_err(priv->dev,
> +				   "%s: rx desc reinit failed on queue %u\n",
> +				   __func__, queue);
> +			mutex_unlock(&priv->lock);
> +			rtnl_unlock();
> +			return ret;
> +		}
> +	}

This is not directly related to the patch, but rather stmmac_resume() itself,
but doesn't this return and hw_setup one leave bunch of descriptor memory
hanging and effectively leaked?

> +
>  	ret = stmmac_hw_setup(ndev);
>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> -- 

Other than that, I don't see any obvious issues.

Reviewed-by: Jakub Raczynski <j.raczynski@samsung.com>

------ri_B_5NHaOs85FNcStlWAa-YkdjA1OEu4E44JRLWFc1KTRWK=_126c1_
Content-Type: text/plain; charset="utf-8"


------ri_B_5NHaOs85FNcStlWAa-YkdjA1OEu4E44JRLWFc1KTRWK=_126c1_--

