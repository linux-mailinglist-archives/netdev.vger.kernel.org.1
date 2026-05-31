Return-Path: <netdev+bounces-293428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EwpFD88HGrsLgkAu9opvQ
	(envelope-from <netdev+bounces-293428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:48:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C321C6166E4
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A71F30154AB
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086E23393F;
	Sun, 31 May 2026 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EmQXZMqd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF923392D
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780235324; cv=none; b=byGMgcOQggXQ/AstYnJOfx80pPcCzD4vk/cJke5dF+Qjh4SU2ZoF3rq13WBQT/6iMxk1Q1e0LA41Ojnt/2kZnmvcNftSYJ8WcL+WX9e7YMiV5Ji5Vx5HfqjF/+VC5tqlA0lWnlcfxrYdRORsJu741NEgB1AbM0iaS21Uf+oZj9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780235324; c=relaxed/simple;
	bh=E77cU14PGQ7wHwdMtl66bZ4chWDfgSb+K3IH4UyHRkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMH23MK2idqe9ryguJ6HpSOCsP0+JwoKWUecdpWPlmitTbOa1lJdm5B77kaL1zEgRkcZv6yv/0EFbe7AZjPQKPrkDqDoomo8yThfCbGffWVk5DxFBofSHkjLVi1Uc6f1ecfJUTJyadgk5MrKgG6G2tAMebQOpSP/q1GTPlvoe1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EmQXZMqd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BD2174E42D9D;
	Sun, 31 May 2026 13:48:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6562D60230;
	Sun, 31 May 2026 13:48:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD8F210888CC7;
	Sun, 31 May 2026 15:48:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780235318; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=c0sGEDSDi0ebuVGdLtrmZ5/hCCvoA73VCoypfFBG5C0=;
	b=EmQXZMqdfxSFW/J07wEY4OFtU/gWAGhCLkTAjZqG/BJ+l1TFWE/Y1wItbydJMZy+jwtlGG
	6jpASkqZCyoHDMaM335B86y0PDupxHffIZV2cwic9GfIElQFCyUMVSuB7iekrv0cAwblfr
	rFjApS6/JNwvMtotM8LOBTCBHMsFO+eBwVouPRxG2g4zg5IcqbEzzvi3mfmeNOHEyTOGGG
	Lw734I+478xfwEuTQBgKF8sIJoLqnkRWF9zAmo18UELMCqByshcZemmnWBYrdFnfDA5JWT
	MICHlddCtzAcwswk3LxJuU8lRoR1qu0Ley1oHAM86b2ci2vx80ZZ8JbE572MDg==
Message-ID: <dfe22404-5608-441e-aaba-ad9edd7038a8@bootlin.com>
Date: Sun, 31 May 2026 15:48:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: clean the sfp upstream if phy probing fails
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <20260530072706.3167745-1-maxime.chevallier@bootlin.com>
 <e7237bce1d68920b054da56abddf94ef@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <e7237bce1d68920b054da56abddf94ef@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-293428-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C321C6166E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/30/26 14:33, Nicolai Buchwitz wrote:
> Hi Maxime
> 
> On 30.5.2026 09:27, Maxime Chevallier (Netdev Foundation) wrote:
>> Sashiko reported that we don't call sfp_bus_del_upstream() in the probe
>> failure path, so let's add it, otherwise the sfp-bus is left with a
>> dangling 'upstream' field, that may be used later on during SFP events.
>>
>> This issue existed before the generic phylib sfp support, back when
>> drivers were calling phy_sfp_probe themselves.
>>
>> Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
>> Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
>> ---
>>  drivers/net/phy/phy_device.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 3370eb822017..6c2ef91fd197 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -3775,6 +3775,9 @@ static int phy_probe(struct device *dev)
>>      return 0;
>>
>>  out:
> 
> While at it, should phy_cleanup_ports() also be added? Failure of_phy_leds() or
> genphy_c45_read_eee_adv() would IMHO also produce a leak.

Good point, I'll followup with this :) Thank you !

Maxime



