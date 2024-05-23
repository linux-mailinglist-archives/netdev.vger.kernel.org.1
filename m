Return-Path: <netdev+bounces-97796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263BD8CD446
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E951F21795
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066314A4DC;
	Thu, 23 May 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OrdR7WEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893414532F
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470590; cv=none; b=H/4vT+l7iDfi8TwKpXNnkoWy7bXEsMtIHFfmSuyoK9h+8dLbLTR3C2Ke3yeoK10qyeM+FIwpMA/9WrRqxDNV31a9thWtH0mqqmg361Uvvnw2TidsBdi1z6X/ALBB3B1BaUMlU2zLFVQHb2pz5UsYN6JkQycFsaG42JgFOmPVirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470590; c=relaxed/simple;
	bh=5kj+pJxNyDro3O4oKgBMJW+N0JELwTb6wvwLqArfn98=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aofC000pBo3YNXPb3cQ3hbr081dtHhhqYKcE/55ATuJgHKCka+1g+sVRufhtdYGFQ4Kp+g7JgZ8ygmiQmDtVIYJicNC5drYLe1TfPdLIKRIBPeke4LvvFWdvuF4TFhJYrN++YzBCKqBnFrSdekgPaHhFkWXC6HBo9Hz7QEXlw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OrdR7WEd; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716470585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDVIJyF/H22HVMkIRJNmZL9WxECGT3a8/OIURmowZ1M=;
	b=OrdR7WEdA1IubmdJbmchlgaQy8JF6SNjRzQCq4AaDKZsd+S3Bu2smBVDaeho48X+hN5/zA
	KkLFKwpk4PTWYA8l1E5XBJdmreM2aIMzEcOX2oA6tti9mJ2VbtR0EZ+s2TVyYq+hkCF+kN
	JWL+NyW/dxXnWnWbKQNSNgpKe6wIm/GBMFmTZ8MsVuD+Eij1s/wmgcFa3tHO0VzSVxl/1h
	+0Ned7LcQj91yDRiPOfP6mGahbqqu5w1OsclwWP3so6iDII3iqECP6AGelyFttWmS1bZGR
	PfQKjNcMQyHmlxFNJrkxbXyLuDZZ6OuUWXDfckVIPqXIexEMTH+ggz2WyhysvA==
Date: Thu, 23 May 2024 15:23:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
In-Reply-To: <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
Message-ID: <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 15:04, Gedalya wrote:
> On 5/23/24 8:36 PM, Dragan Simic wrote:
>> On 2024-05-23 09:57, Sirius wrote:
>> How about this as a possible solution...
> 
> For what problem?

Obviously, for the problem your patch attempts to solve.

> Yes I asked Debian in the first place to leave colors disabled by
> default, but nevertheless `ip` is still broken for most users if and
> when colors are enabled, whether at runtime or build time.

Well, the coloring support in ip(8) can't be broken if the users
configure it at runtime accordingly, i.e. following the background
color configured in their terminal emulator(s), right?  Or am I
misunderstanding something?

>> If Debian configures the terminal emulators it ships to use dark
>> background,
> 
> Do they? Or is that the nearly universal default?

Frankly, I don't know for sure because I don't use many different
terminal emulators, but you as the submitter of this patch perhaps
should know that better.  However, terminal emulators must be
configured somehow, because it makes no sense whatsoever that they're
having their background colors hardcoded.

>> why not configure the ip(8) utility the same way, i.e. by setting
>> COLORFGBG in files placed in the /etc/profile.d directory,
> 
> COLORFGBG where set is automatically set by the terminal emulator. It
> would be more sensible to add this feature to more terminal emulators,
> upstream.

Of course, but that would take a lot of time, both to implement it
everywhere and for the new feature to reach the users.  Shipping
a few additional files in the /etc/profile.d directory would be a
reasonable stopgap measure.

> Should Debian come up with a patch that magically adjusts this
> variable every time the user changes their background color (in one
> terminal emulator... and another color in another terminal
> emulator...?)

That's a valid concern.  Perhaps some documentation could be provided,
to help the users who alter their background colors.

> And what about linux virtual terminals (a.k.a non-graphical consoles)?

In my 25+ years of Linux experience, I've never seen one with a 
background
color other than black.

> In summary, if the best we can do is manually set COLORFGBG when using
> a light background then that's the best we can do. I don't see how
> Debian can possibly help with that.
> 
> On the iproute2 side, a rock-bottom ultimate default background color
> assumption will always be needed and that should be dark.

As others already pointed out, "should be light" or "should be dark"
can be seen as personal preference.

> Yes, echo -ne '\e]11;?\a' works on _some_ (libvte-based) terminals but
> not all. And a core networking utility should be allowed to focus on,
> ehhm, networking rather than oddities of a myriad terminals.

In an ideal world, yes.

