Return-Path: <netdev+bounces-45408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81A17DCB9D
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 12:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88331B20DE7
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 11:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968219BB1;
	Tue, 31 Oct 2023 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEZY68v8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827A12B79
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 11:17:24 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BA097
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 04:17:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso5798656276.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698751042; x=1699355842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VxBLANg6EmmWnADl2MRD0kfvMVo4SQZhTWg/EXI4LVA=;
        b=aEZY68v8+fZNh/McICkZZBS4uGv7RwL4hrHI2FrR3lN6oOcgOJW92tR7mxxHtdCOhT
         K6FWo66x34KLwjj1VmF06aH0nmre5y28rkmXFZceiJhw174qXi36M4y8NONem5DT4Ov2
         qzTUO3E8E9JSLnPEO0u8a4NRElYh92alFHB9iLFRzoLNtyytk/trmC0ZxG0MIx2IZTGA
         yzd6Fd9dYHmkBctoaN1LBG9bnl9clhV9G9vovkkb4IXhRSFVE2VWrJ8bE39AFuGodWXt
         ew00mbtbC/IU2Lf43KmFZadnlUWsnMWwRXH5uesGpXxXIEH3wqNN5g+9605d7gSsY+aG
         fSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698751042; x=1699355842;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxBLANg6EmmWnADl2MRD0kfvMVo4SQZhTWg/EXI4LVA=;
        b=YKGtuRl774gsKpr2GsXHXruVwKDTi86IEP2RJn6JbLmzrwOx+Zsrfe1wD5wDzvOO/+
         7PIoR0go3fpDaJCJGEaCvNtkCZYQaaw8MJz5f1JjLp97S+hR+93UqbUeNVLfn8OMijVc
         6lwO9Yr88AVXTmrY4C3X+aEbbbt901Yuu4UMDOuDlVAj1zXCmqEt+T+bqQMDMJReckP9
         U+/TtouPYGOisj6tReCY9h2TOLroaRiJOUwCKVfwSawhjKDYOjERjMMZppne0zH7zCfK
         VRv0hM6V8g4CweOp+X3eBxmi+PngQC7ICodvzHymPfAxulgjWyoukroIDs5Ee7RTMrjc
         CzbQ==
X-Gm-Message-State: AOJu0YyTDWhMso91+5fTd6cG/fFgCK5xmIVIJlQ+rJDds4bX1fryJ/F4
	CnIGEEAL6Gw50+MtAd2XXE6NnexoWloJpg==
X-Google-Smtp-Source: AGHT+IF3ZLG1XGSt/tjNgfv8nbJdR76a+FDfXSlDxsAi+nGLX0guVUiXmnUBWXYumXEB53PEUByBv2c+6yq0mA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:5f4c:0:b0:da0:3e20:658d with SMTP id
 h12-20020a255f4c000000b00da03e20658dmr233405ybm.10.1698751042244; Tue, 31 Oct
 2023 04:17:22 -0700 (PDT)
Date: Tue, 31 Oct 2023 11:17:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031111720.2871511-1-edumazet@google.com>
Subject: [PATCH iproute2] ss: add support for rcv_wnd and rehash
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcpi_rcv_wnd and tcpi_rehash were added in linux-6.2.

$ ss -ti
...
 cubic wscale:7,7 ... minrtt:0.01 snd_wnd:65536 rcv_wnd:458496

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 misc/ss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/misc/ss.c b/misc/ss.c
index 2628c2e042f1cdb616ec8aa80d4f413b41dfd3f4..9438382b8e667529dc2cf4b020d8696a4175e992 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -865,6 +865,8 @@ struct tcpstat {
 	double		    min_rtt;
 	unsigned int 	    rcv_ooopack;
 	unsigned int	    snd_wnd;
+	unsigned int	    rcv_wnd;
+	unsigned int	    rehash;
 	int		    rcv_space;
 	unsigned int        rcv_ssthresh;
 	unsigned long long  busy_time;
@@ -2711,6 +2713,10 @@ static void tcp_stats_print(struct tcpstat *s)
 		out(" rcv_ooopack:%u", s->rcv_ooopack);
 	if (s->snd_wnd)
 		out(" snd_wnd:%u", s->snd_wnd);
+	if (s->rcv_wnd)
+		out(" rcv_wnd:%u", s->rcv_wnd);
+	if (s->rehash)
+		out(" rehash:%u", s->rehash);
 }
 
 static void tcp_timer_print(struct tcpstat *s)
@@ -3147,6 +3153,8 @@ static void tcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
 		s.bytes_retrans = info->tcpi_bytes_retrans;
 		s.rcv_ooopack = info->tcpi_rcv_ooopack;
 		s.snd_wnd = info->tcpi_snd_wnd;
+		s.rcv_wnd = info->tcpi_rcv_wnd;
+		s.rehash = info->tcpi_rehash;
 		tcp_stats_print(&s);
 		free(s.dctcp);
 		free(s.bbr_info);
-- 
2.42.0.820.g83a721a137-goog


