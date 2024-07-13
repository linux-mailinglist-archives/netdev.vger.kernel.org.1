Return-Path: <netdev+bounces-111241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A449305B4
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 15:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D845B215C5
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF466EB5C;
	Sat, 13 Jul 2024 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="v18MvWA1"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3041C2BE;
	Sat, 13 Jul 2024 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720876756; cv=none; b=PYOQkQP9F5SygqE5C7vTdgS8hyu+tISdFiTOIgX7SaH0FRegPIrNR5lcMAnk4AteHd0TwvUVKPEXYIYmhiy8nAcTxtIW6S4UmvZ6ZP7870TzfjgXsBwWftvp0HE7zzZCDinOWu8UMcnK4KWGCiSBFNEedKV4c/g38rY3CMWFyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720876756; c=relaxed/simple;
	bh=Jor+11MsKH+fiKrgM1crkatfFlEYxyfOLXYjYTcJWYI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=X606S8Iy+wYaaOMWBoPi0DfTOO6bqpDDB/HZ5oSm1iZfOcwPw/AhzugiImsYUGtxgoTuZY9ekj1K734j8Zumq2L/pV4NfK5eYKuwGRA7Mh6WvvDtURPKHoPxqrMV5BoCJxfSrSuzLH5rtoJYgv96otm2t9RRLygrSDrIo7WDLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=v18MvWA1; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720876726; x=1721481526; i=markus.elfring@web.de;
	bh=Uc/1j0byJ3bja6L2DajnHc7fJ0Ad8rFraEJiCZAlxNE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=v18MvWA14jBze7ckXS1UR5OR0TCiCYVPzG4E7J38Y+JyZ/bNLf+GQ3PBTSeQAHiX
	 yZ5poyFziD4l1aEhYnwcJEgMu8Z4k7MG8ApNIocQ7i94JecNipLXsx1H4h9/5ZAJ2
	 QYQhzh/Mw5m33q1XEQapaC6qe5IwC53+Ga0HcfbT1GiEA28i5gnYQP65ZbHFLks/o
	 Vr63gSmcZixW/QzscBWka2sjIougOzcT+7EeTlcEMVVlrznhWP+PFyYQ0VfvGAKkG
	 pv/Vh2XnFTSYAOitbxIAFggtomDjYZACXwjaRUOkgY7juYQNTiDY9CV+4HryNDYq0
	 q5jSsKVpU25xqnKhZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqIB7-1rxdKv0GlH-00qCKl; Sat, 13
 Jul 2024 15:18:46 +0200
Message-ID: <add2bb00-4ac1-485d-839a-55670e2c7915@web.de>
Date: Sat, 13 Jul 2024 15:18:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Paul Durrant <paul@xen.org>,
 Wei Liu <wei.liu@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] xen-netback: Use seq_putc() in xenvif_dump_hash_info()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AIrV8FNxldBf3/OgDzktRpiIaej6QPYpC2zglGR/eidUfOHgox9
 TI2JV3ir65RmcgVVOglq7scUyOukDkTm5ay8GBZhmXZaWFc6ks8t3nZiUwLtKXgUvRcUoDJ
 B0aBelAXN/iOnU/ycfgbET0zdJwh7QsVK9Q+RwiEcOtBuyIzkHKILuD0AiFJs+XlO7trez/
 kCpK5OccjG3pxsQFKm1yA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jxI6I0rfSEk=;rQ4ywyxfN56rW1wln+LjKtUrHbX
 DPajc2pj9fYcgChCM13odsJprWwqDmDzG/6oyreimFWmpgka6DQ5xSFazZd2Y/tcjf7Kyl53x
 Zgg/sZoURTwejjunSJ94qusv76oJJZPmDzVDTWh3OTP8nZu9yVD1eMdffRP1h8iO8hdTWQBjI
 HsDuZ3VTg1c9vM5DxY8j2yl5GM8izEI91boElESrBNJTzlcbcnXBqe7iqJmz7PP3iSun08OHP
 adfvEZxqvNe3bUoASXbbFtewaZ5UaMn8pg4162VKCQD6jSv/D52h11w3kDUUd1lCWi+AZpO0Z
 2RU7lFU1WxyEtlxMa4HPDYDwb8vFtcEatfKAfjyhfOjeoB13xAJkfpWxQ1Pm1Vb3COHSiAZr3
 TTCrvk6SkQJ3RUcRLD8OIBWXtFtLgMB36XlfOOASfdtpKyTXb1ca68HUMm27TBoVJGxrjZoSB
 W2TptLWdZyz/ey+AYnW+T93Ru+D4Pi/MEj6vG38WZFk6gRxrZnpmSUQoWJsKry+DIqxC4Rq+E
 k6BvvAqSHwZKvFVTOT0n2JNZOOolcgNSl3L1d2gVKDwt7QcT/laKjx4Ew5zAQpIp/rG+L+v/d
 ALwxg5V59fLmbAHYmD+jtyFAt/7EZSnhwBqITHL3aI9GQlLzz7UhcHdTF92cNlzLmoT59Gnyo
 fdcJdK67ujx5f/Q3ShdFDZVXhZZP9W4spkM0Bcaw9u3aEchtoVCa84JAaHxDn2ckyZqtoelSN
 FHIDRJzuT835YA9pK7mFRrcmn92qieNMuZG7koR7BnJsWqY1mfyalzHFWJNSAsXb9GB+GoCq/
 fskNeLwv3Etevn+LBr8f7JbA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jul 2024 15:10:15 +0200

Single characters (line breaks) should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/xen-netback/hash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash=
.c
index ff96f22648ef..2d77a7187e1e 100644
=2D-- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -425,7 +425,7 @@ void xenvif_dump_hash_info(struct xenvif *vif, struct =
seq_file *m)
 		for (j =3D 0; j < n; j++, i++)
 			seq_printf(m, "%02x ", vif->hash.key[i]);

-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}

 	if (vif->hash.size !=3D 0) {
@@ -445,7 +445,7 @@ void xenvif_dump_hash_info(struct xenvif *vif, struct =
seq_file *m)
 			for (j =3D 0; j < n; j++, i++)
 				seq_printf(m, "%4u ", mapping[i]);

-			seq_puts(m, "\n");
+			seq_putc(m, '\n');
 		}
 	}
 }
=2D-
2.45.2


