Return-Path: <netdev+bounces-53858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568A3804FDD
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882E21C20954
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3724C63F;
	Tue,  5 Dec 2023 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUevmVSI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9E4B5D5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 10:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA954C433C8;
	Tue,  5 Dec 2023 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701771026;
	bh=2P4evCS7qhqj7duK6ST8nDX7xOcEDcrT4PqNZf00SBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dUevmVSIzy7q3FBG1rZ4ro6B522qjpaUJH9kIi37DcoI/+Rvxcgaikf1OqhcCZa2B
	 r5wDXc/xPzKKemNIAuab7i5/shooreqE8koZgnoTu8rqKGhzf8WuKMyi3oy12l80IG
	 An10rJsUI2HsZTRPLHYVQKoXG4vzCEhVnqSsZI7/a9+wa1xp1FvzCgLpDlmRSqgU60
	 9cBWAhoCk+eOLBMjxx4pPF1uDlwhrZCLCMDitnmrrBcc/FbVSvYviAIJxWbANwktM+
	 Ome66N3342e5VEgBsQmYb/wxtmRpkr2YvxTa5Xkh5aFJdR97BtdEGib/BO6c6EhH0h
	 PWRJQQg9FsLrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FBB1C43170;
	Tue,  5 Dec 2023 10:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 net-next 00/10] Doc: update bridge doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170177102658.7715.5767114300890049688.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 10:10:26 +0000
References: <20231201081951.1623069-1-liuhangbin@gmail.com>
In-Reply-To: <20231201081951.1623069-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@idosch.org,
 razor@blackwall.org, roopa@nvidia.com, stephen@networkplumber.org,
 fw@strlen.de, andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 jiri@resnulli.us, mmuehlfe@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  1 Dec 2023 16:19:40 +0800 you wrote:
> The current bridge kernel doc is too old. It only pointed to the
> linuxfoundation wiki page which lacks of the new features.
> 
> Here let's start the new bridge document and put all the bridge info
> so new developers and users could catch up the last bridge status soon.
> 
> v3 -> v4:
> - Patch01: Reference and borrow definitions from the IEEE 802.1Q-2022 standard
>            for bridge (Stephen Hemminger)
> - Patch04: Remind that kAPI is unstable. Add back sysfs part, but only note
>            that sysfs is deprecated. (Stephen Hemminger, Florian Fainelli)
> - Patch05: Mention the RSTP and IEEE 802.1D developing info. (Stephen Hemminger)
> - Some other grammar fixes.
> 
> [...]

Here is the summary with links:
  - [PATCHv4,net-next,01/10] docs: bridge: update doc format to rst
    https://git.kernel.org/netdev/net-next/c/e8a4195d843f
  - [PATCHv4,net-next,02/10] net: bridge: add document for IFLA_BR enum
    https://git.kernel.org/netdev/net-next/c/8ebe06611666
  - [PATCHv4,net-next,03/10] net: bridge: add document for IFLA_BRPORT enum
    https://git.kernel.org/netdev/net-next/c/8c4bafdb01cc
  - [PATCHv4,net-next,04/10] docs: bridge: Add kAPI/uAPI fields
    https://git.kernel.org/netdev/net-next/c/bcc1f84e4d34
  - [PATCHv4,net-next,05/10] docs: bridge: add STP doc
    https://git.kernel.org/netdev/net-next/c/567d2608209f
  - [PATCHv4,net-next,06/10] docs: bridge: add VLAN doc
    https://git.kernel.org/netdev/net-next/c/041a6ac4bf79
  - [PATCHv4,net-next,07/10] docs: bridge: add multicast doc
    https://git.kernel.org/netdev/net-next/c/75ceac88efb8
  - [PATCHv4,net-next,08/10] docs: bridge: add switchdev doc
    https://git.kernel.org/netdev/net-next/c/3c37f17d6ca9
  - [PATCHv4,net-next,09/10] docs: bridge: add netfilter doc
    https://git.kernel.org/netdev/net-next/c/1b1a4c7e82ae
  - [PATCHv4,net-next,10/10] docs: bridge: add other features
    https://git.kernel.org/netdev/net-next/c/d2afc2cd7f1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



