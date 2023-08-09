Return-Path: <netdev+bounces-25875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F388A776109
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BCA1C21283
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DB318C15;
	Wed,  9 Aug 2023 13:28:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06919BD7
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:28:42 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E02727;
	Wed,  9 Aug 2023 06:28:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 536EC4000F;
	Wed,  9 Aug 2023 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1691587712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3M7r5kP9BFmSEGkwYYNmaCjvt7TKrPw/eCo9cZe9TE=;
	b=ItleYGvxGA2aGrqoc9FCBwKTpuac/dNNasRHV7bIC4g+qMhq+3+jgkf+XdvSZFgPLKcjDR
	nh/0iPri4HVqoBSlJMgaxmriNacFBtE7RwyG8Oysff8LaY6NUqFCwfDVVhxMk3Qvrz8bf1
	C+DWS4s0LgYc+uSKRxRZ8VdKCOH9n+9w1Iqx5eiZYrRP3CbyUf8iZzjI4yd1l6Nc/Qa5ie
	krFBgE3XLzhhEmwpoaXXVT5fVMHr/mso/Ly6ALF5tKr+jp3I3OvCRiS+jRrOsnSNwsdTh9
	1Uh5OPYVXEHh6G2EjslIQ/bO4TTKyQQVrlkuwAZuqJQXZ/1oJ7xvIIdbKvoJ5Q==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 12/28] soc: fsl: cpm1: qmc: Remove no more needed checks from qmc_check_chans()
Date: Wed,  9 Aug 2023 15:27:39 +0200
Message-ID: <20230809132757.2470544-13-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809132757.2470544-1-herve.codina@bootlin.com>
References: <20230809132757.2470544-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The newly introduced qmc_chan_setup_tsa* functions check that the
channel entries are not already used.
These checks are also performed by qmc_check_chans() and are no more
needed.

Remove them from qmc_check_chans().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index bddff0b74252..2416408bb7e7 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -884,10 +884,7 @@ EXPORT_SYMBOL(qmc_chan_reset);
 static int qmc_check_chans(struct qmc *qmc)
 {
 	struct tsa_serial_info info;
-	bool is_one_table = false;
 	struct qmc_chan *chan;
-	u64 tx_ts_mask = 0;
-	u64 rx_ts_mask = 0;
 	u64 tx_ts_assigned_mask;
 	u64 rx_ts_assigned_mask;
 	int ret;
@@ -911,7 +908,6 @@ static int qmc_check_chans(struct qmc *qmc)
 			dev_err(qmc->dev, "Number of TSA Tx/Rx TS assigned are not equal\n");
 			return -EINVAL;
 		}
-		is_one_table = true;
 	}
 
 	tx_ts_assigned_mask = info.nb_tx_ts == 64 ? U64_MAX : (((u64)1) << info.nb_tx_ts) - 1;
@@ -922,27 +918,11 @@ static int qmc_check_chans(struct qmc *qmc)
 			dev_err(qmc->dev, "chan %u uses TSA unassigned Tx TS\n", chan->id);
 			return -EINVAL;
 		}
-		if (tx_ts_mask & chan->tx_ts_mask) {
-			dev_err(qmc->dev, "chan %u uses an already used Tx TS\n", chan->id);
-			return -EINVAL;
-		}
 
 		if (chan->rx_ts_mask > rx_ts_assigned_mask) {
 			dev_err(qmc->dev, "chan %u uses TSA unassigned Rx TS\n", chan->id);
 			return -EINVAL;
 		}
-		if (rx_ts_mask & chan->rx_ts_mask) {
-			dev_err(qmc->dev, "chan %u uses an already used Rx TS\n", chan->id);
-			return -EINVAL;
-		}
-
-		if (is_one_table && (chan->tx_ts_mask != chan->rx_ts_mask)) {
-			dev_err(qmc->dev, "chan %u uses different Rx and Tx TS\n", chan->id);
-			return -EINVAL;
-		}
-
-		tx_ts_mask |= chan->tx_ts_mask;
-		rx_ts_mask |= chan->rx_ts_mask;
 	}
 
 	return 0;
-- 
2.41.0


