Return-Path: <netdev+bounces-29060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03F7818C3
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E89281C38
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4791C17;
	Sat, 19 Aug 2023 10:31:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD81ECB
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:31:43 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE11999625
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:01:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a36dc1422so2256b3a.3
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692435713; x=1693040513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mP+Iaztiy/Te0yU54nCdsDuHG3Gyg5T3frD57UFegog=;
        b=ExrrgAxcQGdrD4gt+ZfQ2Ook6TTfU/PFptEMprq7QAYoCftdn1uvYEYW17pHEXYi8u
         bZiNnMvTzMLUg9NanuYy/4dq3/vonslcCafGxZiWVpRFw+6rpAPww2ufM53ov0rxPdhz
         cY2kgBKZEP+DhNya0AoVICWgbyRwq71ythmo2pDj8M7L5oneQUXHXFoTipz8axdDsDWT
         tq77hvCJFYaOaIeRsGJTNtn0anY73anb67AMZBvqboouGvAlZXhc3H9hcVmLcg7irGUB
         dp0rPs/Nftj7K5VnKqgf/r1cCkSYVZCfK3BxBljAjEHJR/WsfUWAghmjc/7wdPYDgA6Q
         CpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692435713; x=1693040513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mP+Iaztiy/Te0yU54nCdsDuHG3Gyg5T3frD57UFegog=;
        b=SV1ifkZkHem+5CPgP+r1D0x1Akw7fd7RedMEjuKTh0kiNVvrecWDN7tkcSMG7BTWIZ
         416ozUrdflBgaxJ9V8FRBoHqIil/X3K7eqriqMhuYnykiSRivKdALHTSr9HL5IUcEADf
         toyPy4l2DAu6BBASU7ooSR2Ong5YTmEx0ZM70je4xWWU6FImIpa96Rk27TubTheyWEfO
         tbKNcMNRZaCfL1wGSbiEKi9hGjGEMRY/rfBet0R0t88aI+VEYLvFU/1vK+9drjwDrHd2
         +PlFPULHlbZiXHpwncvjh2+TyHUt2hKdFlYCVUgIp4iEqB7vgPUU+sI2qFRiQmDcpQhS
         0vxA==
X-Gm-Message-State: AOJu0YxBkc20zz8bLMbTFPRAfVLHNPnyr2w8EJiInCgQ7jrJCkcCX9TI
	B0On+UmmwUSqzpFjURzt0UsIQv++F7aNsJRz
X-Google-Smtp-Source: AGHT+IFtdJZoqn6nM4Hog9HSb5Rcfn+LJUecZJb1e4wWogIMx9FJDZK77ZplzoA3TF1SzZWU6jRw9A==
X-Received: by 2002:a05:6a20:729b:b0:13f:8e94:965e with SMTP id o27-20020a056a20729b00b0013f8e94965emr1524484pzk.5.1692435712642;
        Sat, 19 Aug 2023 02:01:52 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00688435a9915sm2758895pfn.189.2023.08.19.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 02:01:31 -0700 (PDT)
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
Subject: [PATCH net 0/3] bonding: fix macvlan over alb bond support
Date: Sat, 19 Aug 2023 17:01:06 +0800
Message-ID: <20230819090109.14467-1-liuhangbin@gmail.com>
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

Currently, the macvlan over alb bond is broken after commit
14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode bonds").
Fix this and add relate tests.

Hangbin Liu (3):
  bonding: fix macvlan support on top of rlb bond
  selftest: bond: add new topo bond_topo_2d1c.sh
  selftests: bonding: add macvlan over bond testing

 drivers/net/bonding/bond_alb.c                |   4 +-
 include/net/bonding.h                         |  11 +-
 .../drivers/net/bonding/bond_macvlan.sh       |  99 +++++++++++
 .../drivers/net/bonding/bond_options.sh       |   3 -
 .../drivers/net/bonding/bond_topo_2d1c.sh     | 158 ++++++++++++++++++
 .../drivers/net/bonding/bond_topo_3d1c.sh     | 118 +------------
 6 files changed, 268 insertions(+), 125 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
 create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh

-- 
2.41.0


