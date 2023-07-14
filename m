Return-Path: <netdev+bounces-17856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F6B753480
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFDC2820E8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966567499;
	Fri, 14 Jul 2023 08:02:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E8D747B
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:02:20 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CAF3A8B
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:02:18 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R2P8Q3dQwzBR9sh
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 16:02:14 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689321734; x=1691913735; bh=+kfv0rzFf1YF8igHb2UwtVQy61O
	3wotE1gBrJRPYCM8=; b=qO3kPVroR4qrteqpYfXvVZSkwnhi5wXN4Iycz10MZm1
	octNyyGopPOYeVoOEbB2vEnO+yxnWcejTESG+bYkZEkeRcQiWSs5QWceA1jdSEsK
	HGiIfYOAIzrjgm5s4kG9E+Y8ST4gljMdsYABizaJPWBVtqwBU8PPcN0uJ7b+NtLj
	lPbiWceK1h/wM+/oLEi1nnNKff4x7B3VHxHx45BD0oVkGls98dcczY5Wtdb80G6z
	qm0744FKzFtwQ2Ugl8Jef9JINtmLQJG7d0SHDU/xhaKExLOwl+7YQGGs2cIsaKY4
	KFsck9DcTUkzM9i18ZSnYXz+JeSlVbBw3iPg7P++vZQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BlXF6PIAeuBx for <netdev@vger.kernel.org>;
	Fri, 14 Jul 2023 16:02:14 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R2P8Q0SgwzBR9sc;
	Fri, 14 Jul 2023 16:02:14 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Jul 2023 16:02:13 +0800
From: hanyu001@208suo.com
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/slip: Add space after that ','
In-Reply-To: <tencent_C824D439C8CE96AD83779E068967114FF105@qq.com>
References: <tencent_C824D439C8CE96AD83779E068967114FF105@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <4b922e9203381b3411696feae9ee02da@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Fix Error reported by checkpatch.pl

./drivers/net/slip/slhc.c:381: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/slip/slhc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index befdf4a..cf0245a 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -378,7 +378,7 @@ struct slcompress *
          goto uncompressed;
      }
      if((deltaS = ntohs(th->window) - ntohs(oth->window)) != 0){
-        cp = encode(cp,deltaS);
+        cp = encode(cp, deltaS);
          changes |= NEW_W;
      }
      if((deltaA = ntohl(th->ack_seq) - ntohl(oth->ack_seq)) != 0L){

