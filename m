Return-Path: <netdev+bounces-24969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7993F772661
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0A81C20B61
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E6107AD;
	Mon,  7 Aug 2023 13:47:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBFB101FE
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:47:14 +0000 (UTC)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80758E54;
	Mon,  7 Aug 2023 06:47:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1bc65360648so13655445ad.1;
        Mon, 07 Aug 2023 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691416032; x=1692020832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHjnjhn66GHqvmsQCnTfRAtBD+5kqcK4Ntmnuyxsalk=;
        b=ZrXwX111qiLzoDQyeO5Rvds+3wNUtAglbuDiAhYUp8a8Fjyo9NpZ99p0Wd010QuWEy
         LLsrHOOyfd05K+Cd/4bPnAlm4CxhV9tEo8TsdUP5FIChQXO4KWDXlnLT4Nqt4p8bm2Zq
         1ViDkc3VLCv6p1IOdIvuikHH1YXO473ONRvh6+z9Na9tjmfqgP88mCdYNqahufgcp3/N
         RyLwPxzWT67degtjoHXBI8E4HUCPvqRPSzwQZymQlHvSMNEZ0TaXukTO76Q6+YD+JptU
         erCu6Eee3l6FkBAjJRHO/1VsIMHtve5NuQuwiwfrSbXyTQLD1/aNipcQ0TfXFubxNODP
         /TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416032; x=1692020832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHjnjhn66GHqvmsQCnTfRAtBD+5kqcK4Ntmnuyxsalk=;
        b=CH8AjyRbHcjqTxnH5piVapMEqi1C4apC4Oc/4srcWyxx8bChEIO0PA53nbGO3gEbLp
         v5eTKbnrg0XcwSEShmItEeJgaWBl5z2GbtlFRdrKeAcIbE3BzOorPP5LpP9PLThAweSd
         0D8Ak/L377ejWjRJPtrx9Uo3z3ceKR26vIk+HA3hrq5epkjf5rthn+R8ip8yD9rYeAEi
         uJRZyscA1nm95kKrBBR2MCvTrUw/+Asp7aVVSX5Yu5KFwhu4RDkC9wnqcV6sZ9qjJaJ9
         V1jPsO+Dg0FFjocF0hwNXvLOz2fGWqzHdjpOZnli22OMVvSRU0Rjf6Okk6zwUORIwFkG
         9QkQ==
X-Gm-Message-State: AOJu0Yxm30Dzzv7gwLBX8+f8G6Piho2VX5151AX+vY4SMXFBIpOTkzVg
	DlWo0/St0qp3a1srTod1Nfg=
X-Google-Smtp-Source: AGHT+IFnLdewWO2EhW6p0AgIUYRALtoZx5p/sp/w3CoJ/kXrlgD4/j1xpgelq9rQUpvtm8HmaPK9LQ==
X-Received: by 2002:a17:903:18c:b0:1bc:532f:1bf8 with SMTP id z12-20020a170903018c00b001bc532f1bf8mr9852432plg.45.1691416031727;
        Mon, 07 Aug 2023 06:47:11 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001b54a88e4a6sm6912097plt.51.2023.08.07.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:47:11 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: edumazet@google.com,
	ncardwell@google.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v2 0/3]net: tcp: support probing OOM
Date: Mon,  7 Aug 2023 21:45:44 +0800
Message-Id: <20230807134547.2782227-1-imagedong@tencent.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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

Changes since v1:
- send 0 rwin ACK for the receive queue empty case when necessary in the
  1st patch
- send the ACK immediately by using the ICSK_ACK_NOW flag in the 1st
  patch
- consider the case of the connection restart from idle, as Neal comment,
  in the 3rd patch

Menglong Dong (3):
  net: tcp: send zero-window ACK when no memory
  net: tcp: allow zero-window ACK update the window
  net: tcp: fix unexcepted socket die when snd_wnd is 0

 include/net/inet_connection_sock.h |  3 ++-
 net/ipv4/tcp_input.c               | 16 ++++++++++++----
 net/ipv4/tcp_output.c              | 14 +++++++++++---
 net/ipv4/tcp_timer.c               | 10 +++++++++-
 4 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.40.1


