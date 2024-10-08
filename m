Return-Path: <netdev+bounces-133188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92DF99543E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A31C24910
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF54E1DE89A;
	Tue,  8 Oct 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg3L2qFp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB510339A1
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404425; cv=none; b=MujPce+i6v2RsTJYN7jsboRxNuND+E6T89Y7psWhp4VeR91lHt5A93rpSq3wpGXTCYJKvmu7/yQVaWGqfPf0yBvR3M+ItfbZMZe6SrC9wL12lxPc1e73NTGNf6Bwt85A4zIiU8/m9nlLxIIElsMvbCpScR+7RrzWH9q7LORW8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404425; c=relaxed/simple;
	bh=B04CwJfnrti7+q4QoQd/sDqBKGP+dWRxmN8X1dZ/hsU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jcxiXpAvUVQbA2yVH9UPEX5eUhftqvm3jvZyvMVGEmY69bhsptLVDhtWv5dqK9fWEend3E606GiZsmMUZsHid1BdcbzyPsKDuoa4kvzbDSePjH9wYmlwv/wr0NjA8dPLX36mHTaBeyW/1706FSl7vZXUYKMxxuFu+QsUzYeDZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mg3L2qFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECC9C4CECE;
	Tue,  8 Oct 2024 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728404425;
	bh=B04CwJfnrti7+q4QoQd/sDqBKGP+dWRxmN8X1dZ/hsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mg3L2qFpBHsEMDISJ5uDaHNpZkyQLljl/HiifhKlkdRntW2voNQ0zRHo7/GR8Q+Xy
	 lqcP7G8+d71717tCXiM07eAnHnuU6afETiO1/BIZxbmOZVAjInRjiJra67fpQUnTxm
	 ctJj9m14OCD3qx95FicyJ18P6gdxK0GT2V2Kn5VWWbx73f1JAJmjFMY3DPrSAG/tWk
	 rlNn8yV3YlJeM/ZksWtj/h1TcUSVuTayhUtbQ3LgW0lgHLjdy/A/cSbuzcdyU9K+V2
	 51nR1WVYd2NIWZqwCz2ANOGfCEa2P4F/4UHIIgxrcIGx2/QvTLrQGYz3spymTvPMjv
	 Y0z3KenBUyNRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5CE3810938;
	Tue,  8 Oct 2024 16:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] bridge: catch invalid stp state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172840442950.601483.15722241492485643058.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 16:20:29 +0000
References: <20241007163654.499827-1-stephen@networkplumber.org>
In-Reply-To: <20241007163654.499827-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  7 Oct 2024 09:35:43 -0700 you wrote:
> The stp state parsing was putting result in an __u8 which
> would mean that check for invalid string was never happening.
> 
> Caught by enabling -Wextra:
>     CC       mst.o
> mst.c: In function ‘mst_set’:
> mst.c:217:27: warning: comparison is always false due to limited range of data type [-Wtype-limits]
>   217 |                 if (state == -1) {
> 
> [...]

Here is the summary with links:
  - [iproute] bridge: catch invalid stp state
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f4b86f752d3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



