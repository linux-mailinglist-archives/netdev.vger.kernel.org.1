Return-Path: <netdev+bounces-272164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOiFD7JsxWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:28:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07133920A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E26643009B19
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE641C2EF;
	Thu, 26 Mar 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q0d1aEaM"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955B41C2FA
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545936; cv=none; b=JKVpDZ0hfSrA0jxXIXprZpFu0VTYOiMQEn27dfWikx8khPMVq+h3B32RQsRAPqMoaVLW5biZnshTe8jAbYwQH7NFOMFNFDIf3Mnha46sh5Yb2T6wGjtJbaeUDa3hOvjiq/Nxcwev/cwmSp/kGY5aAd6VKBJae8mCbh/+Ct/jwdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545936; c=relaxed/simple;
	bh=xXogvxR96Nfka2c9N4TQm4TvJydwRvae2H+Ztp9lFuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHD9hxY0Uh1T55c+BOr+P8nF1xN6oJxsmUtvs5VBBLkoqgj5Yer+bWuyLoXb0whBXLr6HgwAFutsWn8diMiy9lorBmH5LwZFPa9xoAQhgyB0cY4+yK4iXLbzm03wiNLs5pGlWcySMVG7MGl0F+RiFyX4x7AbRQo8fKEdqWr7aww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q0d1aEaM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E05934E4280F;
	Thu, 26 Mar 2026 17:25:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90210601FA;
	Thu, 26 Mar 2026 17:25:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54A5A10450C6A;
	Thu, 26 Mar 2026 18:25:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774545929; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ysN35GdxO1ttW5m2FClYkwqiFcjtmzjlRfjcsFmDvAI=;
	b=Q0d1aEaMo5UpzpiJ6qXDP3rV+xnW3uNZNbk4gVTqZfIyTR9HrtirKmZuHJR/iI6mFOjLqC
	aOcC/UcObBbsTyKSKEa/cZqSq5uv7diljbGR86ZwqNdiKY6iNIiQWU5dqpJCcrlHgGZ4in
	Gua7WNkUofKWtstY20tQ+EU0t3kqAfXRNgGerqiiToKGFupUHhKVrcX1QmLFnSrjlNpSk+
	+x5kX+wJVeQQNfTgSMFh5KkHouev4aSioRSQwne1YV//bDQrUAzPmqumiKnUv+DbQd4YIu
	DoA4sNdBW6Kkdkrx8q7FNbJRvdkY0EvfVu5Gbp7QxUAOQASKFizDcC1WH2AsjA==
Message-ID: <385d2137-0d15-4dc0-8994-9cd48e4150b4@bootlin.com>
Date: Thu, 26 Mar 2026 18:25:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
To: Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, kevin-kw.huang@airoha.com,
 macpaul.lin@mediatek.com, matthias.bgg@gmail.com, kernel@collabora.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
 <20260326-add-airoha-an8801-support-v2-4-1a42d6b6050f@collabora.com>
 <acVND6DdpM9czIwU@shell.armlinux.org.uk>
 <044110c5-da1e-48c0-93fd-35553e86b271@lunn.ch>
 <acVQQQiciPQBkQOG@shell.armlinux.org.uk>
 <425217fd-f74c-455c-9aa7-5b6682d887fa@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <425217fd-f74c-455c-9aa7-5b6682d887fa@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272164-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,collabora.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: AE07133920A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/03/2026 17:56, Andrew Lunn wrote:
>> What is the timing requirements for a system going into suspend vs a WoL
>> packet being sent? Should a WoL packet abort entry into suspend? If yes,
>> then we need to program the MAC before the PHY is suspended, because
>> suspend could already be in progress.
> 
> We would then need to hook into the NETDEV_CHANGEADDR notifier, and
> call into the PHY driver to let it reprogram the MAC address.

We would also probably have to re-do that MAC addr programming at phy
attach time ? If the PHY isn't attached (e.g. link admin-down on some
boards), we can't use that notifier as we don't know what netdev to
listen to. Or I'm missing something ?

Maxime

> 
>      Andrew
> 


