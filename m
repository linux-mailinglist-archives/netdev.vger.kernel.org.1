Return-Path: <netdev+bounces-37271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57107B482D
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 16:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 31949B20A61
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B05FBFA;
	Sun,  1 Oct 2023 14:51:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD679CA61
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 14:51:08 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E4AD9
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 07:51:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a1d352a86dso175254277b3.0
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696171865; x=1696776665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lwp1oyRF3ChLSaRi+yID2JlXBWV6npwVkf3uYhTAXgk=;
        b=ugT7fowZl64JQSM8ydVJXb3wST7q0KI/469ZyGXZWWmLSpUWPfG9e5SzLPi6Q296Md
         VuWJhHegra8Q8RNGllxUwKFj1J2UH/sJRKz0lAKSQafeJgtwtJoUJQ5+Zpsfm8jRRv2g
         hG8l1QZnQso78FcJo84MYMm6ZRXmuQG0gszKmDCUwYwzHv+Ovx4Bwa0u1LmKVnSpIH9R
         60cG83JT23mGZQCD9GZjUUCFs0Grh0zd1Hv4uxXiYAcG56+SFO307SNMERxgHvNhHvWG
         lm2XJ2lwoVx51tEXuDseXqj1XG8GSzL6LIkGX1e4DDL6gx+6qR9fN4TizQhaU3mEXZkY
         +fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696171865; x=1696776665;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwp1oyRF3ChLSaRi+yID2JlXBWV6npwVkf3uYhTAXgk=;
        b=jHS1usRc3kowEyGNUYU+jiMUVlTctQGksQ3CLbYSfKPl4uyR/cklU8v60efA/99Ayw
         +6ko1tZis6zUfkRDqT2uxZ9xqJ5FsaGnenxY5Yd7it+v4RLBU427+1caTrK68t74+t+d
         YjVfQ88UguNTSgcOykltagCEktsx/Fsn1ioRHBkqR/wTmrw8xVldJz8FCzsH+kMKtHpE
         HxIchs1zOPdlaQbSoGv8ly8vXLQesXlMZRPffnwTDCLzkwL+x1gp/dJSe58ZhP2fFJsb
         uSHLh5ShC3pe56IGu1d6I/og+LShB4ikwzPSgijpu4KBCyCLI94Nwfr6Yj1i24EVwTQD
         hocw==
X-Gm-Message-State: AOJu0YwFkpI6kbqXFCBjl7XyVw3+2PeIMRDRz6qZQx+fyFr6Yp4s0AgX
	KSemhbmv22ksmZ0SQAn4WrwD50ZAHnmOvQ==
X-Google-Smtp-Source: AGHT+IGQ91ncwXhvbSTxr5ubXGiYeZXicVNsWO1Qvt+WmzBvurN7Q66iVZjr4vr12a5ZoNgqpH2rZdPdpaSkdA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:e013:0:b0:d80:ff9:d19e with SMTP id
 x19-20020a25e013000000b00d800ff9d19emr155779ybg.9.1696171864644; Sun, 01 Oct
 2023 07:51:04 -0700 (PDT)
Date: Sun,  1 Oct 2023 14:50:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231001145102.733450-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net_sched: sch_fq: add WRR scheduling and 3 bands
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As discussed in Netconf 2023 in Paris last week, this series adds
to FQ the possibility of replacing pfifo_fast for most setups.

FQ provides fairness among flows, but malicious applications
can cause problems by using thousands of sockets.

Having 3 bands like pfifo_fast can make sure that applications
using high prio packets (eg AF4) can get guaranteed throughput
even if thousands of low priority flows are competing.

Added complexity in FQ does not matter in many cases when/if
fastpath added in the prior series is used.

Eric Dumazet (4):
  net_sched: sch_fq: remove q->ktime_cache
  net_sched: export pfifo_fast prio2band[]
  net_sched: sch_fq: add 3 bands and WRR scheduling
  net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute

 include/net/sch_generic.h      |   1 +
 include/uapi/linux/pkt_sched.h |  14 +-
 net/sched/sch_fq.c             | 263 ++++++++++++++++++++++++++-------
 net/sched/sch_generic.c        |   9 +-
 4 files changed, 226 insertions(+), 61 deletions(-)

-- 
2.42.0.582.g8ccd20d70d-goog


