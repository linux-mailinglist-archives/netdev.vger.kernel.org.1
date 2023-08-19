Return-Path: <netdev+bounces-29054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8F7817B9
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 08:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FC91C2099F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 06:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76DED0;
	Sat, 19 Aug 2023 06:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E631B362
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 06:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F12FC433C7;
	Sat, 19 Aug 2023 06:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692428256;
	bh=NJ+AzEErbCS9Uj2GmaQZ/wrbE6c9H2qORM9U8sYbwSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INaR/I8iU3IbGQDU94rliksjxWziuXDqnC9Jnq5nAMRg1AaDpg86WgrTbTnMdlfTN
	 TkGM56cqN9GQMUQgSmGgf7h/vVLstHdEyikRSYJ8naChN54OhtsrygQwSkz6/49hHO
	 KPObH40gdfoktYdrq1yTgFW36X++c2EnTWqG8O79H4o5Ev5AWuutX7sicPYxiUSzrV
	 X+imAjAz59fiAkfXZHesbyV7gWPEamh/dT0tnJl6+k1k7ne8yBZ85Qkp7hGI8W5DFc
	 uNYyFpzS5jMB4bov+DqKA5bXrQ/4dceSiKG/yTPgZMnBQaU+bHnDP99qy1dwei1lcD
	 AoRHrc5Gyoaig==
Date: Sat, 19 Aug 2023 08:57:31 +0200
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next 1/1] net: stmmac: Check more MAC HW features for
 XGMAC Core 3.20
Message-ID: <ZOBn22NT/GYbZKxY@vergenet.net>
References: <20230818094832.179420-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818094832.179420-1-0x1207@gmail.com>

On Fri, Aug 18, 2023 at 05:48:32PM +0800, Furong Xu wrote:
> 1. XGMAC core does not have hash_filter definition, it uses
> vlhash(VLAN Hash Filtering) instead, skip hash_filter when XGMAC.
> 2. Show exact size of Hash Table instead of raw register value.
> 3. Show full description of safety features defined by Synopsys Databook.
> 4. When safety feature is configured with no parity, or ECC only,
> keep FSM Parity Checking disabled.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Hi Furong Xu,

thanks for your patch.

Unfortunately it does not apply cleanly to net-next,
which means that it isn't run through the upstream  CI and
creates a process issue for the maintainers.

Please consider rebasing on net-next and reposting.

-- 
pw-bot: changes-requested


