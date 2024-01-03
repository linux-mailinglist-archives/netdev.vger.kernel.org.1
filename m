Return-Path: <netdev+bounces-61070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2384F822600
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E581C21A3E
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC337E;
	Wed,  3 Jan 2024 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CxTY3fuG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC92565
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc049c7b58so3649833a34.3
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 16:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704242168; x=1704846968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i7zY1tfxAa50T3ankCatV+qnHzCeviowalSaAWgODP0=;
        b=CxTY3fuGrxtwed5cKbbArfTqASx6vR7pbPC86/yAqTEAfVSH45HoLcz0RyGU3rMRD8
         FZsL0Fx7OD4mdCaRdLbb1QMHyHJiw1t0JP2hazU3XVZvkbvxaGYgGLp4QJsZmaOWkoyg
         8398f1sc/4NcljoHXTBhVdpCAarUe9QQhzIfKK4KZcjD8quLgiPj9qwZpoCk48R4fnkF
         nbHAHSRS9P9Dsul1sKTVL/NoHEpbEsvyLBgZeO3M2uH02nAiN5Em/+2MLwx37a/GBi2E
         MNsOiIrOY1GD7OUgrO6Zhj5JzxXuCLHzZueqwdHVj+6H+P98Y12cBK+ILlUyXbQXRmO1
         fhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704242168; x=1704846968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7zY1tfxAa50T3ankCatV+qnHzCeviowalSaAWgODP0=;
        b=K1tH5227Rmr/mV/QQHDKvhrHgUveG1UHGH/3g/acRmJ//Kuw5QskLD8HOOwQUo7e9q
         jVvFOFkWq3XKLS2oFMJBrgQNa5/oS6E1WkJ/HK6Mu2Bne8JJFIz7nKp7GWPSsfpMVyeS
         oSUqI7Bgq11orROCvLqvZQ9X5QkTjDLCwSbBCWrPoE/Z4drYmH3ICVQa96CAlu7P4F9c
         BgcwPN2KJOfxMUgO9+nNABHt4iLGEzcooO6ycrilbzFcJa6NSLFyRuN13J0d7cvZt7nB
         tMnuCDA9kriQfc+5uAhb0xGnDmPPqYis6gPyAgLIWQ38zfQQKU+cWkU2gW/gp6VpqgW1
         kZdg==
X-Gm-Message-State: AOJu0YzBOfdswJTAp8GkctrYxep6ukC2haYsbK7HzrSoEIWMLc3GedA6
	3ZFsD5U9rmuM6dRpx0x3BjOftcvkWpLMOe7PW+wwDDg6Z+Y=
X-Google-Smtp-Source: AGHT+IFRDKvASQAugen/lqnfpz2WDBuIh+d7xpd+ovl5gOg99PiLpz/cFCZXrELHZv9zDgA0XosU0w==
X-Received: by 2002:a05:6808:3023:b0:3bb:df6d:da7e with SMTP id ay35-20020a056808302300b003bbdf6dda7emr8253902oib.119.1704242168549;
        Tue, 02 Jan 2024 16:36:08 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006d9af59eecesm16698260pfn.20.2024.01.02.16.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:36:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2 0/8] rdma: print related patches
Date: Tue,  2 Jan 2024 16:34:25 -0800
Message-ID: <20240103003558.20615-1-stephen@networkplumber.org>
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

Stephen Hemminger (8):
  rdma: shorten print_ lines
  rdma: use standard flag for json
  rdma: make pretty behave like other commands
  rdma: make supress_errors a bit
  rdma: add oneline flag
  rdma: do not mix newline and json object
  rdma: remove duplicate forward declaration
  rdma: remove unused rd argument

 man/man8/rdma.8 | 12 +++++++--
 rdma/dev.c      | 40 ++++++++++++++--------------
 rdma/link.c     | 52 +++++++++++++++++-------------------
 rdma/rdma.c     | 21 ++++++++++-----
 rdma/rdma.h     | 10 +++----
 rdma/res-cmid.c | 37 ++++++++++++--------------
 rdma/res-cq.c   | 35 ++++++++++++------------
 rdma/res-ctx.c  | 11 ++++----
 rdma/res-mr.c   | 26 +++++++++---------
 rdma/res-pd.c   | 21 +++++++--------
 rdma/res-qp.c   | 50 +++++++++++++++++-----------------
 rdma/res-srq.c  | 27 ++++++++++---------
 rdma/res.c      | 39 +++++++++++----------------
 rdma/res.h      | 18 +++++--------
 rdma/stat-mr.c  | 10 +++----
 rdma/stat.c     | 68 +++++++++++++++++++++-------------------------
 rdma/stat.h     |  4 +--
 rdma/sys.c      | 11 +++-----
 rdma/utils.c    | 71 +++++++++++++++++++------------------------------
 19 files changed, 267 insertions(+), 296 deletions(-)

-- 
2.43.0


