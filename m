Return-Path: <netdev+bounces-111701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9728E9321F5
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5853B282541
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C6A1448ED;
	Tue, 16 Jul 2024 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="quiISYgu"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E42178378;
	Tue, 16 Jul 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119057; cv=none; b=QpLs7aYYL7dN0Lw46XiPFqlT2WTRukmY2Gj0jEQaOwb/OKIc8UgFh3h0TimJk9fqqN94GVROjkuAA6Bc+efDVw1oDa8D4O+/xXao3Q96UeXyu4Bm7icUwtnI551StlNI5P74PLJGHsPHibA5yZORozVtGVa3KbeLgezswIRd/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119057; c=relaxed/simple;
	bh=Mr/uMakLcuC7WzGCfsWpNQgKRVkSgGcbw8oXnlBJngw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=obeG6y5Z/7gcMJ5hlNEwm6POcKgYkj1DcvSaZP9yAXx8dkkKaeQf2TYY1FkSvKRiE/zNT8brpGFUah4Ap0IX6GhFN3Vcc8Iz/Eb+Skxg6X3vA/N/Yjv9HKsObn6Vv/oqNXjK6JCdA+xxaPZ7OBRKemG/adC1vbgPew9/qdHbkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=quiISYgu; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721119031; x=1721723831; i=markus.elfring@web.de;
	bh=kGIG2lk9JnUGS5D/DzGGpsIb8TqI9jSGdEPMw6I2qBg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=quiISYgunLxFVUByQIsXh1AXUlf1KHqxPHF7NcGDw5BSzCkxx6bmUerj7ZdVF3kk
	 uH63GsM7SWgvKRCT2oNt1hUh8LWOPWGlhDbRwDQlmziZ8iEN4qGFSOYhJIovq6Txd
	 9gGHLEJS82mmEr7dmE9Xh554FnP+6lBDtXNg2qt/GgPTkq+5aNlovpNzB+JVBIWYE
	 0eaBwl8VND196r5Mgn+4+VF4dXhb0d+WEQKdyy7ycNOLMpTtXdXqW1+jKpDr9HazK
	 7tiWuLUF1DLlECkBbgc8PlmtySp1sAncWUKrv0KCkJeK+X+6tLBXZJH48FPnUsFqb
	 Z3UWwvy7ydUi/Bwhug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJRb-1sshbU1VGJ-00R6y0; Tue, 16
 Jul 2024 10:37:11 +0200
Message-ID: <2c153a0f-87aa-4f4a-83cc-c17798f0795b@web.de>
Date: Tue, 16 Jul 2024 10:36:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] net/ipv6/ndisc: Fix typo in a comment line
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nQEHSPejrsVq+DGhGqvitACK7uhP97GuZ/FP+NcjWUwEb4FmnHO
 1GS+SyYMtauJon7zF2HtN41bteyORBlf+Xgl2hAeqjOsyJRbkuhxoMoe3PaCNeoAuX0IGPc
 Yto5bYstxgTiZ+eBRxtaXE/8Rn9uhlEYu26BCNLLBO+Z6yk935FefF+SGllZBXmGv9DusCx
 FxXFYUL1Mh0Q0deIpvIvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OTwN86JcMQ4=;N5iQnSN7aZOY/e8DQ0g839CdEPb
 KIHs06WlhycmawLMyM+7ShXB7O6r1NZdq0RtaEf0x9ME9baIAmHKfCAwa/fATJRHC7SAR/MaQ
 PB0d+j0FMQoPi/kcTCT93XATFZi/gzA648etRfXc/5s7B2HpwGUWEpVGx2p/sF0hVQOGcf/tg
 jXtN7TN2ebP8nX04/ZvdL/bvysxzGn7NH2UInssPYCduwKMgEno018jiLZm7MX6951VvNNgmL
 car0/p8C9ouBYZeU2I2S3WTGhYsP317el46Q7Jj70A28yKAFjHvtDKhkq3nLsKWpvhoPYTuFx
 fzK5jEET5WeW1HtyZtMGnt4ZKzz6J7GZVOyYhW8bDYuha5gCvQM7F+bEEBPa2vO9/fNlOmhR7
 Ev9/GCAjayDqbgiP3Dv2igbv4TsjoB0tlUjYl2/R2Lc7zZ7sHjPvpNb+ItD6f06Ksldb1Rbpj
 FYRoXp1On1S6TM8HOakiNS2VhXnr0JWIX0Z5Yx7GQOZIl0kI5nwEyzykIUoq8EWQkED2MlevS
 B9Cuc1w5IJKJbVIQYjHCB0PUaYEh/b+BIs5wvRG53OpIkukF0Uxmofino/xui9ZTEzWNBEnfU
 CGB/wmb/VkuCAFryC3T19VSzU9rIxEh4flaOsL0sIz1bBLeIa748ZDMNQnrbYv63QFfI3jL6m
 H+B7ppfDI5ROSy+cxaX/YkDDIzYPJ/4NgTWnC1hozwALzQA8ouu0nZix4YW4Bv2OhGN+YTYnY
 7Vs0nWMXfKRLjg+B+WN1OemuXkw2iUh41sLSh2AmUntu0GdBsVKxTMfLtBm4dpD6kuwS1Ujw7
 9H++H5DM+HgbHBXt6Mkma4rg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 Jul 2024 10:28:37 +0200

Adjust this description for a condition check.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/ipv6/ndisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 254b192c5705..4d0785bf6937 100644
=2D-- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1020,7 +1020,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_=
buff *skb)
 	}

 	/* For some 802.11 wireless deployments (and possibly other networks),
-	 * there will be a NA proxy and unsolicitd packets are attacks
+	 * there will be a NA proxy and unsolicited packets are attacks
 	 * and thus should not be accepted.
 	 * drop_unsolicited_na takes precedence over accept_untracked_na
 	 */
=2D-
2.45.2


