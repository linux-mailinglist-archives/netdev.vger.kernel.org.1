Return-Path: <netdev+bounces-274636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMQJLn+nzmkgpQYAu9opvQ
	(envelope-from <netdev+bounces-274636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:29:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215138C84B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A633302802C
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AAE371055;
	Thu,  2 Apr 2026 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVETSoxY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238730E0E5
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775150649; cv=pass; b=KCugR0wCF7avqSkfRbKHdh+HIP+KhVqdIEM7oEry7ITJaLmkjjrGf6vRYLbDFA0vQB015GpxDvquJPYp4snV6NLBsxj6IG15Okv5j6sDZqjbHQdME0J3+ktfpfri/swlhVlYkGUyfNXSeZweCZb6CV6k3O1sE0IlKFAiOTZDkj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775150649; c=relaxed/simple;
	bh=GmTOz63CjjNnwPvUynaJmyNfPQyf9rdnijnUUmNurQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4Q/7GCx5pP0JqQnXfdp9fzD92A1o5cEu9BK1OKXdR4GS2ba6dk0tN1mmZvU4046UVFK9RlfLnIAj56oEL7UKCF/EjnxhodmWyWTBJOC02kyEWhpCHeNSYJoWX8k/Pnmu9HyiEz91qZV80YmTZmCdtpdFy7bmTKkx0oTNiVYBAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVETSoxY; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1273349c56bso1494876c88.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 10:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775150647; cv=none;
        d=google.com; s=arc-20240605;
        b=T7kDDuqoC6fWALJ8vfZ2KS7aK4gqGRCJI9b0MCOfRmpKb2EM0DxGHOg/+eTJfMJsQY
         v9ahTkjrEoQOxEIqnafUIPiBZvpdyKV/5zIkF7Dk6E74yf1q33C4f6awHm17zeo3Ecq/
         a7C/BnpBXg+atdO48/tZSWeYFTKR9tWbp04EUJ9gP1wQbQI/XGRWg7UV73+iQf4aBh6D
         9Ib3vIHsT4u32JOpsXfbsdrIAPwIcVvjifWXYYUZ2V4THu2yXnConGh7B3IZ5V5xCs9C
         oHJspD/U4K76NRhBrCn1ePWRlxGO4jHiAJpMimomPEadNAyibjToWS9GEM8dQf2+YGi3
         vc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MGdK9uBWaQFJrzrBAhj31vEGGDLY8Xcv6XnPO/Im1ko=;
        fh=TCzpq9FuoaKj6dqHENrRUjNR+AVcadkv0ImYrKkTbXc=;
        b=C5PsX7LAowQg/AMOpyWneVcCw7AJ6J5jcaPZkaaica6GyZM9dlcg/5+GacdikoSirh
         vkxH0xRhi5n1vB2CvxzgqJOmZgu0am/Tj3hctqOehtXeAoI9xCVRfuoLbrvoMrnUceht
         Y3R+SfD+2jL3oHf9ZNTTvOaw2Nrq0vc8vEBKRg2LAEx6TdeGqZ20wn0FbKmUgHWaiNGl
         oRRm5gY1hsxRJUQP7bP7PMVIZEPq7YlGg80Ex0h6bP0HwfnD7As+8VcVtXt5gNffcGnz
         +ffAnUV2H8iIgkmRLcPmX4hVhHSsSTkL547jCz68Lzv32AeW+RWPTnHNYAbKYTPh42ah
         TR8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775150647; x=1775755447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGdK9uBWaQFJrzrBAhj31vEGGDLY8Xcv6XnPO/Im1ko=;
        b=KVETSoxYryiYMWBfd2JS0DG0XZG4vEf3Fdtz3cQtdhn99eujidRsSm3TtN47r02826
         Sf2hgYSY6stx0UzMQHKBHb7DeQ+UQO+0Xz+fZKP5j819LxptRcLynBKC4weDVMSzlUuA
         59VV22NrTwBKxiiyfzhBUt7vD5vIRrHtQWdL4O31inQNiBwpLU8mwQOjhfdcmFKo+EQb
         PtRcBXOaTNe/hgn6o1xwZaQs+dkUVw5EyCU00pXaVCcJsqCM7k5RjM/k6RB5yiuqu2bQ
         lNhbswkXPbGhB/kEyEVOLlPD/uwV2NW6u9PYSO+2ZzIGfSTc4+ce7fdR8RVxCgADoi/k
         +8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775150647; x=1775755447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MGdK9uBWaQFJrzrBAhj31vEGGDLY8Xcv6XnPO/Im1ko=;
        b=CIOXNFHPP0QjuUErltTFrBQfpf/YWpCffY5YSh0+qC2MXqY1yavpInXAfXpL917JA8
         no6OBV+GzXJ4fzx7ZngzFZnHkFZEx0xq2gEPtubhbLtICAor5f0RHmwYsnAdMvIBq9sU
         feYjGul6d4h7XShkb1p7jwhYr7eBmC6xDH16NiVMp6PnI3XwsGdBbBX4BqW4eqFwcTSE
         fbv74iin2IonwgD3WjOBZQmBN5QGm0AXXVIke5rmsLxGyuNuqMgt/q7vP2929MqH06Ju
         KuQLn7LMO2IE+Upgb7+r3yihXZ2GZFh6EmD9zlVD4STFO98i3rldMuLLuCyKBjcBiGd/
         t5uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhqFPBpHIix9MM4HPKXNTC084v4Q6PGJIDKbP4wNu/+laWSPTjSuZ02r/TRnV9slrWS3UDFp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjF6amHY73Bqy6V/nBZb9o6ZetL+Ov8FfV+zdDiIcAe0mMEM9l
	BeK50Vx4/ID2zE0Hl5q/p6cUcU4LKWRjgkQrSs4y1Q3EH+lvdI0SMZ1xF2tPADL38WWiZGiHgC8
	YBscM1k6eAb1pr66v2zLaeAZ53mhQDiOyQ24Pg977
X-Gm-Gg: ATEYQzydK1dfB2VeThWebcFGB2OdJ/frVAmUhCfmhQLzZC636EEghZd6WcE630GStX6
	76YEbB5EUNi0Dxi2vcJx2rc0dKgNaWX+Wma1ZEDLg3dEQyrc4rqO13TS3LqQR0LeE+Wuzjf9oAQ
	bvceTXLuGFDdo9Tv9vOV00AFEPdwcVGjjUABr3SegU5bTg3aifkWJmmjPz7ns338qZfBLCSs9/O
	NPOS5OLb10m8Cw5WhFDtB8r0jJdscooDVrPP/cq12hnTIDdMQcPu+XDYHfKwH+NfIngPq289y/B
	/vdBeAdz1NpPfETTwog+JO39nq980tRkFhFMRGY2JzyIfJbWKu8MGQOpevyfj0fU7B03iA==
X-Received: by 2002:a05:701a:c94f:b0:123:3488:899f with SMTP id
 a92af1059eb24-12be6519c10mr4248175c88.32.1775150646649; Thu, 02 Apr 2026
 10:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402050928.32946-1-kartikey406@gmail.com> <f64c57ad-c162-480e-910a-e7a5a3460104@linux.dev>
In-Reply-To: <f64c57ad-c162-480e-910a-e7a5a3460104@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Apr 2026 10:23:54 -0700
X-Gm-Features: AQROBzCGH_diGpPlCLn8lJeTbdIZpGJLDfsG4ZjERFe3Vm2HfWlunO9yF1a-KKQ
Message-ID: <CAAVpQUCj2O8zPHPNwU3qkcLqz_iSmowEgxOFX2JAM5JNBqG7gg@mail.gmail.com>
Subject: Re: [PATCH] udp_bpf: fix use-after-free in udp_bpf_recvmsg()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, john.fastabend@gmail.com, jakub@cloudflare.com, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, cong.wang@bytedance.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274636-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,kernel.org,google.com,redhat.com,bytedance.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,431f9a9e3f5227fbb904];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 0215138C84B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 11:03=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 4/2/26 1:09 PM, Deepanshu Kartikey wrote:
> > udp_bpf_recvmsg() calls sk_msg_recvmsg() without holding lock_sock(),
> > unlike tcp_bpf_recvmsg() which properly acquires lock_sock() before
> > calling __sk_msg_recvmsg(). This allows concurrent tasks to race inside
> > sk_msg_recvmsg() on the same psock ingress queue, where one task can
> > free msg_rx via kfree_sk_msg() while another task is still reading it
> > via sk_msg_elem(), causing a slab-use-after-free.
> >
> > Fix this by adding lock_sock()/release_sock() around the sk_msg_recvmsg=
()
> > path in udp_bpf_recvmsg(), consistent with tcp_bpf_recvmsg(). Also make
> > udp_msg_wait_data() release lock_sock() before sleeping and reacquire i=
t
> > after waking, so it can be called with the socket lock held, consistent
> > with how tcp_msg_wait_data() uses sk_wait_event() which does the same
> > internally.
> >
> > Note: syzbot testing shows a separate pre-existing warning:
> >    sk->sk_forward_alloc
> >    WARNING: net/ipv4/af_inet.c:162 inet_sock_destruct
> > This warning triggers from the idle CPU path (pv_native_safe_halt)
> > and is unrelated to this patch. It appears to be a pre-existing
> > memory accounting issue in the UDP sockmap path that requires
> > separate investigation.
> >
> >
> > Reported-by: syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D431f9a9e3f5227fbb904
> > Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> >   net/ipv4/udp_bpf.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> > index 9f33b07b1481..f924b255cee6 100644
> > --- a/net/ipv4/udp_bpf.c
> > +++ b/net/ipv4/udp_bpf.c
> > @@ -50,7 +50,9 @@ static int udp_msg_wait_data(struct sock *sk, struct =
sk_psock *psock,
> >       sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> >       ret =3D udp_msg_has_data(sk, psock);
> >       if (!ret) {
> > +             release_sock(sk);
> >               wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> > +             lock_sock(sk);
> >               ret =3D udp_msg_has_data(sk, psock);
> >       }
> >       sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> > @@ -79,6 +81,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> >               goto out;
> >       }
> >
> > +     lock_sock(sk);
> >   msg_bytes_ready:
> >       copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
> >       if (!copied) {
> > @@ -90,12 +93,14 @@ static int udp_bpf_recvmsg(struct sock *sk, struct =
msghdr *msg, size_t len,
> >               if (data) {
> >                       if (psock_has_data(psock))
> >                               goto msg_bytes_ready;
> > +                     release_sock(sk);
> >                       ret =3D sk_udp_recvmsg(sk, msg, len, flags);
> >                       goto out;
> >               }
> >               copied =3D -EAGAIN;
> >       }
> >       ret =3D copied;
> > +     release_sock(sk);
> >   out:
> >       sk_psock_put(sk, psock);
> >       return ret;
>
> Kuniyuki  is already working on this. Please see the
> existing discussion.
>
> https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/

Oh I almost forgot about this.. will respin shortly. Thanks.

