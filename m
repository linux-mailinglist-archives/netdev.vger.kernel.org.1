Return-Path: <netdev+bounces-84239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E9A896221
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B26F1C235A6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 01:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA31CF9C;
	Wed,  3 Apr 2024 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOnpSGhS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F090168A8
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108435; cv=none; b=YkuZ/MLVAQMdWpVH/JosRo3EoAmeDnp49l3Ie9o3sl7bruZpDppnOhQG4dHCxfbCCNIqsjyOw4usgDOMB6RNnn1avVtyMsvP892e6mOnstU1+Lpow+IOtWlgzr6bxOryZN0vAXsw17RXpPECzM6rsUbbDtyexVuzwe5Ytbjp/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108435; c=relaxed/simple;
	bh=3iaCdZeo2WFwC0ne8NvezPPQERqRcxIzimAAJhbILlc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LsITVUDhMSrUD3H5hep2AyAKTwvmkAglIUyYlzbHVFXCAhg9BIPYcZbLp02e2bGXXCBZI6GqkzKO6R1miqBx3jesh+ZqHd45BbCLyBod9uTch+A3pbrJYPFtVmhjvjTwcyhP/XIXym9M24VDHN1EjZaYeZ4CV6bzW4C2xi+9X34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOnpSGhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF138C43609;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108435;
	bh=3iaCdZeo2WFwC0ne8NvezPPQERqRcxIzimAAJhbILlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oOnpSGhSYJz8OlFoDFThzc/AigAxTdD4jyIGpHJm+Jo+yFL9eJ0H5gAkNg84sGyVv
	 gdRoPw6ati5JTMa0blxS5WMyLuvXsPPA0QBGI9XrEdgAkBg/yT3yRT30BPLk8a4I9r
	 sxInk5mfXJ0evPtTO7GvvAm53ELyo0vKyC0d4l+eCwOYHUb3E7P0V2i7czmKROclZH
	 htEvNN4cxKarKRQG0H54wbyUpE0x4Vrl6FhpwGLm892RbljpAyCegUTvPL2M+UhAww
	 7PYiM2L5RGftfnPBYivz7DWQhGfVOcSJgSEJ2dqNEr9k24TWi6RykHgOIWMIDBmH9Y
	 EFPeNGtLHXMdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E68BDC4314C;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: add ynl_dump_empty() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210843494.14193.18354979301638732857.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:40:34 +0000
References: <20240329181651.319326-1-kuba@kernel.org>
In-Reply-To: <20240329181651.319326-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, nicolas.dichtel@6wind.com, sdf@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 11:16:51 -0700 you wrote:
> Checking if dump is empty requires a couple of casts.
> Add a convenient wrapper.
> 
> Add an example use in the netdev sample, loopback is always
> present so an empty dump is an error.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: add ynl_dump_empty() helper
    https://git.kernel.org/netdev/net-next/c/d6d647d7ba64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



