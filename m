Return-Path: <netdev+bounces-77891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ED9873612
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30331C20446
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783DA7FBC7;
	Wed,  6 Mar 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPQoBUqe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542794C6E
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727031; cv=none; b=JWeLboUssQWo+AuFWZjzvmUfScHWLJbnvOOsZnxIrZE7RHrlZ9QaZYiCYbP4SZ+YPYW61/hZncjHEoI0meBxV8HY6YeCzR36umls2vNnnqbaMrIXcyJhste1tlAITmxU/ukoTnzg7iPO95yOdHnir/IwegUEkP+Au7AlNWnUrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727031; c=relaxed/simple;
	bh=bYw/wTBXWu/q6ZaIntm2k+XQqqpRZFJKGHer+hq4C20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G95wZhaz46k+W4VcM4RK4tl+oK5FWSsSyRGdJfDYUeKHHcDXtQVKBGJVDJtJtu+0diiKISd1B9uArPp7OBHZOsVLii7VUVdBYbZ5kMKLzMdmUVMo1zlZcgI6G5NS402vtEuiZTm9NtH8gb2QIjit8mueBwR6fiapIrV3lP301/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPQoBUqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E18FEC433C7;
	Wed,  6 Mar 2024 12:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709727030;
	bh=bYw/wTBXWu/q6ZaIntm2k+XQqqpRZFJKGHer+hq4C20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RPQoBUqedCcDMvnZ6HDJ4d/H4+LjPMC2Xr+DlNVsF69xuYIf/ZcH/YO5PIq/KWqBr
	 sbLBFY0OS0IvDrAvcCjqBGdrXROF8/W//aXF22NKWKoslF6YjtuWTIK8bobKmk7gAU
	 tdRnWWowQZcatRiDKOGL5rON3A0FiIzzDGE+3xZtke3CMxlTunH16bWguzYNhKG1uH
	 GA0HcF3SuaWQ/b/W0aZIB7c9SPENRVswzL/QdB5Ezr4u+jVEWGJLmghlt1B6TENDqe
	 tCT/2GhnKum/CsTvfHOArntsIW1A5lVIWwWJegS6YDzjPD7HDkUMrpS+ScBp9Y8jUL
	 7iK5XseJToTZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1300D84BDB;
	Wed,  6 Mar 2024 12:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] tools: ynl: add --dbg-small-recv for easier
 kernel testing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170972703078.11436.219705901018302745.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 12:10:30 +0000
References: <20240305053310.815877-1-kuba@kernel.org>
In-Reply-To: <20240305053310.815877-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  4 Mar 2024 21:33:06 -0800 you wrote:
> When testing netlink dumps I usually hack some user space up
> to constrain its user space buffer size (iproute2, ethtool or ynl).
> Netlink will try to fill the messages up, so since these apps use
> large buffers by default, the dumps are rarely fragmented.
> 
> I was hoping to figure out a way to create a selftest for dump
> testing, but so far I have no idea how to do that in a useful
> and generic way.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] tools: ynl: move the new line in NlMsg __repr__
    https://git.kernel.org/netdev/net-next/c/7df7231d6a6b
  - [net-next,v2,2/4] tools: ynl: allow setting recv() size
    https://git.kernel.org/netdev/net-next/c/7c93a88785da
  - [net-next,v2,3/4] tools: ynl: support debug printing messages
    https://git.kernel.org/netdev/net-next/c/a6a41521f95e
  - [net-next,v2,4/4] tools: ynl: add --dbg-small-recv for easier kernel testing
    https://git.kernel.org/netdev/net-next/c/c0111878d45e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



