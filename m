Return-Path: <netdev+bounces-140180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8709B56F5
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509821F22D01
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE620C024;
	Tue, 29 Oct 2024 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J87KkwkG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FD190665;
	Tue, 29 Oct 2024 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244628; cv=none; b=t4GUHY8saWVaK659pDhMcublNu5bzvZFjSeR0hcl2KoaFl+JX64Zps4nWfG0YMIpe5Gbjzpr2kcqs2JRwqiyeeE+ws3hN5GYJOiNM0PEh7fDbioudRHGaTF8kuR4w5LoLmv5TJKUtlniOLXrnm3p/S1fBQYlWuCSRsUaRGhWibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244628; c=relaxed/simple;
	bh=bMTz5orGXTH+4D0xpkNLWyraHhGfmIrQ9V8w8L61aAo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EVJA3/62Z+76pcRe6nsewYwwQj0NZlUvBRcCoobsaW1VqOqhMdipO1RdHFkmnQfLXC3KtMAk89IvQowYANmzSAGlpHqv2P4MqVLUhDHNI0tcUjctiVHxhVTiztk5OqiMTGg2SuP0PJvSXVnqasW1sSy4uYdJtiTM2tnIWczsx6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J87KkwkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9B1C4CECD;
	Tue, 29 Oct 2024 23:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730244627;
	bh=bMTz5orGXTH+4D0xpkNLWyraHhGfmIrQ9V8w8L61aAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J87KkwkG7MVXPNHosecoEtJkEgpMRasMqXTy8RC9plvJdmZG27ODL8/3smDgMyIEW
	 EihWAe18UkRi/DqtQzEf3xkHBzFJFkBEd35pMeZk7o3OrOMJyFWZF5nbdtxKL2PL52
	 GhXCnXf9IFGXl9I9R4tKxDSBc8cGfDW65Q5TulWBBW4tGYiXM4m3tjh3cUUOSYhCBY
	 FwtTpKru2F8N64SuoAb3J7aLnQVmMXIHK4VDYC20A0oiPhG9TcKvxJQbnapT8x83y3
	 SaupDKNhlSF4Yyqvx2hlsvny16p06Y2c04JwxWaWZP2hgeCPfH7QAdmdit0hD55Ap2
	 MkMPk1f2aepHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D18380AC00;
	Tue, 29 Oct 2024 23:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/1] vdpa: Add support for setting the MAC address in vDPA
 tool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024463498.852400.13607424738542466548.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 23:30:34 +0000
References: <20241029084144.561035-1-lulu@redhat.com>
In-Reply-To: <20241029084144.561035-1-lulu@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 parav@nvidia.com, dsahern@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 29 Oct 2024 16:40:06 +0800 you wrote:
> This patch is add support for set MAC address in vdpa tool
> 
> changset in v4
> 1. Sync with the latest upstream code.
> 2. Address the comments in v2 and remove the MTU-related code,
>    as this part was missed in the previous version.
> 
> [...]

Here is the summary with links:
  - [v4,1/1] vdpa: Add support for setting the MAC address in vDPA tool.
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=9fe68807db20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



