Return-Path: <netdev+bounces-128435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2D97985D
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 21:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20861C20A54
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 19:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203491C9DE4;
	Sun, 15 Sep 2024 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vc6YrE5C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E3175AD
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726427651; cv=none; b=MTM02V0eJd9m0Gxp6VO7S9BJ6DRwAH5ahRBpj7eQ2+Rd/mgx+jgzX039F0DVovnEIm7iGXDIY0r10Xd+abG3nMpVLEmO2Pli/2QB9e98MfoiIEeM2HTEEopWxHiMyxIdUz2dfhBNQtYkl/wik4kDLaJFidEN/9mBAlZwGwePHQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726427651; c=relaxed/simple;
	bh=mnFNA2a/VWm7AW18n7/l3kPiUsP4XViC9PFSpCyHGCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+0l5QmI0A9nv9UejH8/gtaYSByZYfN0nfuDB0pP+koKfMZBtVCV+tCBKmVgpw/D6mRGh1UKr2Xw3PIjLujaP7F8epDujonl/nyw0rvlJexazsYAhZJtgjIZMmOQHQg0u6cySLvzmNbTyufaM8rXLlxc3bfK/dBsAf5C8lPwuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Vc6YrE5C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pX+2JGqedy61bsik7Lg9APPK4GZ5jEs0BOhG71pMERo=; b=Vc6YrE5CQZUGw/iqqQ9+xEkNlJ
	2HXRATcSBBwAmvqdl8+8LpkrgkAv1Xcpb/Ns8PRowW8rht44k4sAuTGWhRAdiiVlFGoPgj+VeGMAI
	yerXOu64mkEhPEFVpioT2dV3Q3jTPV+P214M/RUa+FhqiCsdJnNMVbwMu219oNHhCrLU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1spuhA-007VzC-NL; Sun, 15 Sep 2024 21:14:04 +0200
Date: Sun, 15 Sep 2024 21:14:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
Subject: Re: [RFC PATCH] net: dsa: mv88e6xxx: correct CC scale factor for
 88E6393X
Message-ID: <d6622575-bf1b-445a-b08f-2739e3642aae@lunn.ch>
References: <b940ddf9-745f-4f2a-a29e-d6efe64de9a8@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b940ddf9-745f-4f2a-a29e-d6efe64de9a8@shenghaoyang.info>

On Sun, Sep 15, 2024 at 07:57:27PM +0800, Shenghao Yang wrote:
> Sending this as an RFC: no datasheet access - this
> scaling factor may not be correct for all boards if this
> 4ns vs 8ns discrepancy is down to physical design.
> 
> If the counter is truly spec'd to always count at
> 250MHz other chips in the same family may need
> correction too.

Hi Shenghao

This sort of text should be placed below the --- marker so it is not
part of the commit message which actually get merged.

What we want above the --- is a description of the problem you see,
and how your patch fixes this problem. It should include an
explanation of what you think the real problem is.

My understanding is that the clock can either be 250MHz or 125MHz like
older generations. If an external clock is used, it should be 125MHz.
The internally generated clock is however 250Mhz.

There is a register MV88E6XXX_TAI_CLOCK_PERIOD which indicates the
period of one clock tick. It probably defaults to 0x0FA0, or 4000
decimal which should be correct for the internal clock. But if an
external clock is being used, it needs to be set to 0x1F40, or 8000
decimal. It would be good if you could read it out and see if it is
correct by default.

This should apply to the 6393X family, so 6191X 6193X 6361 6393X. It
does not appear to apply to older devices.

	Andrew
 

