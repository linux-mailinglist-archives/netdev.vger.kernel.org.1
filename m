Return-Path: <netdev+bounces-23676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3376D1AE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67265281DCC
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA38C0C;
	Wed,  2 Aug 2023 15:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68558474
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:08 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805A04C29
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso6423356f8f.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989626; x=1691594426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EKF8sGJpQJOT2vcGdcO6mcg8t451Wlj13LtRUmKgMUM=;
        b=MfIY1lHnOCCr5Pf53gqV6KKwbSAlrXwNmJSayg0Zf0NH4pGB4UQ9lX9OevEzxNTT2f
         nnnSzwgWWD+UUfUUgk5tyt6sY5Bz/lHANUKloB01KQEldffX79aNeNPDeuNv5h+5tlJL
         lIRFiwxBuNzfm3RhgHp4PIa7xi3DG6e86PC2nGgHGLverkJvvrRBjKWEVnyMTjG8u2N4
         CqERjk/ILgJzkNw1uIKIou18AO2oJtdtif+oeuCNyvU9RVsYemyExybzG2h2UkPtTRrB
         WD1SvIyPxOhp+wQluT+Y9hL/Nfth3K5gTLWHHZm09KLZArTMV/4566t2a65iAU4sncul
         F8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989626; x=1691594426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKF8sGJpQJOT2vcGdcO6mcg8t451Wlj13LtRUmKgMUM=;
        b=XGtGeWnT6u7ycCRyscq2PSfn7k1z1vLqxY2SLe8Hy00eWsW0v1t4E5MAHRxZRR5S77
         sGC5JHzS6urdF2nM1M25He2fI//NjM+BZDJn1TYR47dmCIf4FoXqewvVBj6WUy2WPiqG
         cVFndlJSyEM89ipePt0Eis3GuzZkXsCj4kT470bLxoryA7wgR3aZ1nRJriKGTrL6eqKM
         BJyM6q7DkSq3B10v33gVtUDc6+4dfoBA8J8ac/dbWSF5U9egGj18s/Z3w/8SzKBGf9lH
         IFqG67ZWf5HH4xKYeBD9zBahEner9+jhccSFmDF9K4kvfXY46HC4wUJOCggnSHYfugSa
         +kiQ==
X-Gm-Message-State: ABy/qLZQbiyD5yal84h3bTzZDnviFiQZEoiz3vEt1KVtnvMVl53q65V8
	DVLpfPOQOYw83pP0WWKun+YwL0erg5I7LbyeNvlcDZl0
X-Google-Smtp-Source: APBJJlGb3EQJNOdMzSNVVWOVzCz5nJMMtT/ayY2+eyBq5VCGEYG8b28XlP2Z+5MO+puyiy0KrcS7CA==
X-Received: by 2002:a5d:634c:0:b0:317:5d83:b43b with SMTP id b12-20020a5d634c000000b003175d83b43bmr5135445wrw.38.1690989625844;
        Wed, 02 Aug 2023 08:20:25 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id p26-20020a05600c205a00b003fe15c466f3sm4540523wmg.0.2023.08.02.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:24 -0700 (PDT)
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
Subject: [patch net-next v2 00/11] devlink: use spec to generate split ops
Date: Wed,  2 Aug 2023 17:20:12 +0200
Message-ID: <20230802152023.941837-1-jiri@resnulli.us>
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

This patchset extends the spec so kernel split ops code could
be generated from it.

---
v1->v2:
- see individual patches for changelog

Jiri Pirko (11):
  netlink: specs: add dump-strict flag for dont-validate property
  ynl-gen-c.py: filter rendering of validate field values for split ops
  ynl-gen-c.py: allow directional model for kernel mode
  ynl-gen-c.py: render netlink policies static for split ops
  devlink: rename devlink_nl_ops to devlink_nl_small_ops
  netlink: specs: devlink: add info-get dump op
  devlink: add split ops generated according to spec
  devlink: include the generated netlink header
  devlink: rename couple of doit netlink callbacks to match generated
    names
  devlink: introduce couple of dumpit callbacks for split ops
  devlink: use generated split ops and remove duplicated commands from
    small ops

 Documentation/netlink/genetlink-c.yaml      |  2 +-
 Documentation/netlink/genetlink-legacy.yaml |  2 +-
 Documentation/netlink/genetlink.yaml        |  2 +-
 Documentation/netlink/specs/devlink.yaml    | 14 ++++-
 net/devlink/Makefile                        |  2 +-
 net/devlink/dev.c                           | 27 +++++-----
 net/devlink/devl_internal.h                 | 20 +++----
 net/devlink/leftover.c                      | 16 +-----
 net/devlink/netlink.c                       | 35 ++++++------
 net/devlink/netlink_gen.c                   | 59 +++++++++++++++++++++
 net/devlink/netlink_gen.h                   | 29 ++++++++++
 tools/net/ynl/generated/devlink-user.c      | 53 ++++++++++++++++++
 tools/net/ynl/generated/devlink-user.h      | 10 ++++
 tools/net/ynl/ynl-gen-c.py                  | 20 +++++--
 14 files changed, 231 insertions(+), 60 deletions(-)
 create mode 100644 net/devlink/netlink_gen.c
 create mode 100644 net/devlink/netlink_gen.h

-- 
2.41.0


