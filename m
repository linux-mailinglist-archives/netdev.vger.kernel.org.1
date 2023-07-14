Return-Path: <netdev+bounces-17751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59357752F90
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424ED1C21516
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27625A3F;
	Fri, 14 Jul 2023 02:52:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDAE7EB
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:52:10 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B6F2D48
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:52:09 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a1ebb79579so1152581b6e.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689303128; x=1691895128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnlQS3noY/RfWKtReon0Ltmp7lqRCjXLTHuUkj1IuNc=;
        b=RSmgwyrFRx1dH8qwPo2df/uHcCEZvqdix0VlHP47iE0Gz6mYyVEBn4Yf3666J+bQIp
         FV7VPy2bEEun9Rgxi66hI9p7GmzqzX1tA/DnG1mPoLnBpFep1EPYhAK53ZdQuJLa9QBw
         ysCo2mMEH4b4udWh1ArvRtrYCZwWzdi6V1LmCT+fG/7wsamCwOfJqq6RceMBb+W7yUT6
         7jmuug3KLjHMtrk6lHogKt41iyHqVpDKTRjCZ/hzcQvKnTJIjtHz8xZHpupyUye/COZm
         YguMOeIYOZ7vU/H+S99VmUHdC7YNjBpeeuUmBhPrf3G9L3mQl8eLMIuiS+W/UzaiQ5vf
         Bt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689303128; x=1691895128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnlQS3noY/RfWKtReon0Ltmp7lqRCjXLTHuUkj1IuNc=;
        b=RLBMIK+vdrVA7eOmBLYxkJcn0vhwRJGi4A2bnXFdiddTQsr67r7/pnE1pU07HDLa7w
         w/WN7Y9i3l0sgG5k/nkAwMwpUSy023ylnW0Q4v9or6FFXX8uWYOaY4rf/nYFJ3JPlU3h
         XdCU8lRg9SGTxhzi6KMnzYrbLMb9M1MJJqsv4kEDFneFskcZ7jA1V5bsE2W+OG4M+RsK
         bS1U0PGvpMBume9SNQTKqvdI0FCm1Zbp4qpoownCvFfp25gnVQYGpwfxu3dyBGl7Bqdk
         eirY4MFc7OncNpWbRulW2KmVavC6BZ3M+Rhd0RClIpk1hraydkwgOVO78hfKtMq3SR9r
         1UJw==
X-Gm-Message-State: ABy/qLbvYROS5AzFWi1VWmy3wGMM4GeP99UInQaMylIgqodBMyq+mXMk
	WGVQKBv4VcIYprFhFmNbmV2+P1fLeF2tSQ==
X-Google-Smtp-Source: APBJJlEfkwLGpxk4z3s52ozScVrDYDNM515CzH60xV2njfAJ/RJpZEWScLE6iP/6itr61r89ojKoTQ==
X-Received: by 2002:a05:6808:1701:b0:3a1:ed1b:9541 with SMTP id bc1-20020a056808170100b003a1ed1b9541mr4649621oib.40.1689303128522;
        Thu, 13 Jul 2023 19:52:08 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:782f:8f50:d380:ebf:ef24:ac51])
        by smtp.gmail.com with ESMTPSA id l6-20020a637006000000b0055b07fcb6ddsm6347930pgc.72.2023.07.13.19.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 19:52:07 -0700 (PDT)
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
Subject: [PATCH net 0/2] Fix up dev flags when add P2P down link
Date: Fri, 14 Jul 2023 10:51:59 +0800
Message-Id: <20230714025201.2038731-1-liuhangbin@gmail.com>
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

Hangbin Liu (2):
  bonding: reset bond's flags when down link is P2P device
  team: reset team's flags when down link is P2P device

 drivers/net/bonding/bond_main.c | 4 ++++
 drivers/net/team/team.c         | 4 ++++
 2 files changed, 8 insertions(+)

-- 
2.38.1


