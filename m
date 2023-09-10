Return-Path: <netdev+bounces-32731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71348799EB2
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 16:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB92281163
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99410749C;
	Sun, 10 Sep 2023 14:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF52586
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 14:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD05DC433C7;
	Sun, 10 Sep 2023 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694357188;
	bh=VZHoP5kYcYyfcXZ35ny5LQtB1CmlcEONkuJdZApsAq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vu/5QLhIOYnS8xqIO7rbRBslzmsH30XEnbqEkTiQvcceTcRlz4YiFQavVfR247kjR
	 JpAYHKtSPEy+SiS15N2JUV80YG7S2wPKeiziU4XQl1eM+2WOdprtjPGqeTF9KxFaMV
	 07Zws+msdzu1Gdo/tcPT7keO+G5ozcsvyYKeikRGzdS0X0hsr+A5kv/Wf50j4e+S/p
	 zWXV2UEEmipgqyypJJyvlxDvZKSH2cT6UYRD/XryirZt4tqpvkMXBlYDYQTxJDtZEu
	 S+JOWjbguxbMJM9CrCh1SwuVGYG7vHkT0SApkJWybXTipOiMT6DxJ+8RO6wJEBpLia
	 998bfF+BySEQQ==
Date: Sun, 10 Sep 2023 16:46:22 +0200
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
Subject: Re: [PATCH v2 1/3] net: ethernet: bcmasp: fix possible OOB write in
 bcmasp_netfilt_get_all_active()
Message-ID: <20230910144622.GE775887@kernel.org>
References: <20230908061950.20287-1-hbh25y@gmail.com>
 <20230908061950.20287-2-hbh25y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908061950.20287-2-hbh25y@gmail.com>

On Fri, Sep 08, 2023 at 02:19:48PM +0800, Hangyu Hua wrote:
> rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
> rule_cnt from user space. So rule_cnt needs to be check before using
> rule_locs to avoid OOB writing or NULL pointer dereference.
> 
> Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


