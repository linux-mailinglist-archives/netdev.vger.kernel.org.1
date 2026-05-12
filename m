Return-Path: <netdev+bounces-286963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULntOk/FAmp7wQEAu9opvQ
	(envelope-from <netdev+bounces-286963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:14:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA051ACA7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2C12301BEFF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE034DB572;
	Tue, 12 May 2026 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6JVSg17"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551EB466B7B
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566451; cv=pass; b=TVYouy0TsRJNAHE75ftqch2KP9VJoPZAiCI/UKeDimmffKqA2cMfUlmLKS1vjcQBlcNZTZjRGDS8LFE/RI8SgNgxqRacoqPEc1m6gB5ptEXodSoV1D6SP5NbFFQ9NfqBVwIXXAJvZNfU++H8ZcSgULoIg7utNm7h4DLniyuShHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566451; c=relaxed/simple;
	bh=3ld4zdEky9JiorADEB2JzKLMGmxL8CZq09SENbVMLTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV+ff5j1E6E6XxrCJ6fmzfhFIP+nNEH56bybA3wV8Lee/DJUHa9C1fHj7qZ45aYUXszj8uj+f8ISH0eAd/gJc/K1857nwUqDtDvfDhuge97jWYuwhhZAlLlqm6z1PwaYW/TBEhDQST3TIblRbNjFM7qpuBdFMkXHgSs4ZPwRQp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6JVSg17; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso5029023eec.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 23:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778566432; cv=none;
        d=google.com; s=arc-20240605;
        b=Im9Nfil3ro42dm+E1qqRsk7X+x28Wo/TJHG/gsA8sKadBbO9cU94SUebxwTlr7uljs
         su5H3HU9IZ2kZrVQw5Gq3SK1gN9jEY1l6VhptSWos6aa6notoDCgxWr5qgMTKXE9gExK
         F8W/uds1ws9EZa+LuxLd54gUSF1vTdtOZjBLrT3rCxB6aabkURI9ZzLrFgsZI3rU/kxz
         GAG3l5ScD9HgsP1tRmvX8R9fjTQSSNLR7q1o4rB0rj6XBGB3hHTEifQpR0vaD98Jb1L7
         XOP5OK/1Xcxb4ahOVz9AAdkNVKQb/Kx2vpTvvDYhPSWTOPipQZby3f7fqKSpGDflAE9m
         5lRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yr8QRs98bsPiw0gF0kGFiK+9h78W1fGBBJoeOfjYUCc=;
        fh=qPEqS4BSwf51rIS3IyMvSEEevLOBlTnzkOG1uJdli5M=;
        b=WLi80ciTnbYJp576l7MMxMFIVCDsxFwcYsMPWE21Nfx/ApBHCJ+6NID6mkRBGSzfF8
         6ytkHX27JEOhPoZ6/MxmdBbU5e/smzcdExWbSINw6Yy8l47eJJnUFqkQharKQll5DzYU
         G7znkHhALCTlacu7pZeuywMmHpN4oH4FoNa4oZO2RHOy2LA1RX4k0kdOG2q3X/VOPfVz
         nsZDc7oKOPS6S52DeE59PrHTrkmSH9zY4guL42r50qY8FZa07LO1faULcVxAowfSPhXI
         K/u9J7j/Q0TkXpT7KttGlIg/nfGizLeFzYd/54jPb0dPhYHpg8UD6lQxb/PzznQJ9Bqf
         jPGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778566432; x=1779171232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr8QRs98bsPiw0gF0kGFiK+9h78W1fGBBJoeOfjYUCc=;
        b=P6JVSg17mfG3AE++SHupyqKkJLaPPzom6Hym1yhnh9DOVxBji9AnJ3hls5QLmWd2TG
         ULq6zRBIkTtCCKHl/RGgKcP3NwzPXDUGKuv3j9xOZ8IVvN7cTQQtKwh1xBmkhS8Ip/dI
         gwUXG/gIKMWiY/1fAKKkeyuc5gMhyUcg18cf0fLz4gsWYuyey29l/rgRHUkaqPujaeyM
         aTmavwGzzsnO71xErdMSJdx5/+ZnQ5bp+9d/1ZzFEsd8MYd3HdaAOrZhEBJa7d0v7i7+
         vNVEUMU3/83mySnyyEUsL1VgvgozYrJEg2+UG0n2xUEJj733OO0F0x7ngpNZ12iyOWIL
         JZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778566432; x=1779171232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yr8QRs98bsPiw0gF0kGFiK+9h78W1fGBBJoeOfjYUCc=;
        b=JxAV6hX6giKpDt0TryNIVs4OSA330CcAnGNb3sZLI8t4RNqpLMd3sdsCEEsSy7jxJU
         Ent8jTMHMisxkRhJ6zlJDFLyvQs23Je9KAgUfDfHGlnNnxU89hrLAvzKaKtRq8092lKR
         x/ScCjim5qXl2a978RTk668fqBn5L90Xpw0dHMyoIrTYP7TcXW7lHhUPzsis6EvV4u4K
         vPcUNicmNi0Lvxdqs4xs/nS1xL/nDORFW6GYt3R8k4RkMBbuRoEUMAg1O68e7ItBoqhH
         kegWK5dUDn2Q9CIIrcRVqoauf5Cl9TYqorcsCVuOQpd84RmGNkkrVxZjLHce+6SPN0nD
         QZXg==
X-Forwarded-Encrypted: i=1; AFNElJ//sZbjyJfvYH8GBvE7gC3TddEWbWhbuGoc6MIi5lRkNV1S9RSskTV3EmdcjQHsVqZ2aR/LY0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwloqgMMQUQOHRMQSRleT7G2j5frHlBqE+81d4c/kHfDOx+fIKj
	SeHU9DYZ+QSIsetjL05EKplyKiAFyGKHnZaUddwM6/EB/1+2W97gzdDc3g4a8yRBK8wIMQu79tL
	6JdcVMzAG8q3f1RRg3VVcnSgI4GwBC2U=
X-Gm-Gg: Acq92OHhp4QZWuP1JkJbWF1y9NUJ0S1Zk0An75x+uAJHok1XGDccMfF3l2Ply1ZeKg+
	UV+zRRXOgJg0MkVFAOobAAAqRRh+VfUoz1BbYNcS8W9jzK6yGEaeR8LnyQBBsL8UzzgIUAEb3kD
	O2I1b3Y47o93adpbGGsuVwx7F1xVVsEYr1W6OWQRIOYXfriQ0m2hC2RhlIWLZ3blaH4nnPgVSHJ
	7g6mQfEzDoV6pCB/lWitr7vS9TK+r7qLN041ce3VpY9ATA7H+eBfASi5zTZAel4zn6h2zcH8JBt
	VSo4m5rM
X-Received: by 2002:a05:7301:7213:b0:2e2:4979:ec7 with SMTP id
 5a478bee46e88-2fb4bff2949mr6162640eec.10.1778566431760; Mon, 11 May 2026
 23:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511135703.62470-1-clamor95@gmail.com> <20260511135703.62470-3-clamor95@gmail.com>
 <agJ/T8nBGWEoblmd@nchen-desktop>
In-Reply-To: <agJ/T8nBGWEoblmd@nchen-desktop>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 12 May 2026 09:13:40 +0300
X-Gm-Features: AVHnY4L1_bWZXCrp3MmGLMUWBEn-sMyg9m87GKXzm_vHqR-lTAFW3X_ZqIO7y3g
Message-ID: <CAPVz0n173syW9rXy7Qt_N=mChe6WBRLvjRDypcJEC50hPL4OMQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: 80AA051ACA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286963-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

=D0=B2=D1=82, 12 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 04:1=
6 Peter Chen (CIX) <peter.chen@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 26-05-11 16:56:57, Svyatoslav Ryhel wrote:
> > If the USB controller and PHY are externally controlled, then the
> > registration of the controller and the PHY initialization should be
> > skipped, since these configurations must be done by the device that
> > controls the bus to work correctly.
> >
>
> I find you only control USB controller device add at PHY driver, most of =
USB drivers
> has PHY control, for chipidea, it has PHY control at core.c, would please=
 try to
> adapt for it?
>

Usually yes, but this is not the case for Tegra unfortunately. As you
can see Tegra specific section of Chipidea driver specifically
describes why it has to set PHY manually.

/*
 * USB controller registers shouldn't be touched before PHY is
 * initialized, otherwise CPU will hang because clocks are gated.
 * PHY driver controls gating of internal USB clocks on Tegra.
 */

So in order to provide correct work of USB when set by an external
device, both PHY and controller init/add must be skipped.

> Peter
>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_tegra.c | 36 +++++++++++++++++-----------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipide=
a/ci_hdrc_tegra.c
> > index 372788f0f970..593390a818d1 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> > @@ -32,6 +32,7 @@ struct tegra_usb {
> >       struct clk *clk;
> >
> >       bool needs_double_reset;
> > +     bool externally_controlled;
> >  };
> >
> >  struct tegra_usb_soc_info {
> > @@ -312,20 +313,25 @@ static int tegra_usb_probe(struct platform_device=
 *pdev)
> >       if (device_property_present(&pdev->dev, "nvidia,needs-double-rese=
t"))
> >               usb->needs_double_reset =3D true;
> >
> > +     if (device_property_present(&pdev->dev, "nvidia,external-control"=
))
> > +             usb->externally_controlled =3D true;
> > +
> >       err =3D tegra_usb_reset_controller(&pdev->dev);
> >       if (err) {
> >               dev_err_probe(&pdev->dev, err, "failed to reset controlle=
r");
> >               goto fail_power_off;
> >       }
> >
> > -     /*
> > -      * USB controller registers shouldn't be touched before PHY is
> > -      * initialized, otherwise CPU will hang because clocks are gated.
> > -      * PHY driver controls gating of internal USB clocks on Tegra.
> > -      */
> > -     err =3D usb_phy_init(usb->phy);
> > -     if (err)
> > -             goto fail_power_off;
> > +     if (!usb->externally_controlled) {
> > +             /*
> > +              * USB controller registers shouldn't be touched before P=
HY is
> > +              * initialized, otherwise CPU will hang because clocks ar=
e gated.
> > +              * PHY driver controls gating of internal USB clocks on T=
egra.
> > +              */
> > +             err =3D usb_phy_init(usb->phy);
> > +             if (err)
> > +                     goto fail_power_off;
> > +     }
> >
> >       /* setup and register ChipIdea HDRC device */
> >       usb->soc =3D soc;
> > @@ -342,12 +348,14 @@ static int tegra_usb_probe(struct platform_device=
 *pdev)
> >       if (of_usb_get_phy_mode(pdev->dev.of_node) =3D=3D USBPHY_INTERFAC=
E_MODE_ULPI)
> >               usb->data.flags &=3D ~CI_HDRC_SUPPORTS_RUNTIME_PM;
> >
> > -     usb->dev =3D ci_hdrc_add_device(&pdev->dev, pdev->resource,
> > -                                   pdev->num_resources, &usb->data);
> > -     if (IS_ERR(usb->dev)) {
> > -             err =3D dev_err_probe(&pdev->dev, PTR_ERR(usb->dev),
> > -                                 "failed to add HDRC device");
> > -             goto phy_shutdown;
> > +     if (!usb->externally_controlled) {
> > +             usb->dev =3D ci_hdrc_add_device(&pdev->dev, pdev->resourc=
e,
> > +                                           pdev->num_resources, &usb->=
data);
> > +             if (IS_ERR(usb->dev)) {
> > +                     err =3D dev_err_probe(&pdev->dev, PTR_ERR(usb->de=
v),
> > +                                         "failed to add HDRC device");
> > +                     goto phy_shutdown;
> > +             }
> >       }
> >
> >       return 0;
> > --
> > 2.51.0
> >
>
> --
>
> Best regards,
> Peter

