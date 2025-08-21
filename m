Return-Path: <netdev+bounces-215642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F30B9B2FC07
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EB47A6B38
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918B724A05B;
	Thu, 21 Aug 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ8psH2I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BB2E7160
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785581; cv=none; b=nHCtPCTNuBkViNoxsN1O05LmStGpMA2EPX000mgT0MZk8GGpbQZMiDSO3lxQwaGz9ez8XgiU5UdHpR7nMojpIqNDXFMdMj7NY4Pg/8tRAZ3OwSuTgr2x24fgOpTigVNGFKpxTCVFZrViHNI66YkDdKs63UkFBUMAUXgtHzqunJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785581; c=relaxed/simple;
	bh=MyFy2XMgrk3ht8HeMHEYRdDNepYp3/dlMqcWs1zXSTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4pNO+x8Fw4FksG93chiMYhmIIZ7HRLJexzr6FEPukeUZTaNOrbvvc/cW5+ixf7PBz0GshG/BNJKzOIxDdgdO2XRiHiA6EZaQ218zh8zm7rc7L6Lq4QfuD7OP4dO6GpCKgM1acB8cMx/3RbM0+1nPh6ZG7CJBpvcVXJkbeJiZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ8psH2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B235C4AF09;
	Thu, 21 Aug 2025 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755785580;
	bh=MyFy2XMgrk3ht8HeMHEYRdDNepYp3/dlMqcWs1zXSTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IJ8psH2IIaQ0JOMTlGiLQBR1jR8kejy3Nl+1252RmGMHZwFPb3pF4AkOfTsuQA9Kl
	 oBPw9dDRWqc3fOzT41FkmvuLazszqLg7yL+j0uRIfV6hAwLvXJ0qvmH6UdhwLWY9A5
	 un5kVv38PVpLMk+9YNI1agia14tR0HWpGddztvjrm9XS8kqGt3pFt589mh2J2hltzA
	 ZG4i7gZ8RoJyFhSqtvABAgu8CMWFSp98cHEpA+cqb/+Ph+2A/XELB+/OhJZOCZXPyn
	 DxHH961hv+YV/TqWsrzL9fdk4c243pkmMcrsvKy9NNOInSejAx8lSTMZEpCAKxkP94
	 rK3LKKRNCTOfA==
Date: Thu, 21 Aug 2025 07:12:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dsahern@gmail.com,
 netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
 dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250821071259.07059b0f@kernel.org>
In-Reply-To: <20250821110607.GC7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
	<20250816155510.03a99223@hermes.local>
	<20250818083612.68a3c137@kernel.org>
	<20250821110607.GC7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 04:06:07 -0700 Erni Sri Satya Vennela wrote:
> > Somewhat related -- what's your take on integrating / vendoring in YNL?
> > mnl doesn't provide any extack support..  
> 
> I have done some tests and found that if we install pkg-config and
> libmnl packages beforehand. The extack error messages from the kernel
> are being printed to the stdout.

Sorry, I wasn't very precise, it supports printing the string messages.
But nothing that requires actually understanding the message.
No bad attribute errors, no missing attribute errors, no policy errors.

