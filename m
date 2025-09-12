Return-Path: <netdev+bounces-222375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9799BB54011
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B565A6E6F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4AD33E7;
	Fri, 12 Sep 2025 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2hHaoSg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BF3195B1A
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642428; cv=none; b=MMqoQqwo2kuU2HA+izll4HEOB7sTPD8CXiGsQpGVww9p43ppX0rU6tW+/S/KoRR8Og/X4Y0hkmwpp9CetTbWfkhrWOdWVSim3sRF/ccW6C13n0Vmh1YsldKT0aDJDYsVbAhVfDwIKQJS9SQtyjiTkO/tZvtKmdcfPKDDbi0M/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642428; c=relaxed/simple;
	bh=DAKUBlyjV9d85+isZtwOncLgGKba/y4e5ANoFzeWhh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GwK97g/nTrcE1k9UHqSZPfwpcfXhPglLqyD/mkoWYA805wpBAkn07Zr3Y5iVIL18xAZsgy/VRiIGVt7QzenQUPtuzug02cA4t8gwOHuZ9AaUYXzDc1K5DlMRXDuA1FaxYL2OVeeEzB5igawqUT7vw4reBb3d3pb1wIFLkXgZ+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2hHaoSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ECEC4CEF0;
	Fri, 12 Sep 2025 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642427;
	bh=DAKUBlyjV9d85+isZtwOncLgGKba/y4e5ANoFzeWhh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e2hHaoSgRwv2o5hmdKKRTqeZn+HXzN3EYLOzpqWs24p6TBsykNgobvy5iQAde0wxZ
	 dverTg/7kpFRd8RNpQW81Dj2KKz5ocDMSlCsGbKo9dz0Tta8aXshLfv4T77AneugmN
	 7C/jumUvpDOPrvNDLwscsSqv55EQFLK1k7gqo7kZMdFZYuZHCy5peQ2GcgeUGsAzgS
	 LUXqQV+ToR2DeRFLE18MIVLJ/l1mY6usJeNkAGTjEYNcAw0jC3W9YpARVTRJNS9dfu
	 V01DYutMX9sKJcfbB6hr9Pyten6enfFvg4dcEzSSNRZN+BdpOIH9NMqF4TkAbKbRWN
	 my+K+hAcaTenQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BDA383BF69;
	Fri, 12 Sep 2025 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv6: udp: fix typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764242999.2373516.6904077191929718487.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:00:29 +0000
References: <20250909122611.3711859-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250909122611.3711859-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: dsahern@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Sep 2025 05:26:07 -0700 you wrote:
> Correct typos in ipv6/udp.c comments:
> "execeeds" -> "exceeds"
> "tacking care" -> "taking care"
> "measureable" -> "measurable"
> 
> No functional changes.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv6: udp: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/ac36dea3bc85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



