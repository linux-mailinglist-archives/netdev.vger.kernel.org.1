Return-Path: <netdev+bounces-223633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B57B59C44
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82FA47AAEB6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325A3629BF;
	Tue, 16 Sep 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKAcP3Ss"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61C345754
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037085; cv=none; b=u5L2fHuiouvW/P+4NidpklGSNBo+ht3842F7JPD47GJkYu9JoPHdnbvQn9aHVmmAQzFiL6QmcgHyyPB1TJom+INW7NZQBCJfv4jD9xiDfH21MohHbhd3y0BJUNqI/86mdS6F7G7Jn5cBx6f33VU6zzy/i+99b5KshC/IUJRPrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037085; c=relaxed/simple;
	bh=oWr9WvifrAkTWtmXS7VLKZpeQglwqTTCu1HJXbLUiSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PDp+D+tKK6n6p1MhDfiPj2zMKxgvZ+5y4/MdnwFHUswOwDxrbR1IZNlVv2RekE0Oa1V2DOavpQWldk7P9W7JChkQq6yv28sz0vTZto6WX0pa1pgv5vG4TU61NGdPpUNsJWPHrzmcimrHeM/67YYCX6DKYldnrnTRi1dJREXucgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKAcP3Ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A6FC4CEEB;
	Tue, 16 Sep 2025 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758037085;
	bh=oWr9WvifrAkTWtmXS7VLKZpeQglwqTTCu1HJXbLUiSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kKAcP3Ss8lDkmT6FG17AJqq2BnNiOrwri3UsGnlt8xtjqz5QPi2tw4Go2HcrPigfb
	 9mYZg/7zwu6p7ZPUVHdFJdOP01ns1HsC+HtKGqVdxWz5pyth4ymMyQl9LCgrFdt3cA
	 pYcuRbr4F4AZMi6W3XrdfWPvj5ZHRun6vW83aZc++eHwPwSQUtZA4TKd9T4LTPGweh
	 8MEWhBowilKg+I5pltcTtO7CrSetnl4zoQJtH2Irm9RL6oHqzDXClXIf8riuhWXXZu
	 UtpkIDXilSYndUiXsQcGZYf2WWj3r3XpQ55MVrWVfgXfNsViHg0fOIAsFdlMlpedAh
	 LOazEmSVHwNSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5539D0C1A;
	Tue, 16 Sep 2025 15:38:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: avoid "use of uninitialized
 variable"
 false positive in generated code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175803708499.1166060.6121503858718992957.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 15:38:04 +0000
References: <20250915144414.1185788-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250915144414.1185788-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Sep 2025 17:44:14 +0300 you wrote:
> With indexed-array types such as "ops" from
> Documentation/netlink/specs/nlctrl.yaml, the generator creates code
> such as:
> 
> int nlctrl_getfamily_rsp_parse(const struct nlmsghdr *nlh,
> 			       struct ynl_parse_arg *yarg)
> {
> 	struct nlctrl_getfamily_rsp *dst;
> 	const struct nlattr *attr_ops;
> 	const struct nlattr *attr;
> 	struct ynl_parse_arg parg;
> 	unsigned int n_ops = 0;
> 	int i;
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: avoid "use of uninitialized variable" false positive in generated code
    https://git.kernel.org/netdev/net-next/c/a6824f65c996

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



