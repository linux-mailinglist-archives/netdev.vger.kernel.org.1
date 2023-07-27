Return-Path: <netdev+bounces-21915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0CC765456
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0908128233B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F715AE7;
	Thu, 27 Jul 2023 12:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91289C8E0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:51:48 +0000 (UTC)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522EC19BF;
	Thu, 27 Jul 2023 05:51:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-686f94328a4so295689b3a.0;
        Thu, 27 Jul 2023 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690462307; x=1691067107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKUZkcvJL17QOmDKTXP9coyYzuMopzWncaWnpRy5ne0=;
        b=lIU0YTLubXeDuJOCWQqR/396c9Xz18GLDnoAiLrDVuLaCg225hoGQhf4ngZT/01nCg
         EpD9xF4ixeELf+VLi2eprgR6RjAxn99Qh48p/yQomH7PmPLdT70hM84m4YgMa6aniZEx
         +18JTVWpzpCSJrjViAtRKeP2Tbugvr7G1PJthjykW9J0h8vlE54LFcTSNALoVYJaA618
         fPk5Vn8MyiTbrerPyA74m5fo/Olp5mD6gWY2AbPGulrvzm0VTNI4xqY0ZxpZuwaApzhP
         IrW4PohHDlpnZB5l0QKDnG8pGwBFyQ4J4QE26rmfTR3w8O4yy7M9a3NDYtO5jg4NH8ek
         pM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690462307; x=1691067107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKUZkcvJL17QOmDKTXP9coyYzuMopzWncaWnpRy5ne0=;
        b=Vi9c9f6apeNWd9ePpFYbj+2uP5fdJ+/XG6AiM9SvdEle0mvsSFUHClI2D6u7wycv+m
         T28qoo/nJ/CTtq5efFRdAO24W7T7cyjBUFt/JoJ7+QK2Abgki6BsYJk18AqO59RsG7vy
         NnWhx9EziNd/6KwO13pHET3wXRGxRe13EpytSaBwM9rZyiWirqPvNkbWYX2G2LfyTG+u
         qGx9t8+tPM4vBSPdmT1Qj4xdtuwbSwdF4WE6GEd/w22Wy4Zq57AAFuvW/k10IjGyQFhw
         0oYsUmF+m3HNAo8mSVUgd/GiVXsRUAA6ubW2CkvbxTnzW8U7+KaEdFY7L0a0Wpi7cNc3
         Rbvg==
X-Gm-Message-State: ABy/qLaIo6Eo+ac1rjumvmP7z+EC6sPn9BsN9/m3CyIWpualIqbvmXfx
	5HwvbP0cJg+GsFB9SmUkBJvyUiH4mrFgInKrpao=
X-Google-Smtp-Source: APBJJlGppAZMnHjs2o+JsPoLbJ9DnrdowTvV/n/60vMFDzXomPQ0LFFObquzFuHURyPvdwk8jKeO7g==
X-Received: by 2002:a05:6a20:7f8b:b0:125:4d74:cd6a with SMTP id d11-20020a056a207f8b00b001254d74cd6amr2478940pzj.3.1690462306613;
        Thu, 27 Jul 2023 05:51:46 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.gmail.com with ESMTPSA id l4-20020a63be04000000b0055386b1415dsm1315048pgf.51.2023.07.27.05.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:51:45 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: edumazet@google.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next 0/3] net: tcp: support probing OOM
Date: Thu, 27 Jul 2023 20:51:22 +0800
Message-Id: <20230727125125.1194376-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
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

From: Menglong Dong <imagedong@tencent.com>

In this series, we make some small changes to make the tcp retransmission
become zero-window probes if the receiver drops the skb because of memory
pressure.

In the 1st patch, we reply a zero-window ACK if the skb is dropped
because out of memory, instead of dropping the skb silently.

In the 2nd patch, we allow a zero-window ACK to update the window.

In the 3rd patch, we check the timeout of a probing socket with
'(u32)icsk->icsk_timeout', instead of 'tcp_jiffies32'. This is more like
a bugfix.

After these changes, the tcp can probe the OOM of the receiver forever.

Menglong Dong (3):
  net: tcp: send zero-window ACK when no memory
  net: tcp: allow zero-window ACK update the window
  net: tcp: check timeout by icsk->icsk_timeout in
    tcp_retransmit_timer()

 include/net/inet_connection_sock.h |  3 ++-
 net/ipv4/tcp_input.c               |  6 +++---
 net/ipv4/tcp_output.c              | 14 +++++++++++---
 net/ipv4/tcp_timer.c               |  6 +++++-
 4 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.40.1


