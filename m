Return-Path: <netdev+bounces-32862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7685679A9F6
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5931C209BE
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162F711CAD;
	Mon, 11 Sep 2023 15:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5311CA4
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF590C433C9;
	Mon, 11 Sep 2023 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694447411;
	bh=T5ElRX7psvlpJSLqg7vhRn1otwoHt32NOVr5qBN+j5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DA65DCqTEScjyUlS7awjZq1Js3K/QMYqfOFqtusFK198VYOGkAMHOmcVfwpiFZuD3
	 3OMj1IhEmcRvomA0wfi0m5eGTZy4zY9Q4D1f3S3It6hEesCvAawVijNeMweRtOUAZb
	 F/M1KOqgOYeIRqkUPhx99kI/Yv1a/y9GED2afdEIo5jyPQMyrhvaZK5HevgWUJ33KO
	 tkJZKlc21r+ly81IeZ1yJoiG+YEhxcZ5WsYCHg3B8zPI7GGEGvfb37Bd83bk0kaBGF
	 2fCzd+ZPpV6LnR8bmnpwXCY3L1QCJwnElPdtoh14pHh7j/dAyh/2QgCRrzO8VMF04a
	 7eguCgboGpWRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6659E1C283;
	Mon, 11 Sep 2023 15:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] tc: fix several typos in netem's usage string
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169444741086.23759.4623509578136152746.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 15:50:10 +0000
References: <20230831140135.56528-1-francois.michel@uclouvain.be>
In-Reply-To: <20230831140135.56528-1-francois.michel@uclouvain.be>
To: =?utf-8?q?Fran=C3=A7ois_Michel_=3Cfrancois=2Emichel=40uclouvain=2Ebe=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, petrm@nvidia.com,
 dsahern@kernel.org, donald.hunter@gmail.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 31 Aug 2023 16:01:32 +0200 you wrote:
> From: François Michel <francois.michel@uclouvain.be>
> 
> Add missing brackets and surround brackets by single spaces
> in the netem usage string.
> Also state the P14 argument as optional.
> 
> Signed-off-by: François Michel <francois.michel@uclouvain.be>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] tc: fix several typos in netem's usage string
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=dd5b1f585bf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



