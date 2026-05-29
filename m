Return-Path: <netdev+bounces-293059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP1cLYVcGWoLvwgAu9opvQ
	(envelope-from <netdev+bounces-293059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:29:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3925FFF2F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C9613067212
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CD03BD62F;
	Fri, 29 May 2026 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ZD2IhUJP"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4283BD625
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046821; cv=none; b=mnFxvQUNVNfCdjPFXMekXvG1NRBP3ybHIhwgXOW2v2SbANBiSMoUEi7eZiWZnd4HIOR66P0ameKFQx/qZRFs3Hdmm+WZFMENfp4J0sEzAe2dIoJHUV/JxO1uiFkCIIp+BGQRqggyTnxfqz2cZk8MCmqI/mtLQGbn05yAyOe6hbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046821; c=relaxed/simple;
	bh=JPf46eayWBa7wEKjsc7ZCuw/e1iWpOcwv12thpyLEdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvMyzMUfi6N78ZnYdZGMEKGDkX73NSWWRh+1mSQ4lXH321m4E03XD/SdYB/suNYL3auqEmD8cSs2bfdTY3KaPo3LFpU5sE5bfcOWksaI1zs5+ePVfgGPyI0lanDW9efCryARxnH8qcvMU3tVTbX0i0/ZxClMh/fhQPNN7BJ4HAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ZD2IhUJP; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E93742069C;
	Fri, 29 May 2026 11:26:58 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HoQBP5kzsaoo; Fri, 29 May 2026 11:26:55 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B2AEE207B0;
	Fri, 29 May 2026 11:26:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B2AEE207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780046815;
	bh=4uivs2K2N8h4QJZ9APxH+LeDm8lrLlqk8tLSHyEdUF4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ZD2IhUJPHNuoCd7B0CkOwa7l1Kn74UCfqK3mvpWF3SuozVBvb4gVooMGBY/Dsh0f9
	 hFdPs0vFmV8X16W2KFBEeIxW943SfKIliPohNzcrunw5+3HHIO1cHJRVLJ69baDF0u
	 K/VnBOYk2midWdpFSDy/aKwHaVlWclmsxuMUifgleiOK/WB5SAIiCy/F8MkWnh1tBI
	 9xVbXyg2NyiFCcE9lmjq7XicW5Y89YI5EBFRHyc6pyYytDLN/B6itbq3ThtInlndUH
	 ndU/Nb19FHTm64b1FXMNh8DAHFU0dWP1mIEX+DAp9eZ1YRaVe5clKNabx0poFhjIqJ
	 d7b4xVDi0PStg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 11:26:55 +0200
Received: (nullmailer pid 3879693 invoked by uid 1000);
	Fri, 29 May 2026 09:26:51 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 02/10] xfrm: ipcomp: Free destination pages on acomp errors
Date: Fri, 29 May 2026 11:26:04 +0200
Message-ID: <20260529092648.3878973-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529092648.3878973-1-steffen.klassert@secunet.com>
References: <20260529092648.3878973-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293059-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,secunet.com:email,secunet.com:mid,secunet.com:dkim,apana.org.au:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA3925FFF2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Herbert Xu <herbert@gondor.apana.org.au>

Move the out_free_req label up by a couple of lines so that the
allocated dst SG list gets freed on error as well as success.

Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_ipcomp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 5f38dff16177..671d48f8c937 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -51,11 +51,15 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 	struct scatterlist *dsg;
 	int len, dlen;
 
-	if (unlikely(err))
-		goto out_free_req;
+	if (unlikely(!req))
+		return err;
 
 	extra = acomp_request_extra(req);
 	dsg = extra->sg;
+
+	if (unlikely(err))
+		goto out_free_req;
+
 	dlen = req->dlen;
 
 	pskb_trim_unique(skb, 0);
@@ -84,10 +88,10 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 		skb_shinfo(skb)->nr_frags++;
 	} while ((dlen -= len));
 
-	for (; dsg; dsg = sg_next(dsg))
+out_free_req:
+	for (; dsg && sg_page(dsg); dsg = sg_next(dsg))
 		__free_page(sg_page(dsg));
 
-out_free_req:
 	acomp_request_free(req);
 	return err;
 }
-- 
2.43.0


