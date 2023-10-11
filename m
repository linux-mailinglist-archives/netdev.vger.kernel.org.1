Return-Path: <netdev+bounces-39810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66157C4890
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC05281F1B
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30EFCA5F;
	Wed, 11 Oct 2023 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxuN+fla"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669EC2EB
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:44:13 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA189D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690bd8f89baso4917452b3a.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696995851; x=1697600651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qou2Xi0iRC4/xhndQ2mmgbtUDHApacfhk0mMbTXCXY=;
        b=dxuN+fla4ZRQ7k11wm/7zjis+F+8wWbGCgaPNZ4JIsEoDXtRZLHxEy+bZplR2wH0Sm
         Mt09FVCVE3drzRUyDuhzueofShymjEU9JI1iJX6TO0cHFO6PdZ1CGBA9dGR3t9rsiWpC
         vhNRmgf44UN142G/dhcJ9vPTM9iGZ9eeZF9t/Xacy3TQJ0b9wS8B8DQPEMvA+G1JI22m
         VSmYcvpGSKB8URzYmZQR36u8Qvc1BRCReGL8JH9v5mjvez/Dr3MRPmfO9q0QTx8XVeiy
         qEUvS7sURDM33u6nyXWGssEop6241Jyluaefp1Eyy/TMySDwEQSp0OW77K2m4K7ubxKI
         DXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696995851; x=1697600651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Qou2Xi0iRC4/xhndQ2mmgbtUDHApacfhk0mMbTXCXY=;
        b=BAymrvY4bbTaQyDgihQl6MRHV3d6EVNxgNtsZTxXc3a0+InYZaZQ2qRbpLcuVdhHCe
         20foImxJisFo/kbRJQvbD8iAfWmzIDMYeUXfryVjEc3AEH+suJcNkS0c1vxiGdjcwIV0
         kBYgJLchAvO+Zg99JOmR/gDjZbxPFnVEiCYJVSFvwvRwNHBkrLTnjpcr1fyzF2G38PgS
         CotIXD620a5VZiJ3vfZO6UzKyOwwWujlb28jYMJCAKexhZrrh9tDRdStnxyr0OLgYPNf
         WW6CrOGawAE/ivvM44kk3I7KWkHgQh2QRBYBIuDclSPs2by3u1HxiMzOF5rcq8He2R4y
         Vlag==
X-Gm-Message-State: AOJu0YxWedUvF1DGuvdBn+DIXSTOvkPsYObdkylsyLk1o5Qz4G4U8aEX
	VSU5/nG7RbkxKUaWPc1pr0le8AQQK+zySQ==
X-Google-Smtp-Source: AGHT+IETQeg4LGXPttUw1pjj6jgsrPmkurw7I9GSftV80hwfy8cWX8vel1PI3XCZuc9FJJcQoJ6xHw==
X-Received: by 2002:a05:6a20:6a28:b0:15e:1351:f33a with SMTP id p40-20020a056a206a2800b0015e1351f33amr20765174pzk.47.1696995850866;
        Tue, 10 Oct 2023 20:44:10 -0700 (PDT)
Received: from wheely.local0.net ([1.128.220.51])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b0058a9621f583sm7873656pgn.44.2023.10.10.20.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 20:44:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	"Eelco Chaudron" <echaudro@redhat.com>,
	"Ilya Maximets" <imaximet@redhat.com>,
	"Flavio Leitner" <fbl@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH 3/7] openvswitch: reduce stack usage in do_execute_actions
Date: Wed, 11 Oct 2023 13:43:40 +1000
Message-ID: <20231011034344.104398-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011034344.104398-1-npiggin@gmail.com>
References: <20231011034344.104398-1-npiggin@gmail.com>
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

From: Ilya Maximets <i.maximets@ovn.org>

do_execute_actions() function can be called recursively multiple
times while executing actions that require pipeline forking or
recirculations.  It may also be re-entered multiple times if the packet
leaves openvswitch module and re-enters it through a different port.

Currently, there is a 256-byte array allocated on stack in this
function that is supposed to hold NSH header.  Compilers tend to
pre-allocate that space right at the beginning of the function:

     a88:       48 81 ec b0 01 00 00    sub    $0x1b0,%rsp

NSH is not a very common protocol, but the space is allocated on every
recursive call or re-entry multiplying the wasted stack space.

Move the stack allocation to push_nsh() function that is only used
if NSH actions are actually present.  push_nsh() is also a simple
function without a possibility for re-entry, so the stack is returned
right away.

With this change the preallocated space is reduced by 256 B per call:

     b18:       48 81 ec b0 00 00 00    sub    $0xb0,%rsp

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/actions.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 7a66574672d3..be15ef693284 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -349,11 +349,18 @@ static int push_eth(struct sk_buff *skb, struct sw_flow_key *key,
 	return 0;
 }
 
-static int push_nsh(struct sk_buff *skb, struct sw_flow_key *key,
-		    const struct nshhdr *nh)
+static noinline_for_stack int push_nsh(struct sk_buff *skb,
+				       struct sw_flow_key *key,
+				       const struct nlattr *a)
 {
+	u8 buffer[NSH_HDR_MAX_LEN];
+	struct nshhdr *nh = (struct nshhdr *)buffer;
 	int err;
 
+	err = nsh_hdr_from_nlattr(a, nh, NSH_HDR_MAX_LEN);
+	if (err)
+		return err;
+
 	err = nsh_push(skb, nh);
 	if (err)
 		return err;
@@ -1477,17 +1484,9 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			err = pop_eth(skb, key);
 			break;
 
-		case OVS_ACTION_ATTR_PUSH_NSH: {
-			u8 buffer[NSH_HDR_MAX_LEN];
-			struct nshhdr *nh = (struct nshhdr *)buffer;
-
-			err = nsh_hdr_from_nlattr(nla_data(a), nh,
-						  NSH_HDR_MAX_LEN);
-			if (unlikely(err))
-				break;
-			err = push_nsh(skb, key, nh);
+		case OVS_ACTION_ATTR_PUSH_NSH:
+			err = push_nsh(skb, key, nla_data(a));
 			break;
-		}
 
 		case OVS_ACTION_ATTR_POP_NSH:
 			err = pop_nsh(skb, key);
-- 
2.42.0


