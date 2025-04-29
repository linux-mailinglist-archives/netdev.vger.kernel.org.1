Return-Path: <netdev+bounces-186855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E18DAA1C31
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549E74A7D20
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1AE2641DE;
	Tue, 29 Apr 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCYcpLz7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AAC25F998
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958598; cv=none; b=ivlnooXs7pXdYM7OAk3of5lyFdPJ/VNxh0rw9Av44uZUa+DOrLd1TJNlAmwHbQxko9stdtSORrCvIjUb9SuZAEOt6JSXecPSa8KMGYVdEMB3xTG/z++UvFR+YbsYdVwjZnNPeqh1tgqE0LmSx79MJEoYmaWyheGjjVLPsW2p3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958598; c=relaxed/simple;
	bh=evjUxLlJTvHXQFWeLAYx2xqGxRUJCTAG+cl4Z+2eKWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r+b77C8Df6Fup6z3CAywriBZ648cb1JM/umf/ZVhM4Iq4MfS9ky8MkyPknw2NCO9SESbUpRSdktUBlx/7aM3nXCXUnPbUQa8iXf9i+6mZDl8uWHw4vNPfm+kkcf1U4nqp26KH6JhPrlkE0+3/nox+97wsqcBhG8v0o4RtzxbaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCYcpLz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4769DC4CEE3;
	Tue, 29 Apr 2025 20:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745958598;
	bh=evjUxLlJTvHXQFWeLAYx2xqGxRUJCTAG+cl4Z+2eKWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cCYcpLz7Ho+aisyyV7yoKz+UfQSG8Peu/VOsNSEdPUtsjIFYdbKU8bCizojA6rR6/
	 TsQgTaNi+Kb6sJXxv/sQuT0jfnbtgjEygU/UpEQMto5wxBnwyqHukrICy3bTJ+xfvT
	 6RTOayIMczjLtDVxDrY81sp9hz54AM2LXa+umliFXn0zzK5gn+MY179DVWUI0Nt0iu
	 N8GoGmP02zkHwZJSScZD6p6BYkthbEivhTHE9rl9EcaGZE+rb7ATb8rlWwQwuVnG0D
	 LWVg5i79VISdcl0o4mocqehpt1hWfCXR8Y+kkQfse6ViA952Nlx5fIK4xkD0yMpQJO
	 4lZhQ9JC6m+qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AA83822D4E;
	Tue, 29 Apr 2025 20:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next V2] ethtool: fbnic: ethtool dump parser
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595863700.1788116.17627977632235589390.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 20:30:37 +0000
References: <20250417003020.2527974-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250417003020.2527974-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Wed, 16 Apr 2025 17:30:20 -0700 you wrote:
> This patch adds support for parsing the register dump for fbnic.
> 
> The patch is composed of several register sections, and each of these
> sections is dumped lineraly except for the RPC_RAM section which is handled
> differently.
> 
> For each of the sections, we dump register name, its value, the bit mask
> of any subfields within that register, the name of the subfield, and the
> corresponding value.
> 
> [...]

Here is the summary with links:
  - [ethtool-next,V2] ethtool: fbnic: ethtool dump parser
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=a38a2d3a8271

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



