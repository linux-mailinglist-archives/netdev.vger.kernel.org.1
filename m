Return-Path: <netdev+bounces-15401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669C2747590
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C15E280E59
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6646AB0;
	Tue,  4 Jul 2023 15:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323296AA9
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:47:29 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF004E75;
	Tue,  4 Jul 2023 08:47:27 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so57305555e9.1;
        Tue, 04 Jul 2023 08:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485646; x=1691077646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HIfHcKKD5QjLIcE3qmatua7Jxdz84IacUW1Fq893M0=;
        b=XH4UXcwWMXuvBZEQ/92ybkSaZg4r4TPc2BDGVnIJwMN+L/mRIHPEiyONOe4aZ9iect
         PwephRgpnb0QMVc6ehhhwkEq4CkbLeBH5iv9G/3w5SKPJ+mdhgLx1KD8Yd1/XaNNLY/0
         OcCwKQlp7fxWty0EZ3nddoRqHcxkteJImRReub+QqiuX0pOwHK+GgQVfJBopcTaKhQET
         C27fqftEuFkdDQXlJcIeopZ2yIJvFDnBmSLUZakSVLIxVyQMQu2gsgdIqh3tx59p7y5F
         SQNPqRFxXR0KQEVfE4+ymN+PbSZNHvGEOsM2W+KM5USus0dvRBlc3bdJGiY9mJYihRFb
         +KsQ==
X-Gm-Message-State: AC+VfDx6z+m2LrLkDk7aFFKv2roAaUAJOIF5f2M4PEZJXhOsJoHxFFa/
	z1gA86s2scMGQm/huAlBx9IoMVEdPquSWQ==
X-Google-Smtp-Source: ACHHUZ7T5Y/PzaRv1u1C93os7Js2UEOP4LsEvjq1YdK2LO3nX+USNiNH/2D1fHzvMF49bFYz0UqyyQ==
X-Received: by 2002:a7b:c393:0:b0:3fb:403d:90c0 with SMTP id s19-20020a7bc393000000b003fb403d90c0mr10024445wmj.39.1688485645944;
        Tue, 04 Jul 2023 08:47:25 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-008.fbsv.net. [2a03:2880:31ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id l4-20020adfe9c4000000b0031435c2600esm6591763wrn.79.2023.07.04.08.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:47:25 -0700 (PDT)
Date: Tue, 4 Jul 2023 08:47:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	sergey.senozhatsky@gmail.com, pmladek@suse.com, tj@kernel.or,
	Dave Jones <davej@codemonkey.org.uk>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <ZKQ/C7z2RMG5a4XN@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
 <20230703124427.228f7a9e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703124427.228f7a9e@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 12:44:27PM -0700, Jakub Kicinski wrote:
> On Mon,  3 Jul 2023 08:41:54 -0700 leitao@debian.org wrote:
> > +	uname = init_utsname()->release;
> > +
> > +	newmsg = kasprintf(GFP_KERNEL, "%s;%s", uname, msg);
> > +	if (!newmsg)
> > +		/* In case of ENOMEM, just ignore this entry */
> > +		return;
> > +	newlen = strlen(uname) + len + 1;
> > +
> > +	send_ext_msg_udp(nt, newmsg, newlen);
> > +
> > +	kfree(newmsg);
> 
> You can avoid the memory allocation by putting this code into
> send_ext_msg_udp(), I reckon? There's already a buffer there.

This is doable as well, basically appending "uname" at the beginning of
the buffer, copying the rest of the message to the buffer and sending
the buffer to netpoll.

If the message needs fragmentation, basically keep "uname" as part of
the header, and the new header length (this_header) will be "header_len
+ uname_len"

This is the code that does it. How does it sound?

--

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4f4f79532c6c..d26bd3b785c4 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -36,6 +36,7 @@
 #include <linux/inet.h>
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
+#include <linux/utsname.h>
 
 MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
@@ -772,8 +773,10 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	const char *header, *body;
 	int offset = 0;
 	int header_len, body_len;
+	int uname_len = 0;
 
-	if (msg_len <= MAX_PRINT_CHUNK) {
+	if (msg_len <= MAX_PRINT_CHUNK &&
+	    !IS_ENABLED(CONFIG_NETCONSOLE_UNAME)) {
 		netpoll_send_udp(&nt->np, msg, msg_len);
 		return;
 	}
@@ -788,14 +791,31 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	body_len = msg_len - header_len - 1;
 	body++;
 
+	if (IS_ENABLED(CONFIG_NETCONSOLE_UNAME)) {
+		/* Add uname at the beginning of buffer */
+		char *uname = init_utsname()->release;
+		/* uname_len contains the length of uname + ',' */
+		uname_len = strlen(uname) + 1;
+
+		if (uname_len + msg_len < MAX_PRINT_CHUNK) {
+			/* No fragmentation needed */
+			scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", uname, msg);
+			netpoll_send_udp(&nt->np, buf, uname_len + msg_len);
+			return;
+		}
+
+		/* The data will be fragment, prepending uname */
+		scnprintf(buf, MAX_PRINT_CHUNK, "%s,", uname);
+	}
+
 	/*
 	 * Transfer multiple chunks with the following extra header.
 	 * "ncfrag=<byte-offset>/<total-bytes>"
 	 */
-	memcpy(buf, header, header_len);
+	memcpy(buf + uname_len, header, header_len);
 
 	while (offset < body_len) {
-		int this_header = header_len;
+		int this_header = header_len + uname_len;
 		int this_chunk;
 
 		this_header += scnprintf(buf + this_header,
-- 
2.34.1


