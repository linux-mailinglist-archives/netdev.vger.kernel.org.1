Return-Path: <netdev+bounces-46178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CAE7E1ECD
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 11:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FAD280F49
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438A17751;
	Mon,  6 Nov 2023 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItgE/Sfm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB4156D4
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 10:47:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF05DA1
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 02:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699267665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lT38C9wjUtWACQaL07OufNUHAmzWCa7yzF7D6wde9Q=;
	b=ItgE/SfmjgCIbCvtU/vITrSQtWOS7bFdFnft2NszDS1KxYY5SgRvzy02H6MLERNa3xyx3o
	yjDw14wk1e2g+Kds12/bR2NfEwFstA9ThU7syHDY4UHo1Mo3KzlaAlnAw9MAJmzeATePl9
	05s2voa5pIa1eBLktN+IyTDulEHoMOg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-LS75SO1VP8CvDmJo4f6CHg-1; Mon, 06 Nov 2023 05:47:43 -0500
X-MC-Unique: LS75SO1VP8CvDmJo4f6CHg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41cdc542b56so51079821cf.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 02:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267663; x=1699872463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lT38C9wjUtWACQaL07OufNUHAmzWCa7yzF7D6wde9Q=;
        b=qeB6hC4b90Es3xvBlQdAQqe2F/wPlgEcnLHosAfRJ2EXwRjMO/J2YuAgXSZWRlaP1w
         fjX9CHZ8J2sENLS+hfhMxZIbdE+jGW/SCN2+Frsd3lzGf4Q40cYic/VJ0q2oxchIr9vD
         i3uuo5Ir9UpaoC6nyHA6noFVPDd64kWWgPzo0HK3v2KKvRUucknRajBgdIkKyU7zXAUa
         mNiVvx9i9RRudF1drAR/ovY/0iLgTWo5utX7VRgGdggx2r8Vx5mmgjLxfgxnIQ6zD+B7
         1XoQyPiprV7re9TEIJ9Vklz6MBQNHRWZ/fo0Obvptx79mw6HDcOOQHDlhpva4VwKIG/R
         Usxw==
X-Gm-Message-State: AOJu0YzMXk+c8SXfDr217RIuqksfUVc15exhlcKECOJ8ctBO9y3EeWZC
	pSK7pSfTwOvoGk3NOuaILQb2sHyrMH0ItOQ6Q2GFrjJ4nwuVkEn1TUksuVOGjHgQs6yJF4Med/N
	j799sE+FVuPwkyq4A
X-Received: by 2002:ac8:58c9:0:b0:3fd:dab5:9430 with SMTP id u9-20020ac858c9000000b003fddab59430mr34239776qta.16.1699267663090;
        Mon, 06 Nov 2023 02:47:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjH5tsrv9EosQgCdf+Wk5X4APcmLon+ih9JbEw8zpkDnU51uS7si0Atvpc7KZve/mxRma74g==
X-Received: by 2002:ac8:58c9:0:b0:3fd:dab5:9430 with SMTP id u9-20020ac858c9000000b003fddab59430mr34239760qta.16.1699267662799;
        Mon, 06 Nov 2023 02:47:42 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
        by smtp.gmail.com with ESMTPSA id b10-20020ac8678a000000b00410a9dd3d88sm3253917qtp.68.2023.11.06.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:47:42 -0800 (PST)
Date: Mon, 6 Nov 2023 11:47:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: f.storniolo95@gmail.com
Cc: luigi.leonardi@outlook.com, kvm@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, mst@redhat.com, imbrenda@linux.vnet.ibm.com, kuba@kernel.org, 
	asias@redhat.com, stefanha@redhat.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net 3/4] test/vsock: refactor vsock_accept
Message-ID: <l2ng7ukyxj5ykzznogyescuufalhfvx2cvrykpht6gqyjrfoy3@ib6dag5o2qik>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
 <20231103175551.41025-4-f.storniolo95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231103175551.41025-4-f.storniolo95@gmail.com>

On Fri, Nov 03, 2023 at 06:55:50PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>This is a preliminary patch to introduce SOCK_STREAM bind connect test.
>vsock_accept() is split into vsock_listen() and vsock_accept().
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
>---
> tools/testing/vsock/util.c | 32 ++++++++++++++++++++------------
> 1 file changed, 20 insertions(+), 12 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 698b0b44a2ee..2fc96f29bdf2 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -136,11 +136,8 @@ int vsock_seqpacket_connect(unsigned int cid, unsigned int port)
> 	return vsock_connect(cid, port, SOCK_SEQPACKET);
> }
>
>-/* Listen on <cid, port> and return the first incoming connection.  The remote
>- * address is stored to clientaddrp.  clientaddrp may be NULL.
>- */
>-static int vsock_accept(unsigned int cid, unsigned int port,
>-			struct sockaddr_vm *clientaddrp, int type)
>+/* Listen on <cid, port> and return the file descriptor. */
>+static int vsock_listen(unsigned int cid, unsigned int port, int type)
> {
> 	union {
> 		struct sockaddr sa;
>@@ -152,14 +149,7 @@ static int vsock_accept(unsigned int cid, unsigned int port,
> 			.svm_cid = cid,
> 		},
> 	};
>-	union {
>-		struct sockaddr sa;
>-		struct sockaddr_vm svm;
>-	} clientaddr;
>-	socklen_t clientaddr_len = sizeof(clientaddr.svm);
> 	int fd;
>-	int client_fd;
>-	int old_errno;
>
> 	fd = socket(AF_VSOCK, type, 0);
> 	if (fd < 0) {
>@@ -177,6 +167,24 @@ static int vsock_accept(unsigned int cid, unsigned int port,
> 		exit(EXIT_FAILURE);
> 	}
>
>+	return fd;
>+}
>+
>+/* Listen on <cid, port> and return the first incoming connection.  The remote
>+ * address is stored to clientaddrp.  clientaddrp may be NULL.
>+ */
>+static int vsock_accept(unsigned int cid, unsigned int port,
>+			struct sockaddr_vm *clientaddrp, int type)
>+{
>+	union {
>+		struct sockaddr sa;
>+		struct sockaddr_vm svm;
>+	} clientaddr;
>+	socklen_t clientaddr_len = sizeof(clientaddr.svm);
>+	int fd, client_fd, old_errno;
>+
>+	fd = vsock_listen(cid, port, type);
>+
> 	control_writeln("LISTENING");
>
> 	timeout_begin(TIMEOUT);
>-- 
>2.41.0
>


