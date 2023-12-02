Return-Path: <netdev+bounces-53182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FB78019A9
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B84F1C2074B
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235FC17C0;
	Sat,  2 Dec 2023 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1aNdAQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A1EC3;
	Sat,  2 Dec 2023 01:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1B88C433C9;
	Sat,  2 Dec 2023 01:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701481823;
	bh=afM3w+MPxN1sihZGo2nbVInwLYlWl7OkiURQRIw72cQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b1aNdAQKUXOC4UIDanEdq2oQAXSQgeynXBqwgxpIqvyCCxOY9up3EaYPGc0DAH/1x
	 d/SYPiXrWAUHIIj3r74+YLjkiWcjzDmWKWom1tbI/aE4h+d0tx4GvGT/nldohoVtLp
	 kOIayKEG24Le+Anr7Ty+vCfLMu9bkbSUfsFLmPdU4UiafKmB8/Gm+aPPTxn7m/WLi3
	 ucG1LfZ4rYggErSjIu/plUjF7IO9j9AvAtnzLdLNJt0jN51EMEf/HrACPCamFNhn6U
	 pWond/s2SEJvuzVDowghWvt1NCsm4rSJ6dPH5h4ibTt2Ebl+v7IPpawcDSMapgovWv
	 CXDOOc30ecpOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9370AC64459;
	Sat,  2 Dec 2023 01:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/6] tools/net/ynl: Add 'sub-message' support to
 ynl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170148182359.29419.17491945110307467020.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 01:50:23 +0000
References: <20231130214959.27377-1-donald.hunter@gmail.com>
In-Reply-To: <20231130214959.27377-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, jacob.e.keller@intel.com, donald.hunter@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Nov 2023 21:49:52 +0000 you wrote:
> This patchset adds a 'sub-message' attribute type to the netlink-raw
> schema and implements it in ynl. This provides support for kind-specific
> options attributes as used in rt_link and tc raw netlink families.
> 
> A description of the new 'sub-message' attribute type and the
> corresponding sub-message definitions is provided in patch 2.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/6] doc/netlink: Add bitfield32, s8, s16 to the netlink-raw schema
    https://git.kernel.org/netdev/net-next/c/527d2cd8b852
  - [net-next,v1,2/6] doc/netlink: Add sub-message support to netlink-raw
    (no matching commit)
  - [net-next,v1,3/6] tools/net/ynl: Add 'sub-message' attribute decoding to ynl
    (no matching commit)
  - [net-next,v1,4/6] tools/net/ynl: Add binary and pad support to structs for tc
    (no matching commit)
  - [net-next,v1,5/6] doc/netlink/specs: add sub-message type to rt_link family
    (no matching commit)
  - [net-next,v1,6/6] doc/netlink/specs: Add a spec for tc
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



