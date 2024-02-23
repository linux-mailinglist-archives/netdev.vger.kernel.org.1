Return-Path: <netdev+bounces-74234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B181860932
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5187B23BEA
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30A5C154;
	Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8jr1I7/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D499C2DA
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657826; cv=none; b=FPIoEr2oFcYvs8SxPhf4FiPV0yH1C/RwQqocj4FNiGdt+35Ku2/dPJ2HRieyZ72xHgtnKyJfyCedoTrobnSECbZoZNwnZoRSoRbd8LOeh1wsx0iS+hEvof6NESsrLj0qIY1Hrn9HMXSICdlzTF5Y+CCEVBmUyWidmPkl2LBQE+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657826; c=relaxed/simple;
	bh=+haOQknJ8+L8cu33TWcmw9OV7AMwfEQsixi/lclvxyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tQVoLCmELoh8A98LOEoNKZZE9MLXdxGKu8Qdm3HI5jHrgwhCPG6igG5CXjJmx71AyGWPZdYwk+33BhZeXBhDHWNFMJ50G3bWyrecSJOwaRImpP1TvfZAQpZlBkDXTPT5WneS+ek5Fs12dwacZy8vP1IiMDHcLMqVpuNCHKWM+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8jr1I7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AEDBC433C7;
	Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657826;
	bh=+haOQknJ8+L8cu33TWcmw9OV7AMwfEQsixi/lclvxyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j8jr1I7/rBRonZ/zqlMAoaUAxq9qJpaJuCjjNz/djyze9sGGjl86iOCXmWXXe8R7O
	 azW4ufVrPmFkjcYkq4J/xlGV/LU4EjWxmm41waXAHNfriRLOEgm97tsqZDR4GSWNV+
	 5UmPxKef1ZLYc/epUBtzJ+q82jOFyNZZ1pKcKiBYUni/Z2InO51vdj/CnENcbaBsYS
	 QKb/by6DkcRlk3czkkxLBqi4WYDTRjzIiuioUgc61wC5g4ZKDcEZNpsOOaC64HWvD6
	 ZPDjNv0Fjh4H3F9ugx9aKJguP1k1emklnwhhH2N8QybKC0wWfcj7aU/5ZV/vBXPxXK
	 v8hW4Vzjpc/hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5604DC04E32;
	Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: add nla be16/32 types to minlen array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865782634.16544.5670883251247805221.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 03:10:26 +0000
References: <20240221172740.5092-1-fw@strlen.de>
In-Reply-To: <20240221172740.5092-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,
 syzbot+3f497b07aa3baf2fb4d0@syzkaller.appspotmail.com, xrivendell7@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Feb 2024 18:27:33 +0100 you wrote:
> BUG: KMSAN: uninit-value in nla_validate_range_unsigned lib/nlattr.c:222 [inline]
> BUG: KMSAN: uninit-value in nla_validate_int_range lib/nlattr.c:336 [inline]
> BUG: KMSAN: uninit-value in validate_nla lib/nlattr.c:575 [inline]
> BUG: KMSAN: uninit-value in __nla_validate_parse+0x2e20/0x45c0 lib/nlattr.c:631
>  nla_validate_range_unsigned lib/nlattr.c:222 [inline]
>  nla_validate_int_range lib/nlattr.c:336 [inline]
>  validate_nla lib/nlattr.c:575 [inline]
> ...
> 
> [...]

Here is the summary with links:
  - [net] netlink: add nla be16/32 types to minlen array
    https://git.kernel.org/netdev/net/c/9a0d18853c28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



