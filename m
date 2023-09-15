Return-Path: <netdev+bounces-34144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379377A2563
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77CC1C20A3C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D28618E0A;
	Fri, 15 Sep 2023 18:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665715EBF
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:12:50 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F21FE8
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:12:49 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694801568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FCDZpNVUthe5YJ6++GFz+34R4wqawny6ddWnkhAFU4=;
	b=kgBQVXDwC0IHZ5nKQplkzieglAChuCsnNQ4l+vrWK1dqHUxIMBqE+uDCG+Y5lQyPNVXTEp
	C0JFIV5KQdUFr5rI1dQl4S2EPCmmb90+dCrJXX+AkJsGQXbK67KA274IpCBg4EbhjSfo1K
	nMCLoLNn1UWuSMmN23yVYTg1HcxULmnC6xl1J+RhdojBqcu5LM1WKmgLI9xBgsr3mLpMcL
	hJwyeVHuoQ12b/ARECp0OGbJdCUjPeFyaHKwwPnjuwlTBhCE8x1I0yoHcPfZdcT/y2pWqE
	CJN+3nBdeB1+cAdY3FSxuE0ulT6Bvc3Zr1dCBJ/Lcowx94ND4a31RP78YYd+uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694801568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FCDZpNVUthe5YJ6++GFz+34R4wqawny6ddWnkhAFU4=;
	b=u7kjFERgvC5nggZkFazhiaj7j61gUdkby4wJ7hHUoTTn0VLLL9dgmWC5XOBKOVp01O5js6
	t/f4jkBvloA5PDAQ==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Oetken <ennoerlangen@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lukasz Majewski <lukma@denx.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 3/5] selftests: hsr: Use `let' properly.
Date: Fri, 15 Sep 2023 20:10:04 +0200
Message-Id: <20230915181006.2086061-4-bigeasy@linutronix.de>
In-Reply-To: <20230915181006.2086061-1-bigeasy@linutronix.de>
References: <20230915181006.2086061-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The timeout in the while loop is never subtracted due wrong usage of
`let' leading to an endless loop if the former condition never gets
true.

Put the statement for let in quotes so it is parsed as a single
statement.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/net/hsr/hsr_ping.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/se=
lftests/net/hsr/hsr_ping.sh
index df91435387086..183f4a0f19dd9 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -197,7 +197,7 @@ do
 		break
 	fi
 	sleep 1
-	let WAIT =3D WAIT - 1
+	let "WAIT =3D WAIT - 1"
 done
=20
 # Just a safety delay in case the above check didn't handle it.
--=20
2.40.1


