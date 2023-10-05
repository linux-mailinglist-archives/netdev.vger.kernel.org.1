Return-Path: <netdev+bounces-38239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611EE7B9D56
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8AF981C2085B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F28C1BDC4;
	Thu,  5 Oct 2023 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv5KQDod"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532FE1170F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E150BC4AF6D;
	Thu,  5 Oct 2023 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696512823;
	bh=FLFFream6GLJssZcRVYNHHFRQkpW/ViFisAKObzHVY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fv5KQDodWZv6jCAxC1cbX9f0uOyfoqxArpuNVTGT7ymEgZP4QtFDnVfsxbp+5mEk0
	 lzr/NIRv+n1+XVIHNHVDG0Ar8TZfYonh+wbm5Nf2ukWLJuFZZizOOROz3gS24VGLiC
	 b7tVTF27a9AkayA4U6XpEaUXS01M40egwU0DOhTficdR8o/M+0zHsoFonUULoaAmSh
	 Wm1s12uI3MlleCi4tcQqIYx7U0k/8UBHJXRGmxOdpf4r/K/JKMe1d872hpTUB8F9Cl
	 aSCUVeLxIXL8IxrPFaNebVlUTgZVDjTxpxcqIJ/Dq4NgE7ozWtQr8qbhAB+f7LJN7e
	 qiAHgRZl4XPEA==
Date: Thu, 5 Oct 2023 15:33:39 +0200
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Chengfeng Ye <dg573847474@gmail.com>, jreuter@yaina.de,
	ralf@linux-mips.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-hams@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ax25: Fix potential deadlock on &ax25_list_lock
Message-ID: <ZR67M1qVmltomrml@kernel.org>
References: <20230926105732.10864-1-dg573847474@gmail.com>
 <20230930161434.GC92317@kernel.org>
 <20231004105317.212f1207@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004105317.212f1207@kernel.org>

On Wed, Oct 04, 2023 at 10:53:17AM -0700, Jakub Kicinski wrote:
> On Sat, 30 Sep 2023 18:14:34 +0200 Simon Horman wrote:
> > And as a fix this patch should probably have a Fixes tag.
> > This ones seem appropriate to me, but I could be wrong.
> > 
> > Fixes: c070e51db5e2 ("ice: always add legacy 32byte RXDID in supported_rxdids")
> 
> You must have mis-pasted this Fixes tag :)

Yes, sorry about that.

> Chengfend, please find the right Fixes tag and repost.

