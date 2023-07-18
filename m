Return-Path: <netdev+bounces-18541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63BC757924
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26912812D2
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3B6FBF9;
	Tue, 18 Jul 2023 10:17:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E4F9FA
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:17:51 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3FC194
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:17:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5542282b3a.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689675469; x=1692267469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByoyaqDvNhznvUMMuzyRUEldA672hoWbODlIr1lBkEU=;
        b=WADum/ioMrjvXQ1M7W1D4pHoIqZnvyMSMcPaT9YgrrbwGB0+3rtuCNo59tWJts7YFu
         J5FPGHokA2BcV5iv96pjZtxyRjsyVVKWPLYgg3w+7DFckRxw6s188HYsFqLUhKKfI7QQ
         rPYWEoxvAopmAYhncUvm4N6VHHZFosJ5pAv4jJdG5nA/za+i1xGXRi42nqF+BBL6CgBj
         ZGyk+HPCUd/RTcEmwj+uyC40XNE8YA71RS3vFOQbuLskOgl7N041Crj7qZZymtWYEUIn
         pipm/L4aggaDytth05HOGi7Z4KPYOnWYiiU7/a7PKTCoeqKfvG4HHTswREH6M+R+dPZr
         v60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689675469; x=1692267469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByoyaqDvNhznvUMMuzyRUEldA672hoWbODlIr1lBkEU=;
        b=MxmYhkVCDOfRmp0PgSpiEhvpclPKmAbcx8UNc+q2XVdH8r4x4UPyUv+NGt0Ly6vApU
         uEIQ81JMqqi5JUS1CDMHfBsi2i6AwW6ROFKXZiUpVHcaaDowrvLDnl0WMB/gXTA8h1A4
         vZYpb026186ejXec7lvyB9owXCfQfXg0rqxSVp+G4+2oK1kweFPEqndT5e84yg8ip9tc
         UQwWRMnRNcvD0C2T70XWCKJXIRsPWMeS4jENPSOFIjJN9fVboOEAldXJ+w9ORhHYObNt
         STeqg3DCDT90Fm6gmzEJMOQEe1POMtvWwcBNXmwBO2EptZNrtihznSxFTBVxU2vDCBAC
         io2g==
X-Gm-Message-State: ABy/qLahKMgoi8B3NrOiGIx5WPj6skJzMYCjK8me76MrUo15r0VSzl87
	Y4l12jn3Ges95uytLxAmpmIoi692gSXJwy87
X-Google-Smtp-Source: APBJJlE3jI4OIAYUHOYrTSzvG+G1igVq+vTL06o+0Yg0Dv13FaEG6DMVDexDCoqyfovzfdqL5erMLA==
X-Received: by 2002:a05:6a00:190c:b0:682:4c1c:a0f6 with SMTP id y12-20020a056a00190c00b006824c1ca0f6mr20767482pfi.3.1689675468912;
        Tue, 18 Jul 2023 03:17:48 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k16-20020aa792d0000000b0063d24fcc2b7sm1239023pfa.1.2023.07.18.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 03:17:48 -0700 (PDT)
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
Subject: [PATCHv3 net 0/2] Fix up dev flags when add P2P down link
Date: Tue, 18 Jul 2023 18:17:39 +0800
Message-Id: <20230718101741.2751799-1-liuhangbin@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When adding p2p interfaces to bond/team. The POINTOPOINT, NOARP flags are
not inherit to up devices. Which will trigger IPv6 DAD. Since there is
no ethernet MAC address for P2P devices. This will cause unexpected DAD
failures.

v3: add function team_ether_setup to reset team back to ethernet. Thanks Paolo
v2: Add the missed {} after if checking. Thanks Nikolay.

Hangbin Liu (2):
  bonding: reset bond's flags when down link is P2P device
  team: reset team's flags when down link is P2P device

 drivers/net/bonding/bond_main.c |  5 +++++
 drivers/net/team/team.c         | 23 ++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.38.1


