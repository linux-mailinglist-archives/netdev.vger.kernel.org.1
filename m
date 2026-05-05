Return-Path: <netdev+bounces-284532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNA8J8Yr+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:41:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE3B4D2382
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA7FB3058E45
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D40F4A2E32;
	Tue,  5 May 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="kbWzN9tg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF764A2E24
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002865; cv=none; b=UtmH8fmX4IJ+Au7o+9fyuyYAiQ7aGxNn7IOfl8hXO/kEXwyWeh8wRqb//3/BJbAmI62Gbh3MbWy1YM88RZpqslUtpzjGnfDI1u57mS2V+qPeFqqZIhJUV7kCfTZwcfmPdvixzNQAk+vzIXOXTlYUm9kMPmqec/ywFKCKoy1uE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002865; c=relaxed/simple;
	bh=UrSBPzz0WOhCOID0RUusbgSn2UbTPXFPT29YpjUxo78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UL5/RQt93+6/IkLZBQw8aJL3hr5HWZD5+fSNdlJaH/R0aWh0NkU28rk6AhYQfX+S/bgRTP6+XZqRkzwgJwxgDDz4IpWKfQR0z7Be4553YCVC66N+eQBT+meHlk1lgoDRVttO1ZUh84x1mrY7gfxZrz/hJ6z/GBtyWDBdKlc0/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=kbWzN9tg; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-47c918c62b4so1794563b6e.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778002862; x=1778607662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vPeQF7UXUWJwMSwkbigtxLUlS5whi210Wp1HrnHwwYU=;
        b=kbWzN9tgoFM8VPC5Wzdy4ca7hoIZqPaoIps2oitUOutHDflXwHpOoeOeMR+leJhZAQ
         9FrVXOmkc768jaQZQ69N2ozM+VlHJOEIB2t1lfI0X+rWCtEvea4uiiXxTQLbWLBW6G0a
         IhHWWqCbluwsQ4hgNRtBRkrbfHxsVyUjTHwIuv2Ahdx50qUhMuMiGMYtRJ5HEXrTzNXT
         hej8z/Hyc9SDE9kcoo/40wvffrqHKI7yrwmq9ndGc1prLus2kYFVdUA2mNN7v5rx/2+2
         mimYpvrwOE5HQqohYpS7vFRe/U3ygbuoykREjXGkNKCpUfDK8tpr1AOb9EsfMuvmvDXY
         E6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002862; x=1778607662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPeQF7UXUWJwMSwkbigtxLUlS5whi210Wp1HrnHwwYU=;
        b=c6/4/gcHrw2Gtoj3XxLzb/Yrz30N7OWzM23CZyXp4hs4nyR0AOC0RKz6WTKyjyIurU
         N7RLySswAhgqfMcs6APEVfO9X2fszlxLlcnuLab5Gkbc0rvx5hYWnm0i1kw5dVGQ8rvw
         r18foeL3kzx8/hOCz158coWeIe82EZYFB9NGu1g4923mCvbGSIBSnrNOgOVNsjMvs+m5
         ceWLvran/373cEbu7aK4uj+9zspMiEUDv3LsxynCO1pjrA2nM2O8DUz/YguNvh399wiH
         i4cBMWY/0WrzQFl0Es+pLjGy/yPDHERMfz5xZAiMxGFvSi4BpPd6DwKjMPibzJ7AEtqP
         CLtA==
X-Gm-Message-State: AOJu0Yy6TvJj6CNq9etz/bkO6nfrR/P0zNNIL6sISt+UBI6J5FWXtXa9
	941y3jTtm8kk7ifE58i5kqTtAKdOCTpWYy+Jw/EZ7UbgMlllJnw9wdGnYS+IYyxqCTi7TU8OT4v
	oaKsx
X-Gm-Gg: AeBDievXY7HkqXmn7vID7N1Ku8tsRHVfF+5xFrcDrNNKJMim/hl6xOst3i/bdUNFtHz
	bl/npBgopi4vIpn4UjT1kQhpFoKuCJibaR0A8bVTULhrqqdr0j+PVW8puEqqMQ59n+fKh/18cnJ
	iFSFsodoSW5eyzhrxajnBphIp6aojyhXfSdc32jsKfDwyEmEAIw1PtKIFOLH0kF+6/FJsqhi3e6
	/+U7F/arVAbKIlf60eaakRtD+lE1DcKFVUhy3zOB/u8m+IZOewSUUXm3TT2FxDWSTGZp3l4Q3Fv
	dM2w2O8v+Gt9MZYN76bK4Qc9nglF1BsppvdJ9RBobR/z42m/EwEA77Ku1GKDI0FeTgWkM2SktyL
	1qOOWCYrNgXH7MfdFOOX4uvICwk+UO2+PvdccFLIwc7avhORsHdqwzx4+F5tedLZ/PK+cI5sQfH
	yPi4+hTBjDTj9ScmXvgog9hIbue5Ryd7O49nlmJUNMJODfsNuFQWOgTw==
X-Received: by 2002:a05:6808:199e:b0:479:f0a2:d213 with SMTP id 5614622812f47-480420c3617mr25891b6e.13.1778002862543;
        Tue, 05 May 2026 10:41:02 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c769c9b12sm9006504b6e.17.2026.05.05.10.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:41:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next v3 0/5] net/sched: netem: fixes and improvements
Date: Tue,  5 May 2026 10:38:40 -0700
Message-ID: <20260505174059.651260-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEE3B4D2382
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284532-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]

This is a collection of improvements to netem found while
investigating the fixes now in net tree.

V3 - fix the multi-skb corruption patch
   - don't count ECN as dropped
   - try and clarify to AI why statistics are ok

Stephen Hemminger (5):
  net/sched: netem: reorder struct netem_sched_data
  net/sched: netem: remove useless VERSION
  net/sched: netem: replace pr_info with netlink extack error messages
  net/sched: netem: handle multi-segment skb in corruption
  net/sched: netem: add per-impairment extended statistics

 include/uapi/linux/pkt_sched.h |   9 ++
 net/sched/sch_netem.c          | 206 +++++++++++++++++++--------------
 2 files changed, 128 insertions(+), 87 deletions(-)

-- 
2.53.0


