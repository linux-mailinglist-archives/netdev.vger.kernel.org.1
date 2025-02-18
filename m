Return-Path: <netdev+bounces-167378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D4A3A069
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EABF17C4F6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F3F26AAB9;
	Tue, 18 Feb 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSqCv0tR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B726A1CC
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889766; cv=none; b=JdC/AizT8U5m4ycrESnPG0JDPM9mmO2M/tDxIK1IReKqzOVwYe5a5ev/2Zyd0Vr0uQOcquVnTawdZrsqfFiwj+u2XrXmjNZUIUtwoN4MKugQv2ExoAgXxXV9GG7BHY8xDuuTkFPVaOpvNHQkVSaWbrvdp9mIIsUoxk9ZT5Hh5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889766; c=relaxed/simple;
	bh=h4Sz68cDi8sNlheSqNKjltwMOMUjs8fRxT87yFyhDyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKtOE10+kETjOXLyFWWM+hP7FDc2XrHu/qzXT3XyeJ3N+rbvCV7jyS1QmzQ4rDbrAU32pMPWVucHVCWSmE68qFTUypElM7xE1RNxZoikaCvZNGjJ7gwerP6SrpNTzO3jFtf8R14/vDeRGgRrXE9yEUXFhdkrgtxi47bs5GNEhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSqCv0tR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204F6C4CEE2;
	Tue, 18 Feb 2025 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739889765;
	bh=h4Sz68cDi8sNlheSqNKjltwMOMUjs8fRxT87yFyhDyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pSqCv0tRFDX7UY8zvb9XwpmSywgTDymCX/3H4GAB1ytOjLpKrkR9Hyy6HYEayOt1e
	 AoHjxNV69F/Lbekc0imDD7Ijz4STO4iqlYaSpg/bBBxjMTCxjxN7LuY6nI70o3J5Dg
	 tgyLhXlTZNq73pkMNdN2f107/9AexCjnukeXWqOCBJj++uHNTLMbuBwFQmoSlg8eJX
	 +PBAdkLx2hcvedaHV8B/QmNJC2CTXzUoFYwkJCzyFH1e2bUK5L66aOZfhgx0Uaowck
	 pdE6ATBq4ldijeT2/6E/6J7wmCDkN1tpt6YwjOcHWxskbAPTMWzwQ4QfOWmYhj0Oti
	 fWl2JwmU7KcTQ==
Date: Tue, 18 Feb 2025 06:42:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: realtek: add helper
 RTL822X_VND2_C22_REG
Message-ID: <20250218064244.0089ce20@kernel.org>
In-Reply-To: <31a901f6-02ed-4baa-902e-d385d1808f4b@gmail.com>
References: <6344277b-c5c7-449b-ac89-d5425306ca76@gmail.com>
	<20250217164447.4d59e75c@kernel.org>
	<31a901f6-02ed-4baa-902e-d385d1808f4b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 07:33:32 +0100 Heiner Kallweit wrote:
> On 18.02.2025 01:44, Jakub Kicinski wrote:
> > On Fri, 14 Feb 2025 21:31:14 +0100 Heiner Kallweit wrote:  
> >> -#define RTL822X_VND2_GANLPAR				0xa414
> >> +#define	RTL822X_VND2_C22_REG(reg)		(0xa400 + 2 * (reg))  
> > 
> > Just to double check - is the tab between define and RTL intentional?  
> 
> Yes. In the terminal a space or a tab after #define are the same,
> not sure whether there's any preference from your side.
> At least checkpatch doesn't complain.

Weak preference for following what the rest of the file does,
so space would be better. I'll change when applying.

