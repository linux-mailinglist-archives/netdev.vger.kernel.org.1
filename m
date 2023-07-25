Return-Path: <netdev+bounces-20989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1678762176
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F25281A38
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4002418B;
	Tue, 25 Jul 2023 18:35:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A023BFE;
	Tue, 25 Jul 2023 18:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3213EC433C7;
	Tue, 25 Jul 2023 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690310099;
	bh=lnDJDryLE/s2hFOhlSzvGG+STqo8cq44OlY3Bnve82M=;
	h=From:Subject:Date:To:Cc:From;
	b=DyFAMNXOEEZyWJRP3y+wbiIdmDGMYhFOVA0NpIwMKeN9AyYBZ4tPX2OFcEykoB7uP
	 Hr8N6Ealk6wBjI/WdR3L3xHkvFShFvnrsxZAuFuCJHbhzWzksCAghjFYXpDPqHfnwu
	 P2BAxFbdALVU1tCdo8JPfTAydKsYp3XmVPPICAznH9Vtb06XhBh0yJA9QEAYQDvcx1
	 2zBegteRn7VKE5eFRqSJhuysw/Pj/OhSv3zMqGeg2TxOySx9SJ24eE5uCOEPQWfXi0
	 BEn3c61e8YnsZFv4byB/LX6VtuNhY0zYSQUFHynNFqMi+lRnYmDnckpQpOHdgcrs6u
	 R8Uy0wolpEu+w==
From: Mat Martineau <martineau@kernel.org>
Subject: [PATCH net 0/2] mptcp: More fixes for 6.5
Date: Tue, 25 Jul 2023 11:34:54 -0700
Message-Id: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM4VwGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyNT3eLUvBTdvNQSXbiIqbllanKKibGRWaqFElBfQVFqWmYF2MxoJaB
 KpdjaWgDDbgfSaAAAAA==
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geliang Tang <geliang.tang@suse.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

Patch 1: Better detection of ip6tables vs ip6tables-legacy tools for 
self tests. Fix for 6.4 and newer.

Patch 2: Only generate "new listener" event if listen operation 
succeeds. Fix for 6.2 and newer.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Matthieu Baerts (1):
      selftests: mptcp: join: only check for ip6tables if needed

Paolo Abeni (1):
      mptcp: more accurate NL event generation

 net/mptcp/protocol.c                            | 3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)
---
base-commit: 284779dbf4e98753458708783af8c35630674a21
change-id: 20230725-send-net-20230725-579ecd4326e8

Best regards,
-- 
Mat Martineau <martineau@kernel.org>


