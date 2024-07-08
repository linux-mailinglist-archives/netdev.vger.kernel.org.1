Return-Path: <netdev+bounces-110059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF0C92AC2A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 00:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352321F2243D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE86F152537;
	Mon,  8 Jul 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHN5NIqg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C215252D;
	Mon,  8 Jul 2024 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478433; cv=none; b=qqBUpK1Ni9KTwo4Zi95+OqA6KIm2xf4Y2jXE/hPIsnDq76Ho6zmpnNcfO+e5KMQeBsSbN2AWN6SuagKSwV2DhMDSi7Z4q2T1GTz93layyw/7PD85wJGzY5GP3jyXMf0f6UVHmGPzW41mlfIs4YDLCj1EmYOhkU45dbaH50xzQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478433; c=relaxed/simple;
	bh=VBxzRowcIDnhVklNyjz0A9QESGY5kLcwVvi7nLKzb4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JONq6BObSwaR8sDeMZF63yuheRLPaoaC298NmiB7yUdEQLnAK3xzulXMMxZBXVdpSWYzBbM5ow/UcJmqIb9B9Nj8ebU09WP7Ic7Rab1EdxWyjQOdFPIGy83ihjZ8hmw7XK64SBdvAVlxKhp1/+VOf/m/aRoolRD4ISOvMS9oFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHN5NIqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B4A7C4AF0D;
	Mon,  8 Jul 2024 22:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720478432;
	bh=VBxzRowcIDnhVklNyjz0A9QESGY5kLcwVvi7nLKzb4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CHN5NIqgBCp0qYGI3vm/PN0hBIn9hhG5WYWw95PK0j467ZTfKKOtp1k+QCcsx9LEl
	 YM82QIHUTUv1e1PuM1xbJ4UQul3LDIBOkT6RsQOTpefRm3uNqvF+dByDQXJaLJufVT
	 xzglOHfdDdrB5tXqxb7cjApK3X8o3qDkVmt62h+e5eXq1frHXnSzDQ/S5mHUwzdIHs
	 4fH1QogNF9ajBf4fKOfC+tUl8VjKAJb9YMHj9TOE5IPeozUSbrt3GDIU8WENyNiNgD
	 GFLZYNn36UZChpt+glLTINGquzb+gsGjCW+jDlfrOfX4dbVrue4+iHq2Wp2lyI+LuS
	 lhlQ/wIswSbzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E07D4DF370E;
	Mon,  8 Jul 2024 22:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172047843191.22736.1376042190239326743.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 22:40:31 +0000
References: <20240702120805.2391594-1-tobias@waldekranz.com>
In-Reply-To: <20240702120805.2391594-1-tobias@waldekranz.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, roopa@nvidia.com,
 razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
 liuhangbin@gmail.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue,  2 Jul 2024 14:08:01 +0200 you wrote:
> This series adds support for:
> 
> - Enabling MST on a bridge:
> 
>       ip link set dev <BR> type bridge mst_enable 1
> 
> - (Re)associating VLANs with an MSTI:
> 
> [...]

Here is the summary with links:
  - [v3,iproute2,1/4] ip: bridge: add support for mst_enabled
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=60a95a8a2e45
  - [v3,iproute2,2/4] bridge: Remove duplicated textification macros
    (no matching commit)
  - [v3,iproute2,3/4] bridge: vlan: Add support for setting a VLANs MSTI
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=ace3c9c1fefd
  - [v3,iproute2,4/4] bridge: mst: Add get/set support for MST states
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



