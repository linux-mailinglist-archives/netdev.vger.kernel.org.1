Return-Path: <netdev+bounces-136292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6F49A1415
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B44280CCB
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EB51D2B2C;
	Wed, 16 Oct 2024 20:34:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170B176AB6
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110866; cv=none; b=DZtgpSIgwk2CBGhd4rTGKIhxprGYqGzpa+COdN+u3FOrkX5LBU7Yfh94XW0YKnpT13PGCWOcpgPsRERlAnsml1aDz+4w7Esw1K9Lf8wiXHbkBJI59SSxoDiRvtsYoclWO/hm7tvjvYA7w7TPGzVyDk+bcO7ipWPjH/Z+VJBVL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110866; c=relaxed/simple;
	bh=W2SvLkAQLrXASqQcG6lRVBNGP1xI8kiax4EdIjMqMUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8GG0WaThDwUMe+Dp8YEh/D8xvK4ni4PMNEQEdnorwfUHf56DY+y3SZSBEWX+Fw/ADjCJNnyVE6rdLj0SteYxAlMSTT3rMJalnujdU/V3K0b4GHx/4Lcp+0Ytl0f/B9MESth9zO8StytjvTKcMUZhDI2Je8Hk52tXI64z1rr1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ceb8bd22fso1936075ad.3
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110863; x=1729715663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfHJfDeTK/jNvuVw/wNROsS1HDxEN/P2TDwXfNGJZsw=;
        b=LbEFv7EwTHSPH5zof+J8DYRWGKLbnezCVw7ZNZ+bgmnQAeDUBFm0BVi3PA6/Uv876y
         XS4VuYIhlQX+1NSVLrLPGjAkAkzwWNN9tp7v0l/v9TKu5d3Vr/X6dKwQP9A6jMTTpiER
         tBGF9wkI8xl7rhnrzAxq0uygtap6+tqbaADy6SwH4VD3ZPDTQikcnfcvkPnsyKbquGWy
         5m1nO1VJ6DW/DImURWOQTKXeIJ7a4r8MamDnT6cjzlPwv7oO0p9Dfv8PrB+q6CnF7bHH
         /vQMFiRxNWwjZ+rqxa1cFxF2RW5MswfsQrtTXp/PAZ2r8n0kqnyC+ZZgLp1ost4eWzSq
         oGWw==
X-Gm-Message-State: AOJu0YxU1wB7Rnl0ykH99/E3Fph0GYVXhkL3PjhvrMFR2lNu1HZYZUJl
	dQaTqobzgiT92qqyIymyIGdj3ywRhq+gCmtMs2emV1bMbz80oEKDpSHsBhA=
X-Google-Smtp-Source: AGHT+IGZ/O9t/JF6aTkdeCVq+a9NYSexAZ6TS8S4X42JrZuBflLCJoZ1jygSF+hrzor3cHWh3KsiRA==
X-Received: by 2002:a17:902:e852:b0:20c:61a2:5ca4 with SMTP id d9443c01a7336-20cbb18357emr234561655ad.10.1729110863229;
        Wed, 16 Oct 2024 13:34:23 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18036585sm32618065ad.138.2024.10.16.13.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:22 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 00/12] selftests: ncdevmem: Add ncdevmem to ksft
Date: Wed, 16 Oct 2024 13:34:10 -0700
Message-ID: <20241016203422.1071021-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of the series is to simplify and make it possible to use
ncdevmem in an automated way from the ksft python wrapper.

ncdevmem is slowly mutated into a state where it uses stdout
to print the payload and the python wrapper is added to
make sure the arrived payload matches the expected one.

v4:
- keep usage example with validation (Mina)
- fix compilation issue in one patch (s/start_queues/start_queue/)

v3:
- keep and refine the comment about ncdevmem invocation (Mina)
- add the comment about not enforcing exit status for ntuple reset (Mina)
- make configure_headersplit more robust (Mina)
- use num_queues/2 in selftest and let the users override it (Mina)
- remove memory_provider.memcpy_to_device (Mina)
- keep ksft as is (don't use -v validate flags): we are gonna
  need a --debug-disable flag to make it less chatty; otherwise
  it times out when sending too much data; so leaving it as
  a separate follow up

v2:
- don't remove validation (Mina)
- keep 5-tuple flow steering but use it only when -c is provided (Mina)
- remove separate flag for probing (Mina)
- move ncdevmem under drivers/net/hw, not drivers/net (Jakub)

Cc: Mina Almasry <almasrymina@google.com>

Stanislav Fomichev (12):
  selftests: ncdevmem: Redirect all non-payload output to stderr
  selftests: ncdevmem: Separate out dmabuf provider
  selftests: ncdevmem: Unify error handling
  selftests: ncdevmem: Make client_ip optional
  selftests: ncdevmem: Remove default arguments
  selftests: ncdevmem: Switch to AF_INET6
  selftests: ncdevmem: Properly reset flow steering
  selftests: ncdevmem: Use YNL to enable TCP header split
  selftests: ncdevmem: Remove hard-coded queue numbers
  selftests: ncdevmem: Run selftest when none of the -s or -c has been
    provided
  selftests: ncdevmem: Move ncdevmem under drivers/net/hw
  selftests: ncdevmem: Add automated test

 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   9 +
 .../selftests/drivers/net/hw/devmem.py        |  46 ++
 .../selftests/drivers/net/hw/ncdevmem.c       | 773 ++++++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   8 -
 tools/testing/selftests/net/ncdevmem.c        | 570 -------------
 7 files changed, 829 insertions(+), 579 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/ncdevmem.c
 delete mode 100644 tools/testing/selftests/net/ncdevmem.c

-- 
2.47.0


