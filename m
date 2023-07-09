Return-Path: <netdev+bounces-16289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF674C660
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 18:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8E01C20848
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77FEAD38;
	Sun,  9 Jul 2023 16:14:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85855C96
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 16:14:01 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52DFD
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 09:14:00 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a4062577c0so192778b6e.0
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688919239; x=1691511239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pKNlMWqDYznUvAGWejPHHIg2LL4VA2/8r0XhpwiMXY=;
        b=X/GMix1fSZ+hPSAfh5dPyRSf0q56WWcfTb9F/vbQs/cZ1eGptx8L1U7t4G2q3aTT3Z
         mzLZuvTp/nwfA5zjfjd/1b/TASFwpJW6yzUScnqVLk725jc4MQbeZq1cRravKvGDxLaO
         6G/8VwrKLGtXL2yS+52u6QNmF+PN7RmR31coOm8d0XvA4hmMrDiaoXp9W9ICtRo/J/HR
         U6gIXHugr5ZRFF4S8fwH+b2X6vaS88+OLcDc3bkqrZBFLbMoqvrYz0UwOkJY/3k8/8EB
         Gun5LHp5PWG6/nOGruV2bO5Jw8888FkPJdwl2tPwgAQg+ropFP6Z7D7fM/tEYNX6tAGt
         07Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688919239; x=1691511239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pKNlMWqDYznUvAGWejPHHIg2LL4VA2/8r0XhpwiMXY=;
        b=a0EwVXJYVKkaWwApuwC09qQa1wxP4iJDVwhoLbAAsvgV0GgSloD7ThLx/pdD8t8Z7r
         Df9Q1+C0tY29eTn4cRieXBuPYD5UDEhRzzUIVPlFvynfqvht5aRV3AvWrmPx5URESh3t
         rdy8ASF+QHbuEpkMxKnGLJf/sJyjeF2HH9vWEUi3hVVeAn692TLd9g6HVh2MaWfFbjvy
         sn4/mFM0z0J2X3M3AF9C0wKqvruMVK8LngmWgU2U+j7oQbZT2ZjcXu9p8TMauqRFQnxU
         j70VwusGT41fe0/oJPVa3TvRkrhrQKIIfKZnesWVjGSFjUWUrP2sRepx5wdDq31A8Yxi
         Lnyw==
X-Gm-Message-State: ABy/qLYwgQBOyfIULDMYI1CwLZXYLXWd8W2TVSFmyeaMB6Fhdlj1pRYx
	ePP8aKx/8hiYJJCrdtdQ9dECYjDI2P4pvzUFYHs=
X-Google-Smtp-Source: APBJJlH8OTHRUJ3usFRsESRkMx6bO4WfFJkt99pC/5OU4ySoMClwuDPtzA2+Bh+v8ibX+WVEq3rRIQ==
X-Received: by 2002:a05:6808:2a04:b0:3a1:de65:8403 with SMTP id ez4-20020a0568082a0400b003a1de658403mr5008002oib.1.1688919239485;
        Sun, 09 Jul 2023 09:13:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id w14-20020a056808140e00b003a1efec1a6esm3391617oiv.46.2023.07.09.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 09:13:59 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pctammela@mojatatu.com,
	simon.horman@corigine.com,
	kernel@mojatatu.com
Subject: [PATCH net v3 0/2] net: sched: Undo tcf_bind_filter in case of errors in set callbacks
Date: Sun,  9 Jul 2023 13:13:48 -0300
Message-Id: <20230709161350.347064-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BPF and flower classifier are calling tcf_bind_filter in their set
callbacks, but aren't undoing it by calling tcf_unbind_filter if their
was an error after binding.

This patch set fixes this by calling tcf_unbind_filter in such cases.

v1 -> v2:
* Remove blank line after fixes tag
* Fix reverse xmas tree issues pointed out by Simon

v2 -> v3:
* Inlined functions cls_bpf_set_parms and fl_set_parms to avoid adding
  yet another parameter (and a return value at it) to them.
* Removed similar fixes for u32 and matchall, which will be sent soon,
  once we find a way to do the fixes without adding a return parameter
  to their set_parms functions.

Victor Nogueira (2):
  net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
  net: sched: cls_flower: Undo tcf_bind_filter if fl_set_key fails

 net/sched/cls_bpf.c    | 99 ++++++++++++++++++++----------------------
 net/sched/cls_flower.c | 99 ++++++++++++++++++++----------------------
 2 files changed, 94 insertions(+), 104 deletions(-)

-- 
2.25.1


