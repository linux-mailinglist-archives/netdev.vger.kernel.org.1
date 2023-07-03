Return-Path: <netdev+bounces-15137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3F745E02
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15EA280C41
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEEFF9E8;
	Mon,  3 Jul 2023 13:57:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBEDDC5
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 13:57:31 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69EFE52
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 06:57:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 720521FE8C;
	Mon,  3 Jul 2023 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688392649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/Tt9Elti8dh7KReBG2dWJCnACGgY/MFt4BEh7pqFN8=;
	b=FvRbftZUhPNOdiJ4/B1A02p2nJrJoKszbLx2jEs1U+WWBgvMUArJJMZ/yotasU8cGg1hfc
	RBTsGCtLJu6OUT5PqV0kIiqiWcI7uYiPc7B+Y7lqboKX04Vxcr+LA/HMvRzEnw1QYS1ITW
	HdJjn2yiZA8Sr9PW7iiYmyM4lfAXINI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688392649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/Tt9Elti8dh7KReBG2dWJCnACGgY/MFt4BEh7pqFN8=;
	b=V9PnarmzXmCa+iDukSlMLZz4uXpS/wlF1lR9moGQ/hKj8FbVqIzkn0jqu8jHwGVMYsepFr
	g1eRD1n+3cRtudDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53E4113276;
	Mon,  3 Jul 2023 13:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 71UEFMnTomS1LAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 13:57:29 +0000
Message-ID: <0ceb62b7-c310-cc4a-6b90-651e6b0c09ae@suse.de>
Date: Mon, 3 Jul 2023 15:57:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
 <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
 <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
 <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/3/23 15:42, Sagi Grimberg wrote:
> 
>>>> Hannes Reinecke <hare@suse.de> wrote:
>>>>
>>>>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>>>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>>>>> sock_sendmsg() as it's trying to access invalid pages :-(
>>>>
>>>> Can you be more specific about the crash?
>>>
>>> Hannes,
>>>
>>> See:
>>> [PATCH net] nvme-tcp: Fix comma-related oops
>>
>> Ah, right. That solves _that_ issue.
>>
>> But now I'm deadlocking on the tls_rx_reader_lock() (patched as to 
>> your suggestion). Investigating.
> 
> Are you sure it is a deadlock? or maybe you returned EAGAIN and nvme-tcp
> does not interpret this as a transient status and simply returns from
> io_work?
> 
Unfortunately, yes.

static int tls_rx_reader_acquire(struct sock *sk, struct 
tls_sw_context_rx *ctx,
                                  bool nonblock)
{
         long timeo;

         timeo = sock_rcvtimeo(sk, nonblock);

         while (unlikely(ctx->reader_present)) {
                 DEFINE_WAIT_FUNC(wait, woken_wake_function);

                 ctx->reader_contended = 1;

                 add_wait_queue(&ctx->wq, &wait);
                 sk_wait_event(sk, &timeo,
                               !READ_ONCE(ctx->reader_present), &wait);

and sk_wait_event() does:
#define sk_wait_event(__sk, __timeo, __condition, __wait)              \
         ({      int __rc;                                              \
                 __sk->sk_wait_pending++;                               \
                 release_sock(__sk);                                    \
                 __rc = __condition;                                    \
                 if (!__rc) {                                           \
                         *(__timeo) = wait_woken(__wait,                \
                                                 TASK_INTERRUPTIBLE,    \
                                                 *(__timeo));           \
                 }                                                      \
                 sched_annotate_sleep();                                \
                 lock_sock(__sk);                                       \
                 __sk->sk_wait_pending--;                               \
                 __rc = __condition;                                    \
                 __rc;                                                  \
         })

so not calling 'lock_sock()' in tls_tx_reader_acquire() helps only _so_ 
much, we're still deadlocking.

Cheers,

Hannes


