Return-Path: <netdev+bounces-227683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C093BB587F
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 00:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83EB74E3A61
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 22:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CFE2248B8;
	Thu,  2 Oct 2025 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gidLQL7F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C214501A
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443094; cv=none; b=f7MRxeVAPusszzKwGoOQBHvoFi+7P4E1rNaRTzAxuAYIDF38ZOkXY2lk6phLwZ8ndaWO2H53pxnMUB5+KaU+tMCKNNllDPesMbCWCEnamh8LpmjIDFQar3RKYE5b6squHhQT8J/IcfNSxyr33ILbnccAQtNrqWI9qmCUh7GXrms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443094; c=relaxed/simple;
	bh=YbvVWEJRy5o7S9L2fzQyFzc/iqUFFq70EebSdTWSjRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoPS9Rq9KxhbN8KZSqIxBejIClHp6GNGU17OK0oai98yDyx3463zgwsetvhlyfmxo61KRcSfAYHaEP0l+t3nbSuACzOKLBSwHbq2q2EbIxXXD5FBGN4M2ZhP34IzxmPVOX1TI6vCbPUexFRo32UeG4yN0gxTe1rKb56lEn+RGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gidLQL7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E376C4CEF4;
	Thu,  2 Oct 2025 22:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759443094;
	bh=YbvVWEJRy5o7S9L2fzQyFzc/iqUFFq70EebSdTWSjRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gidLQL7FtyoJUqPhIGvsYIxAW0PouC5mjIHAqR4TSq8EDbwmoIZ3kzfNdxpF7rN4t
	 yexPZ9Y8QE0RoZxXA9KLCDRocToXW5G2QgWeuFCkRk3zHXWiUAdWUZ6pU2Cky96Q+M
	 xM1nsL3y1KrkdjD9NVXPKUJXP73Cd9P0buyHJ4yNwrAXhJldnG3goNg5M7YkCMEv00
	 h3FkqfYW48dZlJyVe5IYNWu5cZm2zvL+7bsdEUrnuywn2mkB2adMpB5/mZTxPNeKvt
	 MngNowi7+RoeyCzgRujGEgrBbdHl/GCxTqPvv6vW0Zc1i1uOoqwwghidx5cVHnTLaf
	 YCmdgvswa3Lng==
Date: Thu, 2 Oct 2025 15:11:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] doc/netlink: Expand nftables specification
Message-ID: <20251002151133.6a8db5ea@kernel.org>
In-Reply-To: <20251002184950.1033210-1-one-d-wide@protonmail.com>
References: <20251002184950.1033210-1-one-d-wide@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Oct 2025 18:50:17 +0000 Remy D. Farley wrote:
> Getting out changes I've accumulated while making nftables spec to work with
> Rust netlink-bindings. Hopefully, this will be useful upstream.

Hi Remy!

Could you try running 

	make -C tools/net/ynl/ -j

in the kernel tree?

Looks like there is an issue either with this patch or the ReST
generator we have to render the docs. I get:

  WARNING:root:Failed to parse ../../../../Documentation/netlink/specs/nftables.yaml.
  WARNING:root:'doc'

And also the test bot spits out:

  Sphinx parallel build error:
  KeyError: 'doc'

https://netdev-3.bots.linux.dev/doc-build/results/323981/stderr
-- 
pw-bot: cr

