Return-Path: <netdev+bounces-173583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A7A59AAD
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7AA27A5837
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735B622E413;
	Mon, 10 Mar 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4jHJdjA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5BD22E401
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622998; cv=none; b=egL6TVy93I4jblpV4ibB2AwUrBbKuXgUIHDpMdlWPMV81rEwnKg+c+queAu1Py7b1Z6EVr5I3kBUDep15fbmcDsO86j98FQ9Kr67YcJajzTD19J21Ff+lb4mY5MADxY26hP0qnk5TAOR/yB9rPSTmYVziYgQiJGfcTODhpBtRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622998; c=relaxed/simple;
	bh=Ip63Ayp4gPkWiBJeO6SoMCDQhnTncCNzdOhDDdYYSBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Esy7kygC6Q3w8vt0aRL/2EW9t2k1Ad0LTbof1LzMhjByBRvxyn6xwHWo2AA+yQMKSY/21ahQ6yC/oFrTZu6Yr5pv3pgMPsLrw60ppRhaWBkfkiCk9FzkqJkyjTRYInB4yQ7ejmMz3F8qaYJTigxYVlywzhXxLnjCnB3gVlo6GSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4jHJdjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46E6C4CEE5;
	Mon, 10 Mar 2025 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741622997;
	bh=Ip63Ayp4gPkWiBJeO6SoMCDQhnTncCNzdOhDDdYYSBI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p4jHJdjAwqy19cdORE1Tlf6+vLII7vG5qamdC4sZgjyAvNwSTyYPxcRSibKGlBgUo
	 iGROs9lAYnjCEt22seOQBUUJdWOgaigY0zWRR8IcF+iS3g5eonCz2ylG1yJjgxSotV
	 v0niW+cROoRbnV+5d4t98tUkeBsW3KZUT80fO2TSCDM2RuwXh6+kb0v4PAIJn30ttk
	 GTEHTuCdERnlls58DKmfyTJ7Bph7wKhbLaWag5c8wiSyXorF8b9Zz0Gfypii3PMA8A
	 u/7S+FHdak/8WV/kEsNrUwFz2JyFdArjYM18i5tvN4ahfb+KtuP2jwlmfNCkTZ6FkS
	 ok0tHXkqn6leA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCC380AC21;
	Mon, 10 Mar 2025 16:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] man: document tunnel options in
 ip-route.8.in
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174162303179.3587535.17943123354742594958.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 16:10:31 +0000
References: <e53824a6dc6a300b44d2a58a067722e35d2b74da.1741617346.git.lucien.xin@gmail.com>
In-Reply-To: <e53824a6dc6a300b44d2a58a067722e35d2b74da.1741617346.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 pabeni@redhat.com, marcelo.leitner@gmail.com, aclaudi@redhat.com,
 jtluka@redhat.com, olichtne@redhat.com, wenxu@ucloud.cn

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 10 Mar 2025 10:35:46 -0400 you wrote:
> Add missing tunnel options [GENEVE_OPTS | VXLAN_OPTS | ERSPAN_OPTS] and
> their descriptions to ip-route.8.in.
> 
> Additionally, document each parameter of the ip ENCAPHDR section, aligning
> it with the style used for other ENCAPHDR descriptions. Most of the
> content is adapted from tc-tunnel_key.8 for consistency.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] man: document tunnel options in ip-route.8.in
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=5e113abad9a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



