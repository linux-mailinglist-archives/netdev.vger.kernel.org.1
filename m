Return-Path: <netdev+bounces-139566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D89B31B9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 14:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA776B2207E
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7F51DB95F;
	Mon, 28 Oct 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmB9J0wa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC41D9341;
	Mon, 28 Oct 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122229; cv=none; b=hAv7k1bUg0T/saa+1C3PQUpr82VsuCgtUYvQp9pPHd/yP7WH7vDF3/yYH1MTuO4wAB21vKHv+4OF+hOJx+2ct9ns5kT3R0/OWeuZBJ43Tk+t1AfbXy00//iMPzdmAIN0hUdxmkGojP3Quak33kCX6jF2xVEV4bjkwPjXIs2cwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122229; c=relaxed/simple;
	bh=8Eb60TtfjMAOXqjYLNlGTme3lFmjIkbTXHuDxEBrYv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d02zBFIxOBqUKK4GtbmwPOdXfl9GG4iSVs6gthe1O4O/Eqck02vXIuHaE92GnL1oEv7Yc1F9tHrn1Z3MpY95Zwgi8E3/i6oE0fCXMRlPDcwGOTtcM5DnODpAl4tiNNSv7jqvZ3PHS9lxGUzIDIErTjUsrP07DVwuGVaLc1+Odis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmB9J0wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F3EC4CEC3;
	Mon, 28 Oct 2024 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730122227;
	bh=8Eb60TtfjMAOXqjYLNlGTme3lFmjIkbTXHuDxEBrYv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QmB9J0waT/JXN1azG+woHMsK714VxQ2vTwK5QnLLlrk1oBlHASa3d/G37Vc8mWXUR
	 z+MEdy3vc/vAtL0SuW5rHw9Yw3q0CMgeZImvEjXTbalIA6vXRXZWj/NjSCNlT/cKmf
	 AjdRGUcIXxlK3Tz8vXmHImV6KKTRJh0zWLR0nlSjg1ayfu6xMsFvof1Yqshf6Zyw5P
	 4jO20pe9e/uBiGjmOv63yucFhEskLKjO5jIqUhwNtBD6UHe6CUDuXNPHRgrtSDyRnj
	 2HQPwr7rmB+hHjQnmYYQD01QM2EJX8bD3IEzoYgOtaXVEeTmgg5tgs23keU+20Bjs2
	 yO3fo4jcN4GUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F51380AC1C;
	Mon, 28 Oct 2024 13:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: fix unreleased fwnode_handle
 in setup_port()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173012223502.52850.4413295844363790152.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 13:30:35 +0000
References: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>
In-Reply-To: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linus.walleij@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 19 Oct 2024 22:16:49 +0200 you wrote:
> 'ports_fwnode' is initialized via device_get_named_child_node(), which
> requires a call to fwnode_handle_put() when the variable is no longer
> required to avoid leaking memory.
> 
> Add the missing fwnode_handle_put() after 'ports_fwnode' has been used
> and is no longer required.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mv88e6xxx: fix unreleased fwnode_handle in setup_port()
    https://git.kernel.org/netdev/net-next/c/b8ee7a11c754

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



