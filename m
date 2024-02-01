Return-Path: <netdev+bounces-67823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06088450A8
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 06:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7705528F181
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 05:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA0E3CF44;
	Thu,  1 Feb 2024 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgAWwoQW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9565B3B19E;
	Thu,  1 Feb 2024 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764828; cv=none; b=tCfiuAILKAFs04W5OgSxAbsPv1fPt292Xovtp4q6++yvqnBuanhr6zW+GX3535R7VxgRB3AqhtP6Ae5mL9Tppf20mHzTNs52kSiZCsuud106ATlSPl4/B8coNK/GPjJ/QvvBBHVNTJBjaolrxu2FgL7loCWyO9A4AO3GNqeSeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764828; c=relaxed/simple;
	bh=NzVEEPfDKZXrlbClAX/5PpcAND3mvnrMb8EUSMT+Mdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rCfeN6403Go1lgzNYyDicPFV265PMdh2KJ3CTWkZ7b/56pbXu3k7yvryfXqNPcg2Myf2PfUQT7a9vuqHEX9CEXFdQPT6y8+McEv6ZLCH7ejsrYZfBbN3dMAsV6l3fChIHQH8Sn3NkDplAMd90Ked78xwMnWm2YAquXR4iEm618M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgAWwoQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B37AC43390;
	Thu,  1 Feb 2024 05:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764828;
	bh=NzVEEPfDKZXrlbClAX/5PpcAND3mvnrMb8EUSMT+Mdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WgAWwoQWQnNO/6VrNpyKPtXUQ9MebifHXs244+oys/F6LEZOvzCew8zfZSAaRPnTJ
	 BNUq0FHwfvUjKOKVsrOoDFhPWnX3TgjSwGFdHtK3zwMWGuR0x6o1Mqds4qvX1DlVm4
	 29Q8Ej46635Cmqc3UC47KdpSnRjifznTuHL+kJi4sa8oSpSBnCqNbOC/Kt0dGRTBNf
	 g76qdvoAYkGTNhrCLo3gHlAYHUjQc32OaaKDxFyGcdsHAuSkgut+Gt+bOOzozqD6W6
	 8Xbx6I19E7BCqQK6qzlKvVC40S34VWnIBNVavgrC/p4pzbmrxuG5RnKk32EQW3k1Dv
	 ztV1NHIw5BO3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06998DC99E5;
	Thu,  1 Feb 2024 05:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/13] tools/net/ynl: Add features for tc family
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170676482802.24744.7890909749893938993.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 05:20:28 +0000
References: <20240129223458.52046-1-donald.hunter@gmail.com>
In-Reply-To: <20240129223458.52046-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, jacob.e.keller@intel.com, leitao@debian.org,
 jiri@resnulli.us, alessandromarcolini99@gmail.com, donald.hunter@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jan 2024 22:34:45 +0000 you wrote:
> Add features to ynl for tc and update the tc spec to use them.
> 
> Patch 1 adds an option to output json instead of python pretty printing.
> Patch 2, 3 adds support and docs for sub-messages in nested attribute
> spaces that reference keys from a parent space.
> Patches 4 and 7-9 refactor ynl in support of nested struct definitions
> Patch 5 implements sub-message encoding for write ops.
> Patch 6 adds logic to set default zero values for binary blobs
> Patches 10, 11 adds support and docs for nested struct definitions
> Patch 12 updates the ynl doc generator to include type information for
> struct members.
> Patch 13 updates the tc spec - still a work in progress but more complete
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/13] tools/net/ynl: Add --output-json arg to ynl cli
    https://git.kernel.org/netdev/net-next/c/e2ece0bc5ab1
  - [net-next,v2,02/13] tools/net/ynl: Support sub-messages in nested attribute spaces
    https://git.kernel.org/netdev/net-next/c/bf8b832374fb
  - [net-next,v2,03/13] doc/netlink: Describe sub-message selector resolution
    https://git.kernel.org/netdev/net-next/c/78d234169795
  - [net-next,v2,04/13] tools/net/ynl: Refactor fixed header encoding into separate method
    https://git.kernel.org/netdev/net-next/c/5f2823c48ad6
  - [net-next,v2,05/13] tools/net/ynl: Add support for encoding sub-messages
    https://git.kernel.org/netdev/net-next/c/ab463c4342d1
  - [net-next,v2,06/13] tools/net/ynl: Encode default values for binary blobs
    https://git.kernel.org/netdev/net-next/c/a387a921139e
  - [net-next,v2,07/13] tools/net/ynl: Combine struct decoding logic in ynl
    https://git.kernel.org/netdev/net-next/c/e45fee0f49fc
  - [net-next,v2,08/13] tools/net/ynl: Rename _fixed_header_size() to _struct_size()
    https://git.kernel.org/netdev/net-next/c/886365cf40b2
  - [net-next,v2,09/13] tools/net/ynl: Move formatted_string method out of NlAttr
    https://git.kernel.org/netdev/net-next/c/971c3eeaf668
  - [net-next,v2,10/13] tools/net/ynl: Add support for nested structs
    https://git.kernel.org/netdev/net-next/c/bf08f32c8ced
  - [net-next,v2,11/13] doc/netlink: Describe nested structs in netlink raw docs
    https://git.kernel.org/netdev/net-next/c/9d6429c33976
  - [net-next,v2,12/13] tools/net/ynl: Add type info to struct members in generated docs
    https://git.kernel.org/netdev/net-next/c/fe09ae5fb93b
  - [net-next,v2,13/13] doc/netlink/specs: Update the tc spec
    https://git.kernel.org/netdev/net-next/c/2267672a6190

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



