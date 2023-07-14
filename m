Return-Path: <netdev+bounces-17753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE7752F93
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEBB1C21519
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F268B10FE;
	Fri, 14 Jul 2023 02:52:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76EB1870
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:52:16 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085EE2D48
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:52:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6686c74183cso1416648b3a.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689303135; x=1691895135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73T8dVxxtMynx4wbNvpgMhzmwlQxEaMyD1H0Syk1eE4=;
        b=KoEYewzKtylEOm/wm3i8T6U6Dvzi9FEB9MxED3qwpJw1JAri6yaQm93vxfJXg1/GyC
         Bh6Qfbu6OYH2Em6BJ99C8pNFIbU69k+Ei3NdPUBkvCOwLqyO6WeWBXX80yO6GtACHisl
         hmS0QXr5soY2pB2h3Ccl+miCDy727q2Ul8wMVNFi7bbfTHKyS5/MxZei2wfvm+JHG5lQ
         oM8y2OhJXczJ/4z7dVp+uUhOoKofNuYwK9ZmhOQzDtVxqr+T+Tpm7nZjMCGqOH7G7G7H
         f9MdVHZQ7bouU9ke1z3wSEKdMYI4KUMDGVwqXCxzQ/Z07fOzZ35AbRAIcCgG6Wv/G05i
         WXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689303135; x=1691895135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73T8dVxxtMynx4wbNvpgMhzmwlQxEaMyD1H0Syk1eE4=;
        b=Qzoiy6+urJ3Vj4P3DTGFkg+wnfn7wR3gJhtggHXROGFSJ4f5FnF+6H2ztZx/61OE7w
         1NhDimJgxZYsJEg6FBWrCga1Kqnu1DBVH9bxjrsqU+4zmnBcsMdg8gwXihY2JgVg5PP5
         mQyRle75ccSa74Y/A09oo+zm/hInHQ12UAH78Vze0y9ekD0GjivTOkwA4KpXOurngp0y
         8mxsDdnbAPZF2arsp+zEuK5Ep8u6mkQZ/Slhi+KHmMkCiUNeefW3t8QnnR3RODOSBxXJ
         9t6krodsFNLkoOoZiZoANsovX8a2dFiix9j3GJePUfnN0Slqr1dHr+AAEnBEASuflowS
         Lm6A==
X-Gm-Message-State: ABy/qLalY38et3HEOic9IpATBTLXPeJ7feIfDva+Hs6NgJLAB5PL4Nbl
	qHcC0ooE1SBIuYNLNzpBtfBS/xy8Lu/ZcA==
X-Google-Smtp-Source: APBJJlG4geJa7PqHljjTC9jeE8Bzk8dPnCeZ9+C3DfNx0OvA1LQDSlRBRld7ePGWKaqtpKFNPWOdFA==
X-Received: by 2002:a05:6a20:a5a8:b0:132:fe9f:be9e with SMTP id bc40-20020a056a20a5a800b00132fe9fbe9emr3380679pzb.20.1689303134930;
        Thu, 13 Jul 2023 19:52:14 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:782f:8f50:d380:ebf:ef24:ac51])
        by smtp.gmail.com with ESMTPSA id l6-20020a637006000000b0055b07fcb6ddsm6347930pgc.72.2023.07.13.19.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 19:52:14 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 2/2] team: reset team's flags when down link is P2P device
Date: Fri, 14 Jul 2023 10:52:01 +0800
Message-Id: <20230714025201.2038731-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230714025201.2038731-1-liuhangbin@gmail.com>
References: <20230714025201.2038731-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When adding a point to point downlink to team device, we neglected to reset
the team's flags, which were still using flags like BROADCAST and
MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
interfaces, such as when adding a GRE device to team device.

Fix this by remove multicast/broadcast flags and add p2p and noarp flags.

Reported-by: Liang Li <liali@redhat.com>
Links: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/team/team.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 555b0b1e9a78..c11783efe13f 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2135,6 +2135,10 @@ static void team_setup_by_port(struct net_device *dev,
 	dev->mtu = port_dev->mtu;
 	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
 	eth_hw_addr_inherit(dev, port_dev);
+
+	if (port_dev->flags & IFF_POINTOPOINT)
+		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
 }
 
 static int team_dev_type_check_change(struct net_device *dev,
-- 
2.38.1


