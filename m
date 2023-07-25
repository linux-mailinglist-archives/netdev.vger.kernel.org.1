Return-Path: <netdev+bounces-21102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DB276276D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A701C20FA3
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805227718;
	Tue, 25 Jul 2023 23:35:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19E8462
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:35:21 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6D82116
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:35:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1851c52f3dso1370548276.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690328119; x=1690932919;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IT1myyERRAmr27U+7g0iRlpBPjnAFzNkYKFQXXIj9MU=;
        b=GFY7b+i8VF12uUvgZ3Mvi+viJMe4nep1yoWNltDDL4puMZIRLNwz+qd6VoOGfooKSJ
         35K+JkWLYgcn67TQ6qfKnBti+ldqmVfMYJdSuUtI16CeGeiFxChUtiC2X46q6TpZPFQ4
         i2lGCqdMd4iwIf3xkeSmuMve+05a9GMMoRWIEby41JtjZB/AXPfSvxxs8//i3NVxuoBF
         kBpyW2pf3ScdKRErmiwYT3eT+TwGWXztzpsOIm+VNTLZGlE5PCacH2TtjvA1rnrar9We
         YgIW5qZwj+OsCeSjkVfeQnNuhmEMVtJdo7ywHA84Ctnj/QhgDrlvXS4pZW8ZIQZV7nNQ
         8AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690328119; x=1690932919;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IT1myyERRAmr27U+7g0iRlpBPjnAFzNkYKFQXXIj9MU=;
        b=Fulrcgy5gm4Lns6hL3DIxnRXM87XvkztUgVdmKm3B6P1lNmR9N/fsJ0T4UNZ6+xKP3
         OdgJkk4R2r0gjpBISp/WltoogLVVGAkfsgZUqgRMoYcD3Q2x4/3+CUKlO5nS0NPoy5pz
         Bswy10Hzs3dw7+nMdtbfIvaE6rf72CcLJ7T8nY81ipeWhGZc3QoSfoY6T76QLpZd27z5
         EGIK6KoWbm1HfMQjc4CjXZrrtDG+4MdUFtkG+21jDXJ00ucgxY7rRNx8VX2UKJzIp/pF
         MWX5ywZtEBtLM56ivmH2ZUXWsZk2K0MQKKURET385e6wrjbyiAQrThkuJEWnxxblkP8S
         CLjg==
X-Gm-Message-State: ABy/qLYqZ3hOt4RzklpMjeWgpIO06xx4Fq+Ezk3uWUt3XDID+Buv5c1i
	yoMJXlowgLmS8uedNC0k/hgM43lrL2JHp7knScAf9k7CdwIkXPABJZdq2h3vK5NeLkk4IW9x/Do
	4S2bilM0zX26yH/jJwt+s37Ktyp38fGc343yTFRQxRcxgBSBHv2DyhQ==
X-Google-Smtp-Source: APBJJlH3fxLJXYqNIu4acPGDRQoym4wUkZkJVGOe97KxYJWc2YWt5RwQ0qNOYQoVdJFL6LxSt3tCRwg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:28d:b0:cb6:6c22:d0f8 with SMTP id
 v13-20020a056902028d00b00cb66c22d0f8mr3314ybh.4.1690328118690; Tue, 25 Jul
 2023 16:35:18 -0700 (PDT)
Date: Tue, 25 Jul 2023 16:35:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725233517.2614868-1-sdf@google.com>
Subject: [PATCH net-next 0/4] ynl: couple of unrelated fixes
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

- spelling of xdp-features
- s/xdp_zc_max_segs/xdp-zc-max-segs/
- expose xdp-zc-max-segs
- add /* private: */
- regenerate headers
- print xdp_zc_max_segs from sample

Stanislav Fomichev (4):
  ynl: expose xdp-zc-max-segs
  ynl: mark max/mask as private for kdoc
  ynl: regenerate all headers
  ynl: print xdp-zc-max-segs in the sample

 Documentation/netlink/specs/netdev.yaml |  5 +++--
 include/uapi/linux/netdev.h             |  4 +++-
 tools/net/ynl/Makefile                  | 10 ++++++++++
 tools/net/ynl/generated/netdev-user.c   |  6 ++++++
 tools/net/ynl/generated/netdev-user.h   |  2 ++
 tools/net/ynl/samples/netdev.c          |  2 ++
 tools/net/ynl/ynl-gen-c.py              |  2 ++
 7 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog


