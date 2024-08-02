Return-Path: <netdev+bounces-115444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776794662A
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAA41F22AB0
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1713B797;
	Fri,  2 Aug 2024 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6TF++iG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33761ABEA4
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641445; cv=none; b=M6gVIgnUQe7L8Ow/UUDue/wPCqKDyJ87BTN8JGNWnf/NW+7mW8iOzyV9n/FnjS3oBdouerK6vRNcZuWJrIam2jvpmwqToiqzPeKkjVj5OFJQrYtBc5EhYAGZCMrmuL/dGtpWZgY3VJTIuufjXEBVyO19y9l960kIQxlO3sC1LEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641445; c=relaxed/simple;
	bh=dBNW9caHXAYXYFwPXe0QblWWWQ0PPfvqpkUO6BD4J3I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cDb2zzMiRc8tW0OnXe7bSyDDe7/CyUShx7reIAr9hms8iJ8bG/letTutqFwbZKy3pwMgKGVaa1Fs+Haq7r6mKv5EX/kVsLQY8G9mARA/+eXcY++zAs4OEeiCa99NgH3lli3GXcGd6p16jsuQLNq0jlGhGnP0vgWHkIEW8GYqMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6TF++iG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80B8EC4AF12;
	Fri,  2 Aug 2024 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722641444;
	bh=dBNW9caHXAYXYFwPXe0QblWWWQ0PPfvqpkUO6BD4J3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6TF++iGjFrH0D5a9GMRA36uAPU88Im/EWaGHYRVm+i80Z8u6yTsR6ESvmxMBnwx/
	 UnZU1eZdjSkCFGzjVR9E4ZDSpNT1n1lCSUKQ5ofyQGe25ZODzWnxOpL0OSXDsreFXa
	 o8HpURrdDg9EOeRUmDKpCPtke7U9pAUBQ2edi5sOzYYZ+N8PVgvi8vlcv+5a3yBxKs
	 IWXExNKZQahOHH62hD+ncCC9aKGcVF7Tztw4X86AtZQ5r9lCVYZF6iigOTpMvLB/6Q
	 2eCtF8W347QQkFqr+KTi1IPctWlsnCLuNPeFMTbCE1WO8rGXUIFg8g0f8Y3VCQm0YM
	 jrG76Jo6KS+9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78270C6E39A;
	Fri,  2 Aug 2024 23:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove IFF_* re-definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264144448.25502.3568302485144724156.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 23:30:44 +0000
References: <20240801163401.378723-1-kuba@kernel.org>
In-Reply-To: <20240801163401.378723-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Aug 2024 09:34:01 -0700 you wrote:
> We re-define values of enum netdev_priv_flags as preprocessor
> macros with the same name. I guess this was done to avoid breaking
> out of tree modules which may use #ifdef X for kernel compatibility?
> Commit 7aa98047df95 ("net: move net_device priv_flags out from UAPI")
> which added the enum doesn't say. In any case, the flags with defines
> are quite old now, and defines for new flags don't get added.
> OOT drivers have to resort to code greps for compat detection, anyway.
> Let's delete these defines, save LoC, help LXR link to the right place.
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove IFF_* re-definition
    https://git.kernel.org/netdev/net-next/c/49675f5bdf9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



