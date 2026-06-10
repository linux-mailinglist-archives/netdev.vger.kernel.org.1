Return-Path: <netdev+bounces-297779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bOLWFdqZKWrhaQMAu9opvQ
	(envelope-from <netdev+bounces-297779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:07:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E760F66BDA9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:07:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="SmF9/Kuf";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297779-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297779-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5A73302D4D7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9E2550D5;
	Wed, 10 Jun 2026 17:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F6345CA3
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 17:04:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111061; cv=pass; b=Dw7mrgCpuKVWeRl9cwXii0WDRGxvxsScjzS6Qc2eWZnsJiU0vjR2v4r85u/ynfEJtP39bdjfxhtVeuJCQoECFtKccZT9GU9+49ODrW7PdBAnLcZfXhqL81opCQo06Nl2ppMfkzjAXfdwBybg7rhjd1VYldU6AJdVIn8O0LrfD1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111061; c=relaxed/simple;
	bh=vuKfEEpTx2/k/Y3NdmnH95Ztrzn3afNDVqcCb/pW8aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nf2o41tdtBIWUU9eFYQH8Lhwi1FynJddHaFo6KPLGAU2WUIQn4p8PGZdnbCjEx8m6xg2MlJRMxVq3pQZ+UE6SpBOwMpk16qlHicaCAVB4KpK3/IazxwfuzclcU8MxbldL89NS5YRnLTN5R0N/CiZJ8FBo7EgoVJAKib5XnMyezI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmF9/Kuf; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5176465a4a4so93645391cf.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781111059; cv=none;
        d=google.com; s=arc-20240605;
        b=a4zf3JEvDSgrYuH6Msm4SjuJrosqXEu4AeZXQNxohsCZUYfHO+v/Jl5pWN8Krde/EI
         Uq/u9QkPnWuKpr0v4+gBfRHqzASiPPqpEDgBnPm5CV+NP7XxLLhCp8nTbBH6Q0KzM5Zo
         pLG/C6jLW+ZI4R+tQhP+QaNvZflvYENGdHNDBFihHrGx8rZKdHFx4a7MOc1XP00WLx/2
         JDD5UXEdUImmIXCC001/l11OE+zT6z8WRZrDn+VJpBiNZSXkECUJr3cvO5pjkQKYD+nU
         Eu+Wh8zGYMi54kZlza9Pq9mCMZHVGqea5JsXAm+P63GmPM6piIUXv5JonPeV5b+lakDR
         KRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WZI15obymzEuMmJ7t7sa2/wsmzaMOqFuHrBVfocq66k=;
        fh=i950xXIpUiwUTPHj4GN+nmInusJ+QSpyA3YKv8Okhyk=;
        b=GRhzO9l3mfdlKY6ES0YvH0ll6L0UyYLA6qPqPCaHwe/2gwVmDViVl4/KBggS1h4V/R
         qvO62Bb2pOIHi1SPm2fncma4WfJxI8HENmoI5rvI/1EsEd6+ZXac+IFGxH+esJUbvuz9
         t/BEZ4iQF9GiGWufr4qUlgh/pTI9KsvxQ/M/sRleQEsIxlFs+xJv0aHYZmm5bqQ11tKC
         Q0+RWfh09VTVDbGtsO6g5HDvZpJ+Iriw+wQwOJnAPkWhc2rS2Jo8tPIV6wVHQkSVwOww
         yOCaA8FH/6GutSYYa106DQgEzusg8mzRCREF1jUoqnP9x2ldTbJiIBGw6Z4aM+6qX0YW
         /epw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781111059; x=1781715859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZI15obymzEuMmJ7t7sa2/wsmzaMOqFuHrBVfocq66k=;
        b=SmF9/KufCtABldjUvWnAO2zyuBKuLF237kcH/n2IyppBgiXE9mnaE4isvavrigacMV
         AeUVEv6fNBvxSHGccpgpWu4xJ0DEnPLs4Ph9a7mHaSKugfa1JEpC4XeHPGWZPKOMa9CT
         QVCgPmumYdCWsJoK547C20oGOB5DV8zmoUTPsCxaZ8zTYkI4dK/UvgHfRk6OQ35PeHkF
         D4brGi6jpXx5CKOii945fWzgkaZV1Qs+zaCgTf11gZe0DaM/vafirCzEFypUU8AX/yHO
         d9B0NjN8gevMFSrRvWvLQWJOBvWSWjEzOQvIUaqmo8Uzjuh403poS6XvDp1GzIpZcFAa
         MZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111059; x=1781715859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZI15obymzEuMmJ7t7sa2/wsmzaMOqFuHrBVfocq66k=;
        b=oJ52HEV+lxTvVko1tlU9IxeQbae10WmUHe5FXzwhc/gzsVSzlcC/PG2EWdzsku3yIX
         RTkHep5x/hM+rY6aYPOFzY2tDVSSaBvFtvcJyfTmswDKryOQbiJba/7CapfX09R36IvF
         5QkWrneGJ+ITzb0XQzGTksZ+FjAWYxTolSKWuWN4qRXJ1fWKqOpuJCCUivqikn2OPDZ1
         3ZEFzF2Ejlayt0voRwIPYc7LB0OC2nDUXdh+B2dD8S9BdOpve9TykNPnkh946KRptghw
         9u2t1Ysv2AHkCC4clAAl4ix1gqkiB4nHS/4k31j3eM02pEZXvaNT4ireVWOY7m03yRh6
         niMQ==
X-Gm-Message-State: AOJu0YzKyUwfk7tNoc16BozSjJp40DwTKUspEaPTMjbnz31pI0qG0pYT
	Eoq70ELkguAqDX4PQQ/iXBIrQBUz51LYnCpr06S72kAtR7a6D1v7VMVje/PeSaMPf4BWLyzck8h
	qJ9AcEu3BL5JJLoyvHUTJQnJLD+unR0zA+zC65aQj
X-Gm-Gg: Acq92OGkgwGIKrdog/QBmTETOKF7CKCIIBGkLrkLG8RooFjOhgs1Ct6xlovbob8VWCs
	j45Pk5I8S9oC4GD9ev90WBePfLdFUiKXXIypGK43pHpM8QRxmHwHSSBaUvh37VMU53/PRWIzDid
	yXfbSPLw95OHSwGNOiQBSoKh6BNbh/uek6Vz+enoKgF0r3H44sQ2bHWoyfzfteMr53CSllxWeAr
	SXzDYLEXodmFgHfQUUHoEZmJS5TDOOk4mUTJ+6o0CglHj5Vg13MdQdD3bbqt7hwsnCt4Ha5ysqG
	dSn5S9jQUAE0VG8pnMTkC2auGNekwHHGAbHgi1BlpsAL6onLsZrUbGpeufyMe6ziiuYBC1t3HaH
	FDsyn7UXZSdVdnwIZTMpT7b44skdR+g==
X-Received: by 2002:a05:622a:1f18:b0:517:9095:c31b with SMTP id
 d75a77b69052e-51795c919c1mr382019671cf.42.1781111058719; Wed, 10 Jun 2026
 10:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780979031.git.bronzed_45_vested@icloud.com> <42cd30856907350e1b3834a3338364f9828a307b.1780979031.git.bronzed_45_vested@icloud.com>
In-Reply-To: <42cd30856907350e1b3834a3338364f9828a307b.1780979031.git.bronzed_45_vested@icloud.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jun 2026 10:04:06 -0700
X-Gm-Features: AVVi8CfyH9ri5qFbFWlefnuPYX8Ybf70kG37kG0vz3tpARbR8HvYraJdvpb-xJ0
Message-ID: <CANn89iKLKNGE0aqyuCdxTBbRGWwAM0vCup+AL02u1UB-LrTvSw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: ipv4: bound TCP reordering sysctl writes
To: Ren Wei <n05ec@lzu.edu.cn>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	chia-yu.chang@nokia-bell-labs.com, ij@kernel.org, fmancera@suse.de, 
	yuuchihsu@gmail.com, idosch@nvidia.com, herbert@gondor.apana.org.au, 
	yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:fmancera@suse.de,m:yuuchihsu@gmail.com,m:idosch@nvidia.com,m:herbert@gondor.apana.org.au,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,nokia-bell-labs.com,suse.de,gmail.com,nvidia.com,gondor.apana.org.au,lzu.edu.cn,icloud.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lzu.edu.cn:email,mail.gmail.com:mid,icloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E760F66BDA9

On Wed, Jun 10, 2026 at 9:18=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> Reject invalid `net.ipv4.tcp_reordering` values before they reach TCP
> socket state. The sysctl is stored as an `int` but copied into the
> `u32` `tp->reordering` field for new sockets, so negative writes wrap
> to large values.
>
> With `tcp_mtu_probing=3D2`, the wrapped value can overflow the
> `tcp_mtu_probe()` size calculation and drive the MTU probing path into
> an out-of-bounds read. Route `tcp_reordering` writes through
> `proc_dointvec_minmax()` and clamp them to the per-netns range
> `[1, tcp_max_reordering]`.
>
> Apply the matching cross-check to `tcp_max_reordering` so the existing
> invariant `tcp_max_reordering >=3D tcp_reordering` is preserved. This
> keeps the fix at the sysctl boundary and avoids changing the TCP fast
> path.
>
> Fixes: 91cc17c0e5e5 ("[TCP]: MTUprobe: receiver window & data available c=
hecks fixed")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/ipv4/sysctl_net_ipv4.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index c0e85cc171ae..c44afb9c321d 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -215,6 +215,40 @@ static int ipv4_fwd_update_priority(const struct ctl=
_table *table, int write,
>         return ret;
>  }
>
> +static int proc_tcp_reordering(const struct ctl_table *table, int write,
> +                              void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +       struct ctl_table tmp =3D {
> +               .data           =3D table->data,
> +               .maxlen         =3D table->maxlen,
> +               .mode           =3D table->mode,
> +               .extra1         =3D SYSCTL_ONE,
> +       };
> +       struct net *net;
> +
> +       net =3D container_of(table->data, struct net, ipv4.sysctl_tcp_reo=
rdering);
> +       tmp.extra2 =3D &net->ipv4.sysctl_tcp_max_reordering;
> +
> +       return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> +}
> +
> +static int proc_tcp_max_reordering(const struct ctl_table *table, int wr=
ite,
> +                                  void *buffer, size_t *lenp, loff_t *pp=
os)
> +{
> +       struct ctl_table tmp =3D {
> +               .data           =3D table->data,
> +               .maxlen         =3D table->maxlen,
> +               .mode           =3D table->mode,
> +       };
> +       struct net *net;
> +
> +       net =3D container_of(table->data, struct net,
> +                          ipv4.sysctl_tcp_max_reordering);
> +       tmp.extra1 =3D &net->ipv4.sysctl_tcp_reordering;
> +
> +       return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> +}
> +
>  static int proc_tcp_congestion_control(const struct ctl_table *ctl, int =
write,
>                                        void *buffer, size_t *lenp, loff_t=
 *ppos)
>  {
> @@ -1058,7 +1092,7 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .data           =3D &init_net.ipv4.sysctl_tcp_reordering,
>                 .maxlen         =3D sizeof(int),
>                 .mode           =3D 0644,
> -               .proc_handler   =3D proc_dointvec
> +               .proc_handler   =3D proc_tcp_reordering
>         },
>         {
>                 .procname       =3D "tcp_retries1",
> @@ -1293,7 +1327,7 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .data           =3D &init_net.ipv4.sysctl_tcp_max_reorder=
ing,
>                 .maxlen         =3D sizeof(int),
>                 .mode           =3D 0644,
> -               .proc_handler   =3D proc_dointvec
> +               .proc_handler   =3D proc_tcp_max_reordering
>         },
>         {
>                 .procname       =3D "tcp_dsack",
> --
> 2.47.3
>

Thanks for the patch. I think we can do better.

Also I do not see a fix in tcp_mtu_probe()?

What about:


diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index c0e85cc171aec099fd5d4897b1a623dd27eaee08..987bc87e255a81680ae5e23ddd0=
1c1f0de4425ec
100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1058,6 +1058,9 @@ static struct ctl_table ipv4_net_table[] =3D {
                .data           =3D &init_net.ipv4.sysctl_tcp_reordering,
                .maxlen         =3D sizeof(int),
                .mode           =3D 0644,
+               .proc_handler   =3D proc_dointvec_minmax,
+               .extra1         =3D SYSCTL_ONE,
+               .extra2         =3D &init_net.ipv4.sysctl_tcp_max_reorderin=
g,
                .proc_handler   =3D proc_dointvec
        },
        {
@@ -1293,7 +1296,8 @@ static struct ctl_table ipv4_net_table[] =3D {
                .data           =3D &init_net.ipv4.sysctl_tcp_max_reorderin=
g,
                .maxlen         =3D sizeof(int),
                .mode           =3D 0644,
-               .proc_handler   =3D proc_dointvec
+               .proc_handler   =3D proc_dointvec_minmax,
+               .extra1         =3D SYSCTL_ONE,
        },
        {
                .procname       =3D "tcp_dsack",
@@ -1676,6 +1680,9 @@ static __net_init int
ipv4_sysctl_init_net(struct net *net)
                                 */
                                table[i].mode &=3D ~0222;
                        }
+               if (table[i].extra2 >=3D (void *)&init_net.ipv4 &&
+                   table[i].extra2 < (void *)(&init_net.ipv4 + 1))
+                       table[i].extra2 +=3D (void *)net - (void *)&init_ne=
t;
                }
        }

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6e4bb411dc041b2a299f0fbc2109c530afa2a345..193637a58dcc1acf8e70fdfbde9=
82c2a3eed290e
100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2687,7 +2687,7 @@ static int tcp_mtu_probe(struct sock *sk)
        struct sk_buff *skb, *nskb, *next;
        struct net *net =3D sock_net(sk);
        int probe_size;
-       int size_needed;
+       u64 size_needed;
        int copy, len;
        int mss_now;
        int interval;
@@ -2711,7 +2711,7 @@ static int tcp_mtu_probe(struct sock *sk)
        mss_now =3D tcp_current_mss(sk);
        probe_size =3D tcp_mtu_to_mss(sk, (icsk->icsk_mtup.search_high +
                                    icsk->icsk_mtup.search_low) >> 1);
-       size_needed =3D probe_size + (tp->reordering + 1) * tp->mss_cache;
+       size_needed =3D probe_size + (tp->reordering + 1) * (u64)tp->mss_ca=
che;
        interval =3D icsk->icsk_mtup.search_high - icsk->icsk_mtup.search_l=
ow;
        /* When misfortune happens, we are reprobing actively,
         * and then reprobe timer has expired. We stick with current

