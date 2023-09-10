Return-Path: <netdev+bounces-32732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2905D799EB4
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422121C2084C
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3BA79C0;
	Sun, 10 Sep 2023 14:47:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F2257E
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 14:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCBAC433C7;
	Sun, 10 Sep 2023 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694357254;
	bh=NErVm+qMXZ/pqK2rnbYhPDdyFVVpqvEVZyCXf/EFVGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubxVCTCKav+V51WDKuTtO0EDuxSfsqy9sKFT5Af++H1Fh3Z9uIHtsZLcAFgogb2DW
	 kLN62joKoSscCalyAHAP1XhN7GoOyat3h480sycZQEab/1X+UtB3OMRPlouXDt99ZN
	 7MYBaeQpinURBCB7NUKIK7Wb3DjSxBSK+Sl0SxDkZUQeRxSJV3X9b17qZkqFP+xdn4
	 0KQrhvL8fzq6mcEPAGZCkT+dwy+F/FxAA2a3/FqpTQ1SU0P0JGO8gB7iXPKcJS0L6b
	 GYiMhnyyct6+GQ+oHPRMrxdM6YZ2kNDAtY4w6cPoFKpA2voqNJP7VcCSiBe8+Q0ISf
	 Fy3sv/BaB1Bug==
Date: Sun, 10 Sep 2023 16:47:28 +0200
From: Simon Horman <horms@kernel.org>
To: Hangyu Hua <hbh25y@gmail.com>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mw@semihalf.com, linux@armlinux.org.uk,
	nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	maxime.chevallier@bootlin.com, nelson.chang@mediatek.com,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/3] net: ethernet: mtk_eth_soc: fix possible NULL
 pointer dereference in mtk_hwlro_get_fdir_all()
Message-ID: <20230910144728.GF775887@kernel.org>
References: <20230908061950.20287-1-hbh25y@gmail.com>
 <20230908061950.20287-4-hbh25y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908061950.20287-4-hbh25y@gmail.com>

On Fri, Sep 08, 2023 at 02:19:50PM +0800, Hangyu Hua wrote:
> rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
> rule_cnt from user space. So rule_cnt needs to be check before using
> rule_locs to avoid NULL pointer dereference.
> 
> Fixes: 7aab747e5563 ("net: ethernet: mediatek: add ethtool functions to configure RX flows of HW LRO")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


