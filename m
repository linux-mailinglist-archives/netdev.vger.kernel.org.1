Return-Path: <netdev+bounces-45802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DED17DFACC
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 20:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1781C20EB9
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1580A2135D;
	Thu,  2 Nov 2023 19:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vhva4KTk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775021358
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 19:19:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C29185
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698952769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VH/N2+u/BX61pZEFnFU4abdjTRFxE7atZBHYbezDKHQ=;
	b=Vhva4KTkpA0DZA+QYn4Huiv8TbDsZRogH7ulMW9S5BCIFkDFUAo9eBON/hrSj2HvikXXU2
	Gs+mooYwendhU0CvCO+jhe9l75f9Dk0p1ABcZFpnJvMfbSchd5dMSCbKa1rOi9aNp1dxlS
	gWHZhsn1unrtBssJOMtstUjy4RYGZVg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-OI_OWfXEM6ankgdpovmXhA-1; Thu, 02 Nov 2023 15:19:28 -0400
X-MC-Unique: OI_OWfXEM6ankgdpovmXhA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4083a0fb583so1476525e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 12:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952766; x=1699557566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VH/N2+u/BX61pZEFnFU4abdjTRFxE7atZBHYbezDKHQ=;
        b=KkrQh6vlddPEkp9k97OTK6r23J+7/XON7SE8e9VV9IJkTVA6X7o85Z9ke7Gi0wgAJF
         xQ9IlxN2gzD2BjYgpaRXS7hmKOixD2dzr+5grwFPizAgFYwkiXXepPEmJG7XFwqIrj1Y
         hEteui8WIxguf8cuaBsvHIDYe5mxT2N7Yi3L5UW5I2XuVbTL7zFDcU/eiDAVzcjZI09V
         nsbxK9BVatSMz+dc+eir5aHKhMwRy/jnnrgtx1qTcmE/mIQWSlDiny9eRk2VMZRctIqw
         HxkxUBE6diMykYVlwnRMzWq+OXQdC32kiFmdwI0sEUc3oARWctHTovFlyNXB/B9/3CYZ
         K01Q==
X-Gm-Message-State: AOJu0Yxj7Io8SxIAq+4E/K0Dibi21O9LvqmB9wIr3Qof0HiF40vJTJpM
	c0c/KHzEF1pCocdJoB40rlWyE+NeHXSRb633Fdgjb/mNhq7bpqkMp/UTo64YAZrKgHQAvyOVFYm
	UCL12mLnoXM9kRz8o
X-Received: by 2002:a05:600c:510a:b0:405:1ba2:4fcf with SMTP id o10-20020a05600c510a00b004051ba24fcfmr15749005wms.4.1698952766737;
        Thu, 02 Nov 2023 12:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7wSu4OKWotI05EoNGVSlLHC3iEji5MIz+S+leIFdg+jMKK6E/oGxssjELhigZ3tCQW+7N6g==
X-Received: by 2002:a05:600c:510a:b0:405:1ba2:4fcf with SMTP id o10-20020a05600c510a00b004051ba24fcfmr15748984wms.4.1698952766361;
        Thu, 02 Nov 2023 12:19:26 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d4a43000000b003232380ffd7sm86618wrs.102.2023.11.02.12.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:19:25 -0700 (PDT)
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
Subject: [PATCH] drivers/net/ppp: copy userspace array safely
Date: Thu,  2 Nov 2023 20:19:15 +0100
Message-ID: <20231102191914.52957-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ppp_generic.c memdup_user() is utilized to copy a userspace array.
This is done without an overflow check.

Use the new wrapper memdup_array_user() to copy the array more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
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


