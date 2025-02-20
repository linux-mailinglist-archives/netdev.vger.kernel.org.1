Return-Path: <netdev+bounces-167961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A865A3CF79
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5040C3B85D6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9421D8A0A;
	Thu, 20 Feb 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/EOSy0/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02817288D6;
	Thu, 20 Feb 2025 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740019804; cv=none; b=OnBmtyqlrbUgXXZrjpHbfJT9uuXmQbSzoeWV2YIomG4pJToAvLTkP+Qenw+3CAPr6CR2hw/+X+OgCkxnC7ZyFm+kT202h1o4ZJzNWtI/r8eSeH88aGTdPGalrTOPPr1NGvsYNkWoUzXYYPB++29q/lSMbpFq7rAlEhRmBY4AsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740019804; c=relaxed/simple;
	bh=1EFBr8jGP7VdlAZIMNCHUpVJedr+3H5A+v6tnrAdm6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DNcipPawbsiSuJiVEuOF6DqIBjqghRjWbHlW0OiRN0E13AtYzQuGqx7YgePxlJNfFLYpVU8cb1VCQII39/JTooVxeqF2nGZXcclb9N/Gq76fUxx/+EvLb1S/BzvbOjtEEOviQVV45l279rNPXjCTV+Ci+7L3RjHjVXi0yxxu09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/EOSy0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0D0C4CED6;
	Thu, 20 Feb 2025 02:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740019802;
	bh=1EFBr8jGP7VdlAZIMNCHUpVJedr+3H5A+v6tnrAdm6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V/EOSy0//qGjdH+D8FiP9p0kOEqu8tAgehAmADlymKcwaJbW2s111QT2QjUIBQTcz
	 VDb7FvJ2NuJfAZUKPHfc38papOI+hKNncPHfW/6Wt3Yuv4in5IqaZNVg/NgEWw9wqM
	 eN5PmzX8+ixpsrVmCv2TcQlMrMZP6vaafIDXA5z4SFIBdgPbzOWXkKrL/ldUYFz6zM
	 nMkViafJ+XTAgKSd5UATJaiQxK5ayZfp/PSUtQHaZQ0XlmMhOFVb+OcJXgTNxAgVCi
	 ZyB2K3/cjPTUTzeVrlBAzvS8MJSpEhbYqXA2NZc2Mzvtfngv6BfK+PJrpmGpuDRnx0
	 6lPOXO30459fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B68380AAEC;
	Thu, 20 Feb 2025 02:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] net: dsa: b53: mdio: add support for BCM53101
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174001983300.821562.10124139591919697311.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 02:50:33 +0000
References: <20250217080503.1390282-1-claus.stovgaard@gmail.com>
In-Reply-To: <20250217080503.1390282-1-claus.stovgaard@gmail.com>
To: Claus Stovgaard <claus.stovgaard@gmail.com>
Cc: claus.stovgaard@prevas.dk, torben.nielsen@prevas.dk,
 florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 09:05:01 +0100 you wrote:
> From: Torben Nielsen <torben.nielsen@prevas.dk>
> 
> BCM53101 is a ethernet switch, very similar to the BCM53115.
> Enable support for it, in the existing b53 dsa driver.
> 
> Signed-off-by: Torben Nielsen <torben.nielsen@prevas.dk>
> Signed-off-by: Claus Stovgaard <claus.stovgaard@prevas.dk>
> 
> [...]

Here is the summary with links:
  - [1/2] net: dsa: b53: mdio: add support for BCM53101
    https://git.kernel.org/netdev/net-next/c/c4f873c2b65c
  - [2/2] dt-bindings: net: dsa: b53: add BCM53101 support
    https://git.kernel.org/netdev/net-next/c/dfc4b67db06c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



