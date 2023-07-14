Return-Path: <netdev+bounces-17851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A98753396
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCA51C215BA
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6C7485;
	Fri, 14 Jul 2023 07:51:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37179747B
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:51:56 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECFF30E0
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 00:51:54 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4R2NwP5hwhzBR9sh
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:51:49 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1689321109; x=1691913110; bh=IaiEwpWcOFHXscK+oYD5U76t98y
	szi7NqZeEKNSqRBk=; b=UPQQYe7d9sTS+WovY2u4zuZoESRBRfC2obBygIUenvk
	z+wc5Wqx6ZLK5zRG1FRiVTN5Fwgu8+RkZeh/3DF44CP5kskmtX6+25sx7WWQ2PP4
	Jk+28ueE9oZ/iwYObD3oRidI3DwWNiAbmCeqeWtj/Q8X/Lgyr8+tFpmr+6NIv0DI
	5bgtqM/1Qh0dD0yAyQ+rjfHOtI0+WE2thbhhzvSQhPuz2fIobgxXH34wwXf8HL2a
	MB6vUuO4Kb+9BBYcYZyF4/CmyvXxxoowaItvrFfLh400OYfgC3G75lRGaX0V6x8X
	u5O5tH5Zu/gEwaXt1KyvWUpuku19I4KBK15C3JveYeA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WrJ54Odn6Sju for <netdev@vger.kernel.org>;
	Fri, 14 Jul 2023 15:51:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4R2NwP1rV8zBJYck;
	Fri, 14 Jul 2023 15:51:49 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Jul 2023 15:51:49 +0800
From: hanyu001@208suo.com
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] drivers/net/slip: Add space after that ','
In-Reply-To: <tencent_222320492FD62B52855A0449D87275D0CD0A@qq.com>
References: <tencent_222320492FD62B52855A0449D87275D0CD0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <05e49e0f838eb127cbaee30f1b404c19@208suo.com>
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

./drivers/net/slip/slhc.c:476: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:476: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:477: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:477: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/slip/slhc.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index 0011915..befdf4a 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -473,8 +473,8 @@ struct slcompress *
       * to use on future compressed packets in the protocol field).
       */
  uncompressed:
-    memcpy(&cs->cs_ip,ip,20);
-    memcpy(&cs->cs_tcp,th,20);
+    memcpy(&cs->cs_ip, ip, 20);
+    memcpy(&cs->cs_tcp, th, 20);
      if (ip->ihl > 5)
        memcpy(cs->cs_ipopt, ip+1, ((ip->ihl) - 5) * 4);
      if (th->doff > 5)

