Return-Path: <netdev+bounces-151857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF89F15B3
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81039188D5FB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66AF1EBA0B;
	Fri, 13 Dec 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn5Je+hS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271D1EBA08
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734117615; cv=none; b=i6S3IWdlhmz3TIQMef2wv2u0BAkgFg0B68xanRPIxeMq3vY2DCJHXaEf9lVHK/Gv8ryuFgHm0AoWFL0EUCk1WYI4Ka+NTByoD9T9Yjyqasu4jB2Hjg2KYrAVzLodquQwVYATqK/eYi+dHvv6yg3wT+WvfAWoM+HGbzz1bwswQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734117615; c=relaxed/simple;
	bh=eVuZWi67aoRI0XV9UmExC9wTF5sPMtNeJAN+EcpgxOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dF/0DvJravlpVbrotzHrv8UYHUPR9q/9gwu48OJ8xN72B/Xzq3+MT6Gxbc0OsUuZwZIVYGYelcVnUYnEL2on2ZG5J5i5zSKj2dz4Bz3Nn8eC2zfTUBbtZfTGklerDvsD9VzFg5rLbOb+Q8a4aepADZjuzqfJbyYWoWnyXU9lXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn5Je+hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA83C4CED4;
	Fri, 13 Dec 2024 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734117614;
	bh=eVuZWi67aoRI0XV9UmExC9wTF5sPMtNeJAN+EcpgxOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nn5Je+hSsgHFSQR2yR0qS9eZkC7clRc62+Zw30YqNlRciDq16iOgzQNuHyGv7Lr+T
	 wZfO/QozH4eLEn31jP06BWEyZxCaBGa8hf8+SYqpHgNtkvTLuCke6k9RKaSRdW+Spe
	 n+xJefD5iONHQCqXWngTOVZ/nHnpo/03dCM00F4IsizXU32CYVqYV0GJoBGJJfyyGH
	 /7oB2Qe9rLYqOrq2aEOwNwnf+UHHhBHLaHPuBYICOhS8AE1uHS9hILSVsAIeVO4sG9
	 v7Cz20dWF4rJxzb6YMdOg728FPjK/aOwmBnFek64xZnDLXeBqh9q92J27VBD1pyHTF
	 zEoPy0UlbYDRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2A9380A959;
	Fri, 13 Dec 2024 19:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/6] include file changes for musl libc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173411763075.3136442.14771888577615672730.git-patchwork-notify@kernel.org>
Date: Fri, 13 Dec 2024 19:20:30 +0000
References: <20241212222549.43749-1-stephen@networkplumber.org>
In-Reply-To: <20241212222549.43749-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 12 Dec 2024 14:24:25 -0800 you wrote:
> This is a set of patches to address some of the include file
> issues identified by building on a musl libc based system (Alpine).
> 
> Stephen Hemminger (6):
>   libnetlink: add missing endian.h
>   rdma: add missing header for basename
>   ip: rearrange and prune header files
>   cg_map: use limits.h
>   flower: replace XATTR_SIZE_MAX
>   uapi: remove no longer used linux/limits.h
> 
> [...]

Here is the summary with links:
  - [iproute2,1/6] libnetlink: add missing endian.h
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c8b3ecc22ed0
  - [iproute2,2/6] rdma: add missing header for basename
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=fa3949b792e2
  - [iproute2,3/6] ip: rearrange and prune header files
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=7e23da91fca6
  - [iproute2,4/6] cg_map: use limits.h
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f982f30e166a
  - [iproute2,5/6] flower: replace XATTR_SIZE_MAX
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ac547ad027e3
  - [iproute2,6/6] uapi: remove no longer used linux/limits.h
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=458dce5d0431

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



