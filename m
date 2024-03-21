Return-Path: <netdev+bounces-81081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B957E885B34
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD77F1C20FE8
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDBB8593F;
	Thu, 21 Mar 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5WaKaz9Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7F84FBC
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032937; cv=none; b=mjaYPiHYMEDhiIHe7NNmeKQWp4qixqiUb7jpPmTgfzJdzqtbzRpi6RGhnm+0HRfJJ/+eQXvqLL4Sv/kjRyjFaREzkIKVZsm/OAzJsnCTql2t0PKGPTi0h1hk9erPPdM1tVzr1n5pZV6njLZ+i5WLX7qImz+8kmw0FtIs/hwUoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032937; c=relaxed/simple;
	bh=uyahtdgdPkXVVOhSVN1WKtJkuacZaoYwK2ioxP4JXpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+y9O+K8qUfHYjEOEI7N/bgrp5OyNSNGQxT5Fs9lzrHq4DfbAjofopMLRoO5l5IP4Lt3Z45lUQvRJMF6OQixidL3JqSjgx9u1u+JwqF+W5IGz7sHk9abaqpfK2W1k4nfgQKyUOZE7zP0Fsi8gpWCmagT0ipfgVCQS+rQksDVFLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5WaKaz9Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yh8EYlQ4m/DKJg9xQn1MNNl+VoPTz84vXNwKBwO+qmo=; b=5W
	aKaz9QB/A5VD4jKhKGLBqDwNmi/2x6WJeqdR5lj5MXYwA9DniEpo5BaqYN031ogbM3m959mBnhHAt
	e5sNLJIJ3ZB4kLOmfLNRwqkhURMwSdaBmMnoD9jnk1/qtfHDaRT/jh6Hi+IzByR30143K1li4wlH4
	ZF0felBq0mdIvoM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnJpC-00Asq1-VR; Thu, 21 Mar 2024 15:55:22 +0100
Date: Thu, 21 Mar 2024 15:55:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Serge Semin <fancer.lancer@gmail.com>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <09698d20-7188-45ed-89c5-1161bd52f2b1@lunn.ch>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <027b4ee29d4d7c8a22d2f5c551f5c21ced3fb046.1706601050.git.siyanteng@loongson.cn>
 <ftqxjh67a7s4iprpiuw5xxmncj3bveezf5vust7cej3kowwcvj@m7nqrxq7oe2f>
 <d0e56c9b-9549-4061-8e44-2504b6b96897@loongson.cn>
 <466f138d-0baa-4a86-88af-c690105e650e@loongson.cn>
 <x6wwfvuzqpzfzstb3l5adp354z2buevo35advv7q347gnmo3zn@vfzwca5fafd3>
 <a9958d92-41da-4c3a-8c57-615158c3c8a2@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9958d92-41da-4c3a-8c57-615158c3c8a2@loongson.cn>

> Because the default return value of gnet's mdio is 0xffff, when scanning for
> phy,
> 
> if the return value is not 0, it will be assumed that the phy for that
> address exists.

That is not correct. The MDIO bus has a pull up on the data line. If
there is no device at a given address, that pull up results in 0xffff
being read. phylib understands this, it knows that a read with the
value of 0xffff probably means there is no device at that address. So
it will not create a device.

>  Not specifying an address will cause all addresses' phy to be detected, and
> the
> 
> lowest address' phy will be selected by default. so then, the network is
> unavailable.

Do you have multiple PHYs on the bus? If there is only one PHY the
first PHY should be the PHY you want, and phy_find_first() will do
what you need. However, if there are multiple PHYs on the bus, you
really should use a phandle in DT to point to the correct PHY.

       Andrew

