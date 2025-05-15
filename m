Return-Path: <netdev+bounces-190589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE687AB7B85
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF6F8C139F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAD289800;
	Thu, 15 May 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9hu3LlV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6651288CBF
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747275594; cv=none; b=iokqTpUtH+iwKt322z6toOzvz0uqRrlBwcgvd47ZUSHgbhoQA1U6//u4BEblKS9EbJSd+s3/v9ogxmmEUfm8vif5qaCjxysn1t4X7QppsAg7zSOgqQMIL8Y10I6PGAIVcKulRpIVJRsAF7CrhZ7NhVuGEumOBsQgxR+SaeJEPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747275594; c=relaxed/simple;
	bh=RQDhz5AhnDdZxxkLLnxeKYKnxBiqzonmoI6bBNkAsz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kh5oGtpPHuYYYPXJxKreONnU2Yi8qk/nG+gQLomUakb6SIWXBMEPloUkUWNvnXhLO60cAUOMjEPYR3W6E5R2YUscRYfWXC/ZIDjoOcJib47rXbzWLplhqX/KEozFz4YCcWuM69d3ZQYrjOTTSpz2PIKB27Oov8Bwb4pm2MzdSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9hu3LlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43552C4CEE9;
	Thu, 15 May 2025 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747275594;
	bh=RQDhz5AhnDdZxxkLLnxeKYKnxBiqzonmoI6bBNkAsz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V9hu3LlVby4QOaURI4pZpEJSITNpSlhnF9Bu3yssdhqqE2D3zPlsSC77gfBLJBYvQ
	 L5NznE/XMxSVKatmfLEPqhFA/mTRHCVpzh8Cdto229Fe7b9/TW7yq5iDN6I7mWWbb+
	 hJ3xV2OsWJisQK2gwkfAnjZmOuF2lIcJp0JjYcWuLc+7PmKknX1ITuYM7VVOHnKEVb
	 WFX/15R0w/HVJLM64AMDvRGjtdD20AEK14e+LGhZDVnHM0ThgeykN9wKUkgtuRjCte
	 M+gHk/0Z8CvmtwxNXn4rXV9jfafrqBWevnfEmW4UzisgfEVLTYlAo9t5+4xe48VOma
	 MQrhPQmwMSJrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBA9380AA66;
	Thu, 15 May 2025 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: specs: tc: fix a couple of attribute names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727563124.2582097.9681803117394747704.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:20:31 +0000
References: <20250513221316.841700-1-kuba@kernel.org>
In-Reply-To: <20250513221316.841700-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, ast@fiberby.net, xandfury@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 15:13:16 -0700 you wrote:
> Fix up spelling of two attribute names. These are clearly typoes
> and will prevent C codegen from working. Let's treat this as
> a fix to get the correction into users' hands ASAP, and prevent
> anyone depending on the wrong names.
> 
> Fixes: a1bcfde83669 ("doc/netlink/specs: Add a spec for tc")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] netlink: specs: tc: fix a couple of attribute names
    https://git.kernel.org/netdev/net/c/a9fb87b8b869

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



