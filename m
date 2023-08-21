Return-Path: <netdev+bounces-29277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4017826CD
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A63280E98
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67504A29;
	Mon, 21 Aug 2023 10:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F861848
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 10:10:34 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7CAE8
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 03:10:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdbf10333bso24534585ad.1
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 03:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692612623; x=1693217423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XuHt4TfV1yG9DGNii0ZXojePwRxZX9n2cAdIFRcUEps=;
        b=JdxNgtNHdf4wyecVlX49vfQcBwvqUmG1Qt5qsOTfKGthL8UlVa7eIStD3tmnsHsc4y
         QA3hd5Uy1hOLGY94WNSHBoyegxmTJbM1Qatrt5d3yMefDbiE8fGYwNPBmwGk9zV3A40O
         BgxtnadeSXBzEzoZyzlQ22tubs/VuSwCvrzgkWGAzpZahPiFJvRP57wkm8vBx5VQWuJ7
         5P6BfsQ1sGzgako2zXnzGUx5uMV6FPeSaYbzvczOyJZMx0XJHijliUKvHG2F2k/n6/Xs
         EkPIzv/MiJA8DKPQxzK0HLzDEjhrr+FDXksWkkeCGn2GlJ7fZOvjEAiuGpAsdWzKc5zg
         Mc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692612623; x=1693217423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuHt4TfV1yG9DGNii0ZXojePwRxZX9n2cAdIFRcUEps=;
        b=AmKKZCYTtGVyfxpzM0Zip58aiW+b9R6eacCQeUu2ewysGB/EtIN4pu+xg28BCE/vgw
         lrHCI04CGpkcn1qCPzg+2KycJDysShwsaqpcXBOUCcM/lKoOEUWwX2Otj4DHPjgVk7gD
         G0/t7UvzyhuZsQ+je/F3KTtcwTUqqnZDolVyTzNpjsqR6v0afkOo/nNzplsPJvFO/L9F
         BAFS+lADFWrDzPby+HoyhxLblX48WUlh4/TZxeptUW9L/Mk0tMHnf/w7TeDUXP04nSOj
         Rh6coNkXP3o6WauH199btMQ4JjvS7ZQR5P2q0soNRFzEDMFhmDNH0vbLGc04il0O1lJN
         zG6A==
X-Gm-Message-State: AOJu0Yz0gwDIMAZPBB+dg8MMfVg0n/4H7PsVCOcINVmULVlqpvxNJQUr
	s+LBTkvk5JxaGmT4Kyy8tFcvOwhuXVbMRA==
X-Google-Smtp-Source: AGHT+IHFoB4SdQm2SpKTP2kdEJbMzSRDg3bZmm7eXr+sEwezL2kH0mtAO2g8Us3mP8J2VMstlnMsmw==
X-Received: by 2002:a17:902:7c94:b0:1bb:cf58:531d with SMTP id y20-20020a1709027c9400b001bbcf58531dmr6687434pll.10.1692612623451;
        Mon, 21 Aug 2023 03:10:23 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001b7f40a8959sm6650995plg.76.2023.08.21.03.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 03:10:17 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Andrew Schorr <ajschorr@alumni.princeton.edu>
Subject: [PATCH net-next] bonding: update port speed when getting bond speed
Date: Mon, 21 Aug 2023 18:10:08 +0800
Message-ID: <20230821101008.797482-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrew reported a bonding issue that if we put an active-back bond on top
of a 802.3ad bond interface. When the 802.3ad bond's speed/duplex changed
dynamically. The upper bonding interface's speed/duplex can't be changed at
the same time, which will show incorrect speed.

Fix it by updating the port speed when calling ethtool.

Reported-by: Andrew Schorr <ajschorr@alumni.princeton.edu>
Closes: https://lore.kernel.org/netdev/ZEt3hvyREPVdbesO@Laptop-X1/
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 447b06ea4fc9..07c2e46d27a8 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5706,6 +5706,7 @@ static int bond_ethtool_get_link_ksettings(struct net_device *bond_dev,
 	 */
 	bond_for_each_slave(bond, slave, iter) {
 		if (bond_slave_can_tx(slave)) {
+			bond_update_speed_duplex(slave);
 			if (slave->speed != SPEED_UNKNOWN) {
 				if (BOND_MODE(bond) == BOND_MODE_BROADCAST)
 					speed = bond_mode_bcast_speed(slave,
-- 
2.41.0


