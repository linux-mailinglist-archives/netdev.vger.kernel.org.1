Return-Path: <netdev+bounces-85733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF0689BEDF
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CDE1F226EB
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87116A8AD;
	Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp6FSCqa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28466A342
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578902; cv=none; b=sYHjtGkdx95NTyKvuZkSkOu3i9jn69z+OK7bCuC8JpN0T5x8o13nHmaGf6TkUG+YvhV9e6McbfkjPTdY5EYPP8aucGheJF3xPIhGSSZyZ/jnnl3Iw3IKEURTbhMxdV/1Q5ZIpQl1OGmJ1GCHQWCsHtXNd7q2NCQ5i71CFDM7g1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578902; c=relaxed/simple;
	bh=FKbOofAIGDVypg4ga55Yk/+UGuDXZSrGkeXrzr5xvJA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ahTgjSevjGiqgTsJDATgm6rJp9UWkaI+1l8sE6Vb/eVchhzKKkv0PEJqg6No+/8AbE1gJ4A5TK6hRmrGaPERXRjWC9u2icTlXR1BUY//HDPzFDqyUVwf5KBQCo5pR1JHB2B/JAWx6wH2bCQEtQ9usu6nexJ1zssoeY8HLFslAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp6FSCqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E547C43394;
	Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712578902;
	bh=FKbOofAIGDVypg4ga55Yk/+UGuDXZSrGkeXrzr5xvJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bp6FSCqaU+DNhWbNEtMgVdxdofuWNqE9H8uqBzpxuLwax5KUwtAN2/kN7MARof1jw
	 Edq91TDN22VGQfrfU8euZRP74nXcoTdi9fGU08mtxAbptoWCPa9tzWTHD48Vndv4BJ
	 eygJAYbg1Wu/Dig/FzGw2A2rWFXeFM9V5HGo8h08rtbFFmjjcQ8c+uVz+8V38KHY9F
	 /gcPIjiniw3N7f/ECsHyy/NEqi0sB0Nq3t6Msx26H4/qs/7FRQqGtkrnYkkGPaiO2/
	 R8ha+6Xh9zhVdPbqqAHJh+/KxdnxhLgPhuzxk1S+T66HkwjJDRpvBs0Tk1G3db3B/H
	 XnB13SYpl3sqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D861C54BD7;
	Mon,  8 Apr 2024 12:21:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] af_packet: avoid a false positive warning in
 packet_setsockopt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257890231.8472.7789162267861463115.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 12:21:42 +0000
References: <20240405114939.188821-1-edumazet@google.com>
In-Reply-To: <20240405114939.188821-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 keescook@chromium.org, willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Apr 2024 11:49:39 +0000 you wrote:
> Although the code is correct, the following line
> 
> 	copy_from_sockptr(&req_u.req, optval, len));
> 
> triggers this warning :
> 
> memcpy: detected field-spanning write (size 28) of single field "dst" at include/linux/sockptr.h:49 (size 16)
> 
> [...]

Here is the summary with links:
  - [net-next] af_packet: avoid a false positive warning in packet_setsockopt()
    https://git.kernel.org/netdev/net-next/c/86d43e2bf93c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



