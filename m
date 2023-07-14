Return-Path: <netdev+bounces-17862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD1C7534CE
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7F21C215C5
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F2C8E5;
	Fri, 14 Jul 2023 08:13:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419FF747B
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:13:52 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8F83AA3
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:13:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2637ab3d8efso893172a91.3
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689322431; x=1691914431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suV7GL1gfgmPdI7qRLEZh8jTT4IwViKzfDA1lcidgHw=;
        b=ldInEi7x9eDn3B4AeO6deCYQZA2FU7JoEs3Yl5cR5EzMUEumyUfET1cRpf6IsTByJd
         WV4Kx3I2lSq+CSPbJi6Pi/rRYaqZu3kjyKfPJpEjrg1hjJ4OLzDimiu7cX0qoLLRAlF/
         v9GDDYCe4iEEKIrBlWgzuErLOzZNPVzlhXjBhvxsCdOfgRahYws2YR+1HnzfILyDSuSb
         OGLFErtyAbM9O6mymHX0VIn5Kg8+r6jFaAVuCL9Z9myxUm1aWccRXmW+4DXZOG+jOCcn
         noPKxIq04BCg8ZqPxhW0Yh75gfvxHzYGUPrKeerFs2FcR/JgOvJGQCJEVsrFeVI5sSdS
         sFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322431; x=1691914431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suV7GL1gfgmPdI7qRLEZh8jTT4IwViKzfDA1lcidgHw=;
        b=iwNy5nFOcZJMxOpMvxDpoB0AZ8woFnyQX6xnHUIB6a3bCyjAhdQZxsI4eBmmGj9TcS
         xvpz5Lee4l1+jJXl1UQk7PqbviNj3eyZtxu73qEvQWovl6BEqCJpslW0WogDDSQprzy2
         tn6TqAjkpbdyL2oMIRxFNFN3VNDr+ubKPSPr6jtB4WKm+6pcqdP0GBJmquA1deJwO0Px
         AcncM1/Z2v7th7Sdxn/w9tIq/le9VsBmet4i2/DulCIf5+ZTfrFiNoKN6dFx1ZqheZ9z
         evaUk2+lAFv0H4+K4gICkxgLl3x62BNA1UEmD9wbzvciJGVuz0Gq0NbgMPH1pMJ10fqI
         hC/Q==
X-Gm-Message-State: ABy/qLbrS8MGnIukCiWSI8SdoiRjlCl3Syrl4TGSsN40/Ns3f0X1xzzl
	DQc37WWUag3c7derEj2j5kb0iwYkZzoJmQ==
X-Google-Smtp-Source: APBJJlEUDYKNeoEc6Vn5YAbiBcrYoJkQyT71sDxmqgEl+HHZo6QbjigjHtzscPPEpbPYmCFLDQZ/FA==
X-Received: by 2002:a17:90a:ac0f:b0:264:97a:2ba6 with SMTP id o15-20020a17090aac0f00b00264097a2ba6mr2489771pjq.7.1689322430781;
        Fri, 14 Jul 2023 01:13:50 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:782f:8f50:d380:ebf:ef24:ac51])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b00263ba6a248bsm715268pji.1.2023.07.14.01.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:13:50 -0700 (PDT)
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
Subject: [PATCHv2 net 0/2] Fix up dev flags when add P2P down link
Date: Fri, 14 Jul 2023 16:13:38 +0800
Message-Id: <20230714081340.2064472-1-liuhangbin@gmail.com>
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

v2: Add the missed {} after if checking. Thanks Nikolay.

Hangbin Liu (2):
  bonding: reset bond's flags when down link is P2P device
  team: reset team's flags when down link is P2P device

 drivers/net/bonding/bond_main.c | 5 +++++
 drivers/net/team/team.c         | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.38.1


