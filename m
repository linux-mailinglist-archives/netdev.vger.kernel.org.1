Return-Path: <netdev+bounces-61077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C412C822607
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61771C22C55
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4115F37E;
	Wed,  3 Jan 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="RI3lboul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA415AF
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dbca115636so6073259a34.2
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 16:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704242173; x=1704846973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zf22eup/92NwdG7c8/XQ2OZXhp+h3axYo/8yiikPijg=;
        b=RI3lboul7G3XIyLlyW7MjMUXQeliXBX/rQBBp8jRrzbUCu3rwCDP0gw7kCmyLCROfN
         VzlxLAhWhbudIFf//n+t0SQiEPfnMqX3nM8J+sZ5Bm2vzmvHiDlDo/GKItAcx7NMAlze
         XkZHh0ikXtL6jLTB0DFs0a4RFvChAqDVO0PEwElNoEtZcAHDjKN+YGlWNIWhXUb09C1P
         w5xGzqnPYmLHwfOvlQ6IEbi4Z1ZfTFqwOKvDeD5gIZRsTxaCY1aUrWiPx66g6Ca7nSYA
         fJLM+qQGhDYPcm8RBVObqOQWBmCQDT0b+NGHh/0ewgZsl1WTp2GAAccPIgeB05qyhXFn
         6X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704242173; x=1704846973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zf22eup/92NwdG7c8/XQ2OZXhp+h3axYo/8yiikPijg=;
        b=DM427zZHCVUdsRHPIpKwRmUMIQmO6Dud3meWlgC79ieVuh3904ji3kmMC0X23m//KU
         HC065ZSI5vVIUeLCbiEQaUTsJYjjDleeYS4fb87lX4tqCN+LM9C0UdoWqmh7zoD1Hwbc
         wD2b5CWzxZV5RlhByIWqxKV9MilV3KyIvr4/wqDBxluLm824b9jtwqqmdsKWB6oQMlze
         m/aU3FP3OkEIxbtgmEMfuxpzWqInkz3aglN0xh3TbZlZB/0DHMcj6nNFvxWuzfPExJFB
         nh2S22zgvjjzC6/d0l0TClr766zFOR4oNXHOmExovlunebHH8ZzhioWG/9Q8viZop8fc
         PPoQ==
X-Gm-Message-State: AOJu0YyVXzBDGumdUfyF/k0QxNPAIDEogt2SQl70pqSECckd4CiDn7Qb
	MtKyqyW8UFhZncDE+MLlxW/rWqgV/bduCBQsU0uN1b1n/SQ=
X-Google-Smtp-Source: AGHT+IEu4Ue+ePAkRdvaC9gc/5c59HqPNebLWBz8/ChxOEYCt99bdRsgzKGJaiK9U1KxgHyQOb54gQ==
X-Received: by 2002:a9d:4f14:0:b0:6da:46fb:76c with SMTP id d20-20020a9d4f14000000b006da46fb076cmr14848760otl.8.1704242173801;
        Tue, 02 Jan 2024 16:36:13 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006d9af59eecesm16698260pfn.20.2024.01.02.16.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:36:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2 7/8] rdma: remove duplicate forward declaration
Date: Tue,  2 Jan 2024 16:34:32 -0800
Message-ID: <20240103003558.20615-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103003558.20615-1-stephen@networkplumber.org>
References: <20240103003558.20615-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/rdma.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rdma/rdma.h b/rdma/rdma.h
index e93e34cbce45..08b26a07a003 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -135,7 +135,6 @@ int rd_attr_cb(const struct nlattr *attr, void *data);
  */
 void print_driver_table(struct rd *rd, struct nlattr *tb);
 void print_raw_data(struct rd *rd, struct nlattr **nla_line);
-void print_raw_data(struct rd *rd, struct nlattr **nla_line);
 void print_nl_indent(void);
 
 #define MAX_LINE_LENGTH 80
-- 
2.43.0


