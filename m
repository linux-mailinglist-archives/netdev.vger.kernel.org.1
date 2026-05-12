Return-Path: <netdev+bounces-286989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPzXCvXbAmrJyAEAu9opvQ
	(envelope-from <netdev+bounces-286989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:51:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF3D51C339
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 130CD3004609
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F0C47D956;
	Tue, 12 May 2026 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMRWmgM4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B036F8FE;
	Tue, 12 May 2026 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572273; cv=none; b=kOQV6q2ro5mBYZRwyGQmz7Malox1h6/3IZzu4mRkzdks0+JGFAkVQAm0LK9/CV2NvGL5lI8qsn7mFRhe2V4RgYbteJdjoW8lJF9pDdoLXZLEU0HBmC/64ACzoQIaqgVPltn7ot8s4QgmEEjKxy0o7mguWutQmnvH3dTcNlpCVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572273; c=relaxed/simple;
	bh=GIepLcHTJURrppAg6CpDxGEX4YxETo5qs9bcQX5fU9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u44eE8QhFCPwW53v23n801epTQCOEGrngMp1x6Ta3FhJcLAuWg+Ty6sb9FbmaSAKIvb5wmAvIW+eUScayf6AQOV3io0K19hrT7120WLzfSppXkxAaRPhXYpB+QMd573nyIWQvHhX3gFGwgNo2SNsQ/gbzRAYFvuPiXrq/U7ttJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMRWmgM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD63C2BCB0;
	Tue, 12 May 2026 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778572272;
	bh=GIepLcHTJURrppAg6CpDxGEX4YxETo5qs9bcQX5fU9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMRWmgM4TFh1Xb+dEKyEYsgBNhVzaPuDSi4CMld9Xc58a83X1lERve1GKOFKGOOlM
	 lclh2p1Cyp8UHep/JRikDLFtYAaIAhEN7MNNF83RuNj9VBxa9HjoL15dC8LHgiCRn6
	 POYYwA4NSblSpzS/bS6hJXZ6BiLJtrA6jBokTNtCmwsYv5X8ECFQ/JBJQ1YmrBiydz
	 ZUNaDzq5IjjKeDXyHNHVfFLbR3H79rYP8H/ra8KNgDugQY3Llud74XWQlfODlcpIPR
	 She2M/Sh1Vldu+LE7kVEn7mjEhO5kBfQ1wU0sCWhqwM24nkczmqARGsHYqrLcq2mgA
	 aBEaFoIQFA8Aw==
Date: Tue, 12 May 2026 15:51:06 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 2/6] usb: chipidea: tegra: Avoid controller/PHY init
 if bus is externally controlled
Message-ID: <agLb6mgP45jHjvNt@nchen-desktop>
References: <20260511135703.62470-1-clamor95@gmail.com>
 <20260511135703.62470-3-clamor95@gmail.com>
 <agJ/T8nBGWEoblmd@nchen-desktop>
 <CAPVz0n173syW9rXy7Qt_N=mChe6WBRLvjRDypcJEC50hPL4OMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n173syW9rXy7Qt_N=mChe6WBRLvjRDypcJEC50hPL4OMQ@mail.gmail.com>
X-Rspamd-Queue-Id: BAF3D51C339
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286989-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.chen@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 26-05-12 09:13:40, Svyatoslav Ryhel wrote:
> вт, 12 трав. 2026 р. о 04:16 Peter Chen (CIX) <peter.chen@kernel.org> пише:
> >
> > On 26-05-11 16:56:57, Svyatoslav Ryhel wrote:
> > > If the USB controller and PHY are externally controlled, then the
> > > registration of the controller and the PHY initialization should be
> > > skipped, since these configurations must be done by the device that
> > > controls the bus to work correctly.
> > >
> >
> > I find you only control USB controller device add at PHY driver, most of USB drivers
> > has PHY control, for chipidea, it has PHY control at core.c, would please try to
> > adapt for it?
> >
> 
> Usually yes, but this is not the case for Tegra unfortunately. As you
> can see Tegra specific section of Chipidea driver specifically
> describes why it has to set PHY manually.
> 
> /*
>  * USB controller registers shouldn't be touched before PHY is
>  * initialized, otherwise CPU will hang because clocks are gated.
>  * PHY driver controls gating of internal USB clocks on Tegra.
>  */
> 
> So in order to provide correct work of USB when set by an external
> device, both PHY and controller init/add must be skipped.

You could call generic PHY APIs at ci_hdrc_tegra.c, after PHY init or power on,
call controller initialization.

> 
> > Peter
> >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/usb/chipidea/ci_hdrc_tegra.c | 36 +++++++++++++++++-----------
> > >  1 file changed, 22 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
> > > index 372788f0f970..593390a818d1 100644
> > > --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> > > +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> > > @@ -32,6 +32,7 @@ struct tegra_usb {
> > >       struct clk *clk;
> > >
> > >       bool needs_double_reset;
> > > +     bool externally_controlled;
> > >  };
> > >
> > >  struct tegra_usb_soc_info {
> > > @@ -312,20 +313,25 @@ static int tegra_usb_probe(struct platform_device *pdev)
> > >       if (device_property_present(&pdev->dev, "nvidia,needs-double-reset"))
> > >               usb->needs_double_reset = true;
> > >
> > > +     if (device_property_present(&pdev->dev, "nvidia,external-control"))
> > > +             usb->externally_controlled = true;
> > > +
> > >       err = tegra_usb_reset_controller(&pdev->dev);
> > >       if (err) {
> > >               dev_err_probe(&pdev->dev, err, "failed to reset controller");
> > >               goto fail_power_off;
> > >       }
> > >
> > > -     /*
> > > -      * USB controller registers shouldn't be touched before PHY is
> > > -      * initialized, otherwise CPU will hang because clocks are gated.
> > > -      * PHY driver controls gating of internal USB clocks on Tegra.
> > > -      */
> > > -     err = usb_phy_init(usb->phy);
> > > -     if (err)
> > > -             goto fail_power_off;
> > > +     if (!usb->externally_controlled) {
> > > +             /*
> > > +              * USB controller registers shouldn't be touched before PHY is
> > > +              * initialized, otherwise CPU will hang because clocks are gated.
> > > +              * PHY driver controls gating of internal USB clocks on Tegra.
> > > +              */
> > > +             err = usb_phy_init(usb->phy);
> > > +             if (err)
> > > +                     goto fail_power_off;
> > > +     }
> > >
> > >       /* setup and register ChipIdea HDRC device */
> > >       usb->soc = soc;
> > > @@ -342,12 +348,14 @@ static int tegra_usb_probe(struct platform_device *pdev)
> > >       if (of_usb_get_phy_mode(pdev->dev.of_node) == USBPHY_INTERFACE_MODE_ULPI)
> > >               usb->data.flags &= ~CI_HDRC_SUPPORTS_RUNTIME_PM;
> > >
> > > -     usb->dev = ci_hdrc_add_device(&pdev->dev, pdev->resource,
> > > -                                   pdev->num_resources, &usb->data);
> > > -     if (IS_ERR(usb->dev)) {
> > > -             err = dev_err_probe(&pdev->dev, PTR_ERR(usb->dev),
> > > -                                 "failed to add HDRC device");
> > > -             goto phy_shutdown;
> > > +     if (!usb->externally_controlled) {
> > > +             usb->dev = ci_hdrc_add_device(&pdev->dev, pdev->resource,
> > > +                                           pdev->num_resources, &usb->data);
> > > +             if (IS_ERR(usb->dev)) {
> > > +                     err = dev_err_probe(&pdev->dev, PTR_ERR(usb->dev),
> > > +                                         "failed to add HDRC device");
> > > +                     goto phy_shutdown;
> > > +             }
> > >       }
> > >
> > >       return 0;
> > > --
> > > 2.51.0
> > >
> >
> > --
> >
> > Best regards,
> > Peter

-- 

Best regards,
Peter

