Return-Path: <netdev+bounces-76022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A941686BFF0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3495AB23EF0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24CF38F80;
	Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO1tvB04"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7E3B181
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181627; cv=none; b=Shcwsf6CKHPfgH0A8PcmbozLVCgVPJkGriwLxm0QlMpaP4nzUPUD1GXSM9e+Wug/wuEaiNg2oe/RbnF7pJ2IWMDiBPeyDecFJQF0tlEbdRTmwiVTFkQQn9OVYInIr5piVKt6erdAvfqlp+zfUe3u3bsTEYynncBiJ/1JS+35UMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181627; c=relaxed/simple;
	bh=xdnuxtvE3ycioEph6Nw+oV4/DVLb/NhZyEodFQmJMBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PBUbLHwCA6nJlbSDNy2nipw6upXuX6m+ZH6EZ16fbrlW9iyQtpMbaPkn1TEaxyJGRK1RFmysdwS15han6E/npuPU8YoEnh/eGavjRRJKBYgCZWQm50gsxu/VQ6tPlrlqitIjVEpIgwSy8dBrirrdcGchHHnnLARbliXAKU4PMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO1tvB04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 559E2C43609;
	Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709181627;
	bh=xdnuxtvE3ycioEph6Nw+oV4/DVLb/NhZyEodFQmJMBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZO1tvB04PymTvxMstT8xsNdOItxipevdSN2XpgBwH+QnrFrtBi8y55jfUJ51VL/i0
	 7WxGXb87pzVLEVY6gUX1fwm8NHHq6PYcTKGc4I5ymezooAujNK3GczXGL7hFonM2D+
	 HnSsH9w7EShMDtpA4Dt1EpRJrTdcIKTcnv0LZ1yZyhId2WM9IArQWJ7GClGYaP2uPm
	 qm4jQUBYh2TGTzJWRvYFBjoyYPwZC6k7kxEBt71689phFGnHDfYk4f8GZgbp+oGGEl
	 4+KA22OPMWx8AwGPMFbuDyb6dhNeEcAd3wYsx6kk56QRGoUlXPd4aavOQZZIZFqYu5
	 yT9lGnOZIJcHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14FE8D990A7;
	Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: remove some holes in struct tcp_sock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170918162707.21906.9269286633146762240.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 04:40:27 +0000
References: <20240227192721.3558982-1-edumazet@google.com>
In-Reply-To: <20240227192721.3558982-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, namangulati@google.com, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 19:27:21 +0000 you wrote:
> By moving some fields around, this patch shrinks
> holes size from 56 to 32, saving 24 bytes on 64bit arches.
> 
> After the patch pahole gives the following for 'struct tcp_sock':
> 
> 	/* size: 2304, cachelines: 36, members: 162 */
> 	/* sum members: 2234, holes: 6, sum holes: 32 */
> 	/* sum bitfield members: 34 bits, bit holes: 5, sum bit holes: 14 bits */
> 	/* padding: 32 */
> 	/* paddings: 3, sum paddings: 10 */
> 	/* forced alignments: 1, forced holes: 1, sum forced holes: 12 */
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: remove some holes in struct tcp_sock
    https://git.kernel.org/netdev/net-next/c/99123622050f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



