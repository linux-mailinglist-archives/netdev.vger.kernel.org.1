Return-Path: <netdev+bounces-233374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D46BC128CE
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D531A65AD5
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ACA239E75;
	Tue, 28 Oct 2025 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnr26WG3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D3185E4A;
	Tue, 28 Oct 2025 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615030; cv=none; b=kWDQMLNjfhZ6TDDrC2RjhupI/H/kXW6O6lV+D1jTSbYG0ZsBhKA++vJ0hY7/hoTo/43l9LD9WK9vCsPvri6C/oA2UEezjLkg7aXOHzgaiQ7gKR4D45hcs8syt+NGrvt//4xDaJwKVLukGbU1OPypi23Zm/wrxqAq/QvALbU/t6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615030; c=relaxed/simple;
	bh=Bm2irc7gXUY0CPdzzsQ3acckBICJU4QlM8eFUNd3X5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZrTL/VyvKz2/EEuKu91U5oGeS7uQnzmvop4SKJrhqYspIwqoDVYKTJ6QRINgunOZCrfcHb11jdmPEU75EovBhwV4e2wCmasjZpGMrg/TgfFGtdsqIZFIVgwYz4xkzoZ0Eq/mgE1kzfmdjn4+oRciWISO2YTu1GfBdfWB310rqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnr26WG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E557C4CEF1;
	Tue, 28 Oct 2025 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761615030;
	bh=Bm2irc7gXUY0CPdzzsQ3acckBICJU4QlM8eFUNd3X5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hnr26WG3OLnFInlblb0f266rA6wtxVdNFWKC/epftIgZJ7fXAroehIm+TrueFE5IM
	 daxlCSD8Z8HuN9z/PFR9JGDRwnPt5CAZmGEKyfMIdPXmGMt8V3DoME7GnOOUYzPAhE
	 bfYXIsykI1KMN5VSL8qjV5FcTRyOZ/FUMV28JQFiiNdj+at8YB5aaOAyf7RIRLm4AX
	 iobP3RB9fzN/ZZKifiiU6T5DhB31l+EMAF26B0mrakbs57ZUl2dvvGQdPBRkP2X+xW
	 qZahuqyLgeiKIbbcwLiqTMynhl0my8EBErqLg3hicCuhDjgZBcndqydxadn853f1vi
	 FF7/G9uD2b5Vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7131E39D60B9;
	Tue, 28 Oct 2025 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] dt-bindings: net: sparx5: Narrow properly LAN969x
 register space windows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161500826.1653952.7154756553118848296.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:30:08 +0000
References: <20251026101741.20507-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20251026101741.20507-2-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 lars.povlsen@microchip.com, robert.marko@sartura.hr, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Oct 2025 11:17:42 +0100 you wrote:
> Commit 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register
> space windows") said that LAN969x has exactly two address spaces ("reg"
> property) but implemented it as 2 or more.  Narrow the constraint to
> properly express that only two items are allowed, which also matches
> Linux driver.
> 
> Fixes: 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register space windows")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] dt-bindings: net: sparx5: Narrow properly LAN969x register space windows
    https://git.kernel.org/netdev/net/c/210b35d6a7ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



