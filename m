Return-Path: <netdev+bounces-278977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCoPBduj4GkEkgAAu9opvQ
	(envelope-from <netdev+bounces-278977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:54:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C1E40BDD7
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88B333013EF8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0E384232;
	Thu, 16 Apr 2026 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ac9tj3u6"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B337F8AF
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329684; cv=none; b=hJQyxS6g4kRAHyrzYdWrtkcEvmsu8nHBXv2o7CWBhvbClmxao+wuEObGAcqxrpSdcqHLlOuK6LuThLDiWOmOdZHbywxYPd7HUxPGZDaeM4SFto+wa7VtgytReXseG22WvCyLjSepkLiJU0kSQOcGgmPDPcl0u5EWTDvAPvz7V5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329684; c=relaxed/simple;
	bh=0hVzSIPn5uhdApZ9JnNwNiVK8zLuZNEwYIshEeNqQz4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=ocFsFkKvnqVwlLo9nB61yhgIv8F9pOZIOGzliegVCKTz7Mav5K3Kc/CQcwEKuo1GzWhp+FF9AeB5p19U3etQK0Qo4fFWmvg6cmDbmSbIW0U85etmVVJ2DNIZalRn9SMI7uTfe2RPn0jMBZiI4nVjZbzpSYXEKLQeBUk+xcsh39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ac9tj3u6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4B3D44E42A18;
	Thu, 16 Apr 2026 08:54:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1EDB15FDEB;
	Thu, 16 Apr 2026 08:54:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CCE91045A148;
	Thu, 16 Apr 2026 10:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776329679; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V7sHlpP9WcCyxAkpUsYbIS6sNVJZx8gGVQEfMic61Ww=;
	b=Ac9tj3u67O81GBitqbRpO4/czlpyeNmWG14W+lOOnITLRYDIyzBs6Jz0CoT+fdGTNsLujb
	l5BawobAtwc9uZPduJsut7I3A7ICSxhN4pHFBq4Zytn2gtc9jwwPlLhPBQaOUZaQlto0nZ
	BfsPyMiifLtnH0KTlyiLjvrpFNDropmPEybERCUlrG/9RBhf++gNCCtQ+H27lH/zLq98eJ
	AU3xS7WYcpLKieYJ/9oBgzHwMAq/VTs3g9D+kuRbeJyqZTkKONOe74wpZF6t0Dxkl7t95N
	Los2i0smkzXzsqpXUVhyx1qHXP3sHMvKT1JRMo9uccYQ0cCQg7nG/6R8F82sbg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 10:54:33 +0200
Message-Id: <DHUGBENEI5AU.1XI2OO09FCELT@bootlin.com>
To: "Jakub Kicinski" <kuba@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 13/14] net: macb: use context swapping in
 .set_ringparam()
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "Paolo
 Valerio" <pvalerio@redhat.com>, "Conor Dooley" <conor@kernel.org>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
 <20260410-macb-context-v2-13-af39f71d40b6@bootlin.com>
 <20260413175040.352378c5@kernel.org>
In-Reply-To: <20260413175040.352378c5@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278977-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,tipi-net.de,mobileye.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:url]
X-Rspamd-Queue-Id: D9C1E40BDD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Jakub,

On Tue Apr 14, 2026 at 2:50 AM CEST, Jakub Kicinski wrote:
> On Fri, 10 Apr 2026 21:52:01 +0200 Th=C3=A9o Lebrun wrote:
>> ethtool_ops.set_ringparam() is implemented using the primitive close /
>> update ring size / reopen sequence. Under memory pressure this does not
>> fly: we free our buffers at close and cannot reallocate new ones at
>> open. Also, it triggers a slow PHY reinit.
>>=20
>> Instead, exploit the new context mechanism and improve our sequence to:
>>  - allocate a new context (including buffers) first
>>  - if it fails, early return without any impact to the interface
>>  - stop interface
>>  - update global state (bp, netdev, etc)
>>  - pass buffer pointers to the hardware
>>  - start interface
>>  - free old context.
>>=20
>> The HW disable sequence is inspired by macb_reset_hw() but avoids
>> (1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.
>>=20
>> The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
>> over register writes which would be redundant (because values have not
>> changed).
>>=20
>> The generic context swapping parts are isolated into helper functions
>> macb_context_swap_start|end(), reusable by other operations (change_mtu,
>> set_channels, etc).
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 81beb67b206a..340ae7d881c6 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -3081,6 +3081,89 @@ static void macb_configure_dma(struct macb *bp)
>>  	}
>>  }
>> =20
>> +static void macb_context_swap_start(struct macb *bp)
>> +{
>> +	struct macb_queue *queue;
>> +	unsigned long flags;
>> +	unsigned int q;
>> +	u32 ctrl;
>> +
>> +	/* Disable software Tx, disable HW Tx/Rx and disable NAPI. */
>> +
>> +	netif_tx_disable(bp->netdev);
>
> AFAIR netif_tx_disable() just stops all the queues, if the NAPIs and
> whatever else may wake queues is still running the queues may get
> restarted right away.

Your memory appears correct (unsurprisingly). Ordering was wrong, it
must be (1) NAPI disabling followed by (2) disabling of Tx queues.

The tx queue wakeup is possible in NAPI poll function through this call
stack: netif_wake_subqueue() <- macb_tx_complete() <- macb_tx_poll().

There is also macb_tx_error_task() that disables Tx queues at start and
re-enables them at the end. Meaning we need to disable Tx queues after
we disabled queue->tx_error_task. (Note that tx_error_task probably
races with NAPI, but that is outside our scope.)

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


