Return-Path: <netdev+bounces-266548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDtjCEU0sWm0rwIAu9opvQ
	(envelope-from <netdev+bounces-266548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:22:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B67D82603EA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22D8C30585BA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE2D3C73FB;
	Wed, 11 Mar 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0cJQp38M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DC3C454C
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220660; cv=pass; b=kU7i0U7d2UcH+UhkWdH3CZYnESiHpdz4ei6PQWTnJjVfhq002kN9JwImH9sWTdd0d+wbA6d5Z7z5nT4ZlW3aC8Pdzv+r7ECAnHn28QNO2Uvs2AwWCO32c/3Hz7bBjM0bbZHMTlkbfjzsDCN4N0OVcQ19Raz1TTbZ249h4zzSaqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220660; c=relaxed/simple;
	bh=OxP+oxlWMBqbtwfC/PQBmjuD1E0cI/hvZs3XVNyH0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4gtzVXjvO+TJzNGZFF/k+ee1lVG97Hm5KMBC5qEz9iK3QsPR2owpMFCq9Tq+rvNETKkPM3FGeBMRW2md1xCMR+teVTBwiV6/n9UxRQnXQaXfvoVr2LF3mQTp8lOQyqhV70q5IHXVU8mTFug+1ke3oiLaxPS/87Qi1JeKUIUEEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0cJQp38M; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-509006c070eso38496461cf.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 02:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773220652; cv=none;
        d=google.com; s=arc-20240605;
        b=XDzotl08N9stGrfi6bEgeoT3KQpo0qxuMrRm838M/T62WJZbCrcXe+s/VpnE1magtJ
         CDmrcqrlbEs84H+fuY5lFcO4z8FNY9Lj16+fnxS/f/D6dWltWXDLNxzECjMdTT1/9WVe
         QNiWBdd1WCuyZ277JRJgZLqsKBcfq59QhMVwSsx2KHgizo+rOJ+7Hg2xag5dSyNs/Hpi
         VJ7QvhMRJJm2TLmMm1/aURUbWwBGPwry1Hm4XyAeoYVlnIZnFO4mPogVJLvwXIXLq0KR
         RnEZ6WG5wgCNlw1Dzscx4S210PenSsqc1IyQhzJXZN4CjB2cmuya63+y8IX2QM3vmoDM
         RQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=34kAm3z124TDQNJNDxrj8wJyj1zVsoVCIkxuIHo91/g=;
        fh=SpShyiDWPc+68xSBqGS8z3Zg9LktsyTAiqJxmANsk00=;
        b=hi5uqOhhNvz+HzvusMkDeNRy89H5k12Lscgb9GNYJTt4ii04F+CKvHiblY2gBzn6uF
         J5Wm0hff33N2irLsajvtHxKrZqtJahIs/JY5b45S8HqSraREwmZeCQsJ252nwe40FI3h
         0xqrtr0FxiOmAl6W1n3UWMQ4aAuIIHzqDdfrucpJX1Th90l1YJguwjZtnD9beGoq3zTr
         Yd7Ip7z+d/vgSBnTOp7LdDHUnB5H/vgLtQzFzY5ktKcO81UG2/c2qOHyRo+PRz4AtIEm
         pPyBEkhY1Kih2YGldi0qRGzJxt2yieOGPmAVGBXu3O0qHn9xAtATk1TQuNnXzns6GEIJ
         rUBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773220652; x=1773825452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34kAm3z124TDQNJNDxrj8wJyj1zVsoVCIkxuIHo91/g=;
        b=0cJQp38MAggzovUIISEwDjOMceCuoLNdTrcgauUMi9wfvxyw4OM/5Ipd7VMVX/E6XW
         zRxT6TVNYXk+Zkoi9fq55HDdRtoS+xXjxKaZbNV1VO/WnqVeXOAVQLK4mDEx8NJxhP9U
         HweUodg0iKD+xPYPsTnIvHnH7St0pbWHrlgKW2qvSnAqDYbYZEC0ZiJ+CpZGnR+NTjCd
         ++zxUjoUWHh3MiQbYJjog8VfbWKVKwLfCLxuxXpLyzu0ScNsYuQPYPZLnaLvMGKpWIH6
         jIDgZQEYz8qWwh/PStzOfQ/lEhl6yolU37GfRaIhwLKn0SqJ8ywx+5ZqLJF8ReaCInaF
         s6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773220652; x=1773825452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=34kAm3z124TDQNJNDxrj8wJyj1zVsoVCIkxuIHo91/g=;
        b=oLKfWJOdD0p5qApm5/FBovovypmJVRwuyZKppZs6WUdALu5+tluLBLfhXguyGkAQK1
         nmwHUg2brZaB+sFDJMj90V69ejzzQeNianzpOsM2ZZUOmHeG888chy7Rqr28EYyLl1ro
         nea7YNHX21Y6dsqEvra5jo0k/oPOzpfMLr14Ikd7YlhLj2Mj+9XiX4MgdMYvVKKIr2vK
         7EnokzpUWduGjqsesTmCtcpl0wj1C+sMeCgvUFc15roOq6gxDAq4Ns6NFAxlybhvu3e0
         mh0OTlt+BtqSntoKdWb3f1eUsKxcmsJQCICIGUV7FsLagAelxbm7zOjv3RsA/MHZ5z95
         0XhQ==
X-Gm-Message-State: AOJu0Yy2g7OHPiRu2KyKxs5SSGuZ6z/OK1fHc2t3zA4umn8ieUUzTDpw
	2qWopKSPU771/puFyUqrRObucC1plcaM+JXZS/AkW1cUL6gZsTIKe6vD3uZ0BZCx9f8yeOGUr0p
	PeOeEIdqB8JEZVJttWrjxaXY7yq8ofhCfkLDrVHWM
X-Gm-Gg: ATEYQzzR2Nw/7X3doEfTr8/j3RdkwPj9RkQAx+xfF3DZQTBktUjJfi+VSQ4nnNXponM
	fnR3OcEZnB9Fxh0kDrIpLwucvjIR7l9K5K3s0TRGTgnBBRLalHj8kf334IXlc5mBxTJeBEucfbS
	x32IP+weSNwcdJVrsyYyrQxeZ8Arz/wlz2qkHng2TF8Xu/Fr+571BwiXrhHCSU66qg+bLaPIhZr
	ENUzikcAAC4ofR9/H1OsTt979gu4STC3Ym+Av82DBa/gEOzodHaLvTJJZmYkeCQ87vuvxPI+HvY
	OyNbznYqz+pl+jbrueE=
X-Received: by 2002:ac8:7f8b:0:b0:509:3025:ff4e with SMTP id
 d75a77b69052e-50939fac746mr21570951cf.27.1773220651404; Wed, 11 Mar 2026
 02:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311022451.395802-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260311022451.395802-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Mar 2026 10:17:20 +0100
X-Gm-Features: AaiRm52u0CMFFt7ORPlVWQokL8IgQ6iecZLTd-DHcIzSTX7a8MIK-b_1wmE7h9M
Message-ID: <CANn89iJpjgEnsOfVuF0k4uERc+P4mwy5Tpu-hpSfcx8RGtWEKA@mail.gmail.com>
Subject: Re: [PATCH net v4] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
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
X-Rspamd-Queue-Id: B67D82603EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266548-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email,appspotmail.com:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 3:25=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
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
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

