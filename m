Return-Path: <netdev+bounces-44789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CB07D9D6F
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B63C1C210FD
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87238BB7;
	Fri, 27 Oct 2023 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pW40OyPg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE51381C2
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 15:50:48 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5993B8
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:50:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9de3f66e5so17714735ad.3
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698421847; x=1699026647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPnveosrPilkHRkSjG6kX2zIE5x/3oY3eggz2nhjW5o=;
        b=pW40OyPgGJ/aj+St3J1x/fQSvXq+khjOfPlvGLkAWUcokkiJEEtIZ41BSYSLKP32uT
         q0qsNgNegyexjI2zR96UrB71K2XWn95FsdXV9TpM2y3kRTEuuYXYwifPj/yA9tnTUFEZ
         wEvzL/o0QqC/5CYvoN3hFCa7NopGni2DO9lpvTCn3H+j0hIPXRHWR2aI+osKRgBUcLBZ
         ct4+wyx3JI7ij3amT/SNe6B1G5zCWcHLmTLAQVRkqaW3WzeufmrWEAQLo8SAbN1VISVs
         EvmkRJXzbyM9iQHVhl4q49x/n2gbd3NqLdFNC4dZKbsRLJM2ctr8AZ989B1dP932itoD
         VbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421847; x=1699026647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPnveosrPilkHRkSjG6kX2zIE5x/3oY3eggz2nhjW5o=;
        b=JZM1U3p3Od7OwUj4d3BcCwtpvALh8ulTqu/bTTAKaHrE+Qaq30Gl54BL/wzVyhMUeE
         HusH3giI/SpcO0xXDFlSNqgUBj6TPJ2GK/n2NLIhqV/j1F3mLBzzEQ3lvRZDLJ5MnwMJ
         jFyV3l9c0BThKRJYjLWfyiZ0UIt03jLJzIH73g88wn3Tp6q18YT6Dbz1T8AwhfymEEeB
         JCa2Q2o2sTp1wQ38Yd1xlZNAUqh973g7vAokqQ4JkQ0NCZtKs+PbT9VL81J2V/ahn4Hf
         ocapuCKLZiumUDSoEixASlJwSS+7neZOFQNyou4N0Lke29kyEZBPvWK/TNLfhwMxiuGO
         zFsw==
X-Gm-Message-State: AOJu0Yy2nmycb59oRwUgqUoF6m4UuSCeN1ZY64i7XlCglNo/g0cX+Pq6
	fpEzEp6lhnLeVHbK0ijONPz2ryJ0JdFylo99LYStWSN9
X-Google-Smtp-Source: AGHT+IFfRkuRbNaxr9Whmn9roy+LTpV6fesuuubbjMiAfUg8tgvsBBXugMlu3amgPy8YiiGCk8vpKw==
X-Received: by 2002:a17:902:e84c:b0:1c5:d0ba:429 with SMTP id t12-20020a170902e84c00b001c5d0ba0429mr3470989plg.4.1698421847206;
        Fri, 27 Oct 2023 08:50:47 -0700 (PDT)
Received: from localhost.localdomain (S0106e0553d2d6601.vc.shawcable.net. [24.86.212.220])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f54f00b001c726147a45sm1730224plf.190.2023.10.27.08.50.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Oct 2023 08:50:46 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	vinicius.gomes@intel.com,
	stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next 0/3] net: sched: Fill in missing MODULE_DESCRIPTIONs for net/sched
Date: Fri, 27 Oct 2023 08:50:42 -0700
Message-Id: <20231027155045.46291-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().

Fill in the missing MODULE_DESCRIPTIONs for net/sched

Victor Nogueira (3):
  net: sched: Fill in MODULE_DESCRIPTION for act_gate
  net: sched: Fill in missing MODULE_DESCRIPTION for classifiers
  net: sched: Fill in missing MODULE_DESCRIPTION for qdiscs

 net/sched/act_gate.c       | 1 +
 net/sched/cls_basic.c      | 1 +
 net/sched/cls_cgroup.c     | 1 +
 net/sched/cls_fw.c         | 1 +
 net/sched/cls_route.c      | 1 +
 net/sched/cls_u32.c        | 1 +
 net/sched/sch_cbs.c        | 1 +
 net/sched/sch_choke.c      | 1 +
 net/sched/sch_drr.c        | 1 +
 net/sched/sch_etf.c        | 1 +
 net/sched/sch_ets.c        | 1 +
 net/sched/sch_fifo.c       | 1 +
 net/sched/sch_gred.c       | 1 +
 net/sched/sch_hfsc.c       | 1 +
 net/sched/sch_htb.c        | 1 +
 net/sched/sch_ingress.c    | 1 +
 net/sched/sch_mqprio.c     | 1 +
 net/sched/sch_mqprio_lib.c | 1 +
 net/sched/sch_multiq.c     | 1 +
 net/sched/sch_netem.c      | 1 +
 net/sched/sch_plug.c       | 1 +
 net/sched/sch_prio.c       | 1 +
 net/sched/sch_qfq.c        | 1 +
 net/sched/sch_red.c        | 1 +
 net/sched/sch_sfq.c        | 1 +
 net/sched/sch_skbprio.c    | 1 +
 net/sched/sch_taprio.c     | 1 +
 net/sched/sch_tbf.c        | 1 +
 net/sched/sch_teql.c       | 1 +
 29 files changed, 29 insertions(+)

-- 
2.25.1


