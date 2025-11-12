Return-Path: <netdev+bounces-237966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E640C52318
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACFDF4FDF77
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44431281C;
	Wed, 12 Nov 2025 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fd9ANxhC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E9tQbbd+"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0422FD667
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948752; cv=none; b=AIlQT8ENnX24Su8Gp2uzoFPNig/3OFPlZndhx1O//lPPCrv2tf28ci4H2mOmdli4B3V/IQWl8Y6GWaCgSKLzZt0DGdUUKh0/dXkxQ45IpvREmzxGPk7BoYMHT3mcSDjeXXQgHffUYYIXRsdpapqELn/7Ho5ZkQuu8w85vo+fkHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948752; c=relaxed/simple;
	bh=Fomw+xdItHSuhvxKPsm0M/LG9y1l5ZHa+jerqMi0LDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgSq0GXXb5eJU3c3LKJuc0J0TFf1/If1Z/QszRSylrnLX8NE1D/SfXuwaZr6yn9L3ha2xEAlkiH27D6FkyVCW5OY6hjvLPtS3iwE+9MBFzExGz8GiWlXMuyDFc/27sRbXPYXANX/YcxoITfvAQH3XWXS2jT4sFIHTpXWPvEO0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fd9ANxhC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E9tQbbd+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Nov 2025 12:59:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762948748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc/FSuXFnewKUWSQYT9lqYkgkpx4GOW5n7HjJDInI10=;
	b=Fd9ANxhClvZ82/SEXtxCG5cdFcaX0Di42E6DnoSr6+ILbEFLUCwhrPLjL3T5BeTUKOWz0/
	+FX1HGCYnx6/8h1vQT9yZkf2dhofd6YHOaz13kKfBHkG22dqrhbNu7i37vS3P/uk7kb46Q
	MTmrOAoItYt5z11jMm9uY2d3DblHHLkwHhMHx4z7SNRpRywlHnaEr1IfrlTJMtHceTarlm
	PYsBiW9qyDaKGSm4jPFyP3EYz4P6s/my7VBzMhNh1ql8G1xciDFTzCcu8ldnNOhtetTGp1
	uwMWjgB3+CByPerFSlCavlCpzqa6mJBJYPZhHGgVGZlFIut87kSM9nLMC0040Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762948748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc/FSuXFnewKUWSQYT9lqYkgkpx4GOW5n7HjJDInI10=;
	b=E9tQbbd+4iB1mnED0zsWkv8C0aZKpXm6ncznFyZXjYTLi7DAa9ngPJmIyDgD5G+WtIeMVe
	8HugJKibl/jB9YCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	liuhangbin@gmail.com, m-karicheri2@ti.com, arvid.brodin@alten.se
Subject: Re: [PATCH net 2/2] hsr: Follow standard for HSRv0 supervision frames
Message-ID: <20251112115906.esS_ffL3@linutronix.de>
References: <cover.1762876095.git.fmaurer@redhat.com>
 <ea0d5133cd593856b2fa673d6e2067bf1d4d1794.1762876095.git.fmaurer@redhat.com>
 <20251112102405.8xxcDBuT@linutronix.de>
 <4cb6fcd6-4e0f-47eb-a826-c1af712d33ab@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cb6fcd6-4e0f-47eb-a826-c1af712d33ab@redhat.com>

On 2025-11-12 12:01:51 [+0100], Felix Maurer wrote:
> > You say HSRv0 while I don't see this mentioned at all. And you limit the
> > change to prot_version == 0. So maybe this was once and removed from the
> > standard.
> 
> My description for the path_id is from IEC 62439-3:2010. As far as I
> know, the HSRv0/HSRv1 terminology is only used in the kernel. AFAIK, our
> version 0/1 refers to the value in the SupVersion field of the HSR
> supervision frames. The SupVersion is defined as 0 in IEC 62439-3:2010
> and defined as 1 in IEC 62439-3:2012 and following.

This is what I assumed. I don't have any older specification, I have
here SupVersion always defined as 1.

> The definition for the SupVersion field also states: "Implementation of
> version X of the protocol shall interpret [...] version <=X frames
> exactly as specified for the version concerned." (in IEC
> 62439-3:{2010,2012,2016,2021})
> 
> I read from this that if we implement HSRv0 we should follow the latest
> specification for this version, i.e., the latest specification with
> SupVersion defined as 0 (which would be IEC 62439-3:2010). This is also
> why I limited the change to prot_version == 0 (maybe we should have some
> helpers like hsr_is_v{0,1}() to make these conditions a bit more self
> explanatory).

Based on the explanation, the limit to prot_version is the reasonable
thing to do.

> Thanks,
>    Felix

Sebastian

