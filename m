Return-Path: <netdev+bounces-275259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKxJCP5E0Gk45QYAu9opvQ
	(envelope-from <netdev+bounces-275259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:53:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BFD398DCE
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0134E3011C53
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E9377017;
	Fri,  3 Apr 2026 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="OpouKcV7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E73624A7
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256814; cv=none; b=Rnj7dq7EkfZgPgiNirOOdx//6aMs98KW9oeLWwkvvvgO1dLCDWFLhSfbmcXyQoaqAxJfbJ/JP839tMfMNIetF2aZojNoa3bUzRB5zfDXt4M2IQu/IzPrX6oD8F79Y6dA/seT5og0+oRFNWd6kD6/++IeLBL20V4aQKPtZv7PmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256814; c=relaxed/simple;
	bh=tAguzb4GYeU9DZLjxfOcnXlVOpBJRbiBQeSXNH1YxbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZZXnUR1CxxPzFMHg3fJu2aQioqcV3DyEjUL9z4VrwP2tS168ZtLtwOz7R3/DxC3emruG1WMmPtYOKLO8Zw/B0Eeyc3+Ti5jGl8UUT3CEegBu0orwm4Ud/HN5lDBAZOwpszeY6x8fX6ZeccbDyzQa6EGznClkDYa4fG7yqyF+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=OpouKcV7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d965648a2so1722692a91.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775256812; x=1775861612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHgxxq5e8UjRyt6Mxwq5aHvSKk4szsHzms2QSLd0f3o=;
        b=OpouKcV7hKZqnVdT60EIFjiD6XGVPz6QTE7PlFa9OTQoRT6wAPvKp7qVEqBAoZMftc
         iu0cmJrnaEmuHlZwWVtqfNWS+liSo9Nvjhtm6rg6h4X8cOSKKrEDAr5XwqX9A33OzH/r
         2iiFVW5qpFGHGfYZ6dZY0yffsKB4rdbkISb5u3K/lAIboJxU3yChhKbWJ+7k0Bdh4Bx7
         i7j+AbdolOUz/JuKE0Vk6oTFErjSYq2m5eHQ3QNDVjmmyBLfbc/hB9cbztOfvr4mGgme
         JsXzU4UGhxOQWLN/jrIwuN7hi8ye7OiE6XYyHwllyKaB0gVIRO4HnJa/QHV+ceBffHIG
         FSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775256812; x=1775861612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHgxxq5e8UjRyt6Mxwq5aHvSKk4szsHzms2QSLd0f3o=;
        b=jGuSMxtmcHsYJn0sVA1gr5m9Jb2zqeo6fWkzArsy0ZJ8sc04mXYxCjryUZr1mMuGVA
         jiief8TXiubEybwjp15PgBqnqgGsFcLyb7h1uGmIzcz2JfpRotekevixAs2sMurgnzeJ
         WQmBOxYKZLgWpgsijxUDWEztLW22LVW3v8ZmUFjH7ezI1HFqzEPVc9e3wgwOpYWzCk3F
         5YYytt/R4M/PkxawUH2dkboHrfXLzSiQP301YSi8OvvgKqfKyQeUGreim4pAgYjmQ8GU
         u3W2fOg/jBdl21DSAjBN+NDKLU1s+O42HoUzi9e8WLhxI+Z/x2wyV2otc+HU+XdXvd0t
         Rc7A==
X-Gm-Message-State: AOJu0YwXl1jX8Sp199FnfVCMUe593twl0RmGI3ygQonqPXD+gBGwc1XW
	a+Yza5uNmg78XA+Tp5b9mUlGeO2GnRQCFzJHz7sd/g2GKv77ARI2rOLNAcPBxpcDixmV5LedD5N
	tFlnS
X-Gm-Gg: AeBDiev01sVCvoXuTXs9jYAMydxLydmTUndSylITjDOc5jmJSwQJTOr5aqroaAdUuIo
	tpNgcQY4YJ7vMbKKNDcEtNURZ/B/HR0ytkgv3NOxzLkegF86lxSeW8yb3P30HMf7nEm7FmpB2OK
	4PXzDluTmvG7pDsuIPLDBRBLDgjNEPmRLKaLdAmlLkAzakOeveXjGIjrnW8muCaFOnjFRfZ3r92
	FUSSu2JSw7a9LM+2XkXFIXs671Q2H1gykuWQ78eA0ttFpPhc4XpnkIKSop2kr1WxwPgDqPLeZVp
	FbTGjTjb7Cjr9tpmDsSDTFGSSZ2isp+mdsDlCOAkqFlqxD052zA29J5EgqU0SPitPE4McRcA79c
	5+GuUooAgix8pFCar4kEG8K70OhZVx7GJo8JuIW43PsrW96yfsoGk2tU8M4uIz2WJkdgK02D+7t
	h+d2o/6oFuexJBd/Elh4joio7k9P/UBcS1
X-Received: by 2002:a17:90b:268a:b0:35b:8d89:7199 with SMTP id 98e67ed59e1d1-35de68ec6eemr4057138a91.15.1775256812514;
        Fri, 03 Apr 2026 15:53:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de5197472sm1624944a91.1.2026.04.03.15.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 15:53:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next 0/5] net/sched: netem: cleanups and improvements
Date: Fri,  3 Apr 2026 15:52:05 -0700
Message-ID: <20260403225324.476787-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275259-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:mid]
X-Rspamd-Queue-Id: 71BFD398DCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series modernizes the netem qdisc with several cleanups and
two functional improvements. It is independent of the bug fixes
that are in process on the net branch.

The first three patches are housekeeping: replacing pr_info() calls
with proper netlink extack error reporting, removing unused struct
members that only existed to declare enum constants, and dropping
a version string that was never updated.

The fourth patch adds per-impairment extended statistics
(delayed, dropped, corrupted, duplicated, reordered, ecn_marked)
reported via TCA_STATS_APP, following the pattern established by
RED and FQ_CODEL. A companion iproute2 patch for display will
follow separately.

The fifth patch improves the corruption path to handle
multi-segment skbs using skb_header_pointer()/skb_store_bits(),
replacing the previous code that only flipped bits in the linear
header region.

Stephen Hemminger (5):
  net/sched: netem: replace pr_info with netlink extack error messages
  net/sched: netem: remove unused loss model fields
  net/sched: netem: remove useless VERSION
  net/sched: netem: add per-impairment extended statistics
  net/sched: netem: handle multi-segment skb in corruption

 include/uapi/linux/pkt_sched.h |   9 +++
 net/sched/sch_netem.c          | 112 +++++++++++++++++++++------------
 2 files changed, 81 insertions(+), 40 deletions(-)

-- 
2.53.0


