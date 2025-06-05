Return-Path: <netdev+bounces-195331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA3ACF9BE
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 00:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0AA3AEA60
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 22:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E74127C875;
	Thu,  5 Jun 2025 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b+xeihlb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749817548
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749163142; cv=none; b=FNB9BpoDG+9xl5es47qkMlaWLApSlUZfLhmo80L2pLmatNd2KawGjKzPfB5gKDdtAtvgdmFxzdGrAGHB5Z67P1LiZCNMxXnhuVAy7OAnk5MCz2Jw/GG1pTj1hrJJyVPgTQtV6pOMeNynKTGA8ABj3gWGGyJUCu6WABeQP+IjKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749163142; c=relaxed/simple;
	bh=7VLMthzocv9QzesE1xMTYQ+3ye6jNrPeKzX3YCh1e9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+v9dzxSWItlQUP+J0CkDp0ltDK+n1oOVNE8aVKVEh/FQ80cZtgd2WDIOtfqQzPL4kgLLozFnd5ZYg+WvqfSDILG1mN0GT97Fell1x2DuxUA4c1YGxO0wmq45e1IS5EAjR8hTE6wMcYvKXJxlWuko3UGnhEuw5+saHJ+sVit3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=b+xeihlb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UuuvOlTAEUMd39bqca0XvxFyk0L15ywkAJHq3IS3CJo=; b=b+xeihlbE9zcKHQBgegoINhKaa
	LGE4676BElLGZCdnkwgksIYkmMaHr/YFzz7BCcxtrJsxNl9pvSvaOIbG4wtDYIIX+CbTBhP0H7wRZ
	zyLHEjGPGgAGs3LaoXlI3cbUqgqbicbRbAxUww4pYDMokHkBWewxMh8/a/KIfblhQI26uUtC/Eccc
	iyyfpTwymKXR3M/axpMb2aihC+7jiC1SH82T/8cs+3HBEaGGq1tCQQptRqce07lJ9faN13sg7mq36
	60XO5Z8MX5QgP1f89Y00kt3Bi18F6Qt4hAzFodvFiN96bXeX9mN0l32OgwH5VMrNOU1lxemmMBjpj
	VFMH9zIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58794)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uNJEb-00009Q-1a;
	Thu, 05 Jun 2025 23:38:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uNJEW-0002Xg-1i;
	Thu, 05 Jun 2025 23:38:48 +0100
Date: Thu, 5 Jun 2025 23:38:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID: <aEIceGDOnLsEeoo_@shell.armlinux.org.uk>
References: <20250605221730.398665-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605221730.398665-1-macroalpha82@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 05, 2025 at 05:17:30PM -0500, Chris Morgan wrote:
> +static void sfp_fixup_potron(struct sfp *sfp)
> +{
> +	/*
> +	 * The TX_FAULT and LOS pins on this device are used for serial
> +	 * communication, so ignore them. Additionally, provide extra
> +	 * time for this device to fully start up.
> +	 */
> +
> +	sfp_fixup_long_startup(sfp);
> +	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);

This should be calling sfp_fixup_ignore_tx_fault(), and possibly
sfp_fixup_ignore_los() as well if the module also reports incorrect
soft LOS state or doesn't support soft LOS state reporting.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

