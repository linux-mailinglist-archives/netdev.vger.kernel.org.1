Return-Path: <netdev+bounces-215465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1182B2EB61
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E761C88637
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454525A320;
	Thu, 21 Aug 2025 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsfbA1m/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB215258EE6
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744026; cv=none; b=W/AxSCKRRerXOg10f0qxvWfM4v96Sg3dBOcpUEuHhda4Nz+zJf+mv7Jg5kh3lzE+7JUJXMvkpzt1k7oLQy+EbjUSN8XzFEpgJy6LdrZTjDYJYiC7NnfSsF+k+GrENa8WyIEkzMs3Hw+1e6LHL3gRILuc9eyTq4ql5YV8TB5EQFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744026; c=relaxed/simple;
	bh=c29pNNL5cBof2QgXaD1NRmip5Ia3hE7syRPzKhyq5zs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nlblD2W48s7sKMEadz0g+hkvQhIu1ErQZMreQ6iDHUQyqWsQvQm9gTcPj0m9izomkJzGR7yJAtxUgOeNiWrXm8rferVuCXrOVgj5XWWBBYLa7O2EeCI/FKikdZccbNhGC1IRRuAv/IIV9zBzQ5JXowLrEvO7sGrSkC2nvmhreUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsfbA1m/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D77C4CEE7;
	Thu, 21 Aug 2025 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744026;
	bh=c29pNNL5cBof2QgXaD1NRmip5Ia3hE7syRPzKhyq5zs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LsfbA1m/JdAt+NdUhoGAy+e/2NVStrXd/KWRaWO3/87of7v2CCIaNMUBYyvctA1hK
	 uZZTlHG/fFfl16Y+omaj1c5IyMnLV62CwUVwz/Hy2iAHeMR3/ZCJzyPvs23yKKwBYZ
	 EXw54MMQHhvGKTg24YRU1Mv+VG7wMGK6VLZ47Lb+m8nvcXiwM9s3CeQq+m8IyDffqZ
	 +pgQIedt/A3FO/mfP48lr4bc2BKW4R4xXi4E/oLKxt+DRNyBfaYR2VHkHkQP5AUDCZ
	 dV4TOj2mHCglwlosAUUA9VfPTOeWR4+DYCZa3jbcsHZe+H7fclg7DXRM45v+eVqJTq
	 3K7R6warvTBig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A77383BF4E;
	Thu, 21 Aug 2025 02:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: set net.core.rmem_max and net.core.wmem_max
 to
 4 MB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574403599.482952.17071662130404818536.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:40:35 +0000
References: <20250819174030.1986278-1-edumazet@google.com>
In-Reply-To: <20250819174030.1986278-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 17:40:30 +0000 you wrote:
> SO_RCVBUF and SO_SNDBUF have limited range today, unless
> distros or system admins change rmem_max and wmem_max.
> 
> Even iproute2 uses 1 MB SO_RCVBUF which is capped by
> the kernel.
> 
> Decouple [rw]mem_max and [rw]mem_default and increase
> [rw]mem_max to 4 MB.
> 
> [...]

Here is the summary with links:
  - [net-next] net: set net.core.rmem_max and net.core.wmem_max to 4 MB
    https://git.kernel.org/netdev/net-next/c/a6d4f25888b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



