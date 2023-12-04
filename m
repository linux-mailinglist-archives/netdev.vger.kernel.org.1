Return-Path: <netdev+bounces-53413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999FC802E65
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989151C20A73
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B194417998;
	Mon,  4 Dec 2023 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UH2NJLb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4864106
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:19:17 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-77da6895c5bso613383885a.3
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 01:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701681557; x=1702286357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYMb1BHlApXAbHoP7W0B6oQP1AUehiPBoha05ujq6jQ=;
        b=UH2NJLb6uXLbus016hF2cIFQLllJZr0+A8xNf8kkcfRd3AFX4IPVGPXch+IkAOJ+lz
         6sDq3G6vKVbKY9r9CBjo+XRnat/gSGF8R+9UVdNNg63oxlj++a70HGFIeHMMrnoBFCSA
         NRiAAzsZHOYGHMYllSwHfpCsrDaP3VPYmCxN808grQH+/dUN+FilLBL1GhwBlPmb8HBC
         8Tuuh2qfAxikTJeKNK0ZQy/ms2yk1LpYJrFMjSXIppGqZF2pJohuSBssNhUVHpdOnPC8
         DwHjDHoHmhXjFcp2NkpFUREgBS8txIzTqqCn3eTyD3zTjlQMJyHcFxKJjO7ebvt1bqI7
         hOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681557; x=1702286357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYMb1BHlApXAbHoP7W0B6oQP1AUehiPBoha05ujq6jQ=;
        b=PGH4AMLRDm6STSTY1Mqv+QFNxdRaodCl5/GiauLAK0YNNJLJus8en3v73YSY+u7ddP
         TsoNflis5ZNEVT6ovkyPuPFMd6g31nHz0mrE4xcxVh6BxT6+6Ny+kkvhSC6QtF/YBWcw
         vg3nwusDQp7oDcrkT288VKFlUVYpbkyY4JxnjF6p++I5EoMomqrHhJ32Hz/PRem2vZxT
         RI6b0+WZv0cYqppvH8PuTgH8I01Wlnegd9qTi8n7g+NWX4G5ooaCbRXss0NcFugQT3tR
         lG5Ei/IXPYm4ss96AUwTGiZXPDy0PuNi3Gv+4RBPYrtiKuDkJ+3IHIWPGdTwUEOX4IIe
         bbyA==
X-Gm-Message-State: AOJu0Yw2T7D45vuOpRgQv7OoyhrijojaMOdVgLjn1QUlruCuyeDavkRS
	4x0nx5YuTMWbVwPGSbK7qTvSoeYclITDVQ==
X-Google-Smtp-Source: AGHT+IGgFKYpE1W37ze1Tr2h0Pg4MlCQDqfP7UFlrloX/4oHocEGYEFhv+UjnxaRoLcfteCLtoEHC6LnYIEj7A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:e8f:b0:77d:bf6f:9290 with SMTP
 id w15-20020a05620a0e8f00b0077dbf6f9290mr518161qkm.13.1701681556828; Mon, 04
 Dec 2023 01:19:16 -0800 (PST)
Date: Mon,  4 Dec 2023 09:19:08 +0000
In-Reply-To: <20231204091911.1326130-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204091911.1326130-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204091911.1326130-3-edumazet@google.com>
Subject: [PATCH iproute2 2/5] ss: add report of TCPI_OPT_USEC_TS
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

linux-6.7 supports usec resolution in TCP TS values.
ss -ie can show if a flow is using this new resolution.

$ ss -tie
 ...
State Recv-Q Send-Q           Local Address:Port           Peer Address:Port Process
ESTAB 0      12869632 [2002:a05:6608:295::]:37054 [2002:a05:6608:297::]:35721
	 ts usec_ts sack bbr2s wscale:12,12 ...

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 misc/ss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/misc/ss.c b/misc/ss.c
index 9438382b8e667529dc2cf4b020d8696a4175e992..3dacee48db0f805b3a7a3bd213771b86eceea1ab 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -875,6 +875,7 @@ struct tcpstat {
 	unsigned long long  bytes_sent;
 	unsigned long long  bytes_retrans;
 	bool		    has_ts_opt;
+	bool		    has_usec_ts_opt;
 	bool		    has_sack_opt;
 	bool		    has_ecn_opt;
 	bool		    has_ecnseen_opt;
@@ -2562,6 +2563,8 @@ static void tcp_stats_print(struct tcpstat *s)
 
 	if (s->has_ts_opt)
 		out(" ts");
+	if (s->has_usec_ts_opt)
+		out(" usec_ts");
 	if (s->has_sack_opt)
 		out(" sack");
 	if (s->has_ecn_opt)
@@ -3037,6 +3040,7 @@ static void tcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
 
 		if (show_options) {
 			s.has_ts_opt	   = TCPI_HAS_OPT(info, TCPI_OPT_TIMESTAMPS);
+			s.has_usec_ts_opt  = TCPI_HAS_OPT(info, TCPI_OPT_USEC_TS);
 			s.has_sack_opt	   = TCPI_HAS_OPT(info, TCPI_OPT_SACK);
 			s.has_ecn_opt	   = TCPI_HAS_OPT(info, TCPI_OPT_ECN);
 			s.has_ecnseen_opt  = TCPI_HAS_OPT(info, TCPI_OPT_ECN_SEEN);
-- 
2.43.0.rc2.451.g8631bc7472-goog


