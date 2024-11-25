Return-Path: <netdev+bounces-147119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD089D794F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90980B20FDE
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF42C17D2;
	Mon, 25 Nov 2024 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDUKvZHe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35B1372;
	Mon, 25 Nov 2024 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732494109; cv=none; b=iR52DF1113fvA4ZxEqBIlwaIY8jY8uzno1E+kaDVbKGjDpspdSi3WzokzGVIfv0JV5NUh6iQjzxtdZb8r2PM4x1QWUVhfoBp4wfDmgZcnfza+I3+w4ph3X6kkGbfmxa8qrVNzvTb/gKoBL2hHOZ8FSx97RIhALeB/kErsvmKw3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732494109; c=relaxed/simple;
	bh=ySb5iph48rF33sNgYjYhTOU5DnfrzG1oaqong6mJyKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUDXA3oBT/MJtmLZZy/N4LNswYa7/woGyL1oFvDNtuUS9LdYhpqR23J5D3qN4EGdY5Z3kFoVawVxBpynLWqo0Km995vB1N+n+oAjybTKXyfBxij1yDtRhxRMian9Px3uU+4MaCE7AKaNFsmKzzBBngoqnBvV9/o3zEi03ZLLNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDUKvZHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6450CC4CED1;
	Mon, 25 Nov 2024 00:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732494109;
	bh=ySb5iph48rF33sNgYjYhTOU5DnfrzG1oaqong6mJyKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QDUKvZHep1+LpC71s216IRnlHvpNl9AEcAk1DBy4oQxp44p3I8Wlzq4oqhEfnRg0R
	 rIwOYh+Tj+32xsKofFzLy5YUR8mxUo5oKtAiQn2iHPQL+JAoMOpiEe8ioX8xzZoGGT
	 LIuQuhESCPVp/yVDDQnRUlCtdp6YqKhYP1x02e52nOQVQHeRbERHps8XLg9KahLXL/
	 RUaSvoc800186wUjv28h7ltdMoNNcPw211hGdYpmFoL38KWHtvfft0I5x0bOMphPl8
	 TuPMyeZm7eiYv3DKa9nk0M0PTpTdNnzoe7BbDLzPP0BbaZgnvQ3Rm7zxGM+kZ0xj17
	 AGessry1ZQxrw==
Date: Sun, 24 Nov 2024 16:21:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Catdeo Zhang <catdeo.zhang@unisoc.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <cixi.geng@linux.dev>, <wade.shu@unisoc.com>, <jiawang.yu@unisoc.com>,
 <hehe.li@unisoc.com>
Subject: Re: [PATCH] net/sipa: Spreadtrum IPA driver code
Message-ID: <20241124162147.4508d22c@kernel.org>
In-Reply-To: <20241122014541.1234644-1-catdeo.zhang@unisoc.com>
References: <20241122014541.1234644-1-catdeo.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 09:45:41 +0800 Catdeo Zhang wrote:
> This is a first patch which upload the ipa driver code. IPA is an IP Packet Accelerator developed
> by Spreadtrum included in some Socs, which can provide packet filtering, forwarding etc.

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new drivers,
features, code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


