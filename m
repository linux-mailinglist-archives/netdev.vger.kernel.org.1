Return-Path: <netdev+bounces-276318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DxNCkn/1Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76683B7EB8
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38D91303023A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9527377EB2;
	Wed,  8 Apr 2026 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0WRbAgp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F23793C0
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632154; cv=none; b=TpOC6omMhbrwcrY3aoLZgSWkWTGNC6bX8LX6HaSUkHvZ8DB3Jp+vMsnThYm6WQ8OujiSDcJoGmXRdCVrjnYdhWb4qJqk0WL7h1Rd0bz2FIEZfv+h/nTG4BjprAREvTCdCBGDnEuw24L740woAtKcfHFsqiue+8JlKKRgqbPMOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632154; c=relaxed/simple;
	bh=yW0EWQ0S7fZHnKrZijNI45+Zh8pLiM3aDw1H/YYr77Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AKv3eGuGeMxMOKoPCT/w8EZZtQs3JeScQij9QLIXbDbIbvWui2pSmp+9cz3JDDyoM4ByILMRmcu6yJdlUw8DCbDLSNMhyfCRllT4vuKj0qsEGK75ksM2X5H0e4gMAPo7jK8uWfCHzbIlHOBeXDXO3Y1NrZdqsSFXB8/8kDFOnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0WRbAgp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad4d639db3so26593595ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775632153; x=1776236953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjikhea0j9xNgvdUdw09l94z78mqVFteQ985sCMSLyI=;
        b=d0WRbAgpYGUxKB4zVy5Etr77inb6L1y6hF0T7XTkz0EB11idWu5FTjeyCXiucAgnAS
         PeBX08/mOWQc3DlmRIqWuKAYplddVsvajdK1ZtDwSfTvZ8pl7bM29YJhKcKSWsCSQER7
         9wgCFhvab+aAzLPqbZ8QQJvCFa2uuwTHbLxcv1GiUmERzR6DcPJOyJrZb2ia0vhzk6bJ
         6d5zgHqYpEKSzj8Ii9x5n9kILz3Sr3O4RjDg7cVHObYpfOggz2YgWRMSGxwd23L9vK12
         MzCdz+LGAhtA1O+1iud0uPv34Z7YD2ATuU4KqgNxJ9DuN66QBPC+tXiIbJVaFD3FLBeb
         e5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775632153; x=1776236953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sjikhea0j9xNgvdUdw09l94z78mqVFteQ985sCMSLyI=;
        b=MMqViLYIdr4NyguEjqTb5dLT9yTrtnKuqn1tV8ryRSniSrjad0ZhigMY9hLGegKfE7
         qgFzCFJ7buQ1X3BgG7Y8vX3WFey9NPJ8SUrkIqCgzqcuE7BFwsqaZlFpqWpzyNmWw4jg
         cKHcstvAt80wBn6Lr8308POpzszw+w64zsLvNIe1qpNJzeMJ9mb1C+WVe+fKgofpNVSa
         e+Wa977WbQvg9Qp7UT8enG5ozT8emT7AhM3xAU+yx8opccobgnkWs/gtAyZ9DPvZSjWy
         muoCcXtH0Ul6loAvwHH2lPnGTpI/DHli6huX9h6q4hbQ4+gjRnRcC1ktKSdjcIyj27sC
         gh7Q==
X-Gm-Message-State: AOJu0YzDvtn+HemQZ+3810mRcT4OkMBnCwCCMxV8BJw+F2gumeVAO1UW
	X+nYJ4QT+QKRoZ2gy7eHqIAvyw3TDJN36C/zOq6ZpkJg2YT8y1DTp78Z
X-Gm-Gg: AeBDiev2/tVviQF8f87KPFXoRtptua0F058APOklav5gUBt30UUhxKkNXVJOdxKTXjf
	0cMYu3yrbG8VOQzBt829v0stsurM7+dZ9yCXZaUCbiWb+hrOkTYwjaHDzP/YYMtbgZkB+q4V66p
	/HlJrOSCDtcWdjtxSzivTC+Thgjl8x22c423w/0tP0C9/b6ARMSCKFOFsmwSCA5TzwrSoN0kB0X
	N2imlA0dZ8ARM42tQ/N8GCEPCenOWg+B4jMRlhZVt0wa63SBkJmO2VIrYzoUQGC75f0NZM3m+Dw
	BjuT26uip8GpkiBP3QXEUKzhfmiqC/2w5QA+kJl34SZCoNeWhwN3YBfuhBrxhdyMZIo65ZBMIYh
	f6XeKEvBrstUl63rFDH1sjIzqwzktRfQ+MQ9D0vJaXsV1dFCfR5OkQywBU8rMr1Cns4BchFWSY7
	g4o7NAkKkQlnCFD+kswJNj0JXDugjyyfOejBWlZodyEG+3nyiS7TCEngsXcyY=
X-Received: by 2002:a17:903:2c07:b0:2b2:67ca:5ff1 with SMTP id d9443c01a7336-2b2818afe20mr216067485ad.31.1775632152759;
        Wed, 08 Apr 2026 00:09:12 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749b66aasm202917785ad.68.2026.04.08.00.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:09:12 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 08 Apr 2026 15:08:51 +0800
Subject: [PATCH net-next v2 3/5] tools: ynl: ethtool: add --dbg-small-recv
 option
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-ynl_ethtool-v2-3-7623a5e8f70b@gmail.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
In-Reply-To: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-276318-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B76683B7EB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a --dbg-small-recv debug option to control the recv() buffer size
used by YNL, matching the same option already present in cli.py. This
is useful if user need to get large netlink message.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/tests/ethtool.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/tests/ethtool.py b/tools/net/ynl/tests/ethtool.py
index 63854d21818c..db3b62c652e7 100755
--- a/tools/net/ynl/tests/ethtool.py
+++ b/tools/net/ynl/tests/ethtool.py
@@ -166,12 +166,19 @@ def main():
     parser.add_argument('device', metavar='device', type=str)
     parser.add_argument('args', metavar='args', type=str, nargs='*')
 
+    dbg_group = parser.add_argument_group('Debug options')
+    dbg_group.add_argument('--dbg-small-recv', default=0, const=4000,
+                           action='store', nargs='?', type=int, metavar='INT',
+                           help="Length of buffers used for recv()")
+
     args = parser.parse_args()
 
     spec = os.path.join(spec_dir(), 'ethtool.yaml')
     schema = os.path.join(schema_dir(), 'genetlink-legacy.yaml')
 
-    ynl = YnlFamily(spec, schema)
+    ynl = YnlFamily(spec, schema, recv_size=args.dbg_small_recv)
+    if args.dbg_small_recv:
+        ynl.set_recv_dbg(True)
 
     if args.set_priv_flags:
         # TODO: parse the bitmask

-- 
Git-155)


