Return-Path: <netdev+bounces-23980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4976E684
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3792A1C214A6
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3271618B10;
	Thu,  3 Aug 2023 11:13:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222318AFC
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:13:52 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430581AB
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so451200a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061222; x=1691666022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3CkijGMBJX5Z6XVHPJ6f9Zqaz2mhn/tLQwQh1Vo208=;
        b=FHZT91jsXHLaqmULT2qfWnLCanZ4GdDBWKXMp+LgWYnvw3W6RfdQ4yGm7ryogafLEx
         /sRvbUzMvXZ/qZhGKhCAXcxd4GiwD/pYCRlP1h9fMtAs+ou2W+lPKZztw8ef/3yLy+2C
         f4ojJchWAntxn3CK44gcY+GiAkTGN9DgzHbg2GwOlKgb1ZKFFODFC4RGYLkqO1O7sK1+
         7xXl4WHh6e7NFJLIUEbtLT0lAucekMsWziFo2oGbrJB+i6NcRcuhRVZe0w1HIiSNRny+
         AQ0KCbKIhlv4/e0DGxkybPSp4MPTuEBYgBrFea9ouO9xx64SA7CEI2cKNHHQJgZ/RZF4
         TmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061222; x=1691666022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3CkijGMBJX5Z6XVHPJ6f9Zqaz2mhn/tLQwQh1Vo208=;
        b=HhIbS1N2dk8b2WTV1haDZKtS5u864E86zt4eYZuln4duYuPNk9gMngKL2s8QQPxE6X
         7xi2lbQSCJacCB0T0YIFHRL1qAa4iDxTOeEpPbZJS1jQu8hnfuxzF93DV4fcedQK4y4C
         CrFYKR/0ZyD6hNLiLFrWT4l9O15+g7QoPidhVbkSi+JalZyGaWV/ZMzo/BixWmgBqsDr
         2B59uxQIz93Ls0ms4S8jaMeWH/kXzdanbkPuQuOZYkwFAPffouOL+neBUMNQGxEi4IO7
         Vk0vE/5yaVCyfIN8lITZEof65VwnPWqeuAnJivWNwwD1eVAbqLinn3O4AXrFwraLC5f7
         ddGA==
X-Gm-Message-State: ABy/qLZhnlFKM6XdaXPpovDvcXQmj7zGmHYTKOHCbTTl5MMsI+Djm3Tt
	4yXhMnWjHvpZGKORAfi5ljBvwTg28uM/YjYURe1pX02F
X-Google-Smtp-Source: APBJJlH+9V4XYven1DNwIA5bvrPBK2YtiJ9x57pRtbOcyQzHuUE0XchtpyxDG7WCC7mcZSfxaG8oSw==
X-Received: by 2002:a05:6402:1507:b0:51d:ece5:afd9 with SMTP id f7-20020a056402150700b0051dece5afd9mr7304863edw.21.1691061221689;
        Thu, 03 Aug 2023 04:13:41 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7ccd3000000b0051d9ee1c9d3sm9949710edt.84.2023.08.03.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:41 -0700 (PDT)
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
Subject: [patch net-next v3 00/12] devlink: use spec to generate split ops
Date: Thu,  3 Aug 2023 13:13:28 +0200
Message-ID: <20230803111340.1074067-1-jiri@resnulli.us>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

This is an outcome of the discussion in the following thread:
https://lore.kernel.org/netdev/20230720121829.566974-1-jiri@resnulli.us/
It serves as a dependency on the linked selector patchset.

There is an existing spec for devlink used for userspace part
generation. There are two commands supported there.

This patchset extends the spec so kernel split ops code could
be generated from it.

---
v2->v3:
- reordered a bit to avoid build break, small changes to fix that
- see individual patches for changelog
v1->v2:
- see individual patches for changelog

Jiri Pirko (12):
  netlink: specs: add dump-strict flag for dont-validate property
  ynl-gen-c.py: filter rendering of validate field values for split ops
  ynl-gen-c.py: allow directional model for kernel mode
  ynl-gen-c.py: render netlink policies static for split ops
  devlink: rename devlink_nl_ops to devlink_nl_small_ops
  devlink: rename couple of doit netlink callbacks to match generated
    names
  devlink: introduce couple of dumpit callbacks for split ops
  devlink: un-static devlink_nl_pre/post_doit()
  netlink: specs: devlink: add info-get dump op
  devlink: add split ops generated according to spec
  devlink: include the generated netlink header
  devlink: use generated split ops and remove duplicated commands from
    small ops

 Documentation/netlink/genetlink-c.yaml      |  2 +-
 Documentation/netlink/genetlink-legacy.yaml |  2 +-
 Documentation/netlink/genetlink.yaml        |  2 +-
 Documentation/netlink/specs/devlink.yaml    | 14 ++++-
 net/devlink/Makefile                        |  2 +-
 net/devlink/dev.c                           | 26 ++++-----
 net/devlink/devl_internal.h                 | 20 +++----
 net/devlink/leftover.c                      | 16 +-----
 net/devlink/netlink.c                       | 35 ++++++------
 net/devlink/netlink_gen.c                   | 59 +++++++++++++++++++++
 net/devlink/netlink_gen.h                   | 29 ++++++++++
 tools/net/ynl/generated/devlink-user.c      | 53 ++++++++++++++++++
 tools/net/ynl/generated/devlink-user.h      | 10 ++++
 tools/net/ynl/ynl-gen-c.py                  | 20 +++++--
 14 files changed, 230 insertions(+), 60 deletions(-)
 create mode 100644 net/devlink/netlink_gen.c
 create mode 100644 net/devlink/netlink_gen.h

-- 
2.41.0


