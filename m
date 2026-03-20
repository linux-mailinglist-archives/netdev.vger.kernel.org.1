Return-Path: <netdev+bounces-270080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA5vBCLBvWmEBQMAu9opvQ
	(envelope-from <netdev+bounces-270080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:50:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C52362E17DB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AADE3016EDC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4A3F1678;
	Fri, 20 Mar 2026 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="GIpeVn5x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FBB371891
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043422; cv=none; b=KHX6Fl6+lKgEYw0i9pJpC0B67ZjQQ6G66nJyWchZBta8dfhsBDtdDEt6Oqs63FzJbrgc41kZR6SPk0m2q5Zm9q6rwJnJZH1wa9gPij79o3ocJJFwRGWV1ijJdzu8PpzNqE3vRawHFRxbf8OeayGv2Cou4FLEv3v+Bn448oIIGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043422; c=relaxed/simple;
	bh=pBnqRcrfQSqP04dQsfal7y3JrKjfyno+zV5OFsNFLDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhV9P8pgwT5nnoGb2d+1Qpnt915l91zpaCT7GM4j5wFBDFYanR2M6aEh4tXEYrynynUaOkhr35vd4leQ6RJcNSb494cdWstUAWip+Dv0sfHkN+f2CBb+yP6TdzvSnZP9CyPihkk8NpYiNaKl+4pklQmOS2MMibizqvh+SjQYevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=GIpeVn5x; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9tnA4Ak5H3Fpwo9bB274Q7Mpam2pSNxqDfisUGxyMOI=; t=1774043418; x=1774907418; 
	b=GIpeVn5x3g+4rj+WqKyU9vejaDlCBsosKTMNfjPKLnmSnIWHtYGxGa4sURvd4zGO7vGjWIDyzfj
	/vTd2dy0s0XfSXm+WRR6niEW6jbMVzf9JbQFFwy3qwTUlYzxiVu98JJE6DZ3v9P2ENbI/48nSric3
	toWk/USaC1tNODcyingwvay7Q8b9Ri5OjSPP5usT4DmtzY5xC2ueTMAEDPQCqzrx3WcDTLLLqZVCu
	d1Jgvy7ttxYJlk14ZuWIVMD2ykUU+KI8HgMXK88EGAHJ14CjCCJ9aWHHGjGP97OgIg6puTzZcrN2T
	QhXHDqKQYhPrw8o3DXnbP5rFqICfpYBYeefA==;
Received: from mail-yx1-f43.google.com ([74.125.224.43]:54277)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1w3hjR-0001sz-Rl
	for netdev@vger.kernel.org; Fri, 20 Mar 2026 14:50:18 -0700
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ca4dfdd88so1080872d50.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:50:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVN+rNwoPwJXEVKsIxkavkXYseeHV879sBPfoAwYtZBJcWmE6aeiCigCKAcJ1goqyEBTFoEkZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOW21GkjMIy8VAsuzZcOLzvP/sJt0iONxyj1D86ZCOrWsShveM
	ZVn6j7Q5RQedf8TlIFd8RP15z0R0FhYEZrDhWkuQ1Gz1uF9e234yR5Is6Zm8wIwAyFJPnQPRrlo
	NgKD96mI45oqM8jmKPlKKyTvNYWDto54=
X-Received: by 2002:a05:690e:4183:b0:64c:a1b9:ffa4 with SMTP id
 956f58d0204a3-64eaa69e0c4mr4675626d50.4.1774043413128; Fri, 20 Mar 2026
 14:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316223228.2611-14-ouster@cs.stanford.edu> <20260318072149.269101-1-pabeni@redhat.com>
In-Reply-To: <20260318072149.269101-1-pabeni@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 20 Mar 2026 14:49:37 -0700
X-Gmail-Original-Message-ID: <CAGXJAmywmpxx8A+f0ZZ3H=NKjEVDbCZ6jXAZ1x9i3BBf8jomXA@mail.gmail.com>
X-Gm-Features: AaiRm51Clj3wJ_E3iBMuERIcyueYQmgIs5S9u8tTp6Tq127XTp9wt44wWzLaryI
Message-ID: <CAGXJAmywmpxx8A+f0ZZ3H=NKjEVDbCZ6jXAZ1x9i3BBf8jomXA@mail.gmail.com>
Subject: Re: [net-next,v17,13/14] net: homa: create homa_plumbing.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: bc0ab93dd0d250805ad7d834ef2a99c7
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270080-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,mail.gmail.com:mid,control.id:url]
X-Rspamd-Queue-Id: C52362E17DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> net: homa: create homa_plumbing.c
>
> homa_plumbing.c contains functions that connect Homa to the rest of
> the Linux kernel, such as dispatch tables used by Linux and the
> top-level functions that Linux invokes from those dispatch tables.
>
> > diff --git a/net/homa/homa_plumbing.c b/net/homa/homa_plumbing.c
> > --- /dev/null
> > +++ b/net/homa/homa_plumbing.c
>
> [ ... ]
>
> > +/**
> > + * homa_ioc_info() - The top-level function that implements the
> > + * HOMAIOCINFO ioctl for Homa sockets.
> > + * @sock:  Socket for this request
> > + * @arg:   The address in user space of the argument to ioctl, which
> > + *          is a homa_info struct.
> > + *
> > + * Return:  0 on success, otherwise a negative errno. Sets hsk->error_=
msg
> > + *          on errors.
> > + */
> > +int homa_ioc_info(struct socket *sock, unsigned long arg)
> > +{
> > +     struct homa_sock *hsk =3D homa_sk(sock->sk);
> > +     struct homa_rpc_info rinfo;
> > +     struct homa_info hinfo;
> > +     struct homa_rpc *rpc;
> > +     int bytes_avl;
> > +     char *dst;
> > +
> > +     if (unlikely(copy_from_user(&hinfo, (void __user *)arg,
> > +                                 sizeof(hinfo)))) {
> > +             hsk->error_msg =3D "invalid address for homa_info";
> > +             return -EFAULT;
> > +     }
> > +
> > +     if (!homa_protect_rpcs(hsk)) {
> > +             hsk->error_msg =3D "socket has been shut down";
> > +             return -ESHUTDOWN;
> > +     }
> > +     hinfo.bpool_avail_bytes =3D homa_pool_avail_bytes(hsk->buffer_poo=
l);
> > +     hinfo.port =3D hsk->port;
> > +     dst =3D (char *)hinfo.rpc_info;
> > +     bytes_avl =3D hinfo.rpc_info_length;
> > +     hinfo.num_rpcs =3D 0;
> > +     list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
>                                 ^^^^
>
> Is rcu_read_lock() needed around this list_for_each_entry_rcu() loop?
>
> All three other functions that use the same homa_protect_rpcs() +
> list_for_each_entry_rcu pattern (homa_abort_rpcs in homa_rpc.c,
> homa_timer in homa_timer.c, and homa_abort_sock_rpcs in homa_rpc.c)
> bracket the traversal with rcu_read_lock()/rcu_read_unlock().
>
> The homa_protect_rpcs() mechanism prevents RPC reaping via an atomic
> counter, but doesn't provide RCU read-side protection.
>
> Without rcu_read_lock(), list_for_each_entry_rcu() triggers a lockdep
> RCU warning, and on PREEMPT_RCU configurations the reader can be
> preempted during traversal without the RCU subsystem knowing a reader
> is active, breaking the RCU contract.

Fixed (added RCU locking).

>
> > +             homa_rpc_lock(rpc);
> > +             if (rpc->state =3D=3D RPC_DEAD) {
> > +                     homa_rpc_unlock(rpc);
> > +                     continue;
> > +             }
> > +             homa_rpc_get_info(rpc, &rinfo);
> > +             homa_rpc_unlock(rpc);
> > +             if (dst && bytes_avl >=3D sizeof(rinfo)) {
> > +                     if (copy_to_user((void __user *)dst, &rinfo,
> > +                                      sizeof(rinfo))) {
> > +                             homa_unprotect_rpcs(hsk);
> > +                             hsk->error_msg =3D "couldn't copy homa_rp=
c_info to user space: invalid or read-only address?";
> > +                             return -EFAULT;
> > +                     }
> > +                     dst +=3D sizeof(rinfo);
> > +                     bytes_avl -=3D sizeof(rinfo);
> > +             }
> > +             hinfo.num_rpcs++;
> > +     }
> > +     homa_unprotect_rpcs(hsk);
>
> [ ... ]
>
> > +/**
> > + * homa_socket() - Implements the socket(2) system call for sockets.
> > + * @sk:    Socket on which the system call was invoked. The non-Homa
> > + *         parts have already been initialized.
> > + *
> > + * Return: always 0 (success).
> > + */
> > +int homa_socket(struct sock *sk)
> > +{
> > +     struct homa_sock *hsk =3D homa_sk(sk);
> > +     int result;
> > +
> > +     result =3D homa_sock_init(hsk);
> > +     if (result !=3D 0) {
> > +             homa_sock_shutdown(hsk);
>                 ^^^^^^^^^^^^^^^^^^^
>
> Can this trigger a spinlock bug?
>
> When homa_sock_init() fails because homa_pool_alloc() returns
> ERR_PTR(-ENOMEM), it returns before spin_lock_init(&hsk->lock) is
> called in homa_sock_init().
>
> The error path then calls homa_sock_shutdown(hsk), whose first action
> is homa_sock_lock(hsk) =3D spin_lock_bh(&hsk->lock) on the
> never-initialized spinlock.
>
> With CONFIG_DEBUG_SPINLOCK, the lock's magic field (zero from slab
> allocation) doesn't match SPINLOCK_MAGIC (0xdead4ead), causing
> spin_bug() to call BUG().
>
> While homa_sock_shutdown() would immediately return after checking
> !hsk->homa (NULL), the BUG() fires inside spin_lock_bh() before that
> check is reached.
>
> This is reachable under memory pressure.

Fixed (no need for additional cleanup after errors).

>
> > +             homa_sock_destroy(&hsk->sock);
> > +     }
> > +     return result;
> > +}
>
> [ ... ]
>
> > +/**
> > + * homa_getsockopt() - Implements the getsockopt system call for Homa =
sockets.
> > + * @sk:      Socket on which the system call was invoked.
> > + * @level:   Selects level in the network stack to handle the request;
> > + *           must be IPPROTO_HOMA.
> > + * @optname: Identifies a particular setsockopt operation.
> > + * @optval:  Address in user space where the option's value should be =
stored.
> > + * @optlen:  Number of bytes available at optval; will be overwritten =
with
> > + *           actual number of bytes stored.
> > + * Return:   0 on success, otherwise a negative errno. Sets hsk->error=
_msg
> > + *           on errors.
> > + */
> > +int homa_getsockopt(struct sock *sk, int level, int optname,
> > +                 char __user *optval, int __user *optlen)
> > +{
> > +     struct homa_sock *hsk =3D homa_sk(sk);
> > +     struct homa_rcvbuf_args rcvbuf_args;
> > +     int is_server;
> > +     void *result;
> > +     int len;
> > +
> > +     if (copy_from_sockptr(&len, USER_SOCKPTR(optlen), sizeof(int))) {
> > +             hsk->error_msg =3D "invalid address for optlen argument t=
o getsockopt";
> > +             return -EFAULT;
> > +     }
> > +
> > +     if (level !=3D IPPROTO_HOMA) {
> > +             hsk->error_msg =3D "homa_setsockopt invoked with level no=
t IPPROTO_HOMA";
>                                  ^^^^^^^^^^^^^^
>
> This isn't a bug, but the error message says 'homa_setsockopt' instead
> of 'homa_getsockopt'. This is a copy-paste error from homa_setsockopt().
>
> The error_msg field is returned to applications via the HOMAIOCINFO
> ioctl, so users debugging socket option failures would see a misleading
> message pointing to the wrong function.

Fixed.

>
> > +             return -ENOPROTOOPT;
> > +     }
> > +     if (optname =3D=3D SO_HOMA_RCVBUF) {
>
> [ ... ]
>
> > +/**
> > + * homa_recvmsg() - Receive a message from a Homa socket.
> > + * @sk:          Socket on which the system call was invoked.
> > + * @msg:         Controlling information for the receive.
> > + * @len:         Total bytes of space available in msg->msg_iov; not u=
sed.
> > + * @flags:       Flags from system call; only MSG_DONTWAIT is used.
> > + * @addr_len:    Store the length of the sender address here
> > + * Return:       The length of the message on success, otherwise a neg=
ative
> > + *               errno. Sets hsk->error_msg on errors.
> > + */
> > +int homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int =
flags,
> > +              int *addr_len)
> > +{
>
> [ ... ]
>
> > +     if (rpc->error) {
> > +             hsk->error_msg =3D "RPC failed";
> > +             result =3D rpc->error;
> > +     } else {
> > +             result =3D rpc->msgin.length;
> > +     }
> > +     result =3D rpc->error ? rpc->error : rpc->msgin.length;
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> This isn't a bug, but there's redundant dead-store code here.
>
> The if/else block assigns 'result' to either 'rpc->error' or
> 'rpc->msgin.length', but the next line immediately overwrites 'result'
> with the identical ternary expression.
>
> The two 'result =3D ...' assignments inside the if/else are dead stores
> that are always overwritten. The if/else block's only surviving side
> effect is setting 'hsk->error_msg =3D "RPC failed"' when rpc->error is
> nonzero.
>
> This appears to be an editing mistake where either the if/else should
> be the authoritative result assignment (and the ternary deleted), or
> the ternary should remain and the if/else should be simplified to only
> set error_msg (removing its result assignments).

Fixed.

>
> > +
> > +     /* Collect result information. */
> > +     control.id =3D rpc->id;
>
> [ ... ]
>
> > +/**
> > + * homa_hrtimer() - This function is invoked by the hrtimer mechanism =
to
> > + * wake up the timer thread. Runs at IRQ level.
> > + * @timer:   The timer that triggered; not used.
> > + *
> > + * Return:   Always HRTIMER_RESTART.
> > + */
> > +enum hrtimer_restart homa_hrtimer(struct hrtimer *timer)
> > +{
> > +     wake_up_process(timer_kthread);
> > +     return HRTIMER_NORESTART;
>         ^^^^^^^^^^^^^^^^^^^^^^
>
> The kernel-doc comment states 'Return: Always HRTIMER_RESTART' but the
> function returns HRTIMER_NORESTART.
>
> The runtime behavior is correct (homa_timer_main re-arms the hrtimer
> explicitly via hrtimer_start on each loop iteration, so HRTIMER_NORESTART
> is the intended return value), but the comment contradicts the code.
>
> This misleads readers into believing the timer auto-restarts, when it
> does not.

Fixed.

