Return-Path: <netdev+bounces-25544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BB47749A8
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC60F1C20E8F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDEA168C6;
	Tue,  8 Aug 2023 19:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F18F69
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D7FC433C8;
	Tue,  8 Aug 2023 19:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691524755;
	bh=vaL2GmK6E30etgPK/7amdzCna9Tu7rMpzE4Hc5iSZ1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eP3OhvsFV740uKM4wAelsA49oWXmvK9xYJHKORXwcTkDrSeQp+Xdqc/mvhWuQMbZg
	 pu3WzPRtCxrVoaon4argOZWH/7Gf3fPWD7R1e9/pGriWEboaYGN7O87Hoc1zt5Gp42
	 AawQxcbbq9OdbOM/KhVTxNnezvS1Yvj4jDQG5pHdiukdD6ciNEfVwRLAz0TtC/Eh+L
	 6aChhUkEzYBezywSBFJikE0og6LXAYWNCZm/4DOCxbbLK8ZblLQcJHp7FNYjIJb1EB
	 Ijsei8Gve7vDojv3odcpuWgr1J7hDyOWCJranWmKVDFGKtyoh1f8SmhsAXFWptXGt1
	 vxn8Hd0urihmA==
Date: Tue, 8 Aug 2023 21:59:10 +0200
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: xgmac: RX queue routing
 configuration
Message-ID: <ZNKejh2ukx7Fwo66@vergenet.net>
References: <20230808021906.1120889-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808021906.1120889-1-0x1207@gmail.com>

On Tue, Aug 08, 2023 at 10:19:06AM +0800, Furong Xu wrote:
> Commit abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
> introduced RX queue routing to DWMAC4 core.
> This patch extend the support to XGMAC2 core.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v2:
>   - Convert the shift ops to FIELD_PREP

Thanks!

FWIIW, I think if the code moved to using FIELD_PREP then
probably the _SHIFT defined can be cropped.

Reviewed-by: Simon Horman <horms@kernel.org>

