Return-Path: <netdev+bounces-55646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5051280BCAB
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 20:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0939B20816
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282891BDDF;
	Sun, 10 Dec 2023 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL2apv8f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009111B267;
	Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78E99C433CA;
	Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702235424;
	bh=eQ0/407KP3HhnrTVlfGnfnwd1/ssbYotrJsWIdFbWhU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NL2apv8f160BY5bvo8LX+976+HJNoGlmwgKPzn4+GB2GwtUCa5L0Fg+XjIksXp+zy
	 iKlbAdsvpc8Ccw0SbYWcGt7BKUlu8iPgVBAu/NL47WptmhFN3wjqzW0OickVEzWUib
	 Mi8xckIizx++hO1BvZ2NHNd623vv9gXWBveTVf/KncV6zQplMkhFfQS+wqkmCHPZki
	 qvqe72evzaq1YfS4Bb0mL8McEvbFapBryCVeC1T+2OWhiy1LUVZlB7Q44pk7Xe2vNS
	 q6GOGxy5AZiuWwQ21SDlxt5BeypA6YZxA0IsXFfbQRsQ0nsJC3SPUA9PCctWJlzP8J
	 4THE2FO5yITBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EED9C595D2;
	Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] qlcnic: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170223542438.32670.7822552798580562858.git-patchwork-notify@kernel.org>
Date: Sun, 10 Dec 2023 19:10:24 +0000
References: <20231207-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v2-1-eb1a20a91b2a@google.com>
In-Reply-To: <20231207-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v2-1-eb1a20a91b2a@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 07 Dec 2023 21:42:22 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect fw_info->fw_file_name to be NUL-terminated based on its use
> within _request_firmware_prepare() wherein `name` refers to it:
> |       if (firmware_request_builtin_buf(firmware, name, dbuf, size)) {
> |               dev_dbg(device, "using built-in %s\n", name);
> |               return 0; /* assigned */
> |       }
> ... and with firmware_request_builtin() also via `name`:
> |       if (strcmp(name, b_fw->name) == 0) {
> 
> [...]

Here is the summary with links:
  - [v2] qlcnic: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/f8dd2412ba66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



