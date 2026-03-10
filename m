Return-Path: <netdev+bounces-266102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEMKEEscsGkJgAIAu9opvQ
	(envelope-from <netdev+bounces-266102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:27:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B42122503D4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D66332D8AF6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF10C3FE35F;
	Tue, 10 Mar 2026 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qwj+tuCL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E13F786D
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144046; cv=pass; b=KZiPkcbGbGz7le3tCIU5iQGg06J+BaZhREHGtS8keb1zvdUQ7fUX4eFCIc9EIwqqQMXxZjjAcwSbCVHU4gLMBSMsrqHXR96g/sMICIEuAujuMqeOSK1nZbpmo6ul7mCZ4SnhPdGKFQLzBhxs0WpuAhBXQBcIkK5uSHgZwGZ//Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144046; c=relaxed/simple;
	bh=tUzR/Nakid06crM4rvRZ4qf7nSgbgsUvkFMtzxj2kjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1SrqutDXIx61gHtY0OxFW4qslXPmBSp/7qevIN/MyqS28SEuPtiV9yKDemg2fqhzE8ZzndnUC7f51BRlyVgw/JHzNcMMceAob1lb0espaGm5kmydGb8yLoaJDidq1vVU0Pu1W5D4ZkyJIdVFD7pH08ZQh+PQix4YN108D5w/NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qwj+tuCL; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cbb6d5f780so1288836885a.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 05:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773144044; cv=none;
        d=google.com; s=arc-20240605;
        b=d72MeCoOLFWQBdBB1H5XYJlYKJWOOTz9TMFGZbv+KEmUtspsnvN9xilFqCVsqvfa0U
         CGdDu9KFQEoUOB1rnwYIT9q3j31qkarwxz4kZ0nZoSuHZbX/xbX6Rmvc6yITV8ms/ByQ
         ojuYQbEyrx/qpEJZ9LKeMTWQJF1qs/p7+2JraqkVrammcRlzKmnxj05pLwfePjYtBXPn
         lrKOyCFJOSKU3MWdlo52giXCkk+ITU3OZuKTHrT7zMfrFzYlf78yQn+9i+t3QA+lxFnE
         +ZfECfrvrTal4tQUMjE84/bOKYBQE6CLBdNfHvOgSyimylAsW1LlXWunOorZmwApbveD
         KX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KiPLCC30cbrBmI3zXpnvU6YblX0b2+xRJJpwJf5O1Q=;
        fh=2NYeo+5ZY0Zcqc4t71KF40jTrerGlKxqKqQYcLtzHWs=;
        b=UeGWbXdYY0cDZT6n3qidjH9B4qmd7w0p9b4+30mmii7hpe3VTw22S5Zyzqevr7Jjru
         wqkDve3C17rdtHUn1FjjtMPhovu6BzHcUCL5Q/Tg2z1ZmEYQkHp3bLcZvBuyeZSzYRc0
         m+giaW+zyVtWKUW1kwsyv+zqQgspsg+PTseYN9zXxwMKWoqPkIUSR32AYu7HM04NpxMV
         s82H8Yk0z21Bfa4SuLz3q9DPcX5JTcR0N/PMAQPAnL8Gtd+3F98OPhE+HkRleuS34c0c
         5dGpIOc013ObObz5Jb65wXhhDPBfO4zzPhngBCwv0z/hcnwc3zQFEt+FFCkVTGX1U9n1
         QKGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773144044; x=1773748844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KiPLCC30cbrBmI3zXpnvU6YblX0b2+xRJJpwJf5O1Q=;
        b=Qwj+tuCLktJKd0NoRvrjoLMdfDN9uUn5J69tYo/ziS4U+8A9ezz8TvdBX2SWtr+1o0
         oVrumKUp0Zr06B6f07CBVqtxVIzVUHFpLnBrQ/iWqvCkNT/HPvlN1O8vOWrhEypQU8w4
         IWUQ4EpYm62MLVZun2Hqw7gFQSF06mk+wJoEu988bT3cb/S+/CkaYRoil786ZN+JHmfG
         nRdHS2JGd4v1x/ir5L/8ofnKCgwYyqtv769MzCapTxmDlXq5OoTHqgF06GbfTP5YpnZF
         tTtjQKbU9lAutMiUPerFYih1jbQIYxYNuOvmU25VyyIEIzuV6D1ua1CnW3jyDK41LJPm
         LpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144044; x=1773748844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KiPLCC30cbrBmI3zXpnvU6YblX0b2+xRJJpwJf5O1Q=;
        b=Xtxs1KAbpSwhZ/Aq4gle4lmZipddMBh4s4I6Qm+y8Kr2C627gjAw25O7+moNs3rsHR
         vyVFq2ozJatv1NjuotGs4Y7JvfmQVDd5C94zqolarHwwIiaPr+Cr3TmT+wV4qo9Iqxea
         j3MvRBQHRoN5JwuBxiuq48qCuOA32BIxKqri/YOclPQ5Y3jzLrECcnGh8nmFImf1btcT
         VQXpTFweXwOYEdl8WRNGsrrPMr/R5iYTcDpV1qAIig6THvjp/p8lt0jJIegij58/qT4w
         Av2kP92z9qI6snbUKVMM1swR4h4SV9HnqeRLMBNev2JfutQDSG+fDh6pJa/+5unOQKGj
         /JNw==
X-Forwarded-Encrypted: i=1; AJvYcCU8izZ5JgSzATvSEnz1CFojE/ZgDM0ZyCBXCdeupGsp/wjVeACBZ8YGGdULZTO8E1Q7ERMLM24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRey9ZTfKZ/XIfgMugr2W7ZhvKbDKIIQGF4qi9uqEwK8efLLO+
	/yS2edvCEIoM1aBBf/xe+vXDVwuTCoCxD9+g23uOfiJzc+TcaqZGmikDBQYqhInUTfeGIAbM8fs
	hk3Daz4Aklq5VGny9+IO9RhcK6DN4Cv/pw6zuosRt
X-Gm-Gg: ATEYQzzk4qVH+hM6pqiB5am3c/v1zqaaPQHiZydoGGkVHlM4YCmvcxdYiv9rZKohez+
	/jnDLu02+RvcYBN2BWadZsZ+EmPNpCHVIqXXLIasQLYsCu9K6cMWfhgCyYdqyxJPnfr6jwXQc5X
	mz58/HB7gASfK3q7yYaMv6hpvjuVJCz1AU67asYdlsyVZNf+hjVVLxzepRlMjkN3J4BRpfodO93
	63MthnHlAOEV33Kkv0XVcxqYd6d7AqbEbXhM2/+v5RvoHFnJhwkgH2FxjGrGOZMFYiZF0vTM4km
	rPycF3w=
X-Received: by 2002:a05:622a:1a9d:b0:509:22ac:99ca with SMTP id
 d75a77b69052e-50922aca02amr50931071cf.36.1773144042675; Tue, 10 Mar 2026
 05:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin>
In-Reply-To: <abAFRbJNinhN3O5v@penguin>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 13:00:30 +0100
X-Gm-Features: AaiRm509jDZ3zVYhIbanKsEufYLYkGg_h_Pmpop0SOjPwGN3a_7GxccBpHV9Ooo
Message-ID: <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, jiayuan.chen@shopee.com, 
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B42122503D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266102-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,shopee.com:email,blackwall.org:email,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:49=E2=80=AFPM Nikolay Aleksandrov
<razor@blackwall.org> wrote:
>
> On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >
> > bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> > check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> > when the bond mode is round-robin. If the bond device was never brought
> > up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> >
> > The XDP redirect path can reach this code even when the bond is not up:
> > bpf_master_redirect_enabled_key is a global static key, so when any bon=
d
> > device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> > interception is enabled for all bond slaves system-wide. This allows th=
e
> > path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> > reached on a bond that was never opened.
> >
> > Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id=
()
> > before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond wa=
s
> > never opened), fall back to get_random_u32() for slave selection. The
> > allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> > publish the pointer to the XDP read side. A plain read suffices for the
> > !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> > under RTNL lock and is the only writer of rr_tx_counter.
> >
> > Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to sla=
ve device")
> > Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@g=
oogle.com/T/
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
>
> This is Jay's patch + the unlikely change, looks good to me.
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Orthogonal to this patch  :

 get_random_u32() typical cost is around 10 to 20 ns, I really wonder
if this makes sense
for the packets_per_slave =3D=3D 0 or 1 case to haves this kind of
randomness in the first place.

Perhaps we could use a

static DEFINE_PER_CPU(u32, rr_tx_counter)

And :
 slave_id =3D this_cpu_inc_return(rr_tx_counter);

