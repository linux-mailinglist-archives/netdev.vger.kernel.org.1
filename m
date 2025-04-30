Return-Path: <netdev+bounces-187048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09576AA4AC3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D32165483
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BC425A63D;
	Wed, 30 Apr 2025 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkRIFjcX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCB248F5B;
	Wed, 30 Apr 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015006; cv=none; b=pKEe6DGS5U0CoP0Qf4JGSI0ooaOThL9XA9+g15QXnc154nTB/lSAe9NK1/lpdRWrKDjnNAXqJW92IgapxJhf6uQ2LATAIXa2lR3eKs47PsY30Fz0DkJ9AW0IbVNJ28re4TVwLaV49RJKjYmLqDZElsgBacSjc2cGl28gN2Shanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015006; c=relaxed/simple;
	bh=WBSrjNBJ3OQdsyQov5DoZYcjP/wb5pnfBR9JpejUXWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gXeYvYZJ6JS+zf5DViJwhNb7U1DsJAzbrvcbeOuNbz5v1X3gccthBy6SxbGI5vLBzQ27D6LeyZQM2qYJC0vk/AuZtYckzFnCbmRPOhNgoaTpLy+kFNnm4mK/x2mdWwM3j6nAb9sySRinQ9UWZ/7j9hldlob1uJ3tM8c6H6pIB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkRIFjcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E82C4CEE9;
	Wed, 30 Apr 2025 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746015005;
	bh=WBSrjNBJ3OQdsyQov5DoZYcjP/wb5pnfBR9JpejUXWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GkRIFjcX5jmQMfCWmgz0rb4p4EBjTA4byTzg5/+AjLsg0Y5rZTTsHgpvlHHl3g6F5
	 NkOFRG/BQoyrtP56ZWXskXX8BpgrjfxRy3N3/LXeBGITTIVsTK2g/+3omovUp+QtLc
	 GnZy9jcpyLvoCx+5QP09QnuFRCTdcPDL9SwoiICdgao47VQB2jEwtV/HAVafDPBvxe
	 3BGo1qxbCxUrJ6E+tah7MDVTcGpx9jHdAsQt39j2iKW9WwSnopiMpGtljJNLRDHrXH
	 fjn75ubetyyblQ5sn9JuLiixxrnVDHLuGl6kQIWIjqPxvNfUQo8lKJF660eVa0EXu2
	 pkKE8fORLoTsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE523806642;
	Wed, 30 Apr 2025 12:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] pds_core: small code updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174601504450.2338913.3710874849878953588.git-patchwork-notify@kernel.org>
Date: Wed, 30 Apr 2025 12:10:44 +0000
References: <20250425204618.72783-1-shannon.nelson@amd.com>
In-Reply-To: <20250425204618.72783-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 25 Apr 2025 13:46:15 -0700 you wrote:
> These are a few little code touch ups for a kdoc complaint,
> quicker error detection, and a cleaner initialization.
> 
> Shannon Nelson (3):
>   pds_core: remove extra name description
>   pds_core: smaller adminq poll starting interval
>   pds_core: init viftype default in declaration
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] pds_core: remove extra name description
    https://git.kernel.org/netdev/net-next/c/144530c15ec7
  - [net-next,2/3] pds_core: smaller adminq poll starting interval
    https://git.kernel.org/netdev/net-next/c/7c4f4c4fa9b6
  - [net-next,3/3] pds_core: init viftype default in declaration
    https://git.kernel.org/netdev/net-next/c/6828208a45c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



