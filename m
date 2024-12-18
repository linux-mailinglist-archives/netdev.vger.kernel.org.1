Return-Path: <netdev+bounces-152939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035A49F6651
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA5C1893A98
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F181B0424;
	Wed, 18 Dec 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXSCIWzt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566021ACED2;
	Wed, 18 Dec 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734526814; cv=none; b=K7nwGePCI8jHZxrUsadTvJjgtePzRhIfM5x+1fp39oOX11SzNNeX+aGJ+S8AgXQagrC8Ifo9YB0Qzd9OCe62b+E+LcIuAVkxlc5ct0ITrv+Jg1I9HDNv1n38phXGYgk1eU9xKFDMCB/OCU+vGLmgO81R/xKXSs6v15+A8ni7K8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734526814; c=relaxed/simple;
	bh=lUyCjF2rHbMCDCGOuc3K4f/JEVP8amd4QCuUD6lnnLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WxZQ0MBov5zYN8PjwU2JQ0S0VwFhthkbU+8flgn8cKPMUbJp43t8sB5vP+SrZlMGMj4+k00/m2+nJx+izPVaATPEG1SKiFA72WA1xQLyOHy1w1lzQ9jof3ArHFMi42H02R7ow5lAm6AsYspO2waPWxDoPjCow/7P2lYZ/qEa6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXSCIWzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3AEC4CECE;
	Wed, 18 Dec 2024 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734526813;
	bh=lUyCjF2rHbMCDCGOuc3K4f/JEVP8amd4QCuUD6lnnLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FXSCIWztowIEGSKsR63BNYuz5R55wQLRX3k0X4IlEdg7xDgE0xGDHmYpLrksxBnrZ
	 03H/gHHqS7SkA0f/0UWGbt6NZZJzFzfU1wkdiBTvdRSCR5vUsMYSQCefUFTkfSElcB
	 DqRzddB1yx57matnFU7i0yvRuU//4URH+6q3B2qmZGZDczFFv1YOF33TIeorIQ5Qn7
	 sHSgdr4ypYRiKddT+Pt0H9Jc7+ztVtecx/9DyoDULBjd34TV+ZrdZDQodYgEBhMLZP
	 3dJeagp78YyXBwr2C2LJspjMFSVvvp96BDo5ijTZJuyciKZFtwOkGMXNYd6YbBCgUO
	 hFveAcfGei1Bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF63805DB1;
	Wed, 18 Dec 2024 13:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove bouncing hippi list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173452683126.1605224.5098552969181183573.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 13:00:31 +0000
References: <20241216165605.63700-1-linux@treblig.org>
In-Reply-To: <20241216165605.63700-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: jes@trained-monkey.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 16 Dec 2024 16:56:05 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> linux-hippi is bouncing with:
> 
>  <linux-hippi@sunsite.dk>:
>  Sorry, no mailbox here by that name. (#5.1.1)
> 
> [...]

Here is the summary with links:
  - [net-next] net: Remove bouncing hippi list
    https://git.kernel.org/netdev/net-next/c/c1bad69f8baf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



