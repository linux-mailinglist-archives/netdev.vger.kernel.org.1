Return-Path: <netdev+bounces-130436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842E198A846
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE001F2407A
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED31922DF;
	Mon, 30 Sep 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vEyC6rgf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D91922D5
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709253; cv=none; b=pZehqGSGBFCGV5TGaKybkZIUOucJMpksBbWAB7LABtsi0VjskjIva1fGLSKTqWd2vrKKJu3p9YbXlQtvQAUckulTmgd12o1LRGNaNhKwXvGM2e9X9W3q8v51hgtjnHftF6zL0lF6jF5BJCeVW4zN9ITBzJ+DwNtEDfcmqHBgc5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709253; c=relaxed/simple;
	bh=owsDEQ+VqwnDbFFP85sAPAnVkml6uirbiPbWm/FIa70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLdqcldYibRBMnMwND70UBCKykfjvSoS1Jma8ZRJ2KhERvGml2M3BvqrRPSCo6tbnV3h0ayEFU9tpUXhR3nczPAPoiDPtWcDR1aCDFVLqt6eV7QqCKT4torYcq4YXpc9Dt/wxUAGnNUqB+hXrVfPeX25Y8rCestdrjuwuh0L1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vEyC6rgf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0b7Nd0J1DV9+ONt5HCFd0zUuk5hBej+xBMATgI/jjQk=; b=vEyC6rgfwaXuffiWvbVTMMwe6r
	dSi8mt66WL4kG3jLc/0QBPq9Fo8E+Z0dcTsCBtpFdXQsrrNKv0mfmEglKAt4UHobSEDCEfiKj7lSx
	Rn18t6ESpimLOWZQ6NuiW+soXW8DKQr1yTDa0q2MzKuZylg7yyyc0GWXMZTdV+wIy/38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svI6D-008dRW-Dx; Mon, 30 Sep 2024 17:14:09 +0200
Date: Mon, 30 Sep 2024 17:14:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
Subject: Re: [PATCH net 1/3] net: dsa: mv88e6xxx: group cycle counter
 coefficients
Message-ID: <707b4ebc-c1ce-48a3-93c0-cebff9feef37@lunn.ch>
References: <20240929101949.723658-1-me@shenghaoyang.info>
 <20240929101949.723658-2-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929101949.723658-2-me@shenghaoyang.info>

> -#define MV88E6250_CC_SHIFT	28
> -#define MV88E6250_CC_MULT	(10 << MV88E6250_CC_SHIFT)
> -#define MV88E6250_CC_MULT_NUM	(1 << 7)
> -#define MV88E6250_CC_MULT_DEM	3125ULL
> +const struct mv88e6xxx_cc_coeffs mv88e6250_cc_coeffs = {
> +	.cc_shift = 28,
> +	.cc_mult = 10 << 28,

This is slightly less readable, you loose that the 28 is the same as
cc_shift. I would suggest you keep the MV88E6250_CC_SHIFT and use it
for these two lines. Please do the same for other instances of this
structure.

	Andrew

