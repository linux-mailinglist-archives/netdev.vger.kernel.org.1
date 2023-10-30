Return-Path: <netdev+bounces-45294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A17DBFFF
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640581C209AB
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B59182AB;
	Mon, 30 Oct 2023 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="cA9C26xn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7CE18C01
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 18:42:09 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC8EB7
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:42:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so4753897b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698691327; x=1699296127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg55PGleKVAZ5FKT9rqw3cl5WH0ZVJATb9N16MUYRFI=;
        b=cA9C26xnUXEiz/e5BBt7DZC8bszFsBHKfg4mQhW9nA0Ui3valcBMGj46DF4SuFbyqa
         8F2OT9Qrw+AsYJcxzEscS0fh1VUH2cq9mEYf9swyGq4olufxQ7dakYyfmXS1mLBfm6mC
         sY+zS8Ox5GCM+OGdDU13HPnx7Yj+Htx4iZokcfO1vMh1xfm5Ef2XhDMeX+RhGDRAtbQU
         ap8Z4VH+uhfHzo1GWAuU/hiUBKmJjAl9gU8UR2XvT0StD5WQUtfd2PuHl7nLKgh3iS3y
         mIZjxz9LF26N6qDFIkViViZKbYE256rS0ElE/Rd5miGD63XXX+CtWBid8IMV+bLSR7y/
         7LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698691327; x=1699296127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg55PGleKVAZ5FKT9rqw3cl5WH0ZVJATb9N16MUYRFI=;
        b=Pu+KMZVh6Och7uBH7hcjctQy3b5BQawmEUbC1TflQNRtKWGSzDBg5ImlSRJ2et7oFN
         XOCZUrUH/WvZ2ZgjBUqYFe2PzKX9PSv1uSvk95J8CJAIgn7j9gJy7GYBqzDQ6BenlSIo
         my/Y40yVX6JJv4BmtL5n1A1OoOa4339SqLbkEpUkDQkX/2465JCewoQLaiwLWlq9xuwK
         mMzDwQGDFCRU+mUTfIs759psqfG9lPefFUF05YFxQOJqm648QV0I+fRysWK2eWRscVKu
         IK290IzbSuDE98LGmU6RtYPMlrYa65YRHPzT9xABYo0TNImZLnFPwUKIieJ6TolvPHrI
         N/wQ==
X-Gm-Message-State: AOJu0Yzq2bGg1WVBuXLnjZIpsVF5Yz+EJoNKt9TiLSXhAODbgu0V73tN
	IwEOwGtvzROURrZ20BcOJ9DWIH+mHYzGXMLexIyKJorEjGs=
X-Google-Smtp-Source: AGHT+IEcN/XW2qctcjxe79T/6bMCevYWLNDBer1L2TlsyKktRVuL/HX3t08fBqLisQoI3CL+AGaexg==
X-Received: by 2002:a05:6a20:8e2a:b0:132:ff57:7fab with SMTP id y42-20020a056a208e2a00b00132ff577fabmr14372484pzj.2.1698691326881;
        Mon, 30 Oct 2023 11:42:06 -0700 (PDT)
Received: from fedora.. ([38.142.2.14])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0010c500b006bfb903599esm6206962pfu.139.2023.10.30.11.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:42:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 iproute2 0/4] Remove retired features
Date: Mon, 30 Oct 2023 11:39:45 -0700
Message-ID: <20231030184100.30264-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove support in iproute2 for features removed from 6.3 kernel.

Stephen Hemminger (4):
  tc: remove support for CBQ
  tc: remove support for RSVP classifier
  tc: remove tcindex classifier
  tc: remove dsmark qdisc

 bash-completion/tc           |  24 +-
 man/man7/tc-hfsc.7           |   2 +-
 man/man8/tc-cbq-details.8    | 423 -------------------------
 man/man8/tc-cbq.8            | 351 ---------------------
 man/man8/tc-htb.8            |   8 +-
 man/man8/tc-tcindex.8        |  58 ----
 man/man8/tc.8                |  23 +-
 tc/Makefile                  |   5 -
 tc/f_rsvp.c                  | 417 -------------------------
 tc/f_tcindex.c               | 185 -----------
 tc/q_cbq.c                   | 589 -----------------------------------
 tc/q_dsmark.c                | 165 ----------
 tc/tc_cbq.c                  |  53 ----
 tc/tc_cbq.h                  |  10 -
 tc/tc_class.c                |   2 +-
 tc/tc_filter.c               |   2 +-
 tc/tc_qdisc.c                |   2 +-
 testsuite/tests/tc/cbq.t     |  10 -
 testsuite/tests/tc/dsmark.t  |  31 --
 testsuite/tests/tc/policer.t |  13 -
 20 files changed, 11 insertions(+), 2362 deletions(-)
 delete mode 100644 man/man8/tc-cbq-details.8
 delete mode 100644 man/man8/tc-cbq.8
 delete mode 100644 man/man8/tc-tcindex.8
 delete mode 100644 tc/f_rsvp.c
 delete mode 100644 tc/f_tcindex.c
 delete mode 100644 tc/q_cbq.c
 delete mode 100644 tc/q_dsmark.c
 delete mode 100644 tc/tc_cbq.c
 delete mode 100644 tc/tc_cbq.h
 delete mode 100755 testsuite/tests/tc/cbq.t
 delete mode 100755 testsuite/tests/tc/dsmark.t
 delete mode 100755 testsuite/tests/tc/policer.t

-- 
2.41.0


