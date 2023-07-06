Return-Path: <netdev+bounces-15835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A34674A168
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 17:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5693928136D
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF03AD30;
	Thu,  6 Jul 2023 15:48:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42F9453
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 15:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C17C433C7;
	Thu,  6 Jul 2023 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688658521;
	bh=ASn250ABHz65GgKATAAVAm7VbjKnew/NYaiW0XJGgR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fdwpRLyaAoUXbPtt2cwMuBx0Fk4XYI+3C0Pdrdp/56s3hcGHyP6jKvY+RSKTo/gvx
	 lMMAXKaWnw8qF8TCXTS98T7eQEKbcJ/OfLmtcTKmYpNnatg0vH+MTXNJ0YQ2GhGUBF
	 suLU5pdR2CIEvHgqdb2UPeA+P7SKHcWNGDYSHn3+JQg+ux700ldwyN8E2+tAKnMpSx
	 LFz0MP4cAkAesct/r8y1a7JLnNq2q3G5pD39GEIVYeRohPYjCw/sa631tuHXmvDjR8
	 sAqMqEhmyx9niLRjbtPW1XIH0mXecJ/FSZklgBoS3bWtD9KezsRX6mnSsU6ClBq9zX
	 DZKYPJwXs9LEw==
Date: Thu, 6 Jul 2023 08:48:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Michal Simek
 <michal.simek@amd.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] net: emaclite: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230706084840.223b5926@kernel.org>
In-Reply-To: <20230706120850.11026-1-frank.li@vivo.com>
References: <20230706120850.11026-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jul 2023 20:08:47 +0800 Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


