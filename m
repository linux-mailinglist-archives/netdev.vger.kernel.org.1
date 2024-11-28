Return-Path: <netdev+bounces-147721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84C79DB66A
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 12:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECABA165610
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C07198E63;
	Thu, 28 Nov 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGRoLTjZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C5A198A0D;
	Thu, 28 Nov 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792820; cv=none; b=rdJLJgW6Hn7gPY5K8tCFp9aYcVPgOlP38s8mV4FLWdYZMtt12xJS6rDlRmDyjn2hxinqIv/kgqGDj3i2+SlTP5lKzZE6azmGm2OgjJlX9WFPrvpOjD0h/oDD//dhntGD3mA3aAVPvKQbklfd5TJZJdrUn2M3j1lKeIeuNr9/WMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792820; c=relaxed/simple;
	bh=sFGPuq2GrV4o7QT3erVbqFRlcQCPCRyyo2T2cpCOiVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ruESEMrONcCHbFdAsGdeAX1v7nonz67KOh1M+2OJhBL90eclLyM2dN/keD0hqbM9KB+A3zF8bOubIxybkgKpK1INmHy/lC89BwXFJmJfpKJmIUKiIFFN3J4RemhCQY3OAh0K8/eSiGB06c0I2cSp53tx0uJurY0+4aIoSks+eow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGRoLTjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1024AC4CECE;
	Thu, 28 Nov 2024 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732792820;
	bh=sFGPuq2GrV4o7QT3erVbqFRlcQCPCRyyo2T2cpCOiVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iGRoLTjZbDUrVsRWpwaFWrnHEwvw+QeC6qNuiXCDAFXqVfb6TZ1o7horrAGNkkY5t
	 oePNf7eRP5VJ0jZBW7aVaHVo88jx0fzdXPPwLPkW4RfnUJ5dhO34TgF0I3cACS+MqN
	 9xNtDcQknz//Shbq4v3e84ZMkFZ64kAdcED5Q+eeNxtpJmj1cwrl6+Pxt1/bJ167As
	 PPiG7kO8oCxnuO4+XbN7u8dj7SXDqDluBuddWqb790s8VXggq2kzFOTvb0B5G80yTn
	 BPlXTna+/EzGtvmEpSvoiie833Gc+2NbqBve5cmRM41nD6OaT2RKt5WH/YR+B0XOz1
	 V+/NVGYNZj6yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E06380A944;
	Thu, 28 Nov 2024 11:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: Fix spelling mistake
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173279283326.1703182.12994083213872459937.git-patchwork-notify@kernel.org>
Date: Thu, 28 Nov 2024 11:20:33 +0000
References: <20241121221852.10754-1-puthen1977@gmail.com>
In-Reply-To: <20241121221852.10754-1-puthen1977@gmail.com>
To: Vyshnav Ajith <puthen1977@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 Nov 2024 03:48:52 +0530 you wrote:
> Changed from reequires to require. A minute typo.
> 
> Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
> ---
>  Documentation/networking/cdc_mbim.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Fix spelling mistake
    https://git.kernel.org/netdev/net/c/6e33123a18bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



