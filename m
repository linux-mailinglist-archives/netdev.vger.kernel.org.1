Return-Path: <netdev+bounces-61414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2A823A17
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46421F25E78
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62643376;
	Thu,  4 Jan 2024 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="LsK5Rd0n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815E1851
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28bf1410e37so8772916a91.2
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 17:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704330873; x=1704935673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8m21qIBX8vbuJ/H7kcz1mHNetUJ1SqQygxP6CcGiOzA=;
        b=LsK5Rd0nJWeRkmOhuJMUGBFxGmseQhlv//JkP6c9GmHe+7Tg3AFEgTFi4TvxJyYIf8
         w4LibAoRm1gP0yZad6EoFZ30/FiRPrp4zD8+9/OpcbBY/Cep/P2e0Yd9no9qYkZutM6y
         gLggLnLDdlMjpMgV7CbdgB+BUGWNXkds9zWGZkbjLNjWwcBCVjMazsWjJ0NEF9zCDTuf
         28+2oXSk5A2A5AkJwmwFXYn/cjZSIfeOCK2/vHNadmLpRCcrK1FmRgIOiR8m3+qF90GZ
         kJnICh3U72/LtvquQUKun1cJv/OLmXtA3GkV/OePlfy8dne74c588NesXhlhnHP66zBB
         Hduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704330873; x=1704935673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8m21qIBX8vbuJ/H7kcz1mHNetUJ1SqQygxP6CcGiOzA=;
        b=VEj3J1dZOxeJKbQMOJDVbX8SX9ZfqYskwHpxW+ayFcTIPDRVwBeqHYxoIfrfUjk/Ij
         UfklsWpruPvpU/MqxdEBIa/tB1vJ9gFjNUloCPc6V2ux0PXtyDYNJBs+AokqgQ/8UDQF
         ggNNado53/kZle5w/7YVmqwktOEWQfgcWBZ0ByLzrE7gGwzQAWKAXgrPGXLHqABdtaQi
         8DIb+yiN0B1Dnn+/LyrXuXvHUXQGB6r3frtzo5OCxfXppA+A2i0ilZOH+xDx2Uholv2g
         toUpzySkaM0ywAfP6Powe2H97AFbgLyrqT6EeJbehn01X9kqxuZers3KYkJeXBaBLlp+
         98UQ==
X-Gm-Message-State: AOJu0Yya9Tpe3FUKBjJYhmxv/smS97+r6Eu8ZurRGFZw2aqdwtNECMo/
	I88AVtJSBbWkRXlRIDSqiSJC4iF9z7dKYiPCEcsHdivxCuo=
X-Google-Smtp-Source: AGHT+IGis2EGj6FKPf8FQDwJvLpjXyWm58HtTJyLanjKtXCWRLPP4vx6164iKiCSQd8lNtz6QY5m1g==
X-Received: by 2002:a17:90a:4961:b0:28b:e9e9:e0f with SMTP id c88-20020a17090a496100b0028be9e90e0fmr10653316pjh.17.1704330872758;
        Wed, 03 Jan 2024 17:14:32 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a7c4400b0028adcc0f2c4sm2510124pjl.18.2024.01.03.17.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 17:14:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 iproute2 0/6] rdma: print related patches
Date: Wed,  3 Jan 2024 17:13:38 -0800
Message-ID: <20240104011422.26736-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches makes rdma comman behave more like the
other commands in iproute2 around printing flags.
There are some other things found while looking at that code.

This version keeps similar function names to original

Stephen Hemminger (6):
  rdma: shorten print_ lines
  rdma: use standard flag for json
  rdma: make pretty behave like other commands
  rdma: make supress_errors a bit
  rdma: add oneline flag
  rdma: do not mix newline and json object

 man/man8/rdma.8 | 12 ++++++--
 rdma/dev.c      | 42 +++++++++++++++-------------
 rdma/link.c     | 52 +++++++++++++++++-----------------
 rdma/rdma.c     | 21 +++++++++-----
 rdma/rdma.h     | 11 ++++----
 rdma/res-cmid.c | 37 ++++++++++++-------------
 rdma/res-cq.c   | 34 +++++++++++------------
 rdma/res-ctx.c  | 11 ++++----
 rdma/res-mr.c   | 26 +++++++++--------
 rdma/res-pd.c   | 21 +++++++-------
 rdma/res-qp.c   | 50 ++++++++++++++++-----------------
 rdma/res-srq.c  | 27 +++++++++---------
 rdma/res.c      | 39 +++++++++++---------------
 rdma/res.h      | 18 +++++-------
 rdma/stat-mr.c  | 10 +++----
 rdma/stat.c     | 70 +++++++++++++++++++++-------------------------
 rdma/stat.h     |  4 +--
 rdma/sys.c      | 11 +++-----
 rdma/utils.c    | 74 +++++++++++++++++++++++--------------------------
 19 files changed, 277 insertions(+), 293 deletions(-)

-- 
2.43.0


