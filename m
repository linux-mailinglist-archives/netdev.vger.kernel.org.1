Return-Path: <netdev+bounces-133017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED6B994492
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8874E1F25CBC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C17119067C;
	Tue,  8 Oct 2024 09:43:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8A18BC19;
	Tue,  8 Oct 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380626; cv=none; b=iTfJUXsw7TmMtB1m0YCM8BY1c6/qndBhhS37MtV3OkDQ60VDAzyjAviuj5+zXmIPqEPVV6nqOZfe9Wb5xDSEp/5ZqFxl5r3XqsdfQLK7sBHbFFjcWC8lPEfSWAl6/67n+/x9qF1fTDNb159SpQoQ6S0IgpAelDpGaEggYjyuOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380626; c=relaxed/simple;
	bh=HXy8CJWNF6qH50hLohSF2IGSgGAjFAwW/OWKaY0iWfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LcKtLYVe6RrSobs1g0go8NMp6ScxKNafM8PBcXBBUcHnvUa8O/vCyi5ViiCLrHcjJEg3MrBMO/aF56+Dl7lpn5Q4QlZ4foe6D1eIggDxQMhYJxTuCG3TH24H+Qb6FgDptPYSOfY6U0Ayzm7UhtJHN61sLHZpyLNq9QFnsSfng0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fac187eef2so63919061fa.3;
        Tue, 08 Oct 2024 02:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380622; x=1728985422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swh5VTqB4q1vjh5aJ5th+EjDQhZ/dHlb0hXmSyJKUpk=;
        b=gFd1FzI92oQIpsGRVVteJ4KurW04dAzH62A2eXcVpWIBLpYH+jUUnxGB10QPeqBdhv
         7+1DTwtQJFrecQje7yiyPUviiRMYg4SN22MnEzTHMgsYuH1SodVQ/jbcUc6csae2vna/
         HYUuu/G+DtorRx70cUXEsaJHiE7NOze7KPj1tln4KbH9EkrgAh0E0WTM/Io3TJcaTMKQ
         YY4JhqngExkHRk9DDpwS9B/V5DA37tY39MFJ/poM48z+BxXFlTEnuG4tYY2MzT18Ou07
         WaKbm2RzKsiYn3YdsfvBDH1k3t5SzOLvS9IC22IH5FiGbm34tSAvgywrgGZp204yr+H9
         w6og==
X-Forwarded-Encrypted: i=1; AJvYcCWAT8S+mhYY+6TDKXBw81410XV1qUCoTp3QTrH7tjrLMng8g65g1psf3CWRKxOmhG5Xufk3EpVR@vger.kernel.org, AJvYcCX1Smlvd3tE/J4EjvYTx/LXozQLpC1RDcDqzYblOWbDKIs7f4Q1zyniJ+3nUyeKqLKFEIfaF4LuMQldJ/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPsZmWWzCwd4huPO62umGsr7zeMvMHdB6Vdgvipoq9Agx7o3g
	jucSaqQLhMRBUX3F9+BZDWMWzs2psrHiS8rvrwAD9jEair/a+Vv5
X-Google-Smtp-Source: AGHT+IHGz+7RqFpca06yAzjxBPQFAJG4/E9xG4FhYAaDwwuh4IV8a5uADHH5W0m/3+TJFlSB5wEqxQ==
X-Received: by 2002:a2e:bc19:0:b0:2fa:cf5b:1e8e with SMTP id 38308e7fff4ca-2faf3c2ff8emr65352401fa.2.1728380622073;
        Tue, 08 Oct 2024 02:43:42 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb7f0sm4137427a12.72.2024.10.08.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:43:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthew Wood <thepacketgeek@gmail.com>
Cc: kernel-team@meta.com,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: netconsole: fix wrong warning
Date: Tue,  8 Oct 2024 02:43:24 -0700
Message-ID: <20241008094325.896208-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A warning is triggered when there is insufficient space in the buffer
for userdata. However, this is not an issue since userdata will be sent
in the next iteration.

Current warning message:

    ------------[ cut here ]------------
     WARNING: CPU: 13 PID: 3013042 at drivers/net/netconsole.c:1122 write_ext_msg+0x3b6/0x3d0
      ? write_ext_msg+0x3b6/0x3d0
      console_flush_all+0x1e9/0x330

The code incorrectly issues a warning when this_chunk is zero, which is
a valid scenario. The warning should only be triggered when this_chunk
is negative.

Fixes: 1ec9daf95093 ("net: netconsole: append userdata to fragmented netconsole messages")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 01cf33fa7503..de20928f7402 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1161,8 +1161,14 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 
 			this_chunk = min(userdata_len - sent_userdata,
 					 MAX_PRINT_CHUNK - preceding_bytes);
-			if (WARN_ON_ONCE(this_chunk <= 0))
+			if (WARN_ON_ONCE(this_chunk < 0))
+				/* this_chunk could be zero if all the previous
+				 * message used all the buffer. This is not a
+				 * problem, userdata will be sent in the next
+				 * iteration
+				 */
 				return;
+
 			memcpy(buf + this_header + this_offset,
 			       userdata + sent_userdata,
 			       this_chunk);
-- 
2.43.5


