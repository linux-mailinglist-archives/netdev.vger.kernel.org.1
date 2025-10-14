Return-Path: <netdev+bounces-229370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 247CEBDB4A4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03F9A4E01C8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21128305946;
	Tue, 14 Oct 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq6/h5AF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10B3002B4;
	Tue, 14 Oct 2025 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474425; cv=none; b=a4c10WvTNNbS5G2z9D7k1TyJIA1eN8SBFIj+JUIXEru6IMp7DbxNztVFnnAuvaXe/sKlaAyPw0GyCvrGNj6Qim05f0lh2CGrXuunj0oqj7JFEy2PZ88ScYYcAP1yAqL5q5hmV9KsywdQbDhpbITbvlsdHaFaPikvRogM/efSU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474425; c=relaxed/simple;
	bh=UKfRwm5zN9BQFOob+EZxBBh2Mumuqk0YAR+spxConOs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LuGUycaj4TO56S45UClJhHD742jI6Q5O7dQuONe8jyRfhRhw3+21If3WPnrG8Pg0q9056HSuVJVyHibsd1WaPD511ExPmoNyW7ZWWwp51OWvJYZccbvupG10zbE+TQrjeu8r2OnpxRDL9ZRuzDr7JU5/wqJ1I2NfblRNc8C8HF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq6/h5AF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EB7C4CEE7;
	Tue, 14 Oct 2025 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760474424;
	bh=UKfRwm5zN9BQFOob+EZxBBh2Mumuqk0YAR+spxConOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jq6/h5AF0Oe+cFeQTc8+ML2O1ypOpSpr54SGYlBwbNot81cqzlrOw/bwP3Nn4yFGY
	 TpGGF8GGkQ9X5R+bxM+EZx/AM5HEERMfpWzeMhF8jWb+4slbnQ1tKHapJ2XvEwxqxV
	 yyih4gpTy0DJVatTGuDzjMFcsJXhTBMi0IlMhGw7ZcVpoqn1aPb6wQ5tir8qnh0BXD
	 w3uvc30cWdxeTcciPHHdTwi3OM7xirJRwg/PM9n6uCvpULcHq5jMW8H4erxv45Wukz
	 FIiDbHqIXa444XfnBa/jNIzq1NbfDc8HeWCjJ+RgIS5eJA9QiIhaDQzaHu29aUOwtG
	 dNc/hiJ7pt7gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4B380AAF2;
	Tue, 14 Oct 2025 20:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bridge: correct debug message function name
 in
 br_fill_ifinfo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176047440999.88862.1720664057067545918.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 20:40:09 +0000
References: <20251013100121.755899-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251013100121.755899-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: idosch@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 03:01:16 -0700 you wrote:
> The debug message in br_fill_ifinfo() incorrectly refers to br_fill_info
> instead of the actual function name. Update it for clarity in debugging
> output.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  net/bridge/br_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: bridge: correct debug message function name in br_fill_ifinfo
    https://git.kernel.org/netdev/net-next/c/0513a3f97b96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



