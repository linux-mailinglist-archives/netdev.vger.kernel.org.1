Return-Path: <netdev+bounces-214235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E35B28945
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0367E1D02220
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 00:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623611FC3;
	Sat, 16 Aug 2025 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f4zmHIVd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286D405F7
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755304246; cv=none; b=hWmSf6/sVSEUs8g7+nuVHBKgWhl4uMf8zhRlaZMF2vYcIFnkdx40go87Bweespegs9eQHMIeM8Vrk+EE8rPSi1PRW8ZsCj34exPEOI3LLrcvibNTsFRoWQ6ttkJFtlM8dIGUtGNBa2S/UG4Gcf+yrTVktdeZ+IH+Q0fxgt5CKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755304246; c=relaxed/simple;
	bh=I193qQEop4Fz59XNPdGmQG7l6yuKt5tQqXnd76+tNWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B16DZmwzl5NgZpY0NPXRsOPIrqeh2Ue0ofXxADS0xH2hZ71gQWms/V3Od39i1Q4dJonSNanXDpRu+NNp5ji6skmo8Mxv7TZiEUDtp50Rg9/TNl4KYiZtJynmg3qLdsgjcFm8RQjMT2JPrj5sI+RBtiT8iFgflMyuKroZZ5KLnG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f4zmHIVd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=BBEQJXduKyAUWITPYyruO7rQEKgNnkD1VpUmf9eyfWI=; b=f4
	zmHIVdznHIAPre5l7256QDjgSRz+FoBYyX5E5qc3QR0Uwj11QSArxrz+Vr4YiLJH/7SSO4GHKSVKn
	UYtwOXgL5PMUDQvr3Y4kdXeSjcPWizGNuoduPlw6V7QWu9I0dua9vM2txmKcQItJXxrUFimIz1KT9
	GomVSebUXuNrR3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un4ok-004sPb-7h; Sat, 16 Aug 2025 02:30:42 +0200
Date: Sat, 16 Aug 2025 02:30:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guilherme Novaes Lima <acc.guilhermenl@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Seeking guidance on Rust porting for network driver as a
 learning project
Message-ID: <e219a202-0e02-4802-bba4-da8d15624113@lunn.ch>
References: <CE8FAE9A-CC93-4C91-AC07-B6C43B073CDA@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CE8FAE9A-CC93-4C91-AC07-B6C43B073CDA@gmail.com>

On Fri, Aug 15, 2025 at 08:27:53PM -0300, Guilherme Novaes Lima wrote:
> Hi Andrew,
> 
> > Another idea might be an Ethernet switch which is not supported by DSA
> > at the moment.
> 
> Thank you for your reply. The ideal would be to do something simple, the actual implementation of the driver would be the secondary focus of the research. What I originally intended to do was to port over r8169, I didn’t have switches in mind. Do you think that would be too hard? Sorry for my inexperience, I’m a complete noob when it comes to kernel / driver development, so I thank you again for your patience and generosity.

Any code you produce for the r8169 will not be merged. We don't want
reimplementations of existing drivers. r8169 is widely used, and
currently Rust only supports a subset of architectures. It makes no
sense to have a minimal Rust driver for a few architectures and a full
featured driver for all architectures. This is why i suggested writing
a driver for something which currently does not have a driver. If
Linux currently does not support some hardware, we don't care too much
that a Rust driver works for a subset of architectures. Its better
than nothing.

	Andrew

