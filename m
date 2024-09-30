Return-Path: <netdev+bounces-130383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D078098A482
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884121F249F9
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB58C194C7D;
	Mon, 30 Sep 2024 13:12:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B51192D78;
	Mon, 30 Sep 2024 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701960; cv=none; b=IY/zR7mqsChWcQYEOn+TxoUJzSqUigg+QaxTz5nLMoFnpgbzh8cq7f1eDexx2oZv+cU/8Np/PqmGjeqMfvBTLEESD17CqdAQM25Tg35forty/f1bL1qcY+UAXxKypvaDNCgjMTeHVf6LAWWXG0GI3DIJY3rCxexaGDjj34FLxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701960; c=relaxed/simple;
	bh=YoM8JfTyubmHxwyaR780Z4MLjoKPXDQNorh4/OwIsSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJ7j+Rc964VUTOeyMHKHudt5BviHODYRnpvWZXYd6enqrlm8DBRLmxEqlQc88cWlnDCklSK+I5cHHowbGdojOd4w00rwebZEyzuwbmXL5qvY6c9+X/gchSg4PW6+QJ1uMo3fkiktbliUE644OzQT4X3EcP/x3qh7C7W0N6M1AmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c88b5c375fso2784325a12.3;
        Mon, 30 Sep 2024 06:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701957; x=1728306757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M94vldEyuuxRxO4IdgpqluNKuv+egbA35R49EuAXB5k=;
        b=LWoEqK4AehAOiO++6o85fktIhOeMNb5PcvFI+3Im9x7p37QX4WQZEQNx9jef9Ngd7q
         WNifFpwKBKRaa40JL4oLGOjr60Cs8CbQYOLwt+3/HKQoIAeFlKkovOtsHg3RYgNFBAd+
         XPqxxtSojYl9qGT+wf3IpbBadDxQ8qWt3VXmg0eQQ8DuV0hg+bvSQY0P7bnBV3hNf0eK
         UZvxfIMWAcApq3VoL/Pc7/eZvxj7eORfLFhniiw0eClC/0eSAcLiLRY6scckY/QyPsZH
         sW5/VOtcDnZuNqVKEWY6Pi/kymxxxEU+ofyfH6u380Al3BOMPRUa6bCdXazWXXNc0Y/0
         6zpA==
X-Forwarded-Encrypted: i=1; AJvYcCUENp2bfasn8IeEYx4qBwcmacgfkHAtkVzbYh42gYlQq+0KDzTQ2WVoZa93Ab+G8eudXnw+3jzFF1GSFEg=@vger.kernel.org, AJvYcCXeeEHH14vOaTOZacz9Ndw/VkhnH67HaK9+AaeT9igL9Sc18GlgX+okYZ/3Vpc0Cx7RRRDxwCy0@vger.kernel.org
X-Gm-Message-State: AOJu0YwgkSstMR+1P6ErQ08kISahS3oyhgWP5T2s1RV31pAeVjLox6CY
	hhOZOh8rhCVVTgf9lPLy8CXY85WMgTrqsfNJvG7or293gK7xbfxr
X-Google-Smtp-Source: AGHT+IH6Y2rTIy3dvSJEkp+aAJG0YoFNk2Um9vgMkgloRl+3noBVk3cFbg0OQ/pVKprj/KMikAei1Q==
X-Received: by 2002:a05:6402:2812:b0:5c8:8538:b770 with SMTP id 4fb4d7f45d1cf-5c88538bbbfmr10342103a12.8.1727701957157;
        Mon, 30 Sep 2024 06:12:37 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245e9e2sm4485793a12.46.2024.09.30.06.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:36 -0700 (PDT)
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
	max@kutsevol.com
Subject: [PATCH net-next v4 10/10] net: netconsole: fix wrong warning
Date: Mon, 30 Sep 2024 06:12:09 -0700
Message-ID: <20240930131214.3771313-11-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240930131214.3771313-1-leitao@debian.org>
References: <20240930131214.3771313-1-leitao@debian.org>
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
index f724511cf567..4ea44a2f48f7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1164,8 +1164,14 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 
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


