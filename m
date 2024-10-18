Return-Path: <netdev+bounces-137012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D42699A4064
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4011F2B643
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A16433B5;
	Fri, 18 Oct 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1qk+sXCZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9FF9E6;
	Fri, 18 Oct 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259423; cv=none; b=k3gH1cVLpMoMg21C6hEEjwdbaRI6R6/Wtz+GNyjQDjw+nB7P87Aqcd0zugIieVcAA3el1rLCu7JYFgXDf0FYEKXmrsw8e0kJfFgZE4QJcA2rn2Z5oZVsMHRd01VX5tRmS0QCsywvcZuPkmLTn6Du3xIPqq9pBNAqzgJHJZOPPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259423; c=relaxed/simple;
	bh=Ifz2Hi49RNJ7FTB0bhlHs1SBJ6O19jjgJGYYqj7mLk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDExGVqgoyHUHzdl/96j/zt46e/XIEsFWQ1H2kZeaLvC2l3fa/6xr0tWqvqV4JrKSvLivdTfGUpWxaSouqAA3uTAkAjJXTDxoLn8WbPwCwU41GMjHfMhUQXzf+sB00iJGG6u62T6MlXYwydw57h/0DDVOkLeaOzb9wK4Aol82tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1qk+sXCZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Iaohp9JW+2KjUcboUd0Ub0ES9LNoNdwWMVfFNbvuLsM=; b=1qk+sXCZ+ySPkpBqSJ8biolan9
	0ZcV/XAb4XAe/JNQnEe7PAugIa1pzEezaQdTVIAlU37jXE522s3OrzaiXbrybuAP46RpB58KJmzuh
	gisag2No1ZkVdUkREmlSbPGvxyeiY9PAE5dtvJO/zwT/XkS7B5tdFfHd/4NY0osXa4zI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1nMY-00AXUl-QB; Fri, 18 Oct 2024 15:49:54 +0200
Date: Fri, 18 Oct 2024 15:49:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
Message-ID: <6bc68839-a115-467f-b83e-21be708f78d7@lunn.ch>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016035214.2229-3-fujita.tomonori@gmail.com>

> +    /// Return the number of microseconds in the `Delta`.
> +    #[inline]
> +    pub fn as_micros(self) -> i64 {
> +        self.nanos / NSEC_PER_USEC
> +    }

Wasn't there a comment that the code should always round up? Delaying
for 0 uS is probably not what the user wants.

    Andrew

