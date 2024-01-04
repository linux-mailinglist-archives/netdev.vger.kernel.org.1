Return-Path: <netdev+bounces-61418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01FF823A1B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A447A1C227A9
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6339185E;
	Thu,  4 Jan 2024 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="zvZy1LEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A8C15C8
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28c0df4b42eso717395a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 17:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704330876; x=1704935676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/BS9I1G25iZlaKnjcUNfLqctGtiSHWfr43vpJ46xOc=;
        b=zvZy1LEsyl6CRxGDbCxIoajcIn7Cd6X9lkZ1cDihKSijapnEwugyMsXpKs3vQDwkk2
         azI3p+edip9wl7ubwtWi5xrv9J27ybgZ5qZ9kJawM7GehZcRCfJOvaAA4D1GN5KOPGtr
         BAbAT0oxQ4dbmWtmIVFufvCl0yeY5cQNl+TBFkKlaBCyGP3NPSN+MSg0fKTBsDWIWzjI
         Y3lkKfn606U/8CWnK5nv8BwInaKVNk7w8ZyQpwJL3BtIElG9/oMMj0ec2fFFsYoEojgE
         bjh1JLyRhwsGxXoiYPhYg4QX6ZuroT273h/8TjZ8lBGfq5LybGOaW5akT3VRVidP7DYf
         jknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704330876; x=1704935676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/BS9I1G25iZlaKnjcUNfLqctGtiSHWfr43vpJ46xOc=;
        b=ge0/fu6r9z9J15HjO8cQ2hcFpAV0+KXGxLiF7r/0lG2WyqmJJsTyX+y4bi6VdfXCXt
         P6PH6g/NGPKPzIY15WHHHEuQALKH2xc0NvsHsr3oEY3RV8VTHkAWPVIhNaLmEy4wNNmb
         //MScytGcRWfWT5VwqEPlQVOOZgHPT1XcciwQePP9kVDWZy6QrKcqhnxcHqWCET6obd3
         RqHztxVm4dctu1y8ONNWccn/BKbNAcuCI5StgUMoYadPsG0klRiOlAnVDYIGptvYf0Ox
         /ttNhA9Bn6mLtwhYw4hsZb1vfkupSePupUoAVOhUDylzFk05HPQp9Pr2OrlvlNVB6YDq
         BW3w==
X-Gm-Message-State: AOJu0Yx7G8vxrm5eltHDCzJXrJP2bg+9RezaOfM70e94BFzYVaC6wpw2
	hdhhVV8DMSRn8Ye8lFvRO+W5rXxf1mEobg==
X-Google-Smtp-Source: AGHT+IEK8rkyL7cYPk+iflGI6hKGkBIPZbcX0On4ZVskogQrXCMkq4o5QOCKNNBRwJpVDHgijQTGzA==
X-Received: by 2002:a17:90a:540a:b0:28c:16bb:712d with SMTP id z10-20020a17090a540a00b0028c16bb712dmr2068466pjh.48.1704330875856;
        Wed, 03 Jan 2024 17:14:35 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a7c4400b0028adcc0f2c4sm2510124pjl.18.2024.01.03.17.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 17:14:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 iproute2 4/6] rdma: make supress_errors a bit
Date: Wed,  3 Jan 2024 17:13:42 -0800
Message-ID: <20240104011422.26736-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104011422.26736-1-stephen@networkplumber.org>
References: <20240104011422.26736-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other command line flags supress_errors can be a bit.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/rdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rdma/rdma.h b/rdma/rdma.h
index f9308dbcfafd..65e3557d4036 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -61,6 +61,7 @@ struct rd {
 	uint8_t show_details:1;
 	uint8_t show_driver_details:1;
 	uint8_t show_raw:1;
+	uint8_t suppress_errors:1;
 	struct list_head dev_map_list;
 	uint32_t dev_idx;
 	uint32_t port_idx;
@@ -68,7 +69,6 @@ struct rd {
 	struct nlmsghdr *nlh;
 	char *buff;
 	json_writer_t *jw;
-	bool suppress_errors;
 	struct list_head filter_list;
 	char *link_name;
 	char *link_type;
-- 
2.43.0


