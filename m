Return-Path: <netdev+bounces-83479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258DC8926DD
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9054B22D31
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 22:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B9130493;
	Fri, 29 Mar 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNGe8T+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422A54BF6
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752028; cv=none; b=GJNkldxqScu+Xle1n6gFjgdWR/nj3x+2cDUSIZUPohDuaHYAZMILiahAJRCzTWf/rgL8xd40eIbE4LRjXi2Ob7aMIGeqSGrXvm5Bcd5KQnRl2B2wqRF1bjy5xnIGwg9vcvRqBxA05NY+sNuP6eYzX1rTiuw/xqtPppWxUl7uLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752028; c=relaxed/simple;
	bh=VUmYEKXDlF4wS7Yo8cNwCnnm4QOfOVJSj/3PTpcpBsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KUYZnS5mQTWnly8goiYxQJaJZWQn5fgqjIPGGgveMCOqa/7nmAU/Vu6pm0lrQxT5QLB/URGAQP0lnDJdUGX4XO6RIOKPDB9fPP42HoU55J1qUyBQgToX6NdHuhVmluH6+G4gQ7ZtG33hZt5KproWoURaWbDBB7DHj13MLog7y0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNGe8T+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F647C43390;
	Fri, 29 Mar 2024 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711752028;
	bh=VUmYEKXDlF4wS7Yo8cNwCnnm4QOfOVJSj/3PTpcpBsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lNGe8T+nmkqRsk3h2OZtTliMXK1Jw/jrQedrderw2QF0C41aHCA7hfBKgzXObbI/T
	 mvQSOpIyQ8F6q4sXJSQ063k1bAogBj9eedWzHgrgEzdqltKkvfkFJN6l6BVMeCr4Zv
	 4E9NNxn8n/cARj4cx9O97tyBYxnjhwExxKHlnnC3kaWQa6SYzxRsOtOtADghI7IRMS
	 TKp2Pud8nrXyo6vTV7AMPj15X2c/1QOH5R6N6rXDnYibmOWVYqUXyEfBwC7inj/bJq
	 m8/GK+kpsFdz+ZIV4kpZGmgVT7WLEWcVy4RLceKA2vJQwfiYFIwGHQ+sNzkS+A/IDd
	 TOLN2qIrRiM+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31B59D84BAA;
	Fri, 29 Mar 2024 22:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: introduce type-checking attribute iteration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171175202819.29251.8300719399855725690.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 22:40:28 +0000
References: <20240328203144.b5a6c895fb80.I1869b44767379f204998ff44dd239803f39c23e0@changeid>
In-Reply-To: <20240328203144.b5a6c895fb80.I1869b44767379f204998ff44dd239803f39c23e0@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, johannes.berg@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 20:31:45 +0100 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are, especially with multi-attr arrays, many cases
> of needing to iterate all attributes of a specific type
> in a netlink message or a nested attribute. Add specific
> macros to support that case.
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: introduce type-checking attribute iteration
    https://git.kernel.org/netdev/net-next/c/e8058a49e67f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



