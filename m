Return-Path: <netdev+bounces-23254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB8276B716
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B051C20F08
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4572823BC7;
	Tue,  1 Aug 2023 14:19:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6823BC4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:19:13 +0000 (UTC)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A05170D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:19:11 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so9318464e87.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690899549; x=1691504349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNVNvgcLTwvZM2HweEHRS6+OeiW8iPTzLsB19++QEn4=;
        b=m3ScllYw/VEPPxNwW2BiNWIHCE2Wal6OHSuqdirIFTqNgGeEoXyKTk3VyH+AMhWNF8
         W/6d5clGslFHRTmNcCT0X0yFfKIfnRw9Ts8in+TsFs09MfVKrYNdE1PSorLXjZfI8AmU
         rrultAwtxVlmqX6GTaQINiQLIGcxt8N1yaMFUIglVQHFYjwnfmlEHqbDB6kbS5SYhCqW
         c02oADv9nN8cvsRRnEornzQQKaSAx6ExYYbYAS3kl6v2Fo+wVXUyL1tadKpX7aMhMs81
         rv2Ff+tEHvabuknQbVnZYxORCsKE6c9T2mubPbY7lTC1vaqeZ++cnxVnnXCA/74BOgaU
         GSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899549; x=1691504349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNVNvgcLTwvZM2HweEHRS6+OeiW8iPTzLsB19++QEn4=;
        b=GgiIWfmXp4bMye/q5EQitPktfs8SGEcmUH/YTX5reisqp+d1RSDIpC9LrcFfVNcxUt
         36suZ8qpk6JQKUQZm00G3NWVZxaF1BjVHl64mDTVyntx5W3FUT+kI2bq/cemml2EfL2o
         z16w6NRt1ROENsGRdUMPBfTgeXFQwCZeSQaLewqlQSJqV137wadkhR8On1zyDygWjNNc
         8ngDTKpXWEBZ9yrxVf7hOiBCfDlkLHqA8mk9GCJAmf7/HsHMZJZW7Hi/b/wc1BijL03W
         w5CjqWMlKNhK9BY+j47zivp3QX8DKATA/wEGxzd9Z20iWuTI0YAp+7Pnxem1Upd3PHlo
         d43w==
X-Gm-Message-State: ABy/qLYxGI70e9+J4a1xw4gRbN5a+S3zOC7WvNZZ4tbP/NrFm09gxKc9
	0Pm+SlRc7UfiWQu1LesvkG+hazkncYyjHRE3+3H2Rfxf
X-Google-Smtp-Source: APBJJlFZUCikjsKjOiu04F1/zC6SwW1t4drL1NeITnQ97D6W3EHg7M7CPuX16bcPm8zXJm3H614Ogw==
X-Received: by 2002:a05:6512:3445:b0:4f8:5600:9e5e with SMTP id j5-20020a056512344500b004f856009e5emr1921308lfr.47.1690899549356;
        Tue, 01 Aug 2023 07:19:09 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709064e5600b0099b7276235esm7761169ejw.93.2023.08.01.07.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:19:08 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next 0/8] devlink: use spec to generate split ops
Date: Tue,  1 Aug 2023 16:18:59 +0200
Message-ID: <20230801141907.816280-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

This is an outcome of the discussion in the following thread:
https://lore.kernel.org/netdev/20230720121829.566974-1-jiri@resnulli.us/
It serves as a dependency on the linked selector patchset.

There is an existing spec for devlink used for userspace part
generation. There are two commands supported there.

This patch extends the spec so kernel split ops code could
be generated from it.

Jiri Pirko (8):
  ynl-gen-c.py: fix rendering of validate field
  ynl-gen-c.py: allow directional model for kernel mode
  devlink: rename devlink_nl_ops to devlink_nl_small_ops
  devlink: add split ops generated according to spec
  devlink: include the generated netlink header
  devlink: rename couple of doit netlink callbacks to match generated
    names
  devlink: introduce couple of dumpit callback for split ops
  devlink: use generated split ops and remove duplicated commands from
    small ops

 Documentation/netlink/specs/devlink.yaml | 14 +++++-
 net/devlink/Makefile                     |  2 +-
 net/devlink/dev.c                        | 27 ++++++-----
 net/devlink/devl_internal.h              | 20 ++++----
 net/devlink/leftover.c                   | 16 +------
 net/devlink/netlink.c                    | 35 ++++++++------
 net/devlink/netlink_gen.c                | 59 ++++++++++++++++++++++++
 net/devlink/netlink_gen.h                | 33 +++++++++++++
 tools/net/ynl/ynl-gen-c.py               | 12 ++++-
 9 files changed, 163 insertions(+), 55 deletions(-)
 create mode 100644 net/devlink/netlink_gen.c
 create mode 100644 net/devlink/netlink_gen.h

-- 
2.41.0


