Return-Path: <netdev+bounces-239768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD9CC6C474
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 289F04E9824
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF724111D;
	Wed, 19 Nov 2025 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGBrTDZ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98F221F2F;
	Wed, 19 Nov 2025 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763516450; cv=none; b=GnNAPX31I0NscobP2qu+ISSEJyswE1VLMGLeHsz+aHaWgtcpJgW5yLmW4XuY7tkTpVogkp8bqHgkiy1R7ruIxkcuhcg3WWKqhMjNONZynud3RPbBLxLw3OWFqPi/R1w912cJS2F98GJktRVqfUYaP9Ys52OlPjEfKYzBq6wHbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763516450; c=relaxed/simple;
	bh=Iuaw7J4dfPz+VjKhGbJY6rki/beeEkAKn1oGdfL+C4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DLKLUmMhtZ+HF8oWb/4Cgx9JO/mEWwVqSzSUsYVOitKpbTe2bTn0ZvLcxrzWQ+cdvZrjg0EDX8fxLzEYHqf1uBe2kQ9nAg3GkHRekbRqoDbR4FU/RSFTK8I0xuaGdD83vFNE/J/FCKB02PyOI87DJIdgsnUaJiRtmihP5OOH8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGBrTDZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1EBC4CEF5;
	Wed, 19 Nov 2025 01:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763516448;
	bh=Iuaw7J4dfPz+VjKhGbJY6rki/beeEkAKn1oGdfL+C4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KGBrTDZ9T9KrTSy4OapHZRJ78xABXFde+t3Q+lXfHDbMdllGdhVG8uldeOU/FxBLS
	 mibjRDkM9MjhqzRxUNEkNWApT9YgmUvgt4s6LCFKt9keh43IltXTgs3OWn1ATXp3H7
	 Vn3K/950vbqe2RtOd/XeD0vB0xuzhaSjbwx+SlJ9XRTrR5oHEnP+gFL2jNSuGAKYvz
	 WtsVMbJcpf/OaZzPBDzYYjrge7Z46GjkLJHDdl+mvLziBv+KIzUZ0trSMAnbhvBFez
	 3zA26JisBm2Os6iouCf/y2sp+BmN8ztrqmmARCvERK/k0odIs+XMIyMQOZ1Dl0YM3q
	 uXtFdfCVmozhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD3380A94B;
	Wed, 19 Nov 2025 01:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next] dt-bindings: net: cdns,macb: Add pic64gx compatibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176351641324.175561.12876827179234536373.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 01:40:13 +0000
References: <20251117-easter-machine-37851f20aaf3@spud>
In-Reply-To: <20251117-easter-machine-37851f20aaf3@spud>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, pierre-henry.moussay@microchip.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Nov 2025 16:24:33 +0000 you wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> 
> The pic64gx uses an identical integration of the macb IP to mpfs.
> 
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: cdns,macb: Add pic64gx compatibility
    https://git.kernel.org/netdev/net-next/c/f4e3402f59ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



