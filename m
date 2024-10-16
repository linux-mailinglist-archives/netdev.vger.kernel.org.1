Return-Path: <netdev+bounces-135988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EB999FE63
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64431C21AE6
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772C913E40F;
	Wed, 16 Oct 2024 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5fTlO5s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18C13D53B;
	Wed, 16 Oct 2024 01:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042596; cv=none; b=GTC4YCAHysH+fTwAEydsa2lFpscFHflPy3zM2AxmPLTGt5Kspt422Nr5B8MrL3O454N2MHOcezxoqgrBsULm0XwVMOYDvC3B+45PcjrV6CQ1fYA8ZbzR134NhQBik9RYeXJFgo8OgwnNYxk8e7Xb3bbjiKDVQCvySYrMeUiAHgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042596; c=relaxed/simple;
	bh=KQs8c39gTuB1VefLz7m4qSUhRHznzbpNoJCe8C/EY9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpvF67X1nUOmh4kNTz4Ro+Qhxt4ay0yqT4FV/2JaqvgxWXDNHolLzfywFw+JsMiF0HexL8vxBLSrBilDQ4PUxpw/SHps3pqkGA1y8FsIuowKMh+3kGG7e5jt9C8orW6nimzR90TbLom4bW01yba5XwwGA4mW5gxhJHeECTpzmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5fTlO5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E235C4CEC6;
	Wed, 16 Oct 2024 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729042595;
	bh=KQs8c39gTuB1VefLz7m4qSUhRHznzbpNoJCe8C/EY9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T5fTlO5soBPadX3BTJ2x2DV/+IP3qR32vPmOi43REhRiDEDxmxPO3bWeLeY4KXThF
	 FPU20hb03CSRTFp8msDwN0er/8YOrPwAREAFFUWVIrrwdJDv9GlVYW92ejC8rQJyqW
	 k7xMnAjah9VjuqRblFWFzuaM0peyP3Zbizuzay886FgqpvlmIDmb86jRQ3kKSmkXCY
	 0pyXsBq6C4uVKSxre2GU9OAZf6aJpMAZ6857XVaRN5bu6rMhmMh1LhkGaujL4YeL94
	 aPPWgtGqw5BRW7yHxGD2xedO0COGizZt0n2jXYeHTHvJ78oWJIsby8eom28p6HLXhR
	 aqBh3ZrzQH9wA==
Date: Tue, 15 Oct 2024 18:36:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: Use str_enabled_disabled()
Message-ID: <20241015183634.5a64740b@kernel.org>
In-Reply-To: <20241015121300.1601108-1-roheetchavan@gmail.com>
References: <20241015121300.1601108-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 17:43:00 +0530 Rohit Chavan wrote:
>  Use str_enabled_disabled() helper instead of open coding the same.

I think this falls under clean ups, please see:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches

