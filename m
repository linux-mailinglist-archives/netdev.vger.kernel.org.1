Return-Path: <netdev+bounces-133822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B4A9972BA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC861F22BEC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C631A0B0C;
	Wed,  9 Oct 2024 17:12:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA51974FA
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493976; cv=none; b=I+1WAE6XY1FT1Unwi+4oApi/dmqGfeTR046lA5o1jp6ULk+2IM8+Fqccf8/6W+2IgDAfN+PeDLIdROFSdf5togwlJma522NbLubjPsL9Q+XKQhXkwPGShuEMyMR8Jp87pBqpsZ++x8oH4UsppYLQFO7Vst+1LNOWw+apsOwKAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493976; c=relaxed/simple;
	bh=cBThCaPqAFQxgxw17rsPz9Q4kdonuuOwkzDDjeTqKRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1+5i0LUiMRVpHDdL51xNWHWYGC2vP5i3CzDtuCTCufSPn2zg89bvgFpE6rnCSNds68REaxlAEOjvPGH8IbVY0fsVAmoF4YoTQO/Bv/MJ6HqV1czSp1axhkZXB6UotfWs4ZPAokxJVuuse20NbHsOYpNMm8XvlbwFSYWIklsS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e053cf1f3so32682b3a.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493973; x=1729098773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4MH+OVopgiP9KTBosr1WQuN8qhtEA0FVfO6WhH4iJk=;
        b=ENM2AYZGl4mxxwJUERJU5r+DnuM9WP0L1FiMhnMrnhwAv5J72hXuntFGjcxGCyBrmz
         wrlcH41yjF4NIJhPsVbbvuGHKos9G3k4hlG1CAlC6Nzs+VFar9IdAUMPziQuQrg7KXBm
         xW42kdNc1TpX5qd3g/VlzOKGOb2Pn91UwgXu0DpRm7KoI2Jrqe/tsInYo42Y+5jj52Wl
         8j25WgG6+BrrW1N8uEMmM9Cm9vhZf4cLg8nxNBxRZfSYw/5WnuNqQ+2wIQwOfkV9BWQh
         J/a0KQ1dSbB78XeZb+aA5yat1sif6gAlsmEVkEcF3BSVEM6H8C3j40Ql1s+BHqWhygUc
         yOgw==
X-Gm-Message-State: AOJu0Yztn3SYLZfb7va5Ez5c5IEi+sDVn2ZgRb16WF/3bU3glQNGKKt4
	bY1JQuCNCWkLzFgtcnAMIabZ4kmQwHIS6xXg+X8O33xNR24nkfC8SnVu
X-Google-Smtp-Source: AGHT+IF3ThYYyDo09M78eEFdKJy7bJFwX3XAcGcrr3TRhTrPZGAuSTU+1PxYUpMP3ddac1K/LlHNKw==
X-Received: by 2002:a05:6a21:4006:b0:1d4:fd63:95bc with SMTP id adf61e73a8af0-1d8a3be149bmr6360666637.9.1728493973566;
        Wed, 09 Oct 2024 10:12:53 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4530dsm8032460b3a.102.2024.10.09.10.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:12:53 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v3 00/12] selftests: ncdevmem: Add ncdevmem to ksft
Date: Wed,  9 Oct 2024 10:12:40 -0700
Message-ID: <20241009171252.2328284-1-sdf@fomichev.me>
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
 .../testing/selftests/drivers/net/hw/Makefile |  10 +
 .../selftests/drivers/net/hw/devmem.py        |  46 ++
 .../selftests/drivers/net/hw/ncdevmem.c       | 761 ++++++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   9 -
 tools/testing/selftests/net/ncdevmem.c        | 570 -------------
 7 files changed, 818 insertions(+), 580 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/ncdevmem.c
 delete mode 100644 tools/testing/selftests/net/ncdevmem.c

-- 
2.47.0


