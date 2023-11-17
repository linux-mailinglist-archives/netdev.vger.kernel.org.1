Return-Path: <netdev+bounces-48663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7007EF279
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE9BB207B5
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BECC30343;
	Fri, 17 Nov 2023 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNEXft1G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4117726
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 12:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6FBC433C8;
	Fri, 17 Nov 2023 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700223482;
	bh=HpoiobYK4SHESYSPd2bYVUp4GAKtfq8ebm87To2wZ7s=;
	h=From:To:Cc:Subject:Date:From;
	b=MNEXft1GJ6TUQIkUL85urPe/TCGb3B9a+mrpGwYM0hhI+hnVW2KKV869AYSOJsLFz
	 ERT/75Dty3g99oCMgPSaFp7bVOUr6qIwV84VRwQVYMkPFZ/bJAifuXFnYjWVP8yy4P
	 EHaI+QNigecekIore5t+YhVacTv+bjvxTlVeJfH5aY57DzdRzBgc4Wk0bTZAt9Qu8v
	 ganpBOKmbczHNr0Xfu1ycBRd/z749u4Nl/qXo4eJzO37pYXgvFP6Ht1EngT3M2c2nH
	 8st6V0AG8aOUCtKxa4JPe19gVaQU5vZcJl30HAePMpmfpZzqFpXd4sf7X68hYrpTEy
	 Obk1tqbgGWjOA==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	andrew@lunn.ch,
	u.kleine-koenig@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 net-next 0/4] net: eth: am65-cpsw: add ethtool MAC stats
Date: Fri, 17 Nov 2023 14:17:51 +0200
Message-Id: <20231117121755.104547-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Gets 'ethtool -S eth0 --groups eth-mac' command to work.

Also set default TX channels to maximum available and does
cleanup in am65_cpsw_nuss_common_open() error path.

Changelog:
v2:
- add __iomem to *stats, to prevent sparse warning
- clean up RX descriptors and free up SKB in error handling of
  am65_cpsw_nuss_common_open()
- Re-arrange some funcitons to avoid forward declaration

cheers,
-roger

Roger Quadros (4):
  net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool
  net: ethernet: ti: am65-cpsw: Re-arrange functions to avoid forward
    declaration
  net: ethernet: am65-cpsw: Set default TX channels to maximum
  net: ethernet: ti: am65-cpsw: Fix error handling in
    am65_cpsw_nuss_common_open()

base-commit: 18de1e517ed37ebaf33e771e46faf052e966e163
-- 
2.34.1


