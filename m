Return-Path: <netdev+bounces-169656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66EA451E8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A843317DD73
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1756BB5B;
	Wed, 26 Feb 2025 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqS0bK+z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4F190665
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531947; cv=none; b=kPpYmdk8vZYhmeod/dSQCsAT3QHl34NagWQaxgZsURaEz7KlkImbGP1ihG63eoYRLwWEZz7DbHAiWszc2TP/wvMEt02sd/RHbMkpBZQSnE+Apwnq91zm2Yj9yuBgcPNo0q9zCblvxT0cbAe/I9FQYLBaS6FSOkKbHXYGebd2+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531947; c=relaxed/simple;
	bh=AfUwPXSr1UvoSdhjUtyqk+Tp/xcTdmjlBQRE8i87+G4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iirTd36GgbDpT0aRwzwOtVeT6UmX0jLNYN4P9t2vlXRP3wRdHFP9jV9nCL3FdEwkicxmNuu6BXU0rGRlRP9sE5LyVcCYmLJ+hMAjXk6Y1pMaBorR+wbicGIxrLMDSR8xDlX9n051jOlA98ci78+Ub9/5Lcx/kQIBA5oN9jQ/s7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqS0bK+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CCBC4CEDD;
	Wed, 26 Feb 2025 01:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740531947;
	bh=AfUwPXSr1UvoSdhjUtyqk+Tp/xcTdmjlBQRE8i87+G4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oqS0bK+zKFmeR1qI2QcRDdNXQ8L2xruDFNYLX9zWLcfQCS90bANu6CUxSj8Yx391N
	 2c09Oaji5zzT0JxK/kS6XaPiXOddX6+yyt28FB1dvwvmYwlWJmh/6u82sDkiezOTLd
	 YwOFNZ9PtoOQRitRlI6P2v1jsV5o48PIFyxP84DgLEqpX08aGuuwf0D9SQhgS8GpBC
	 9x0JjQ2NwA3cOChQM8VNRahamM1ZvJX/KGI8OLnVZSodLp86rNZBg2NYiuaJtBUwkS
	 U3U3K2+ITrY03T3XctYRbYVhZNd6/a237pTii+1zz6zoDqQrkSkumJwTIxleeZDxJ7
	 PXqIOlJ89noyw==
Date: Tue, 25 Feb 2025 17:05:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ian Kumlien <ian.kumlien@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU
 read-side critical section!
Message-ID: <20250225170545.315d896c@kernel.org>
In-Reply-To: <CAA85sZuv3kqb1B-=UP0m2i-a0kfebNZy-994Dw_v5hd-PrxEGw@mail.gmail.com>
References: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
	<CAA85sZuv3kqb1B-=UP0m2i-a0kfebNZy-994Dw_v5hd-PrxEGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
> Same thing happens in 6.13.4, FYI

Could you do a minor bisection? Does it not happen with 6.11?
Nothing jumps out at quick look.

