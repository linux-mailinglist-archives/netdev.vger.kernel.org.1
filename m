Return-Path: <netdev+bounces-262794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHHFBk/spWlLHwAAu9opvQ
	(envelope-from <netdev+bounces-262794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 21:00:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13C1DF0BF
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 21:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840993087D3C
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1560238F640;
	Mon,  2 Mar 2026 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UWcCNUL8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7CA383C9B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481289; cv=none; b=ViRdkaWlZMGXfZlpERvnfOqg068YvVY+Khve+tTq8CkCQ6BJ9OQEt9CI7MugFwYqDS3tFEJoglNFSRqx7QD2rLsZIuPcbHWQXq8H/2yHCmu8UbErfvF02wPq0o0LO8t/i39V/6IiqfVkpknuk5q8Se0ZGAZ6YdY8qtUCwXpFk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481289; c=relaxed/simple;
	bh=+uwb0WSaraRgZ7tUo9HYkLnOugrzTXtBTQZLSH+fIcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpfTs6RORQkaZU9k8Rky58l2jDER/oI5VvpzzISyxKXfwBQov3ZdBZEL0XOawcYhaTM9aBNUQYoxgOXwS0Fn59mtc9jaMlNQw/NFK747wDSrgCfznjV/RL3r7YhHtgixmx6MTYjefGQkwlCukKyfeRLv3BUtJYyCGp9SlHsbMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UWcCNUL8; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7d18f80b5c2so3558533a34.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481287; x=1773086087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIZFwA51nNys2/FTKh4DEqdlwUn34Jlb5NBGGS/ohWs=;
        b=MOHIZm2k0uhyrCc0ePHvvmsZ7ETBQ2kmM7epHUcsjZmuA8uySNk09YlvQ3DaFyd9nk
         Y+2DuYyLOFKiPksy01sKJiXQhqTrfGCCLeZtaDJrQ7cgRGT/+IuxloM10jLExCoKD3H3
         /7UCPyxLx717fI+s6PmWk5TZ72i+Tdx907LU8B4lUcZ/TWcINvcGYHoyf7eJZ8GKrDde
         zFKdKMQKYfpHfHKgYzuQzzNS0QvepnRl57dt3bmSA8gfDB7anlDTj473WJ0QwWLu5QoL
         LOnsQ1hAs3CaylBXNZQgTW6ayTR3I4VYyU3Lchqdg6FH/vvRgqsh3UG5IdVD+e5Q0OFe
         mE1Q==
X-Gm-Message-State: AOJu0YyBZqFzsBUBQF6DH/nyPBTmA16LcIzhR/m5jDqPeP3tq4B5msVC
	rmaFNrPa4z9Oh25znl/IYytxV2IlacyZnJ/qcVNH0F8eGQRRA242Y8OF06l2fW44xjJEkVRV2PI
	p9eKHw6EeEsZdxSPDEmAJ+Ox0wAgTjt9VzyCW9B6g/LrRh1xFviwGpMWlOZ/91WIvPekmJxVepE
	UVTYCWY/DNgTFp1pNm8/ho2iaK6dMBaOXWaMNPKkSLCBsj0zgn4ITDFNpfRvqqDdaoZCOzLUp4g
	5Cdy1Gr1gcKd1BMMVc/
X-Gm-Gg: ATEYQzx4DA66VpPXVFKuUrVZckcrQEdr1LxDlho5Ulp+o8Z+fenNbv2P0VsUQhcwzkg
	kblhlM8sdNPF05m5XVRFzHqcjt9hBYwl6s8/aaonYDKRlAOqb97s20YSaYt3YnqrX52FlG9hlrd
	Pyb46TfStgHhUWJoLufk696lzKKkHwWsdZXp7TWb3kLDmSD5SNWPUqhAJiF/QtpcElDnUTwHGpf
	SOPn2140ZtblGKWz8LjuGQYLGL+TocMzWrj6DwCxXfpJR2HDfndDwePWv2xKL6MSRfBPHKzz2ze
	onenr1/g6+8zzDLYWvACqbKfGrQlwpS7GVH/PHPD33+lQqKglTaETVvBAUrC5Gy5IydglbH6MPU
	AwR1+d4l12R75/xH2H/2q63IKRIu9/Cws+SW4qgtwkTwiNYYJy7tLoaDrEoBv1uoNeTe+tMlMBW
	ofIVDU68xH3F5pXlYTD8qMIW561q5rWku2rZKNswTUY0R7GoU94RjfoElzbsgbnIhvZg==
X-Received: by 2002:a05:6820:4c0a:b0:678:24c4:2ef4 with SMTP id 006d021491bc7-679faf374d2mr7747442eaf.50.1772481286657;
        Mon, 02 Mar 2026 11:54:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4160cfd446bsm2051023fac.7.2026.03.02.11.54.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 11:54:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb4e37a796so3315853985a.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772481286; x=1773086086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIZFwA51nNys2/FTKh4DEqdlwUn34Jlb5NBGGS/ohWs=;
        b=UWcCNUL8DaEzExIUGwAp0znOO5OkMxob2GmmmFHwoBuaAw6ko9RYyd/bG7sBVufeSy
         FPe16HeKAM3kBw5WQS3AGLcPVGtGy8hmU91izCcp/BmVKuazy7ucjQzv9fwJ7P3pMQXN
         MwwGSq/sLZpi/HgtrwwTuWEAWFKiLKb3yJjNk=
X-Received: by 2002:a05:620a:1a92:b0:8ca:110b:38cc with SMTP id af79cd13be357-8cbc8d867ddmr1755776685a.27.1772481285608;
        Mon, 02 Mar 2026 11:54:45 -0800 (PST)
X-Received: by 2002:a05:620a:1a92:b0:8ca:110b:38cc with SMTP id af79cd13be357-8cbc8d867ddmr1755774485a.27.1772481285092;
        Mon, 02 Mar 2026 11:54:45 -0800 (PST)
Received: from lvnvdb0691.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf736cfasm1208049285a.49.2026.03.02.11.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:54:44 -0800 (PST)
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	kiran.kella@broadcom.com,
	akhilesh.samineni@broadcom.com,
	sachin.suman@broadcom.com
Subject: [net-next 3/3] selftests: drv-net: psp: add reset statistics test
Date: Mon,  2 Mar 2026 11:53:52 -0800
Message-ID: <20260302195352.1015990-4-akhilesh.samineni@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 8F13C1DF0BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-262794-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add get stats and reset stats verification within _data_basic_send()
to exercise the reset-stats netlink command in the data path test.

Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
---
 tools/testing/selftests/drivers/net/psp.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 864d9fce1094..b7a59d0dbe25 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -113,6 +113,9 @@ def _check_data_outq(s, exp_len, force_wait=False):
 def _get_stat(cfg, key):
     return cfg.pspnl.get_stats({'dev-id': cfg.psp_dev_id})[key]
 
+
+def _reset_stat(cfg):
+    cfg.pspnl.reset_stats({"id": cfg.psp_dev_id})
+
 #
 # Test case boiler plate
 #
@@ -389,8 +392,22 @@ def _data_basic_send(cfg, version, ipver):
                         "tx-key": tx,
                         "sock-fd": s.fileno()})
 
+    _reset_stat(cfg)
+    rx_packets = _get_stat(cfg, 'rx-packets')
+    rx_bytes = _get_stat(cfg, 'rx-bytes')
+    ksft_eq(rx_packets, 0)
+    ksft_eq(rx_bytes, 0)
     data_len = _send_careful(cfg, s, 100)
     _check_data_rx(cfg, data_len)
+    rx_packets = _get_stat(cfg, 'rx-packets')
+    rx_bytes = _get_stat(cfg, 'rx-bytes')
+    ksft_ne(rx_packets, 0)
+    ksft_ne(rx_bytes, 0)
+    _reset_stat(cfg)
+    rx_packets = _get_stat(cfg, 'rx-packets')
+    rx_bytes = _get_stat(cfg, 'rx-bytes')
+    ksft_eq(rx_packets, 0)
+    ksft_eq(rx_bytes, 0)
     _close_psp_conn(cfg, s)
 
 
-- 
2.45.4


