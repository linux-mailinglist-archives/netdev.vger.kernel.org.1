Return-Path: <netdev+bounces-214161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980EAB28628
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 21:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F28B07C28
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78B1E47C5;
	Fri, 15 Aug 2025 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rg2AYj/d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91ED3AC22
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285042; cv=none; b=dAlFsPNyo0Vabv0xUnsl4QIO4X32WHa4EBPUPZJAtc37Yf4Nr8q6nSeQnp7pPkxPcUMAggBBwGzMbQ3ukmLjrM8BXCRoO/rayUBqbnUCGf3BPWpnBfEKQ3tuNns6jRpd7vgkqYWYJ201QwpjhrVo9apDge6LdpmiroVHLhjXfQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285042; c=relaxed/simple;
	bh=yDlozE1QTHi2QytZB/xXMOzUWGP9U998tdsp+3hzpnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL6wDfsZi3aj1TDXbtgicjF1jgV0oY6CbogqPvf/sPZQWPL38mMLyHpVVU9nmG2FRZScEdQpGf7Gtn0fLUi6sjW+Co9dqjFNuUWZNyVSIddc1rRofguz5owRQ5gxwcmEquGQU1ki/I143pPD0F+Eg7WH9HzI51ls4/y2ac8Yj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rg2AYj/d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zTW+B9ncvNJyYxgyWutrC4Y8qn8IDvmPmPWHlGxxUos=; b=rg
	2AYj/dtauvEcvRYAE4rdPEAmMVjL5UULrK33A8tgUFfnBO2pMbuRr2KaVkbGUcMxvpEHQig7Lrwsj
	p6HCahHwKQuALjAam2ddE6sWkNeKyrgvnDAeedB9yFoHWQRGCwOlICXJw2DuVjNnyB+NQB3p24ZUD
	on20J2Ey0lX4XrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umzow-004r71-Pu; Fri, 15 Aug 2025 21:10:34 +0200
Date: Fri, 15 Aug 2025 21:10:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guilherme Novaes Lima <acc.guilhermenl@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Seeking guidance on Rust porting for network driver as a
 learning project
Message-ID: <e59430e9-ed20-4358-bddf-fa5bf6f0d0da@lunn.ch>
References: <355E9163-9274-49C3-98AB-7354B9C091B7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <355E9163-9274-49C3-98AB-7354B9C091B7@gmail.com>

> If there are any maintainers or experienced folks willing to offer
> guidance or suggest a suitable driver for this kind of project, I’d
> be very grateful.

The problem is, network devices make use of a very large number of
APIs into core Linux. It is hard to write a Rust networking driver
until there are rust bindings for all these APIs.

To stand any chance of writing a networking driver in Rust, you need
to find a really simple device. How far has Rust got with I2C or SPI?
Is it possible to write a simple Rust I2C or SPI client driver? If so,
maybe look for an I2C or SPI network device which is currently
unsupported. That will simplify things a lot.

Or maybe see if you can find a USB Ethernet dongle which is currently
unsupported, that would make use of usbnet to provide most of the
code. You then need a Rust binding onto usbnet, plus a number of other
Rust bindings onto anything else needed.

This is not a simple problems space. It is going to need a lot of time
and effort to do anything useful.

    Andrew


