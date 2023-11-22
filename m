Return-Path: <netdev+bounces-49849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482647F3AD5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FB61C20971
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3A010E5;
	Wed, 22 Nov 2023 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eHy7gGcS"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2526D112;
	Tue, 21 Nov 2023 16:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1700614262; bh=gzvxNaFgXpUPDEUAHkQPkAaRXyYwT0flcIsNk4lBtvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eHy7gGcSqcOry15C7ucAHzPHBpCcAeTPNJF6rNhh84yKziGnJnLzB3WkXxu/Yp724
	 H+DKCiIwUOeP0e1DONCK0N/StyCh9mj3nKdorOm8UwsFe+s+LCdnHm/33dtEu0iKAs
	 C/VqE/QE+w454amPnO3zk6e/sCvh5SRAQsOruLPI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id CB7B5A80; Wed, 22 Nov 2023 08:50:55 +0800
X-QQ-mid: xmsmtpt1700614255tc8djfbyw
Message-ID: <tencent_884D1773977426D9D3600371696883B6A405@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9ovjyRgGNqgtMh6Va05ELoy2/HMi6IsAkx4szUMBjSpTD+efd4/
	 ov9kgVGiM/scZ0CutViE1B97RX0XHB6K3ewEpzAtd9+yFfRbnUj9WEZ9Bd1lW+hdhIgoT7knR5P5
	 AvmevPfcyOb8Q1Pf283rP6fxMoSMzU7esdpmXZ8Nw7+U2f3Dmxurp9W5yaPNyvAmgVub4v/eqKPc
	 M0n9sOEYAc952p7plqJG51dsVJL/zmgo2nmNzO7R//sBQciI767tEoe2ZI9bg9FZ5jfnE4RM9NRF
	 OlXoz1B1E0jZUuMDBvM29dczwMpbGZ0STD33HBb+W2+7nV8RBvsEsVQpmJ0HflOKUYabAwkmf4Mp
	 e0FqFZyRF2qNK2busSQMv6ptOwaa/Yxk59a2I86AHNjmzA64Py5Tgd0i86qYtJURLsWvTOLx29hS
	 IOd1qWY35fn7Vx4eN1iUWZz0fg6u26iClnu+NEhuiLJQ9vjOnCMv3Isj8uENMLNs5RB6Wz9eaEU4
	 yEUQ2/i4j8I/roydVJb8XztnEWTZYtTuW4MawdgY4tPLIcubZR4G+JkZamrR1GTK9B0DupfCiGTQ
	 Peofz4F2gAN3we5PJEc0KceR61ZLBnnOG470q6tkhwrsT7+fNBnpW4QKQrWU+/Sror7Gs7cymUgw
	 08pvkKMFOIyOyN2OgEofXAYVW4EDmY5W+r4ThwO7Tkxi+AqnvNdXnFwiFlqMKT+8P/WrIfyQpeKd
	 Bp7fQeJQv5wSKhGjSa6wLMYuq5J6znE+3634ZZ5Odg1g4mlO46H1cUHd3TtUbHTqfoPRiitmgbhx
	 TU35ZDjq0D8B/eP+748ZE1n646xOLLxoIJlE9TJk6bpIZnQrFde8ch+1artGe9yRoXz+VjDrouC1
	 4JFfLqg/YJiaSnBXpDH2IFKP0tBbKiUQLvrYVZ2KVUzPZP65cm3wWPDdU5fOd9UFu9bNusK+Il
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	haoluo@google.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	mhiramat@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	sdf@google.com,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yhs@fb.com,
	yonghong.song@linux.dev
Subject: [PATCH net] bpf: test_run: fix WARNING in format_decode
Date: Wed, 22 Nov 2023 08:50:56 +0800
X-OQ-MSGID: <20231122005055.3594477-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000004b6de5060ab1545b@google.com>
References: <0000000000004b6de5060ab1545b@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Confirm that skb->len is not 0 to ensure that skb length is valid.

Fixes: 114039b34201 ("bpf: Move skb->len == 0 checks into __bpf_redirect")
Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bpf/test_run.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index c9fdcc5cdce1..78258a822a5c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -845,6 +845,9 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 {
 	struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
 
+	if (!skb->len)
+		return -EINVAL;
+
 	if (!__skb)
 		return 0;
 
-- 
2.26.1


