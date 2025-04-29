Return-Path: <netdev+bounces-186878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5CFAA3B61
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1AF9A3CBB
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434B27817D;
	Tue, 29 Apr 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ci2+xyUz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895827780A;
	Tue, 29 Apr 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965203; cv=none; b=rZEDCp+OLx/6wM7oNc6CD4ePMG8GnDfccJDmzL4ghxBJ2bGBAPkCdBVogTfDCHsFTzpRA0bkKSkfHMeo2wWliL5lH1h6etuiklixNZpt0ixtkdEbBjyP73CJx8PO1PmmeMNUDbFob3jnZCOJ1iEUhiFMfonjpn1cnJhTKzHZsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965203; c=relaxed/simple;
	bh=UARy4YweGvAs4OKgaT5MnQWEZWB5cyIY2AU7IflVyY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Un866xM5ZfUV0Z2hx2BGwEX2M20Vhm3WqkLetD9nj0v3RH8P/BSY0ALehUcThFQzJvryilgbKKu0ESxyvZIafVrvDDPc31JUQ/CWcxayx9K6EL1X1Wy+li/tO4svRZCcaNIS/SX6awjcilVga+HQVOFJAYqI/NJTn+w1ehIkhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ci2+xyUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E671C4CEEA;
	Tue, 29 Apr 2025 22:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745965203;
	bh=UARy4YweGvAs4OKgaT5MnQWEZWB5cyIY2AU7IflVyY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ci2+xyUzb1LV0vwB2eR/MqtxECRBLwkVNlsaPNOam6KrsLAesIOfrormD1mzVIVPG
	 DQrwpzQGR2rOShmJW00Ag70yw53Uksl4NWV/b0MCQQuwuce7UTErFtcgTYp4t+uwCW
	 j7aw8gqo66LWFsFWN38PofSKfTA08w8Bt9zccejYN4OFbbJ3RUXxOJF2SwCI+M4q32
	 6E7EU0+3HB4Ydm6y0uzs3KJ2WuL/gcM0JsBvfhRu712fRS/tt+HY9Oe2FWqItQkis2
	 6D0J9g6nwtw9uSlhk08dCYJcMq71gwlc3lxk+bV/lqg+WmUUvWjwxgWbg1WIHl5m6b
	 TqnHkXbEJrgSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEEE3822D4E;
	Tue, 29 Apr 2025 22:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: fix typo in info string
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174596524224.1813341.12376820674091397543.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 22:20:42 +0000
References: <20250428215541.6029-1-rubenru09@aol.com>
In-Reply-To: <20250428215541.6029-1-rubenru09@aol.com>
To: Ruben Wauters <rubenru09@aol.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Apr 2025 22:51:09 +0100 you wrote:
> replaces formmated with formatted
> also corrects grammar by replacing a with an, and capitalises RST
> 
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> ---
>  tools/net/ynl/pyynl/ynl_gen_rst.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] tools: ynl: fix typo in info string
    https://git.kernel.org/netdev/net-next/c/8e36fcaa494d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



