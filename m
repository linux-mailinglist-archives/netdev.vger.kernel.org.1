Return-Path: <netdev+bounces-272790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGzzDrYcyGkShAUAu9opvQ
	(envelope-from <netdev+bounces-272790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:23:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE1734F868
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1EC7300BC41
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F1374171;
	Sat, 28 Mar 2026 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="a1NxZKWC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0865322B72
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722222; cv=none; b=TSstcIy6Sk6wJsKx507Mqf8wD7fUe5X360BdIkL4IaNmmbMyZWDZ277eqQMtU9lq4Ry8dgR2pL/x1bhZbr0N7FoB2e++s9yi/IbJazZUlYOSmjnXnrPwXImungFn7Fh76PLcBMJeTcPo/5gNlvI+Q7GOFKuQaYtrMHQojsVySL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722222; c=relaxed/simple;
	bh=UXf9Js4OX6tTkSIzHkuR+90XKZwQtpBNs8i5n5HWXjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHVdwxSj8NBh40WnXJpoIx6gJq/zh3JdWuRiGfLg6yKC4Wz0zhDpH1cb0cTcY/18pPlIPW3SPJARi5nhFwkWDSJqURLY4OG1VUjIb31QIq7jeyyEVQa/s4etEWFaatG4BS81Mb7ZOUsPDVyWZOoCvDB1011q8zsPcAHHLZ8W5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=a1NxZKWC; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12713e56abdso1221922c88.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722220; x=1775327020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ck8SaND5LSVaKjpPu/DWpG6HZzjjicvnW6N+Jnt60/g=;
        b=a1NxZKWCV5D79JpqGOGZCPsIRR0zxGxtdDh4SQQDimo0fipVWh7c25ov9WW4x7xxqo
         mw6pk3+m4HYEoYvE10ilfaNIz4DbnFZwobFmhk9/bvO6vgi/7MaXc33wIQvNGwEp+fJ9
         0QIrOsccBSxI6/VCiEvXWuTcTW6q/LMwC7JMmbY1a4h4xyQjZOEVYNqujSrlN6muzSTB
         lF9HZNhVZtMCkSiT4BUEGsuQUeHoq0PUXy1O99Ix6yVIYU0x4tW+9GRsuBUADjDzBXVS
         PS1sErRTVFO5XaHzmFP5jrgynMjGpxK8ZawmPCl6lSeCvD/H2YIsLkTKDttxBh2/flBm
         olKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722220; x=1775327020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck8SaND5LSVaKjpPu/DWpG6HZzjjicvnW6N+Jnt60/g=;
        b=qmWsSnJ7HTbIM9vP5pM+4SsPMm6n94zPKXwKo5SzkjRogDea7jrTM1q0MmQA0MhlNU
         uhZ0HNvT1/kNR7gJB4aWT89+c88rItUmRxHXngx0QoYa+6JhclGW/a/Xji2vmsPIyg/E
         Ysxcyby/hncXr/E9S+lJqiVowNMFd+yfMOXkJa9NAk7HdCp4n3hE3gdorczr1J3YUjF4
         4QP0dveUyfHqvwtkHBy9xS8JEAHwks32QlSH3DVhpVJQLQkAYwM3Kx43lpeDuco2jCAb
         lZUrhdSAH/R48jAT5SXh0ZdHlX9B6fLR/Hz4Gz9KrgDTMlc/DKpPvrazGKoEZlJUFKS8
         aaJg==
X-Gm-Message-State: AOJu0YyvUAQ83N1E/srLneW9PtslMO87BrDR0SjuarSN8tV9Q2Tc4+ze
	+FHRzJCLp761QsNXrtAicOUmeKGLAc6rctbf4w8VACNqjFh3Ib07NLi93lwscRhPeDTs0QKtJf4
	y/aeR
X-Gm-Gg: ATEYQzxPm71omA4lXivV2MOg0rdbTb7f/SRByW92sQErKghwfBYtahvfke+vqXLuDZJ
	38cHBhQqG22H0yMRqXg8ll0zXRG+JMjRLYG+npttopAPV3553amoovlBLQ7Q3qUZl78SQ+8Ik7T
	kw9O/yg01aMUAIlDIt5ZbGHNVoOsv9+b60kt2VXA7AkinLFliJ23Ng0F6vZASyjyNQnlzTNruWA
	pPWdyi7MOJbSexPF6roHr5ssBa1bt81VGmvqxh1DZMZeHegZON9cgvsaMVKZ8CFiCFkEIKUpByY
	CXv5xn6ectdFdlrnkkjERGtYSGT7TBJY5Y4zMa/YHowBNNuVoTuMjkUX09VqbrCQdKCNdIRPJWo
	iARSaQmrF6sRMksmTH/huuKYat8WTdogGU0K38j332lHrtVlHhLgDmIXY6Ihv3tBNny/cxfomBX
	OUPgiXIJSOIr8BGxyMbl+kH2vezg0rXz3/
X-Received: by 2002:a05:7022:218:b0:128:d2b2:143b with SMTP id a92af1059eb24-12ab2fc895cmr2839251c88.9.1774722219965;
        Sat, 28 Mar 2026 11:23:39 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm3133008c88.4.2026.03.28.11.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:23:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net 0/5] net/sched: netem: bug fixes found during AI-assisted review
Date: Sat, 28 Mar 2026 11:21:44 -0700
Message-ID: <20260328182336.392817-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272790-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: EBE1734F868
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These bugs were identified while using AI-assisted code review of
sch_netem.c to analyze the packet duplication re-entrancy problem
(CVE-2025-37890, CVE-2025-38001), which are addressed in a separate
series.

The review uncovered several additional issues:

- probability gaps in the 4-state Markov loss model where
  boundary values produce no state transition
- queue limit check not accounting for reordered packets
- PRNG reseeded on every tc change, breaking reproducibility
- the core dequeue re-entrancy issue with child qdiscs
  causing HFSC eltree corruption and DRR class stalls
- missing NULL termination on the tfifo linear list tail

Stephen Hemminger (5):
  net/sched: netem: fix probability gaps in 4-state loss model
  net/sched: netem: fix queue limit check to include reordered packets
  net/sched: netem: only reseed PRNG when seed is explicitly provided
  net/sched: netem: restructure dequeue to avoid re-entrancy with child
    qdisc
  net/sched: netem: null-terminate tfifo linear queue tail

 net/sched/sch_netem.c | 222 ++++++++++++++++++++++++++----------------
 1 file changed, 140 insertions(+), 82 deletions(-)

-- 
2.53.0


