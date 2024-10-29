Return-Path: <netdev+bounces-139827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6209B4526
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8422818EC
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96B81E04BE;
	Tue, 29 Oct 2024 09:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8118E35D;
	Tue, 29 Oct 2024 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192563; cv=none; b=syB3KnBP1vXOTY3Yzts9o3T5z8InXBdR2vpemgg++WFZ+NmdSYJz/nnp3kY6vIG2GBJ1rbc84BLkLrtGi3cX9RqWgk/3qXiGZ9r689qzU6NP/1KvWmvzsNK5t9AaCsUBZ0AJYCczHtmxS+Qzyd7R5jB7hM4mjJzPM8hqm5g0nD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192563; c=relaxed/simple;
	bh=EIa+fsNWb96v5GX8xVCCAXgTItn4FUHLk55wnKJiZok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIukRlb/efTluJ6vuBBomAY23QThU9PJT0gsv6f1kNe/H9d9bV1SX9PAhie7GwtrcQLPvQlmDhEiV0YWLStuA1b0y1W+DjLjkEGfhUjRZaL2Br029KYF+fZKPo+iOlPXDXqV3JpeiXvVlPQfPwnmPn8CwuvQKKP/iglNuabMbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso7318055a12.1;
        Tue, 29 Oct 2024 02:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730192560; x=1730797360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Er9Z6DPKGNKiOWSF7KSU2JF3ZFz2j8ab701+SiacTIg=;
        b=PuOJTc2fCUdVWGBz8ea83BpyrbLyZ+AmShb+RJg5SHmbY4x0SfBsX2FfogxAO1vhig
         7mYTwXHeIxEDPgrT7T332x1kbBQTHYHE3hI23buE1b6S5hfJMt7sYWwRnqaf42N/Ar1A
         31EneOWBVj40fCM8vkI1PrjGaB3KzIiJ6PI+GCgOe5GkMhoYNkrpIXpEfDxnKVhlzP6h
         DSdoefrRMTDz5rFZYcFohYwQ37IUi3w/V/NbGFTGdx+aBRcxmNBYvfIxdU7Y2chyNakB
         Lp3AplmQQRGJ297Y415n5IYQFttjDQE6RbEvW/Fq2QRzHToLsS2h7/XAqM2TANwROsiz
         BuFw==
X-Forwarded-Encrypted: i=1; AJvYcCUCX2k+RPSuGmFYXG0t4oBlqRnx0MafV1nNyA1j6Dd/TNc988XsRoKQOCYsZ29V3OZAuwV4S9yNec3XzL0=@vger.kernel.org, AJvYcCX5b+9AKSt2moNnD2+vzsSZ1zK502lzHj8ntbbOHpQ9JpOifM/Yanoxc0Ax2xEJHte1BCnXqi3o@vger.kernel.org
X-Gm-Message-State: AOJu0YzTdIukkxF5U6/eOH4ZzBSyCq3wGSf77Labp/Q1Rj91GCIVDp1s
	+nycF3M8rNkUftdpRnuV05ex14Wsie/a2NBEuK/QxyeAtkkSUWUw
X-Google-Smtp-Source: AGHT+IGX91wM8d0Bi7fiJlvrKkYsWhglEURMbK164EkmlnKh/RJV9FSdETYivcanab9cSa43SJk5lg==
X-Received: by 2002:a05:6402:3495:b0:5c9:584d:17e2 with SMTP id 4fb4d7f45d1cf-5cbbf8759f4mr7681961a12.3.1730192559744;
        Tue, 29 Oct 2024 02:02:39 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62a5e6asm3797443a12.39.2024.10.29.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:02:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	matttbe@kernel.org
Cc: thepacketgeek@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com,
	aehkn@xenhub.one
Subject: [PATCH net-next v2 0/2] selftest: netconsole: Enhance selftest to validate userdata transmission
Date: Tue, 29 Oct 2024 02:00:27 -0700
Message-ID: <20241029090030.1793551-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netconsole selftest has been extended to cover userdata, a
significant subsystem within netconsole. This patch introduces support
for testing userdata by appending a key-value pair and verifying its
successful transmission via netconsole/netpoll.

Additionally, this patchseries addresses a pending change in the subnet
configuration for the selftest.

Changelog:
v2:
 * Use 192.0.2.0/24 instead of 192.168/16 in the first patch "net:
   netconsole: selftests: Change the IP subnet" (Petr) 
 * No further changes in the second patch ("net: netconsole: selftests:
   Add userdata validation")

v1:
 * https://lore.kernel.org/all/20241025161415.238215-1-leitao@debian.org/


Breno Leitao (2):
  net: netconsole: selftests: Change the IP subnet
  net: netconsole: selftests: Add userdata validation

 .../selftests/drivers/net/netcons_basic.sh    | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

-- 
2.43.5


