Return-Path: <netdev+bounces-69688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB784C2E5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD06B1F29397
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D1FC1D;
	Wed,  7 Feb 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEMmXc2j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8810962
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274832; cv=none; b=pr2MdmAGv0iPRc5fC37nJaJiXmnn4P3euxMNlgnmZ3hXwJWpc1El3Gq7UjA01jOAEJLJ7g1SN3T7a8G2yp684oKaWBdlozgF989zv7mHTrIrrKLiJNS8HzrcR/idvsdzF5ixVFEEWsDpQ5Vlrkbf6zIWXhmtFKWMy0EorzSZYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274832; c=relaxed/simple;
	bh=f6ABF8lP1gWYNcseIHiTky6RI87e+pb+OnWhgmUjU+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mU6l02K7XwLjk7msPEJX+aFaVlPmQzmboK00b32692XbQYdaFL+Av/VQKcIavjI8/PVuUEgS6u6vmyceyMD97e/Ohu1+pnoHKa/FtbJj9xKJMaDiJqq+QG1Kje3koMj8Dr0rPhT/13LgdH9Hi4oqV7brvqcEXMD/D+ASIFkh4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEMmXc2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1B72C433F1;
	Wed,  7 Feb 2024 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707274830;
	bh=f6ABF8lP1gWYNcseIHiTky6RI87e+pb+OnWhgmUjU+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TEMmXc2j0wU7qYDJhH+LwbRZCRBtkqbm1M8NKGwp0D4nxKDiWfBk38/E2GMW1/KCE
	 Nm1+jggJZR/msz8BMG5cFZsO+UEPHm4F+2T8f9s26NLfrzK4GmJSMuEBWkZWxD5I2G
	 GW4hXLZYlTWvIYQmyOmqxv6bE6hE7UKt4tOoqG4o/CigAXZ/v9d/UoNOrJlMDo34T9
	 GCzG0XWYFwuKiSWcgkKrW2eep+bKpgxi1acFCULXmrp7jZ6HSi+U2rlA8nezAO2IEJ
	 9o21IRujav1fIboW8tzLML2/IKe6E1zrb4RVA5Jzjvo/mbs/wULiE80FCEbMMSeaHO
	 s1yGEF0mX5cIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB84BD8C981;
	Wed,  7 Feb 2024 03:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/3] Add support for encoding multi-attr to ynl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170727483076.2210.11143826108194228120.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 03:00:30 +0000
References: <cover.1706962013.git.alessandromarcolini99@gmail.com>
In-Reply-To: <cover.1706962013.git.alessandromarcolini99@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, sdf@google.com,
 chuck.lever@oracle.com, lorenzo@kernel.org, jacob.e.keller@intel.com,
 jiri@resnulli.us, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  3 Feb 2024 14:16:50 +0100 you wrote:
> This patchset add the support for encoding multi-attr attributes, making
> it possible to use ynl with qdisc which have this kind of attributes
> (e.g: taprio, ets).
> 
> Patch 1 corrects two docstrings in nlspec.py
> Patch 2 adds the multi-attr attribute to taprio entry
> Patch 3 adds the support for encoding multi-attr
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/3] tools: ynl: correct typo and docstring
    https://git.kernel.org/netdev/net-next/c/7b4434a8face
  - [v4,net-next,2/3] doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
    https://git.kernel.org/netdev/net-next/c/70ff9a91e868
  - [v4,net-next,3/3] tools: ynl: add support for encoding multi-attr
    https://git.kernel.org/netdev/net-next/c/b9bcfc3bc978

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



