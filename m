Return-Path: <netdev+bounces-217533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F71B38FC7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF857B3B73
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0D61A0BD6;
	Thu, 28 Aug 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTrO9iDC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC318BC0C;
	Thu, 28 Aug 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341008; cv=none; b=TpzNajtXIawZDuwZqxjwCD6LSSHTOfuPp1hm9NORR3SS4aGSBTtcaF+UHZjhSh9TPBKS8N98uSP7b0v42uC2PpX+HNIJLtixc6g1OZtM+qHoy0YrTFCiUciOs07LoXUTzUoRYcqaBdVg3PB2tchVQdBKS3uTkwE7yRx0BlXAJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341008; c=relaxed/simple;
	bh=2YNvnxkE6opOiJzQKg9rDytLgUPiH/j/1tXwTT64WCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=raD4ViHiM4k0vfeYTXDPPweuUXcXbV4FOQ2d3ZWB84IYmPth5AWIk5TwFJHJDlFj0I5+pQAd3TSDkf4FbJT5o3LMheOWRo2GtUMYa3gP5sO9FkNYYEhINv59QFM1Gqcg8r1jc82r7ShSI3r/eZB6P5pD3a6qcWldG8Q2nEpY7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTrO9iDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDACFC4CEEB;
	Thu, 28 Aug 2025 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756341008;
	bh=2YNvnxkE6opOiJzQKg9rDytLgUPiH/j/1tXwTT64WCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FTrO9iDCpeSPtZT5P9WpfiTE2esTw2r6mDptqM4rsfrdc399xJxKGwDUc+R1dXoPx
	 1bvLD4Dy2U5LvDLzFHGMwhSgKNyKr51PDybpYWScNPIva3dRfzln9pU9xW5/6JDztP
	 dULhfEtElsgv5uWvjJ2/AtbyPgvhU3uNOX1EhhrbMzoaWS6fUSwBVsMW/w91Wi39cv
	 qtga0lWMLFadOllhyTJoqVtrJO23gjukSjxE8Mc5+BjRRhhBzuh9mLG32etppuzJb/
	 7dPGuzn3cxCP4epXEe3E409+aL4SqeIQTHjFo1jZdTBAdwD4/gJ8e9V/ghkINbyqRm
	 /eEVtoI3tJYlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F48383BF76;
	Thu, 28 Aug 2025 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] dt-bindings: nfc: ti,trf7970a: Restrict the
 ti,rx-gain-reduction-db values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634101500.886655.10640391041483861056.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 00:30:15 +0000
References: <20250826141736.712827-1-festevam@gmail.com>
In-Reply-To: <20250826141736.712827-1-festevam@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: krzk@kernel.org, mgreer@animalcreek.com, robh@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 conor.dooley@microchip.com, krzysztof.kozlowski@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Aug 2025 11:17:36 -0300 you wrote:
> Instead of stating the supported values for the ti,rx-gain-reduction-db
> property in free text format, add an enum entry that can help validating
> the devicetree files.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] dt-bindings: nfc: ti,trf7970a: Restrict the ti,rx-gain-reduction-db values
    https://git.kernel.org/netdev/net-next/c/40fb9751ccc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



