Return-Path: <netdev+bounces-111503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C76393164E
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB07B208F5
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088E818E76A;
	Mon, 15 Jul 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpQn2xuh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E418C35B;
	Mon, 15 Jul 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052094; cv=none; b=pp/g4aWat2kgjzwLbAnCxGO+wnwYvDPGvc8NYjXvGQxQGRgS15gSNAJpj0SuZxIxsQUT+fTK7+hPyBmG6PdgtFvb+xL73KmmVcu29CMZDGYNgoIIKzoYLYUXagkJlegz4CmbUYcthP0sr0rqM3dgz91DDYa4mvM/sUeXRSrLCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052094; c=relaxed/simple;
	bh=TeIlN+pxRlMLbfTJ9SKGctyyYOJ1QdfFvrULVFnZ00Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpByUmh6HyOJhNNaBDowI0IWHvH+ebQeOBzRV/gdxCvyqZEngGFY16CjVcUhU77qnGquOy3fXwDvAUttzLnnNMGkTmnDXdAgvM9Jq4Injp63KEeRTtzu5oBl1z3zUCjO69J+iQzZJTjnSWrroLJz5MbWkx4MMxx0n/9WXwUTKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpQn2xuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36098C32782;
	Mon, 15 Jul 2024 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721052094;
	bh=TeIlN+pxRlMLbfTJ9SKGctyyYOJ1QdfFvrULVFnZ00Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tpQn2xuhwUr+2Ai9lxYrNnE0arz2Y+mtQrLlJgyW9w2DxvSK8mJ2idLGZ2LB2ThVy
	 2dg9sc0KOZg+VbZMZJRxafb98csGAJxTgYJUYxGgS5mHiowMq40wNdT1XxybocCfvb
	 mzde4yqq9OLNfnIRAt83e4j+ifKJZfrJXuY62w0OWkb80JzHhWTtAbYGw0gxSMos7d
	 aZqgsKtdtkh9hVX6x59i1pwtlcmO7bw4tw3+C2wN8wsEFfkvGx5S69imlwqubh6mPh
	 v5289ktKncsEo0pw1R+p409djZ1TXYeh5GwT6ee4/0iiAArSfb0r0O5nZ1cn16dqCx
	 gVVENvftmFGAQ==
Date: Mon, 15 Jul 2024 07:01:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2024-07-14
Message-ID: <20240715070133.63140316@kernel.org>
In-Reply-To: <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
References: <20240715015726.240980-1-luiz.dentz@gmail.com>
	<20240715064939.644536f3@kernel.org>
	<CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 15:55:56 +0200 Bartosz Golaszewski wrote:
> Luiz pulled the immutable branch I provided (on which my PR to Linus
> is based) but I no longer see the Merge commit in the bluetooth-next
> tree[1]. Most likely a bad rebase.
> 
> Luiz: please make sure to let Linus (or whomever your upstream is)
> know about this. I'm afraid there's not much we can do now, the
> commits will appear twice in mainline. :(

If Luiz does rebases, maybe he could rebase, drop the patches and
re-pull again? Or, you know, re-pull in the middle of a rebase
so that build doesn't break. Should be pretty.. doable.. ?

