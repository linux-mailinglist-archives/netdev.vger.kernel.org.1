Return-Path: <netdev+bounces-37803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4439B7B73F6
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 00:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7286C1C204F8
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 22:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD73E466;
	Tue,  3 Oct 2023 22:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0665F3B2A0
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 22:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B1EBC433C7;
	Tue,  3 Oct 2023 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696371033;
	bh=53KM6uXapouO/oBQrn7043YTKwS2I9MAaSMI9++lFxE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iDRbnNkNN4rcBmdSVqWCm1xDy7VwS9LtUEamUkTpHrvGpZM0TfQQtjLTiXNrmkYYK
	 8kMGtHDpCdtSbOAocIg28wg43wzcMSz0iVf9ES+1I1aE+YnTVZpzNfSRce08GMEjFV
	 ccMMUyZALwnbksPfL8lrlhsEA+1Yn1Zfm+Qohhl5g5AvdJbDm5KWqsnJ8Nuoi2+83y
	 jMFMUFeI5i1/R/iXsutAzxc6JSgkWhgJ45vYk6yJe5bqU31PIysV6/aAHw7IcUU2ME
	 NSM/WouPN9liZz47vxg+n/fpUh/7H0Iuyvm3OXizqAq7ArFcljFVAj5BNgMvo23RG8
	 3Zq2dfelrEY/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F919C595D2;
	Tue,  3 Oct 2023 22:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Documentation fixes for dpll subsystem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169637103325.17710.5593789278603779444.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 22:10:33 +0000
References: <20230928052708.44820-1-bagasdotme@gmail.com>
In-Reply-To: <20230928052708.44820-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Sep 2023 12:27:06 +0700 you wrote:
> Here is a mini docs fixes for dpll subsystem. The fixes are all code
> block-related.
> 
> This series is triggered because I was emailed by kernel test robot,
> alerting htmldocs warnings (see patch [1/2]).
> 
> Changes since v1 [1]:
>   * Collect Reviewed-by tags
>   * Rebase on current net-next
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] Documentation: dpll: Fix code blocks
    https://git.kernel.org/netdev/net-next/c/92425d08a608
  - [net-next,v2,2/2] Documentation: dpll: wrap DPLL_CMD_PIN_GET output in a code block
    https://git.kernel.org/netdev/net-next/c/c8afdc018329

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



