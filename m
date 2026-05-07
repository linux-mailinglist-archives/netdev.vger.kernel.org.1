Return-Path: <netdev+bounces-285247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMUnFUlw/GmkQAAAu9opvQ
	(envelope-from <netdev+bounces-285247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:58:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A14E71D9
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6D063022577
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8B23EF64C;
	Thu,  7 May 2026 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1qBTvls"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F0313520
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151494; cv=none; b=gKFbTeDOarYXHnv/rkPNOnd63dms85TMi8jVCwi89UWnjvD+tuyAyfPkLnzSKgwJuleDmQdDFJ6d9GpTAnVUUtNBiiXCzi8zpHaLQGNUp0ew5ldswShZ146QnT+up3hKbUeE4AlsZxLlS5S7xK9q7zIofFxo6DpL4+cY4D3KhlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151494; c=relaxed/simple;
	bh=KDyR+OrrNlAu2ayv0jsJpH01ZNNW8r/iaESMvFPjkq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGyjmd/B/CIpZgZ0dpdowAk1EFRbB5YA3FwwJihN2HQMcjB7DJX/VCCJ8ZDLIa24xbZRTOI3s+1o9P24sNBrhxNyzNvJK5Dx6dObvQoN+qRYzoPhuSfuaxgwXdzh64cHHViMB1+DRuUTBedRUMSkFEByC7J8GySfyjGSWU4Pbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1qBTvls; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8721851e2so634902e87.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 03:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151480; x=1778756280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8sM4rzQ8tb7rg7dRckHCV2LR59wwtkKewjtgiOctmrs=;
        b=n1qBTvls4DJVk/iqJi6DofzH31O6QK5iudBlgDM/w1CAXIAbDH4ZV8Wn/0vVyQYvNK
         vUgNmr6u1cOZgUmJhtmyOPU7fC5P/J11Kquh5SqlGyzb6B3Krxc+CgDzfAcdSHj8NoVc
         xrotp/UsDyR9/71btKQqvUf3s86QkFVwYH5bgSmrhmdmzTVIkfjpfCKa2rRwbVmmE/3L
         lRetR/XrmU9MXRnBULlW32R0JzyU9ULQgEMiadsLz0tf0S86OUsUfpHT913hrKsuQ2Co
         nscrWcGA/UIRmkaFEqwq1iLOZAJlsDsNNlWeCJo1CzePH0JdF6bn2Kjs6Dp4xhRzM/4B
         Wi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151480; x=1778756280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sM4rzQ8tb7rg7dRckHCV2LR59wwtkKewjtgiOctmrs=;
        b=nB6Qm1Ow1kDbJ+jv3/BjwOTDPjnQWHwwFslfBinaDhxMn4lHMKjVNe+JvRtKDmFlHz
         jBxE5hKk4J4sdxCoH/iiDPe3Wvxw2viM2JohxK5gQ2Dz7k5VEXyW49Ca+k2Lt8iKr/Jp
         iAihjL/pt1H3laTvf6/6zwrP3ZoQ534bM6f6ZA6sxo4hDYFpylE53gjQiH4VYHfkg+Xt
         yjQrFcRShQ3VFeI37cs3iIAPMdP+tn6Vo4qSdipLJkc2WxB5iVohfJ+P0T8cHiwNsY8N
         XW/EohYSKxClEUIi8Qap4BXG/XGPd3a9MzFJTVbgHiUbFw5VbuMfhJ1+J9aJ0QY1LpWx
         Ym/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/zSlfkR/J6N2ra2RMJUOxMhQXfhy29+IzXMm7Qj5CcHiEDdRQ1N1unfwPi+nnpdZ2UFrZrt8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqP0NELwldHL/tBOQqzaYgFO+lETJ7jAZ55cmAVoiZ0WbiHXqB
	tV19p3n27Ybnhuwwo0lVlbj8U/dVrnaTieHQlxk6ZWX0KNHUx1IPtQh8
X-Gm-Gg: AeBDieuNaCcy0Im29EcC+VzU5+817aZwDx3BYrxAmHk83n+VCnkxHCElrRe7TVTQAax
	nREl4Awj5qN3HF/St2PRaJhZNG/kneWKCdg0TD0D9/f/pEfR2+bN85+5SaEmBf0vw8z9vxsRCRX
	DLr5B9RBHkUUQsMwK6giooCaL2fs0SJQ+lXHDYWXccFeNyCrbcfpWQF9KEj1IoZmaLXNpRnPCkf
	CIWwwGn04GtjhRwWnRMleJGCbm1i27h3LBIiP4/V1PSf7Dp5EhOzYEbx0OiUqj3ooxkjlrkKu3L
	xXRmf5t0D9cN9kQjCg2t/BCemobJUgtqgDiUrPlwvLyQ8xJiFBwhSUql7ioF8YQJGi806KKnm8V
	Vw83QimZGi1ivH2joL1GHbbw2eAt8pkTpKSW2TNnWCJFOQoA3akDEblzYM+HD0A8f/jPSHRE8Ju
	hd4Zr68CcvfF3GqQMSUivjYk0BnZ0Vur2la9iLrLLzYQVaToIZeSCO31kvVDsCykrNo4ZuMW6vJ
	Cs=
X-Received: by 2002:a05:6512:1154:b0:5a2:b8cf:39ce with SMTP id 2adb3069b0e04-5a887ae02a0mr2768403e87.10.1778151480147;
        Thu, 07 May 2026 03:58:00 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm5533962e87.65.2026.05.07.03.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:57:59 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 1/2] sctp: Fix typo in comment
Date: Thu,  7 May 2026 13:57:58 +0300
Message-ID: <20260507105758.25728-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA9A14E71D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285247-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[shofiqtest@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Fix a typo in a comment in sctp_endpoint_destroy(): "releated" should
be "related".

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 net/sctp/endpointola.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
index 8d342b5141..dfb1719275 100644
--- a/net/sctp/endpointola.c
+++ b/net/sctp/endpointola.c
@@ -209,7 +209,7 @@ static void sctp_endpoint_destroy(struct sctp_endpoint *ep)
 		return;
 	}
 
-	/* SCTP-AUTH: Free up AUTH releated data such as shared keys
+	/* SCTP-AUTH: Free up AUTH related data such as shared keys
 	 * chunks and hmacs arrays that were allocated
 	 */
 	sctp_auth_destroy_keys(&ep->endpoint_shared_keys);
-- 
2.54.0.windows.1


