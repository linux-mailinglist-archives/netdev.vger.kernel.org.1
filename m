Return-Path: <netdev+bounces-146910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8C59D6B83
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 22:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF7F161CCA
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E451A7240;
	Sat, 23 Nov 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZMg/eAl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3141A08CB
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732395620; cv=none; b=TimyaTdJwEu13R57nqa1CupZFybLwTxAqz21ieSnJOlYyisPZIK9G4gNk52jbOzjWbs0JicoNcxWph2MLawBLEbPs9B8DznQTJ9bHOQJc8qFit2WoI0vT7Wepn8wLkrd7eEZpvxSPldp+rACaZpSzuz3b1l0zm8z/1/3B5wUoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732395620; c=relaxed/simple;
	bh=qTVa3W+ZhkMqLMdMDHWomkJ3h38Vgsa9Pr5+/iIulPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JjEESHOCGSeYQbEljtsTw8Bzq/6qyKwIo3aeR52uuhE0D90jq7CHmna39Wa20xd6VLLlwx2AUTWiBn0mhTAXHgnvMOQRtrBPmrjS/Ld1wwivA6U7Kd/d27keSqsBcHqD7LA1VRgkenmbvDNm7fLs8DZfXs5m+mGfjCKHYxeRowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZMg/eAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB36C4CECF;
	Sat, 23 Nov 2024 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732395620;
	bh=qTVa3W+ZhkMqLMdMDHWomkJ3h38Vgsa9Pr5+/iIulPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fZMg/eAly8rm/eFgbONqbjDlhu+XkZ2cyLa+qnUy62TTHj9sGAOrKAEMQFJW+IWlX
	 U+7ekwHfa0tLgrMTHqThAHmfBqDxtmkKy9CZqExrVlTbO87gydg0+9OnOjesKTfaJJ
	 1g9hhrZBp+5mWeyDCRRut457GgXYhjyBFpRCoqf3pS7PZH+kV4HZ0g41JIqY5br2/+
	 G/pPG9cRhn8ICRmGLxU9KZ0fUDwWU8sf9mQloy2ZvU2xnFRDen7Oj0zcl4lttdLDq0
	 XEl9oju7Q3f2YeV5/Eqd51hv/d/qw+Gs+vmpQMxBXNon27YzrSnfoawJS5JF68l1KS
	 3UsYOJAAh4svw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7143F3809A06;
	Sat, 23 Nov 2024 21:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] add .editorconfig file for basic formatting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173239563227.3081678.17133754509821646330.git-patchwork-notify@kernel.org>
Date: Sat, 23 Nov 2024 21:00:32 +0000
References: <20241116030802.1267075-2-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241116030802.1267075-2-mailhol.vincent@wanadoo.fr>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sat, 16 Nov 2024 12:05:43 +0900 you wrote:
> EditorConfig is a specification to define the most basic code formatting
> stuff, and it is supported by many editors and IDEs, either directly or via
> plugins, including VSCode/VSCodium, Vim, emacs and more.
> 
> It allows to define formatting style related to indentation, charset, end
> of lines and trailing whitespaces. It also allows to apply different
> formats for different files based on wildcards, so for example it is
> possible to apply different configurations to *.{c,h}, *.json or *.yaml.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] add .editorconfig file for basic formatting
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=bf410407103f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



