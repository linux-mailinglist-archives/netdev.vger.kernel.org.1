Return-Path: <netdev+bounces-295363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id btvtIdy2IWr/MAEAu9opvQ
	(envelope-from <netdev+bounces-295363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:33:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D156642519
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:33:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gilmore.net.au header.s=google header.b=KYs9gL2L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295363-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295363-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gilmore.net.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA47730315D2
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212D33A2E33;
	Thu,  4 Jun 2026 17:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60BC4C6F0D
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 17:27:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594046; cv=pass; b=HYty6MYELYZs/WnadSB2YDwcVlUoBNlX0cW9qgSvGWcHQhRvvBetDojqPfvWsmPH2rfgzHlLjyuaaGYyaaFPVrDqoUn6dsivCmwnX6OkOXOh68+PztgD2nbbBikxMirG1nfEyQIrOLcA+R1OgJn153KI9vYUr+xQgg1aLbeMHCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594046; c=relaxed/simple;
	bh=6/iK4uMOTWzCx1f9x5zTWSQXFWwfNxGnzU9ELaC4Aqk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lrep09MGpq5QX07EraKQqiqQPpnv16U5l8P4t26+gayo7+8qyL5OXG0yv+wQnuaxWAzJjNweyXawSFHFVuesEHFn2WUhaN6OschNuarDh+OEMvzx8DyeGXoIQYcVJjNy25CYNP1tBkCoP3A6cJby3mcAi2/TRn/YDMnbrSvtEM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gilmore.net.au; spf=pass smtp.mailfrom=gilmore.net.au; dkim=pass (2048-bit key) header.d=gilmore.net.au header.i=@gilmore.net.au header.b=KYs9gL2L; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51784eb2ba0so7617901cf.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 10:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780594044; cv=none;
        d=google.com; s=arc-20240605;
        b=EtQu/3bonJDOJ9uozTbueP7y2MEgim8tjfLeOxwVVbPKHq2FJ+lqis2H2zzPt5v6sy
         ouUPdBbBS8duvZ8whWvqRakyJzK4Ud+5t9JalaRif2EWRD9xyyBGVjI2pt4kw6JT3rjI
         PG/hF4tpN+SCxI9jPiw2TqBPEr12ZAVUsh2JOGeMxjqdDjgRCgsTQCq4vxNsP2ETl1x1
         bfsHH3mp5QL5SKT0JCz5FvYjMBLchSean8k1Q0V1vWIUznFgpjJLk0ixHFtj7KGfnAiu
         QBECFqGQX7JovklcfbbqNIINXrMX0VUaI+eH0EcH/0FT2zOJ+orK6n+K04DRxn8ZYTi6
         5n9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=gPL/34wvaoxtqwYPSWYzpFqvhDiZWv7s+PvEx1IcPy8=;
        fh=3R1uR7xpiMaYcSLSNXHibBQja7G6U96r1H9dRFWuAAk=;
        b=cuNz3dKg4Vey6jXBTwVtK70LwsZ7rg5ZvwjracDuQdhjALV+cvD6hBWIVlN0MSvrAH
         IE/hFj/GQgdGxEsy/XZ6YRH5SuE1wjCwfJIBd5xudU+K1Vb1Zh8ZFmUJHLMx4mqtwxOa
         X3GuaTi6QGFZGUCOpnfo9OyD9ifajEg+aVJ1hoPAhE/w6bzJb/TSS6W3See4hP836y3e
         1yUKmuqUueT3ibZvAhKN+88nta//dJO7qaY/YVEtJcOuzVYVaqxQ94l4g1svxEzjjV38
         FB22wJKtqR9MACxh2MhNVJJ8vXcNUNFzYCXNV3cUbHc2Fu+egp1orIHp6KlEX8FVeQz2
         /oQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gilmore.net.au; s=google; t=1780594044; x=1781198844; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gPL/34wvaoxtqwYPSWYzpFqvhDiZWv7s+PvEx1IcPy8=;
        b=KYs9gL2LmzVlzJyaVUwUOJC9Paaa1OWLRALD7KLAQMCh3QPfYX2r0qIhC4zVUDqRFB
         Yjm85Fb24UeAne9A8J+G5Qh4+v9D5jLEjgCSDzsIijurWPsDvf4rQ9ajvei6qJ0WjH31
         K0QuH+L5i5SsackwcB348+2k1Qu13L5M5YlagKXaM0kQRyVXcv5Kay8aVkGCGsn8PflZ
         9R19DLoZGKTxkt8WGNjzS+PBgd2Pwq7mlURKYHirWIu7RaK/XX4MKo/MrftxdQK8Bi0L
         xIut1P6HrliurquH+k+nDUp6CcDr0SNe96I/IBk5jBuzxZtXa9BsIIFXbmpOsjLMW9jC
         W/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594044; x=1781198844;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPL/34wvaoxtqwYPSWYzpFqvhDiZWv7s+PvEx1IcPy8=;
        b=QaTFlXFYujZuARVta+2WnnXjrk5CKb6SlO1hs5aF0RJhA32KBKewVPkeIsAEtinBs9
         ZgzDLBYVn4ibzRHzOARBA1YuZ7CQqL5tLhPvNRxPnDnBbk7AsaH7CDaBGJlpDHO9cRSq
         42UfHgYdv0+PqIcd6eIfjPg/qBryVkzgHGVVWoDoSkO2z0Qy/z/mcgrN6GZPwdsQQHRK
         Dq7sD6jiMAt6I/vtDKyxOtIVWN9W9wovVQUDadqfM0uADFsbfX9qcctfy5jY94fzKfgc
         L9aKvFC/wCr42QVqo5+69wthk/anco/4nCLULsQJpNq+r+XdgsSF+HPE1lXBysSfc604
         fjOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Q3/ETIlZy9mC5Im0tvtrBH1Zo1HVAL4OII8yLegQvTWyC/i9pV97mREMfdIk31E84F8RMjPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+X7MkACJW2AsVjjOScffkhcpj4XcObxGZZmrcVKkIXVPHb+V
	nI23T8qbOVax4z8QeW34pv42Z+64xCHgtrPMqde9LzmHV2mJ9Zwc89mfXcUf5ye3V/Gg6u7UksT
	9omOCu3K8tpU98XgldBVaM9epVEBlP9WzOOC1vXjd0CmfpD/2+j8AvCKPb5O8j2M=
X-Gm-Gg: Acq92OGNlUvQIq0v/y1aTcNW7RIc7r7dy8eJ2daj/R1hwpZGI6iDmTDu1pIBpWugkIj
	Wd4Je+n9lwpaABszRCTjkvwrxIwKmdTLrTZv6wZgALy46TbJ/jj0EW9nkEpoZ748MyszlwpsZgQ
	2qzY+We/m5e8L9/W0zu/wVDTCdeJpxmygQmUW/UZeIntSO0TMcQWuIufIuSBmj6jVctJPuKr/sg
	4nj7V2ybb5GjgoVEGYF225o6y6+NylIKOBarxf+lyLiMpJQy6yvSiiwOVUHqGJ3IaHY0VRvMc3W
	50+TTGoOdn9+rUwxsRsm5pt1L9Mwy22wd5Ye6XxzXipJ1iYbJM8R1VU0TULd9OFXJXdzJM+rjFo
	5zhzchw==
X-Received: by 2002:a05:622a:652:b0:50d:3eac:8466 with SMTP id
 d75a77b69052e-517786ed4eamr123741381cf.30.1780594043754; Thu, 04 Jun 2026
 10:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dennis Gilmore <dennis@gilmore.net.au>
Date: Thu, 4 Jun 2026 12:27:12 -0500
X-Gm-Features: AVHnY4L4VbeVVDM96w3Ryrk0joR_3R6TrZkYc3uVkd5bWpR8TKH4NYOWWKTh99M
Message-ID: <CAABkxws33UjeKYXHrk-AHYUi9w5jFNxn4=T_FuXSng7WJbh2SA@mail.gmail.com>
Subject: Re: Question about support for orange pi 5 pro (dts) [was: net: phy:
 motorcomm: YT8531S missing LED ops and default init]
To: Frank.Sae@motor-comm.com, netdev@vger.kernel.org, me@ziyao.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gilmore.net.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gilmore.net.au:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Sae@motor-comm.com,m:netdev@vger.kernel.org,m:me@ziyao.cc,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dennis@gilmore.net.au,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis@gilmore.net.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gilmore.net.au:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D156642519

Hi Frank, Yao Zi,

I am reporting a driver bug that affects the YT6801 on the Orange Pi 5
Pro: the RJ45 LEDs (link/activity) never illuminate. I had not noticed
it, but I see it now that I look. A user reached out to see if it was
something missing in the devicetree, and I believe it is a driver bug.

Environment:
- Orange Pi 5 Pro, RK3588S SoC
- YT6801 NIC (PCI ID 1f0a:6801) on pcie2x1l2
- Kernel: mainline,
drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c +
drivers/net/phy/motorcomm.c

Root cause:

The YT6801's internal EPHY presents as YT8531S (PHY_ID 0x4f51e91a).
There are two problems in motorcomm.c:

1. The PHY_ID_YT8531S table entry (around line 3059) is missing
led_hw_is_supported, led_hw_control_set, and led_hw_control_get ops.
The adjacent PHY_ID_YT8531 entry has all three.
2. More fundamentally, the YT6801 is a PCI device with no OF node. The
phylib LED hw offload framework only calls those ops when LED child
nodes exist in DT =E2=80=94 which they never will for a PCI device's intern=
al
PHY. The yt8521_config_init (used by YT8531S) never writes any LED
registers, so the chip's power-on defaults govern LED behavior, and
apparently those defaults leave the LEDs off.

Suggested fix:

- Add LED hw ops to the PHY_ID_YT8531S table entry (same three
functions as YT8531 uses).
- In yt8521_config_init (or a new helper called from there), when
of_node is NULL, write sensible LED register defaults. Something like:
  - LED0 (link): YT8521_LED_1000_ON_EN | YT8521_LED_100_ON_EN |
YT8521_LED_10_ON_EN
  - LED1 (activity): YT8521_LED_TXACT_BLK_EN | YT8521_LED_RXACT_BLK_EN

Happy to test any patch on the Orange Pi 5 Pro hardware.

Dennis

