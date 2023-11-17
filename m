Return-Path: <netdev+bounces-48575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A438D7EEE48
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD443B20B65
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D27210979;
	Fri, 17 Nov 2023 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB595D4D
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:17:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyQ-0007gN-Qv; Fri, 17 Nov 2023 10:17:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyP-009e64-03; Fri, 17 Nov 2023 10:17:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyO-002yJU-MG; Fri, 17 Nov 2023 10:17:12 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: 
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Stanislav Fomichev <sdf@google.com>,
	Marek Majtyka <alardam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	linux-omap@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Alex Elder <elder@linaro.org>
Subject: [PATCH 0/7] net: ethernet: Convert to platform remove callback
Date: Fri, 17 Nov 2023 10:16:56 +0100
Message-ID: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wXCgBNxbg3ysP3JCSEHurrmf3eiwdq62Y4zXvsuYJQU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRw/XbnB608Ouuryo9rPfD9F+Vqr9ARn/g3gvnZri3Xm owvNz/vZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAi1Ws5GPq1dq9z2uzbsLPK p+r0pd+2Hx9wJW22fv+zS7fESOtk5WyXrWUbNf94JGUtcAjsENmZUthWLTZp0rGqNZ5KTYnPIp5 KXI1XyHt1UUMsb096zWuH7MIXB+dnd9y3PFwlz7bMjWPn3H09+zRdUq84BLyX9nNpv3VwO88Rlj naM8wPC1v+P72+Wyi/Reys78mVdoYLUmMaNAt2On6qVeNhTjE/qCWz3/N+4jFJa/b/eWy3pWdnX bloqia70u3Gq6TKkK83fBv3SYkdyhbW+HJjmZdOIFe7q83vttXJ30sNWaw3snOUeCux9cgEfDr4 KOly6Ma/Gky5VdEp3esfrI77NOvgWfeQ275P3OeaxykBAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello,

after three fixes this series converts the remaining four platform
drivers below drivers/net/ethernet that don't use .remove_new yet to do
that.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.
The TL;DR; is to prevent bugs like the three fixed here.

Best regards
Uwe

Uwe Kleine-König (7):
  net: ethernet: ti: am65-cpsw: Don't error out in .remove()
  net: ethernet: ti: cpsw: Don't error out in .remove()
  net: ethernet: ti: cpsw-new: Don't error out in .remove()
  net: ethernet: ti: am65-cpsw: Convert to platform remove callback
    returning void
  net: ethernet: ti: cpsw: Convert to platform remove callback returning
    void
  net: ethernet: ti: cpsw-new: Convert to platform remove callback
    returning void
  net: ethernet: ezchip: Convert to platform remove callback returning
    void

 drivers/net/ethernet/ezchip/nps_enet.c   |  6 ++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 12 +++++++-----
 drivers/net/ethernet/ti/cpsw.c           | 21 ++++++++++++++-------
 drivers/net/ethernet/ti/cpsw_new.c       | 21 ++++++++++++++-------
 4 files changed, 37 insertions(+), 23 deletions(-)

base-commit: eff99d8edbed7918317331ebd1e365d8e955d65e
-- 
2.42.0


