Return-Path: <netdev+bounces-50640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AEF7F6644
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A5B1C20C02
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3C735EE6;
	Thu, 23 Nov 2023 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd9rpg2e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611574C3CA
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 18:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8E1C433C7;
	Thu, 23 Nov 2023 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700764398;
	bh=wf+ar37SNyZQGbz8ggIzfl6+ESKvq2AX3271FYm2brQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fd9rpg2eZ3ZoTyeEWt2gHXBXquJN9xUv0wK+tgFygP5idyb9erUYQBn8lmQtAz8Ty
	 7mF+BlWIJW2ZdOQdkZiSJknAY6M3Vv+BNPhYIO4rhFyBHFRNZkDUYOfZC0gqiLf0Vy
	 cUS7164//U09aSWjLi89ymQcrVSvDcLPzkiij6NGHrDhOw6YMTRFBOmEnHOer7Izsy
	 W+dAB++Br2vQfiEzXxMK5TrY0d8r0mU5JmA+kbLNvlbHPDwYvcssPzSwzKoLsam5Wy
	 /9G3tKGRYKP44Pw86+ejOKKotFCDhJMwDQ3jsAbe3JDxCucZEmD9ZrC5aNSL0ieGrp
	 PjgRNqiN8FIuw==
Date: Thu, 23 Nov 2023 20:33:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [net 09/15] net/mlx5e: Forbid devlink reload if IPSec rules are
 offloaded
Message-ID: <20231123183314.GE4760@unreal>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
 <ZV3GSeNC0Pe3ubhB@nanopsycho>
 <20231122093546.GA4760@unreal>
 <ZV3O7dwQMLlNFZp3@nanopsycho>
 <20231122112832.GB4760@unreal>
 <20231122195332.1eb22597@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122195332.1eb22597@kernel.org>

On Wed, Nov 22, 2023 at 07:53:32PM -0800, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 13:28:32 +0200 Leon Romanovsky wrote:
> > Unfortunately not, we (mlx5) were forced by employer of one of
> > the netdev maintainers to keep uplink netdev in devlink reload
> > while we are in eswitch.
> 
> The way you phrased this makes it sound like employers of netdev
> maintainers get to exert power over this community.
> 
> This is an unacceptable insinuation.

It will be much beneficial if you stop to seek extra level of meanings
in our conversations. There are differences in our ability to express
and feel intent in English language.

> 
> DEVLINK_RELOAD_LIMIT_NO_RESET should not cause link loss, sure.
> Even if Meta required that you implemented that (which it does
> not, AFAIK) - it's just an upstream API.

Excellent.

