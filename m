Return-Path: <netdev+bounces-16735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8197A74E96A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595E11C20C67
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6771F174DD;
	Tue, 11 Jul 2023 08:52:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587445246
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 08:52:38 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553AE6F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 01:52:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3159d5e409dso1083727f8f.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689065553; x=1691657553;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqBcFsm4VvCi5EZywoq+U276RpO9NYFsz2Y5f42xGjY=;
        b=FUOCf9WcfNVUm7BtEOKdPaOLicH9qh1ARWma3aXixAtDBWnMsaVLVKfIoF87hxq4rR
         hQnviV4I4qowdfrsxQ6DJyAz9d0EiCfX3W4AFeXnI5ek8grtOW+FYO4AecCqEaIHyHPQ
         euP4jsxA2DT+PQt+OIHGFVwxucdUNon7sSnJLAUMSepUP2i9w7I2kUPeQipCpAL6pGpS
         eXkC3vav6JnBrJHL6ssaaWG0OpYhcbvu3iSg8AamN+8hzJtIjIwIOe8htoeBQ9pfj7wc
         k4nvebqf0CCPBLz6+sH+OjddMVVPruhN7iTTa6s86EC0Lq9IHh8WnlScYwtcwtvsUdwh
         Gkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689065553; x=1691657553;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqBcFsm4VvCi5EZywoq+U276RpO9NYFsz2Y5f42xGjY=;
        b=gil/u8hPLyKcKFG86hQPZ4LutEJcJ0Ujd/Z6Y3tBXgAD4QoOJmUKQeqqJNGwqXMUew
         JYVK5oGsxs9bm8rSlWLv929Aj/mHHhIY0HwWPogaAHOFyWB5c0j8Noy+GP89ajBdpbn4
         qPmMGYICgjZpVP1LB6yE8fEdf0ePgKBHB8oip/BBUwh9lXFjLebv4WuTfnhBDd/Neqob
         zmQ2jGDj5sfagseiFIGVfJXKM7LnfY8jXvQlUOQ+3EGqhO9lnRqXqPKE/0G1vNYxg/ph
         Z+eqISnwfw5gIUi7XaDKGyWmx8QyMXsFAEoocWwveK+mFmemXc+z69e4uRcKPUvM1XhT
         jZbg==
X-Gm-Message-State: ABy/qLYjiRPl9IkLj9UPo8ic+qmLbLdwNw2eNIxIb4eYH/ed9eFH+ejM
	T83o6XxEpDTIxR+K+JfGSlhCrQ==
X-Google-Smtp-Source: APBJJlGSShkRRFeH3WyQvNfSN+5bRph1U8HSLs/9Sc8Xf9i/vPSkWHCW59E3FMwo8/UOe2Se1+IG8A==
X-Received: by 2002:a5d:5182:0:b0:314:2d59:c6d5 with SMTP id k2-20020a5d5182000000b003142d59c6d5mr17588385wrv.15.1689065553040;
        Tue, 11 Jul 2023 01:52:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q10-20020adfdfca000000b003144b95e1ecsm1619492wrn.93.2023.07.11.01.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 01:52:31 -0700 (PDT)
Date: Tue, 11 Jul 2023 11:52:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] devlink: uninitialized data in
 nsim_dev_trap_fa_cookie_write()
Message-ID: <7c1f950b-3a7d-4252-82a6-876e53078ef7@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The simple_write_to_buffer() function is designed to handle partial
writes.  It returns negatives on error, otherwise it returns the number
of bytes that were able to be copied.  This code doesn't check the
return properly.  We only know that the first byte is written, the rest
of the buffer might be uninitialized.

There is no need to use the simple_write_to_buffer() function.
Partial writes are prohibited by the "if (*ppos != 0)" check at the
start of the function.  Just use memdup_user() and copy the whole
buffer.

Fixes: d3cbb907ae57 ("netdevsim: add ACL trap reporting cookie as a metadata")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/netdevsim/dev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 6045bece2654..b4d3b9cde8bd 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -184,13 +184,10 @@ static ssize_t nsim_dev_trap_fa_cookie_write(struct file *file,
 	cookie_len = (count - 1) / 2;
 	if ((count - 1) % 2)
 		return -EINVAL;
-	buf = kmalloc(count, GFP_KERNEL | __GFP_NOWARN);
-	if (!buf)
-		return -ENOMEM;
 
-	ret = simple_write_to_buffer(buf, count, ppos, data, count);
-	if (ret < 0)
-		goto free_buf;
+	buf = memdup_user(data, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	fa_cookie = kmalloc(sizeof(*fa_cookie) + cookie_len,
 			    GFP_KERNEL | __GFP_NOWARN);
-- 
2.39.2


