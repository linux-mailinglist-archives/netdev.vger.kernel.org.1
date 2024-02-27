Return-Path: <netdev+bounces-75134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9650868512
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 01:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80C80B22528
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE401136A;
	Tue, 27 Feb 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEay6SW6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85837E
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994428; cv=none; b=KDmWP9am7SmlBDf1TMlkaIfwwK+U4osopxcCpVIv6dxlIAUoynLEMHk/xcXbBXYTBh2OrM2I5Iqh6Y6LMHbbw7thc12WviI2lDCcwVtdreTXNauEK8WgIRxx5mgpred4A945HkOhEh+9vZT5P+9aRnGQ0B16G6dMRRg/AcstJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994428; c=relaxed/simple;
	bh=Ueje1kSPXBTB8HZ4OMgBQJKys0+r5SL9rR5yXPAXQh0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZHstQ1vULOuNa4KslPT7Aw5xITF8vUS7tsSsK+vTgTTai/hPcJDhyBVmokSe3c7TelrDYAJ5C2raHQCYhR2gNupa9ip7M8Tz2rAknoydgsT22Y3T3SnQ2Q91w1D6PBMllbJhWHwZov7nzB7efMpLMsPxXRzEp4bGd0o8x0OZZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEay6SW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55F5DC43390;
	Tue, 27 Feb 2024 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708994428;
	bh=Ueje1kSPXBTB8HZ4OMgBQJKys0+r5SL9rR5yXPAXQh0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hEay6SW6EOWAHavoAo3FKXOv1ZeZ45NmNx4yMjZ8bYfwYEdGYzAqatSzmqHU7LHUc
	 sG7TQwLt4JGMZ7m5gnEkYBNXwWGeVcl6Wgn6pSKKoZiVNiueres1lYp+NGOLNLckpi
	 qnNdX1TFo96YArA461ib8bBRF4Ap4QU7JprzkBG3PJ8+OJ5r+1mMtb+oORvqClRDAc
	 B6k7uS9KyxQUtZGr6o4RMjklvVeaBFtWB8Hb6uF8MS9wh0LiWo4DIAuZ+EVC+bHc8C
	 QRCgDxqa8uw4ZIXcl1oOXj/70EwhjyFsOgvuec6PvTPhDdeJI66SmIg8gRfMwsFzm/
	 +QZwEbtIDc9ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39022D88FB4;
	Tue, 27 Feb 2024 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ip: Add missing command exaplantions in man page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170899442822.32588.13560162298089596731.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 00:40:28 +0000
References: <20240217212102.3822-1-yedaya.ka@gmail.com>
In-Reply-To: <20240217212102.3822-1-yedaya.ka@gmail.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 17 Feb 2024 23:21:02 +0200 you wrote:
> There are a few commands missing from the ip command syntax list, add
> them. They are also missing from the see also section, add them there as
> well.
> Note there isn't a ip-ila man page, so I didn't link to it.
> 
> Also fix a few punctuation mistakes.
> 
> [...]

Here is the summary with links:
  - ip: Add missing command exaplantions in man page
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=2bae5a315abe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



