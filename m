Return-Path: <netdev+bounces-115363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BDA945FCE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615861F22BF4
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593082139B6;
	Fri,  2 Aug 2024 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8ykICnu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D8B2139A2
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610910; cv=none; b=BlIecqaKtLGIB7DR8X+1JWXc7tvoyuXfHfCvvzVdyLYXGKzHhfS6UZ7R5VjmUnE2v6x79VXx35NMg+M1NPvQQomVKRGUNwWjxptJudI/PgHAHMCLZ1LwwOFDmUxZCL5s12wRvXoXhOihRTN4pUag85Cx/oWo3BCtW0JTwVAVgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610910; c=relaxed/simple;
	bh=ijYQDnHqWDf8gx+zcfEzq/82UW/8PtNr0g1u3y3auIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWPJky0WDvGjtVXQitr/0MXhI0xFYJI2EvN5l+UI/A86LGN//HPXIx0d6I4kwNi2fRVfCmp6D7EJLNOR5eesf/DQyCzwqGaXJIQRKG+nIoMgtiFpyHy7K4vcaQpf5ICQXtwzovofjHE0JdAJ4pxa70mNpDo0Gl3HB+7PPCWJGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8ykICnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831ACC32782;
	Fri,  2 Aug 2024 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722610909;
	bh=ijYQDnHqWDf8gx+zcfEzq/82UW/8PtNr0g1u3y3auIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o8ykICnuQg+QbyDVGd+yzu5tiZ/4V6SrG8m5/y0sVaoTV/mW5qFiEyQBvCEUYqFaI
	 FzkRofIzLFmGPP5hHAjy8TqHsRn5SGcr5eoAeH12JNtPmaH8PeVPX4n2pXKUH/zNPP
	 t02B4DLv5efeXCjClW61uy/pDrNkrwFd9oItZijcU+VJNHy+Nq1jR9OKaOi98oCZEi
	 UX8OmkyYydKkQw85878DK8fx+K9gcNmoOKgJdqdQcNX/4mAMnI60s7zEVBlIkp7okR
	 LDFBA3nQmohmbOic9fd0TW6dPztrybAwbas2aJ9NaYyYs8w4PdDGotfAyYPraa+HfP
	 OoMP9roag85NQ==
Date: Fri, 2 Aug 2024 08:01:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, kernel test robot <lkp@intel.com>, alexanderduyck@fb.com
Subject: Re: [PATCH net] eth: fbnic: select devlink
Message-ID: <20240802080148.53366633@kernel.org>
In-Reply-To: <20240802145038.GE2504122@kernel.org>
References: <20240802015924.624368-1-kuba@kernel.org>
	<20240802145038.GE2504122@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Aug 2024 15:50:38 +0100 Simon Horman wrote:
> But while exercising this I noticed that PAGE_POOL is also needed,
> which I locally resolved by adding:

Oh, good catch. I'm a bit surprised how slow kbuild bot is :(
 
> 	select PAGE_POOL
> 
> I can provide a follow-up patch after this one is merged.
> Or perhaps you can address this in a v2?
> I have no preference either way.

Please send your version with both selects, I'll mark mine as superseded

