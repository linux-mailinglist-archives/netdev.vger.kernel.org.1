Return-Path: <netdev+bounces-178435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D309A77015
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65011188A855
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D581621ADAE;
	Mon, 31 Mar 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouIznht7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9341D63DD;
	Mon, 31 Mar 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743456358; cv=none; b=uabyOJmUdOBERC8XMPMfNKibDjHelW/4BC8J0m2Hs+7Eh8K8GW04oXKkHT5+78s/AMY6wZ/M91T6EqG2hDl8+Io7RDS2XyseiypPgwzkcnWsM781JhrCvCXePsZBNAcXTQf+lJL8TgRXh2n04fp7P7KYQUiR3DK/Jn9j8bUvz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743456358; c=relaxed/simple;
	bh=VENzcAMS3GYy4saaDxr2yze+Keef8IZU4+9h3qOq2I4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfoONVN9OTWkLwtOkc8/MIk5WS61mZwt6X3RbIXA3PBu+bfsL6R3Bp4VjHp4dkOvjsdbwiqM9VaED+QkJzJYHOVthM5sNXE96/pBV5/sdZV0qxQuLge3MEdAydNBx7KZhF5nYJJsBpRMyr6aDwGVwjysc/ed6OtH1KnfwdFHQDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouIznht7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F191FC4CEE3;
	Mon, 31 Mar 2025 21:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743456358;
	bh=VENzcAMS3GYy4saaDxr2yze+Keef8IZU4+9h3qOq2I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ouIznht7YcCVIRNkYpECS0nSVFTjzFrw2MqdDKyXdI8C2lFDWc2/4AbWZtR65+fly
	 3l1TeVBeLIHmJRiF/+PlYx9DmUXjmsCE7MuXZ2am1UTdMsju8eZQcPhUJZqi353jMP
	 KxdlydrxMViPlqtV51kwgUPbYc6Htp+OipXraWGiwMQHvopAKeY/ME6H6WjepZkr69
	 EHSuF3YEqPjIbWoP0XAlz3x7gDSTOrZ4kvGIRDrJhvyzcob4IZo+j7MKM/c2IoJA2M
	 5nhRF/jeO2yvEjrbgfunTl7HFZbUjhQOo72Z3ExcpA+wq7QlyNKcGQ5+fLWyU1grda
	 4uH/jjW/hvYBQ==
Date: Mon, 31 Mar 2025 14:25:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: dlink: add support for reporting stats
 via `ethtool -S` and `ip -s -s link show`
Message-ID: <20250331142557.3e454470@kernel.org>
In-Reply-To: <Z-rFcxj7XeiMHsz7@mythos-cloud>
References: <20241209092828.56082-2-yyyynoom@gmail.com>
	<20241210191519.67a91a50@kernel.org>
	<Z-rFcxj7XeiMHsz7@mythos-cloud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 01:40:19 +0900 Moon Yeounsu wrote:
> On Tue, Dec 10, 2024 at 07:15:19PM -0800, Jakub Kicinski wrote:
> > On Mon,  9 Dec 2024 18:28:27 +0900 Moon Yeounsu wrote:  
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&np->stats_lock, flags);  
> > 
> > I believe spin_lock_bh() is sufficient here, no need to save IRQ flags.
> >  
> 
> Anyway, base on what I have learned, I believe `spin_lock_irq()`
> should be used in this context instead of `spin_lock_bh()`.
> 
> The reason is that the `get_stats()` function can be called from
> an interrupt context (in the top-half).
> 
> If my understanding is correct, calling `spin_lock_bh()` in the
> top-half may lead to a deadlock.
> 
> The calling sequence is as follows:
> 	1. `rio_interrupt()` (registered via `request_irq()`)
> 	2. `rio_error()`
> 	3. `get_stats()`

Makes sense, please document this in the commit message for v6.

