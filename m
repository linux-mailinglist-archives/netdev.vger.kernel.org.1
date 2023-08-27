Return-Path: <netdev+bounces-30928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1334C789FA5
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 15:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAD31C208CC
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D8101E7;
	Sun, 27 Aug 2023 13:53:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24479DB
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 13:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13B4C433C8;
	Sun, 27 Aug 2023 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693144426;
	bh=b1kK7Dz94GVdmWTD3uMOP5lr20LHYQ/HNK30s5G1xWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=J7iqqsoca1RQhX0MDlxFMt+CDy/1lz+AquUHzDkG8IjDA7/IUiQ+dLIRLojeSJLQn
	 ol+t6JDZCxG/qv2FmBSgvEFb63SnAfBzz0wkbBB8/xQbWAJOdM8AmlIAvkhaJY0DiB
	 wectLoOwvHfQv7+WW7JdtXe2359iT/u7akjCo5OuyokykABNFRZ7sTL5VvE7rkKbPx
	 W3G8onw2trcD1gIKfUlIRoEJBmnDSY9RmCdjjbhz/EwMX29Jc9G9hOOpFaczq8EwRC
	 3Cf1UGifzwWeurywMHocRK7zWD8i0mQJRGAhg0NzYLUgcTE2RPyHTr/zLiPdu4l4SF
	 TJn9NFL2l6+7Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: stmmac: dwmac-starfive: some improvements
Date: Sun, 27 Aug 2023 21:41:48 +0800
Message-Id: <20230827134150.2918-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is to improve the dwmac-starfive driver by correcting
error handling and removing unnecessary clk_get_rate().

Jisheng Zhang (2):
  net: stmmac: dwmac-starfive: improve error handling during probe
  net: stmmac: dwmac-starfive: remove unnecessary clk_get_rate()

 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 38 +++++++++++--------
 1 file changed, 22 insertions(+), 16 deletions(-)

-- 
2.40.1


