Return-Path: <netdev+bounces-53412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AAC802E64
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4E5280EBF
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF52D171B6;
	Mon,  4 Dec 2023 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWtLPfIH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04944101
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:19:16 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d340a9cf07so64181607b3.3
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 01:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701681555; x=1702286355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5Rd1tgTUvyMs83JE7brV4nb0+zXx5TKbcvBUy55/2o=;
        b=WWtLPfIHe78Zyot2VuMKa/ix7voITVSri7fpmjLFUTM3//2q2xH29Iiwyu8GGNT2G0
         Z8Oydg1Owvrj5UlPZB8SGl3wKOhK6Jcqod+/cminV0toJb6hwpQfs+1jZvAx1HVWPucJ
         8tjmBTjz6C0XN9OvmUVGx7+Uv33ihzWGx2mR37iifvgdija4KGncAaDjHVpLt/0zgXfX
         fj/uXoqRZ2TJlLJwbjUGI8hd9RWgYYJfIDTDrghI5Imwscx1pvQjLX/H4xA68PKOcP2H
         yucUXmKjMvP29WbwXr7wZaCBZ/y4RoZYKVXBlZ/5QgMmRv+raskakybhAR6/II2QtKMK
         qyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681555; x=1702286355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5Rd1tgTUvyMs83JE7brV4nb0+zXx5TKbcvBUy55/2o=;
        b=CWcpHifXUuY8CmFWFuYx1QxQ4HeQCnSuBTDnWXvIsM6KdNdN3NkNFTMk+l31AgFZWX
         cPHVqxMvKewYwTuHJK6JqGBcS+dhpzhM2lVFbbpih2B1eUd9tgBm9Beh8NN6dBCgzUeW
         cZ38f1CDkTzU/xfQb+qZEKcrc3otJudlIm5iJob2FFVJ1GEcjr+SaxmOw9JI5fUDg0yJ
         ZrXa3msrITOhnJRr/vRZjCwKcNEHOg4HobzjbRmXj3zwy8xj8++Id48rrCpsPAuwHMPk
         W4OR8rJuDOU2Sl4Jb8RDcYGJkyjMjC6g43FrhIt+8H4iTzgIdFsZVOeHjebgjnaGdJt+
         tMDA==
X-Gm-Message-State: AOJu0YxNvqBqSL66T4XzYGYEOJLIl5Hedjm4Ee4ZHy9duuIfVdI7jAbG
	vAPo4a5hmVWpuifW4oq8BiW7MUQFNgWYGw==
X-Google-Smtp-Source: AGHT+IE9v9rpIZoqrB5PjQQykbTo8vu9z/5iBxpRHLgykstmCBt71Zle0GvjKPmL4cmaxLKGTID/aJ6DXA/Suw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:9ad3:0:b0:5d3:9513:4aad with SMTP id
 r202-20020a819ad3000000b005d395134aadmr341892ywg.3.1701681555191; Mon, 04 Dec
 2023 01:19:15 -0800 (PST)
Date: Mon,  4 Dec 2023 09:19:07 +0000
In-Reply-To: <20231204091911.1326130-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204091911.1326130-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204091911.1326130-2-edumazet@google.com>
Subject: [PATCH iproute2 1/5] ip route: add support for TCP usec TS
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

linux-6.7 got support for TCP usec resolution timestamps,
using one bit in the features mask : RTAX_FEATURE_TCP_USEC_TS.

ip route add 10/8 ... features tcp_usec_ts

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 ip/iproute.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ip/iproute.c b/ip/iproute.c
index fdf1f9a9dd0a4b693516d0b29b12cd6463895317..73dbab48aa4533e2297a1b1dd43726b4b05466b9 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -351,6 +351,11 @@ static void print_rtax_features(FILE *fp, unsigned int features)
 		features &= ~RTAX_FEATURE_ECN;
 	}
 
+	if (features & RTAX_FEATURE_TCP_USEC_TS) {
+		print_null(PRINT_ANY, "tcp_usec_ts", "tcp_usec_ts ", NULL);
+		features &= ~RTAX_FEATURE_TCP_USEC_TS;
+	}
+
 	if (features)
 		print_0xhex(PRINT_ANY,
 			    "features", "%#llx ", of);
@@ -1349,6 +1354,8 @@ static int iproute_modify(int cmd, unsigned int flags, int argc, char **argv)
 
 				if (strcmp(*argv, "ecn") == 0)
 					features |= RTAX_FEATURE_ECN;
+				else if (strcmp(*argv, "tcp_usec_ts") == 0)
+					features |= RTAX_FEATURE_TCP_USEC_TS;
 				else
 					invarg("\"features\" value not valid\n", *argv);
 				break;
-- 
2.43.0.rc2.451.g8631bc7472-goog


