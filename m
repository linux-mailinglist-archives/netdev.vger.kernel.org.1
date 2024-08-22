Return-Path: <netdev+bounces-120860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FD295B109
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B38B1F22B85
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD0C15C156;
	Thu, 22 Aug 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWGaTTIt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8A1CFB9;
	Thu, 22 Aug 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317228; cv=none; b=qK4IzeBg6Q+2PZFxU97h/8o4z7TPpyubVW/zs5r5Qw0YUxRBODYxHUvoym9vkkC1t9E258Kb2mijcAQV0eXZdwHDOkPfx6zfvsH4wL1XjiyGOg4LbfK4JLLxoTV7hs8snx0Mr/RkTflOppouMkjaZ3t2Vi5e6VDodJ28Ya4VSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317228; c=relaxed/simple;
	bh=atPSiCFdfkMcesNUaH6RuZASJxuNsj/f1YGmoqPIWgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=paLS2Q7WtC+mNGH6VWqFFof7TShh4uAIc1oIbsvFelKiOsim4c35sBj8lG5h6n0iS5nGcxDjlSTRMnTDTkDdM/EBOMRyF2D8i39ID6oqIXyy7Y7/M1ISuOlEGDJgDza5zw4FiXCuG+24Jhbce8ZxXcfHHYJWMmUPoI83Hgtv3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWGaTTIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC00C4AF09;
	Thu, 22 Aug 2024 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724317227;
	bh=atPSiCFdfkMcesNUaH6RuZASJxuNsj/f1YGmoqPIWgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OWGaTTItiO+GC3W9uvk1QaPFeC9waDb3ltn95nb36adI8/I2eUGkyNvhu6iL8VtLz
	 TMsxCWbW5fDCvn2Y+DBNgoCZo4aZSi9E40Sicvm+t+ylUVEcebm/I2P91YbPDK9Mz/
	 PLLqq+oRtJeNg+Y+1zHVSzH7tM7kUm3SeXQ0WEDmQqqFqoQJ3Qn7jz43NzcKsfSqjx
	 uSraPRmxdHsHz3sEOzpvZQm7bCWJZYqPRnaGFhK0R0QPJ4i3FoWBQVpD7frUylxwB9
	 EyE8cBwxenYfbGTazNdL0xky5FvPfYiiaHCUqXeOtjDOL745ftYGMI8q0jraASnwMk
	 Po02GmrzjxS4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341F03809A80;
	Thu, 22 Aug 2024 09:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: ipv6: ioam6: introduce tunsrc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172431722701.2256827.13061551625019118054.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 09:00:27 +0000
References: <20240817131818.11834-1-justin.iurman@uliege.be>
In-Reply-To: <20240817131818.11834-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 17 Aug 2024 15:18:16 +0200 you wrote:
> This series introduces a new feature called "tunsrc" (just like seg6
> already does).
> 
> v3:
> - address Jakub's comments
> 
> v2:
> - add links to performance result figures (see patch#2 description)
> - move the ipv6_addr_any() check out of the datapath
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: ipv6: ioam6: code alignment
    https://git.kernel.org/netdev/net-next/c/924b8bea870b
  - [net-next,v3,2/2] net: ipv6: ioam6: new feature tunsrc
    https://git.kernel.org/netdev/net-next/c/273f8c142003

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



