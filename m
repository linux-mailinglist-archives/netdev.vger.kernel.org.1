Return-Path: <netdev+bounces-271785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI1zLzp4xGkpzgQAu9opvQ
	(envelope-from <netdev+bounces-271785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 01:05:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6147B32D878
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 01:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C79763012220
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 00:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF59208D0;
	Thu, 26 Mar 2026 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNC/XIXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFEB7081E
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774483512; cv=pass; b=cDhEr6vQTAJvKyuA2uSqKWhnu/txA5QVD+5mGVrbbBfQGVKbVpQDmP5po8N34g1bWWKMavCdlnvOtBdWAEy1HpptYTppTDJSsir83xDnY/t/RHpWVOYF5gpHHo1VUnc+TnztKWcJ/wFngTOeIVpTIbyWW5bfmkzKTxYPRWWcso4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774483512; c=relaxed/simple;
	bh=09LknHMDIYhGkY37GVaHUaDbkJkl2uyKia+bWoJPBlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGVZRMna6TOq2ERs2TCgguxaus2tazmBClUWCu+C5XwIO187hEER0mjdEMnkduXF1NXTssHeX1AzDI3gr4s+bCzSpN7/acIV43cSNSn7azJDnLb2q4giHiqbNZ2NGLDnq5y16rlq3bvFvhRxiqE29YI2KkN20yNggkRfAxeEZmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNC/XIXw; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c160308a54so913159eec.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 17:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774483510; cv=none;
        d=google.com; s=arc-20240605;
        b=LWO5R2XnCRYJc9eH5+seSnADWgbpWA8nhoHgf+ITVlnWEDqCb7ncG2M07JQfP0kaBh
         wwEwGlJdGqtm+AYhSFiVEfRV1kitYG9qcju7rrtGSNsr8B0KjULcBZt4QJoViJNG7I5f
         qzGETDSoisdX35CNpVBEoSzwuD0g6LeH+FwML0M1486XIDbnVTJV0aZ+oomSqtrxxCN4
         n4yEALvu4snqZMcJKMRW3CFtXaZT7SQaI/wy4uCzKzExek5sj3q5tFTodjMFxcIF4/zX
         XmiRn+8oim+Q9r1VvHcqB2vorOKQkTjIP6aeDJH/4HT29ghXyB+ZbvLwmPaJoEABxdQn
         A7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rOHw2g9ZBT/hyeGef6C4r595s8lKM1vTjJzS7pLxOUk=;
        fh=oFSGX8DyrHME5BXuHpea24KSkTmOFt6pbgAHKfHeZPA=;
        b=GXJZMKj+RyFlzhQe3iVcykVEZ/U/gGpaNokQuCwJIXTKKHb/pP5ohAur92JLmQAWyX
         mRFG+JVO/NjfWMMeZN2K5upxSerC5/LJjJ7ud7yBCETde4Vj6tcA7j4oDbcnNnOrI67Y
         CuzEJV7OvrccYHPf0LbEW4n0CI5d+EDq+7aZ9PT+tfV5CevGSOmTr/veNaRwQ/uaS10r
         n0hvsK88qPSbK6s3mOTH/NGwetXHVqXM09KZ/a+7Yie/I2pysL0ee7yMnoDbvLn31k10
         0y4h8k/QVAF01VT9OtAKQi0o8+AVWe1kkohBFQvl+fOu8g90IoHTx7WLpXZAIZLVb6nb
         vofQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774483510; x=1775088310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOHw2g9ZBT/hyeGef6C4r595s8lKM1vTjJzS7pLxOUk=;
        b=iNC/XIXwBdW6onX6kBucVt5AW0ywZEL/36nFVVNRw0BVP3zttsDfXrkqROE14rpnMI
         5vNplrBt7VlOp7jwsKt4HWW6mV15jqxZLVbK0AMUnmmD7LUeiqNjBusiRvNBI/fwf3Jp
         40ypgmmIVB4vvaFDQa4dRr2aqMt0oje1Yy7u3P5FxoKciEOCYiVrDPXvM6Q1OqaF2oUD
         HCLSQYB13i1gRAoQ6FQ3eu88/j47TDbkY5GWeiuqgYNLF31b8y/FuHAQCsK3Yqhl0n+B
         /Vo6Ae/+L4DWpLGc5aCi+EE4Zrc2+6YVCCilUA3njVOgjs86r6Oe4Alzd5FH9MgNx62w
         DOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774483510; x=1775088310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOHw2g9ZBT/hyeGef6C4r595s8lKM1vTjJzS7pLxOUk=;
        b=KiHj69I7Q8JcOyfTmYW1FaiNUdc8ziiTKCXCsqkIVabNVASVxMBi2TMOsDmprr5g0q
         XeF9pV6+NWrDh9bbranjRKPXtfNoi8JopV5Nl6F9S5xIzhP6z6j1mjB4oCsrS8y+HYEL
         CXPQr6qY9apIKomAdJmThym0qH4KKiqA1RNKRDvEDcMIVh38cRTjsxIYR9SuUEFa/P3o
         y/F7Vm3P7Dp6tI9cRMoIYWgZOl9ASywJlAS9xZ9coGM5J0aJd8SkmZ33vj7QKdT9RzwM
         T9crnJWstGmv7Ey4cvHt9+LPk5Y3TwOevMMRQYJMNvkwJ1zglKcgdEnivdOK4kNRVOv3
         w25A==
X-Gm-Message-State: AOJu0YzS+l6VMfegjI/AK918356qgwL3tx5KTlveBFJz5f9t3wPjw/FY
	5xne4v7w6loRgdCLvIBokwYfu5MMiyoOIZJn99ZPBbcwH+kw7aW/agOP9xFYrs2TTGbgbyLV9iv
	z2f80HnLU+A/qpEz/kn5GqdQbPO8e8lIjaB7PukDdI1wRq9T7biwr2arC
X-Gm-Gg: ATEYQzyF6caQfjnwZppYk1Pbvo6KAMhR/yqdd09QfG0QV0Y3t88OJRjRbIWpYYapTm6
	73crraoOxGgVIbPOSCHi0so5VXFnDmXVRFAhmOmlkU5imINSv8OKuLNnwPRbDA/OfTaKDBlexkD
	el+utloS6RArT651pHjdtguAyUNepUWyQUFkA9juzVRnKMGP09za+xQKeJpFh9U6aoI/1TZMZ4k
	GK3HtypYey3Sm6+P8GZ52z+GQpXIf9GJrJfwZJ8KVBvIAxY5xQvop7YEGySAzk2GOEs89P2+rzR
	gqcX+SbVwnOEpWeQHghQ0roJI1MTIKAN0XFsrzEyucfteeOFvKxP/E8sIpygpspa50+OMw==
X-Received: by 2002:a05:7022:ba5:b0:128:d967:466c with SMTP id
 a92af1059eb24-12a96ed373bmr2822619c88.24.1774483509090; Wed, 25 Mar 2026
 17:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323105510.51990-1-jiayuan.chen@linux.dev> <20260323105510.51990-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260323105510.51990-2-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 25 Mar 2026 17:04:58 -0700
X-Gm-Features: AaiRm52AA_qp46xzo-zT0U_vZFvFfC3jyAgRm4AjFmf0jkfgDvGqPT6HupdXIf0
Message-ID: <CAAVpQUDpkro_cA-vP1=L=NhAQ4WDPGdm8nVrUBiooiuji3kXow@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271785-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 6147B32D878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 3:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> bpf_sk_assign_tcp_reqsk() only validates skb->protocol (L3) but does not
> check the L4 protocol in the IP header. A BPF program can call this kfunc
> on a UDP skb with a valid TCP listener socket, which will succeed and
> attach a TCP reqsk to the UDP skb.
>
> When the UDP skb enters the UDP receive path, skb_steal_sock() returns
> the TCP listener from the reqsk. The UDP code then passes this TCP socket
> to udp_unicast_rcv_skb() -> __udp_enqueue_schedule_skb(), which casts
> it to udp_sock and accesses UDP-specific fields at invalid offsets,
> causing a null pointer dereference and kernel panic:
>
>   BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x19d/0x1df0
>   Read of size 4 at addr 0000000000000008 by task test_progs/537
>
>   CPU: 1 UID: 0 PID: 537 Comm: test_progs Not tainted 7.0.0-rc4+ #46 PREE=
MPT
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl (lib/dump_stack.c:123)
>    print_report (mm/kasan/report.c:487)
>    kasan_report (mm/kasan/report.c:597)
>    __kasan_check_read (mm/kasan/shadow.c:32)
>    __udp_enqueue_schedule_skb (net/ipv4/udp.c:1719)
>    udp_queue_rcv_one_skb (net/ipv4/udp.c:2370 net/ipv4/udp.c:2500)
>    udp_queue_rcv_skb (net/ipv4/udp.c:2532)
>    udp_unicast_rcv_skb (net/ipv4/udp.c:2684)
>    __udp4_lib_rcv (net/ipv4/udp.c:2742)
>    udp_rcv (net/ipv4/udp.c:2937)
>    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
>    ip_local_deliver_finish (./include/linux/rcupdate.h:879 net/ipv4/ip_in=
put.c:242)
>    ip_local_deliver (net/ipv4/ip_input.c:265)
>    __netif_receive_skb_one_core (net/core/dev.c:6164 (discriminator 4))
>    __netif_receive_skb (net/core/dev.c:6280)
>
> Fix this by checking the IP header's protocol field in
> bpf_sk_assign_tcp_reqsk() and rejecting non-TCP skbs with -EINVAL.
>
> Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks, the fix looks good.
Just curious how you found this, are you trying to use this
feature for CDN or AI just found it ?


> ---
>  net/core/filter.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb0..fb975bcce804 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12248,11 +12248,17 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct =
__sk_buff *s, struct sock *sk,
>
>         switch (skb->protocol) {
>         case htons(ETH_P_IP):
> +               if (ip_hdr(skb)->protocol !=3D IPPROTO_TCP)
> +                       return -EINVAL;
> +
>                 ops =3D &tcp_request_sock_ops;
>                 min_mss =3D 536;
>                 break;
>  #if IS_BUILTIN(CONFIG_IPV6)
>         case htons(ETH_P_IPV6):
> +               if (ipv6_hdr(skb)->nexthdr !=3D IPPROTO_TCP)
> +                       return -EINVAL;
> +
>                 ops =3D &tcp6_request_sock_ops;
>                 min_mss =3D IPV6_MIN_MTU - 60;
>                 break;
> --
> 2.43.0
>

