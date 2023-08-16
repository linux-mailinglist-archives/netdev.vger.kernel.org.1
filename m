Return-Path: <netdev+bounces-27919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3EC77DA2C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152271C20F38
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 06:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5CFC147;
	Wed, 16 Aug 2023 06:07:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47D649
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:07:52 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A4A270C
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 23:07:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc6535027aso52241685ad.2
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 23:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692166050; x=1692770850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZ/rkzR/tJxAZz+ef1/e/rmnp7gy4q6o/qFzcO/IfkY=;
        b=fVy6KI0iZB3tmqkNGmZwBTFfkPou4U6pAeHCW407L3uQPb9eQ3bauW/zrQZdsuNZvW
         TvbumiBczmr4QxJ57l5B1mEKSpgFvlO8vbh+7PBLMdqyE+0z8aXdF1zks40T6dm137Rk
         sCxWFUoynubRkUxMCWkB6IgfrnnyZK/pPhDN6frWgMpmt9w0v33PzeyQyY5Vo79jqhi2
         1ov1Gk+Ey0Qe+8QyUHiKqJGigv3QKUl/b+UBjY5SJIdYmXqZqdmW4yhjCuav+oQ7S3xa
         /nAKtRRDNUbgGGy45E60VGWEB5MUBFBM048PHUaWmxG4IlqknAE3Tv7Pd43M47EtU3Eh
         JQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692166050; x=1692770850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZ/rkzR/tJxAZz+ef1/e/rmnp7gy4q6o/qFzcO/IfkY=;
        b=jDUVeCtbPyC8NDD6nIGpmcWktkX6CAgesUL48vznxvgy1mCqFAR4lQTZlHnYfI9kBh
         vhI8/rV1rcwuW+TzblxzZkaB7tuN7rsQazTUtQx+pgTTf9lB08BUae7fpyvWMGF/nB3/
         eC9jrNFim/e1DEiWt3eAX6jeSV6ujKHPBFu1oONM/UjbOjVzqDuddSAit8vbZ+WSJ2MM
         eY2CSa7YBZ52QaUQQ99strBSEwYExLyFZCXrSZadxuWjJkMlS/J8UIRl4qdmLXb6pIuk
         zrIAE1eIpmNpVRfx5W2qfkl0tt0aSjGSlb/ednPRIE0u9MOIu8/rqc4lElQuXGA6ciHe
         6+ug==
X-Gm-Message-State: AOJu0YxUpFAR4crjzBu8d6OuVEOZq29yn+PQLMpSRW/KRwjs+9JS3rgT
	Clh62v78eJEZulGBmSWnNmh7YMSfF8++8XPw
X-Google-Smtp-Source: AGHT+IF1OXMbLw+z+hFXkmEZTV+1PdakbOv1ENFyUAN8s4Q1n9ulzzJQTAY9A+9FiRLr1fY2Z4P5ig==
X-Received: by 2002:a17:902:d203:b0:1bd:f71d:5298 with SMTP id t3-20020a170902d20300b001bdf71d5298mr1001093ply.3.1692166049709;
        Tue, 15 Aug 2023 23:07:29 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902b11600b001bb24cb9a40sm12097090plr.39.2023.08.15.23.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:07:29 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 0/2] ipv6: update route when delete source address
Date: Wed, 16 Aug 2023 14:07:22 +0800
Message-Id: <20230816060724.1398842-1-liuhangbin@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, when remove an address, the IPv6 route will not remove the
prefer source address when the address is bond to other device. Fix this
issue and add related tests as Ido and David suggested.

Hangbin Liu (2):
  ipv6: do not match device when remove source route
  selftests: fib_test: add a test case for IPv6 source address delete

 net/ipv6/route.c                         |   7 +-
 tools/testing/selftests/net/fib_tests.sh | 163 ++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 6 deletions(-)

-- 
2.38.1


