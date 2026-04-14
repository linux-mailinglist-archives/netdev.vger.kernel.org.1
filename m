Return-Path: <netdev+bounces-278538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBF8JXhq3mmxDgAAu9opvQ
	(envelope-from <netdev+bounces-278538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C55D3FC880
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8761330221D8
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E813ED118;
	Tue, 14 Apr 2026 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gydIB3om"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AD314B73
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183516; cv=none; b=fW8ip38i3a7PSA0Gp24Mfvg3e9pdHCxK/niOo3ea9P/jptOOrah2bJC8Auw2AQgcUpO9We/YfqcyxE8PQEDX6T7BTXR0nZc2SJ+hj+a+muhOMeHsedLX8zzGdODZWg17aZruXwySQrtQdUN2txSGOeIa3bFaUZvkcpCBgHIgF2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183516; c=relaxed/simple;
	bh=XxowB+AH/eEAEqtA4yUnvHLjw7Bb/KSy6kXpNy5thIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDJlxpEkx3TMLXZKrq2AAYBMguTGDlA65vXJOQlDwi73ZZKam16dsaow0krt+H1YaXWkjPeEMvuqE7E7BI47AHFxchBE/iKeaeCROXhRbWprIGMprx22zhpFt9OGr1L2+YaFuZeQYkgnN+9kVEHxrhrpQhiGT1joSlXmVNIFOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gydIB3om; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so1331221a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183514; x=1776788314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scz9wajtoz9F+k9R8s9CmDHuFZyZzs5RVR37Rr0iyLE=;
        b=YMMjCrgsQ1Ko73S83tIvaRF0cTfPCwHl+EOq+TzNWmf1GlNs6XqJzWjr89xsd2Wb1I
         b1DBiqrSMaA8eFENwCAy6OFBatOG0Ma1gxPJH8qkW8Y65tbghn8Iqe6IYZ3WFKX9G1tb
         jbIUCxYlg9fQcxrOh6u8lIuoaXvkwXg4TAcMCMR6t1pijcyWdhM0uHHfneTLAZbqBK3E
         45x/YD7ykgz/v0/vf6g9K/PlBLaSz/wSCvEHdPucATdfQLX+OiSeb8kV+xh1+oNLkIZn
         v9eDH87gEsXH96BEJ8zm+xgjePjK4SJin9B3BFQHPM+aInjGGCh75Fxe7xuCqRygNMg4
         gitg==
X-Gm-Message-State: AOJu0Yz+BNN9GIOcgwijntja1j78z6J48y+gkUha4DD+GDXxxQwvEwNL
	smdIESBiLhssQ8ziLdS42aSkgxIGIvvR0s0hrtJiTQEZPXoNgPNeEpZ7MOHwKqh8QWP/UjO1srl
	koqQ+GscrcLHkovk6kbLnRMrIzQP43fTPecvpCjZQN0zXc0P8rI2aeCgfrnbhbEWrG5+EWGzfdk
	ktgMg/wETVRtHMN5ZXRHQG8UhGUIPSBNoJ7CPy/7WCax1LQiI+CT6aiCpKmIFrtvrC8NuXAycw2
	2XKpsAvrA==
X-Gm-Gg: AeBDiesChx1WXEHqs/ntcY6SRPAniXBo1SjTogcrrg3KmDb0LC0Zynp/oybjTAmBkYe
	5B9Q6r4nUSYTLbnSLgTQ8vBkb1JzPTDgq+tUGJn/UBf0JMdmg2RU1lf5cedUu1LKO1/JdBzX/so
	Hkx8FEPqDG6WDiLRGk7OxRdBpS25lEK8zLhQGaTLNeQGznUF+8SGpB+vIJ9ZjNEyP8Rto+w5ZHZ
	JtJaRupNVClmnHGTCFgyz1sPXCHLxf1y2wCmqO1r9eq6dDX0OER7xjdeMmf3KVMsm58r4UhY5ah
	7oBEWBtFQFuAE6/UWub5p7zWge4p9XHCjp6JDCqKOHqdpqMWT2FO5y/h9rBxcA4xs8qhptYB7Kx
	nSqr5fX/NvLfnGQ7M/FyP9O0JlywV55xSeqh3Iz6ubgzfYPF7/0BtFM5lvsykvSYGYHBFTb8NBc
	PX9Eju8Jas6UJHutfdWyt0vug1Tu7fAtyi8XJpzFNqpsAOdVFWQgGprH8=
X-Received: by 2002:a17:90b:4c8b:b0:35d:aa02:d776 with SMTP id 98e67ed59e1d1-35e42fe6b1bmr13725189a91.2.1776183514146;
        Tue, 14 Apr 2026 09:18:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35fc6efeba7sm223695a91.6.2026.04.14.09.18.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 09:18:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so2895487a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776183512; x=1776788312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=scz9wajtoz9F+k9R8s9CmDHuFZyZzs5RVR37Rr0iyLE=;
        b=gydIB3omfYejQf2/kN6Q54BqMF2o36Gletswzzc+CBo0i5fRU9dj043HcbcwWd6zBk
         /RbByjplRo06gp53zTDEvw8foww5mqu+I9Aia+6BSeR/RLgS0/Bzm9deggSrXOufbeFn
         rMskTzNWpVRJ2ZP+GARWGv9aNcIlRG4YjIBJs=
X-Received: by 2002:a05:6a21:3384:b0:39b:8dba:695c with SMTP id adf61e73a8af0-39fc959dd8cmr21300094637.27.1776183512443;
        Tue, 14 Apr 2026 09:18:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:3384:b0:39b:8dba:695c with SMTP id adf61e73a8af0-39fc959dd8cmr21300058637.27.1776183511875;
        Tue, 14 Apr 2026 09:18:31 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79219cbc21sm12042656a12.17.2026.04.14.09.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:18:31 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsrama-krishna.nemani@broadcom.com,
	bhargava.marreddy@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net 0/2] bnge fixes
Date: Tue, 14 Apr 2026 21:48:20 +0530
Message-ID: <20260414161822.742382-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278538-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1C55D3FC880
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
 This series fix two issues.

 Patch-1: 
    Due to wrong HWRM sequence, driver do not get the correct
    information regarding resources and capabilitie.
    The patch fixes the initial HWRM sequence.
Patch-2:
    Remove the unsupported backing store type initialization, which is
    not supported in Thor Ultra devices.

Thanks,
Vikas

Vikas Gupta (2):
  bnge: fix initial HWRM sequence
  bnge: remove unsupported backing store type

 .../net/ethernet/broadcom/bnge/bnge_core.c    | 40 ++++++++++---------
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    | 16 --------
 2 files changed, 21 insertions(+), 35 deletions(-)

-- 
2.47.1


