Return-Path: <netdev+bounces-97359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBDD8CB00D
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 16:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94542838A9
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB617F7CE;
	Tue, 21 May 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngBK63Z3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9257F7C8
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300486; cv=none; b=Gn23riOf1C00IGwG5k66Ct8KE1L1LVOSi2yRaLwTRnlKo6ghRiH/rzuqWno+cnTOG9uMds5UDRIfyvcAYyBAbnUco1WobqLrF64H3mXLuYl8141uYb6LHIoAU2/b4iAE1xZiZ2A4kU4JPU4TIGwqDz3XVTdMU3bTx228vhCG0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300486; c=relaxed/simple;
	bh=rKYukvrI5TbGiEI6itS2BS5Fa/jpJmyU1H2tO7zeKd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPGUH6kpb1h0VL8oNl71TsBsDU8T5IbESRwyWpetsLQHy9qfYD5tyn40DZpTngmDPcYuk/h2S6/qfhsVAFBJdi70ILwGYCcY9+JzF0ilfOyLjrW+crcvQb3DFM9ra3+6G/83RHFS8t9Re3Wgh/H+sqd0Jt1zTAERjW+YZ0o49Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngBK63Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD99C32786;
	Tue, 21 May 2024 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716300485;
	bh=rKYukvrI5TbGiEI6itS2BS5Fa/jpJmyU1H2tO7zeKd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngBK63Z3Ail2UgiJU3h+fvXxDm20KzVjjj/PTMgBAcqUykNv6IMP74oGVznicnry+
	 2SoKUtci3kApVsD81ryE6Ap9EvfFyWyHZPIHPTnbCF9NynI0B804yoaXKj0zUnMaR0
	 t4EC18c9rqb4Age+CKalYi3NmsFvg7L/i96I4R4y5/5c74pYdGTAaQlHa/BcN5HOBP
	 5PXnkIVv5F1+zzyosWIlp87gbSw6wD55a8IbbpQ85660AROvY3xXpaxEAE31HBQ60d
	 mCGKf2YTaiK9SafuqSN1It6Li2669UEwf3B6LivuXAtry7XXsRA4vA/Do+ksldpzpN
	 HdKncLk4qaNqg==
Date: Tue, 21 May 2024 15:06:31 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
	drivers@pensando.io
Subject: Re: [PATCH net 0/7] ionic: small fixes for 6.10
Message-ID: <20240521140631.GF764145@kernel.org>
References: <20240521013715.12098-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521013715.12098-1-shannon.nelson@amd.com>

On Mon, May 20, 2024 at 06:37:08PM -0700, Shannon Nelson wrote:
> These are a few minor fixes for the ionic driver to clean
> up a some little things that have been waiting for attention.
> 
> Brett Creeley (3):
>   ionic: Pass ionic_txq_desc to ionic_tx_tso_post
>   ionic: Mark error paths in the data path as unlikely
>   ionic: Use netdev_name() function instead of netdev->name
> 
> Shannon Nelson (4):
>   ionic: fix potential irq name truncation
>   ionic: Reset LIF device while restarting LIF
>   ionic: only sync frag_len in first buffer of xdp
>   ionic: fix up ionic_if.h kernel-doc issues

Hi Shannon and Brett,

All of these patches look like good improvements to me.
However, it is only obvious to me why patch 2/7 is a bug fix
suitable for net. Would the other patches be better targeted
at net-next once it reopens?

