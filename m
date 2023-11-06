Return-Path: <netdev+bounces-46167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3697E1D17
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 10:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F9328111D
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1015AE2;
	Mon,  6 Nov 2023 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMvSuBPl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F30415ACC
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 09:17:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C89EA
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 01:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699262227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5e6mOiJPde7i1hVZv69YfOb7z/h87xjiUMR0oLDOiv4=;
	b=JMvSuBPlLAexp1xZ5gzc+dgD2Nt4gRoSdXsBz2Py2vqyC6/vsU0o9uR3nxN2RFJPz+R39b
	FsxQ1DFCqTmX7yDadqYMq+b8G6uul9PzJnK8nY+o3kC1bbBYllhg7SnaHcQO5aIa2XdBO/
	CzsGKRLxdYipIPqpKRQ6zifCfoMAcfY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-CIH1K9x_MmiA0I3zlBd3Ug-1; Mon, 06 Nov 2023 04:17:02 -0500
X-MC-Unique: CIH1K9x_MmiA0I3zlBd3Ug-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c45a6a8832so58589466b.1
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 01:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699262220; x=1699867020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5e6mOiJPde7i1hVZv69YfOb7z/h87xjiUMR0oLDOiv4=;
        b=WxSxz9OQrqKtaK7QAFWPjMImJcDjEnZRLhNFr8Bn18bc0qTfP7oBQk/5WbxLKboOh3
         wCJZc+2st99gIi7ziGTGkbsTpnN0QoauFkgZaDclC+Kog7GX9WVZwrMXZ17rUROQcxnY
         qdguBqwbcPldYHSigPpkGllww4zc4HScEKYbRR4kR15gng9FNa85YplwZxCEuRXFfD6B
         Xsv1wAsJGbOi23DpKKGLj3+HB2rcbzJo5p1CkSlMBi2HHkq6MJJTNmM2tlofwkXIIzKp
         hygHhW3M8meiCw1KvIT2UlSDg1+F73Bjoa8jGICJVPFRJyJHON5dI7sIz66weNT0GqxD
         5KDQ==
X-Gm-Message-State: AOJu0Yzo1uRzuFgfo0TwMuBGR0HW1Z+W8B1E9bhVyNsSfvoV/uMGqcjW
	P8apBoaQrveqNEdsrrPP7s/dR5Mpmk+J3qGs74j7f99/HIgTl6DpqynEz78PAAi6qGkH46Q2swR
	DbN1jcib8l66zLqAy
X-Received: by 2002:a17:907:9811:b0:9dd:b624:dea9 with SMTP id ji17-20020a170907981100b009ddb624dea9mr5908955ejc.7.1699262220637;
        Mon, 06 Nov 2023 01:17:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg+Dca1Hqr/M7XD/LNddS3HhgudK6ckTsPr4vuaCXPSKcGEUtvPE7ntVOMTBjItD9G/Xyblw==
X-Received: by 2002:a17:907:9811:b0:9dd:b624:dea9 with SMTP id ji17-20020a170907981100b009ddb624dea9mr5908931ejc.7.1699262220297;
        Mon, 06 Nov 2023 01:17:00 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:91a:4014:af36:ab77:ffe6:b2fd])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b009930042510csm3902969ejs.222.2023.11.06.01.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 01:16:59 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH v2] drivers/net/ppp: use standard array-copy-function
Date: Mon,  6 Nov 2023 10:16:00 +0100
Message-ID: <20231106091559.14419-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ppp_generic.c, memdup_user() is utilized to copy a userspace array.
This is done without an overflow-check, which is, however, not critical
because the multiplicands are an unsigned short and struct sock_filter,
which is currently of size 8.

Regardless, string.h now provides memdup_array_user(), a wrapper for
copying userspace arrays in a standardized manner, which has the
advantage of making it more obvious to the reader that an array is being
copied.
The wrapper additionally performs an obligatory overflow check, saving
the reader the effort of analyzing the potential for overflow, and
making the code a bit more robust in case of future changes to the
multiplicands len * size.

Replace memdup_user() with memdup_array_user().

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
- Rename the commit and rephrase its message completely so that it
  becomes a) obvious that we're not fixing an actual overflow here and
  b) emphasize that the goal is increasing readability. (Al Viro)
---
 drivers/net/ppp/ppp_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index a9beacd552cf..0193af2d31c9 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -570,8 +570,8 @@ static struct bpf_prog *get_filter(struct sock_fprog *uprog)
 
 	/* uprog->len is unsigned short, so no overflow here */
 	fprog.len = uprog->len;
-	fprog.filter = memdup_user(uprog->filter,
-				   uprog->len * sizeof(struct sock_filter));
+	fprog.filter = memdup_array_user(uprog->filter,
+					 uprog->len, sizeof(struct sock_filter));
 	if (IS_ERR(fprog.filter))
 		return ERR_CAST(fprog.filter);
 
-- 
2.41.0


