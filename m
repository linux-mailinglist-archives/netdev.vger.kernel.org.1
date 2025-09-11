Return-Path: <netdev+bounces-222304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F323B53CFC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F770585CB3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE82727F8;
	Thu, 11 Sep 2025 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DDAQHXB+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ECB29405
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621698; cv=none; b=Vu1XUioO6aTMjzvfw9/9bn1NPVfudQvjG/Jcu+k5ImgYZzaKV1sfEaQ4/gPwXHUtwiFfITAjWSE+hbrs4k321INbcjv+KYXjvs2fga9Dq62RfGFUAkRt88fudEzns3EWGbMZw0xesFrwFHrL66Xwzk9B92TUPQ8h7Peh7jJLyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621698; c=relaxed/simple;
	bh=0cF8aNqGROlL7H9BBldIkjYtHJLEGzy/HVeyePl5QC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sqi2e4/Za7fnprksg1KDf/OXF84Ef6eOzDlmL0b1TZfD5C4Z68tx93jchI4ljWbOT+3FBuJv6NFq/OoM/JPxniFWoZhIU1uvC9E6vHmwAz1fn5M/jwzNb229aZchPcRENNRvrQcuArtp8eBxfJPvyCopG58O+bPS5H3VKb0e320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DDAQHXB+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ePJBC31bbxyESuu28yFD2CULnSZHZPwn8l1pSlndyHE=; b=DDAQHXB+L5N3ZRXhzIqDD752qB
	1yTu18cPGXKfGLU3OTDD7NvT8/lAQRCUFpJfFLk/ymc/fMKR31PTRYgkrvjeKMf2WS0Kbj54/9uw7
	VGAqbmTuEzO+I1Vx4SMexJJWwbahOdMB5LQ4N3rVPcNmsLJmm724NygkvOd7aXPTaKW0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwngp-0088FL-4Z; Thu, 11 Sep 2025 22:14:43 +0200
Date: Thu, 11 Sep 2025 22:14:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, saeedb@amazon.com,
	darinzon@amazon.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [External] : Re: [PATCH net] net: ena: fix duplicate Autoneg
 setting in get_link_ksettings
Message-ID: <30acdf24-c945-40ff-b7f8-29a5b2c0c3e5@lunn.ch>
References: <20250911113727.3857978-1-alok.a.tiwari@oracle.com>
 <6500d036-f6ef-47df-9158-529b2f376fae@lunn.ch>
 <2cad7a63-56e9-409b-90b1-69dfe73358c7@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cad7a63-56e9-409b-90b1-69dfe73358c7@oracle.com>

> So we have two possible approaches:
> 1. Explicitly set supported unconditionally and gate advertising on the
> flag:
> 
> /* Autoneg is always supported */
> ethtool_link_ksettings_add_link_mode(link_ksettings, supported, Autoneg);
> 
> if (link->flags & ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK)
>         ethtool_link_ksettings_add_link_mode(link_ksettings, advertising,
> Autoneg);

This is the correct change.

	Andrew

