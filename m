Return-Path: <netdev+bounces-29500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B646F783852
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 05:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C01B280F83
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 03:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F20E111F;
	Tue, 22 Aug 2023 03:12:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FBB7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:12:33 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F054F138
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:12:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a410316a2so1168410b3a.0
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692673952; x=1693278752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bMQbkf+JmMhfzw2YkHmW9WJ5nnfZA5nHVrMDXLuS7i0=;
        b=TmtvfU8bUiVtivsfQ/B4WSPBoOkED++igsULc1YeTjj0rzzoyzUIqtjwfgaCPr2Myp
         +A4B1MhLi1rsVbMB7pkzPqhNFCyOqaXnui5XWPSrcOdEkR2PUr6QECg2sN53v/1OLH9c
         nVlnsGR+cnfSIt2pjrmZ55CAMYNFJsmDPyhDkZooMjum+6YFrA2oFJ/nVrw5GwkUp0D4
         B83fh0/pSlLG+prq1A+ecv3fqoV1chPcbVTxYUsqOwgeWznjb/e0ZcbnAxMA20OSR8q0
         08WBi8huT0yl8gGNtNEFnVfYiiUaJUMHWS21y4rf8nfsjdYAGFQ/lxRmmAOLGTjqfQZi
         E82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692673952; x=1693278752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMQbkf+JmMhfzw2YkHmW9WJ5nnfZA5nHVrMDXLuS7i0=;
        b=UuxrDmX1RBMdbbWC/pHw8we2tQvwfoZsUlOlNX+do8DRQb3gIwVqeWkO+WzJ6ReapG
         zSHc/ED4mhq/XMYif6BTUsBkn/CEfzIxSMMeJ6Z6mxMSF77IMuV7UpsUq4FmGjOrTZmJ
         SJ7jqRaVUacZVTtt4hyi5sunaXiMO7Z90+Li3dGkLddyAG2TvbAYjG54DGkW9upkXwLA
         ZWh12UFvR1tUoEfFJ2ogTcLgmO1HD8RyJ7/H+cUzcoIc2Hwq3BRIcgg1UESSd8vo0Xli
         CzJzNy2KkLSeeHLP4B+2yOlDJkEtKMhdojQmeFRAx/2zWM6rVbk2if8+6NSZvEUSbYUc
         mgUw==
X-Gm-Message-State: AOJu0YxS4k9xCyyUfZEc2gSTY6kk5Xc3yMXwg9NQ8ZdnHUukOj5k7bSb
	SfvNWLVaHC0peuqrzH3EhtFVgkSK4pE29g==
X-Google-Smtp-Source: AGHT+IE8liB6W0HPwk86N8IARIPvJYYVdXclgskAk4MRwVUk5Il3M/FJjT8FuLypaeuiWUU2T1ybBA==
X-Received: by 2002:a05:6a20:f393:b0:133:dc0a:37e7 with SMTP id qr19-20020a056a20f39300b00133dc0a37e7mr6682780pzb.13.1692673951760;
        Mon, 21 Aug 2023 20:12:31 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ix21-20020a170902f81500b001bde6fa0a39sm7803601plb.167.2023.08.21.20.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 20:12:31 -0700 (PDT)
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
Subject: [PATCHv2 net 0/3] fix macvlan over alb bond support
Date: Tue, 22 Aug 2023 11:12:22 +0800
Message-ID: <20230822031225.1691679-1-liuhangbin@gmail.com>
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
  bonding: fix macvlan over alb bond support
  selftest: bond: add new topo bond_topo_2d1c.sh
  selftests: bonding: add macvlan over bond testing

 drivers/net/bonding/bond_alb.c                |   6 +-
 include/net/bonding.h                         |  11 +-
 .../drivers/net/bonding/bond_macvlan.sh       |  99 +++++++++++
 .../drivers/net/bonding/bond_options.sh       |   3 -
 .../drivers/net/bonding/bond_topo_2d1c.sh     | 158 ++++++++++++++++++
 .../drivers/net/bonding/bond_topo_3d1c.sh     | 118 +------------
 6 files changed, 269 insertions(+), 126 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
 create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh

-- 
2.41.0


