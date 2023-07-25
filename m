Return-Path: <netdev+bounces-20898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9BD761D7C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541F91C20F0B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1733823BE4;
	Tue, 25 Jul 2023 15:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C451F173
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 15:40:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05181FD3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690299608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DtjuQEYBysLf5IPBPQqG0dtkZp2a3tmx6LZMEFCT4Do=;
	b=A1ci2n3NJ942VeOflzhPUyRN05uN7KPYCbPu/I2/ew62vwZRS3PiyNBQqoGYuXSPW0fGAa
	az+Cl++nq1HapAXVyYapV7pJ/qL9Y4aHXeE4k3XqJF01SbgTvZO+Ef129HZ2CvLjXrLRHD
	HRjI2+OEN/5lbffEq9apNRZXbdmu1oQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-M8mQtMwAO06LQ4PwjfTXvQ-1; Tue, 25 Jul 2023 11:40:06 -0400
X-MC-Unique: M8mQtMwAO06LQ4PwjfTXvQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76839756ba4so801222785a.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299606; x=1690904406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtjuQEYBysLf5IPBPQqG0dtkZp2a3tmx6LZMEFCT4Do=;
        b=KmYmCIWahw06PyPxZ/6gKtSTqH8Oxb5mTJ3hb/iUYFwSEOmk2AI+stGiMne05TEkES
         Yb7GEylcnCwozz3ePHvU2UNqeCtY/kg4EdRtZAP1xub+cKsytHboKaiJKt/ZxzVyqClD
         OJPTYj5BfM3dSxOmOQgbKI2wE9q8BHsbz3huw/xTXBuSgUU52+FrjIHUzvEaGUmtFe2U
         7hYkxCqtJhw/VC3YHziY6eY3cJheaBWiNUP5xEJRfadmqnQlN+vIX04NP8T3Bguzya3s
         yt1+QDu6ndb1hWF0+YZ6ICwqtDsPPmNxN5PWDa32U1UFu/Qb0HpXCgBOk+2Iz+UjYe29
         JkcA==
X-Gm-Message-State: ABy/qLZ+CC2/2X5MoeiojShBRv5a6VpeHMcyxT2rZfMSyy0wAD+fCI0A
	cgCktMgOkkQSK2TGiucRWuOfG0h7H/4zgu8wx83CjOfxFh0qvIghXlCLHT3TXqAwmoqS0hc6bQ8
	jxnHcUoB4Hc/AutYk
X-Received: by 2002:a05:620a:218b:b0:767:dd72:68a0 with SMTP id g11-20020a05620a218b00b00767dd7268a0mr3217544qka.73.1690299605986;
        Tue, 25 Jul 2023 08:40:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZVy88xuYM5gaAVvj+fpdBp2vTTrdGeiv4z5i5xWjqyut/xez/YNHtY8x0EI0HNIa8YER6+w==
X-Received: by 2002:a05:620a:218b:b0:767:dd72:68a0 with SMTP id g11-20020a05620a218b00b00767dd7268a0mr3217536qka.73.1690299605744;
        Tue, 25 Jul 2023 08:40:05 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.153.113])
        by smtp.gmail.com with ESMTPSA id 4-20020a05620a06c400b00765a676b75csm3751894qky.21.2023.07.25.08.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:40:05 -0700 (PDT)
Date: Tue, 25 Jul 2023 17:39:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 3/4] vsock/test: rework MSG_PEEK test for
 SOCK_STREAM
Message-ID: <fefl2wuphc73qm26n62mhs3x5qrbirfd5334u3xeblpghgkdq5@h4a2t4nljyoi>
References: <20230719192708.1775162-1-AVKrasnov@sberdevices.ru>
 <20230719192708.1775162-4-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230719192708.1775162-4-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 10:27:07PM +0300, Arseniy Krasnov wrote:
>This new version makes test more complicated by adding empty read,
>partial read and data comparisons between MSG_PEEK and normal reads.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 78 ++++++++++++++++++++++++++++++--
> 1 file changed, 75 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index ac1bd3ac1533..444a3ff0681f 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -255,9 +255,14 @@ static void test_stream_multiconn_server(const struct test_opts *opts)
> 		close(fds[i]);
> }
>
>+#define MSG_PEEK_BUF_LEN 64
>+
> static void test_stream_msg_peek_client(const struct test_opts *opts)
> {
>+	unsigned char buf[MSG_PEEK_BUF_LEN];
>+	ssize_t send_size;
> 	int fd;
>+	int i;
>
> 	fd = vsock_stream_connect(opts->peer_cid, 1234);
> 	if (fd < 0) {
>@@ -265,12 +270,32 @@ static void test_stream_msg_peek_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	send_byte(fd, 1, 0);
>+	for (i = 0; i < sizeof(buf); i++)
>+		buf[i] = rand() & 0xFF;
>+
>+	control_expectln("SRVREADY");
>+
>+	send_size = send(fd, buf, sizeof(buf), 0);
>+
>+	if (send_size < 0) {
>+		perror("send");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (send_size != sizeof(buf)) {
>+		fprintf(stderr, "Invalid send size %zi\n", send_size);
>+		exit(EXIT_FAILURE);
>+	}
>+
> 	close(fd);
> }
>
> static void test_stream_msg_peek_server(const struct test_opts *opts)
> {
>+	unsigned char buf_half[MSG_PEEK_BUF_LEN / 2];
>+	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
>+	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
>+	ssize_t res;
> 	int fd;
>
> 	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>@@ -279,8 +304,55 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	recv_byte(fd, 1, MSG_PEEK);
>-	recv_byte(fd, 1, 0);
>+	/* Peek from empty socket. */
>+	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK | MSG_DONTWAIT);
>+	if (res != -1) {
>+		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (errno != EAGAIN) {
>+		perror("EAGAIN expected");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SRVREADY");
>+
>+	/* Peek part of data. */
>+	res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK);
>+	if (res != sizeof(buf_half)) {
>+		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
>+			sizeof(buf_half), res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Peek whole data. */
>+	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK);
>+	if (res != sizeof(buf_peek)) {
>+		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
>+			sizeof(buf_peek), res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Compare partial and full peek. */
>+	if (memcmp(buf_half, buf_peek, sizeof(buf_half))) {
>+		fprintf(stderr, "Partial peek data mismatch\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	res = recv(fd, buf_normal, sizeof(buf_normal), 0);
>+	if (res != sizeof(buf_normal)) {
>+		fprintf(stderr, "recv(2), expected %zu, got %zi\n",
>+			sizeof(buf_normal), res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Compare full peek and normal read. */
>+	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek))) {
>+		fprintf(stderr, "Full peek data mismatch\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
> 	close(fd);
> }
>
>-- 
>2.25.1
>


