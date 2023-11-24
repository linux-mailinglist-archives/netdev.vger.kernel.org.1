Return-Path: <netdev+bounces-50681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB127F6A11
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 02:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4432813F9
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B0E621;
	Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsE+sSpX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE01367;
	Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 346CBC433C8;
	Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700788825;
	bh=eLNAnyUduoQQcE8ecVOU/349sikSBU3Okw3Eu+Fv3po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AsE+sSpX1YgGEgwiGSNjOv38w0cso/T8/MPv2DZxKH8JvSts4fh9ePUgxlm/yoSVy
	 p4dLG/c79ffECd2Xho9iQBP6iBu83ozVEgduIhVfutF+VJldRC48NucLuiqS+U7V+T
	 6YtD9oNemPFU2Cr7Ljh1lMiZDMuMp6G0YU4QhurKWM/HJaE74PeiXTtZbgGkSq9cz0
	 /37jm6tuA772z+ZA7R7aKETPv8WIDLQYKrsvLfV4Ux6erZSWAIBJU/r8aLN2PElDvL
	 BmU9egNdpHrZaG6e2DOcPQdH0pQ1QA52UOciORqdrsILmSF8Gz97uXRaf13LUNclk+
	 Z0QkE5XHFu1LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B190C3959E;
	Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Documentation: Document each netlink family
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170078882510.20317.6470955515511938856.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 01:20:25 +0000
References: <20231121114831.3033560-1-leitao@debian.org>
In-Reply-To: <20231121114831.3033560-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: corbet@lwn.net, kuba@kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 03:48:31 -0800 you wrote:
> This is a simple script that parses the Netlink YAML spec files
> (Documentation/netlink/specs/), and generates RST files to be rendered
> in the Network -> Netlink Specification documentation page.
> 
> Create a python script that is invoked during 'make htmldocs', reads the
> YAML specs input file and generate the correspondent RST file.
> 
> [...]

Here is the summary with links:
  - [v3] Documentation: Document each netlink family
    https://git.kernel.org/netdev/net-next/c/f061c9f7d058

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



