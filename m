Return-Path: <netdev+bounces-54228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C66A806471
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 02:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4751F213E9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34663FF5;
	Wed,  6 Dec 2023 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Kl8NdM7O"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B400D3;
	Tue,  5 Dec 2023 17:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1701827718; bh=LLIH0Kz5ZGnGw4QusRBHhQkk9DqEy2V1LnzsVnAxE08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kl8NdM7OttnlooJObHNMvpkPFYxgbOVJXgu054MC1iVQhfWk5SUU02jaO7wTvhDDA
	 hdmoI6tKyMH4XpcIxwpQStxUd5EnjQRJben8AmSjHntWjjp8dUqsOEvIr9YWejcPLW
	 2BFN1N3n3RzGxqwyPkCw+Vuxvb1IJditnACbB+gw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id DCF1881E; Wed, 06 Dec 2023 09:55:15 +0800
X-QQ-mid: xmsmtpt1701827715tekr0z5d0
Message-ID: <tencent_269592755DA55D9B19384F870D9D25B18D07@qq.com>
X-QQ-XMAILINFO: M6RB6eJp7HzZu+e0I1xlRxRIxeLQsIxaMD2c1yFHjP4Bd9gRQHaMjWbpzpgxtp
	 VuDC9mHp9V5kCMIPX79Tr5d7vImOOpzCNb4bz89+zob7l7zB8mV8RUMUHwa+2iv3LahGlbJ4kZ2a
	 zX8euMtH33HONVYDmVHZdQwLVzSU4yE4nXjXXQw1Uple+xUkxZrtPUjl+5xCox9anX3gmJEyOfHi
	 J7yd7d34nco79aqhiBesMfsQX3T5Iro2n3FmH1Sz93/aLZaLrsVCNux8HyFo3eh5/83iQ0hfTkyD
	 sbjSFkLRKk0Ikj0Vrct+HKZobD3zT0MlcaHUSq2BtpZZPYjtU7XHnWEAl2Sls85A2/iOTIwj0gUM
	 ExGe1YVRu0sHerkEdGGwNO6xuKyZY3aYL+5iIeTwPLu6bKt64eAdYOSsmusEP1vt1M8zLMOcTWPc
	 YRR00S2wGqSqJD9gDZED4eFq+6SR7bo6qXFUMrRmuM80gYrvAOBFP4PxLoB1sx2661E5hB7Q3g+j
	 81DrmLJNjqeUqIlusSJn4XrQVyHqssNDUQG7Vh9AOvEhrk9kO5yNRHjFR8ZssTNtIGfZhGd9RvqL
	 jB4OjcRmajNaLo9o/uV3Ixzwp1Qizxv/paMAFNhqyVBPoyOXM4z542GLkW7cXstlUlV4Rfk2hF/8
	 ef7klQMGE1vA1bhfOXp5EpVMVFK5CAhBXZ5gqLqzGbbEyBE3bx4zqPHnhapPgaoyPbIvyYt7fPLo
	 +WOnlL+UMzkwpXLCSHKElkoPkfh3eVE4J3t9FmPZW62p0/q58uwxx7+qV1jQklqF8PUtLaXm3PI5
	 OqDLaaxYQawksHU79XtHUEG9F+XXxX/Evnoufk1VUzmp63l/ux1ZZxJjaZUpQNUUff47rtmYjCFX
	 k0x99cpzhgKi8eROxbAawUrxiITBXn2twuRknGmIDl7ea21QpxLY4yI+4dbzYonmVao6c8OleK
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] llc: fix uninit-value in __llc_lookup_established
Date: Wed,  6 Dec 2023 09:55:15 +0800
X-OQ-MSGID: <20231206015514.2409439-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000001b9bed060bc75cbc@google.com>
References: <0000000000001b9bed060bc75cbc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***

llc only supports ETH_P_802_2 protocol, so drop the skb when the protocol is 
not it.

Reported-by: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/llc/llc_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 51bccfb00a9c..16b2c57f38c2 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -141,7 +141,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 			return 0;
 		if (unlikely(pskb_trim_rcsum(skb, data_size)))
 			return 0;
-	}
+	} else
+		return 0;
 	return 1;
 }
 
-- 
2.43.0



