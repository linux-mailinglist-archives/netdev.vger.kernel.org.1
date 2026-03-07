Return-Path: <netdev+bounces-265062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CENBABWiq2k2fAEAu9opvQ
	(envelope-from <netdev+bounces-265062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:57:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DBE22A03B
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBB2D3051493
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73D3290A0;
	Sat,  7 Mar 2026 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsIWxnhp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4D3254AE
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772855820; cv=pass; b=r15m1oHeXam0HbxV/nf18e9d7CWE12X1iirRPoscLIlNgbrJuFvnpVgr0xnWFZRpBXm3hJl5rZEQ7h4udApGvTyfoGBQwIYBsrSFtFsWEa8pdwgEsxeZmIAPU6iPqm5fiL0J+h2fBFwaZbLsyh+yobqB0YR9DK+eazpnem6C+5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772855820; c=relaxed/simple;
	bh=+YqGUeipYWqmWrLE2oeW+THGWpKHPiQu0Eq0PtmykIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOlM01oyVri1mMVANUoK7L3Hrsjk9v+7yp3vrYIbd1fZbQP6DMBRL4ppRXkPpRVpiuHBiUTpsNN1Y7NHeQKeq0DpuBgQhDcfC3IaZOoMy+P9qW1FgQ0rk+YMXX8C0WIhJEj8fVUUDRYvUePVyqJDNKbMST1cQH2s7/9a9ITUEx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsIWxnhp; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899fa9610bbso100948416d6.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 19:56:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772855817; cv=none;
        d=google.com; s=arc-20240605;
        b=XIWK63Qw8WvzcMEs9u4KNEcTJjvIJ0Da3rnAiBFQ1X5i9YdVLTrak75cdQubPEHpqH
         P2kD+Z1T1CC0z+kRRzwzpvb/15LFIA1+BeAse6CAbgZlFN51ErpBwSR05gb+dYWTMAp4
         HrzhsTviM3ZFfZReTCtaQs1g14mR8zfZrSCzYsza914WbLqnOxuoTdtdmJj/QiEyefWr
         Hc+dSVHNY3GY8QsDwpTEXSj4qPXL5g2mexy1C8rg1RdmNV2R3N/wYYHyf+fRnP2C/kAw
         M+kNwg7soD6F5+275qOtAuRqc0iow9CNs5f4zeUPi7BlcbnaOgHD+VHneSC8Oco+5PUR
         idEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=37+f+iNxTBvZkkOYj5LNOiKZe8rFt1xADvJtvYfXxU8=;
        fh=kB2QvoVzrYnMTh9y8zs37UvjylSFrDT83k91OzOeld0=;
        b=drK4wFXIAussXhVc0unIulj9dTSvVeYT7t/uPzLDAEJV1axEs4najt8mBYC7XAeRxw
         IWil9ERE5HELThYEpyzrbrlX9yxy4COqUFi0V07mUJ/oDzJ0s0ZqSgk/HT3/P6sRC+uM
         yQNizi5Lco4aogxO3bydjPWtsy7u0uBFMt4gnljpCdKS9wUJT2fI3vQI/Xr26W2CoKT6
         5NWij2Ny3gpZMhTDpvVzyVwpSsHYu270qiV/1a70lT18lqF4Rfo9Syzq9a/RKQGOgWPz
         oSdMLoQTZ2LZsls2cn63lcsiE60o7TCcDHO/d9pP1F0n0aAfbVkzEIqEMavp+zlXe2WN
         qogQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772855817; x=1773460617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37+f+iNxTBvZkkOYj5LNOiKZe8rFt1xADvJtvYfXxU8=;
        b=dsIWxnhpN0EAXPrukZSZ73phlOmE+r3Qhs2dhlQfOjw7axbBNQDEKaF6iiN3ZJVLSH
         L3EDpZjsmRw9+5R/uWfsrkN+B7K39mZ4Brwi8GsliM3XE4wDicSqf7uiqAno8Fyo91En
         gDJZhgBJYMEmTWGHWd0Ty1Mc1Z/YEg8uDvmmBe2iNCBKjQOWgSQfuFhrQbFANIJpNUXb
         srkPKgsyYVlkk177dc7Wnv4QbGuYMf6lQJ3oxf+6xabFsurrdGXD/CvyCTnf3MSTW5pi
         IO8A1CW6fKVULJhnuq29fDHVLBvDML0tqawGma/1sRK4SpRuGQgxiLfTDDi8CpEHHMJa
         bLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772855817; x=1773460617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37+f+iNxTBvZkkOYj5LNOiKZe8rFt1xADvJtvYfXxU8=;
        b=pyKeWlQFZNKP02oDek5teqSHf6VrjrlhM4qWLMbdgfcLujOsg7YQdxDN2XXD6o2wSz
         1kXJA7vuhTlnZGV/zq0gAmEWGR3FHixMhVVsQe0zQInh2abbTVgSCST0ZrXXLgT+WOzb
         UBaShiportiHbszeUaI/8kfsgx1k2154YAKrxxOy72dJwbM9NU7S00ZyFJ4WNXtNv1v1
         WPOsYHFLK3NYDBoyijKKULWI8CD0NP9S3wpoLPrOECG7NExZOt0rea+5k+aZrrRTPa8K
         zIKZhaqi6PIM5UkwtKXf2xcGiKMN99pg/ospXJe4/KMrF3GYQxfr6Q+fsNnbVQd1X8zO
         EGqA==
X-Gm-Message-State: AOJu0YzJCXJR2GC57NUmpPKIJjpjKgnG6ayCkt+7GeQvUN+aX/YRGsgU
	A98d5tFmv5+FvQPqy6WrJs1eAZXQOehZovDmgVVbnkuhglE7tFJSakVVlhKdPM42n8Uib0tpQ1A
	tmjqhOop42EobgXnvLVC+wWRMPlKNSMLhelOb8vkV
X-Gm-Gg: ATEYQzzJAitQOWPZ45gD1G3iNLPPHfWdXwca3fHom2vSUYt3a2doCXmnvB8ExQKlr6c
	pa3/3shGtlhjW9yP/sS3JJVrE023aNo8wridU2se3YhxchFDSxN5ad6HR63Y2CY/FXv6yxxhwON
	USbTfRJD84dk8ZARKL1iER/4wVhNbCMZ13Xu0FgBk+/ICrAWDuObKsYmZ+2pP6Mt7pMm1ABptRs
	N/mMbyflU2Y+uUDfIWU2Ba03mdURrpZRbah94sJd5E7SkZux2BRU6jIrKd5YXx4MxlY5Rprdkly
	9kt+yWVb
X-Received: by 2002:a05:6214:c6d:b0:899:f6a0:7a6e with SMTP id
 6a1803df08f44-89a30a1751dmr64828556d6.9.1772855816216; Fri, 06 Mar 2026
 19:56:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307032158.372165-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260307032158.372165-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 04:56:45 +0100
X-Gm-Features: AaiRm51ElVeY3JClqi6sIJpTbU0I15M_lz5ZJaTnV56OEn-A2dcPlGYd14B54AI
Message-ID: <CANn89iJ0V6un1un7zjG-J9d4EJQOjTO37s3EQUKTodwPWsXhFQ@mail.gmail.com>
Subject: Re: [PATCH net v1] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, 
	syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E2DBE22A03B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265062-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 4:22=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> Syzkaller reported a panic in smc_tcp_syn_recv_sock() [1].
>
> smc_tcp_syn_recv_sock() is called in the TCP receive path
> (softirq) via icsk_af_ops->syn_recv_sock on the clcsock (TCP
> listening socket). It reads sk_user_data to get the smc_sock
> pointer. However, when the SMC listen socket is being closed
> concurrently, smc_close_active() sets clcsock->sk_user_data
> to NULL under sk_callback_lock, and then the smc_sock itself
> can be freed via sock_put() in smc_release().
>
> This leads to two issues:
>
> 1) NULL pointer dereference: sk_user_data is NULL when
>    accessed.
> 2) Use-after-free: sk_user_data is read as non-NULL, but the
>    smc_sock is freed before its fields (e.g., queued_smc_hs,
>    ori_af_ops) are accessed.
>
> The race window looks like this:
>
>   CPU A (softirq)              CPU B (process ctx)
>
>   tcp_v4_rcv()
>     TCP_NEW_SYN_RECV:
>     sk =3D req->rsk_listener
>     sock_hold(sk)
>     /* No lock on listener */
>                                smc_close_active():
>                                  write_lock_bh(cb_lock)
>                                  sk_user_data =3D NULL
>                                  write_unlock_bh(cb_lock)
>                                  ...
>                                  smc_clcsock_release()
>                                  sock_put(smc->sk) x2
>                                    -> smc_sock freed!
>     tcp_check_req()
>       smc_tcp_syn_recv_sock():
>         smc =3D user_data(sk)
>           -> NULL or dangling
>         smc->queued_smc_hs
>           -> crash!
>
> Note that the clcsock and smc_sock are two independent objects
> with separate refcounts. TCP stack holds a reference on the
> clcsock, which keeps it alive, but this does NOT prevent the
> smc_sock from being freed.
>
> Fix this by taking sk_callback_lock to read sk_user_data and
> then sock_hold(&smc->sk) under the lock to pin the smc_sock.
> The lock is released immediately after sock_hold(), rather
> than being held for the entire function, to avoid holding it
> across ori_af_ops->syn_recv_sock() which creates child
> sockets and could risk deadlocks with nested lock ordering.
> sock_put(&smc->sk) is called on all exit paths after the
> hold.
>
> [1] https://syzkaller.appspot.com/bug?extid=3D827ae2bfb3a3529333e9
>
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@goo=
gle.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/smc/af_smc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index d0119afcc6a1..21218b9b0f9a 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -131,7 +131,14 @@ static struct sock *smc_tcp_syn_recv_sock(const stru=
ct sock *sk,
>         struct smc_sock *smc;
>         struct sock *child;
>
> +       read_lock_bh(&((struct sock *)sk)->sk_callback_lock);

This will not survive a SYN flood attack.

Please use RCU instead.

>         smc =3D smc_clcsock_user_data(sk);
> +       if (!smc) {
> +               read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
> +               return NULL;
> +       }
> +       sock_hold(&smc->sk);

If you must take a refcount, use

if (!refcount_inc_not_zero(&smc->sk->sk_refcnt)) {
  rcu_read_unlock();
   return NULL;
}


> +       read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
>
>         if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_=
hs) >
>                                 sk->sk_max_ack_backlog)
> @@ -153,11 +160,13 @@ static struct sock *smc_tcp_syn_recv_sock(const str=
uct sock *sk,
>                 if (inet_csk(child)->icsk_af_ops =3D=3D inet_csk(sk)->ics=
k_af_ops)
>                         inet_csk(child)->icsk_af_ops =3D smc->ori_af_ops;
>         }
> +       sock_put(&smc->sk);
>         return child;
>
>  drop:
>         dst_release(dst);
>         tcp_listendrop(sk);
> +       sock_put(&smc->sk);
>         return NULL;
>  }
>
> --
> 2.43.0
>

