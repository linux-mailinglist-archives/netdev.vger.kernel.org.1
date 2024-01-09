Return-Path: <netdev+bounces-62692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42099828913
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFE0B22F27
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEDD39FE3;
	Tue,  9 Jan 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEDWvZAf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590763A267
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704814456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PedXoBJLPDoLNhxQ1NY5DR5qJ8OudrQSgaNvjyyoOas=;
	b=iEDWvZAfLLTIWIL0eqeAAetq/q7MlCrD02/9vZ3AFbJb1lZJAKP32D1z9aOb5V5/LGxaek
	lCvLb4FC1DfssplroQu1nj5QoOxD0pdMt5k55xyw8vmA6sHpVmqXxd4KObvMiOOgag2lOb
	uN94+cGqeSFpxaPx0NfS2j07tBTjwb0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-OO8f46pGNEiu999LdqROFQ-1; Tue,
 09 Jan 2024 10:34:13 -0500
X-MC-Unique: OO8f46pGNEiu999LdqROFQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 734343C02B87;
	Tue,  9 Jan 2024 15:34:13 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.254])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C353492BC7;
	Tue,  9 Jan 2024 15:34:11 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <hadi@cyberus.ca>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2 1/2] iplink_xstats: spelling fix in error message
Date: Tue,  9 Jan 2024 16:33:53 +0100
Message-ID: <52d94cd79743fcbfdc0767669f012a1ef2e926d8.1704813773.git.aclaudi@redhat.com>
In-Reply-To: <cover.1704813773.git.aclaudi@redhat.com>
References: <cover.1704813773.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Cannont --> Cannot

Fixes: 2b99748a60bf ("add missing iplink_xstats.c")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 ip/iplink_xstats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/iplink_xstats.c b/ip/iplink_xstats.c
index 6c184c02..8d367984 100644
--- a/ip/iplink_xstats.c
+++ b/ip/iplink_xstats.c
@@ -63,7 +63,7 @@ int iplink_ifla_xstats(int argc, char **argv)
 
 	if (rtnl_statsdump_req_filter(&rth, AF_UNSPEC, filt_mask,
 				      NULL, NULL) < 0) {
-		perror("Cannont send dump request");
+		perror("Cannot send dump request");
 		return -1;
 	}
 
-- 
2.43.0


