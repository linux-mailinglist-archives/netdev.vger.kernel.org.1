Return-Path: <netdev+bounces-91250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF9B8B1E39
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 11:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5092825B3
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5233B84E0B;
	Thu, 25 Apr 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaPpShNJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1882C63
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038029; cv=none; b=DZZ5zjBAqFz+4VPxEoI2N9idulJhfClSR3GorQd3TaFMb/iQ80/OpsrTQ1M5U9jpJxoLku7F8MTwbDsEKpKhp7Fy15zSymApOeNt1LTKzRtrfhfJSbF/prEjfo7yK80YPMcPLx3xd7PMraBFRyzVItUMKRtumS+TzME3yJkHZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038029; c=relaxed/simple;
	bh=E9yhwWtKo247qcUrK5W1k8RXEiFWzkOaYryJxmvZk9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ocl3Gy5EytUVb+LBy+k8mSlheg+jND8debRIoVdyb7gnsNF48fZyetuTwY7fvEc3fMfubEsUmfDLbXGzIrmtV1Mr7ztIQbt6foJ8/s1qXHFTnD3UoqFf1e290aKiWCxlBb2z2iJlnFVRLu6XRWlzcrCLGU27BR8difEtdY/umX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaPpShNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92B39C2BBFC;
	Thu, 25 Apr 2024 09:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714038028;
	bh=E9yhwWtKo247qcUrK5W1k8RXEiFWzkOaYryJxmvZk9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XaPpShNJsOwMFlxMI58HfZcJDPVFRtaymNNlQSecLY9uM+I63ev31JuCaswPLU6PF
	 hozpqKEcEzCNtzM6+q1EXRuLTV65I/48PSqmBXVJyQaenehNTj+9o7Uf2dZXXdXtWT
	 xqtesznzEcOS+8Sns3sFsCx9f6VEDF1F9IryHL/59E+iFDjtpm9E/Tz//SW94haxHI
	 vRnJowp0sVNC+NdsvO9N1xuYo9ZamN2S0+Q9uKveTU7AaQXH6AYwvaDJ65sD9KZV3/
	 jR5s6cFyz5ZYtiyJnxneayjKV8ULrFQCG/ff+86/Gd3MpNnU2QBLki/AARwfty2jsI
	 u8EfyY0ATgS1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A6F7C595C5;
	Thu, 25 Apr 2024 09:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] enic: Replace hardcoded values for vnic descriptor
 by defines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171403802849.30265.357715525179258561.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 09:40:28 +0000
References: <20240423035305.6858-1-satishkh@cisco.com>
In-Reply-To: <20240423035305.6858-1-satishkh@cisco.com>
To: Satish Kharat <satishkh@cisco.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 22 Apr 2024 20:53:05 -0700 you wrote:
> Replace the hardcoded values used in the calculations for
> vnic descriptors and rings with defines. Minor code cleanup.
> 
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/vnic_dev.c | 20 ++++++++------------
>  drivers/net/ethernet/cisco/enic/vnic_dev.h |  5 +++++
>  2 files changed, 13 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] enic: Replace hardcoded values for vnic descriptor by defines
    https://git.kernel.org/netdev/net-next/c/369dac68d22e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



