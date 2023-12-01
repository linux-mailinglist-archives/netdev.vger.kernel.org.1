Return-Path: <netdev+bounces-52946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E49FA800DD4
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992411F20D22
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A73E498;
	Fri,  1 Dec 2023 15:01:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D41D6C;
	Fri,  1 Dec 2023 07:01:51 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1r951S-0000eX-Mm; Fri, 01 Dec 2023 16:01:42 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	heiko@sntech.de
Subject: [PATCH 0/2] net: phy: micrel: additional clock handling
Date: Fri,  1 Dec 2023 16:01:29 +0100
Message-Id: <20231201150131.326766-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Micrel phys define a specific rmii-ref clock (added in 2014) while
the generic phy binding specifies an unnamed clock for ethernet phys.

This allows Micrel phys to use both, so as to keep the phys not using
the named rmii-ref clock to conform to the generic binding while allowing
them to enable a supplying clock, when the phy is not supplied by a
dedicated oscillator.


Heiko Stuebner (2):
  net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref
    clock
  net: phy: micrel: allow usage of generic ethernet-phy clock

 drivers/net/phy/micrel.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.39.2


