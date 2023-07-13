Return-Path: <netdev+bounces-17660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BE75294E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1667281E7D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2F71ED43;
	Thu, 13 Jul 2023 17:04:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBC18AF5
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 17:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D85C433C8;
	Thu, 13 Jul 2023 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689267842;
	bh=L/hiCcnT7c1qI3+L7nQcuycK9uSve3ePnEWo922QO9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l0nJBsgcPEGayeFtulD6OxTY6kMZkH9S6ClszKZ2JkxFaA73WPRZCTEkJYSmj968E
	 pZ+0PWH2Dn7d3MiU7HX6BoX0P0X0q3LyG0Pw0OcATjbTjNvxA0XYphjlKVY/EPYXXO
	 xkVlsK5UTDAFiPTU7IRjOe3ThRM9+G+2I9sYgXGCHhkF+ls8Cs2ZecmKcKvWq6R9VV
	 6AFBPKtrSLSU+7he9SX2/1ErkrGwTJRmRSY9tZoAhgRbqkSH4D2qXxaKxKz/MVXhvB
	 mTArvVISPXkCHrubzHKvJJDcgZGTw+Vm94Byzwb7hAcEP+csLA4ASPoYUakTNQfVLt
	 XDTp4SC0Z1NVw==
Date: Thu, 13 Jul 2023 10:04:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230713100401.5fe0fa77@kernel.org>
In-Reply-To: <20230713063345.GG41919@unreal>
References: <cover.1689064922.git.leonro@nvidia.com>
	<5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
	<20230712173259.4756fe08@kernel.org>
	<20230713063345.GG41919@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 09:33:45 +0300 Leon Romanovsky wrote:
> > This says Fixes, should I quickly toss it into net so it makes
> > tomorrow's PR?  
> 
> This is a fix, but it useful for this series only, which actually
> needs to modify flow steering rule destinations on the fly.
> 
> There is no other code in mlx5 which needs this fix.

Reads like "can't be triggered with current code", in which case 
the right thing to do is to add "can't be triggered with current
code" to the commit message, rather than the Fixes tag.

I had a look thru the series yesterday, and it looks good to me
(tho I'm no ipsec expert). Thanks for putting in the work!

Could you add some info about how the code in the series can be
exercised / example configurations? And please CC Simon, it'd be
great to get him / someone at Corigine to review.

And obviously Steffen, why did you not CC Steffen?! :o

