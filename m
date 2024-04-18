Return-Path: <netdev+bounces-89242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DF48A9D3A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA63B21178
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245131DFC4;
	Thu, 18 Apr 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wYos3Wab"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD86FB0;
	Thu, 18 Apr 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450766; cv=none; b=JKZQXq+hyprBKMgup8xCvC4svNU2rR3UEo5tNe0s1+f4sEV5PR6YdkdkrweHNhchSDl52/wno0fD8qTtnCnFWMV+E6iuhOHclf/rDxgEDxliACzZHRA9GneBl+hUsexmNQZod0FoO8YZbdCbwUTgTLNaWFfWHna9Wta5SNogPhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450766; c=relaxed/simple;
	bh=nCMIMkUZD4xA2FXfjaiSTFskbrMOmFMJvKZgCiV/oV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5CuQ6z5Ht2UGiRECQfHGOVY4rXvYPs8zAJsaVV05NtcCIEzryNxWftr/IpgRvUTkXY/NjlcRN5qwGJ0ojiHQ6xm2n9hgvOzt9Per7dMHgfxRtF2szOl4pnKK82yJqH6FgfohnTzGY4FPB8aK/GCBrHXbwwniq5wWKkSqIuvv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wYos3Wab; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XSpvfjcaAXW5G7jqabTaSSigyt23MWCMe58+uF8u7ho=; b=wYos3WabfCrqvYiEC37KItheeB
	RUues0JP6WvMEeLpW6lJ6NXWZXaDd0iXR96zdHcpo9iJdmAzdwRu8yXvUNczQPXDCOqEW5gsogbCJ
	TVG8lHbj6Yq0qnbFg5G/N1YF7wDS5Fcv5QFXxRbmm6a1QbuiLAk779Z3YIXZxrta5SrI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxSoS-00DMHV-5y; Thu, 18 Apr 2024 16:32:32 +0200
Date: Thu, 18 Apr 2024 16:32:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
Message-ID: <aee3bb68-2b5f-4d3a-ae4e-43380e112d46@lunn.ch>
References: <e8a440c7-d0a6-4a5e-97ff-a8bcde662583@lunn.ch>
 <20240416.204030.1728964191738742483.fujita.tomonori@gmail.com>
 <26f64e48-4fd3-4e0f-b7c5-e77abeee391a@lunn.ch>
 <20240416.222119.1989306221012409360.fujita.tomonori@gmail.com>
 <b03584c7-205e-483f-96f0-dde533cf0536@proton.me>
 <f908e54a-b0e6-49d5-b4ff-768072755a78@lunn.ch>
 <92b60274-6b32-4dfd-9e46-d447184572d2@proton.me>
 <49c221e6-92d0-42ef-b48b-829c7c47d790@lunn.ch>
 <903a21b5-38d1-4d7c-8eb0-610b629c9856@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903a21b5-38d1-4d7c-8eb0-610b629c9856@proton.me>

> Thanks for the explanation. What about having the following register
> representing types:
> - `C22` accesses a C22 register
> - `C45` accesses a C45 register using whatever method phylib decides
> - `C45Bus` accesses a C45 register over the C45 bus protocol (or
>    `C45Direct`)
> 
> Or are you opposed to the idea of accessing any type of register via
> `dev.read_register::<RegType>(..)`?

I'm not against this, it is good to use Rust features if they make the
code easier to understand.

We can bike shed C45Bus vs C45Direct vs ... . I would probably go for
C45Direct, because C45 over C22 is often called indirect.

	Andrew

