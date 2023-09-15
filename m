Return-Path: <netdev+bounces-34143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8227A2562
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C118A281D79
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FE918AE7;
	Fri, 15 Sep 2023 18:12:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A715E93
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:12:50 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB961FD7
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:12:49 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694801567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1lgYYAsG57snL31iQEKiT+ZxutAikuTvErgxmStpu0=;
	b=QvfeEqgn4KAO80bGjM8RONKradQxrLfIjxn6xIiisLc+Y0rNuWhYqCZ79wMtKAMtnp1Z6r
	uaztU4BSdzZK8x7qtPBRTEN2yxxBJ7o5i02fKaMUMGz9p+mYiUr9WNAm+vfncnvzB8Iqfk
	R+THcMqRPHJJ6XNqE0teoCTI0hQpQeJqwR08ndj8TMtkkhbrd5LboYQeRO/ziYgAMndFrl
	oCtCo2EFyWiiJtbooAEBO7JEvltU66rGEmiMUpQcpnTJZAmgmE+6CB9x4N1t5yrubRZHtN
	/Pfg5SK8OmE4l4lFdYKN2h6V4BXBpd3Wz9+3vWKvWx2qRv0+Phhbaz4v/zJYkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694801567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1lgYYAsG57snL31iQEKiT+ZxutAikuTvErgxmStpu0=;
	b=jRoacA7MO2KaB7SuAFEd0Qxc2zvuhyixbpLbM3zzhcsdIhHvmmvHxXNlLfF4EJ3gPhyEwm
	UEmSsP7jdcg6IgCw==
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
Subject: [PATCH net-next 2/5] net: hsr: Add __packed to struct hsr_sup_tlv.
Date: Fri, 15 Sep 2023 20:10:03 +0200
Message-Id: <20230915181006.2086061-3-bigeasy@linutronix.de>
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

Struct hsr_sup_tlv describes HW layout and therefore it needs a __packed
attribute to ensure the compiler does not add any padding.
Due to the size and __packed attribute of the structs that use
hsr_sup_tlv it has no functional impact.

Add __packed to struct hsr_sup_tlv.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 6851e33df7d14..18e01791ad799 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -83,7 +83,7 @@ struct hsr_vlan_ethhdr {
 struct hsr_sup_tlv {
 	u8		HSR_TLV_type;
 	u8		HSR_TLV_length;
-};
+} __packed;
=20
 /* HSR/PRP Supervision Frame data types.
  * Field names as defined in the IEC:2010 standard for HSR.
--=20
2.40.1


