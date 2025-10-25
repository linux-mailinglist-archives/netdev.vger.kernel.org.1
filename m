Return-Path: <netdev+bounces-232931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCFCC09F6A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 21:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B743B8404
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7A42609D6;
	Sat, 25 Oct 2025 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dIoYniUp"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF902DF15B
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761421856; cv=none; b=N8H8hOUINEKzB55ZJzBmB1Dzjgv80SZWEDITGn3X2K89QIxqy8JBcVxcj3Ley/w5DovKFp30LKH1PeCMxXVlWB183r04vsMDR44HR9NtjuslZynDfhDuGmm5dN0hQdt/G9wkAWapsvrQK3+9+KL+G8uJEvRO82bMRw/8LxSM+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761421856; c=relaxed/simple;
	bh=8p9kKuiCnIDT4OZyCrBR+3Swqyfaujbqe9WyZVaNleE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqhfoJ0uzr1HxfPCfQDJ9/5ly3YpHCFgOWsEMY5ZRaq8i4t2yTzupBzcYQtl3n/H4KbWSgI8hV8gAiLaGGIdy47SzrRD7mUn9fMCc69FQsXS7JLpafxjCKy5AAyFdPrcv8RlPAqNx6NsZwjML/vt60VSWyjvAt9y0X+8hp3+7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dIoYniUp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 94466C0C405;
	Sat, 25 Oct 2025 19:50:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 755AE60704;
	Sat, 25 Oct 2025 19:50:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E817F102F24B4;
	Sat, 25 Oct 2025 21:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761421849; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xS9DWYbPS5RAJNziak57osAtFOJp0n29KoRjK/Vqiag=;
	b=dIoYniUpURM/Ww/98Jgc69HzgHGZtZ44HlfJXzhx1To69jb+uLJOEFOdZ+2KT9UHK9wlQa
	FH297d2+YdBS5/lJLw0Ai+Tn3P1EziTuLp3UVi6RIR+a05xjKvFjfaqhevpHGIViMv9+wj
	/U+f1kvAEgPFWDwF79hq2D/MCEFt+4YJCnEVGqzB+FsS/NsFGmKOlHTqbdHwZSeZiO+NHb
	kUI3/HhCZt/2P1ZtQkXseoLCs4qRayzrN2u16Ij8mOYmRKtr+CjC7RlwCH8NDKnzHHXfl2
	KyZxahDikrJ0+gGECfT+SUg6ru5El+UW4HX2zVCHeTvN+RuWJGlCbkcf7zr+lA==
Message-ID: <fa194ce6-8fca-4974-8dc7-2eb22ec50bfb@bootlin.com>
Date: Sat, 25 Oct 2025 21:50:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: stmmac: add stmmac_mac_irq_modify()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aPn5YVeUcWo4CW3c@shell.armlinux.org.uk>
 <E1vBrtk-0000000BMYm-3CV5@rmk-PC.armlinux.org.uk>
 <20251024190159.60f897e5@kernel.org> <aPyEKGCeXwnsn4OC@shell.armlinux.org.uk>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <aPyEKGCeXwnsn4OC@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 25/10/2025 10:02, Russell King (Oracle) wrote:
> On Fri, Oct 24, 2025 at 07:01:59PM -0700, Jakub Kicinski wrote:
>> On Thu, 23 Oct 2025 10:46:20 +0100 Russell King (Oracle) wrote:
>>> Add a function to allow interrupts to be enabled and disabled in a
>>> core independent manner.
>>
>> Sorry for a general question but I'm curious why stick to the callback
>> format this driver insists on. Looks like we could get away with
>> parameterizing the code with the register offset via the priv structure.
> 
> Not quite - some cores, it's a mask (bits need to be set to be disabled).
> Other cores, it's an enable (bits need to be set to enable). So one
> can't get away with just "this is where the register is", it would need
> three pieces of information - register offset, type of regster (mask or
> enable) and then a core specific bitmask.
> 
>> Mostly curious. Personally, I'm always annoyed having to dig thru the
>> indirections in this driver.
> 
> Me too, especially when it's not obvious what is an indirection and
> what is not.

Same here...

> There's the fun that a lot of the PTP-related indirection
> actually has no difference. For example, at the bottom of
> stmmac_hwtstamp.c, the struct stmmac_hwtimestamp initialisers have
> almost all of the methods pointing at the same implementation
> with the exeption of .get_ptptime, .timestamp_interrupt and
> .hwtstamp_correct_latency.

Well I introduced that last year. GMAC1000 and GMAC4 have what
appears to be different versions of the timestamping IP, registers
are either at a different address, or same address with a different
layout bitwise, or with just different behaviours.

There used to be a single instance of the stmmac_hwtimestamp ops,
which didn't even account for the differences between these IP
versions. TBH I don't even know why we had a stmmac_hwtimestamp
struct with a single instance back then, but I figured that using
that was a good way to at least split the gmac1000/gmac4 diffs
back then.

We coud now very much get rid of the common ops and avoid the
indirections for the TS ops that are the same between all IP blocks :)

As I'm doing quite a bit of timestamping in stmmac right now, I may
find a bit of time here and there to do that at some point :)

Maxime

> 


