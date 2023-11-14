Return-Path: <netdev+bounces-47745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77077EB201
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 15:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8051F24D9E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244EA41215;
	Tue, 14 Nov 2023 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="duwetk83"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF0D405ED
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 14:20:49 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB19D1
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 06:20:48 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc37fb1310so42789805ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 06:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699971647; x=1700576447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIu3RIT0xrGwPko9+CGawuOOlKNSks8F2EA1QVYJ2kE=;
        b=duwetk83ZD+O+6SsD22Dq3X5dR/vgLYDsAyMN6SwJAl5KkcYpdGkNqqMarmhewc9FT
         L9QADDwRmIXoNOTKvRBpQ1RtR/jTtRwwW4n6wyO/88GBiBSHQSWLGuFOsgPEakTeFsRo
         ML4mqyhytadjHK7EA4zapfMsot9fsvbl4hvqg/qhPDp9sUp7ZFDRgqVsOy9udRIaXbJO
         QPKixpsMxUkfwwlreSEcsEHEDEuNyhv3iht2Jm2etX0PDFOMhpKrAd2fhFDYDHVrtf8M
         IR4U4eBx9sg3+/5BF+s4NOBYlbbO4xlQlcJvroMl+uZFdP1j3CeKnYRDc/UWJ8F2qae5
         NRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971647; x=1700576447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIu3RIT0xrGwPko9+CGawuOOlKNSks8F2EA1QVYJ2kE=;
        b=Mbw6c8hfdiHLtlebadnTlpF/GZPhk8uJ8PT6pMjarZ45jW4liM9vbI4TrSWrbVcyY4
         idtaO1ZI2Se3fJORPjd3ZlVvJBXixgj+YZUF5aHXfVa1+Ms6pLPrMoQcNbmFzoby00BQ
         p5H8vdY12skBAGOizh39S6gASk16oF2fTI/f0jhVS0t7EdrvndDfWRjpvybPICAbPux1
         ysfFw5Zudj5lA9wc7gntb/ctbofQRVrTbpMklUvrRD5AYot4Ulojpf8txCC5lJWQGgTs
         BAMRXtNuY91FnEi950fKn1gz3kRO5KKtLSu3sNZOx5iNfVBmXYcgGXHOFQojanqCak43
         BcpA==
X-Gm-Message-State: AOJu0YxSolIEGz9joyAME3Uun4mVq9WbAaUbft4gNn5rH6/HKGLWb8sj
	tdt+3wYfkQ3Dase2ojdcuVW8xXYMXbr1/Wf89eU=
X-Google-Smtp-Source: AGHT+IE4s2gV6jTa4mfeOVtyWrcBscYllOKUtCzP4TCQ2TOJnhwq80/do0V8B6ILgPBvBp9SV4ObUA==
X-Received: by 2002:a17:903:234e:b0:1cc:348a:a81d with SMTP id c14-20020a170903234e00b001cc348aa81dmr2496813plh.31.1699971647517;
        Tue, 14 Nov 2023 06:20:47 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:70a4:6f84:7ab8:14d8])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001c8a0879805sm5687608pli.206.2023.11.14.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:20:47 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 0/2] net/sched: cls_u32: use proper refcounts
Date: Tue, 14 Nov 2023 11:18:54 -0300
Message-Id: <20231114141856.974326-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In u32 we are open coding refcounts of hashtables with integers which is
far from ideal. Update those with proper refcount and add a couple of
tests to tdc that exercise the refcounts explicitly.

Pedro Tammela (2):
  net/sched: cls_u32: replace int refcounts with proper refcounts
  selftests/tc-testing: add hashtable tests for u32

 net/sched/cls_u32.c                           | 36 ++++++------
 .../tc-testing/tc-tests/filters/u32.json      | 57 +++++++++++++++++++
 2 files changed, 75 insertions(+), 18 deletions(-)

-- 
2.40.1


