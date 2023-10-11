Return-Path: <netdev+bounces-39811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2D7C4891
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5241A1C20CCE
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96942CA57;
	Wed, 11 Oct 2023 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVcXL7kS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23744354EB
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:44:20 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA7692
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:19 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7c011e113so17542297b3.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696995858; x=1697600658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC6KbeW6ZXTkOADgcyHrxsp1uDrAyBKZbdYvTZmeLb4=;
        b=HVcXL7kSXkIP/fQXXkbvkO70Bqbp3BOWOYu889GVmMtiOYeaS7UbsNjBQKm/ebhGiS
         Lni2Nockd18eywhEHPkgUYq1B5vZ/DqFeNAFfE55qh5u5D/21/dQu2Wb4c3sX0wjcxmx
         63cXvFSFPWXWSPKaZ97q9ZRQn2yRvigfOImCm8gLTrbdss88Pxkngu9F53Z/frwo59tG
         2vlYx06Dym+5HDWTNvIpoz2egHlErOmWEH/LmK91eiNt/H1zN5faKrZDfj3Y3q2tDtin
         bln6TjnXLAOyuc7lB0EYFQjhLIkpquvaLj4idAZ4p1bY0hmhuSP2ON3NpOzya/e9aQHZ
         Arxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696995858; x=1697600658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC6KbeW6ZXTkOADgcyHrxsp1uDrAyBKZbdYvTZmeLb4=;
        b=HhXjNkWDZzWQhxBvxG1cAoNA16+NXUwZsuO2Ttt2Ci6zoKPHrMsEBJkn67f1tw8u8n
         yaM7qnheEUw3v7Fm0WAWCdb7z0jp56igqHpJzufLYKjcZyC+3JQKjUh9+BbAMjq0lV+h
         ALhe2rqnMBUILUlF5RnH9bFh0GEpGGs4nWRhcwEuo8ROC8rk0q0Wv3Eom2+WMXSULZTa
         J/SYbe9ylFPQ8xz9tWgwt0M/ywMTvuAsLQxUp0s6En56QztyfO18V/0Ued4cejVGj0oA
         YDDdhl83Y/Ak+090UQJ2hQ9vg3sqb2rp6uFRoANvthuEDzb9uUkxFMl9AQPBf1G9oxNU
         Kp4g==
X-Gm-Message-State: AOJu0Yw9ENYXRhn9fBkBN3U5u7wuA0HauoZNkG9xogkaU6oX61jio6tf
	VeuJmDTRD8UW8W7I6WTfu79OxoDgyr+OgQ==
X-Google-Smtp-Source: AGHT+IGR7WzD4+qRbBoPht38+b30c7JemrjbQnAvMIUiH66akqSOfW2CxftoM6OS23X1ivAgsXTMxQ==
X-Received: by 2002:a05:6902:1204:b0:d81:c512:e542 with SMTP id s4-20020a056902120400b00d81c512e542mr21283016ybu.31.1696995858061;
        Tue, 10 Oct 2023 20:44:18 -0700 (PDT)
Received: from wheely.local0.net ([1.128.220.51])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b0058a9621f583sm7873656pgn.44.2023.10.10.20.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 20:44:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	"Eelco Chaudron" <echaudro@redhat.com>,
	"Ilya Maximets" <imaximet@redhat.com>,
	"Flavio Leitner" <fbl@redhat.com>
Subject: [PATCH 4/7] net: openvswitch: Reduce push_nsh stack usage
Date: Wed, 11 Oct 2023 13:43:41 +1000
Message-ID: <20231011034344.104398-5-npiggin@gmail.com>
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

Use percpu data to move the large temporary buffer off the push_nsh
stack. This reduces stack consumption from 336 bytes to 64 bytes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/actions.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index be15ef693284..fa53e22f3ebe 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -349,12 +349,18 @@ static int push_eth(struct sk_buff *skb, struct sw_flow_key *key,
 	return 0;
 }
 
+struct tmp_nsh_hdr {
+	u8 data[NSH_HDR_MAX_LEN];
+};
+
+static DEFINE_PER_CPU(struct tmp_nsh_hdr, tmp_nsh_hdr);
+
 static noinline_for_stack int push_nsh(struct sk_buff *skb,
 				       struct sw_flow_key *key,
 				       const struct nlattr *a)
 {
-	u8 buffer[NSH_HDR_MAX_LEN];
-	struct nshhdr *nh = (struct nshhdr *)buffer;
+	struct tmp_nsh_hdr *hdr = this_cpu_ptr(&tmp_nsh_hdr);
+	struct nshhdr *nh = (struct nshhdr *)&hdr->data[0];
 	int err;
 
 	err = nsh_hdr_from_nlattr(a, nh, NSH_HDR_MAX_LEN);
-- 
2.42.0


