Return-Path: <netdev+bounces-12701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0428273899F
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACBF280E86
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C591951F;
	Wed, 21 Jun 2023 15:37:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA9156C3
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:37:32 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA271FC1
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f9bff0a543so7583705e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361821; x=1689953821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ClAzoGuEp9Q2PcVgXbgejHlPiXITPfjrxWcfTJEqc0=;
        b=AQIraaew2/zXvqE91YbkJxU/ss1rbUIc/5WuQ2mQSwEYNaPiuXgCTioCRnA75I2VFH
         +aCknfvR8zMLhgxgFgf+R4+5qcdatJMkGa8KNvvRfJbcxnUJU0FfInDocxRWkmdMvjXV
         jA6Ng/H7tcLwo0B5fe3RuLLWT368fspgiGisI9e7Y1/7perYFhsqalEbkJsnHZwzepPc
         +84/bY1JMoZu5qIIxGa5K2tC0byJVnDuBDEJxR+EkG17r1y/ENGmCwG/xT7yUoz/itB7
         8j2kOORbFrSvtdFFb4XNZSbKY7GQ0oPbztBfJ+cawzxzNLskGBR3+E7rrS3ryhjOVjTq
         eyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361821; x=1689953821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ClAzoGuEp9Q2PcVgXbgejHlPiXITPfjrxWcfTJEqc0=;
        b=c1rGlvCLCcJCUeRIZ4TkuPm2K3pukJSnaknIyfzBH49OBFgYfRVbcJ+eQotremmKx8
         Xphp2hhR8ZuDyVBk1s8Z+bwMiltnCqbxA23vDjVWRGNKPvitURuk/38ezj25BBGVofnY
         SaseQcMT8C82xldRlQ9v9QlJoyk4JGTOtLRt36PMWMLGw3T9xvEh9QxVKOVO+nwZyGtl
         XeQbqxbu4QUpSJZAwK+rycrV5BZimbUKLTVEiVZtntVBQlkz+sgAz5wsy/Zas3djM7B4
         IYKyi3ky+jWg6lEiEe+bpuQtZ3RP1BaIGsB4Oj4mgKhHvR2+8AnwhzDXY+XLbAyHmQSD
         zX1g==
X-Gm-Message-State: AC+VfDw2zc0uk9qP0Peto+Vu9CCLJ8P+D2IUNBMW1SnRWqO0TFvPk7qu
	pzl4469IM7vTBffuIA2e0V65SQ==
X-Google-Smtp-Source: ACHHUZ6HAkXFQk8+aVBXjAYvPLGkmxJv5JHJtkveKCNtpBoYsdRohmCW1C61OJtW2Tm6Xb1OgI9RQQ==
X-Received: by 2002:a7b:c38f:0:b0:3f8:ff4e:8ba3 with SMTP id s15-20020a7bc38f000000b003f8ff4e8ba3mr11474166wmj.38.1687361821346;
        Wed, 21 Jun 2023 08:37:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 00/11] net: stmmac: introduce devres helpers for stmmac platform drivers
Date: Wed, 21 Jun 2023 17:36:39 +0200
Message-Id: <20230621153650.440350-1-brgl@bgdev.pl>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The goal of this series is two-fold: to make the API for stmmac platforms more
logically correct (by providing functions that acquire resources with release
counterparts that undo only their actions and nothing more) and to provide
devres variants of commonly use registration functions that allows to
significantly simplify the platform drivers.

The current pattern for stmmac platform drivers is to call
stmmac_probe_config_dt(), possibly the platform's init() callback and then
call stmmac_drv_probe(). The resources allocated by these calls will then
be released by calling stmmac_pltfr_remove(). This goes against the commonly
accepted way of providing each function that allocated a resource with a
function that frees it.

First: provide wrappers around platform's init() and exit() callbacks that
allow users to skip checking if the callbacks exist manually.

Second: provide stmmac_pltfr_probe() which calls the platform init() callback
and then calls stmmac_drv_probe() together with a variant of
stmmac_pltfr_remove() that DOES NOT call stmmac_remove_config_dt(). For now
this variant is called stmmac_pltfr_remove_no_dt() but once all users of
the old stmmac_pltfr_remove() are converted to the devres helper, it will be
renamed back to stmmac_pltfr_remove() and the no_dt function removed.

Finally use the devres helpers in dwmac-qco-ethqos to show how much simplier
the driver's probe() becomes.

This series obviously just starts the conversion process and other platform
drivers will need to be converted once the helpers land in net/.

Bartosz Golaszewski (11):
  net: stmmac: platform: provide stmmac_pltfr_init()
  net: stmmac: dwmac-generic: use stmmac_pltfr_init()
  net: stmmac: platform: provide stmmac_pltfr_exit()
  net: stmmac: dwmac-generic: use stmmac_pltfr_exit()
  net: stmmac: platform: provide stmmac_pltfr_probe()
  net: stmmac: dwmac-generic: use stmmac_pltfr_probe()
  net: stmmac: platform: provide stmmac_pltfr_remove_no_dt()
  net: stmmac: platform: provide devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-qco-ethqos: use devm_stmmac_probe_config_dt()
  net: stmmac: platform: provide devm_stmmac_pltfr_probe()
  net: stmmac: dwmac-qcom-ethqos: use devm_stmmac_pltfr_probe()

 .../ethernet/stmicro/stmmac/dwmac-generic.c   |  14 +-
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        |  48 ++----
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 158 +++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  14 ++
 4 files changed, 179 insertions(+), 55 deletions(-)

-- 
2.39.2


