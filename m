Return-Path: <netdev+bounces-208275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B70AB0AC95
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111FF188A62A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E231DDC37;
	Fri, 18 Jul 2025 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSCkiorf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BAD33985
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752881649; cv=none; b=Hn9zJdhox4/oq4jw5khUlsgXuxoRZWuhdZZnInpsLB00cGQSMFU/mDB2MX0aLPAHnogRjA/EHnIK7E+fvJDLQWgMefMRbI3lcU0zU5dQ8gc3OvZivIbRaXXq8UeJeokMjvRwH7iQHu5i25MM9YtBswcIc67AZir2cVdjYgn5Jao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752881649; c=relaxed/simple;
	bh=NYIQV5H2RdyZzTzBrYdYW5kl51yDCJtGSFUNVCLPMU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSMQo54NbuJBuLdaUOS1F+mnAmMtK1ps85Ujtgyf38twrs7d4xfHNRtX0Jl8CCFFLncFUYWB/6+nDBq9Prxe0j2STFo12EjgjPITEmkWuY5QmQXv/Cw5BsEaelEVzn440zzbUX1CKXX+GYcECan+nXQK+fOjP0226y+mXKTKZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSCkiorf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446F1C4CEEB;
	Fri, 18 Jul 2025 23:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752881648;
	bh=NYIQV5H2RdyZzTzBrYdYW5kl51yDCJtGSFUNVCLPMU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nSCkiorfOTqVTRsmfjp23key05iCy5DLyQvPk0NryqF8oJJptj4weZtj/Y1I/K9Cm
	 kDfWFaSge1SaInRtXHCKMZqH/4AKHTZdeDF/RtXwHeUE0bxRJj3qDov3Ef2kPP0SsF
	 HuzJkytPz2nK6kNeHCrXOCs3wy0ANFSlcVfHzvWReRzeuG+FCoTj4DUFZR2+vJu0SK
	 FUoYMa9UmvpcphGMnCTYd72lJrCgEJnSxXBBWJcYyXQ7kqJYYjnC9Ncgfl9VPUkItb
	 9iNRTEEsH01746+JhSc5BJSdFk3nUSvV9jb/QhLa5b9gIZ2gcbxH5u/u2hEaKQ/3sn
	 jqiLJEbwNQD0Q==
Date: Fri, 18 Jul 2025 16:34:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 00/13][pull request] Intel Wired LAN Driver
 Updates 2025-07-18 (idpf, ice, igc, igbvf, ixgbevf)
Message-ID: <20250718163407.1246b5fe@kernel.org>
In-Reply-To: <842e0cbe-57cf-42e0-8659-81f96e29d7bd@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
	<9d2817f0-5ee8-4133-a139-80e894f32c9f@intel.com>
	<842e0cbe-57cf-42e0-8659-81f96e29d7bd@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 15:36:36 -0700 Tony Nguyen wrote:
> On 7/18/2025 2:37 PM, Tony Nguyen wrote:
> > On 7/18/2025 11:51 AM, Tony Nguyen wrote:  
> >> For idpf:
> >> Ahmed and Sudheer add support for flow steering via ntuple filters.
> >> Current support is for IPv4 and TCP/UDP only.  
> > 
> > I blanked on the .get_rxfh_fields and .set_rxfh_fields ethtool 
> > callbacks; we'll need to adjust for that.  
> 
> Sorry, long week :( Looks like this functionality stayed in this call so 
> we don't need adjust this after all.
> 
> Did you want me to resubmit this one later or did you want to change the 
> status back?

I'll revive it, no worries :)
-- 
pw-bot: new

