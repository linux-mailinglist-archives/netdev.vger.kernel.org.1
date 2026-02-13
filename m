Return-Path: <netdev+bounces-258575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBPaHaLWjmmhFQEAu9opvQ
	(envelope-from <netdev+bounces-258575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:45:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF80133ADA
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4471B3018738
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8195330FF21;
	Fri, 13 Feb 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fJ6RMR9T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460BC30FC1A
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968735; cv=none; b=bh5CtiNO68N5ZVSU81Di0LWAqpj9kcz5P321GMiW2p9/j2br0CMgkiLKJgZZh7nFp2AvPwCsTlnEXtc/RQubWoVnkQ7C6BOcLqOsma2gp4UzcZNg5XpONzGTMgTe4XrqNaEDXDDqF4omQKkvs+gF03wjfzRomPAfSl/RktKwFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968735; c=relaxed/simple;
	bh=+8mQzfbIsSjg0eT9UVzFYNrY4fHI7i/L1Gt1bS5rCV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZZhvfJIKklnikojO3s4dwD6/C/jE34poxtV7us3//KHXmrZ1Yyirfe/n5uv8Gmwo8MrQv2BINEMJ19Z0e+990+3o0TDqgHTyhLdfnJ9cwYS1kEiWWM612R7GzFsOYnOq/GU+W5hLZmjwkhIwO3P64kB1axMcA9GEOx6n2s3wmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fJ6RMR9T; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-354c67da885so573235a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770968734; x=1771573534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkA694Y46HE6RhoI7vyi3O2U0inNurM7rBFBXqWEitg=;
        b=RfGo1fy22n6wrbwKZ67UwqW/2VETWo9HVMOIbwijMkzHYta6h1Fl+DSxofQ5LCz1Mj
         i2YMZU1MWwjh2VgEoplrHK2UganAyp5X8wDqrlP1pYGMH24KLJRFoDCHC/ZGKPkhBTMe
         a5/a3CpTRBEnQIivZcmgMcWMcIZtWA0GDa2uIJ4SrJe2nZ+Mz/mZQTOSi5S6SHN4KoY/
         OIsGxJaMZ/0s3empdDRJbEJoResO5oSrU6itjE3PxvFDaKDO/rSWdM+6tMxqVBvKHU1h
         ZTmTfkR6hMO6+Ky7jnkiq8Ce82p4/ITB7uWZ0MTkfylxKGMOvH/oeKYHm6wMvs+ycf3y
         +slA==
X-Gm-Message-State: AOJu0Yyzk9OC/K1ZyExcwOz71hnrM+WnZb2ZKRVWINgX1s5GPTqEKtEX
	7F8b3c21+Rj3aR+maGcrZBeO+2uqy1x/hfg9NiIFUef8fSInj4DTRMtK/cgRmUepOJ5slSmTFFE
	ZRicUvN8PF4ZAF1bVy4gb+I5f4oYzydJGOJ7RpcdXXNDOAPfGxZpFTEqtJipgMzCGjo+35OYM6F
	hK42z7lGrnK/0fpMUXSz3azv9yDG20u31AqyFWUTyx/OFcDCRzcfthUdAPSWKJdJbvWXI5S96v8
	q8CirEyDO4=
X-Gm-Gg: AZuq6aJ+UQpa4XZWRAYhOIHV+hmC0HlvDknW0UpWoW56cMtftUMFSJusTiEzHaTbRpF
	jyKAUyZcr54MVfyjVBgXa6cumAf+97Kim1qzuxBTLIhi8JtCwDishsl+N8DeXrJ8EmrDQZA9BqZ
	ek6Xh9KOzFHGL86byWnoax9++OKCfjrNtzb6wMVOzB2hRAjdukkhhbw62qdpeSsz7Ma+eOcXBKj
	SE6rnPNbJKm9NI3QHsN3aWEAGMJNDjjWbpHq86knZheOO1O4AijdLOxh8SKGevSkgdS44CPmeDQ
	mJ4GUVAZ2DC2OjnvG+i0+2ypqTbdrlALpmfqqPZLxnPLjxWTrmYHnuBKTyj9KG2JTfnKn9r236T
	7UsVmkHXjEgQR5yktNy/+bRMcx3xESMxQJIH8ytVsfLsr01iCla4OQuelZ+V50sFLtgJubiwuBY
	TflXrbmIT6uUq1uP/jG9sv5+aS29BnfxwItDlbIR1uHFczaPFfwLhMoXc2
X-Received: by 2002:a17:90a:be01:b0:356:2c7b:c013 with SMTP id 98e67ed59e1d1-356aada179dmr814366a91.29.1770968733544;
        Thu, 12 Feb 2026 23:45:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3567e3f5a72sm999079a91.0.2026.02.12.23.45.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 23:45:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-506a07740bdso41177531cf.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770968732; x=1771573532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RkA694Y46HE6RhoI7vyi3O2U0inNurM7rBFBXqWEitg=;
        b=fJ6RMR9TuQNQ1OkWXk6q6BRJaB68HUzUOxf3XKCa6Du/bsT6SCNly6SXulvfFX/Kcm
         5SXy31e3zxqjEazxvYrF6EPyKFids9LP2duujToZ/NKkKgATAnySjqyK8uh1ZqCuoBFf
         Xe+HnKSpTpt+vQbYwdUfLhvWNXkcw2bqshWe4=
X-Received: by 2002:a05:622a:48b:b0:4f1:b956:6125 with SMTP id d75a77b69052e-506a829f4ecmr12353091cf.20.1770968731882;
        Thu, 12 Feb 2026 23:45:31 -0800 (PST)
X-Received: by 2002:a05:622a:48b:b0:4f1:b956:6125 with SMTP id d75a77b69052e-506a829f4ecmr12352991cf.20.1770968731502;
        Thu, 12 Feb 2026 23:45:31 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b6b56bsm58882201cf.17.2026.02.12.23.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:45:30 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net v3 0/4] bnxt_en: Fix RSS context and ntuple filter issues
Date: Thu, 12 Feb 2026 23:44:59 -0800
Message-ID: <20260213074503.2302046-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-258575-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EF80133ADA
X-Rspamd-Action: no action

The first patch fixes the problem of ifup failing if one or more RSS
contexts were previously created.  The 2nd patch is a cleanup patch
required by the 3rd patch which fixes ntuple filter deletion errors
in ifdown state.  The 4th patch adds self tests to cover these failure
cases.

v3: More improvements to the selftest in patch #4

v2: Many improvements to the selftest in patch #4
https://lore.kernel.org/netdev/20260206052930.1882740-1-michael.chan@broadcom.com/

v1: https://lore.kernel.org/netdev/20260129061646.1417185-1-michael.chan@broadcom.com/

Pavan Chebbi (4):
  bnxt_en: Fix RSS context delete logic
  bnxt_en: Don't overload fw_vnic_id for RSS context's filters
  bnxt_en: Fix deleting of Ntuple filters
  selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  28 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  12 +--
 .../selftests/drivers/net/hw/rss_ctx.py       | 100 +++++++++++++++++-
 4 files changed, 123 insertions(+), 20 deletions(-)

-- 
2.51.0


