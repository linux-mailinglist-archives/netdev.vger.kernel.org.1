Return-Path: <netdev+bounces-31639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC78578F2DC
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 20:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4322816A3
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE45198AE;
	Thu, 31 Aug 2023 18:47:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA28F57
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 18:47:58 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7EDE5F
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:47:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcf2de59cso136525566b.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693507675; x=1694112475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=otamgPRS7Hkx5IKNXkHinQsi5qi2Cf9JHp7MAFPszyk=;
        b=feHFvpJ20IOe8HR3kp4D5CSQ4HOeC0j2On2gZrWVA/ofX/PCJpiamHWF8fbf6qBDo8
         qdl9+lPkhYI9u/seEE0HMC5gRCSznmiSn5FfJ4M+QOb1Bq0V/lWuwtOgLYj305EUYfVb
         ve8Uvr6m4fn8ooJux6ZxlteTMkv8j+L8auolYQGZtaLVj2YExPZPFR3vqJ+KH7T8Rd3F
         SAJ5G0aWBWFoIdQg/HA+RE59Syw5wSL3mL2fbPH9+talD0fO5xWKi02QdgKPE/aihX2+
         7fjv2rpreXygUtP8mP1l+vuFv3dQNGjPAMeCRQ+5BqBTgLtcScObbHtUsp2NGl0bXiCw
         UdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693507675; x=1694112475;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otamgPRS7Hkx5IKNXkHinQsi5qi2Cf9JHp7MAFPszyk=;
        b=hMKFpx0dfWDumKZkJV1GKMzj3C5T6AeflIlDBrzRpdF44Dqg/VYrDshEg+4c8tROvT
         tvTfiMbV5ap37eQe+0liLhRgw/kd9SMD0erfrZiwzJBCg/QD4cA0FcKwFkr75hTJRTcr
         MFy9mTLg845dn+7bMQQFc9zQ7Dznpufc+d29zZdU6uhv/WazdKhwQvGXQvEvr1GZlENF
         8XaV28zTiEREA+pPJXMlvmJaGJyN1SrrRsWvdwyD/jNbJNjgK3FOGFZwBRUdTlJOC3Dw
         W1FpEd8EcPvmuel00dPvY6ZhbYNbdpFzAbip1JlU/Y5InPR1MIMEmmIXmFAHjTV9spWZ
         8iMg==
X-Gm-Message-State: AOJu0Ywirpsl7xDKIiAyLYDByJUIApW+3Fx6pOu4Wq2+8bDe42jDqikt
	WsRT9yrtUP/m7dufWZ8rythVf9uBc45pZ4Q76GScOM+77Vebg73pfRz1OA==
X-Google-Smtp-Source: AGHT+IEEGDvG/frPq+NqgmrUJdeV0Tjp2O3eaeoOUwN5ug7HY6Z5OIJss6j569812PiAyYP3Y0yEp/UdwUQmKwFUz7Q=
X-Received: by 2002:a17:907:2bc9:b0:9a1:f449:ebd5 with SMTP id
 gv9-20020a1709072bc900b009a1f449ebd5mr148003ejc.33.1693507675431; Thu, 31 Aug
 2023 11:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jordan Rife <jrife@google.com>
Date: Thu, 31 Aug 2023 11:47:44 -0700
Message-ID: <CADKFtnSPTQGLxfpn38cfwTPk=JY-=Ywne2DFoRkq03m-eKo17Q@mail.gmail.com>
Subject: Stable Backport: net: Avoid address overwrite in kernel_connect
To: netdev@vger.kernel.org
Cc: dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Upstream Commit ID: 0bdf399342c5acbd817c9098b6c7ed21f1974312
Patchwork Link:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=0bdf399342c5
Requested Kernel Versions: 4.19, 5.4, 5.10, 5.15, 6.1, 6.4, 6.5

This patch addresses an incompatibility between eBPF connect4/connect6
programs and kernel space clients such as NFS. At present, the issue
this patch fixes is a blocker for users that want to combine NFS with
Cilium. The fix has been applied upstream but the same bug exists with
older kernels.

-Jordan

