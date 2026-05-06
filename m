Return-Path: <netdev+bounces-285039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFMhLjaz+2lKDgAAu9opvQ
	(envelope-from <netdev+bounces-285039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CD24E09B8
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 053523015C82
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 21:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E2309EFA;
	Wed,  6 May 2026 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JwnPugBa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24412213254
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103090; cv=none; b=Qx+NntwL14fRSSl5nOgkKc+ToGTkCrLW0HLE801A+n8FV9qXU8TLEv7Jazs08660lo7AHuAljWg8k+De6U+Md6xZwRjuvGz2L4P9Uza2moy4GtXIiFWp9dEP/XHWokIaZtAdAV05YRNKcndoeq5V2IAZpKQvf+HYaaiqdgyffTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103090; c=relaxed/simple;
	bh=iLG2Ac2GxBIwkEfOIFn6MYmyDklfPJ1WT0s8aUWdI4E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JxD1wp/sAKy5Jun0NG8IHKawnQNfEFOWuDXVHIdgLCxYnFjDUvbG7PUwApMHzC/NAm4o5eNPze7SvCtC8LmwYsaptR2CPY/TKuE0yYMNP7pO4cUR7Xm5gZFWDkZ/Rsk/lE2p5gmDyMnSMfaWr6J+zjBixdam2eAWLBArqhjQDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JwnPugBa; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-51306c9f2e1so933481cf.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 14:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778103088; x=1778707888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWXIV+0QnyRf8tyhx8IzEb6dSeGGdXG4R0Fr9KArd6k=;
        b=TQAi8rMbxT6Tp4cryiSRcLr20bsDFYKg8CEImxUroMZw0Dku0+wcwkIb1Ud2ser6K/
         8Mr0WNK7D1aLqzYZ+tEeJzxJnXNQfk2VWguIY8TE3QvfvEZzXEpNKP4rOj6SUMV07t/0
         tt+3aNbLU7OIcvbniMRTrkO0CBt5Wf9KX2s0VkTF9h/Sv1ONsOFJ2pg8LlbthtR5TQQ+
         LKN1TVkmUD/oauRCcdrfYyInww6aoJZbQoYkGZ5+bXmx2zYc/mwVx830JQWX4p3GW/Hf
         0LvpFiwIE/vwRCsjJ7kMen4pDLgWjxtJiPk5T66Vge2oIWABAFNTQmZqsY2YIoDl/YjM
         qXXQ==
X-Gm-Message-State: AOJu0YxPGAsAWYt/FkBKFPpQrCj6J2VIcQn9P/JE0hm+uIkTwAs1pzN6
	B31XtQOGuK+kztdlhqY2fIQhZMld2iwySyS1lcWDVQuFSHd7Lr8KrMcLgwvZ4n5qajlzxluO1HU
	5lEzP012K+QJ9JC4pM/SAJ3po3Pv6TW3IqWNVskSByxhiV0sfFTzhjZRrFxIHlAM0DNf0y7qvaz
	b5xHfDI/c5xNkfjm/YL+EGRaYRAGURtWbr8HqfIKIScqDVFtmOz9vjxLHASP6TzUaqT5YAxXJhf
	GEAlHZOZQ==
X-Gm-Gg: AeBDieuzt9gvIWDN8qlXwDvxcwp0azPJmf/wSnRzt/h/Ondv6Uni+sKA+GlLsniZowy
	XtabwcpsqJD+VkpPC4MaeMbN+79WaJz6yT1DlHnvuR1qjt9T6In6WvNggUz+gfbVZuMJEp0/7DA
	yii9VJgpPkMMMrrZixynsDrnKIEsmUfmm9pW1BalrZKLJCeneE5rVKxq0TXuXM6rDmYZyQPiNkK
	RVXawy21Fv/WNSyAUUkGJ+Gc3T+5k3NAjVw5tQ7i3uJ7Ygg1P+pQPTHAqTtlHSf2poT02E/vA1y
	mBVGQ2qMW3JnyfDZF0PUnNre+fa++QqqJb+ziM6s6gCFdedyrbWmkj970FrhpDNkAuFAeEpeT/Y
	P4KztQsnp8wzlVvdIJtW2fCA0zylo9xcBCLbQLT6Ac5RhlB7p2tiRIhvXrwEnbTHCZd/WLbRzsn
	GPCBzdPXPxM1WKjw==
X-Received: by 2002:ac8:57c5:0:b0:50d:9174:cf33 with SMTP id d75a77b69052e-51461c05042mr71147121cf.16.1778103087898;
        Wed, 06 May 2026 14:31:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51040abc6bcsm9342251cf.20.2026.05.06.14.31.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2026 14:31:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f485961555so1008684eec.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778103086; x=1778707886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWXIV+0QnyRf8tyhx8IzEb6dSeGGdXG4R0Fr9KArd6k=;
        b=JwnPugBant6ZkNu8FRpy2U0h9AATLJ43aiOGGx1T5QDfRiAk2QyweRYJ6ovnpLMxCf
         jOInXtRiG50ldhNbnoDcBTPxIty+UPuWZ2JfsMioQkbVh2+G7/wB4S+gGP/I3AysAQM7
         JWRk3bKYEpiyVpyvE5YH4ez+6f09kgu6jor2M=
X-Received: by 2002:a05:7301:e83:b0:2d8:97d6:6abc with SMTP id 5a478bee46e88-2f549f60b6fmr2806875eec.22.1778103085859;
        Wed, 06 May 2026 14:31:25 -0700 (PDT)
X-Received: by 2002:a05:7301:e83:b0:2d8:97d6:6abc with SMTP id 5a478bee46e88-2f549f60b6fmr2806845eec.22.1778103085172;
        Wed, 06 May 2026 14:31:25 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56fd909e3sm5234089eec.20.2026.05.06.14.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:31:24 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v3 0/2] Keep PHY link during WoL sleep cycle
Date: Wed,  6 May 2026 14:31:12 -0700
Message-Id: <20260506213114.2002886-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 15CD24E09B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285039-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

First we divide the init/deinit path to allow for a partial init/deinit
during a sleep cycle. We also remove some unnecessary small functions at
the same time.

Then we modify the suspend and resume path to allow for a partial bring
down and bring up. This allow us to keep the PHY link up and to resume
network traffic much quicker. Note we only do this when WoL is enabled
since the PHY is already powered. In the non-WoL case we want to follow
the same flow.

Justin Chen (2):
  net: bcmasp: Divide init to allow partial bring up
  net: bcmasp: Keep phy link during WoL sleep cycle

 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 262 ++++++++++--------
 1 file changed, 141 insertions(+), 121 deletions(-)

-- 
2.34.1


