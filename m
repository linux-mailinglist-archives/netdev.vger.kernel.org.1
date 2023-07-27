Return-Path: <netdev+bounces-21984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A67658A9
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E9A1C2157D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4246B18035;
	Thu, 27 Jul 2023 16:30:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C019896
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:30:07 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7FA2D4B
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:30:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583a4015791so11517937b3.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690475405; x=1691080205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8C8WN8g4V3DRA6OM+WF8phKoBb7MuO1zg5ar7S8uBQ=;
        b=1CNPok2Ol/TFM4viHAeLfi+YN0MPjQDkIB3n6AJSfe6GguAQAiXt8LgLsk3/trE03g
         aKl+chZzpthEKoBmmQttsYSSUfKFCnTVaSMHIO8W87icnijfVFN5pV9f+8adf0X/aAZX
         lcP2a5ThhYdZQGhHv+40DHQJvD9Z0aHUC/tHCpdFhzO8DvAmHwPlCMYmDCt3z+diUv3P
         SzqZlQbAWdwcAAdooiHaohUFczHh0xpRrjJ3V0BuDQIY95Uf1n+kqEWQ23j1h76DqA0U
         UnO/iO55Ah04NLCTc9+HrYzU7pycBlV0OyXMEmKg0idEQ8vl0YCT5Z6c1V4jeTBlz53d
         U2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475405; x=1691080205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8C8WN8g4V3DRA6OM+WF8phKoBb7MuO1zg5ar7S8uBQ=;
        b=kI2VOvoEWmSxVh3AYZNwLrRRXU8Fcea+mU74MCtDfvXlPF+/CXwVi3yXt6XXAwyywJ
         q8lh/ywrPG6EjdCfZlj9ubkiK6yGSoKxZCW1GVRcc/uWNL5bjGHbODm5SzswoYRPto70
         AKK/dPQrS7T5lA7yp01PEqY1un/1OE0LhwF0eUp28HndIXVvYaKZW2nj+SeekoS2fsAW
         7cKVY8qIg3yIzHQa1aSoz5C0tOIZvPvsmwroQF/rplZA9SJNSyVzL0FucemEO3xM7MuM
         6UtUMftfpq46PbO4R5pwdNV31MQFpAHOPHiGRGmsCk66lAEaSA5gvApxJ/uLfGprIIVn
         Joig==
X-Gm-Message-State: ABy/qLYkkTP5ePWX5XddlofK4bY6bMijvbjJ0wnTkwjBrfmWaTWz2Vqr
	q8sONHo4U4/rp3Ys4Fzb6jN68MzqNWQlxtsVVuQiC5jZb+s4eFjhBU4eCGiaY9etcMk6x/KnK+V
	U9TA0/VWdNxWQOBm6IHr4EBklMNGFBZy2DLN/WHgRs4C8whfkqBk6cA==
X-Google-Smtp-Source: APBJJlHtV/iZz6Y8lPZOk32gxC4zMWUL66fza84RzqSVzJLkvxjEGOJD9lt0u19pYsRoZ78iy2KQ8ck=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:587:0:b0:d10:dd00:385 with SMTP id
 129-20020a250587000000b00d10dd000385mr37998ybf.0.1690475405351; Thu, 27 Jul
 2023 09:30:05 -0700 (PDT)
Date: Thu, 27 Jul 2023 09:29:58 -0700
In-Reply-To: <20230727163001.3952878-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230727163001.3952878-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230727163001.3952878-2-sdf@google.com>
Subject: [PATCH net-next v2 1/4] ynl: expose xdp-zc-max-segs
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Also rename it to dashes, to match the rest. And fix unrelated
spelling error while we're at it.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/netlink/specs/netdev.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index e41015310a6e..1c7284fd535b 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -14,7 +14,7 @@ name: netdev
       -
         name: basic
         doc:
-          XDP feautues set supported by all drivers
+          XDP features set supported by all drivers
           (XDP_ABORTED, XDP_DROP, XDP_PASS, XDP_TX)
       -
         name: redirect
@@ -63,7 +63,7 @@ name: netdev
         enum: xdp-act
         enum-as-flags: true
       -
-        name: xdp_zc_max_segs
+        name: xdp-zc-max-segs
         doc: max fragment count supported by ZC driver
         type: u32
         checks:
@@ -83,6 +83,7 @@ name: netdev
           attributes:
             - ifindex
             - xdp-features
+            - xdp-zc-max-segs
       dump:
         reply: *dev-all
     -
-- 
2.41.0.487.g6d72f3e995-goog


