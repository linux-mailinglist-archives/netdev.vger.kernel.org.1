Return-Path: <netdev+bounces-79631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B0C87A4C6
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26C01C21D78
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F781F5FD;
	Wed, 13 Mar 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="IHfffcYs"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984C1BDC2
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321583; cv=none; b=Kj+4CMlz6E9g0WL19eZ1J7s+mapPFNuMoCiaTRwuAvwFmlKj6K1p3TVvsZiYs7JsMpkppcKp2CnwJUCoDlHHREHXJeSKX8i/UPMmN7YdHBlI2TFS15eZnHMIh6H9VFnwbR7bj2FuUO9WVh3JUlAfnS3yidLo0dul7qDZo3S9Osc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321583; c=relaxed/simple;
	bh=QE/o9L1hFx1ujgqzxLt7DwDEi3+56nYKQEGZyFmFm0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G56akmRQo4bxqsI+p589BrQBEsnC9SR0RBXRl/gAFCrAgVlg0ii1URS5IDrUFfMgyswqAJFfiXnFMjFVA8Cx8uBWVuatPCTOg8hf2c8HrQpt0wTM0xcEvCPXoCOT250c/s3TXxHqs4XS/UbQF1TRKZaG1KT8CH86jOUsrfwDzbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=IHfffcYs; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id C0326602BD;
	Wed, 13 Mar 2024 10:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710321577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9RM+VJvH7H+3nWUIhVB457v03QrwTFXUAacQKAJ65wg=;
	b=IHfffcYskHRyZCZdFzFjpBDD/Em5iBRp3tnEj89szfepQwX8iH3zQRwcp6LYFMZQbygulp
	/bF1UTx9WBOfdj3LIuUMwLkCDyghCmSf0xl3fQIMpipvXfu0VXjDAIQaxUPR5JNTc1/HWq
	SVDH1jLma4oM7u6Y42otljOCg2Go2t2oXmwSPazhkQs363p2bUvJrtUW3WfmZEU47DTQ37
	xzRNaEPvVLPBap6JsctJUzkOP76SFTWalOdGHWitnLz5fT0ejrlhvSv8rirZfYnMcDLcQJ
	C96vY9BvIri5Ucwgo2K1q+EkD+hI79Z6AMslCSIUBOHavwOya4rt3UIUNegoQA==
Date: Wed, 13 Mar 2024 10:16:54 +0100
From: Max Gautier <mg@max.gautier.name>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] Makefile: use systemd-tmpfiles to create
 /var/lib/arpd
Message-ID: <ZfFvBmNKO_G7Q5m9@framework>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Mar 12, 2024 at 03:19:19PM -0700, Stephen Hemminger wrote:
> On Tue, 12 Mar 2024 22:34:59 +0100
> Max Gautier <mg@max.gautier.name> wrote:
> 
> > On Tue, Mar 12, 2024 at 02:24:20PM -0700, Stephen Hemminger wrote:
> > > On Tue, 12 Mar 2024 09:22:20 +0100
> > > Max Gautier <mg@max.gautier.name> wrote:
> > >   
> > > > On Mon, Mar 11, 2024 at 06:30:07PM -0700, Stephen Hemminger wrote:  
> > > > > On Mon, 11 Mar 2024 23:28:31 +0100
> > > > > Max Gautier <mg@max.gautier.name> wrote:
> > > > >     
> > > > > > On Mon, Mar 11, 2024 at 12:40:03PM -0700, Stephen Hemminger wrote:    
> > > > > > > On Mon, 11 Mar 2024 17:57:27 +0100
> > > > > > > Max Gautier <mg@max.gautier.name> wrote:
> > > > > > >       
> > > > > > > > Only apply on systemd systems (detected in the configure script).
> > > > > > > > The motivation is to build distributions packages without /var to go
> > > > > > > > towards stateless systems, see link below (TL;DR: provisionning anything
> > > > > > > > outside of /usr on boot).
> > > > > > > > 
> > > > > > > > The feature flag can be overridden on make invocation:
> > > > > > > > `make USE_TMPFILES_D=n DESTDIR=<install_loc> install`
> > > > > > > > 
> > > > > > > > Links: https://0pointer.net/blog/projects/stateless.html      
> > > > > > > 
> > > > > > > Why does arpd need such hand holding, it is rarely used, maybe should just not be built.      
> > > > > > 
> > > > > > The commit introducing the install of that directory is quite old    
> > > > > 
> > > > > The problem is that build environment != runtime environment for embedded systems.    
> > > > 
> > > > That's the same for anything detected by the configure script, right ?
> > > > Hence the override capability.  
> > > 
> > > Configure is mostly about what packages are missing from the build.
> > > It would be better if arpd was just smarter about where to put its
> > > file.  
> > 
> > What do you mean by smarter ? Trying to found an existing directory
> > rather than a fixed one ?
> > 
> 
> Isn't there some environment variable that systemd uses to tell a service
> where to put its files? If that is present use that.

Yeah there is StateDirectory that could be used for this (set
STATE_DIRECTORY in the process). I would have done that, but there is no
systemd service file for arpd, and I don't know which options
combination should be preferred for the arpd invocation in the potential
service file.

On another note, I see in the examples sections of the man page the
following:

> arpd -b /var/tmp/arpd.db
>       Start  arpd to collect gratuitous ARP, but not messing with ker‐
>       nel functionality.
> 
> killall arpd ; arpd -l -b /var/tmp/arpd.db
>       Look at result after some time.
> 
> arpd -b /var/tmp/arpd.db -a 1 eth0 eth1
>       Enable kernel helper, leaving leading role to kernel.
> 
> arpd -b /var/tmp/arpd.db -a 3 -k eth0 eth1
>       Completely replace kernel  resolution  on  interfaces  eth0  and
>       eth1. In this case the kernel still does unicast probing to val‐
>       idate  entries, but all the broadcast activity is suppressed and
>       made under authority of arpd.

Looks like all examples use /var/tmp/arpd.db. Maybe that means that
should be the default instead ?

(forgot to cc the list)

-- 
Max Gautier

