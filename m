Return-Path: <netdev+bounces-28796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77C780B7C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0959E2822EE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA8C182D8;
	Fri, 18 Aug 2023 12:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA76182CE
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D420EC433C8;
	Fri, 18 Aug 2023 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692360194;
	bh=bu1MVi82BPmDSIibUNjdlS56ovX7Eg24gQiaTb8MNGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYAy39Q6HEsRP02wSaJvQ7vZSs96nP09/6QVlf2+Njfv0ga6Ya9haZ+z7a3Slj5tv
	 0e/MX5yuFQzZ52xapMwUFxqO9uc4JRut7+UXlfhmH2Ee6JVLP9jwuku/vFCJKlPxi7
	 JKbT09UPf6c9CfQUnqDwoVipYuZIhLUbLIAVzwSGX7Y9CJTQ6b8VxwrhlH7i4IfllQ
	 mcgOT7T0FF2pgEUClMMs8Q/JL+C7ICqzf2R3/hIfaA6Db52TkP7SnDl4FiGpXvKxeb
	 9XDGF07RzKLZapkbQZS8MDrrq5OLL5j6sj4lB+yvCPsD0f+CzJY1/GtkgVKOXS5K7N
	 K8ZDma6jqhAcA==
Date: Fri, 18 Aug 2023 14:03:09 +0200
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: fix register
 definitions for MT7988
Message-ID: <ZN9d/RJ8qX4xbMml@vergenet.net>
References: <0c0547381d3dc2374e219c97645ab7e1fdfbc385.1692273294.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c0547381d3dc2374e219c97645ab7e1fdfbc385.1692273294.git.daniel@makrotopia.org>

On Thu, Aug 17, 2023 at 12:58:29PM +0100, Daniel Golle wrote:
> More register macros need to be adjusted for the 3rd GMAC on MT7988.
> Account for added bit in SYSCFG0_SGMII_MASK and adjust macros
> MTK_GDMA_MAC_ADRx to return correct registers for the 3rd GMAC.
> 
> Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Simon Horman <horms@kernel.org>


