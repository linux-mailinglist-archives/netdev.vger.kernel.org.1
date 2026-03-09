Return-Path: <netdev+bounces-265387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOhZOyV2rmk2FAIAu9opvQ
	(envelope-from <netdev+bounces-265387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 08:26:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5568A234C55
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 08:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21346301991E
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56561366810;
	Mon,  9 Mar 2026 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8gA2hRD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28D36492F
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041185; cv=pass; b=XuT49/aOaDBAxjx71cO4xS6Ar0SJMBh1qJLrIRpPZFMQ+wgq2gUph1ucD2E/KR0QkBZ/rMsbfU/ccI2ITJ4J8KxKdDrHvNiCpZT8SKaWm4PBEiuNvQHNLPJ6MNlZcQiahnX3T03HzT4uxSIvLcioxwFdA61U58C4q+DWq2UT790=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041185; c=relaxed/simple;
	bh=M0URNz+sYkeBXVx2U9Q0KCsD6TVHTuFPnbncyRSfgHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvv1PdR8tkTbRABits0logumOFlkj2qofz+CIsNGK/CN8NGmVFcMfgDeGQx3rVrpng3bD3QQiI9cQoyZ2oxrwc5L/puViKSXJvF2Lp04api7Hs/LfCucTJ7xoWPgHAlqpyx8y9ZXgCsSEbp/2cHL5F8DNNou+EY7bBhc4hXfyNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8gA2hRD; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899fc265126so104299886d6.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 00:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773041183; cv=none;
        d=google.com; s=arc-20240605;
        b=VgjCZq24OrSHNAd5gN6rmdqlFyOUA0z5Mz1MhbNdsPj6jBF9Srp+chopUChq4EcqrI
         0Vs06mrjdtcJheyvxcF4N3tGI3NUZ4lYYhQSH8jWGJYg/82AGuKxp5W99F+Oljg2iKKb
         Vcp9tCdsPdqfKAihOA/QKNDorYL1/SJJYZKgYruNFxQAIwvKwUtkGjT82V/RaAt9fsI8
         Hm1F9rnwFDvNJMMimwSSMRvQ9Lz9nIBuf+VQtYBjImuYNofZGqAr8NvI91sqeFpjbJ94
         sHCKApbPgX7HZ47Z7b2DfmngsEEysuJBLC7IVJ74wJi1TAXfwvHzyZixlu1hPPpD/zdG
         zL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u1ty6hSqFnrzRB3XG88cC/iwZTRE0lCfD8hBQNLJnIs=;
        fh=kB2QvoVzrYnMTh9y8zs37UvjylSFrDT83k91OzOeld0=;
        b=L6TWQqWmwTzlzvo2CeiohVbkqAetUkT0RYA29TxYaXlGvzAh4PbYMHio8ekrt8huu5
         apkAihZX0FR4dzhJ90RI3IlSo3zGss+eifyjzoXPCL07ZCm3YGSAEwyCrpwsmL5sZkno
         Gsei4L1j5kyVPmGIiPGoJuwtznuTtQ5Y0cNpyfeLIDAvlvH4TE6Byfn1dOAzrbQxLOEY
         QTM2e3SpNtiXH8mwkDKtRLRr7Eb4r17tDCXmlhAFe4I1QR3ntrI5sj7H+//oVHVglSxM
         mD/NX6mUWVl2A9RCw1EPkf59UGV/iLsRcwwpRSoVredaaReBQxMhGvmVdaljfCVClvsw
         2cVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773041183; x=1773645983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1ty6hSqFnrzRB3XG88cC/iwZTRE0lCfD8hBQNLJnIs=;
        b=A8gA2hRDnXgs5WrpwQi+dhzAd1zlZo1BTHX20WwOZZCcNbMBOnICESQ+Fq/yWGbA6g
         YeTcG7UcQaA09D9Mn71UzGkek0ERh2D0s6gBmJv8Hkozu1/iTJsCwdbJUIgZXFqV1yKK
         6Oem+hJgUeabaxe9lPEO4OTxyl1wSkuNb/GLmgKpt+sDc1TGpM37IY/j8jVazj/92v9X
         An3JnoNbj7JEg14eniv95GHWyhZ2OYyJT0wrlYMKEDPEHaM7JmQi81cvsiz25YR9+j13
         f2uBGSpdgR45fmVydvDkhrMQIOMvThU2waxnZ8GiK/Jgtzr+gyc80ZRsUjAmgUPNO4O4
         XCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773041183; x=1773645983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1ty6hSqFnrzRB3XG88cC/iwZTRE0lCfD8hBQNLJnIs=;
        b=suhIOc0Bs12xTRik/VRmnmVqdK0VT+df/Mk2dLC+ektgnQC0P+BiqmLi3u+AGxjWV6
         iIVVqDQ2Q0VPL8Wfx/tqHws/y4O8dwwu0zlluHmHO33RXw0HTQskmcocnorBj7xXsvzj
         mlmkWRbttytzythc6qP0xLc394ypnsFq7Gej7FeOFMPRi+cVOHf55xw8bVZptEEgXY1z
         uXuB6uLISSt0FHyZlUJjAGDOLikJXVE5G8rKdTwudiCyIE0SpycyO11pVxhXfivz2V4T
         rpBQcbXrpzl3Aaxp1LgGSBwwReuCl+a6zkfLN3hwJkd4ZlX+uJkiRAepw1bLaxjKysjp
         IJzg==
X-Gm-Message-State: AOJu0YwvFte1CVI+YonlrVU3+gcNxM8Hqaedac+vN1Oef/Ql/N9sgL9/
	G2FjX4ODCttDN/OPZ6dnLW58ZKSP8C45yUiVAQaWg1Yhzjjbbmw/pZKevRgva+SUCqUFfLjv9Mh
	rkBIBW0ZWgNtYb1saYIAx3Cc2AZTRAJdW+UXRZnyKjoAixBbwsURicm6nWf0=
X-Gm-Gg: ATEYQzzTK8u24XELKEhIFHDf4mr6OGfYfjGOD9wcEkhy2cVpWZs9JVZe66/K6z5S5Zg
	lkaMFPG8BUGXrVxcn7dgEDT96mbAWMvmvg37dO5yZb7IILaOE4JcViMufCA4W+iWeCfmNBdzNoN
	p0uVCDAgpnJVi1GW9scQ89XbpbPtWlRSaDl2u5aQkeoR1HG7XgsB63dfVqwJzewoVCOXwoyQxNJ
	49O9nsV5VIOlDTpbYVtO8sYIQSxJ783zl/etROCfw+hiL/AUMmFc584muT1HCbWknshWU8eyTdB
	ST2IVvQ=
X-Received: by 2002:a05:6214:2aa2:b0:89a:1536:2520 with SMTP id
 6a1803df08f44-89a30a7d461mr142404526d6.26.1773041182131; Mon, 09 Mar 2026
 00:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309023846.18516-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260309023846.18516-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 08:26:11 +0100
X-Gm-Features: AaiRm50o_e6zoBfA91A7V-Gnt9-tGRqpQxxbgPA3vagSfMfB5nBzBMx_MrJn41o
Message-ID: <CANn89i+H1vuKLMrSy7M4o_=gEKroQLSz9S5pKB2DJYSdPc_BcQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
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
X-Rspamd-Queue-Id: 5568A234C55
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
	TAGGED_FROM(0.00)[bounces-265387-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,mail.gmail.com:mid,appspotmail.com:email,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 3:38=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
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
> Fix this by using RCU and refcount_inc_not_zero() to safely
> access smc_sock. Since smc_tcp_syn_recv_sock() is called in
> the TCP three-way handshake path, taking read_lock_bh on
> sk_callback_lock is too heavy and would not survive a SYN
> flood attack. Using rcu_read_lock() is much more lightweight.
>
> - Set SOCK_RCU_FREE on the SMC listen socket so that
>   smc_sock freeing is deferred until after the RCU grace
>   period. This guarantees the memory is still valid when
>   accessed inside rcu_read_lock().
> - Use rcu_read_lock() to protect reading sk_user_data.
> - Use refcount_inc_not_zero(&smc->sk.sk_refcnt) to pin the
>   smc_sock. If the refcount has already reached zero (close
>   path completed), it returns false and we bail out safely.
>
> Note: smc_hs_congested() has a similar lockless read of
> sk_user_data without rcu_read_lock(), but it only checks for
> NULL and accesses the global smc_hs_wq, never dereferencing
> any smc_sock field, so it is not affected.
>
> Reproducer was verified with mdelay injection and smc_run,
> the issue no longer occurs with this patch applied.
>
> [1] https://syzkaller.appspot.com/bug?extid=3D827ae2bfb3a3529333e9
>
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@goo=
gle.com/T/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2:
> - Use rcu_read_lock() + refcount_inc_not_zero() instead of
>   read_lock_bh(sk_callback_lock) + sock_hold(), since this
>   is the TCP handshake hot path and read_lock_bh is too
>   expensive under SYN flood.
> - Set SOCK_RCU_FREE on SMC listen socket to ensure
>   RCU-deferred freeing.

This looks better, but please note there is something missing in your
RCU implementation.

You still need to ensure s->sk_user_data is read / written with
load/store tearing prevention.
Standard rcu_dereference()/rcu_assign() are dealing with this aspect.

For instance, the following helper is assuming a lock was held :

static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clc=
sk)
{
return (struct smc_sock *)
       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
}


One possible way is to use
rcu_dereference_sk_user_data()/rcu_assign_sk_user_data() or similar
helpers.


Thanks.

