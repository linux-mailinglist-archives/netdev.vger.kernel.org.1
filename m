Return-Path: <netdev+bounces-47748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D577EB2AE
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 650D5B209F8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEA13FE4C;
	Tue, 14 Nov 2023 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Evm2cY8X"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DA3FB23
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 14:43:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8532910D
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 06:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699973024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mQIaQPMOld1Kc5nwv0wGbX0LFpmGQ9KKGNwoI/vm3Ic=;
	b=Evm2cY8XOGjOghpu84xE4s8MxGXF99GLdbKtpwGS98yvBNy0zM80cQV4y5ztNuGPrUhB/b
	0a6H2LCFzttYdLHZ74+gds9XBRWJnBssmaZN1+ltJ7KTHZowAi/r6uq3L8tdz8lSHHxTax
	Og+0cOklinwHTKNfQaqQ+lVW8hovsSQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-Wm5bxFlANDSI7YJdcdl3Nw-1; Tue, 14 Nov 2023 09:43:43 -0500
X-MC-Unique: Wm5bxFlANDSI7YJdcdl3Nw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c19a0a2fbfso2231111a12.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 06:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699973022; x=1700577822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQIaQPMOld1Kc5nwv0wGbX0LFpmGQ9KKGNwoI/vm3Ic=;
        b=jnx8emkU3Bo6EzNAUhCBC3wsfnPZ6YMORnyqhOTIgU2+JuEB7egav7ZdeBq9v5Hj8l
         F/EiZ3mJszUl3BPba66SL06sjXl6uvnFvxpvAOxbjw9S0rKgr5eldBICIXDghOmV0RWr
         XphUjycqR2XYptuY1B0Ks6R/ZL/OLfpJ++zdXQDW8x3v3Rdf4BgtkWQpOvntpSpsE+Uq
         AmZxPXc+FofMPGczArtO9qpIQMzeEP+jlmWj4Os60KRfsGrPPwt3gEALgKacmxe3c35z
         3GiQsFU3uyX7Hq/DNacq0lLbO5+hSO1xcC/mXK0VWnakLbs3qVuJjeFdbEOi4kojy7ba
         zxfg==
X-Gm-Message-State: AOJu0YwyTDyXn98p1MP6dbKrnNy7eeQ42Sm5rkUPf4gBR/F1zuqBJCaJ
	yNhxh8DPujOvZP6OemsvWTc7QPw2WnZidxnKOe10p0a/10nHmUvWOXksLPdJD+P04gKRVZbqgey
	W1rBomgYkPracBkSmywf2Si5BoTo=
X-Received: by 2002:a05:6a20:8403:b0:186:aac2:26b9 with SMTP id c3-20020a056a20840300b00186aac226b9mr6086433pzd.30.1699973022209;
        Tue, 14 Nov 2023 06:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK7BkhMmeEDIpgWq8BX2/zMWGfrbmoU5cFlw762Ol84eWMWoCowEUrKngx/sMldw6NAmVs4Q==
X-Received: by 2002:a05:6a20:8403:b0:186:aac2:26b9 with SMTP id c3-20020a056a20840300b00186aac226b9mr6086409pzd.30.1699973021834;
        Tue, 14 Nov 2023 06:43:41 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b006c33c82da67sm1208825pfe.213.2023.11.14.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:43:41 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] tipc: Remove redundant call to TLV_SPACE()
Date: Tue, 14 Nov 2023 23:43:36 +0900
Message-ID: <20231114144336.1714364-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of TLV_SPACE() is to add the TLV descriptor size to the size of
the TLV value passed as argument and align the resulting size to
TLV_ALIGNTO.

tipc_tlv_alloc() calls TLV_SPACE() on its argument. In other words,
tipc_tlv_alloc() takes its argument as the size of the TLV value. So the
call to TLV_SPACE() in tipc_get_err_tlv() is redundant. Let's remove this
redundancy.

Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/netlink_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 5bc076f2fa74..db0365c9b8bd 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -167,7 +167,7 @@ static struct sk_buff *tipc_get_err_tlv(char *str)
 	int str_len = strlen(str) + 1;
 	struct sk_buff *buf;
 
-	buf = tipc_tlv_alloc(TLV_SPACE(str_len));
+	buf = tipc_tlv_alloc(str_len);
 	if (buf)
 		tipc_add_tlv(buf, TIPC_TLV_ERROR_STRING, str, str_len);
 
-- 
2.41.0


