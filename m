Return-Path: <netdev+bounces-181482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F0A85207
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D42B445DDB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D62A27C858;
	Fri, 11 Apr 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhrR22Ve"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7427C851
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744342198; cv=none; b=rgqkO0jRE7Xnz3U7LpsTBzbiOPaYKf8njcYXajkOD/Ivz/iEOJfFYPQULVVIh01lmmhF00uiZCLhZYek2uoE04ypziesN6FhR9J0fSVog/ASZrwNbRmbxbByycws3/e2p6VNv0CCgR+oZvGi5/ggQb4e5Kg38OEETyYzFMHqNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744342198; c=relaxed/simple;
	bh=C66Im0AzE8+U+XgUGXegfxZJ6mcriFsk/jwDevFX4jw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y5v5exxWflo6lxg4dPyCXvuVEbhkWiXNZKQXc0WaoMBUXS/N5Mfx7IADBF0EGXUQkOtx0Pu6UdH/U8nzPyuGOfuqt8bLcrbqgNQCaYdV5M4plIE1t2jmneW6XKCtuZ7PidULq9IYpc/M1EEMUJ82EQvywKd4c9lEcXt2iZf9BwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhrR22Ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF358C4CEE2;
	Fri, 11 Apr 2025 03:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744342197;
	bh=C66Im0AzE8+U+XgUGXegfxZJ6mcriFsk/jwDevFX4jw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HhrR22VeVlH1H2Zg8KtkW7Mn5XkEchGTkcQB3OildkMlKSvQDl1INnEZkhzYgl1Sd
	 tD79zqrGvuTDRyFYsumjv6XNwkvOBIvYblW+uhawFNfKD+us0RxhrrKzfToKXD5me0
	 xqEEsI7AB4uf7axk4biFiyr1G5AJQK+frIbAzH3FGk1RJOrKnkofFc83h5W0yRgBMs
	 E+S8nlig4rSCgKb3vFgIXPOTJAwm6k9HrV3qbFihGvzgi0Rt0raHb3YwWmRCBNqdam
	 dl0L+qihGr4m7moOZVknk4ox/jPv1/6nnKbh9fRVUFtYlUAYy+YToOlhHV8sbPCxTH
	 o/SQUWbtq8vLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE37F380CEF4;
	Fri, 11 Apr 2025 03:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/13] tools: ynl: c: basic netlink-raw support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174434223551.3945310.12371352099269592658.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 03:30:35 +0000
References: <20250410014658.782120-1-kuba@kernel.org>
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, yuyanghuang@google.com,
 sdf@fomichev.me, gnault@redhat.com, nicolas.dichtel@6wind.com,
 petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Apr 2025 18:46:45 -0700 you wrote:
> Basic support for netlink-raw AKA classic netlink in user space C codegen.
> This series is enough to read routes and addresses from the kernel
> (see the samples in patches 12 and 13).
> 
> Specs need to be slightly adjusted and decorated with the c naming info.
> 
> In terms of codegen this series includes just the basic plumbing required
> to skip genlmsghdr and handle request types which may technically also
> be legal in genetlink-legacy but are very uncommon there.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/13] netlink: specs: rename rtnetlink specs in accordance with family name
    https://git.kernel.org/netdev/net-next/c/cd5e64fb959a
  - [net-next,v2,02/13] netlink: specs: rt-route: specify fixed-header at operations level
    https://git.kernel.org/netdev/net-next/c/97a33caa9071
  - [net-next,v2,03/13] netlink: specs: rt-addr: remove the fixed members from attrs
    https://git.kernel.org/netdev/net-next/c/d460016e7bca
  - [net-next,v2,04/13] netlink: specs: rt-route: remove the fixed members from attrs
    https://git.kernel.org/netdev/net-next/c/295ff1e95201
  - [net-next,v2,05/13] netlink: specs: rt-addr: add C naming info
    https://git.kernel.org/netdev/net-next/c/52d062362c05
  - [net-next,v2,06/13] netlink: specs: rt-route: add C naming info
    https://git.kernel.org/netdev/net-next/c/1652e1f35dfb
  - [net-next,v2,07/13] tools: ynl: support creating non-genl sockets
    (no matching commit)
  - [net-next,v2,08/13] tools: ynl-gen: don't consider requests with fixed hdr empty
    https://git.kernel.org/netdev/net-next/c/e0a7903c323f
  - [net-next,v2,09/13] tools: ynl: don't use genlmsghdr in classic netlink
    https://git.kernel.org/netdev/net-next/c/7e8ba0c7de2b
  - [net-next,v2,10/13] tools: ynl-gen: consider dump ops without a do "type-consistent"
    https://git.kernel.org/netdev/net-next/c/e8025e72aad6
  - [net-next,v2,11/13] tools: ynl-gen: use family c-name in notifications
    https://git.kernel.org/netdev/net-next/c/882e7b1365ce
  - [net-next,v2,12/13] tools: ynl: generate code for rt-addr and add a sample
    (no matching commit)
  - [net-next,v2,13/13] tools: ynl: generate code for rt-route and add a sample
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



