Return-Path: <netdev+bounces-16390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4C274D0C5
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 11:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A901C20993
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE81C8D0;
	Mon, 10 Jul 2023 09:00:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA08C8C9
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:00:15 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D844E7
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 02:00:13 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6fbf0c0e2so63457461fa.2
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688979611; x=1691571611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi0neW334vEUn9BnnI+UYaAU5ZZLFAfHbjZLAic+fdQ=;
        b=EqBWfD3g9G1f2j+bgRXH5wRADIaccx1W0vEhGOo3hNKnmlyLuJx4VJJ7mTzA/k0i2d
         F+7KfZoiLqYu9xNbaAdf4xyciku5hdX7Fm7MXl/i+Ycd9Zn7qWq+IsBhcwjC+zwJBXpq
         ghM9Bf2gyNLr2cbrh48lSiYil8EFiWr+pFopsMPdriUzrqEuCE4KE1eRE/E7SKosr4MF
         Dd9xTvJ6brdf1TpX+x3ThA/7st5nwDz71MIAWAZTG6Cds93Vh46UdxVVSJCZ9MMbIGaG
         SflTHiNb4yIx1+hAc//E50HZyvTzAQHZFZrKtppJ+7GmP6up/KqbHNltSfszxujOo+BU
         qsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979611; x=1691571611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pi0neW334vEUn9BnnI+UYaAU5ZZLFAfHbjZLAic+fdQ=;
        b=S6guL12htpFADqmcziMQgjQmGubbER01vOJg4gTkOylsoCYjNXxRDflLlXrAADK07X
         KxW8Fj6utk5Ae5OTDFcgDXg0HaLwrOMaNI/NVZyKdqkFHOH/ci4cONsFB0WfGWlSQ8my
         TNLK9e1gckvibSDjKPb8HdgcNlOcCy6fO5yeEXWvXXrRU88uq5kbQu8ND/BdvI5FVrmp
         ShQB7URQN7CFkv909INYJOasiT7T/RXHmfQ4oZSijSIB0U1uVij4CdOvPU/ApRWG0pDf
         cSrYa0fE+noeh8Gf8m5HYpc0Z6hU/cX0UHbNeEXh5vsgRSVK0o0cjpC/jr52vFI5/GRu
         HPMA==
X-Gm-Message-State: ABy/qLYOM55z9j3F2n5jLEyCRBzrX/dT1t6ZXa82RpWN01yo0tVnm9h6
	x/K3hpra9uo8v5YPlVf9I73rgw==
X-Google-Smtp-Source: APBJJlEjnwa6aLt1S4/l0UmZLQcAqJFRGPgprZQ9W+4d6fTrF3qCcNsLykNlD/mAdr8AMz3+iYLvsA==
X-Received: by 2002:a2e:b0c6:0:b0:2b6:a7dd:e22 with SMTP id g6-20020a2eb0c6000000b002b6a7dd0e22mr9274754ljl.48.1688979610963;
        Mon, 10 Jul 2023 02:00:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6002:540:6954:abdd])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003fc00702f65sm8581045wmr.46.2023.07.10.02.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:00:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v3 00/12] net: stmmac: replace boolean fields in plat_stmmacenet_data with flags
Date: Mon, 10 Jul 2023 10:59:49 +0200
Message-Id: <20230710090001.303225-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As suggested by Jose Abreu: let's drop all 12 boolean fields in
plat_stmmacenet_data and replace them with a common bitfield.

v2 -> v3:
- fix build on intel platforms even more
- collect review tags from Andrew

v1 -> v2:
- fix build on intel platforms

Bartosz Golaszewski (12):
  net: stmmac: replace the has_integrated_pcs field with a flag
  net: stmmac: replace the sph_disable field with a flag
  net: stmmac: replace the use_phy_wol field with a flag
  net: stmmac: replace the has_sun8i field with a flag
  net: stmmac: replace the tso_en field with a flag
  net: stmmac: replace the serdes_up_after_phy_linkup field with a flag
  net: stmmac: replace the vlan_fail_q_en field with a flag
  net: stmmac: replace the multi_msi_en field with a flag
  net: stmmac: replace the ext_snapshot_en field with a flag
  net: stmmac: replace the int_snapshot_en field with a flag
  net: stmmac: replace the rx_clk_runs_in_lpi field with a flag
  net: stmmac: replace the en_tx_lpi_clockgating field with a flag

 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 23 +++++------
 .../ethernet/stmicro/stmmac/dwmac-mediatek.c  |  5 ++-
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        |  8 ++--
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-tegra.c |  4 +-
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 40 +++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  |  2 +-
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 10 +++--
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  5 ++-
 include/linux/stmmac.h                        | 26 ++++++------
 12 files changed, 76 insertions(+), 57 deletions(-)

-- 
2.39.2


