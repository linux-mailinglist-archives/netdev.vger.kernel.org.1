Return-Path: <netdev+bounces-266118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG57MrwhsGmCgAIAu9opvQ
	(envelope-from <netdev+bounces-266118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:50:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBD6250E18
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14A7D35BFF67
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93AF3B47EA;
	Tue, 10 Mar 2026 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qf6uGOi7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238813B38A9
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144830; cv=pass; b=SQi6sF0Nc76tsN+QeTI36kDwuMoV1+StYeUkqoFTPWmGP1jnDjL9DbtE8DP4KhwFWDxl6PGyvT/xzB/vx5bBQxI3migvUE3ABEOkdeSQJahwKygOqNxtraewezMtbRIoJgBgFZ2NYnIwWIofugmRoU5rQ2MKLPgspKb6T9ixb88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144830; c=relaxed/simple;
	bh=oBWHWl4oFG4ctqngCJNsL2W/w/X/y+8sHCgAIJblmFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwSoXUm2IfQFULTw2DM10aqvnw489Zh+2hS5aDMa5KVaSfCuIC+fl3kjqqavjJv0XEmUeNwyC+cXr4edIEBnOoels1q3ANqNQND9xr1NPhKYEzIPYgiyN6fWsdPpTAmewcUhD6qHGisjMaDJKX6NcjC9kkv6pFumcDErgPYV8v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qf6uGOi7; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89a0d53f3d1so84744956d6.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 05:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773144828; cv=none;
        d=google.com; s=arc-20240605;
        b=cxt3sgonDV7wS1AoUtBb4TykEYJPlmUnIGZo0/3Wf1yNJrz5HXFVWPHFiBQitRT01M
         IhQleb3Qayvl+pIGVHeXd+Jlr7yb2DCeaKhckdSM1xBorH/iokuLIbDMMR0Fdw1YAIfq
         wpFYa77ZMbz54a7Z5L0uSkVXmtsDZW1JpGvkD5W4+yboE8MUV46Jy/VkJ6cEQEKA9ga0
         Px3QtjNxOsSFHv6x/1lwD0mvk1OGqVjGws0YQYTt/l+RYozv7BoGy+gDesiqmqa3kVvh
         ZM/VSgsaS+FRi9JmlSFzcfO+Z5qsqIgKKbQjs9pTY+E93/02cKyFGCGJs0RHh/riufPO
         QEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aNlD1VnwwuWUuVdK0r+JEQho3gk9Img94yEEgNc2T2Y=;
        fh=SpShyiDWPc+68xSBqGS8z3Zg9LktsyTAiqJxmANsk00=;
        b=I8Y+F2u4vU5G/VoD2nnsNnRWA2VuJpiuUeGWGmA+FJDfl20aVkBVORFHKpv86uri8g
         TV3CKJJ5F4ZM/3oRfii3ua3Nck3Gwx9AGD8h5KZPgZ1pOrnNVCYyvH8nspkJ9qFSfLog
         5+SQ8TMjXvnTVHtde4hWwKtYcXPu1VzPY6y84QF3dHdRPOAP4x7SGd5BQm6vYPOIEtLl
         KglBoA3rvBBgDoeLrxojIKOVKZ1xbwMjWrr3wYZsjA+9jSHzOoacc6II0dNIRqgcosk0
         FJ/7aTXb4EI/qaQdGlm9St/RP6cgrwIWZV4mCCCseOADQbxuCFAk+p184OirZIjvq81g
         q0eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773144828; x=1773749628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNlD1VnwwuWUuVdK0r+JEQho3gk9Img94yEEgNc2T2Y=;
        b=Qf6uGOi7YDhTAg2wqxZ2yfGHJ4hzAHx8ToJNEw3pxlLhDTBJbvjvysxSb7Z7xPwoko
         V12L0oqtIM23astGiRTGta2bljIhDOuSI15VR3mN0qN14HcAWhni34g6E09MApOPR5q7
         oAaaAMBDGNoYYMxAlZqPl1gRS6xl4isMN44PcNxmagXTeMC8jpNjYaXK3n/hnLthiTwE
         U+XACYDeQyVL/NypQuRjBhLmAUaWxeCmZmpoRAUT0gQYsIFsayo0jHH8OLt2Nzhg9/g9
         v4jIZwG1WKVlAStQWkO1QmpeCo3arE63uTEUoCV2eeag8nqtLbvyeiD6RQhOmL5XxUJQ
         HY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144828; x=1773749628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aNlD1VnwwuWUuVdK0r+JEQho3gk9Img94yEEgNc2T2Y=;
        b=jcgPXXCObiQ7Xo4+OPjwUR06FkAIi9QMikDhk5EChfmya/l+Kn/XoiWClG59WjQXcY
         eEOf/VQBqr8+FGD/Yrf9RVsnXd/ezs1B/C1c6YyheZUr9PfhrfQQFoWH0YNbnAe0Z+2Z
         86UbhBgSUKqlV16lLtskQUyCC8zizjowEA6cT67TZ4kLun5vlOY2b2ovGF50tXr7ANTh
         OLMd3WdabGEAqdRRy7Q9qxRlo8ZLIntO//QwzbT49/qb6rrRZWi0O3+MaIid8KxOXTJR
         01gV8O4NKIMTO+f77T7poRJnJWVafVFLm1MsRsfsrQBnQtRBf6jBwMGliVYQ2hcdRjef
         j9pw==
X-Gm-Message-State: AOJu0Yw6lMhQDzSgz9BstaBmZanwLPqYCtTz5G/vdf3SEwZqRfWMEjNw
	ZHtHFdWTbVG06F2VR7Xv968+YbRxRTLTgOm6A6JUR6EhS4hMKy0Hc4lMVmzHYjdCVyKEUNadHpZ
	CLUtYU5FI3378fIS0ZBwzmZCJTIzvIUlNM1sK7XK4
X-Gm-Gg: ATEYQzwzfQEUUTgg8RWhB990ZhJkoR2mYkFoo3d2cncNijcijJ4WqijiOQ+QfRADLXz
	PxjHqno6qnaS8CfmbvDp5Y/pVPpJJlMSyXMBeJ3/GqnYGkUXvLHKwZm89oHoAVyiWhc5eFSMSS9
	Leb918kPnYszsZbu/qbo2wewjw5vP1fN/XhQNoNyzm0C0xSpvHzDLbAdRw83fRSzobNohVmTfGu
	9LP1Yvm78Hnx8IZuPWPOXIyVgAbsUWIwaijhWbce0Nbi0ncUEm8Gl/yVniBE8KVpqypw/YCmYUD
	hRq1YjU=
X-Received: by 2002:a05:6214:d08:b0:899:c803:ca2f with SMTP id
 6a1803df08f44-89a30ace932mr206169286d6.42.1773144827562; Tue, 10 Mar 2026
 05:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310120053.136594-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260310120053.136594-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 13:13:36 +0100
X-Gm-Features: AaiRm50qCXqay-aJR-sI5Vzv5JmvJjTgCTUtA-sXdrVxWvAsiISg39w7gsRzpcw
Message-ID: <CANn89iK-Kj7Gthff+Q8vSUDTYs9t6YZepm5uAv_2ZZJ4AkyxOw@mail.gmail.com>
Subject: Re: [PATCH net v3] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
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
X-Rspamd-Queue-Id: 1EBD6250E18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266118-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,827ae2bfb3a3529333e9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,shopee.com:email,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 1:01=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
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



> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 9e6af72784ba..8b3eabcdb542 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -342,8 +342,7 @@ static inline void smc_init_saved_callbacks(struct sm=
c_sock *smc)
>
>  static inline struct smc_sock *smc_clcsock_user_data(const struct sock *=
clcsk)
>  {
> -       return (struct smc_sock *)
> -              ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
> +       return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
>  }

Are you sure all smc_clcsock_user_data() callers  hold rcu_read_lock() ?
In order to avoid surprises, I would have added a new helper.

 static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct
sock *clcsk)
...

to allow gradual conversion ?

Thanks !

