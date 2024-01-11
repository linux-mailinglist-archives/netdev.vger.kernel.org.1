Return-Path: <netdev+bounces-63121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED34D82B44F
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 18:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE4328443E
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0D524D2;
	Thu, 11 Jan 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="lxouuzcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA350276
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d4a980fdedso48920385ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704995265; x=1705600065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mY6Rn808eaVli/D2Z7cXkvA5RQLFLC1HHn5Qzf9fE/c=;
        b=lxouuzczLc42XAYnyK2/9K3RCJbhkxJ0g+rE9230MQnnteqjGSPpxiCX7OITDUIphG
         BccjxuyUKUCHQMvX/QNDxphBUGQ4NouUZgFSJztMW63G1L1l7l3kFoWLhIwbeikUr//d
         eozrGUP+40ylrIgXhchp2JEJVLOkBoOYWU1/lzFCckjHnRxgYx1hxheralPS52DlZI6W
         MAi5sG9kHAQoBiu6CpF/yD343mrP7vx1XH2GN6WB5tgjFQxfRBE2Z/IfFnPfKlYISXN0
         +Yegsvfz8q1CEWEfJY36Ire028FDBrnEF6hOgsSzS+kEC09JQ/KCwUqWas2/0avrGSXp
         eTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704995265; x=1705600065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mY6Rn808eaVli/D2Z7cXkvA5RQLFLC1HHn5Qzf9fE/c=;
        b=nbYk9SRl7aIvMfn5jFHxyq4FXlokmlNqsM97mHQW4cTt/O0XFZIUymkpVz7Oi+9xFa
         ExMn8uO4yW3WA+f94oiacyQfewAabbB7xxiOZGMmpl+/RmurhQXF8O552/GM9waL+nRe
         /j9bpqG/4e/tlgzn6fssIXprebEv7TQjl+a5Fmc2C6W0TjzQXqURtGzhDL/0lV38t+mo
         /Lc+YCq3ONAT0yVhq2KT9c2s4zq75rbYK+XfH+DSAlT1Wv2vHw5tWW02iZ4EpZnJrjXA
         X+s3Ss2U8HGHhHxhIdp5OM8yyR1/Iyh0aNm2FNX+qYFPMOZ7aK3dbSWzw7rFVzfr2EEQ
         dx5Q==
X-Gm-Message-State: AOJu0YyZj5v/A3N8qCQl/kCMfnqKJXKgSCKJzkQTy7GYPOHsEjYdKn/b
	tmVSo6GTKjvNKl44MBuDeXMxH5e9oAKH5GxN1XWdX/SZG2WOrw==
X-Google-Smtp-Source: AGHT+IGf1tdl6kSs19WSwc0vVsopO9k+ofUi2H83CuOzaySE5OEJA7qocj6o39ax1WKbXVjJJQA2jg==
X-Received: by 2002:a17:903:110d:b0:1d3:b167:7da9 with SMTP id n13-20020a170903110d00b001d3b1677da9mr111618plh.58.1704995265124;
        Thu, 11 Jan 2024 09:47:45 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170903288f00b001d3b258e04bsm1437853plb.248.2024.01.11.09.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 09:47:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] man: drop references to ifconfig
Date: Thu, 11 Jan 2024 09:47:25 -0800
Message-ID: <20240111174734.46091-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation does not need to have any references to the
legacy command ifconfig.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/tc-bfifo.8      | 2 --
 man/man8/tc-pfifo_fast.8 | 2 --
 2 files changed, 4 deletions(-)

diff --git a/man/man8/tc-bfifo.8 b/man/man8/tc-bfifo.8
index 3e290322f603..bc05ef4d8bb6 100644
--- a/man/man8/tc-bfifo.8
+++ b/man/man8/tc-bfifo.8
@@ -37,8 +37,6 @@ If the list is too long, no further packets are allowed on. This is called 'tail
 limit
 Maximum queue size. Specified in bytes for bfifo, in packets for pfifo. For pfifo, defaults
 to the interface txqueuelen, as specified with
-.BR ifconfig (8)
-or
 .BR ip (8).
 The range for this parameter is [0, UINT32_MAX].
 
diff --git a/man/man8/tc-pfifo_fast.8 b/man/man8/tc-pfifo_fast.8
index baf34b1df089..09bceb78bab3 100644
--- a/man/man8/tc-pfifo_fast.8
+++ b/man/man8/tc-pfifo_fast.8
@@ -27,8 +27,6 @@ have traffic, higher bands are never dequeued. This can be used to
 prioritize interactive traffic or penalize 'lowest cost' traffic.
 
 Each band can be txqueuelen packets long, as configured with
-.BR ifconfig (8)
-or
 .BR ip (8).
 Additional packets coming in are not enqueued but are instead dropped.
 
-- 
2.43.0


