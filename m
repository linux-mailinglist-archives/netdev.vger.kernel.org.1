Return-Path: <netdev+bounces-215610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2D0B2F80D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5933A990C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEC130EF9C;
	Thu, 21 Aug 2025 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HI6mVSyM"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24AF2F5E
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779496; cv=none; b=ElCKh8xDC3OoUfVHzeMMHZ+rAUIOnu0k2gDI/9JPA76oDufT8nGdphAFyJ0IMyBHp7SENk+GYLPZsPkHujuRaNs+lzbtz5VvZabT5EpmtkO41bY1nRTLiFfPRZwfOFRRIrCzbVlMFhs5utKcllxDg2Y9drBk8g9nfEWX9TrAFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779496; c=relaxed/simple;
	bh=njKY15hGc+dMqrtzrwBA8umfUwTNYx/s9vdbKXNbyFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXZKXgCsAfI3GyIPqixWaDsXEap9SM3aDiHSUwlppDax41YE0h9NZXS2Da2ylkbv5hg5RgWpa/ITPPHBuraXmvEgWYHL9bhUfUxvtDD+3M6j0lLeOCAU7sSAgIbaGt8OiAMqIUoS0NPRV5Fcuj7EzN9gWzDmBWOFnvtXHPNKo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HI6mVSyM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 982CE2115A5F; Thu, 21 Aug 2025 05:31:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 982CE2115A5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755779494;
	bh=4KvkEgGYEwO19yBArhSOsaxuLbp/FcuULsjMt/wUi54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HI6mVSyMdim+X11ofXvJK7LNdphsXWrI6pbs/GWY2Yrt6U8gUluocmj1I+gWITy8b
	 bynvCm2cESsJxiQCQUOMt5466osnMTINqGmdf9yQeA7mfE+b/2I8QNYxYwYmXOwsmd
	 Q6w6Y1SpcXHuP+BnxulFTXrnumBEdQItFmaXuoHc=
Date: Thu, 21 Aug 2025 05:31:34 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
	dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250821123134.GD7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
 <20250816155510.03a99223@hermes.local>
 <20250818083612.68a3c137@kernel.org>
 <31e038a1-5a17-4c13-bf37-d07cbccd7056@gmail.com>
 <20250818090010.1201f52a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818090010.1201f52a@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Aug 18, 2025 at 09:00:10AM -0700, Jakub Kicinski wrote:
> On Mon, 18 Aug 2025 09:41:29 -0600 David Ahern wrote:
> > On 8/18/25 9:36 AM, Jakub Kicinski wrote:
> > > Somewhat related -- what's your take on integrating / vendoring in YNL?  
> > 
> > I feel like this has been brought up a few times.
> > 
> > Is there a specific proposal or any patches to review?
> 
> Not AFAIK. Erni is being asked to rethink his approach here, and 
> if we're going with a new command perhaps YNL should be on the table.
> 
Thank you for the feedback and for suggesting integration with the ynl
tool.

For the current implementation, I have followed your earlier guidance
( while implementing bandwidth clamping for MANA interface ) and used 
netlink commands similar to those used by ynl to support netshaper
operations from the kernel.

Ref: https://lore.kernel.org/all/20250421170349.003861f2@kernel.org/

> I'd be very interested to get a final ruling on YNL integration 
> into iproute2 -- given its inability to work as a shared object /
> library it's not unreasonable for the answer to be "no". 

This approach, to use netshaper as separate command in iproute2, seemed
like the most practical path forward to address shaping support without
introducing additional complexity.
> 
> The page pool sample in the kernel sources is very useful, I find
> myself copying to various systems during debug. If there's no clear
> path to YNL integration with iproute2 it's time for that sample to
> be come a real CLI tool.

