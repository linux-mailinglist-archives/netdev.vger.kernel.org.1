Return-Path: <netdev+bounces-22951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D10E76A2B5
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE4E2814F3
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7311E505;
	Mon, 31 Jul 2023 21:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498F1DDF5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0F3CC433CA;
	Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690839022;
	bh=XHqN9wzw3qixfXK047P0G7gUorvlxDRZG6we3e3s6l0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q61XHMFRp0IfwgaPm/h+3vTLQVxw4bda2OB4Xa+elynm9fjjZ4G3YJ7gUiDyJcsGK
	 OOXBJ72E54Jgg4E22HG4sbcMCLtsQRAuP5dM/7/2znI/BNOkMwKHNtooniqcKicz7o
	 dst6zzG5lFb/5HeUYJd+VRlyglQto3t7VYZw3VNPWmkMuVWkLnP80h61QW0s95SkjI
	 RN7YjfReRAi2V5zV3+lsbTICV5Q/hPYn9gD108N97AbqufGbnMex9eyZE3NwQIiIZI
	 Bi0QR60VOOnTIi04gNJTD5vEtm6WsvdDUVCionRNm10240TeVsomFSsfq8MarZwEsM
	 cm+TeaeH+Z/TA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F111E96AC0;
	Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: fix field-spanning memcpy in selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169083902250.31832.4198008992222822559.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:30:22 +0000
References: <20230728165528.59070-1-edward.cree@amd.com>
In-Reply-To: <20230728165528.59070-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com, andy.moreton@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 17:55:28 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Add a struct_group for the whole packet body so we can copy it in one
>  go without triggering FORTIFY_SOURCE complaints.
> 
> Fixes: cf60ed469629 ("sfc: use padding to fix alignment in loopback test")
> Fixes: 30c24dd87f3f ("sfc: siena: use padding to fix alignment in loopback test")
> Fixes: 1186c6b31ee1 ("sfc: falcon: use padding to fix alignment in loopback test")
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> Tested-by: Andy Moreton <andy.moreton@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] sfc: fix field-spanning memcpy in selftest
    https://git.kernel.org/netdev/net/c/55c1528f9b97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



