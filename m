Return-Path: <netdev+bounces-130959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C498C383
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E247EB21B90
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A881C9EB7;
	Tue,  1 Oct 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vyiBYeku"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292ED1C9ECE;
	Tue,  1 Oct 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800570; cv=none; b=oo7Z+dK7YBRhI8R0AnOPHmaNEhOb8xF+76oEiNoXOQrbkb/WPJZ84HcD5F8rD3FGvGOAqVqFzqk6wSstZJRMDiUpWVj3hH0V7/O4fnJEJvUP1GDhUUqpnJTA+p6nlx24U0GfNGszGYrVr+3gf58MAcURMHx+cMGOQMMQJsk707o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800570; c=relaxed/simple;
	bh=CXXdMP/+Bs4oS3nfHaIkViUY0bh3YuSNrdxO9RLmUWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+RSlUQHL2ev2Yke12XPr1MOTNmOcPveqovqRd+vr7Sm9Uvv4ml1h17/+n9vZqmb719Vs9STZ/e111+RMiXZq2wtZuiHHjQxlA0SxA3bQ3UEfz4Ovw7SA9R9Vf6TZZCZc4jz+1Sq7XqQLaq9nlvY2yWe0HluUq8ckVL+X7kVpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vyiBYeku; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=z3kIzE2VXhVxEHh6j26Krtkzo+MmRj9VwurLG0WpooM=; b=vy
	iBYekuxqqqLau13SWtLKIaqW2wXRyqjnEQNfV4R+eBoYG5a5SwdPAvC7Gb5/h7UdhagFZY1KwxYTx
	gGd6zt+yEIwjU1ZuTAYyHgcodH97dHTDxUgrbNjuD3pPZQA/yUOzsk8TxGv26KHz44X3H53M3wkRB
	u7TrYk16+d4VRJA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svfr1-008kmT-Qt; Tue, 01 Oct 2024 18:36:03 +0200
Date: Tue, 1 Oct 2024 18:36:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	aliceryhl@google.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v3] net: phy: qt2025: Fix warning: unused import
 DeviceId
Message-ID: <c4a0b7c3-f552-4234-9b7f-fce01f2b115b@lunn.ch>
References: <20240926121404.242092-1-fujita.tomonori@gmail.com>
 <CANiq72nLzigkeGRw+cuw3t2v827u0AW8DD3Kw_JECi3p_+UTqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nLzigkeGRw+cuw3t2v827u0AW8DD3Kw_JECi3p_+UTqQ@mail.gmail.com>

On Tue, Oct 01, 2024 at 05:52:48PM +0200, Miguel Ojeda wrote:
> On Thu, Sep 26, 2024 at 2:16 PM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > Fix the following warning when the driver is compiled as built-in:
> 
> Do you mind if I pick this up so that we keep WERROR builds
> error-free? (I am sending a `rust-fixes` PR in a day or two to Linus).
> 
> Or is netdev going to pick it soon? If so:

It was marked for stable, so generally means it will get submitted to
Linus in a PR on Thursdays.

      Andrew

