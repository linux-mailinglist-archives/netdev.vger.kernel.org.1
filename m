Return-Path: <netdev+bounces-50898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1EA7F77D5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A101C21070
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E82F506;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdM6yK/U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB32EB0A
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 513F8C433B6;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700839826;
	bh=L/opXA63SCD9o5GQQ+yU2Zjp5Hqs4S6i138ukAADmE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cdM6yK/UbvCnm/BKrrF8iEzAY9Rb380JTyIWvQTmN+cUpqwPYZPbUsOwNkTintTHg
	 tferUkPitnpjcoWfDc2VHZSSFaJxcD2yc4OcE6nSAQ6mutkaieSgOIkBA+uWwRKGfH
	 ooi3DEN+V1BZVaWYWFoYMsVzBGG5mghyvEqkXLGMI4+ndS+c9XXC1TmjTpTr5JU64M
	 IoYBjxbRL8ztieMZG0sQbRJxLEKiLip5jdULfIGWWh68iPWLr9YdtjiGC+JI7kXmbX
	 ZNTQfCqQ0WiFcDTxQk02jPDfF/TK0HL0L0T+I5i7x2E53G11IyHyO4AjGgm7IsbDPf
	 y+V3MCEPfyKOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BA74E2A029;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-get: use family c-name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170083982624.9628.16715002463945430535.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 15:30:26 +0000
References: <20231123030844.1613340-1-kuba@kernel.org>
In-Reply-To: <20231123030844.1613340-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 19:08:44 -0800 you wrote:
> If a new family is ever added with a dash in the name
> the C codegen will break. Make sure we use the "safe"
> form of the name consistently.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/ynl-gen-c.py | 46 +++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Here is the summary with links:
  - [net-next] tools: ynl-get: use family c-name
    https://git.kernel.org/netdev/net-next/c/19ed9b3d7a77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



