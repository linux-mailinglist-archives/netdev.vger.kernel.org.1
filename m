Return-Path: <netdev+bounces-18469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089537574CB
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8613281254
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A23D72;
	Tue, 18 Jul 2023 07:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA523CB
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:00:00 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA62C1AC
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 23:59:58 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023071806595625aff3f4af98540424
        for <netdev@vger.kernel.org>;
        Tue, 18 Jul 2023 08:59:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=dsqOsTbu6ItfSQgdDQ9vQvzE5kO/E/YSJ1AX3jl3+I4=;
 b=b0sh/73dxpJ5z48g0KYd7PK1ggLAlq2Zp+unEjLDZ3SDbp7w6kl02kAewCAggNuLBe2ycv
 PjCWLZsl443vujr1F6jHY2ZhDPDf4gJ4Z43wbl9oHTH7iqcpDge3NCBwjc3pwQdLJeic3W1f
 cm9Ib02hd20Awwf6ExbzFtM01pj38=;
From: "M. Haener" <michael.haener@siemens.com>
To: netdev@vger.kernel.org
Cc: Michael Haener <michael.haener@siemens.com>,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 0/3] net: dsa: SERDES support for mv88e632x family
Date: Tue, 18 Jul 2023 08:59:28 +0200
Message-ID: <20230718065937.10713-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michael Haener <michael.haener@siemens.com>

This patch series brings SERDES support for the mv88e632x family.

We have backported and tested the patch series with kernel 6.1.
With the current kernel it was possible to build without errors,
but not to test on the HW (due to a vendor kernel).

Changelog:
v3: rebased onto main branch
v2: rebased onto Russell Kings series dsa/88e6xxx/phylink

Michael Haener (3):
  net: dsa: mv88e632x: Refactor serdes read
  net: dsa: mv88e632x: Refactor serdes write
  net: dsa: mv88e632x: Add SERDES ops

 drivers/net/dsa/mv88e6xxx/chip.c   | 35 ++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  5 ++
 drivers/net/dsa/mv88e6xxx/serdes.c | 76 +++++++++++++++++++++++-------
 drivers/net/dsa/mv88e6xxx/serdes.h | 33 +++++++++++++
 4 files changed, 133 insertions(+), 16 deletions(-)

-- 
2.41.0


