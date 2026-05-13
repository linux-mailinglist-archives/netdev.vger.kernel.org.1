Return-Path: <netdev+bounces-287693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFU0NDi1BGplNQIAu9opvQ
	(envelope-from <netdev+bounces-287693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11A538106
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B12DA300D4F2
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF5A4DBD89;
	Wed, 13 May 2026 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myb2qtmm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01C4DBD70
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693424; cv=pass; b=hsPN8CU2V26svfKz9mqg9dO6EEqlMsUP1K69LkOQAzKl8EM4TMnrNtrr64Fi5IWq/LR2wipPtGFYoqGU+kSGjf83IkObnRstA0+LByO9qAbNcNyFyjcGHJpEAhnyFrh1SOQQo+rlBMl8tkuk8yQfSMH1j4U99DMiT39v3F3s6r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693424; c=relaxed/simple;
	bh=JPLT6FMeldEbFhJ09K/mL4agPV0DXAvQaThe6y1REcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9oY64XKXDvvr0UJYY28qSp47EmLIrpo4mj8QG2QFWLeIkUVp/jNS/WqLQrSM/LdlNWOx6CKhCC49aPiR7UdratEQiLgLR1Jjq7iY5mDjGxh2HHrRMqf1fgsKc0bBb4iT8pF5l3p0ZZVPHoViix35el4pDbL56R5UtIFX9LFAiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Myb2qtmm; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso6975510eec.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778693422; cv=none;
        d=google.com; s=arc-20240605;
        b=RqD3ven437qasFTcT/911DI06exUT12rTWsoADqKFJC5KQvbGfDnuhNLqt6wLSduFQ
         szw4MBcopJtRwKS25wZ1GKYMwLUamoM/DljynlacPIfn94UTrsY7pvgY/fHSe+hsepzP
         kkTL+cbS8IrthuM5qEfXlPRDVWiO5/sesRFsPhyAmxwud9C+iSPOktYKck4jjuNgRTcY
         fqEzjjyHB/6AnWJ/xpD1jqNVuXypoGX6zmAUiqWnWmPe1quUVSnXIvPvABFyGtN+Ns4u
         LRDtaUG6ESqePj6f/mtmOlXTUXKNRGe26bb8d3sBTaP1MGr/TTTR5u31cYfnvpxepjnA
         ntrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YDUAur+XoWH6JFWlom4UBKGDg0H33xYVizwbBkMvANo=;
        fh=uwZhCECqQ80txhrhvzZXN5Yo4JWJDWnrNWCn00CM7kQ=;
        b=R4UAFUB4mSv5ik3cECyoigwmmkhwF8scQkPcFpoA9Y/NbXnaeXXk2+VlvM8EFjJATN
         BfkUIcx/wxnxrx058b+4NlD+XV3GyfNN89TquenFnZrVnsSDEj8UM3FK395B8CrIeq8T
         JoeJHXg7C+B9AnXZpTXFWumD45HZv3nWSS1rUYIdogLjWQ9sp7IoG9Sh5ZF6wMARF1Cu
         DszFuvcb3n4esPfjgL7K4lbjYeXWOUFCKamGZIXUetmpQcmESBQCUvNi6P0Ax8dKtta0
         YDo3Kn4K7CWGHkuI0HqMHuJE50W94bbeHJUvZlU2wI/qidVlKcj5Th0gCUgHgC1zfTIm
         iPSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778693422; x=1779298222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDUAur+XoWH6JFWlom4UBKGDg0H33xYVizwbBkMvANo=;
        b=Myb2qtmmEWFHOlXmcUwS8JtGLmsuI7inrmcQU+iPTH42mxnoa1ZxH9YLyLmmoPoVac
         pTB+UbXzRJ9vMcAYAcvh7XMp8mWMm+QAX6m2+HZKbXJk6pSNXB1rA5D5HpHpvI+XMj3Q
         /Ai7ZLztC6F9LvQUrKNwk11s+jjCqsWpuddo0O+K4vlBS0xLHZu1b4/I9yK8Aj6Hqey2
         94SKVCluyhtdUv0ezOIkw9yj+cGUpOrs9Zrp3Ut8bo05fMomAOF9qoBpaujprOYUMmtp
         gI+KIN9inWDtqC9bxQKllgKE0p7uf9EoUCakd48EApwwOBJCCplAWHdiRy/GNfgsk5wd
         7jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693422; x=1779298222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YDUAur+XoWH6JFWlom4UBKGDg0H33xYVizwbBkMvANo=;
        b=l+UUEoQcRhf/1LOH0rlqqCpG8d2HZXbxGPdmfs5MhyeCD3aoBLkI+XsO2Bxxd+LShd
         9W9Ag0jzKHZXNNmgTGBvtdrCKiJEpguNO04WXOHEml8x+4oDvlLvOkjYxcagTMZJQQwj
         B79J25mVovp3VBVhna+MZCf8hMsIhvyRRxAW3vqIDmtkFkk+lCCWZpevlHDc6AMk7eqE
         OrrSD4tUqSr7421B7qUUpgO5xkQ4ywgfJpQka+SXhalxPoNvhw9jUYw2t3qxgppJLx4i
         QmqaKPbHttfQL32SKYUfymH0cexeBv4x0aztf8IwrPXuYRb3BEg5il32pl/gZKwIYwJI
         C8KA==
X-Forwarded-Encrypted: i=1; AFNElJ/kGRSBpwzQLo0Nv/UzGvi4am6pZmq56fDDa50OlWmdg/EnRBvrUE/2jmGPgVBKmlnVt8oxqZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHGWjmy1f2CmMzBkX+By4nzT7YkUHa/F5tkRHOsx5yJoMB0MF
	ncnPCT+AVn7eeTHQ6aSYv4yrODitM3ApEZLjisgyaXV2Rf1aaSzKb+MZMGJTfqDTZEIRcLnD82J
	WCoskeuhjFS5CuFAT5OUyYu0Ka98FGtI=
X-Gm-Gg: Acq92OECt9nhdHZ9BN1HXyWbQoCzJBNM2YwmmVNTJNhjuBiRvSZSSuuF4spnpKSHRE2
	OzUi/fSa38dzEBBQm1oc7WQDf6fOSvvYeDyqBV0qzX9tQDOLHdnQDnEHA8BOHeiMrbg7BNOLULu
	9vqiuaM/f2c+B8ya0Pb//yxqNO4drAyM0SV8K5yd0gCkOIVPsW7JeP/NbQ0Hk4SEvA1noahmMeE
	gaO8bjBxNc2WCa8qaX5W/8YO0mT5IlktpeohP9a5yeuueMFJRKWrY1L6MjLlrMEtLVktcsCZ2GL
	48e1SQvGKqC4sROxq4Q=
X-Received: by 2002:a05:693c:2b08:b0:2f3:c3d4:382f with SMTP id
 5a478bee46e88-301181aa331mr2513866eec.8.1778693422110; Wed, 13 May 2026
 10:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511135703.62470-1-clamor95@gmail.com> <20260511135703.62470-3-clamor95@gmail.com>
 <agJ/T8nBGWEoblmd@nchen-desktop> <CAPVz0n173syW9rXy7Qt_N=mChe6WBRLvjRDypcJEC50hPL4OMQ@mail.gmail.com>
 <agLb6mgP45jHjvNt@nchen-desktop>
In-Reply-To: <agLb6mgP45jHjvNt@nchen-desktop>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 13 May 2026 20:30:10 +0300
X-Gm-Features: AVHnY4LbEcLazP490SpFW2HazY7KluRMMma2mmpgzBcW68oL5O3KVQGdtgY1RmI
Message-ID: <CAPVz0n2yGALm1Z0j0j6_MaqAOZGL+a8EgCWYQpW0QN1YVf96EQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] usb: chipidea: tegra: Avoid controller/PHY init if
 bus is externally controlled
To: "Peter Chen (CIX)" <peter.chen@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BB11A538106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287693-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

=D0=B2=D1=82, 12 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 10:5=
1 Peter Chen (CIX) <peter.chen@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 26-05-12 09:13:40, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 12 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
04:16 Peter Chen (CIX) <peter.chen@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On 26-05-11 16:56:57, Svyatoslav Ryhel wrote:
> > > > If the USB controller and PHY are externally controlled, then the
> > > > registration of the controller and the PHY initialization should be
> > > > skipped, since these configurations must be done by the device that
> > > > controls the bus to work correctly.
> > > >
> > >
> > > I find you only control USB controller device add at PHY driver, most=
 of USB drivers
> > > has PHY control, for chipidea, it has PHY control at core.c, would pl=
ease try to
> > > adapt for it?
> > >
> >
> > Usually yes, but this is not the case for Tegra unfortunately. As you
> > can see Tegra specific section of Chipidea driver specifically
> > describes why it has to set PHY manually.
> >
> > /*
> >  * USB controller registers shouldn't be touched before PHY is
> >  * initialized, otherwise CPU will hang because clocks are gated.
> >  * PHY driver controls gating of internal USB clocks on Tegra.
> >  */
> >
> > So in order to provide correct work of USB when set by an external
> > device, both PHY and controller init/add must be skipped.
>
> You could call generic PHY APIs at ci_hdrc_tegra.c, after PHY init or pow=
er on,
> call controller initialization.
>

I was tinkering with Chipidea driver for Tegra a bit. If you meant to
use flag only to control usb controller device init and leave PHY to
be handled by controller, then yes, that is possible and that is
better approach.

> >
> > > Peter
> > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/usb/chipidea/ci_hdrc_tegra.c | 36 +++++++++++++++++-------=
----
> > > >  1 file changed, 22 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chi=
pidea/ci_hdrc_tegra.c
> > > > index 372788f0f970..593390a818d1 100644
> > > > --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> > > > +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> > > > @@ -32,6 +32,7 @@ struct tegra_usb {
> > > >       struct clk *clk;
> > > >
> > > >       bool needs_double_reset;
> > > > +     bool externally_controlled;
> > > >  };
> > > >
> > > >  struct tegra_usb_soc_info {
> > > > @@ -312,20 +313,25 @@ static int tegra_usb_probe(struct platform_de=
vice *pdev)
> > > >       if (device_property_present(&pdev->dev, "nvidia,needs-double-=
reset"))
> > > >               usb->needs_double_reset =3D true;
> > > >
> > > > +     if (device_property_present(&pdev->dev, "nvidia,external-cont=
rol"))
> > > > +             usb->externally_controlled =3D true;
> > > > +
> > > >       err =3D tegra_usb_reset_controller(&pdev->dev);
> > > >       if (err) {
> > > >               dev_err_probe(&pdev->dev, err, "failed to reset contr=
oller");
> > > >               goto fail_power_off;
> > > >       }
> > > >
> > > > -     /*
> > > > -      * USB controller registers shouldn't be touched before PHY i=
s
> > > > -      * initialized, otherwise CPU will hang because clocks are ga=
ted.
> > > > -      * PHY driver controls gating of internal USB clocks on Tegra=
.
> > > > -      */
> > > > -     err =3D usb_phy_init(usb->phy);
> > > > -     if (err)
> > > > -             goto fail_power_off;
> > > > +     if (!usb->externally_controlled) {
> > > > +             /*
> > > > +              * USB controller registers shouldn't be touched befo=
re PHY is
> > > > +              * initialized, otherwise CPU will hang because clock=
s are gated.
> > > > +              * PHY driver controls gating of internal USB clocks =
on Tegra.
> > > > +              */
> > > > +             err =3D usb_phy_init(usb->phy);
> > > > +             if (err)
> > > > +                     goto fail_power_off;
> > > > +     }
> > > >
> > > >       /* setup and register ChipIdea HDRC device */
> > > >       usb->soc =3D soc;
> > > > @@ -342,12 +348,14 @@ static int tegra_usb_probe(struct platform_de=
vice *pdev)
> > > >       if (of_usb_get_phy_mode(pdev->dev.of_node) =3D=3D USBPHY_INTE=
RFACE_MODE_ULPI)
> > > >               usb->data.flags &=3D ~CI_HDRC_SUPPORTS_RUNTIME_PM;
> > > >
> > > > -     usb->dev =3D ci_hdrc_add_device(&pdev->dev, pdev->resource,
> > > > -                                   pdev->num_resources, &usb->data=
);
> > > > -     if (IS_ERR(usb->dev)) {
> > > > -             err =3D dev_err_probe(&pdev->dev, PTR_ERR(usb->dev),
> > > > -                                 "failed to add HDRC device");
> > > > -             goto phy_shutdown;
> > > > +     if (!usb->externally_controlled) {
> > > > +             usb->dev =3D ci_hdrc_add_device(&pdev->dev, pdev->res=
ource,
> > > > +                                           pdev->num_resources, &u=
sb->data);
> > > > +             if (IS_ERR(usb->dev)) {
> > > > +                     err =3D dev_err_probe(&pdev->dev, PTR_ERR(usb=
->dev),
> > > > +                                         "failed to add HDRC devic=
e");
> > > > +                     goto phy_shutdown;
> > > > +             }
> > > >       }
> > > >
> > > >       return 0;
> > > > --
> > > > 2.51.0
> > > >
> > >
> > > --
> > >
> > > Best regards,
> > > Peter
>
> --
>
> Best regards,
> Peter

