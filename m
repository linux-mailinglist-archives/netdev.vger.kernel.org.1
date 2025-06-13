Return-Path: <netdev+bounces-197500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A00B0AD8D48
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E87189FE03
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413CA17A2F2;
	Fri, 13 Jun 2025 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l3Nq5Uxc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BDC156F5E
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821994; cv=none; b=hwH19q1dJXPo8ndpJkidEDwt5LqaY8y7MiNfWM0Mv+SVwIjMG7RNXKghtK6gLLrxW/nRqgikR9ijkeU5RULjaS2SkM818mnYrtrSiTkPJnnptI2u0qvry0rJS92drZV66+3D7QaQkjMM0TwVtLWFGjajdUqStY+DeBDojQ0DU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821994; c=relaxed/simple;
	bh=A3ISDuDGpv7xrA990LVx5fes7z9h1EyqhshsUSfLe78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdGLfFMva81vIEuG86/WsvCEg22chOnVfpL01VP3JqucnTeWTnTPNNL37p8xLShNlIuy6bYjxLeGs99dHH7txrtv8mlgiWOP6gDtV1TOmNjyavIJ2XzFlg9M18p5GxORz4Z6ltTDZuzPXTRZGeBU25QV9ucK3av/781IN6xnIp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l3Nq5Uxc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=lWbYeIMxBXKH3hU+a/NJ4RKlW0M+OeIlJxO6OukjuJo=; b=l3
	Nq5Uxc1owlqiHZEtCOYPN7m1pe8hev2QJVXxuq2kEJZkQ2HbeEnP14c3XSB5v5hKAhGu8yID3FOAl
	Lakw1pqgSgFp00ywoe3uIAaGm1gT4w5raUrTtQBd7xx++SNOD3x3It5wzndiX+To5Hzxt7QDOzZE+
	ZO2Z4i8jUMgzb8c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ4dK-00Fibg-Oq; Fri, 13 Jun 2025 15:39:50 +0200
Date: Fri, 13 Jun 2025 15:39:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Cc: netdev@vger.kernel.org
Subject: Re: [support request]: where should I register this (apparently not
 supported yet) transceiver?
Message-ID: <11c8694a-382c-4085-9e83-0a4fa4a362cb@lunn.ch>
References: <5568c38c-5c93-493a-96bd-b6537a4d1ad6@kabelmail.de>
 <da8834aa-da77-4633-ac6f-d2b738a97337@lunn.ch>
 <b6a4604e-55bd-4ab7-9cf2-05fb94e72500@kabelmail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6a4604e-55bd-4ab7-9cf2-05fb94e72500@kabelmail.de>

> Unfortunately, the result was not as I'd expect (on kernel 6.12.32):
> 
> > ... (booting kernel 6.12.32 with quirk) ...
> > [   37.832050] mtk_soc_eth 15100000.ethernet sfp-lan:
> validation with support 00,00000000,00000000,00000000 failed: -EINVAL
> > [   37.843056] sfp sfp2: sfp_add_phy failed: -EINVAL

So it probably cannot find the PHY.

> > ...
> 
> I tried the eepromfix of i2csfp:

Did you play with:

i2csfp I2CBUS rollball read|write DEVAD REGISTER [VALUE]

Try reading devad = 1, register = 2 and 3.

	Andrew

