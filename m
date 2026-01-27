Return-Path: <netdev+bounces-253793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Lw9LliPeGmqqwEAu9opvQ
	(envelope-from <netdev+bounces-253793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:11:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FAB9282D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F99304FC04
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA5274B48;
	Tue, 27 Jan 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZ4LNQxM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF82E717B
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508494; cv=pass; b=O0CeppVnk/e1/EUnhFZp5Set9iiy+jtGCI9qifCCWm3PpZmZQvVHQDkerF+7/9ozkAOxMKrkL1rbCPg72Q910DmrdZxyxDarrV47KMlrQl30vsnJi2HnTCSFA2Mcar7t9U0U64UwIdVWK9K/RzSjVXbQKa1tv+FrWr+r+5I1AXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508494; c=relaxed/simple;
	bh=MLw86eBiDXAumXM++7EfiGG29Qu1A8IbBkYgIWvUoKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4a6EabDBBI/q6RN7PzcGkrFMeObIJb8eLnNPgo5/0myGDcmLrdTXSpGXNjpiF4SOuJiRGCCa3GikSqIH5Yyh/OZ+BcfEBuwyReuDQpDWmwAbRbiCq42HYJXAVu9NV5YeCqHTESKebl9As/cXrHGnZruxQ3wgj5AirKC43yrnMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZ4LNQxM; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so8753079a12.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:08:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769508491; cv=none;
        d=google.com; s=arc-20240605;
        b=a/YuFpqwc9XeEdd8E6SyyGr1tbydmLp5eiBEpRvynXm4Zizov24Hbg8j+Mk/4TE7qz
         eluo6bMOFVkT1ewElzV0J9bbAOmeirkIn0rjsvljdHDSDinfAz7QH2F20wU3XIWUpf+x
         v3ITjbKIj8JTBZdYoGHHor0yHHYQalYkoQD9Q9ZwRH0MMCk/E3PXXSglPds1lWwe46dD
         gNjq72JLwKA3feH93o/gimuD84K5IxsUUWZyln69NnohJa3JjX0Xr0gKlvd0ClXXONeG
         EZz0RyZDr8U3YnaJ8vbD6Wy0EtbdcEEtie95yP0ECjQk3w/1SDX0Mugl3DQsPNsMKyCv
         3zKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bpxQmfY9VK7T+Y3W6DWNgC6rQuK+Ld0siGTt5w9irRg=;
        fh=yXrtQEZpXa9GQyYNZSuygmuaU1dJ80A3KNFKIvvbd20=;
        b=JOPqIpE/oVYxhCmi8J5NbpslfH4cnBNVRH+lfcpv+zoovAt8lRBxiiarKOmW3HqjS3
         ECHns0pqhN1nbAlP1sLsOE5UiD4Td/8FiN7UJYsqQW/d6Ydcl3ryybba3xs3pOIsuXRG
         6WXXHESUGVPr4ckOKeOMoOuCRpaQRwhqRS3hOODcCugvnVh91RKSnRI9yj7RbejPODIP
         Z7ON03pIYh9at0iMVdrXWDh1skB5eyiBn8gVJ0R3e6SA3yXDd4l1eklpu7KVjzr779mU
         TuKqdiYMe7rN6yPXrrllJhmBI3iRPHD/m9hgaIymffU4NipX3OAu4M3GHeRCN9stwXJf
         Y5zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769508491; x=1770113291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bpxQmfY9VK7T+Y3W6DWNgC6rQuK+Ld0siGTt5w9irRg=;
        b=NZ4LNQxMyzH8a+73O1L+U3RpEVlcCjiKmi8MQ8VwPQkONMXrkMFCRTwxrmqCHkz6l1
         2EkUZIxGbBgO6Ji7LA/xvWYUklFiXH9MIHvyf+zYHYPBbOz7jlxKijDrNQyPRrVBHJWQ
         LD+DAc/KC/TLCakdfBx46NuXxT+Z2hfjnt/U7eCcYUbG1zyLSr8ZHfi0dlFf9RuAghYi
         CIJQakHNnKXgaIpfw/HMS8FDOSEhbP6p2cuYiEkmu4KKON+ifvEi4Tv+LeOzrtP/fkhB
         fn+8j98lx+ZUPmboBm6TOwRLb5TrJNmB9km7C6KGPm2UAxgYhv6Kry944o6rRElBwhTi
         mm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508491; x=1770113291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpxQmfY9VK7T+Y3W6DWNgC6rQuK+Ld0siGTt5w9irRg=;
        b=lpeBhzx7IZIIgBNrOW2mp8VDqfDIDpuNLrBcJ76eZRLFHnz3uK7wOSvUAe2swqOgJ5
         tVHb0xM4F7KA2F2IcZpQ6b0EQCtaOsqwbshON/dwjoXzVdCaImt6zrqsVojacjoaERYm
         yC7B0BP3pHJ8hrVqpHCcrFSLFK6YdnHN0ELFjpg2C2jk7wjR1aP1R0LGNHeO7GgH1wHA
         3jDXs7rv+iehNEoZJC7IMrDxY78zsUVYauAsKZ6UsvYBWBEpM1j7ON3TfE1LrFqFp+aY
         idlQFcHLE5kEO77/xHTkCompn3sKOr+Cc0N311YZ8QEzNvDOFwkgRIUWB9Ee86QyNvfi
         61yg==
X-Forwarded-Encrypted: i=1; AJvYcCWjoorjHEu27dhe/muCWlwOigK4wrv4VTEDnjevem9e2MNfxYnlYGUIQJrYX6wELOW0rmRm2q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQh3OLhSH/rDTuTcX4BmctVgoYh+3p4JMGY3bLVEtKn4bWlDfI
	IYbfJ5Pm+TIT5Ud5VSai8wzjTCaJEpX90OGaXobayBXBOkMJV40BlR5D5rVXHCt4M4+KClGP/E9
	iUxQv1ZHxjwsmuWAChiUB+nurB3kl28jzeuFI+H2rOw==
X-Gm-Gg: AZuq6aIb9INfSWcMW07/JoVb7fDAOanOX3D+mKDIt+KxNhZXDBzjRTU4lhFHIGFClUS
	RN14sQjJwt9x5kNIpRjVQmSjkT+vj7DThjmsPpDNB2S4FJp10eLkwz4WXGlbgp59hintEuc7Zqw
	u9QQXtNhjqdkGC/8Yo2v/2iFpEV5ujgFUk1lpvSjkTdXPiyupQBe63CgPKcAzZIi2yVZVal71hY
	7SbgV96HFbsAwPtbzNSWjVg5DoCJbp/MoWwCPNBex0rA4MHL0ibbeg+isfbHLIsWi+wSPEWQ1yT
	td7iKHEo5/VWpMLQyLmC6UEK
X-Received: by 2002:a05:6402:1d50:b0:64b:6e44:217 with SMTP id
 4fb4d7f45d1cf-658a5f8e7cdmr891417a12.0.1769508490979; Tue, 27 Jan 2026
 02:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-3-vincent.guittot@linaro.org> <69592713b7bd419e23df458734ca78070a83e8ac.camel@pengutronix.de>
In-Reply-To: <69592713b7bd419e23df458734ca78070a83e8ac.camel@pengutronix.de>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 27 Jan 2026 11:07:59 +0100
X-Gm-Features: AZwV_QiOrd8cMHRoDNLhWiUkjdTQ9Am6xMiRSspZlgdv4qBzTDeeYROI1wjEMTk
Message-ID: <CAKfTPtD+EZ+apAnS7tccY5UrQx3EWXb4j33F_5SkHY80akxz-A@mail.gmail.com>
Subject: Re: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com, 
	linux@armlinux.org.uk, ghennadi.procopciuc@nxp.com, 
	bogdan-gabriel.roman@nxp.com, Ionut.Vicovan@nxp.com, 
	alexandru-catalin.ionita@nxp.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253793-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:email,linaro.org:dkim,pengutronix.de:email,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18FAB9282D
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 at 14:11, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Mo, 2026-01-26 at 10:21 +0100, Vincent Guittot wrote:
> > s32g SoC family includes 2 serdes subsystems which are made of one PCIe
> > controller, 2 XPCS and one Phy. The Phy got 2 lanes that can be configure
> > to output PCIe lanes and/or SGMII.
> >
> > Implement PCIe phy support
> >
> > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> > Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> > Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Co-developed-by: Bogdan Roman <bogdan-gabriel.roman@nxp.com>
> > Signed-off-by: Bogdan Roman <bogdan-gabriel.roman@nxp.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/phy/freescale/Kconfig               |   9 +
> >  drivers/phy/freescale/Makefile              |   1 +
> >  drivers/phy/freescale/phy-nxp-s32g-serdes.c | 569 ++++++++++++++++++++
> >  3 files changed, 579 insertions(+)
> >  create mode 100644 drivers/phy/freescale/phy-nxp-s32g-serdes.c
> >
> [...]
> > diff --git a/drivers/phy/freescale/phy-nxp-s32g-serdes.c b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
> > new file mode 100644
> > index 000000000000..8336c868c8dc
> > --- /dev/null
> > +++ b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
> > @@ -0,0 +1,569 @@
> [...]
> > +static int s32g_serdes_get_ctrl_resources(struct platform_device *pdev, struct s32g_serdes *serdes)
> > +{
> [...]
> > +     ctrl->rst = devm_reset_control_get(dev, "serdes");
>
> Please use devm_reset_control_get_exclusive() directly.

Okay

>
> [...]
> > +static int s32g_serdes_get_pcie_resources(struct platform_device *pdev, struct s32g_serdes *serdes)
> > +{
> [...]
> > +     pcie->rst = devm_reset_control_get(dev, "pcie");
>
> Same here.
>
> regards
> Philipp

