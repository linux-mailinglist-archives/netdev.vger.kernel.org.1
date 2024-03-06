Return-Path: <netdev+bounces-78020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C2C873C4A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65F2B22ABA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70C9137934;
	Wed,  6 Mar 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNPyOQBt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B158004B
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742628; cv=none; b=IVddmrdiMlx80dyBRfOGxIPD6liVNlasNKD+3iYrhAfvbJEhzs9LSwavmlSE53AAbRZ2VjBKpzwp7BAgTXEqdrEeWbLNmIwstQvM0IyIht/Df4SgwbvrgKp7YuFQAxd1ws60Z/wcMLQ37nFBOcT4oXs2GZluJiBMhUfhR2XXKuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742628; c=relaxed/simple;
	bh=Z9T1libhnlCIsRPbznxn6R2x+UYfld6/Hvkh7oPPh90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Icxq2YFxMBwHzTJnewDtL9AmruTK5xsXaYN5p0eiww0WsLBUJgFTD1oB3ZAj8aOcX4lQWQsHAWoQBADe8dmi5NtPD7kV+W9X9bf2BIRmWz6mQO7Am9DqvN1rR5shOMhejHBBOyCgAy+naw1j/MoCFA1hKxnqs3iGCnhdOa67qTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNPyOQBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28C5AC433F1;
	Wed,  6 Mar 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742628;
	bh=Z9T1libhnlCIsRPbznxn6R2x+UYfld6/Hvkh7oPPh90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JNPyOQBtlxQlTZzGODT5gvH9VG2sBmPQebOfs8k1EJsA75LtJzu0LwHuduHoH6Y4L
	 d8+nyTgjPYBBaRYoIzy9bzZjA0CpR4huEwa56kCbiokL8a1sbFr/ow3Iw5NcYig9Cj
	 AlqXBSdNwr0ymX+vjom/K4IMilGhR8qM9dcrPy/rIokj5QAOiDNUAKUpuWh5reDp5Z
	 arhKV0LPfcAyHbVeq+3tqHbmjHjA74ojhDMZ7lnJ4FHcowmHp6dOjo/XslSlBM4tI3
	 7mvK08Nt3tTSn2favhOAk8n/jnc3sGCtp3nwcSrsicDdJdFHH6dHFRy+oBIYqMRhUK
	 6HbSxDn4qqzNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0901AC3274B;
	Wed,  6 Mar 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3] iproute2: move generic_proc_open into lib
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170974262802.15464.12216033367377027459.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 16:30:28 +0000
References: <20240304141340.3563-1-dkirjanov@suse.de>
In-Reply-To: <20240304141340.3563-1-dkirjanov@suse.de>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org,
 dkirjanov@suse.de

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon,  4 Mar 2024 09:13:40 -0500 you wrote:
> the function has the same definition in ifstat and ss
> 
> v2: fix the typo in the chagelog
> v3: rebase on master
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3] iproute2: move generic_proc_open into lib
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=a9fce55334f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



