Return-Path: <netdev+bounces-230629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F827BEC106
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE786E58CC
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAC286D6D;
	Sat, 18 Oct 2025 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD4mczsl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE1335BA;
	Sat, 18 Oct 2025 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745631; cv=none; b=FDqfy654pRcwA9Wl9hoh5MHMTsvd4PrstxwbAca3qsoca5DX6UuWnhq+lKeuCrZmEldcsZKc2ckrLU5pNNyIszUZSBPBUR4Ky8vk0Fi5u+uVL2blVpwj+4tqcgnuACouCluKBCjL8Xtj4Z3rJPnRUu/JNMH7xBUqfOXR/t50DTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745631; c=relaxed/simple;
	bh=Y9jEbxvXW1zlR7DvYBO+PFoOwd8tSJ68hgpMl+Ypi0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HKtfamyioulNRzMy3TfdYza6gz1cbs5cudunutl4hnZfxdWoN5MSh+wD4G98RMl0xLC5UzxFhx9F6w7sm9mjRtjbkFqKXFczOZqXDpftBRXKXOIAYthvrKGfOB4LC1MJwDofpZzSGR7Af1fZOQzdT+e8A9GMZKw6vGZi2MeHMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD4mczsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416A4C4CEE7;
	Sat, 18 Oct 2025 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760745631;
	bh=Y9jEbxvXW1zlR7DvYBO+PFoOwd8tSJ68hgpMl+Ypi0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XD4mczslteMoZ0OYnURSnmHRK3R5bBOZKVlquxONANYyM7fNwX6eoo/WJeHIiw+/F
	 8Vk8DYYSjywmCwKEWDWStNlK58qNrgdS9K+9BivzUmQ1rMG7MtaU0iJIgM9HYKyFl6
	 IprgnaY8xNYQ3scM8GD2J401Q9ktdhfXEHQskG8a37AgUzTXn7h5FbNXznQyhbXeTt
	 113uePDdVdBUQF+26sXf0sYQVLjQeWBnyHWM+chXLVj2vsoxVh2hv3OmIb3kzmRGMW
	 DnzinpP1fCh6l6tHSjGl+LiPD1AfMjZOMAMYjQym/WNx+uf0GZEV02vXiHTiz0VpN+
	 C7DwHnRy6m7CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB34439EFA61;
	Sat, 18 Oct 2025 00:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] Documentation: net: net_failover: Separate
 cloud-ifupdown-helper and reattach-vf.sh code blocks marker
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074561449.2830883.10548185381553170961.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 00:00:14 +0000
References: <20251016093936.29442-2-bagasdotme@gmail.com>
In-Reply-To: <20251016093936.29442-2-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, sridhar.samudrala@intel.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, krikku@gmail.com, vasudev@copyninja.info

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 16:39:37 +0700 you wrote:
> cloud-ifupdown-helper patch and reattach-vf.sh script are rendered in
> htmldocs output as normal paragraphs instead of literal code blocks
> due to missing separator from respective code block marker. Add it.
> 
> Fixes: 738baea4970b ("Documentation: networking: net_failover: Fix documentation")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] Documentation: net: net_failover: Separate cloud-ifupdown-helper and reattach-vf.sh code blocks marker
    https://git.kernel.org/netdev/net/c/cb74f8c95250

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



