Return-Path: <netdev+bounces-256741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI0DNDVrg2l+mgMAu9opvQ
	(envelope-from <netdev+bounces-256741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:52:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F31AE9844
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D6C30AB066
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECA8421898;
	Wed,  4 Feb 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAIfj61U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B74266A4
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218419; cv=none; b=bSmP0F0anPuaqVc9Dza+edPHZzzJnlb+oNu8Quqtgq3ekzG1s04MO4zLlipeA70sKYMM1thbb//1Az0PQyM8wp7rq1N/wnCOsXLhT46IcW8AOnQzkD6/Ca+wZfBqFtzSFC5LBBQcr/3Ui/KbSsriaQRJgtUWIuJxVOobsKRjoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218419; c=relaxed/simple;
	bh=0/nmv0IDyjZ5YED5N+7nUqbvJbs6BmOGKiwyVONZ0o8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itSVjXsLFMhKutSLeHIog7knEey5wB6Woc33T/eoQ8IhTWmWYKyBuL/H/QLmngIBBSsttyprMKOkoXVyf8Ugb1UfRGgzxda33pBVB+p5VCxqLs4dkA7zoWDpGNRsD/5z5toGHUjoZg5CfbIQLbUa9K4739EbzxXOMhthB82wr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAIfj61U; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-649d4690088so1943513d50.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 07:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770218419; x=1770823219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSx1gFM/JJEanfUhmz6VoD8iNfqolHu5MhqxWiYgt5I=;
        b=FAIfj61UT4UQF4Gxw+XifDnRlMPLM+B43hMQ6Ze6LyL/abnMMB9mytb0RAebHMaK3J
         fTmbkuvKs/zKpi57rnCW0ElTG9XpmVlzZf+kU9wYhW/qzpnyWouYZrdEmao0YJB61bSp
         LZdOv0a1+Tb2Ux2AG6BWmC0x8mGYADn+SHKsMQ2GlNDgKm4mf+vS1h5eeTOjYTBRa9X0
         vIjGfT0HgKUyHWjEQpjn2vkp0GsCkYfmOD7q2ixeVHtEw4cG+mhGr13+ubMB26ULWohu
         PGBoOloHvfeSva9yC0H0to2bf/a10Dr+7TVDHYQZC+JLAkhGe6Q8oX7mu8lbdTx4OQb3
         /l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218419; x=1770823219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CSx1gFM/JJEanfUhmz6VoD8iNfqolHu5MhqxWiYgt5I=;
        b=fxPotTW2k+q3CZ1iF2v//TB5cRCvFB0ugGmulS70LYyrs/Q0UhtVVPAYdNi0gaZm9e
         9hlwoQbqWDTJ7kgCRZk6T5fS6R/s96WkT2UhD3i9vpa7Rr19Z6tuDOpfjz3aybXgqhcV
         kKw4BYwLXjtRhEwKVI5yUoVRmF18sxe8oYwxynZCkdl8yu1P50F4oZZRRGs7HyyV0FfE
         YY/SFyFSIjt+RuAtatB7P0CFt+TWa/tmMI9bwo2V67jXIGJU2oSWWLrb9JajZpN8KJre
         InoUp6KUYU5LPe0uBh2RsSMrYBqmHJTOC/la99VlKYHKvRyWoDwKPFeNQg9wGpG6KfmE
         TMbA==
X-Gm-Message-State: AOJu0Yx0b0FsUX5VSYejR/g2v5y8MbK5A01XNTNtEJbsvVvtspJJ0/xK
	qhZvz6mBl3MI7hdoqlFP2WKCWaycTzjgVfh+Pu+oLmd5zfkJhrETK/CL
X-Gm-Gg: AZuq6aIUTCiaurVEPfyKfqbBTRx3YbeyHlnsBQbz+ARIvXBPQiSENpP+EWVtdrfGyoE
	ipmX5evDQSLF7h3RbNLVfIqJCIpBhKQwO85Y2ysYhfBwB33gw2aRw0kKReSn5rHR1OMRXSX2dji
	KyWBmx87pZVAc60n29BjakP9VUMPgikq7csypemLyHqcOar4EVR+gAb54/MwqbyaZO2cx2JhIjA
	9QdWNw26AB9feKVjETerICgCGMiMST/2eB4GZtIMlHRVEHmO47cETlwm+qBX4yXo/WJw4nsOiFV
	EDFqx/e6EFGDJIyA51PGD7jdPcLt+0OzYMp4Xg4VMZWnMpAr701ATJH9fcMO+J8IBe/m4i5nlzZ
	YY/5TsBfvdL4XWXAfqaMSSQRup0PE1EX66sBJriEaLNV9gdd32KvT85WCDuylJ7gE67ffW85U5h
	Zs/e6ZLfiq
X-Received: by 2002:a53:e202:0:b0:63f:c816:1169 with SMTP id 956f58d0204a3-649db49940fmr2094091d50.48.1770218418453;
        Wed, 04 Feb 2026 07:20:18 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc5e4c23sm2595779d50.22.2026.02.04.07.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:20:17 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 04 Feb 2026 07:20:12 -0800
Subject: [PATCH net-next 8/9] selftests: drv-net: psp: lift psp connection
 setup out of _data_basic_send() testcase
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-psp-v1-8-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
In-Reply-To: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256741-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F31AE9844
X-Rspamd-Action: no action

This is a pure refactor, so that the key exchange sequence can be used
in other test cases that start with a key exchange, but might choose
to perform different tx/rx patterns afterwards.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 864d9fce1094..63dc8757ba37 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -360,10 +360,8 @@ def assoc_twice(cfg):
         s.close()
 
 
-def _data_basic_send(cfg, version, ipver):
-    """ Test basic data send """
-    _init_psp_dev(cfg)
-
+def _establish_psp_conn(cfg, version, ipver=None):
+    """Establish a PSP connection and return after key exchange"""
     # Version 0 is required by spec, don't let it skip
     if version:
         name = cfg.pspnl.consts["version"].entries_by_val[version].name
@@ -388,7 +386,14 @@ def _data_basic_send(cfg, version, ipver):
                         "version": version,
                         "tx-key": tx,
                         "sock-fd": s.fileno()})
+    return s
+
+
+def _data_basic_send(cfg, version, ipver):
+    """ Test basic data send """
+    _init_psp_dev(cfg)
 
+    s = _establish_psp_conn(cfg, version, ipver)
     data_len = _send_careful(cfg, s, 100)
     _check_data_rx(cfg, data_len)
     _close_psp_conn(cfg, s)

-- 
2.47.3


