Return-Path: <netdev+bounces-15292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020AA746A30
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 08:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781A51C20A78
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 06:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58010FD;
	Tue,  4 Jul 2023 06:59:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E81368
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:59:38 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D3107
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 23:59:35 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230704065933ed20249795d17e56fa
        for <netdev@vger.kernel.org>;
        Tue, 04 Jul 2023 08:59:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=b5rEaasbVD70uV0KaKcnh8XZdEIB4CkUmPMwdCkGMqc=;
 b=R4WwaRH1KkwnOv7MGACIUjBNYBZaKVmitUSalOY4XAQdLHymw70Tk+ctxG8c6RHLMRhC0m
 +kcQLgt3agq+pH+qQCPUvJUbstpisxfmaBdpMFsh5M02r0MIILAvjF/YLLCyv4W3+D0QOdZk
 b4e+sIx5rxnrDxLyiBZ9u7/QzcTKU=;
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
Subject: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Date: Tue,  4 Jul 2023 08:59:03 +0200
Message-ID: <20230704065916.132486-1-michael.haener@siemens.com>
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


