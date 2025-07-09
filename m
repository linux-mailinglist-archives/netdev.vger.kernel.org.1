Return-Path: <netdev+bounces-205431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C3BAFEA6A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05846541C02
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9072DECB4;
	Wed,  9 Jul 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NGPhZo9C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451BB292B59;
	Wed,  9 Jul 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068328; cv=none; b=i7pOY9Cuj5oSI8kdK2sp4tXnOoiR+/3BO0EmKDkqx05QeOqYi15nKE8o7s3FQNoSiV8qQElad+tZ+l5MbhxeRMY/H2SK4D9i6QZaWd4q9qwnShCHB8l6JBM/2RUjHuLqQZhYwGvM+EHt8t1gwte4GX3+KSlzp+F8LNGUStq2ESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068328; c=relaxed/simple;
	bh=/qahDK0IYUkKuGYysnJtX6MM8jLq9TOrhizk1MDBSKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chiV8KWFeqXBQVs4rRTrqPswhq9UwDwZTHraAe0U4QbfwSuafP5BD/5gSYSW6wvOg44NYkMEVFMor7iOLtJpsEsPH0ymaAga2N1HJ1yhJC5NNGZ3ianiREIozt84B1u3Bgvmf606yAzGdXZ4cw0Wr04nLu4enbxr8FiajTg2ODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NGPhZo9C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=uFbfUiyAkr+pHnWKgq1GAWpjjH62LzZxy6ER26rGetM=; b=NG
	PhZo9CF4z4CpWDVEOHzB6oY6vZFa5iJcnr2bewWpoSuvF9DTdsIJCeFkAzoPBip8OIhfbpLnJc0Q2
	jD+bB9Z2dpYh2x9jSjGxfQybQX98CiMyMIxdeGd4dSCS5Zvkz64c15E34L2B8h8MWgvzfo5lfYh0M
	GdouP+ZDXRmIayg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZV0X-000wiG-7F; Wed, 09 Jul 2025 15:38:45 +0200
Date: Wed, 9 Jul 2025 15:38:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 2/3] net: mdiobus: release reset_gpio in
 mdiobus_unregister_device()
Message-ID: <595b48b4-b830-411c-9cba-fcc3e8cf53a0@lunn.ch>
References: <20250709133222.48802-1-buday.csaba@prolan.hu>
 <20250709133222.48802-3-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709133222.48802-3-buday.csaba@prolan.hu>

On Wed, Jul 09, 2025 at 03:32:21PM +0200, Buday Csaba wrote:
> reset_gpio is claimed in mdiobus_register_device(), but it is not
> released in mdiobus_unregister_device().
> When a device uses the reset_gpio property, it becomes impossible
> to unregister it and register it again, because the GPIO remains
> claimed.
> This patch resolves that issue.
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> Cc: Csókás Bence <csokas.bence@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

