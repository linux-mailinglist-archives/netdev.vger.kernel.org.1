Return-Path: <netdev+bounces-139711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1459B3E41
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FDF282FAE
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0421FF618;
	Mon, 28 Oct 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtmH5LNo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A01FF5FC;
	Mon, 28 Oct 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156432; cv=none; b=DYZUT2e2ZAcujbWPxtkS0FaWh8SnW/1Vs9oxdCBols8yU2nQVE8VrF9FK0tQ36gF4QqXi++2qnzvXzAd5NDBvEGWjCFcrqmKaVS5EX6zUI+2ZNh3EBKdr2nANhkl4sx7ajm9/X/DJu7uMbeRvtRbuHl3VGP19Jwo/M15r5jbRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156432; c=relaxed/simple;
	bh=2TsbmtG/I1oHVpcvUjYRMWJRplrIg4dY7ZI+70HcFEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FUICLTsJDXrjOU/WabcXFI3QS5Uoxd781WW1QJmASf2waI5cLNY4zFWcPOtBbWgSBxcaxkKTfibal3I7i9OUxIdZU67KMtuB7mSHjS/bkrMiSjlyTPRr+j4heS0x4n7F+W/mHi+BFJBLJLqPFX0uU93k38xxJQPzoMOAwrZiujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtmH5LNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF5EC4CEE7;
	Mon, 28 Oct 2024 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730156431;
	bh=2TsbmtG/I1oHVpcvUjYRMWJRplrIg4dY7ZI+70HcFEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YtmH5LNoPmvBSX3uvS/MjU4rwMZWiGV2LcCO7guTUq0cr9BIEbWcNJERhZtwktknU
	 OCupG5tUyDQX0MMu8kaBjGeuVER7/GyJT5hqR6tmf4DExwsU3sJmMWN1uNiBSqoXQu
	 MpMU1rZLIqCweDdeKT5mg9lnAyjU6UAZfTVOWqEtiWiGO+8//FUXOfRkCpGLlXcu6K
	 m5lZ1/ER+3Y26+X39kNm3rEJD56EpoRQkqOzZDfMLs+AOHlye4AyYZIfqMOXZ+8rxX
	 QUX8RQ56QcMiajpurDEPH9mZAC3KXvGouwJDvQ8R0FvYSn6zidYMFZ+LMZvHBIoYW9
	 8bewih0z7Sj+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA3380AC1C;
	Mon, 28 Oct 2024 23:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: amd8111e: Remove duplicate definition of
 PCI_VENDOR_ID_AMD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173015643900.206744.7296998805951528456.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 23:00:39 +0000
References: <20241021153825.2536819-1-yazen.ghannam@amd.com>
In-Reply-To: <20241021153825.2536819-1-yazen.ghannam@amd.com>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, yazen.ghannam@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Oct 2024 15:38:25 +0000 you wrote:
> The AMD PCI vendor ID is already defined in <linux/pci_ids.h>.
> 
> Remove this local definition as it is not needed.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/net/ethernet/amd/amd8111e.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: amd8111e: Remove duplicate definition of PCI_VENDOR_ID_AMD
    https://git.kernel.org/netdev/net-next/c/9f6cb3197973

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



