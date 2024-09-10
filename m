Return-Path: <netdev+bounces-126933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF9973125
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085AC287D9E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031BA19C56E;
	Tue, 10 Sep 2024 10:04:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433141922F2;
	Tue, 10 Sep 2024 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962683; cv=none; b=CNerJ1k178sw+VQ4ynJLgc7u0ESUhGkxVr6QOX2apSO1Wjo174UOTb2hgZsztP6ORbAunvk/0O/5aKCxkrGEJb1mL5Q1mPKx3v514AHwHzuuROfxE7cp1ao5bRicxipPf0mV2Aj60cgkgVLzcOMaNQDzUWzEFe8pa13J2VTTqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962683; c=relaxed/simple;
	bh=BJV+r7fxxZqQ1eqNqmwAaK9bvos/cwcmNDivLsg5oJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJ1OF2myz8NM3beKJagnXPouX/0tD8SY16dynWaYUmNcZHqTiF6s63NHSa1Jpbc6/QEg+G9PNJfvBy/8pFRaa8BxYsYQ2GvL5Vi9ckf2IwmUoOF766OSMRsFM0CkwHs/IJK6f+1qTcfdBJUxBNGK0I4K9MEl2E33uzbab8cMzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c3d2f9f896so5740771a12.1;
        Tue, 10 Sep 2024 03:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962680; x=1726567480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NN/RftK0AtSsIg+UinUpjGI9Wdbejwds073AkbWDML8=;
        b=swMb8zShGi96JPDNZGZODhoygtLDcM+CBelJQ++ojWbwH+8tCAaNHAeTU8z6Mg00oh
         b6MlgD0yCCCaOFMs1YnIIehhEEIBdyMnW6YId2a9EprOxWIV1rrWy0aQD5YJ70BiAia7
         kqZPwTnj129yTUmZcQpMZaqiGgnPTdS3k/3yb4byd6pMumcPI3KYtNziNvmQ+ldw6QSa
         LUb06zgLy+k1omL5Qq9lg81XPvawiKPGp8NVKPrxY0zTk9NYg2Cg9jCPsq8yVWiRAQtO
         1PRiwpKKDKjc1SLMdngb0pFd5kPoe88y7VpADaJE0lQLiMsA9dY5VFut1sb4V0aO1iGw
         7jVg==
X-Forwarded-Encrypted: i=1; AJvYcCUMHZmwJYR4AniuM20UnBhJwoHht+xnYcj9lxkYw8IrNf5I5rZbtFePjgP6Sxs/A9jAnPz6T5sfbNiGoP4=@vger.kernel.org, AJvYcCUOgsWZmgt6Av6/m8cWd4D/3FJrZhdoEN6BoZ+p3en3tJ8GcSENvfqt5eECJA/q6smnwPpcI7A7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0EaZcTTCyFo1adjA6+/G7BbOa3OPC/355GWxRY0DjIEdpE1V8
	EcXPkZ88m4eWnmNkABjd3m2mPY/wlqGohZHJ08sh2FPX1cLDqFK0
X-Google-Smtp-Source: AGHT+IFX0pPWRAvDvfmSjrPODi7Lnuscg7NdxM/DXlinVH0dQq1JKuZbuzWHOWNdzZkncYbyFtaveA==
X-Received: by 2002:a05:6402:3486:b0:5c3:2440:8570 with SMTP id 4fb4d7f45d1cf-5c3e9742dd6mr6770241a12.26.1725962680332;
        Tue, 10 Sep 2024 03:04:40 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd52071sm4102474a12.44.2024.09.10.03.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Matthew Wood <thepacketgeek@gmail.com>
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com
Subject: [PATCH net-next v3 10/10] net: netconsole: fix wrong warning
Date: Tue, 10 Sep 2024 03:04:05 -0700
Message-ID: <20240910100410.2690012-11-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910100410.2690012-1-leitao@debian.org>
References: <20240910100410.2690012-1-leitao@debian.org>
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

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 1ec9daf95093 ("net: netconsole: append userdata to fragmented netconsole messages")
---
 drivers/net/netconsole.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 86473dc2963f..624bfb342da0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1165,8 +1165,14 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 
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


