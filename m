Return-Path: <netdev+bounces-202071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B796DAEC2A9
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3311C61958
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F025A28F53F;
	Fri, 27 Jun 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCBuaOAj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0828DB46
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751063981; cv=none; b=hv593k7w3WTtG6Im7D1O9hOiJ3i97Xjd/NMES/2JUFJh8Qe/qqh5q1bmwAZZRHaisgccNzPLfWAwwD75Bfz8U2NlZGGqJA2koG4eoQA1PwZo2F532Ikt/SvheCfGgoCxtKkp3CtLPYD6iO/9Nl3fjKO8e4iBOGTRpbmzQ4nGlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751063981; c=relaxed/simple;
	bh=9V7KsmYdKPrpn0MuS9uYq424TeaDUaEqdhIofFWlXnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f4tcuTI7LPXUlRliodmjh16HT/O7fdgd64NtWS4gwdYr/fI1/YqaOk2K3c7rXXsbO3HH2ppK+9d0U8PuU3Nxc9WBflVRCaEZKtRJYsMWsgnwVl7iAhEtU72mFbkCjMmT+/ilAyF9J2z9mPI0ZLJZgSf174c0qiHXPB4VcRyC/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCBuaOAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FD4C4CEE3;
	Fri, 27 Jun 2025 22:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751063981;
	bh=9V7KsmYdKPrpn0MuS9uYq424TeaDUaEqdhIofFWlXnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UCBuaOAjf1Xk02ejRqFFHV5CFpg8MLjwcxMrpXJy4RZB8eMyunG5E+LWAtp6Z5usT
	 dev0cpnwuCAssssnCKaW9j4M3inG2VqKlDXg7RaYf4kchj8Zxv4Rhe5lw4n30RlB7Z
	 mq5HOk8wWhtQ3GdXYWMNnAjUpTMVbPoWaFux2Fl1H7nqxny1nkHMFvB2pB1FFKtpqj
	 qNSNi1AgHNzDAolOxDbEwr9acbtlSOeT81wgQHoUKhMNY96UHnq4AwM6OqtOCjXAMF
	 6OzHpOfVQ2H37XXUPpDYTTWA4dt3TEqF3MO8Wrhp+C3fizO8cBx9NZ93xKEz7SKELr
	 57KyI0Crx5Xsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EBF38111CE;
	Fri, 27 Jun 2025 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] doc: tls: socket needs to be established to enable ulp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106400726.2079310.8522757403000568031.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 22:40:07 +0000
References: <20250626145618.15464-1-ulrich.weber@gmail.com>
In-Reply-To: <20250626145618.15464-1-ulrich.weber@gmail.com>
To: Ulrich Weber <ulrich.weber@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 16:56:18 +0200 you wrote:
> To enable TLS ulp socket needs to be in established state.
> This was added in d91c3e17f75f218022140dee18cf515292184a8f
> 
> Signed-off-by: Ulrich Weber <ulrich.weber@gmail.com>
> ---
>  Documentation/networking/tls.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - doc: tls: socket needs to be established to enable ulp
    https://git.kernel.org/netdev/net/c/ba2f83eecd2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



