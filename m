Return-Path: <netdev+bounces-29898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE41B78516C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79801C20C30
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB02946F;
	Wed, 23 Aug 2023 07:24:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF5946E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:24:27 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F44FF3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:24:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31aeee69de0so3302110f8f.2
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692775465; x=1693380265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WevOLFXl/2i1NIjOjgq+04LHQEgQNZPLNt/G1BCNMf0=;
        b=U4eVV2so3IUROV54x/3kMVua03DAmJXJpqPZmrgpQCOIWpHOmZRvgBiAb2o9xrxqx/
         LpQU58/vqNkUeNV2dX+j2iAgnX/A9qE/SM3yV6S5CxtI4GN4mqWQ8hApdJfOVx7zATPr
         ElNtTZwvBDJE29u7ZyCZnub5aSkdZmNlhxFSbXfhElBkwPhd/M3qsrI8djZgOoe4iQj6
         f5OzFHtGFd1rUOseBKp11Vpb6EGX7PWORsPqPAOqy7+NzsooPIF7/uhBGfQSa9c5MErK
         31mMlqj+lG3jqMGyW1dYIaGeovm8Tey92KWqz3XVbf59/OAJkieqVYGKSMbjs59DkAkF
         CiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775465; x=1693380265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WevOLFXl/2i1NIjOjgq+04LHQEgQNZPLNt/G1BCNMf0=;
        b=CeSmGJ1SFLheJyQ7XgLAMBfU22ppQLWDdu1PH63CNNN320LFiZa+Lov2sswrF0F+mg
         TIKGpjxWxuNuJNKgSFYOXemf5lbZF244sT7W5hG+4iWFPcoylSIFOIApDHoQe2zHoZDh
         pWbegPmNUy3Y17Fcjm1UDzR/O1YznivTYetfqK+wdX88tzSgFNfRSA45b5UBaOaor/NT
         JrrjqXjO4pg8IFozdsKkedEy+0vjcarPyc1piWUxhuhCc35Vd43VKofqsqkSzPAgcvUb
         J/LPphB9B6pCjDncFSqWZim1q3Iw1AhW/4Jzsbz6mZ2ny04Bet0zvhgRqCZKWJLRp/XA
         o4eQ==
X-Gm-Message-State: AOJu0Yzes9xRHWz7xje9d3sjjVvy2RJWS0iWY9pdNd6XVzZgGAFBMHlM
	kCmKHLjGcZpMXrCRSvHLG8XsEA==
X-Google-Smtp-Source: AGHT+IHmczGIUZK3mIj2s5mua2NpDLGvwyTP49zuM+K6N9loKJri/M/EcCAz+P1L7Vnjn7GqIw2CUA==
X-Received: by 2002:a5d:480c:0:b0:319:55a5:3435 with SMTP id l12-20020a5d480c000000b0031955a53435mr8813117wrq.64.1692775464760;
        Wed, 23 Aug 2023 00:24:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b003140f47224csm17975418wri.15.2023.08.23.00.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:24:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 23 Aug 2023 09:24:06 +0200
Subject: [PATCH iproute2 1/3] ss: mptcp: display info counters as unsigned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-1-fcaf00a03511@tessares.net>
References: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-fcaf00a03511@tessares.net>
In-Reply-To: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-fcaf00a03511@tessares.net>
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>, Andrea Claudi <aclaudi@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=vecf6tLbR0awOgwcnlMZ2IJU00x2CO7EBpwaOMAYH40=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk5bQkA6/aXA/o9Q7ef23/q6DnzcQDsJd53NSrt
 GDEuP2M88GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZOW0JAAKCRD2t4JPQmmg
 c5nfEADfV+jsOt/z99a9BrFvIkgbaLMdTSJpkQXo8/GbQs2NAlwpXrUOo1hrzQ/Q8Dd3Jn7Dqc5
 nQZ0fAdg7gEDJaEwyZW0ahy4bEzBXTrbL5ly8UjONg9EduX7+Zk19yu9UvudiRZoOCVDBuJ/PCg
 tO/6kwCGigMbJ2noqs7iva+xC5cC3zFtou/33/+4nTrxjXvP+2JdjBsq3RdkesQDtmxczGTZiHv
 kci3PUfQdP4MOV3ZTLI8mARN8EgKER5+g8VySQ4W9rI5+aifOGCRqLgqNAJhI3GUOmIknhnU9OJ
 I6ECZoNtWvsTzG4EbZ687vbLW7xmkm7y30xKxE5GOA4QAvkNNjIL8HbU1vMi/RTcENY6NqN5h7/
 IfA5bqbdSrcdoOyYgQDradLby3Q2v6bc3OfCO67rGh8Jh8w5X9DfWiTsNL/5u7c8nfhuBETcBJD
 KhO+L1SURpwvnZmrowZZagoG8hhAACCtttIqI5Ne0XqEt6TW0tsoMRbn7UOkPvhwsOBCX+6Ww2V
 wxlZHUfgBE+qP/zE1MzvBE4V2hDq99nVLoN+GwtTnDoDiNFT1PWGBEanIZFjI3Ox6a9uF0K6Ygu
 hau4HvfXgyLHOjeGEoqFvfA4lYiAcCakuKY1Ot/P46mpkIitgnBmXIa5yPt4hUJ0eFXgElEZta2
 Z5X8cSGVhNNnGmw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some counters from mptcp_info structure were stored as an unsigned
number (u8) but displayed as a signed one.

Even if it is unlikely these u8 counters -- number of subflows and
ADD_ADDR -- have a value bigger than 2^7, it still sounds better to
display them as unsigned.

Fixes: 9c3be2c0 ("ss: mptcp: add msk diag interface support")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Andrea Claudi <aclaudi@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 misc/ss.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index c71b08f9..34f82176 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3232,17 +3232,17 @@ static void tcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
 static void mptcp_stats_print(struct mptcp_info *s)
 {
 	if (s->mptcpi_subflows)
-		out(" subflows:%d", s->mptcpi_subflows);
+		out(" subflows:%u", s->mptcpi_subflows);
 	if (s->mptcpi_add_addr_signal)
-		out(" add_addr_signal:%d", s->mptcpi_add_addr_signal);
+		out(" add_addr_signal:%u", s->mptcpi_add_addr_signal);
 	if (s->mptcpi_add_addr_accepted)
-		out(" add_addr_accepted:%d", s->mptcpi_add_addr_accepted);
+		out(" add_addr_accepted:%u", s->mptcpi_add_addr_accepted);
 	if (s->mptcpi_subflows_max)
-		out(" subflows_max:%d", s->mptcpi_subflows_max);
+		out(" subflows_max:%u", s->mptcpi_subflows_max);
 	if (s->mptcpi_add_addr_signal_max)
-		out(" add_addr_signal_max:%d", s->mptcpi_add_addr_signal_max);
+		out(" add_addr_signal_max:%u", s->mptcpi_add_addr_signal_max);
 	if (s->mptcpi_add_addr_accepted_max)
-		out(" add_addr_accepted_max:%d", s->mptcpi_add_addr_accepted_max);
+		out(" add_addr_accepted_max:%u", s->mptcpi_add_addr_accepted_max);
 	if (s->mptcpi_flags & MPTCP_INFO_FLAG_FALLBACK)
 		out(" fallback");
 	if (s->mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)

-- 
2.40.1


