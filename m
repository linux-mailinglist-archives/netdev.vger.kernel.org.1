Return-Path: <netdev+bounces-26947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92834779922
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 23:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D027280A85
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 21:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C453329A6;
	Fri, 11 Aug 2023 21:03:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3B13AC7
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 21:03:00 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428BAE75
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 14:02:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3178fa77b27so2002351f8f.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1691787775; x=1692392575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Icd1RHvUtr1iso/nHvhzqTbNVpgZmMmJXYphHgjqgjE=;
        b=kk9QEhj5jeKZnh79pfcwTNUp+RIR3eMYfjeA0BhVPsEV+GLd7A8sbkVXEOBOZrn6kY
         8wUeJ65YBPnLcS6bhg4xgfcMQC+kdkNOTAgRM0l2JBGeXJhdzqsKvq8IrKN0qc9PObuB
         9KWqew/dxe+XtVH4QJwntEP97A9F3tVQgRLzy4ZfCiSXQgx2Ci/aNlu9qBpXzyBwqVrm
         RSykWmNqSM/yg0dFnRgdys+ESGuDjv1Sadj6TMg6vK3+yvZ/8egB1emBVWoRkB6B+3op
         PdEOuSnIaIHBcjOhFFJ2lLKmm87Zj4EEBK+pfyKgEiOjT3ETW1p7JFhzuBAPm9+VLjFW
         A7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691787775; x=1692392575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Icd1RHvUtr1iso/nHvhzqTbNVpgZmMmJXYphHgjqgjE=;
        b=PUHpou7mhyCAsD2yCYnKI7M2T36+TVpZXGGJL2u8obvGLT3e2d8mri5KoEGpBLuwKg
         /x2CkO7tgE8FdNqk0yZSWrQvbO3Jr99zBuEYbDzuccq7UsKUrIAFSFoGY2AQWRElNCR7
         2Sppx9K/JHG2HbKkbdrRDOm1guKZNU46dWp5oim+kQrovhcYvry2cIyej/6L/Zq4enLY
         SCN49mMNE7NGrMwx+TqbR+0tgLfLI+ZLyWTAw0i/GofGXt7hwtMJRqL36yuGXslMVsOF
         yKVGMS8nzJ9jEiO6FFaqyqh6CIsMXUdwRPTmrmK0KQCKXJ86frGzCKLjnUWOAaikdV7D
         jyGw==
X-Gm-Message-State: AOJu0YwrJPIgS5KjZXb2ACVm148XoEqme2VuZO48bBHBSOAhcKXGL6ms
	WyBxc4WtRPDavjvyL+RpVDSz9A==
X-Google-Smtp-Source: AGHT+IG9n7lW4JjAdrJwP+9knTso6Xk1X1MCzd6/Q5vLVKQZWQe7lJAKE/ZlzY+xkiUC33s41hRjPw==
X-Received: by 2002:adf:e2d1:0:b0:317:7af4:5297 with SMTP id d17-20020adfe2d1000000b003177af45297mr2028177wrj.62.1691787774660;
        Fri, 11 Aug 2023 14:02:54 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v1-20020adff681000000b00313e2abfb8dsm6479390wrp.92.2023.08.11.14.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:02:54 -0700 (PDT)
Message-ID: <937d4a14-050a-56f1-8af9-2c7acdd5ae86@arista.com>
Date: Fri, 11 Aug 2023 22:02:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 net-next 01/23] net/tcp: Prepare tcp_md5sig_pool for
 TCP-AO
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Ard Biesheuvel <ardb@kernel.org>, Bob Gilligan <gilligan@arista.com>,
 Dan Carpenter <error27@gmail.com>, David Laight <David.Laight@aculab.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Donald Cassidy <dcassidy@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>,
 "Gaillardetz, Dominik" <dgaillar@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Ivan Delalande <colona@arista.com>, Leonard Crestez <cdleonard@gmail.com>,
 Salam Noureddine <noureddine@arista.com>,
 "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
 Steen Hegelund <Steen.Hegelund@microchip.com>
References: <20230802172654.1467777-1-dima@arista.com>
 <20230802172654.1467777-2-dima@arista.com>
 <CANn89iKJBgYF7_Yu_wrw02+a4yj2Xw6wvd4JxMbDKwJu9cPxBQ@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iKJBgYF7_Yu_wrw02+a4yj2Xw6wvd4JxMbDKwJu9cPxBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

On 8/8/23 10:58, Eric Dumazet wrote:
> On Wed, Aug 2, 2023 at 7:27 PM Dmitry Safonov <dima@arista.com> wrote:
[..]
>> -       hash = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
>> -       if (IS_ERR(hash))
>> -               return;
>> -
>> -       for_each_possible_cpu(cpu) {
>> -               void *scratch = per_cpu(tcp_md5sig_pool, cpu).scratch;
>> -               struct ahash_request *req;
>> -
>> -               if (!scratch) {
>> -                       scratch = kmalloc_node(sizeof(union tcp_md5sum_block) +
>> -                                              sizeof(struct tcphdr),
>> -                                              GFP_KERNEL,
>> -                                              cpu_to_node(cpu));
>> -                       if (!scratch)
>> -                               return;
>> -                       per_cpu(tcp_md5sig_pool, cpu).scratch = scratch;
>> -               }
>> -               if (per_cpu(tcp_md5sig_pool, cpu).md5_req)
>> -                       continue;
>> -
>> -               req = ahash_request_alloc(hash, GFP_KERNEL);
>> -               if (!req)
>> -                       return;
>> -
>> -               ahash_request_set_callback(req, 0, NULL, NULL);
>> -
>> -               per_cpu(tcp_md5sig_pool, cpu).md5_req = req;
>> +       scratch_size = sizeof(union tcp_md5sum_block) + sizeof(struct tcphdr);
>> +       ret = tcp_sigpool_alloc_ahash("md5", scratch_size);
>> +       if (ret >= 0) {
>> +               tcp_md5_sigpool_id = ret;
> 
> tcp_md5_alloc_sigpool() can be called from multiple cpus,
> yet you are writing over tcp_md5_sigpool_id here without any
> spinlock/mutex/annotations ?

Yeah, it's writing-only: as long as there was a TCP-MD5 key in
the system, sigpool_id returned by tcp_sigpool_alloc_ahash() would stay
the same. The only time when it writes a different value - iff all
previous MD5 keys were released.

> KCSAN would eventually file a report, and a compiler might very well
> transform this to
> 
> tcp_md5_sigpool_id = random_value;
> <window where readers might catch garbage>
> tcp_md5_sigpool_id = ret;

Agree, haven't thought about the optimizing compiler nightmares.
Will add WRITE_ONCE().

[..]
>> +
>> +/**
>> + * sigpool_reserve_scratch - re-allocates scratch buffer, slow-path
>> + * @size: request size for the scratch/temp buffer
>> + */
>> +static int sigpool_reserve_scratch(size_t size)
>> +{
>> +       struct scratches_to_free *stf;
>> +       size_t stf_sz = struct_size(stf, scratches, num_possible_cpus());
> 
> This is wrong.   num_possible_cpus() could be 2, with two cpus numbered 0 and 8.
> 
> Look for nr_cpu_ids instead.

Hmm, but it seems num_possible_cpus() was exactly what I wanted?

As free_old_scratches() does:

:	while (stf->cnt--)
:		kfree(stf->scratches[stf->cnt]);

So, that's just the number of previously allocated scratches, not
per-CPU index.

>> +       int cpu, err = 0;
>> +
>> +       lockdep_assert_held(&cpool_mutex);
>> +       if (__scratch_size >= size)
>> +               return 0;
>> +
>> +       stf = kmalloc(stf_sz, GFP_KERNEL);
>> +       if (!stf)
>> +               return -ENOMEM;
>> +       stf->cnt = 0;
>> +
>> +       size = max(size, __scratch_size);
>> +       cpus_read_lock();
>> +       for_each_possible_cpu(cpu) {
>> +               void *scratch, *old_scratch;
>> +
>> +               scratch = kmalloc_node(size, GFP_KERNEL, cpu_to_node(cpu));
>> +               if (!scratch) {
>> +                       err = -ENOMEM;
>> +                       break;
>> +               }
>> +
>> +               old_scratch = rcu_replace_pointer(per_cpu(sigpool_scratch, cpu),
>> +                                       scratch, lockdep_is_held(&cpool_mutex));
>> +               if (!cpu_online(cpu) || !old_scratch) {
>> +                       kfree(old_scratch);
>> +                       continue;
>> +               }
>> +               stf->scratches[stf->cnt++] = old_scratch;
>> +       }
> 
> 
> I wonder why you are not simply using something around __alloc_percpu()

I presume that was a heritage of __tcp_alloc_md5sig_pool() that
allocated scratches this way. In pre-crypto-cloning versions per-CPU
ahash_requests were allocated with alloc_percpu().

But now looking closer, if I read pcpu allocator code correctly, it does
pcpu_mem_zalloc() for populating per-CPU chunks which depending on
pcpu_chunk_struct_size may be allocated with vmalloc() or kzalloc().

IOW, as long as CONFIG_NEED_PER_CPU_KM != n, which is:

: config NEED_PER_CPU_KM
:	depends on !SMP || !MMU

The memory, returned by pcpu allocator has no guarantee of being from
direct-map. Which I presume defeats the purpose of having any
scratch/temporary area for sg/crypto.

Am I missing something?

>> +       cpus_read_unlock();
>> +       if (!err)
>> +               __scratch_size = size;
>> +
>> +       call_rcu(&stf->rcu, free_old_scratches);
>> +       return err;
>> +}
>> +
>> +static void sigpool_scratch_free(void)
>> +{
>> +       int cpu;
>> +
>> +       for_each_possible_cpu(cpu)
>> +               kfree(rcu_replace_pointer(per_cpu(sigpool_scratch, cpu),
>> +                                         NULL, lockdep_is_held(&cpool_mutex)));
> 
> I wonder why bothering about freeing some space ? One scratch buffer
> per cpu is really small.

When all TCP-MD5/TCP-AO keys removed, why not free some memory?

[..]
>> +       /* slow-path */
>> +       mutex_lock(&cpool_mutex);
>> +       ret = sigpool_reserve_scratch(scratch_size);
>> +       if (ret)
>> +               goto out;
>> +       for (i = 0; i < cpool_populated; i++) {
>> +               if (!cpool[i].alg)
>> +                       continue;
>> +               if (strcmp(cpool[i].alg, alg))
>> +                       continue;
>> +
>> +               if (kref_read(&cpool[i].kref) > 0)
>> +                       kref_get(&cpool[i].kref);
>> +               else
>> +                       kref_init(&cpool[i].kref);
> 
> This looks wrong. kref_init() should be called once, after allocation,
> not based on kref_read().

Well, as long as it's the slow-path and cpool_mutex was grabbed, this
essentially re-allocating an entry that had it's last reference
released, but wasn't yet destroyed by __cpool_free_entry().

I think, if I interpreted it correctly, it was suggested-by Jakub:
https://lore.kernel.org/all/20230106175326.2d6a4dcd@kernel.org/T/#u

[..]
>> +static void __cpool_free_entry(struct sigpool_entry *e)
>> +{
>> +       crypto_free_ahash(e->hash);
>> +       kfree(e->alg);
>> +       memset(e, 0, sizeof(*e));
>> +}
>> +
>> +static void cpool_cleanup_work_cb(struct work_struct *work)
> 
> Really this looks over complicated to me.
> 
> All this kref maintenance and cpool_mutex costs :/

Hmm, unsure: I can remove this sigpool thing and just allocate a crypto
tfm for every new setsockopt(). Currently, this allocates one tfm per
hash algorithm, and without it it would be one tfm per setsockopt()/key.

The supported scale currently is thousands of keys per-socket, which
means that with sizeof(struct crypto_ahash) == 104, that will increase
memory consumption by hundreds of kilobytes to megabytes. I thought
that's a reasonable thing to do.

Should I proceed TCP-AO patches without this manager thing?

>> +{
>> +       bool free_scratch = true;
>> +       unsigned int i;
>> +
>> +       mutex_lock(&cpool_mutex);
>> +       for (i = 0; i < cpool_populated; i++) {
>> +               if (kref_read(&cpool[i].kref) > 0) {
>> +                       free_scratch = false;
>> +                       continue;
>> +               }
>> +               if (!cpool[i].alg)
>> +                       continue;
>> +               __cpool_free_entry(&cpool[i]);
>> +       }
>> +       if (free_scratch)
>> +               sigpool_scratch_free();
>> +       mutex_unlock(&cpool_mutex);
>> +}
[..]

Thanks,
         Dmitry


