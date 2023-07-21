Return-Path: <netdev+bounces-19715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CCC75BD10
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 06:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A761C215BF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 04:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62E7F9;
	Fri, 21 Jul 2023 04:04:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A87F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:04:12 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A501BFC
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:04:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad356fe4so10274355ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689912249; x=1690517049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bY/RBfdoq4ZeKaav890cCu+cZT1ywyH6Utsea1xTdnA=;
        b=gFf3Axz1UOByOaSesSuMbh+Qv17DTID16u04VLT7lzB1TfD5611MZrtH3kpwMB+DlT
         iARCAQaJMuAOdpRh6VYJKPR+1C/Rh83wHbCwE3k8u5z+FNh7IxIFX8ejv4963ogHMJE0
         5GOYN/CgTy+JSegKgvEgwinW2EyXRmg5TwQsvISkROTrNJa9dE6xb9b6HjGA73Ri1AJr
         ZYc/qQmCvkjCEqyeIJsWyu1TMBVAkM69PGq8fDFI3t588u0CDUeKDRWY8hWKwHJ9YGMi
         Tuji4zzkAsxXhnMlW+h9DBOOQ46cWLO4kPhKd/6bbf3BJV++D39jnTR+Jp7RLkfFKRoW
         99UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689912249; x=1690517049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bY/RBfdoq4ZeKaav890cCu+cZT1ywyH6Utsea1xTdnA=;
        b=KqhRC8Qduf30wdca1OVX+K0V4EGm+wESHaIYphVd328myfSVyusRZXWYYn0uTygOAT
         u3QtZFFz5YoHeC1uAgZKW9S8l1tT6XDmV7PYyjDCAc72qZfHYj7gIu/sqcadrWaJAPDT
         gFCPRL4NRxkglKlz/dNIn9bwkGubxzQ9kN9qzD2UgaRLKtD0W9+1IbIJtCfhy2tOTVZW
         Ntt3zn0lfEQdWldEb2KxPQXMxRlOcHkHhK7PbkU8wbw50snCvelVPBfk+qPgOy3fMzFH
         KizVCBB31BUxwp1ttFGBoyc+Ezx8f3pmNK+AOFn4q/MndJeTxRHqac8D87m8rnnl31m5
         mupg==
X-Gm-Message-State: ABy/qLYRAYixkILaH2BX2kx96zxigYoQJKJpvpClyJFVumVPQ0eAA6uo
	rZAA6i5xbr7Uk8uNyOsahovd9IFistH4AQ==
X-Google-Smtp-Source: APBJJlFtxypNbP5gcYQz+/zfqsiiaCpPPi+6jae7r1YqzwWEj7R/8PF6lrccVo02FO/W+SLbJ26zrQ==
X-Received: by 2002:a17:90b:14d:b0:25e:ff04:4fb with SMTP id em13-20020a17090b014d00b0025eff0404fbmr544501pjb.23.1689912249046;
        Thu, 20 Jul 2023 21:04:09 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bt21-20020a17090af01500b00263f6687690sm1640480pjb.18.2023.07.20.21.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 21:04:08 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net 0/2] Fix up dev flags when add P2P down link
Date: Fri, 21 Jul 2023 12:03:54 +0800
Message-Id: <20230721040356.3591174-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When adding p2p interfaces to bond/team. The POINTOPOINT, NOARP flags are
not inherit to up devices. Which will trigger IPv6 DAD. Since there is
no ethernet MAC address for P2P devices. This will cause unexpected DAD
failures.

v4: Just reset the team flag, not call ether_setup, as Paolo pointed.
v3: add function team_ether_setup to reset team back to ethernet. Thanks Paolo
v2: Add the missed {} after if checking. Thanks Nikolay.

Hangbin Liu (2):
  bonding: reset bond's flags when down link is P2P device
  team: reset team's flags when down link is P2P device

 drivers/net/bonding/bond_main.c | 5 +++++
 drivers/net/team/team.c         | 9 +++++++++
 2 files changed, 14 insertions(+)

-- 
2.38.1


