Return-Path: <netdev+bounces-27371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A677BADB
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D7B2810D7
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E61C135;
	Mon, 14 Aug 2023 14:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C6BA4C
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 14:03:16 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D32BE3
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:03:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF84621861;
	Mon, 14 Aug 2023 14:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692021792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6F6qS9ARfDgbmlW4Wz3YUR3Sj+wNsXTs4Qtk2wGXVhY=;
	b=IkI6rSOLdDY72UMRgaAO06Ar5rimrijY4ojEK9AYMP2FppewUTMFSOKeACVZl4GGVN05Ub
	gjVaJYxK3C1wlB/4xj7hE2tk4pvY969st3ipBt9qvrEggnNXQHff3kSr3j3ZQWnoSK+Aop
	Xa9pDMCFEXmqEAoyRwuALx04pJQ0gIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692021792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6F6qS9ARfDgbmlW4Wz3YUR3Sj+wNsXTs4Qtk2wGXVhY=;
	b=qHey2eLrAY4XS9Xe+ixB7eKGl3MSxB5igKQpybqKJW/JrWnjh36/tH83eLRtzKCtzZcS4m
	uMp7BUAYk1XT6YAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF0B5138EE;
	Mon, 14 Aug 2023 14:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id I30jLiA02mRWbgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 14 Aug 2023 14:03:12 +0000
Message-ID: <bebf00fb-be2d-d6da-bd7f-4e610095decc@suse.de>
Date: Mon, 14 Aug 2023 16:03:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-16-hare@suse.de>
 <cf21000c-177e-c882-ac30-fe3190748bae@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Autocrypt: addr=hare@suse.de; keydata=
 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
 YwtooKEemPj2lg==
In-Reply-To: <cf21000c-177e-c882-ac30-fe3190748bae@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/14/23 14:48, Sagi Grimberg wrote:
> 
> 
> On 8/14/23 14:19, Hannes Reinecke wrote:
>> Add functions to start the TLS handshake upcall when
>> the TCP TSAS sectype is set to 'tls1.3' and add a config
>> option NVME_TARGET_TCP_TLS.
> 
> Need to document the refcount added.
> Also the general design with upcalling tls handshake in
> userspace and continue from there...
> 
Okay.

>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/Kconfig    |  15 ++++
>>   drivers/nvme/target/configfs.c |  21 +++++
>>   drivers/nvme/target/nvmet.h    |   1 +
>>   drivers/nvme/target/tcp.c      | 146 ++++++++++++++++++++++++++++++++-
>>   4 files changed, 179 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
>> index 79fc64035ee3..8a6c9cae804c 100644
>> --- a/drivers/nvme/target/Kconfig
>> +++ b/drivers/nvme/target/Kconfig
>> @@ -84,6 +84,21 @@ config NVME_TARGET_TCP
>>         If unsure, say N.
>> +config NVME_TARGET_TCP_TLS
>> +    bool "NVMe over Fabrics TCP target TLS encryption support"
>> +    depends on NVME_TARGET_TCP
>> +    select NVME_COMMON
>> +    select NVME_KEYRING
>> +    select NET_HANDSHAKE
>> +    select KEYS
>> +    help
>> +      Enables TLS encryption for the NVMe TCP target using the 
>> netlink handshake API.
>> +
>> +      The TLS handshake daemon is availble at
>> +      https://github.com/oracle/ktls-utils.
>> +
>> +      If unsure, say N.
>> +
>>   config NVME_TARGET_AUTH
>>       bool "NVMe over Fabrics In-band Authentication support"
>>       depends on NVME_TARGET
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index efbfed310370..ad1fb32c7387 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -15,6 +15,7 @@
>>   #ifdef CONFIG_NVME_TARGET_AUTH
>>   #include <linux/nvme-auth.h>
>>   #endif
>> +#include <linux/nvme-keyring.h>
>>   #include <crypto/hash.h>
>>   #include <crypto/kpp.h>
>> @@ -397,6 +398,17 @@ static ssize_t nvmet_addr_tsas_store(struct 
>> config_item *item,
>>       return -EINVAL;
>>   found:
>> +    if (sectype == NVMF_TCP_SECTYPE_TLS13) {
>> +        if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
>> +            pr_err("TLS is not supported\n");
>> +            return -EINVAL;
>> +        }
>> +        if (!port->keyring) {
>> +            pr_err("TLS keyring not configured\n");
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>>       nvmet_port_init_tsas_tcp(port, sectype);
>>       /*
>>        * The TLS implementation currently does not support
>> @@ -1815,6 +1827,7 @@ static void nvmet_port_release(struct 
>> config_item *item)
>>       flush_workqueue(nvmet_wq);
>>       list_del(&port->global_entry);
>> +    key_put(port->keyring);
>>       kfree(port->ana_state);
>>       kfree(port);
>>   }
>> @@ -1864,6 +1877,14 @@ static struct config_group 
>> *nvmet_ports_make(struct config_group *group,
>>           return ERR_PTR(-ENOMEM);
>>       }
>> +    if (nvme_keyring_id()) {
>> +        port->keyring = key_lookup(nvme_keyring_id());
>> +        if (IS_ERR(port->keyring)) {
>> +            pr_warn("NVMe keyring not available, disabling TLS\n");
>> +            port->keyring = NULL;
> 
> why setting this to NULL?
> 
It's check when changing TSAS; we can only enable TLS if the nvme 
keyring is available.

>> +        }
>> +    }
>> +
>>       for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
>>           if (i == NVMET_DEFAULT_ANA_GRPID)
>>               port->ana_state[1] = NVME_ANA_OPTIMIZED;
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 8cfd60f3b564..7f9ae53c1df5 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -158,6 +158,7 @@ struct nvmet_port {
>>       struct config_group        ana_groups_group;
>>       struct nvmet_ana_group        ana_default_group;
>>       enum nvme_ana_state        *ana_state;
>> +    struct key            *keyring;
>>       void                *priv;
>>       bool                enabled;
>>       int                inline_data_size;
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index f19ea9d923fd..77fa339008e1 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -8,9 +8,13 @@
>>   #include <linux/init.h>
>>   #include <linux/slab.h>
>>   #include <linux/err.h>
>> +#include <linux/key.h>
>>   #include <linux/nvme-tcp.h>
>> +#include <linux/nvme-keyring.h>
>>   #include <net/sock.h>
>>   #include <net/tcp.h>
>> +#include <net/tls.h>
>> +#include <net/handshake.h>
>>   #include <linux/inet.h>
>>   #include <linux/llist.h>
>>   #include <crypto/hash.h>
>> @@ -66,6 +70,16 @@ device_param_cb(idle_poll_period_usecs, 
>> &set_param_ops,
>>   MODULE_PARM_DESC(idle_poll_period_usecs,
>>           "nvmet tcp io_work poll till idle time period in usecs: 
>> Default 0");
>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>> +/*
>> + * TLS handshake timeout
>> + */
>> +static int tls_handshake_timeout = 10;
>> +module_param(tls_handshake_timeout, int, 0644);
>> +MODULE_PARM_DESC(tls_handshake_timeout,
>> +         "nvme TLS handshake timeout in seconds (default 10)");
>> +#endif
>> +
>>   #define NVMET_TCP_RECV_BUDGET        8
>>   #define NVMET_TCP_SEND_BUDGET        8
>>   #define NVMET_TCP_IO_WORK_BUDGET    64
>> @@ -122,11 +136,13 @@ struct nvmet_tcp_cmd {
>>   enum nvmet_tcp_queue_state {
>>       NVMET_TCP_Q_CONNECTING,
>> +    NVMET_TCP_Q_TLS_HANDSHAKE,
>>       NVMET_TCP_Q_LIVE,
>>       NVMET_TCP_Q_DISCONNECTING,
>>   };
>>   struct nvmet_tcp_queue {
>> +    struct kref        kref;
> 
> Why is kref the first member of the struct?
> 
Habit.
I don't mind where it'll end up.

>>       struct socket        *sock;
>>       struct nvmet_tcp_port    *port;
>>       struct work_struct    io_work;
>> @@ -155,6 +171,10 @@ struct nvmet_tcp_queue {
>>       struct ahash_request    *snd_hash;
>>       struct ahash_request    *rcv_hash;
>> +    /* TLS state */
>> +    key_serial_t        tls_pskid;
>> +    struct delayed_work    tls_handshake_work;
>> +
>>       unsigned long           poll_end;
>>       spinlock_t        state_lock;
>> @@ -1283,12 +1303,21 @@ static int nvmet_tcp_try_recv(struct 
>> nvmet_tcp_queue *queue,
>>       return ret;
>>   }
>> +static void nvmet_tcp_release_queue(struct kref *kref)
>> +{
>> +    struct nvmet_tcp_queue *queue =
>> +        container_of(kref, struct nvmet_tcp_queue, kref);
>> +
>> +    WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
>> +    queue_work(nvmet_wq, &queue->release_work);
>> +}
>> +
>>   static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue 
>> *queue)
>>   {
>>       spin_lock_bh(&queue->state_lock);
>>       if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
>>           queue->state = NVMET_TCP_Q_DISCONNECTING;
>> -        queue_work(nvmet_wq, &queue->release_work);
>> +        kref_put(&queue->kref, nvmet_tcp_release_queue);
>>       }
>>       spin_unlock_bh(&queue->state_lock);
>>   }
>> @@ -1485,6 +1514,8 @@ static void nvmet_tcp_release_queue_work(struct 
>> work_struct *w)
>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>>       nvmet_tcp_restore_socket_callbacks(queue);
>> +    tls_handshake_cancel(queue->sock->sk);
>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
> 
> We should call it tls_handshake_tmo_work or something to make it
> clear it is a timeout work.
> 
Okay.

>>       cancel_work_sync(&queue->io_work);
>>       /* stop accepting incoming data */
>>       queue->rcv_state = NVMET_TCP_RECV_ERR;
>> @@ -1512,8 +1543,13 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>>       read_lock_bh(&sk->sk_callback_lock);
>>       queue = sk->sk_user_data;
>> -    if (likely(queue))
>> -        queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
>> +    if (likely(queue)) {
>> +        if (queue->data_ready)
>> +            queue->data_ready(sk);
>> +        if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
>> +            queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
>> +                      &queue->io_work);
>> +    }
>>       read_unlock_bh(&sk->sk_callback_lock);
>>   }
>> @@ -1621,6 +1657,83 @@ static int nvmet_tcp_set_queue_sock(struct 
>> nvmet_tcp_queue *queue)
>>       return ret;
>>   }
>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
>> +                     key_serial_t peerid)
>> +{
>> +    struct nvmet_tcp_queue *queue = data;
>> +
>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>> +         queue->idx, peerid, status);
>> +    spin_lock_bh(&queue->state_lock);
>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> 
> Is this even possible?
> 
I guess it can happen when the socket closes during handshake; the 
daemon might still be sending a 'done' event but 
nvmet_tcp_schedule_release_queue() has been called.

>> +        pr_warn("queue %d: TLS handshake already completed\n",
>> +            queue->idx);
>> +        spin_unlock_bh(&queue->state_lock);
>> +        kref_put(&queue->kref, nvmet_tcp_release_queue);
> 
> How can we get here?
> 
See above.

>> +        return;
>> +    }
>> +    if (!status)
>> +        queue->tls_pskid = peerid;
>> +    queue->state = NVMET_TCP_Q_CONNECTING;
>> +    spin_unlock_bh(&queue->state_lock);
>> +
>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>> +    if (status) {
> 
> Wait, did we assign the sk_state_change in this stage? What will
> sock shutdown trigger?
> 
That, however is a good point. You might be right.
Will be checking.

>> +        kernel_sock_shutdown(queue->sock, SHUT_RDWR);
> 
> Probably the put can be moved to a out: label in the end.
> 
Probably.

>> +        kref_put(&queue->kref, nvmet_tcp_release_queue);
>> +        return;
>> +    }
>> +
>> +    pr_debug("queue %d: resetting queue callbacks after TLS 
>> handshake\n",
>> +         queue->idx);
>> +    nvmet_tcp_set_queue_sock(queue);
>> +    kref_put(&queue->kref, nvmet_tcp_release_queue);
>> +}
>> +
>> +static void nvmet_tcp_tls_handshake_timeout_work(struct work_struct *w)
>> +{
>> +    struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
>> +            struct nvmet_tcp_queue, tls_handshake_work);
>> +
>> +    pr_debug("queue %d: TLS handshake timeout\n", queue->idx);
> 
> Probably its better to make this pr_warn...
> 
Ok.

>> +    if (!tls_handshake_cancel(queue->sock->sk))
>> +        return;
>> +    kernel_sock_shutdown(queue->sock, SHUT_RDWR);
> 
> Same question here, did we assign sk_state_change yet?
> 
Will be checking.

>> +    kref_put(&queue->kref, nvmet_tcp_release_queue);
>> +}
>> +
>> +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
>> +{
>> +    int ret = -EOPNOTSUPP;
>> +    struct tls_handshake_args args;
>> +
>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>> +        pr_warn("cannot start TLS in state %d\n", queue->state);
>> +        return -EINVAL;
>> +    }
>> +
>> +    kref_get(&queue->kref);
>> +    pr_debug("queue %d: TLS ServerHello\n", queue->idx);
>> +    memset(&args, 0, sizeof(args));
>> +    args.ta_sock = queue->sock;
>> +    args.ta_done = nvmet_tcp_tls_handshake_done;
>> +    args.ta_data = queue;
>> +    args.ta_keyring = key_serial(queue->port->nport->keyring);
>> +    args.ta_timeout_ms = tls_handshake_timeout * 1000;
>> +
>> +    ret = tls_server_hello_psk(&args, GFP_KERNEL);
>> +    if (ret) {
>> +        kref_put(&queue->kref, nvmet_tcp_release_queue);
>> +        pr_err("failed to start TLS, err=%d\n", ret);
>> +    } else {
>> +        queue_delayed_work(nvmet_wq, &queue->tls_handshake_work,
>> +                   tls_handshake_timeout * HZ);
>> +    }
>> +    return ret;
>> +}
>> +#endif
>> +
>>   static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>           struct socket *newsock)
>>   {
>> @@ -1636,11 +1749,16 @@ static void nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>>       INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
>> +    kref_init(&queue->kref);
>>       queue->sock = newsock;
>>       queue->port = port;
>>       queue->nr_cmds = 0;
>>       spin_lock_init(&queue->state_lock);
>> -    queue->state = NVMET_TCP_Q_CONNECTING;
>> +    if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
>> +        NVMF_TCP_SECTYPE_TLS13)
>> +        queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
>> +    else
>> +        queue->state = NVMET_TCP_Q_CONNECTING;
>>       INIT_LIST_HEAD(&queue->free_list);
>>       init_llist_head(&queue->resp_list);
>>       INIT_LIST_HEAD(&queue->resp_send_list);
>> @@ -1671,12 +1789,32 @@ static void nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>> +    INIT_DELAYED_WORK(&queue->tls_handshake_work,
>> +              nvmet_tcp_tls_handshake_timeout_work);
>> +    if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
>> +        struct sock *sk = queue->sock->sk;
>> +
>> +        /* Restore the default callbacks before starting upcall */
>> +        read_lock_bh(&sk->sk_callback_lock);
>> +        sk->sk_user_data = NULL;
>> +        sk->sk_data_ready = port->data_ready;
>> +        read_unlock_bh(&sk->sk_callback_lock);
>> +        if (!nvmet_tcp_tls_handshake(queue))
>> +            return;
>> +
>> +        /* TLS handshake failed, terminate the connection */
>> +        goto out_destroy_sq;
>> +    }
>> +#endif
>> +
>>       ret = nvmet_tcp_set_queue_sock(queue);
>>       if (ret)
>>           goto out_destroy_sq;
>>       return;
>>   out_destroy_sq:
>> +    queue->state = NVMET_TCP_Q_DISCONNECTING;
> 
> Can you clarify what this is used for?
> 
Primarily for debugging, to signal that we really are
disconnecting. But yeah, not really required.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


