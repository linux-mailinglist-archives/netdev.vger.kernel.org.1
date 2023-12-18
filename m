Return-Path: <netdev+bounces-58694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D5817DE6
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DF21F24652
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 23:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F0D76094;
	Mon, 18 Dec 2023 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYn9fjii"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36351EA85;
	Mon, 18 Dec 2023 23:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92E40C433C9;
	Mon, 18 Dec 2023 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702941027;
	bh=95/9p+qdwlznQhwye/627I6KjP6ua5ueRj7+oeGQow4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CYn9fjiiRtprSMMfnQVFJ2NdwXbuLilS4aJ6uZdZZmhENrW2HQ5dMkkScw1OElkYw
	 cgx7ohwfOIbBk1I9kqSHgoZRlPNON0+8T4UIHcgW0G5EFB0au+U1D3COBcSo4M68Qf
	 /heGjYRUwyOvRs+w4x0a90AkKUH5PN0U9/3fuvJLjZVOP1Fz20xc2MSjG5mS1TiIYs
	 ehl/SYngLc9XljXS7NQTCDZfldAH/EnwI4MWN85CujwMgAwWzUJ2CLOfTKA4ACynXQ
	 Nb6gVgpECmnflxBlMubbZEVE/ZCJZUN04M4JFhugqj2wJkpp/Mob3TzIA1ExgdvCao
	 S50jw1xTeINTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73C1DD8C98B;
	Mon, 18 Dec 2023 23:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/13] tools/net/ynl: Add 'sub-message' support to
 ynl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170294102747.20113.587351606180091252.git-patchwork-notify@kernel.org>
Date: Mon, 18 Dec 2023 23:10:27 +0000
References: <20231215093720.18774-1-donald.hunter@gmail.com>
In-Reply-To: <20231215093720.18774-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, jacob.e.keller@intel.com, leitao@debian.org,
 donald.hunter@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Dec 2023 09:37:07 +0000 you wrote:
> This patchset adds a 'sub-message' attribute type to the netlink-raw
> schema and implements it in ynl. This provides support for kind-specific
> options attributes as used in rt_link and tc raw netlink families.
> 
> A description of the new 'sub-message' attribute type and the
> corresponding sub-message definitions is provided in patch 3.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/13] tools/net/ynl: Use consistent array index expression formatting
    https://git.kernel.org/netdev/net-next/c/62691b801daa
  - [net-next,v5,02/13] doc/netlink: Add sub-message support to netlink-raw
    https://git.kernel.org/netdev/net-next/c/de2d98743b83
  - [net-next,v5,03/13] doc/netlink: Document the sub-message format for netlink-raw
    https://git.kernel.org/netdev/net-next/c/17ed5c1a9e36
  - [net-next,v5,04/13] tools/net/ynl: Add 'sub-message' attribute decoding to ynl
    https://git.kernel.org/netdev/net-next/c/1769e2be4baa
  - [net-next,v5,05/13] tools/net/ynl: Add binary and pad support to structs for tc
    https://git.kernel.org/netdev/net-next/c/8b6811d96666
  - [net-next,v5,06/13] doc/netlink/specs: Add sub-message type to rt_link family
    https://git.kernel.org/netdev/net-next/c/077b6022d24b
  - [net-next,v5,07/13] doc/netlink/specs: use pad in structs in rt_link
    https://git.kernel.org/netdev/net-next/c/6b4b0754ef8a
  - [net-next,v5,08/13] doc/netlink/specs: Add a spec for tc
    https://git.kernel.org/netdev/net-next/c/a1bcfde83669
  - [net-next,v5,09/13] doc/netlink: Regenerate netlink .rst files if ynl-gen-rst changes
    https://git.kernel.org/netdev/net-next/c/646158f20cbc
  - [net-next,v5,10/13] tools/net/ynl-gen-rst: Add sub-messages to generated docs
    https://git.kernel.org/netdev/net-next/c/6235b3d8bc3f
  - [net-next,v5,11/13] tools/net/ynl-gen-rst: Sort the index of generated netlink specs
    https://git.kernel.org/netdev/net-next/c/e8c32339cf49
  - [net-next,v5,12/13] tools/net/ynl-gen-rst: Remove bold from attribute-set headings
    https://git.kernel.org/netdev/net-next/c/e9d7c59212e4
  - [net-next,v5,13/13] tools/net/ynl-gen-rst: Remove extra indentation from generated docs
    https://git.kernel.org/netdev/net-next/c/9b0aa2244d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



