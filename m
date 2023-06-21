Return-Path: <netdev+bounces-12496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B884C737DB4
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 10:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740682814F8
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 08:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043D8C2EF;
	Wed, 21 Jun 2023 08:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2058BF8
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:40:00 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B4A1BEE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 01:39:48 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f80cbc37c5so13720195e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 01:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687336787; x=1689928787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZrSwU7sZ+tq2ti3olTSASQ+zEZysx384vzrRtwJJcs=;
        b=JzB/qV9q1c84tk5stQIKVBggS/GOErtrJC2+2ZKThA76kVjcdC63BTeDGV0i4efN/i
         10mi15PR8HAZRlJXZ67fib0pHvnXZSwvQ0KkdjsFEaEtKe1Iwotv7GThOrskWjya8UKU
         gWjDI4qA2ag7D1VqVN7IXJA+ad45EV+fTN9fqjKriTCWHRwpCtwu6uZM8seWj6sqxAEA
         pDPr7fm6l9EstpJ81LuIn6EDmjEu3VXJ4xTdiWGQC6lyVdKNIjJr0MX7YTcopp8upMm0
         jqrIGrt4n/Egy1mFMesBofWdjPaeCxTyU3Tf23AV/HdqeZdtVxfNHJPTAzgq5J7A8Jxw
         nJPQ==
X-Gm-Message-State: AC+VfDwqy6nCaPDFEkxxUF51jFA8/eNtIc4U+HU/Dn2K7BfPLjcKXo3J
	9VXoxp72Uf5ZG+1NEe9hDdI=
X-Google-Smtp-Source: ACHHUZ6qrwp92kCV1dS0R523NqQKTRce/Eo2cdDXsy6P5snKCi5r2n3MgMycr+M5VsIEzrtE0cyfzg==
X-Received: by 2002:a1c:ed05:0:b0:3f5:927:2b35 with SMTP id l5-20020a1ced05000000b003f509272b35mr12990022wmh.1.1687336786700;
        Wed, 21 Jun 2023 01:39:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c210c00b003f9b0830107sm8036286wml.41.2023.06.21.01.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:39:46 -0700 (PDT)
Message-ID: <35f5f82c-0a25-37aa-e017-99e6739fa307@grimberg.me>
Date: Wed, 21 Jun 2023 11:39:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-5-hare@suse.de>
 <5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
 <20230620100843.19569d60@kernel.org>
 <bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> On Tue, 20 Jun 2023 16:21:22 +0300 Sagi Grimberg wrote:
>>>> +    err = tls_rx_reader_lock(sk, ctx, true);
>>>> +    if (err < 0)
>>>> +        return err;
>>>
>>> Unlike recvmsg or splice_read, the caller of read_sock is assumed to
>>> have the socket locked, and tls_rx_reader_lock also calls lock_sock,
>>> how is this not a deadlock?
>>
>> Yeah :|
>>
>>> I'm not exactly clear why the lock is needed here or what is the subtle
>>> distinction between tls_rx_reader_lock and what lock_sock provides.
>>
>> It's a bit of a workaround for the consistency of the data stream.
>> There's bunch of state in the TLS ULP and waiting for mem or data
>> releases and re-takes the socket lock. So to stop the flow annoying
>> corner case races I slapped a lock around all of the reader.
>>
>> IMHO depending on the socket lock for anything non-trivial and outside
>> of the socket itself is a bad idea in general.
>>
>> The immediate need at the time was that if you did a read() and someone
>> else did a peek() at the same time from a stream of A B C D you may read
>> A D B C.
> 
> Leaving me ever so confused.
> 
> read_sock() is a generic interface; we cannot require a protocol 
> specific lock before calling it.
> 
> What to do now?
> Drop the tls_rx_read_lock from read_sock() again?

Probably just need to synchronize the readers by splitting that from
tls_rx_reader_lock:
--
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 53f944e6d8ef..53404c3fdcc6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1845,13 +1845,10 @@ tls_read_flush_backlog(struct sock *sk, struct 
tls_prot_info *prot,
         return sk_flush_backlog(sk);
  }

-static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx 
*ctx,
-                             bool nonblock)
+static int tls_rx_reader_acquire(struct sock *sk, struct 
tls_sw_context_rx *ctx,
+                            bool nonblock)
  {
         long timeo;
-       int err;
-
-       lock_sock(sk);

         timeo = sock_rcvtimeo(sk, nonblock);

@@ -1865,26 +1862,30 @@ static int tls_rx_reader_lock(struct sock *sk, 
struct tls_sw_context_rx *ctx,
                               !READ_ONCE(ctx->reader_present), &wait);
                 remove_wait_queue(&ctx->wq, &wait);

-               if (timeo <= 0) {
-                       err = -EAGAIN;
-                       goto err_unlock;
-               }
-               if (signal_pending(current)) {
-                       err = sock_intr_errno(timeo);
-                       goto err_unlock;
-               }
+               if (timeo <= 0)
+                       return -EAGAIN;
+               if (signal_pending(current))
+                       return sock_intr_errno(timeo);
         }

         WRITE_ONCE(ctx->reader_present, 1);

         return 0;
+}

-err_unlock:
-       release_sock(sk);
+static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx 
*ctx,
+                             bool nonblock)
+{
+       int err;
+
+       lock_sock(sk);
+       err = tls_rx_reader_acquire(sk, ctx, nonblock);
+       if (err)
+               release_sock(sk);
         return err;
  }

-static void tls_rx_reader_unlock(struct sock *sk, struct 
tls_sw_context_rx *ctx)
+static void tls_rx_reader_release(struct sock *sk, struct 
tls_sw_context_rx *ctx)
  {
         if (unlikely(ctx->reader_contended)) {
                 if (wq_has_sleeper(&ctx->wq))
@@ -1896,6 +1897,11 @@ static void tls_rx_reader_unlock(struct sock *sk, 
struct tls_sw_context_rx *ctx)
         }

         WRITE_ONCE(ctx->reader_present, 0);
+}
+
+static void tls_rx_reader_unlock(struct sock *sk, struct 
tls_sw_context_rx *ctx)
+{
+       tls_rx_reader_release(sk, ctx);
         release_sock(sk);
  }
--

Then read_sock can just acquire/release.

