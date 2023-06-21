Return-Path: <netdev+bounces-12501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E14737E06
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72A51C20C61
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F32C8D9;
	Wed, 21 Jun 2023 09:08:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95CC2DE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:08:32 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C128F1996
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:08:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79A5521A52;
	Wed, 21 Jun 2023 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687338509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6q/P+JsxZ1/FMyKnygNf11cV6ffBMw7VK5hG2JsrKs=;
	b=A14eNZReUlHloZXdum4ph+Y1XuAqkkZPEZ63idPxqEzc/bZ8qABRCtCiXm4WgMGyjsMUFm
	Gjx9RbkU3n9s/bbLZ756QBPGXa7mJSC3sX775GGqCzdv/d0TS0ehcFUHzegSPgfVzVMXH6
	ZzrjqNoe/8nQvHMhxEKCIiP7dmmVv5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687338509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6q/P+JsxZ1/FMyKnygNf11cV6ffBMw7VK5hG2JsrKs=;
	b=19tSquV/X8hIcTEau2JGn3lH2ms3XDjQ9M3InaHup6Z3IJeNHFCYv/71ab0iI9+Puj5B1U
	TKulYHO5x0bsvLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56860134B1;
	Wed, 21 Jun 2023 09:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JNCYFA2+kmTpZgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 21 Jun 2023 09:08:29 +0000
Message-ID: <f8d789df-8ca7-9f9a-457d-4c87e2ca6d0a@suse.de>
Date: Wed, 21 Jun 2023 11:08:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-5-hare@suse.de>
 <5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
 <20230620100843.19569d60@kernel.org>
 <bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
 <35f5f82c-0a25-37aa-e017-99e6739fa307@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <35f5f82c-0a25-37aa-e017-99e6739fa307@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/21/23 10:39, Sagi Grimberg wrote:
> 
>>> On Tue, 20 Jun 2023 16:21:22 +0300 Sagi Grimberg wrote:
>>>>> +    err = tls_rx_reader_lock(sk, ctx, true);
>>>>> +    if (err < 0)
>>>>> +        return err;
>>>>
>>>> Unlike recvmsg or splice_read, the caller of read_sock is assumed to
>>>> have the socket locked, and tls_rx_reader_lock also calls lock_sock,
>>>> how is this not a deadlock?
>>>
>>> Yeah :|
>>>
>>>> I'm not exactly clear why the lock is needed here or what is the subtle
>>>> distinction between tls_rx_reader_lock and what lock_sock provides.
>>>
>>> It's a bit of a workaround for the consistency of the data stream.
>>> There's bunch of state in the TLS ULP and waiting for mem or data
>>> releases and re-takes the socket lock. So to stop the flow annoying
>>> corner case races I slapped a lock around all of the reader.
>>>
>>> IMHO depending on the socket lock for anything non-trivial and outside
>>> of the socket itself is a bad idea in general.
>>>
>>> The immediate need at the time was that if you did a read() and someone
>>> else did a peek() at the same time from a stream of A B C D you may read
>>> A D B C.
>>
>> Leaving me ever so confused.
>>
>> read_sock() is a generic interface; we cannot require a protocol 
>> specific lock before calling it.
>>
>> What to do now?
>> Drop the tls_rx_read_lock from read_sock() again?
> 
> Probably just need to synchronize the readers by splitting that from
> tls_rx_reader_lock:
> -- 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 53f944e6d8ef..53404c3fdcc6 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1845,13 +1845,10 @@ tls_read_flush_backlog(struct sock *sk, struct 
> tls_prot_info *prot,
>          return sk_flush_backlog(sk);
>   }
> 
> -static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx 
> *ctx,
> -                             bool nonblock)
> +static int tls_rx_reader_acquire(struct sock *sk, struct 
> tls_sw_context_rx *ctx,
> +                            bool nonblock)
>   {
>          long timeo;
> -       int err;
> -
> -       lock_sock(sk);
> 
>          timeo = sock_rcvtimeo(sk, nonblock);
> 
> @@ -1865,26 +1862,30 @@ static int tls_rx_reader_lock(struct sock *sk, 
> struct tls_sw_context_rx *ctx,
>                                !READ_ONCE(ctx->reader_present), &wait);
>                  remove_wait_queue(&ctx->wq, &wait);
> 
> -               if (timeo <= 0) {
> -                       err = -EAGAIN;
> -                       goto err_unlock;
> -               }
> -               if (signal_pending(current)) {
> -                       err = sock_intr_errno(timeo);
> -                       goto err_unlock;
> -               }
> +               if (timeo <= 0)
> +                       return -EAGAIN;
> +               if (signal_pending(current))
> +                       return sock_intr_errno(timeo);
>          }
> 
>          WRITE_ONCE(ctx->reader_present, 1);
> 
>          return 0;
> +}
> 
> -err_unlock:
> -       release_sock(sk);
> +static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx 
> *ctx,
> +                             bool nonblock)
> +{
> +       int err;
> +
> +       lock_sock(sk);
> +       err = tls_rx_reader_acquire(sk, ctx, nonblock);
> +       if (err)
> +               release_sock(sk);
>          return err;
>   }
> 
> -static void tls_rx_reader_unlock(struct sock *sk, struct 
> tls_sw_context_rx *ctx)
> +static void tls_rx_reader_release(struct sock *sk, struct 
> tls_sw_context_rx *ctx)
>   {
>          if (unlikely(ctx->reader_contended)) {
>                  if (wq_has_sleeper(&ctx->wq))
> @@ -1896,6 +1897,11 @@ static void tls_rx_reader_unlock(struct sock *sk, 
> struct tls_sw_context_rx *ctx)
>          }
> 
>          WRITE_ONCE(ctx->reader_present, 0);
> +}
> +
> +static void tls_rx_reader_unlock(struct sock *sk, struct 
> tls_sw_context_rx *ctx)
> +{
> +       tls_rx_reader_release(sk, ctx);
>          release_sock(sk);
>   }
> -- 
> 
> Then read_sock can just acquire/release.

Good suggestion.
Will be including it in the next round.

Cheers,

Hannes


