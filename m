Return-Path: <netdev+bounces-232833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF101C0924D
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A0104EA7F5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787DC3009C0;
	Sat, 25 Oct 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mGCUG53T"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF12FF16E
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761404004; cv=none; b=cE4z5Fux/KbPd5qQWWIitEiN3sT9SbC5ysmMKgz16rLYHRYSsQoCEBDhJGmPYeg1WViqguvEz99hGiQPtMRQtEZq7tHMP1badrYlc1Rk/h2zsbYAuMloyAKksQZH6pzdWqd4BrTQxHpb/7B9pCovLftgF1W2KYc7lqWrttBhQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761404004; c=relaxed/simple;
	bh=JaSfmXv94VXl1jyPk4wPKXuHmTVcW+XYQIoaz8cq1sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OABI3+VOa61AiC3xyeZcLHd7Ywh2nCcNo9vYlp4WBUO+MiUnECWjUOvNhenP7eSsOJa2bJ+oFPM6SnA3i5FVs4BiXwb1TS1gu3FXudjpv5em4ErqRKaOKHR1kcVJfaqE3pyX+a7+naoZ8STRBQdcNR0Og1Z3ez/FTpmQvnagoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mGCUG53T; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s8P1sxLgEuKRZ6dvxoVDBmjehIiKI0ixhEHlFaCTQFs=; b=mGCUG53TFjcHedFm6fwVH+6lWd
	aVyMvQ9GdkajhSknyP/Dppubm787ZKAMj9nyQVFPhuoCbY/Wp5rmANBQ25H76wXTQHXRkME9wT+ER
	ziAdOL7AZLCsoyEfUurnxH0hccb/0OnTo24m1o/t6doB9i6PMcloWkzMli435VcpZdTCLZCxpd9d/
	102rXdZLNhmJNTHXWRop07MPQsD0L989sdvp0PSsjDSafXjenEMc3o8yMgt7we6K1HB0i523Y2zPC
	3tt++PvXWRMg7m1wVCDEgtE9NLWHnxy/Ij0yAWk0Rou32ldPyFZmFicFnC6Pd8kzOvQRfX6OXFBFd
	bT8R25Pg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1vCfdo-009sNR-Nm; Sat, 25 Oct 2025 14:53:13 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 07F7BBE2EE7; Sat, 25 Oct 2025 16:53:12 +0200 (CEST)
Date: Sat, 25 Oct 2025 16:53:11 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Garri Djavadyan <g.djavadyan@gmail.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, 1117959@bugs.debian.org
Subject: Re: Bug#1117959: ipv6_route flags RTF_ADDRCONF and RTF_PREFIX_RT are
 not cleared when static on-link routes are added during IPv6 address
 configuration
Message-ID: <aPzkVzX77z9CMVyy@eldamar.lan>
References: <ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com>
 <0df1840663483a9cebac9f3291bc2bd59f2b3c39.camel@gmail.com>
 <20251018013902.67802981@phoenix.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018013902.67802981@phoenix.lan>
X-Debian-User: carnil

Hi Garri,

On Sat, Oct 18, 2025 at 01:39:02AM -0700, Stephen Hemminger wrote:
> On Thu, 16 Oct 2025 00:12:40 +0200
> Garri Djavadyan <g.djavadyan@gmail.com> wrote:
> 
> > Hi Everyone,
> > 
> > A year ago I noticed a problem with handling ipv6_route flags that in
> > some scenarios can lead to reachability issues. It was reported here:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=219205
> > 
> > 
> > Also it was recently reported in the Debian tracker after checking if
> > the latest Debian stable is still affected:
> > 
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1117959
> > 
> > 
> > Unfortunately, the Debian team cannot act on the report because no one
> > from the upstream kernel team has confirmed if the report in the
> > upstream tracker is valid or not. Therefore, I am checking if anyone
> > can help confirm if the observed behavior is indeed a bug.
> > 
> > Many thanks in advance!
> > 
> > Regards,
> > Garri
> > 
> 
> Linux networking does not actively use kernel bugzilla.
> I forward the reports to the mailing list, that is all.
> After than sometimes developers go back and update bugzilla
> but it is not required or expected.

Garri, best action would likely be to really post your full report on
netdev directly.

Regards,
Salvatore

