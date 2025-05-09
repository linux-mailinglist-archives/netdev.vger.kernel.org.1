Return-Path: <netdev+bounces-189405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE41CAB2046
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6E69E87D3
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555BB264FBC;
	Fri,  9 May 2025 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8p1thop"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312AF2676DA
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833397; cv=none; b=iUgs/mjaeKSccACWHAEYQE7YToqVYOpF/NY56yzuDMhe18GGpGe+bI8DygauB2VZnnlWNkairtwZzrzFuP+gkpI/K620qSovFGHXkFcL/gB57nEJY37l3VJ+sq3ru170vhmZpC7NzlZXIBC1aKvRphfPaOeUr3uPGr6AM7K+ptk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833397; c=relaxed/simple;
	bh=PADfpyWPkZLdZCDqLh8rRB2inP5NkwhZGjS+2zXci1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GvDj5eGfWKMSpa+TftpQjtSfzePZbxS8N2nyr+xsYaFxDm/0f/C5kAWuBXzQkCbbbqeCX5rSRONscfJ1lRiLke7iffdv0G12FehE7GDsOi5HAEEwVA+RJSU8epH7AhXYI/ogUC44vrDVxsLCvSNgX/lVq44rlyR6tp03dTjLr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8p1thop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B095C4CEF4;
	Fri,  9 May 2025 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746833396;
	bh=PADfpyWPkZLdZCDqLh8rRB2inP5NkwhZGjS+2zXci1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V8p1thop8EIlW0SPXLR3BU/0fjzHosZ6eqO/OWSSmPKlO4/lYn1uTnrkLwhHvZlkb
	 DLKfmrBj0P1qSkmYc5yyRqZ/nfcOTklOu0u7P181+BI7TWyCYhG7qwecpK+wUvkRMg
	 1L6bDYpSgW+vjIw9VbM2fMflu92EdI6gzvHwIWUP9/dF9DzcXHK7y3Fj0YBCoLvdJG
	 MQ98H01jeryT9zRe5Okb6xjt9FC0NYVRPHhyHYhwhQ3uHnteMtGoeF1EmQ/mHiYTK2
	 t5S3scrlQV3BLD3wpRLt8qxIX/bUP6YmOJu5iPYS6Mfgfx0dhqPjhKJOulwyfQ1kdk
	 QZWqtycJorl1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AAA381091A;
	Fri,  9 May 2025 23:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools/net/ynl: ethtool: fix crash when Hardware Clock
 info is missing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683343499.3841790.4154973310756554641.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 23:30:34 +0000
References: <20250508035414.82974-1-liuhangbin@gmail.com>
In-Reply-To: <20250508035414.82974-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jstancek@redhat.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 03:54:14 +0000 you wrote:
> Fix a crash in the ethtool YNL implementation when Hardware Clock information
> is not present in the response. This ensures graceful handling of devices or
> drivers that do not provide this optional field. e.g.
> 
>   Traceback (most recent call last):
>     File "/net/tools/net/ynl/pyynl/./ethtool.py", line 438, in <module>
>       main()
>       ~~~~^^
>     File "/net/tools/net/ynl/pyynl/./ethtool.py", line 341, in main
>       print(f'PTP Hardware Clock: {tsinfo["phc-index"]}')
>                                    ~~~~~~^^^^^^^^^^^^^
>   KeyError: 'phc-index'
> 
> [...]

Here is the summary with links:
  - [net] tools/net/ynl: ethtool: fix crash when Hardware Clock info is missing
    https://git.kernel.org/netdev/net/c/45375814eb3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



