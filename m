Return-Path: <netdev+bounces-28925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC16F7812F0
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF67C1C216AE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9518C2E;
	Fri, 18 Aug 2023 18:36:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D42CA7
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A360AC433C7;
	Fri, 18 Aug 2023 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692383807;
	bh=3oWiS4sVJeb4//lAqOui7eKJtdtrVdyXAt1lq0C8smU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ct+KaK/KK1RNR6YdtIkf1+T2As47s8ewfGXEMjR6vWOMsSxo+N72tExX2BTJn1dE8
	 SOWN0G1LUkalkll/qD8mdNQ+3a2nRSoE/aGTyNR+7VcvbD3yzLLB7tSVvw+a2rlCy/
	 yi6UpBpVesWeBoZgaBtW3qkYfWrSuj3A/BOkkkbv/+kgB2R6csIvDheRhrVWQisxUh
	 cl5djJv8A3E0gnjS61fC+gmX033OSNqEaoJi/9i+CekFpgWLebyfDPa58DUSQAzL4x
	 fBPImYBVUI16/NPi32bxVUR/LOuipOEnccJXseUP9o3WY+g/aST+lgGob9CZx4vKIh
	 zew68f+QMVM6w==
Date: Fri, 18 Aug 2023 21:36:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Dima Chumak <dchumak@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 0/8] devlink: Add port function attributes
Message-ID: <20230818183640.GA22185@unreal>
References: <cover.1692262560.git.leonro@nvidia.com>
 <20230817200725.20589529@kernel.org>
 <20230818041959.GX22185@unreal>
 <20230818093812.7ede8fbc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093812.7ede8fbc@kernel.org>

On Fri, Aug 18, 2023 at 09:38:12AM -0700, Jakub Kicinski wrote:
> On Fri, 18 Aug 2023 07:19:59 +0300 Leon Romanovsky wrote:
> > It is very strange to expect 1 series per vendor/driver without taking
> > into account the size of that driver and the amount of upstream work
> > involvement from that vendor.
> 
> According to the "reviewer rotation" nVidia is supposed to be reviewing
> this week. Sorry it fell on you in particular, but as a company y'all
> definitely are not pulling your weight.

I can't speak for my company and for my colleagues who are OOO during
these days because of summer break, but only for me.

I'm trying my best to review and reduce maintainers burden. Should I stop?

> Then Saeed pings me to pull your RDMA stuff faster

Saeed explained to you why he needs it faster - merge conflict.

> and you have to audacity to call the basic rules we had for a very long
> time "very strange".

This rule relies on basic contract of 1 series -> fast review/acceptance.
Once fast review/acceptance doesn't happen, what else do you expect from me?

Thanks

> 
> SMH

