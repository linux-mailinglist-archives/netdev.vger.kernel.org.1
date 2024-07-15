Return-Path: <netdev+bounces-111556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263FE9318A4
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16E61F2282B
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC689446AF;
	Mon, 15 Jul 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdVdemQ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3342A9D;
	Mon, 15 Jul 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061635; cv=none; b=oxjj7F0YIpUmiNMv0dpZrlQbkWig5gbLfbxg52m+xvrfvIRY0SLOynV81Hscx1p25LoiTUIdoN5IQPVL4FpUXTkiIJR+gHjuNWp4QimUywQh8euKcvuHALDMNZnJkKWlKbAMcZX4LgQvM0CbpCJ3cVICf2dDtisv65IpjcfaSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061635; c=relaxed/simple;
	bh=F5YsMjAkLh27ZHf6rNRj5lSqspaU+jyfHUOdjACkHVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jdtn0YfqoRbkzkDO3/ZvU4Q3vGxCtmtKGwgeOA3o4AcPATQ/3GLoebcN4YwMLS8BRhLWNb4a0TEVuMWTKkZEClkr3g8wJT3d+nwtgnp1rLJnpTrVEDg2zPkd3IzGs8BsDIA7VrdY+Smq3xWF90AIB0SpPe2UdTX0iEhFRe1Rzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdVdemQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49521C4AF11;
	Mon, 15 Jul 2024 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721061635;
	bh=F5YsMjAkLh27ZHf6rNRj5lSqspaU+jyfHUOdjACkHVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AdVdemQ8QFLMdRQ1Q2PzZp56oKyVnlQzzXvT4XcAAXkGdBqXCd3o49isfmTbx+dsq
	 C0+1rlOTt2fvpKD3evic/BKSjBxtGKPyDukEY0TbWxg75+jF94KaIocL4B8fJlg9Al
	 4Bl4/ktWDZAn+YgpKkNJijVC4PNVIPYBrdBig/Z4p38pm25bwRnMg3wRSmHeR0FPOr
	 BrWwWzglN2SIg1XewWktLk14tKqHyws7k8VYh9A9Kgnl3Si8DmgkamehzdARa4S2FB
	 OE5VOp+3lGv+DUaTU4G2we+sYJPQL1FIb+W6kzRnyEsJVV2xmrJfsTxkHfKH8ITOv5
	 1s7ecWq+S92pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3581CC43443;
	Mon, 15 Jul 2024 16:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/13] flower: rework TCA_FLOWER_KEY_ENC_FLAGS
 usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172106163520.24349.6809733629118549125.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 16:40:35 +0000
References: <20240713021911.1631517-1-ast@fiberby.net>
In-Reply-To: <20240713021911.1631517-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, dcaratti@redhat.com, i.maximets@ovn.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, horms@kernel.org, rkannoth@marvell.com, fw@strlen.de,
 aleksander.lobakin@intel.com, donald.hunter@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jul 2024 02:18:57 +0000 you wrote:
> This series reworks the recently added TCA_FLOWER_KEY_ENC_FLAGS
> attribute, to be more like TCA_FLOWER_KEY_FLAGS, and use the unused
> u32 flags field in FLOW_DISSECTOR_KEY_ENC_CONTROL, instead of adding
> a new flags field as FLOW_DISSECTOR_KEY_ENC_FLAGS.
> 
> I have defined the new FLOW_DIS_F_* and TCA_FLOWER_KEY_FLAGS_*
> flags to co-exist with the existing flags, so the meaning
> of the flags field in struct flow_dissector_key_control is not
> depending on the context it is used in. If we run out of bits
> then we can always split them up later, if we really want to.
> Future flags might also be valid in both contexts.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/13] net/sched: flower: refactor control flag definitions
    https://git.kernel.org/netdev/net-next/c/6e5c85c003e4
  - [net-next,v4,02/13] doc: netlink: specs: tc: describe flower control flags
    https://git.kernel.org/netdev/net-next/c/49ba9fc1c773
  - [net-next,v4,03/13] net/sched: flower: define new tunnel flags
    https://git.kernel.org/netdev/net-next/c/bfda5a63137b
  - [net-next,v4,04/13] net/sched: cls_flower: prepare fl_{set,dump}_key_flags() for ENC_FLAGS
    https://git.kernel.org/netdev/net-next/c/fcb4bb07a927
  - [net-next,v4,05/13] net/sched: cls_flower: add policy for TCA_FLOWER_KEY_FLAGS
    https://git.kernel.org/netdev/net-next/c/0e83a7875d69
  - [net-next,v4,06/13] flow_dissector: prepare for encapsulated control flags
    https://git.kernel.org/netdev/net-next/c/4d0aed380f9d
  - [net-next,v4,07/13] flow_dissector: set encapsulated control flags from tun_flags
    https://git.kernel.org/netdev/net-next/c/03afeb613bfe
  - [net-next,v4,08/13] net/sched: cls_flower: add tunnel flags to fl_{set,dump}_key_flags()
    https://git.kernel.org/netdev/net-next/c/988f8723d398
  - [net-next,v4,09/13] net/sched: cls_flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
    https://git.kernel.org/netdev/net-next/c/11036bd7a0b3
  - [net-next,v4,10/13] doc: netlink: specs: tc: flower: add enc-flags
    https://git.kernel.org/netdev/net-next/c/880a51a8ab8c
  - [net-next,v4,11/13] flow_dissector: cleanup FLOW_DISSECTOR_KEY_ENC_FLAGS
    https://git.kernel.org/netdev/net-next/c/db5271d50ec1
  - [net-next,v4,12/13] flow_dissector: set encapsulation control flags for non-IP
    https://git.kernel.org/netdev/net-next/c/706bf4f44c6d
  - [net-next,v4,13/13] net/sched: cls_flower: propagate tca[TCA_OPTIONS] to NL_REQ_ATTR_CHECK
    https://git.kernel.org/netdev/net-next/c/536b97acddd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



