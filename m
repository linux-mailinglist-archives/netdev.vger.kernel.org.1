Return-Path: <netdev+bounces-61271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA02823031
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031D4B22E73
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94251A708;
	Wed,  3 Jan 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRtSDLfN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF61A704
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704294398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wEHakIYqdfU8FEDiDv2kbLLbw2wVp310Y7yIEyIyaLU=;
	b=dRtSDLfN+zbZi1qlyaERYgLCRjwpV+RJyoYvFHdozqoqavXZZ1gWVyyBpDV52TdKhA2tBj
	Zjdk8RQJPlxdCOGQFyVV8gVphydln2fIXFpn3wv0Vvmi7kuwDGz1If1oOF8zjKWVs/xksS
	SVd+7tKVoDztXkKfGyQZl/+hDDswaaQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-7ERukYGZPyOu8qoJI1KOtA-1; Wed, 03 Jan 2024 10:06:36 -0500
X-MC-Unique: 7ERukYGZPyOu8qoJI1KOtA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d76064581so27429005e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 07:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704294395; x=1704899195;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEHakIYqdfU8FEDiDv2kbLLbw2wVp310Y7yIEyIyaLU=;
        b=pSi6yYtjBTL8QnVVsRNCqy/FippLpQcBtnFU0z6RkJKrBmM5OSdoE0fj+G+GfqiXbC
         oWmjCNziXfxTgwed8q+pasr9SjwsJraMmGQvPd6wZvjNoq93H4DzsPDdZ4oaJkNDQI5t
         aMDIZ1V/XrXxK7MhuZm+IEDhV9tZqixQNGPfdWfVAeRVgNJKsr62FkYBnolEOh0vjtY+
         pTiY1EwvAvT8qkjjPXfSzhXrluTLwx0VkdTO5g8yW0VbXRsfp9eok2bHSUJbzLYeQVEj
         fdpzkh0rfpXItLzjd9ByZN/la8/lsLgGRmWkrfOkgP7rUna7de4DJTJQ64jvEFkc0wdH
         rDRw==
X-Gm-Message-State: AOJu0YxhiyXKuQf5dRxnmof4biXsg87H3IG7kw2CuHMuF21+ag17rPE0
	vgqd9jnx7kxGUrxOthcc2eGwXxNRldaCZMz1ASVSf5MbhMEU+zF7r6jdWv2ttnQtxh4ZQxJOhwo
	Z7n35TWek8c+nsMaUYavwPmMg
X-Received: by 2002:adf:f505:0:b0:336:7b50:1f31 with SMTP id q5-20020adff505000000b003367b501f31mr10736881wro.109.1704294395590;
        Wed, 03 Jan 2024 07:06:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+Oo7EUzGD/CvnFLd9O44zNnPLXt7KFUgk8azlxRsPAoYBqpIIPl9yapWYvXDL1efHwilQTw==
X-Received: by 2002:adf:f505:0:b0:336:7b50:1f31 with SMTP id q5-20020adff505000000b003367b501f31mr10736869wro.109.1704294395257;
        Wed, 03 Jan 2024 07:06:35 -0800 (PST)
Received: from debian (2a01cb058918ce001c33ce3a2d76e909.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:1c33:ce3a:2d76:e909])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d48d1000000b00336e15fbc85sm19911082wrs.82.2024.01.03.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 07:06:34 -0800 (PST)
Date: Wed, 3 Jan 2024 16:06:32 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH net] xfrm: Clear low order bits of ->flowi4_tos in
 decode_session4().
Message-ID: <73ad04e0f34b17b02d1eca263e4008440cf3b8e4.1704294322.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 23e7b1bfed61 ("xfrm: Don't accidentally set RTO_ONLINK in
decode_session4()") fixed a problem where decode_session4() could
erroneously set the RTO_ONLINK flag for IPv4 route lookups. This
problem was reintroduced when decode_session4() was modified to
use the flow dissector.

Fix this by clearing again the two low order bits of ->flowi4_tos.
Found by code inspection, compile tested only.

Fixes: 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c13dc3ef7910..e69d588caa0c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3416,7 +3416,7 @@ decode_session4(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 	}
 
 	fl4->flowi4_proto = flkeys->basic.ip_proto;
-	fl4->flowi4_tos = flkeys->ip.tos;
+	fl4->flowi4_tos = flkeys->ip.tos & ~INET_ECN_MASK;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.39.2


