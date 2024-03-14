Return-Path: <netdev+bounces-79855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102FA87BC32
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 12:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B669C1F213FD
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA986F060;
	Thu, 14 Mar 2024 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx9GaPpV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE656EB76
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417030; cv=none; b=Tm04JQSogtUi2kKv26z+WExvS2Ufbae/52ZWUaHUjyieaKXH/oQCHRwl0cSt6GnN3B4UB0u3mgHLF7/TkkrQRPTQUWwM2n0kps3kJBo0tsHbSQgeNUEA7S8t8WJvoFsXG0XTa0JLc+FxZjmrfycQecTt+gJZxwS5jqRVZt7/tPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417030; c=relaxed/simple;
	bh=K6wdvdvaF5dlIYg2PERCB3sUhg2mnENdts9pDII/+rU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GA5I6jDKjExY96IDFzIA3CTjqx/r32SWxKWKwYBW/jLhM41+GNQIf0+X++aELGpcPtLncUzg43EFJB13DLMhozz/vXorXDK48HqJvJs+qT7KtnOB6DlQcViOpGfDD8sap32ymupnsNex8vAXJncIrw6eLUvAh/+G/Zuhp+5AAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx9GaPpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3A65C43390;
	Thu, 14 Mar 2024 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710417029;
	bh=K6wdvdvaF5dlIYg2PERCB3sUhg2mnENdts9pDII/+rU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tx9GaPpV/dECj/OyFnC75AXJB5NP4Wr+XQkOQbNdy8BMmn4fereJjsRgyJVUHKH+r
	 uduHvdPNY1z5Uymr7+d0CMnAVO90Oomq/YC2Zh6SqUbO5Pwxox9hPgGgZRBVikVh05
	 n8ULawuPfeNuXVNWT1WMIqFnOsZ+Frjnz3ZD2h5XUlNWcVIgU6vWOarCOc9drWy+j5
	 JvHekP8D77FvQv3KaEDw29tpvEwWmNQPeML0usl9A8zPFeLU02BQjZ4OEANnZpriL1
	 rwSd9fCl8GVzRZgUFn1OJX6BzDbTf4Vo7GNFsG0FU0iW6SL+tPYN9T9oFxf8/C+8Wd
	 C64Y+N1K7CMdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3071D95055;
	Thu, 14 Mar 2024 11:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vmxnet3: Fix missing reserved tailroom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171041702966.3013.11175078666174379308.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 11:50:29 +0000
References: <20240309183147.28222-1-witu@nvidia.com>
In-Reply-To: <20240309183147.28222-1-witu@nvidia.com>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, u9012063@gmail.com, micron10@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 9 Mar 2024 20:31:47 +0200 you wrote:
> Use rbi->len instead of rcd->len for non-dataring packet.
> 
> Found issue:
>   XDP_WARN: xdp_update_frame_from_buff(line:278): Driver BUG: missing reserved tailroom
>   WARNING: CPU: 0 PID: 0 at net/core/xdp.c:586 xdp_warn+0xf/0x20
>   CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O       6.5.1 #1
>   RIP: 0010:xdp_warn+0xf/0x20
>   ...
>   ? xdp_warn+0xf/0x20
>   xdp_do_redirect+0x15f/0x1c0
>   vmxnet3_run_xdp+0x17a/0x400 [vmxnet3]
>   vmxnet3_process_xdp+0xe4/0x760 [vmxnet3]
>   ? vmxnet3_tq_tx_complete.isra.0+0x21e/0x2c0 [vmxnet3]
>   vmxnet3_rq_rx_complete+0x7ad/0x1120 [vmxnet3]
>   vmxnet3_poll_rx_only+0x2d/0xa0 [vmxnet3]
>   __napi_poll+0x20/0x180
>   net_rx_action+0x177/0x390
> 
> [...]

Here is the summary with links:
  - [net] vmxnet3: Fix missing reserved tailroom
    https://git.kernel.org/netdev/net/c/e127ce7699c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



