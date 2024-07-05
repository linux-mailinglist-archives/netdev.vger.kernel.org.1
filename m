Return-Path: <netdev+bounces-109340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3574928051
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002D21C2374B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24388171BB;
	Fri,  5 Jul 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va8zm7vo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26014AB2;
	Fri,  5 Jul 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146031; cv=none; b=l3C0i7DOPYiUJu4wi8ZcSB5EoFApS8H/OR/MZlTzXpAJAtlPvtrpoGFnLBA/ARZ/mg5eQafccDorZilQUA4Wzqxg782eetD6lSPwrmE6qSjGhTHTuJBKqitEYPsLlOMm1NnedkRj2c4Eli/8t8RKEamdYSSF5Pi2Omptxjbzx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146031; c=relaxed/simple;
	bh=QWd9ons4AXRKjTGh2DaZWE33fQe8DJP7zwUjzNaLr7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oc1+QiTMq0zGrVBqFUwzjg0IxlihyNcH3tFbNAJAjy87ZfRcGtDwJ9HR/TdEoQh4vOV7ReCBfWcF9KhC5ApaEHHi+JRB6FeuSuktX/MpLTfniLsNxYJNsBrYZvpLq0m3Gir/2IYE3dU4UkfSm4SlIc1QIpMZH1fBVXNUTSwUiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va8zm7vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C284C32781;
	Fri,  5 Jul 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720146030;
	bh=QWd9ons4AXRKjTGh2DaZWE33fQe8DJP7zwUjzNaLr7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Va8zm7voHc4ONfHmF7lhOXFaqvIdKiUSEB+drBOoEnFzCRRph0FHqsgubj4LP0sgI
	 P1i7QY+9DUhT/mWvupdu1eQO3UJ6JUGuDPgQQ7GT0b4AlzEhMyCfNQzUoI8LWkeRpg
	 8LChJBQ9lh5M6RCFh2xFuG5fu0WpJnKxGRs+ljNBGyyHXkc7qADRruYpWLOLFQFKQ6
	 a9T2tdIlLvDIw0P1OGHZkR4BFQurlRWRMxNRNF4f/XhiknjLn7V1LBVDUFoYP69eA0
	 FH1uWwMTQIgP3qgJn7Nt2Kg8fe821ZgyYl1S1C3cx7mEXDRm/9yZ2xNbwu5Yogl/AJ
	 L1nD+3tmh78SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68C6DC43446;
	Fri,  5 Jul 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: Define properties at top-level
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172014603042.16848.6916818330068048606.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jul 2024 02:20:30 +0000
References: <20240703195827.1670594-2-robh@kernel.org>
In-Reply-To: <20240703195827.1670594-2-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: fancer.lancer@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 lorenzo@kernel.org, nbd@nbd.name, alexandre.torgue@foss.st.com,
 peppe.cavallaro@st.com, joabreu@synopsys.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jul 2024 13:58:27 -0600 you wrote:
> Convention is DT schemas should define all properties at the top-level
> and not inside of if/then schemas. That minimizes the if/then schemas
> and is more future proof.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>  - Drop the parts already applied from Serge
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: Define properties at top-level
    https://git.kernel.org/netdev/net-next/c/390b14b5e9f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



