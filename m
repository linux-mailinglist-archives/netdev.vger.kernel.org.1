Return-Path: <netdev+bounces-297335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rAEnGymTKGrPGQMAu9opvQ
	(envelope-from <netdev+bounces-297335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:26:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BEE6648FF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:26:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=QCQJjyR5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297335-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297335-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0F98304E500
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28A14D2EE9;
	Tue,  9 Jun 2026 22:26:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511C4071FE
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:26:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043961; cv=none; b=S4wWUN2Cyo/BchsImb/hvFNZqUB1oV5lWrzGxLl5lGnTk5ltl19qC0f4/8T4Xq3nEeBN/n8n38nJrY0L4zuZE9psfgxPBJo6NVpHLCJ6cj6+sqNKNI76NkNUGTS296Vd/wjMlVFEU76YXidvtg6Q5083h8RtVmDCUYt5CJiKNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043961; c=relaxed/simple;
	bh=B4kz5SsRggjEFJjV3J/sE+7/gP1ESaf/r5J4kQ1a0Po=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N8sULs5IbEObobBHW9npriRVcVmDAcr4k+W41l5We0EKJPoiA3v+iVoTBG8Cadv4enAV66JIrGj0mpujGFuXudYebd+A/65zgZ0TSzru9vdoz+zgYRE4+5jE3U7OHzXHFN1HARvNTd91ft1uPvh1TZjiG1EqcBVLUAtKtPBsKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QCQJjyR5; arc=none smtp.client-ip=209.85.215.169
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8588ec1b44so4165472a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781043960; x=1781648760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46q2U4nrUSnKYOo0Qk6SmRB++eNAzeKGUuI3ymafY8U=;
        b=QCQJjyR57x2jUdD3ntf6Gyww23PmARz4+wAcMdlzZE7wY0U7MqkScjLb+CT50OyZh6
         J/daVsPnZPc4yBpihDiUbgT4VGV0h9dxPXWbvpUu/q4qYgmBdvJ1euYLyvNvSbOGRONc
         NPjGHwYjXnDtuu5yVjS/sY21m3uBsnTPnRJuOsQneVVFuatI+lmoqwBhPbOjxxEK26i+
         W4YVcitKlZ3LHPjK6MRkSuj93knXfvNFg4+cImH/6dZ3x/Lgwx6UYIH+KHt1tYJGrJ+6
         +QB+g0IXjgcInp0c8o8Sfa8HSlJCsKibi7ZbFiVKKp+yCmGtIOHT2erGIHX2sRanrN3V
         ftYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043960; x=1781648760;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=46q2U4nrUSnKYOo0Qk6SmRB++eNAzeKGUuI3ymafY8U=;
        b=rLvv1TlcavrVvPEtK/aQFNqM7xwlJM/khke3pZZEV+Rue69wtR+lbgq7zcBlOGeTYj
         3hM0OzYwI8x63vTNcqE+rDpoTgtepAcXF3OUEhaFurRYUaoiEgEoekxR0uIL+suNl/CI
         iQJV4QqR91NE20K+W5s4gUfiA8q8yyp5RMjWgEFDuzZ2VAtS5nJTpknR1aXZBGorr4W0
         Nn88SLV38tr8ZRZUSBShIoEHmgotjnHtk29Q37itDgFmSseHpmumG6uyu3E9nsCJFx2N
         f0FinzLFRJUO5n0GXqRqdzcpkKwsD0t18geDMDJ0dzJ+ZILeh5P3Sk8WG+/PtEXoWza6
         W6ZA==
X-Forwarded-Encrypted: i=1; AFNElJ/cDL1jb63L4eTAY6tIj5dJpmwrMpBs6lLJTHtIW6uzNSUpHoerQoR+cfypJGuH0agXjtSFsfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmicPMggaKQuLFp9/AL83XUBvDb22L+9JlzpVxh7U0LBwOXiH
	cVWgWt3qsfEJANgGMNX2aGTX+NRWBACMnulgPYuIbeT67p1e6TaSqToM9n3803rcOayf/jyr1CD
	1lgKwQkrUvTwH
X-Gm-Gg: Acq92OFXMuM10Sz2nzq9CjRBoWTSSBty8qitZ41KEG7XzyH97FlYC9A4KDaHKvGRhYK
	ssx90NY2LPghttLdH0Ytttifs1gvNcu7UonKlMwDJ2g1KTV2WUBUXa8mwTVqr7rBvdu1DneuiR6
	NjZ5bqNtMLD8fqe2t0SFk7ut1AImPh2GErGqz9xNuShoVKinOdgt8zc6LmujR313GEZ5fYn/C26
	MCEo3rFLX2As1uzmb8DnzLvCdJyHzncCpgmf/bp3im+5AWJvwjR/mKNcEJgwGOLC17Av9G/fF3p
	ZDCXfqhzvYhjvj6M/FRB1t2AOWfMmzq/cK9UjfERQZM87EXWuo9lyxYEnRO8ZtJSSPIeg6OZNdL
	4F6HO5G9qTUEnxC73ZpVBen26SRdZSFch6DrStllkFc/qIb7w4POzb1ePy7G2qjaXZEAbQkaNqw
	1ldX+lpiBItI6PKQHXzDBR11Um5CPrGk4=
X-Received: by 2002:a05:6a21:390:b0:39f:a42:9247 with SMTP id adf61e73a8af0-3b4cd0670f4mr27316925637.37.1781043959893;
        Tue, 09 Jun 2026 15:25:59 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-c85df0bd337sm19404461a12.29.2026.06.09.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:25:59 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: nm@ti.com, vigneshr@ti.com, afd@ti.com, rogerq@kernel.org, 
 tony@atomide.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 richardcochran@gmail.com, aaro.koskinen@iki.fi, andreas@kemnade.info, 
 Parvathi Pudi <parvathi@couthit.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
 danishanwar@ti.com, pratheesh@ti.com, j-rameshbabu@ti.com, praneeth@ti.com, 
 srk@ti.com, rogerq@ti.com, krishna@couthit.com, mohan@couthit.com, 
 pmohan@couthit.com, basharath@couthit.com
In-Reply-To: <20260428072046.3022679-1-parvathi@couthit.com>
References: <20260428072046.3022679-1-parvathi@couthit.com>
Subject: Re: [PATCH v7 0/3] Add support for ICSSM Ethernet on AM57x,
 AM437x, and AM335x
Message-Id: <178104395875.234140.5899663583168202275.b4-ty@b4>
Date: Tue, 09 Jun 2026 15:25:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nm@ti.com,m:vigneshr@ti.com,m:afd@ti.com,m:rogerq@kernel.org,m:tony@atomide.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:aaro.koskinen@iki.fi,m:andreas@kemnade.info,m:parvathi@couthit.com,m:linux-omap@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:danishanwar@ti.com,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:pmohan@couthit.com,m:basharath@couthit.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,atomide.com,gmail.com,iki.fi,kemnade.info,couthit.com];
	FORGED_SENDER(0.00)[khilman@baylibre.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297335-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,baylibre.com:dkim,baylibre.com:email,baylibre.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07BEE6648FF


On Tue, 28 Apr 2026 12:47:26 +0530, Parvathi Pudi wrote:
> This series adds support for ICSSM Ethernet on Texas Instruments AM57x,
> AM437x and AM335x platforms.
> 
> The AM57x and AM437x IDKs support two PRU-ICSS instances, each consisting
> of two PRU cores, with each PRU-ICSS instance capable of handling two
> Ethernet ports. For the AM57x platforms, the PRU-ICSS2 node has been added
> to the am57xx-idk-common.dtsi, while for the AM437x platform, the PRU-ICSS1
> node has been added to the am437x-idk-evm.dts.
> 
> [...]

Applied, thanks!

[1/3] arm: dts: ti: Add device tree support for PRU-ICSS on AM57xx
      commit: 9c4fc66a770a018062e371d1c8a77184d4c15dad
[2/3] arm: dts: ti: Add device tree support for PRU-ICSS on AM437x
      commit: cd080146369be3a1750774eabbb839c45cc9a750
[3/3] arm: dts: ti: Add device tree support for PRU-ICSS on AM335x
      commit: 19ab47bb6b96820c28024ebfe674050fa2c54ad5

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>


