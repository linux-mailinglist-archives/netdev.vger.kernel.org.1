Return-Path: <netdev+bounces-239359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB34C67300
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C37CB4EBD0A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176330CDBE;
	Tue, 18 Nov 2025 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sj3rdmfW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7F1EB5C2
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437845; cv=none; b=S+A5mycpS+/dLn/67C6ZfOjwyDdSORPET2Jg/pNqVlKgFBqZyH7AG48NGaDhZHHL1NDP4eadeFmH8zRPVDU8yJdHAD1/9DnmXQJAI+JKty2ownZFPVOW/Hjh9KX84snSyw54MRaDMiCw5EbghQJPNfaL/ronj8bSJjyyqMuCaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437845; c=relaxed/simple;
	bh=74iBNGLFoDBMiR8mvHb1GX9etUS1B+Yez0w7xGpGFZ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gfL8jbxeIb7Sm6P5UOh/w5OTpgtBOxM35mTUB9x2zvsaUt7GC6OtEJxs3wBoR6BvaAz4xZR4+p8+Q+yvBSe/TAaI1ZMXaYpH6VKz390JuNJ9O4GV5p6zOaBa8AvRw1ngzDbDsocQh4AR9mEgLBrD0h4wfIFO+8xFZs/MvoSIqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sj3rdmfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B3EC116D0;
	Tue, 18 Nov 2025 03:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763437845;
	bh=74iBNGLFoDBMiR8mvHb1GX9etUS1B+Yez0w7xGpGFZ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sj3rdmfWDAzf6hA7mOiTfz+bxAEHNWT/BTWykP9xqahnrXwI0IgGmgg1GywZvmPRz
	 JGsfreTzcTyzdWNMnKPL40qxcFvV6LHDdgX2IJ91SKXCwy6UcQdilPifzef5QY3rJD
	 qJdvFmsxTyzG08IecrToed+pPKo0KiyBDuKlU09PvGPcGCXa/tGu5j8UwRQtkNL0Sf
	 ZeUyP7a6+S4hYywECgggH+WC+ocjLa091wUxqb5n0/WnkBMr1ovrRMNPGebFsN67sL
	 gt+eRureuf7ICzdf2S9H1h4VnsBGmFoO0QyUtnGwYcMfBDvBZu0G2t67FkTJ0UuA0J
	 cGRHs3mt47zoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA83809A1C;
	Tue, 18 Nov 2025 03:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] NFC: mei_phy: fix kernel-doc warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176343781074.3575942.14727831203245654978.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 03:50:10 +0000
References: <20251116070959.85055-1-rdunlap@infradead.org>
In-Reply-To: <20251116070959.85055-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, krzk@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Nov 2025 23:09:59 -0800 you wrote:
> Fix kernel-doc warnings in mei_phy.h to avoid build warnings and to
> improve and documentation:
> 
> mei_phy.h:15: warning: missing initial short description on line:
>  * struct nfc_mei_phy
> mei_phy.h:19: warning: bad line:
> 
> [...]

Here is the summary with links:
  - NFC: mei_phy: fix kernel-doc warnings
    https://git.kernel.org/netdev/net-next/c/7cf3ac8a9c0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



