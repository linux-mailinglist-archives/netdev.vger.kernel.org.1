Return-Path: <netdev+bounces-38139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE3C7B98B6
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 1ACF3B208CB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A583F30F89;
	Wed,  4 Oct 2023 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY0hNbwS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA5266A0
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 23:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A06C433C7;
	Wed,  4 Oct 2023 23:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696462375;
	bh=0n38R5SC8S/5l5Ik34Obsa7hdR5k+fdYnhAGPoGD3SM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EY0hNbwSshrQ0wJhWIxXGp4Zx3fXINLWpxdr260Nspolc1OZoibzu1nz55tbPdcYU
	 M9ct9tVmzf7Hbjf/vBSABY2gEWbabUp3EETl4sTvorpbvWVIyKeHZ0ZRS2NmYKtENm
	 OaJS+3q345AUphxpUX93tAZ4LC+GaGdABxBWmg9h3rSJorMXSCvOi7F3kstS0sUQl/
	 tVc4b/TJXv8zDrpMMlr2yIRw41lYcHJVip3cAZN93Ou4OS8IR3o9gG0UKuS/7vNPNK
	 71/lj3U64E5ew6e9CDFX68Gm+g5Ugh1l0gFQKwBLumQkGOEwPbcymiVuWcsHib7TFT
	 SuwBUA1pyyNdg==
Date: Wed, 4 Oct 2023 16:32:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Morley <morleyd.kernel@gmail.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, David Morley <morleyd@google.com>
Subject: Re: [PATCH net-next v2 0/2] tcp: save flowlabel and use for
 receiver repathing
Message-ID: <20231004163253.75584412@kernel.org>
In-Reply-To: <20230929210352.3411495-1-morleyd.kernel@gmail.com>
References: <20230929210352.3411495-1-morleyd.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 21:03:50 +0000 David Morley wrote:
> This patch series stores the last received ipv6 flowlabel. This last
> received flowlabel is then used to help decide whether a packet is
> likely an RTO retransmit or the result of a TLP. This new information
> is used to better inform the flowlabel change decision for data
> receivers.

Minor conflict with Eric's changes to derive delack_max from rto_min.
This no longer builds, please rebase & resend, thanks!
-- 
pw-bot: cr

