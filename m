Return-Path: <netdev+bounces-302604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qxBHMktkQmqq6AkAu9opvQ
	(envelope-from <netdev+bounces-302604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:25:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 532786DA23A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:25:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=ADtwEzya;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302604-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302604-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1CFD3045A8B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E65402BB1;
	Mon, 29 Jun 2026 12:24:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805C4014B8
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:23:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735840; cv=none; b=eEXPz2MB2OOdquTBoVd5euyWk1eKe/mkpVgwyzMBioL0tMBLTjrr22l0a7z1kmTIdxMxyH8NMOY652TubVFW14HURFhwx7x43HeCwCVDyBgGkrHdiiH5Y0K6ePmDPHo2Fb4w5e0ZeFNqesZ2yyYELdtSGftRyUjtCD0qa/ZnnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735840; c=relaxed/simple;
	bh=ILrOk2P+4YIbgjhwimr6mEMlIbotrvQIk7b4uuv31Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iik3vfmJj8A2FGAMmNGbsAPYTQwhmIFgOkA3g0OBgn64jZRT5x2i07kLZPBvJuSZrq79quNBTw4U80qxV/Fjc82eN2Repi0PFk/tFpNP1w1izsCKu+rUoiT6qhGdJ/RfQr9apDwE1hIJylYWbte8o6rbnV84y9dKNImSWjExO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ADtwEzya; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EAB93C5145E;
	Mon, 29 Jun 2026 12:24:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD8315FF96;
	Mon, 29 Jun 2026 12:23:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49017106F0D1D;
	Mon, 29 Jun 2026 14:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782735834; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0JWC3/HI5GLNMPJskSp8HrjRuViFmhXlpOl8T51fHMY=;
	b=ADtwEzyayQKbH7uffhbV5HjZb6jgSKm0ln+QaeWEfBtv4Avx6Pyn8AUMGtv5nwhQ78SZSn
	OVBILzWAJt3tUiqUvWTr5Q+m+gOlc6xPmtueWxm5nx8T6eH2naDh+0pTCchwDE2j73h4A1
	znJ1KT6cwoeJ/q4i+vJP+lTHG2hsEVPo1qMkrchzOERa5UVU1kYp+CT9N92OhwhLuekSPt
	lJPLpFCIxAtlpQYO1mSw3AihoJzPRIi7Sz78gjMsx6diQ+MLW3f9s+4z4ktT7bhTrKsQYF
	kb5re/z+NpY9QdxXnq5mwUF3AW0kX9qa5gF8Vuv3idNmffuiQ4BPlKva2gqsDg==
Message-ID: <1bdf0dd4-4f34-406e-ae97-f2ec5b540906@bootlin.com>
Date: Mon, 29 Jun 2026 14:23:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] Revert "net: phy: sfp: probe for RollBall
 I2C-to-MDIO bridge in mdio-i2c"
To: Petr Wozniak <petr.wozniak@gmail.com>, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, bjorn@mork.no, olek2@wp.pl, kabel@kernel.org
References: <cover.1782581445.git.petr.wozniak@gmail.com>
 <23e3931915c3ed2a14cec95f1490e43d30b225e8.1782581445.git.petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <23e3931915c3ed2a14cec95f1490e43d30b225e8.1782581445.git.petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302604-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,mork.no,wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,wp.pl:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 532786DA23A

Hi Petr,

On 6/27/26 19:32, Petr Wozniak wrote:
> This reverts commit 8fe125892f40 ("net: phy: sfp: probe for RollBall
> I2C-to-MDIO bridge in mdio-i2c").
> 
> That commit added a RollBall bridge probe at MDIO bus creation time, in
> i2c_mii_init_rollball(), to avoid a multi-minute PHY probe retry loop on
> modules without a bridge (e.g. RTL8261BE). The probe runs in SFP_S_INIT,
> before genuine RollBall modules have finished their firmware/bridge
> initialization, so the bridge does not yet answer CMD_READ/CMD_DONE. The
> probe times out, mdio_protocol is set to MDIO_I2C_NONE, and PHY detection
> is then skipped for genuine RollBall modules that worked before the commit.
> 
> This was confirmed on hardware by Maxime Chevallier and Aleksander
> Bajkowski: their RollBall modules no longer detect a PHY, and work again
> on v7.0 (before the bridge probing was introduced). The Sashiko static
> review flagged the same path.
> 
> Deferring the probe to PHY discovery time does not fix it either: at that
> point a slow module may still be initializing, so the probe still returns
> -ENODEV. A proper fix needs per-module init timing (a longer module_t_wait
> or a per-module quirk, per SFF-8472 the host must also wait at least 300 ms
> after insertion), which requires genuine RollBall hardware to develop and
> validate. Revert to restore the previous, working behaviour in the meantime.

Sorry this didn't work out :(

> 
> The RTL8261BE retry-loop latency that the reverted commit addressed is
> handled in our downstream tree, so reverting upstream is safe on our side.
> 
> Fixes: 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c")
> Reported-by: Aleksander Bajkowski <olek2@wp.pl>
> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Link: https://lore.kernel.org/netdev/20260624084814.20972-1-petr.wozniak@gmail.com/
> Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>

I confirm this restores rollball PHY detection on my side.

Thanks,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



