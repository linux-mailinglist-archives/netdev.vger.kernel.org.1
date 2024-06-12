Return-Path: <netdev+bounces-102777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C62A904920
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 04:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC644B23240
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1568CB663;
	Wed, 12 Jun 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bujLiAns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181BEAC2;
	Wed, 12 Jun 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718160030; cv=none; b=aAKbEmV9Nwe4MTVReDBM7TSjHfyCp1cB204rQ4tgQ7jqHpYLdraVRoimQfK5pUyameqb0KYBQ8zbuGxNgJ0x45R6TZTzwLBcQfEIZesmHCIQ4yVoSAkvNDpaZYOm3puFF9tf5AQKFA/CRIaZp8oy8PdSm9fXbknDIhoLsCVTDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718160030; c=relaxed/simple;
	bh=aswzwmVE7WSzfqb1OHgJAxTYBO7HmwFUThA200YzYiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bi4VPIYuF4UsGwOcn3E70Et+JpaWt7Q46da2Zq4Y3fdIk0TB7u3gDzr/XS91oZsw9hVFzFWKZXUfNrfPjROh1utQBdD9FKXHmHRNvT2QlfCf8SfYxuBlqjAbuj28jFrHHRLq+JU7aeylxqKMEOlGzJiLcdFgfuzBXOdWm1xiG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bujLiAns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E2DFC4AF1C;
	Wed, 12 Jun 2024 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718160029;
	bh=aswzwmVE7WSzfqb1OHgJAxTYBO7HmwFUThA200YzYiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bujLiAnsNHQbYp/Nf7SKx14PMNpi9Kmf3IWzQC3SAX1SCXY7aGGZqr8egxjyp9cjE
	 dUFnhq8AyjZ1FVGUzFOCN/oxOG3/8v9HCPU1gr0ZVN1dYcxsOrqFHxiv0JHMSE6UTu
	 BOIV/tbBnY2TO+7/tztomTEwTI/yC/4Qj3nyn9dPrlFryyZTdlY5YVVliWHFgwJhHg
	 SddQ6p54k8GKTY0jSopdS2V+Ujn3Djjxsbe8hST/9PlmbGFklWeZAnXU+ArHH73204
	 35K/2k+Z8ZusB+cscwfsO0KJBS2kxkzXopnbiFqRlD8Zkufp2s9Lt9+0smfjEOHdQX
	 EjLhxHOImYXKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CBD1C43614;
	Wed, 12 Jun 2024 02:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: Use EOPNOTSUPP error code instead of
 ENOTSUPP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171816002937.1102.11231449667986655694.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 02:40:29 +0000
References: <20240610083426.740660-1-kory.maincent@bootlin.com>
In-Reply-To: <20240610083426.740660-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, o.rempel@pengutronix.de, bagasdotme@gmail.com,
 kuba@kernel.org, andrew@lunn.ch, lkp@intel.com, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jun 2024 10:34:26 +0200 you wrote:
> ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP as reported by
> checkpatch script.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: 18ff0bcda6d1 ("ethtool: add interface to interact with Ethernet Power Equipment")
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: Use EOPNOTSUPP error code instead of ENOTSUPP
    https://git.kernel.org/netdev/net/c/144ba8580bcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



