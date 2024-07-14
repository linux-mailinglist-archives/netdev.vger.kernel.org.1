Return-Path: <netdev+bounces-111372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F647930B36
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 20:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9487D1C20938
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202213B59C;
	Sun, 14 Jul 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ER5ULhGo"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534F11CB8;
	Sun, 14 Jul 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720982087; cv=none; b=gs4JxXuRTeltTwctAmjNMWt2swnr592laVUDuCb2RvEsBRAFokbxISVeL0sbACHtEJ7qaKsIrgbaIpkNLI+9cefng6Uk3HWASaRzPpxh/gCBDT/ZKuQ1p5Rie9u+UjiFIWubPXlKAUgKXamSSWrGx8JOF21wSz6lonAn4ewt+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720982087; c=relaxed/simple;
	bh=fzuTQnw5lleiRZ0IayazA7aAUaLTTw8Hba3Fc031SME=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pHl8Q+IMLb0xS8bm9va3NPBqOdQuQuQnEv9acW4rvUTIulhcNNLJ1AfpJdn6CuJDL0o5rhNmGbsIYfEIgBuWYsmvwG2orgEJAufuRbUH0QsxC/+efeVzuMSHiS18JIm44Lwhx0v2NxTLTH137azkNDyB845bGz0uilg5TD3wHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ER5ULhGo; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720982062; x=1721586862; i=markus.elfring@web.de;
	bh=pchrGxpoglpNRDaqcmRgxlF4ObCukq5qADbq5zjCBSA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ER5ULhGoqFmdRcs1W2y3+PCmAONsiCQuWq/3GX/vQRFgRy/y+vrC0m5HoSIOk/VT
	 gy59kjHtPQN+7ZxksqTfarxnogs+BL+NsAE5tXJPNYoRugFB9jnsaZaf3RI8liwN1
	 relmjwqnZTKyaQ8ooAhJIYdn5YeHjPMq8bjwNX+1rRLe3DKtyHUot6ORARrH9les9
	 I+jOtCPvorBHXMv4nzGbe+2o1ADd9bsDaWafSjjK0fZusjnvGpPl0OZC4XkEHOn+Z
	 lJ3PcGnjh99ux60MyG5nOUMAHoeQGnBMJbgG4LkuI0Hos4haEba8tjaPD/YeuIeII
	 zmbaCwdSJTeEwtYU6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQPZd-1sgajP2GwL-00Hexd; Sun, 14
 Jul 2024 20:34:22 +0200
Message-ID: <cc21bbb8-e6d3-4670-9d39-f5db0f27f8ce@web.de>
Date: Sun, 14 Jul 2024 20:34:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Benjamin Poirier <bpoirier@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>, Jakub Kicinski <kuba@kernel.org>,
 Kevin Hao <haokexin@gmail.com>, Liang Chen <liangchen.linux@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] pktgen: Use seq_putc() in pktgen_if_show()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XNgmM3OfsFeaWgtKBaXqtNc3yzN5+fv9TV70VVDrlvTZxN3av4T
 zM1xjub7hn8T+lvTQ/kOLpLnlLhChn7AyFhjqO6pkxP1mhVLbOQnM9H8hE2ChMLGf/Y4xO6
 mndUNxBCiSnlhxRFDhSFclA1qbozRyvj8rwde06UfyjnM+Z8JQ5yERUkEKrw9MDxQz+hRm8
 3FGQMiWFtoMxfkHShLCQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I64haoflU4A=;8hLhysjiM8yWTlDyqwzRHtabkgR
 Z6wU9OVTmy7v2l36PCKl52yL/6GFgSmLjf87RQLifv71hNFRHdxoVBWE+fws4ykCcvGBWfCIH
 +8IdcyndHielbs/0MKymc7Bew+KYwneduKrhypfLLkXuTJnYclATG8ah1V3pQeGBHaIwS2i2g
 jSiUiy9imtQbvmAr9CPiVtJoB+g5fjY3BISVUkdSk07Pxm56hZBbYg/c+DloyKQ1Jp00cyoAQ
 wZJrIjtBholhr/PPXNl6dCyBdYIHptX1BQjcb0qz4wSX2khz0KJAhadoDMc5InOamCfTAs/MN
 wm8eN05150A6DY9wrzOJiD/RT3UBCe7UMU54VllKwHxrTqxLpNMl07WCnq+nx+0fRhKJLraVm
 21TL4PMbyS1sd2JsZHQUR9C2IJb+yK706eIh3XocEM14GXQeGKf4A5Aw5lA1/pUnwZXGnyntK
 SRdWT+5n90DSPF8rQEFKn0IjDg+Exc77A9eIpaY1HkeTj8YK5harwP2mBsblR39ycfDpWn3v1
 by3Cx1zR+In/dw77oFJA+jr7mSvKtwNYYkW17RuQwVRH67JBF/CkRpdliFeQT+IUP5dJ4iku1
 R9iH65TMtHYaZKowXmD/uK+3g7+Jzuw6zSXRgegxzKUTSWcI28L6eJkbdCrINNDZ6IdFS9R5g
 bIEFDd42rQWJFtKBisxOTMb4cEToBp6iJBTvNNEKhBl73GM20ajLOj1dzdiP0oqH8Im+QViCP
 hbtgHqK06nnlNTrXhVrGQxWBrRtbkjREiYqOKrNjBxVpqycMmy1ezltEL9o7KcUA1n5voyyIq
 rir7hVxAndPk+EvmZUcbLq4w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 20:23:49 +0200

Single line breaks should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/core/pktgen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ea55a758a475..441e058d6726 100644
=2D-- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -577,7 +577,7 @@ static int pktgen_if_show(struct seq_file *seq, void *=
v)
 				   pkt_dev->imix_entries[i].size,
 				   pkt_dev->imix_entries[i].weight);
 		}
-		seq_puts(seq, "\n");
+		seq_putc(seq, '\n');
 	}

 	seq_printf(seq,
@@ -685,7 +685,7 @@ static int pktgen_if_show(struct seq_file *seq, void *=
v)
 		}
 	}

-	seq_puts(seq, "\n");
+	seq_putc(seq, '\n');

 	/* not really stopped, more like last-running-at */
 	stopped =3D pkt_dev->running ? ktime_get() : pkt_dev->stopped_at;
@@ -706,7 +706,7 @@ static int pktgen_if_show(struct seq_file *seq, void *=
v)
 				   pkt_dev->imix_entries[i].size,
 				   pkt_dev->imix_entries[i].count_so_far);
 		}
-		seq_puts(seq, "\n");
+		seq_putc(seq, '\n');
 	}

 	seq_printf(seq,
=2D-
2.45.2


