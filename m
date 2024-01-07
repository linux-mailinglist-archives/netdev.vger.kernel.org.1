Return-Path: <netdev+bounces-62246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187F782654D
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 18:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B3E1C20C14
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B815413AEB;
	Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyhI70OL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE7D13AE6
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27561C433C9;
	Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704648624;
	bh=NnTGTgrDUTB7sPSsBQc5+tZMs/3LkQNmhmAJwJbF7Rg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MyhI70OLMs7FgrHuaT3Z9eIG6N3WWw2JtHwzL3FQN6hzQg8g0DhxGaJj7cegEpXLE
	 TlNw5GGyBM/YIfHX5cE48hsvi9akllQyp6aMXuPR1sO7Ldb5zTlUMJzsXqh93Qe8Kh
	 gZcuh4Vf+vkv3GpdkfB/RXYQMT14Ce833wpm6geVwNIRSpn6YDAU+/wlOMfXdEw7+C
	 PxDFlxTL9zxu9+C0RlOY61az/MvCBg2ujeCZ9FoLP0xEI5+Tu54SEUgR998Hp8MM1u
	 GiaQXf6cU3Pcsy9ZNf/TmBct2dbXZo5YYydnM6TgVh3s2c6Z63k5KzETUqmeE6fCK0
	 8C1QSLayi71aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E7F9C4167F;
	Sun,  7 Jan 2024 17:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] rdma: shorten print_ lines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170464862405.7815.17485941921374147950.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jan 2024 17:30:24 +0000
References: <20240102164538.7527-1-stephen@networkplumber.org>
In-Reply-To: <20240102164538.7527-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue,  2 Jan 2024 08:45:24 -0800 you wrote:
> With the shorter form of print_ function some of the lines can
> now be shortened. Max line length in iproute2 should be 100 characters
> or less.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  rdma/dev.c     |  6 ++----
>  rdma/link.c    | 16 ++++++----------
>  rdma/res-cq.c  |  3 +--
>  rdma/res-qp.c  |  9 +++------
>  rdma/res-srq.c |  3 +--
>  rdma/res.c     | 11 ++++-------
>  rdma/stat.c    | 20 +++++++-------------
>  rdma/sys.c     | 10 +++-------
>  rdma/utils.c   | 15 +++++----------
>  9 files changed, 32 insertions(+), 61 deletions(-)

Here is the summary with links:
  - [iproute2] rdma: shorten print_ lines
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=674e00aeaba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



