Return-Path: <netdev+bounces-26992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6FC779C62
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 03:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164BF281E64
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC531111;
	Sat, 12 Aug 2023 01:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385EE10EF
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EE81C433C8;
	Sat, 12 Aug 2023 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691805022;
	bh=8XXzEmW/ZaE7kT1BJKo5aN6WIj3+Cvfi93IOJaZeD+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GkRAAGMgddIWVqlboqkfRKqUI92TgzNlqcXxT5Y25QLTE1kfitp+HjwkwYEwZHgrt
	 dSS7ySTSK/Aye3jJDS7BJyj3JSlqvgwvDrQ9wAzKFPojzauPswu7nQI6NQFpgcN0lu
	 eIXca7oydeAbzYX4dr/Pw3Q6BpHjZsB30c9FLF5TQNmfEBVSu1QtjpDrjsvu9SR3i4
	 sq1b4c1ncdn2ffNlJE5ZYJ9/LMEY8nQCu7YxHoU2Y5vSXUpGMXlHzghcmMXOO52sw4
	 CABXFIl3u1tC0anHaJlZHz1ehh5jqCYS8qqRTOXMKW//6RA+LyXqPw0LSCtfpwV73c
	 FQnxQxRtdxg6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 837A1C64459;
	Sat, 12 Aug 2023 01:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4][pull request] i40e: Replace one-element arrays
 with flexible-array members
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169180502253.32437.70376958556242210.git-patchwork-notify@kernel.org>
Date: Sat, 12 Aug 2023 01:50:22 +0000
References: <20230810175302.1964182-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230810175302.1964182-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, gustavoars@kernel.org,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 10 Aug 2023 10:52:58 -0700 you wrote:
> Gustavo A. R. Silva says:
> 
> Replace one-element arrays with flexible-array members in multiple
> structures.
> 
> This results in no differences in binary output.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] i40e: Replace one-element array with flex-array member in struct i40e_package_header
    https://git.kernel.org/netdev/net-next/c/e55c50eac36a
  - [net-next,2/4] i40e: Replace one-element array with flex-array member in struct i40e_profile_segment
    https://git.kernel.org/netdev/net-next/c/fbfa49f92484
  - [net-next,3/4] i40e: Replace one-element array with flex-array member in struct i40e_section_table
    https://git.kernel.org/netdev/net-next/c/ff1a724c4f6a
  - [net-next,4/4] i40e: Replace one-element array with flex-array member in struct i40e_profile_aq_section
    https://git.kernel.org/netdev/net-next/c/4bb28b27040b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



