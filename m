Return-Path: <netdev+bounces-32022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F11579216E
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194A5281090
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5222463BD;
	Tue,  5 Sep 2023 09:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE41C02
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 09:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BA27C433C8;
	Tue,  5 Sep 2023 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693906044;
	bh=1+/QKQCw40/B9Vgp4fHtU4QBI3qEVS2B5TQz8nvHZg4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=usf78FlzXMQAqaxyM25embox5sqapOnWRl7lMxkvfVraF7gHZ/BBwga3FSs7fJxzW
	 C2Ud9rEwr0CZ7wwbIi+/fWbRP5jBcDprxp/JgNJRQVN13yk6MpDfFBqLbtC2VJxdgr
	 bwSrJvw3AV3lphFaDntKXXozZymPhde2jesLRPxSpHDxwyitqziNxFPl2BOfTGiCRX
	 433sEisTq2caNswTB/dRZJe77tJ0qmO3nGadk6j3Q6Dh0EvCicemwODiDC+BsOFH19
	 B+mTFNOyEntRWyiV9rKtfJ+djzAvPI/m1/EEBFiP2W5z8/diW7vZStqPt2hXiWGTF8
	 OYr2Ug+zVS91Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4973EC595C5;
	Tue,  5 Sep 2023 09:27:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "net: macsec: preserve ingress frame ordering"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169390604429.18381.3705126377327956116.git-patchwork-notify@kernel.org>
Date: Tue, 05 Sep 2023 09:27:24 +0000
References: <11c952469d114db6fb29242e1d9545e61f52f512.1693757159.git.sd@queasysnail.net>
In-Reply-To: <11c952469d114db6fb29242e1d9545e61f52f512.1693757159.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, scott@scottdial.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  4 Sep 2023 10:56:04 +0200 you wrote:
> This reverts commit ab046a5d4be4c90a3952a0eae75617b49c0cb01b.
> 
> It was trying to work around an issue at the crypto layer by excluding
> ASYNC implementations of gcm(aes), because a bug in the AESNI version
> caused reordering when some requests bypassed the cryptd queue while
> older requests were still pending on the queue.
> 
> [...]

Here is the summary with links:
  - [net] Revert "net: macsec: preserve ingress frame ordering"
    https://git.kernel.org/netdev/net/c/d3287e4038ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



