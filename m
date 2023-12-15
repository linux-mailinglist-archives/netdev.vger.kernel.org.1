Return-Path: <netdev+bounces-57922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831038147E9
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A452858BF
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792C2CCDA;
	Fri, 15 Dec 2023 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTygCIkN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9F2CCBC
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 12:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42C4CC433D9;
	Fri, 15 Dec 2023 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702642826;
	bh=UowIKjb03bsrFw2+ao/cl1iPKGnLypoq2U2kDnVGsxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OTygCIkNcH6dit51bw9pjHL1Ih7mec9Mxu0DYZjQxCXCCPNUaMhaWt49u6vsHTXGJ
	 SPXGANfHNSI8FxIrmpn5rqGLcYlS8tkAFcQXFwO5On657nxXK/LG20l6qPnI5Ka1T4
	 8AGOIPs9N4MiUR0gE3DSRocAYMBrk85jCqGh/EjJ+ZsoziG7pkVnKQBD+0EpzXAtmC
	 zWsk5g7c+Sxl0/x1HiRmJl6u0HzwOO5RwqxSY4+3lal6CVDuuj/PLhAKVTIuMaf9hV
	 UIDa9dXdVW5aqiw/knP+6LpGyg9Vb762mSHEIXtqZ8N7c68SJHKzC1H58EH1a1+yU2
	 jilHydMt3Zjag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A22ADD4EF5;
	Fri, 15 Dec 2023 12:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] netlink: specs: prep legacy specs for C code
 gen
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170264282616.26998.14952146049410897563.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 12:20:26 +0000
References: <20231215015735.3419974-1-kuba@kernel.org>
In-Reply-To: <20231215015735.3419974-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 17:57:32 -0800 you wrote:
> Minor adjustments to some specs to make them ready for C code gen.
> 
> v2:
>  - fix MAINATINERS and subject of patch 3
> 
> Jakub Kicinski (3):
>   netlink: specs: ovs: remove fixed header fields from attrs
>   netlink: specs: ovs: correct enum names in specs
>   netlink: specs: mptcp: rename the MPTCP path management spec
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] netlink: specs: ovs: remove fixed header fields from attrs
    https://git.kernel.org/netdev/net-next/c/3ada0b33c454
  - [net-next,v2,2/3] netlink: specs: ovs: correct enum names in specs
    https://git.kernel.org/netdev/net-next/c/209bcb9af8f1
  - [net-next,v2,3/3] netlink: specs: mptcp: rename the MPTCP path management spec
    https://git.kernel.org/netdev/net-next/c/b059aef76c51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



