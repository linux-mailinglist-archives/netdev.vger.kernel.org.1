Return-Path: <netdev+bounces-306641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tl4iFQUzUWqrAgMAu9opvQ
	(envelope-from <netdev+bounces-306641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:59:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9127A73D268
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:59:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=everpuredata.com header.s=google header.b=EUM6VEht;
	dmarc=pass (policy=quarantine) header.from=everpuredata.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306641-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306641-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60997303CD1F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAAB42DA56;
	Fri, 10 Jul 2026 17:57:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BEC2ED860
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 17:57:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706224; cv=pass; b=gwNBdPjDVUCwfCvpGLF/synQrOn5c4E2ok+NkAv1AJIR88qsdgRjYyV9Q1zkvHPdp41ivB+J6ZZB9eAjx+YoDNAL2zhWsxC4QK/YqBNIuS1zTHUkQXArZP17M0gUjcO+R1eCXZR8h2VyRXN/OCMqFXw9SnwQ72Dyvv8o7OG4bzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706224; c=relaxed/simple;
	bh=sKCmj/MAcdsfDhf059d98K/uKGyICNLrAjmrzMiB4CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvOzY/BwpH7fNEN9oWftLKftxP2uKZELTmkQnirO9hoWHqumqoFubw1bvVM6YVYN3zCT9nZnazlZw+goV7+a4xpXuJFuGIJQAMEGMEOOTMifyvgecqrx1T9A/C8sdKVqro5vd02SvJvkzFtCfrQs1TfZz6PYc7kpaLqcu9DpvfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=EUM6VEht; arc=pass smtp.client-ip=209.85.221.174
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bfa6766cf6so778618e0c.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783706221; cv=none;
        d=google.com; s=arc-20260327;
        b=TqNd6rui+dNbqEBmFuStSYZIk/naRRt0EL5MC4BYhJRD5LBK1+Bs+JmJlTDALdQtNV
         hoDzpwT2oeWHxbR46Ghi4iO0eVaGUsCOktrqbqw5h9lni+g/H413fICUV0MlNnztOBBU
         o2jOCgyccZss7/VO9Y2kQsdv+BFzTOeHpJsAhoNSMpj9mYu4yb0fzblhYYj+8DvbEPYq
         JTHBAUK48RsmEsYslzz37j68Xh7WLc+hwTpGgTEIunRfLneCVJ4HJuCcZ4050tIQTWe/
         YlJefwkM6K3zkJPeu+KvjIX++RSkSq+EVxsAgCY6CNSOvkv9Jtb/va7vTy/jABhYLtQn
         511g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vGLPsJSAr2LVAQzabNsffxPju3AsO91AtDgLJpKXYUs=;
        fh=ar5Wl+s7PCxkDA6REpmk8mBtdxq/QExujRSvxSt5TZQ=;
        b=jsGLC8fUyB2mAGZ/CUyqnIQ1aQUR11BzNDdi5XLmu0bE1Hwanq1IBLB/w5oVUoc5Z6
         m51hdyjS9sr93YjJ0ctTh2f6W7YO39Q/yl4ifQ6RGj7Mjr0cVQX5AWxfq8EO+3zWPyfj
         Xl/b038ZOlh+Gt0K8zyyV+Cc6mnXpULO+KBO9THU/tHu5ekNYEvzL9hpIFr33p2UkgC/
         c4kkBX9cSWrqa3EoNFYRApG4nEf1Zsl7dmM7fbEwvpAyr0qEgwoDwYodMOleSDg6YMo0
         BabgsINVAopEEGfllFntoExwibOqCS+0znuHL1RuyevAYVCXtQfLeoVIJb282ihifXhN
         ehuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1783706221; x=1784311021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vGLPsJSAr2LVAQzabNsffxPju3AsO91AtDgLJpKXYUs=;
        b=EUM6VEht7JncoKRob9RnI/CPltyUlo2MHaHuLNNnBKiEu8qgyGqLCze3MPabkBqTcC
         5qjs0HsXW+0MYcQwAnAjZJ4epZuSlvFq6rp6e3bnLl5M5sVdMjFODsH5JMqmklZkZSWs
         agD/Icl2vujHZUxMtmoD3IFtQLGTbjkaF9nv4kR4lawDQmnbB9LtdiwuJH5rnMxH2t8T
         0Li328ajpgP/jhC10l15dxsBIm29QjKX35EzHfZN39XVQOIhAHfFTHQeKxMnAQ2q09yV
         RWjSJbPlM1pB7vpEu/COnmx6ML/yrLoGet3ss+GsZpdke6nSmvhRCd6rjMrc+k6ZzZoT
         bzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706221; x=1784311021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGLPsJSAr2LVAQzabNsffxPju3AsO91AtDgLJpKXYUs=;
        b=YPRXGtUoFRzOcSpcQ+bFaUIMQilqcn1Z8H8ZG0WyzMcb0jGX3lh+/jhT8iuTg85iPN
         zJTqZbKBF/bh3R9Gsar9TxcPlcWI2zEQVDjDd8k/MEdfJ0d0iu3RVrKX0kgVAkVnmz7B
         plMHtxV2mLLU49/vq6RbUE8sAw2T9BJ222oCqkmtCQKc9dh6CzibP4PIjkdNf4Axwq+U
         MznD+iPQYaxSd31ft1+Q2c4clnHTEqPdXCUTY1/mcOmgH2ItcP4CFvlfYGl3RgNmkGHt
         MmgM9UL70+fOXo2tJXTLUCDTcpqIT/EnYuzY0c3cB0eLTcPa2uUkyZTLRfG1Dd2sJVzY
         yaVw==
X-Forwarded-Encrypted: i=1; AHgh+RoLjBhmBpvVoM0ufh5A0+AO9x9vwBxncyFncTOZJcv3iw9lLbwUXyRcdKkISwZU1oZ2Oofb1yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0hoqRB/4LwrQq1Ar16BG0OxWH12D7SJkyrV86zVjM29Vqwyg
	MLYcZFB1I6w8ubwlwhkKLvfctdvS5GIYjgZQO49jolB9PF3SKwz+CvflRYBt6z8y13z6LFUqgE4
	jyXeuBq/bgTz+y+Jwk3/k06FSxtg7e+UdTmJEE+Fyew==
X-Gm-Gg: AfdE7cmLpyNBl57HADaRzvX8K1b+sb8axTJ8k/gpyQJ7acIM7NFa5Pn55wFlTwOTaFx
	soerR1I0Si/5MIAidF0+ttkeNxF7ZrB6n8bBNgO4CoCutZW6hro0TbVYSyVbiqELJ/njKTU4WGM
	2DTaOrUaeqsA7jxLdLWJbeBT2KnautYcqNGV7jFFPah5Fghq7aefJHVjzcvTvsKZybE1hKS0V8q
	oFVsi0/kr7SyQjyaxY67ip6yckgc6vdtt9wQdrOYM6lLsdsMhVsTJwNvPFdIDKRshBpBfWrlJqC
	UqSPPAgeKuPxiO7V8f5q4MPbjhu4Rct3sJi41pEz9DwlREx0LKYDJ+hz4XjuYL9RbaTzNvU7eth
	HdJ+STKC75mAaWj2pobBpPjq8lS+o7qk0C9lLSidfND6IVaFxEyDTjEPxe1esEOC569A=
X-Received: by 2002:a05:6122:1682:b0:5bf:ad8d:4f9a with SMTP id
 71dfb90a1353d-5bfbf141d59mr253469e0c.4.1783706219111; Fri, 10 Jul 2026
 10:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKaoeS3RbLP=D1G6HHaSfQLj4VSi_W=HZ9EnKxKia_EjcT1vSw@mail.gmail.com>
 <20260708060319.68063-1-nils.juenemann@gmail.com>
In-Reply-To: <20260708060319.68063-1-nils.juenemann@gmail.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Fri, 10 Jul 2026 10:56:48 -0700
X-Gm-Features: AUfX_mwNnjoCz1YZXZRKcXSucwnw88a0ux8VePz3UseWoj2Vrrx0p9d98btSNnQ
Message-ID: <CAKaoeS1ym7EF-KJqF1G+xm2tqogVMaEnmBUUcXw3vHG+xSTGhw@mail.gmail.com>
Subject: Re: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload support
To: Nils Juenemann <nils.juenemann@gmail.com>
Cc: borisp@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, leon@kernel.org, mbloch@nvidia.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, saeedm@nvidia.com, 
	sd@queasysnail.net, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[everpuredata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[everpuredata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nils.juenemann@gmail.com,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:nilsjuenemann@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-306641-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[everpuredata.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com,queasysnail.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,everpuredata.com:from_mime,everpuredata.com:email,everpuredata.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9127A73D268

On Tue, Jul 7, 2026 at 11:03=E2=80=AFPM Nils Juenemann <nils.juenemann@gmai=
l.com> wrote:
>
> On Tue, Jul 7, 2026 at 5:31 PM Rishikesh Jethwani <rjethwani@everpuredata=
.com> wrote:
> >
> > Could you post the disassembly [...] count how many distinct loads of
> > sk+0x4f8 the compiler emitted in that region.
>
> objdump of mlx5e_ktls_handle_rx_skb, CQE_TLS_OFFLOAD_RESYNC branch
> (+0x63) through RIP+0x10a; bytes match the oops Code around the fault:
>
>   11bd03:       48 83 82 90 01 00 00    addq   $0x1,0x190(%rdx)
>   11bd0a:       01
>   11bd0b:       48 8b b6 d0 00 00 00    mov    0xd0(%rsi),%rsi
>   11bd12:       49 89 fc                mov    %rdi,%r12
>   11bd15:       4c 8b b7 00 01 00 00    mov    0x100(%rdi),%r14
>   11bd1c:       0f b7 46 0c             movzwl 0xc(%rsi),%eax
>   11bd20:       4d 8b be 08 01 00 00    mov    0x108(%r14),%r15
>   11bd27:       66 3d 81 00             cmp    $0x81,%ax
>   11bd2b:       0f 84 a4 01 00 00       je     11bed5 <mlx5e_ktls_handle_=
rx_skb+0x235>
>   11bd31:       66 3d 88 a8             cmp    $0xa888,%ax
>   11bd35:       0f 84 9a 01 00 00       je     11bed5 <mlx5e_ktls_handle_=
rx_skb+0x235>
>   11bd3b:       0f b7 43 78             movzwl 0x78(%rbx),%eax
>   11bd3f:       49 89 c5                mov    %rax,%r13
>   11bd42:       48 01 c6                add    %rax,%rsi
>   11bd45:       45 8b 8e e0 00 00 00    mov    0xe0(%r14),%r9d
>   11bd4c:       0f b6 06                movzbl (%rsi),%eax
>   11bd4f:       83 e0 f0                and    $0xfffffff0,%eax
>   11bd52:       3c 40                   cmp    $0x40,%al
>   11bd54:       0f 84 a8 01 00 00       je     11bf02 <mlx5e_ktls_handle_=
rx_skb+0x262>
>   11bd5a:       44 0f b7 46 2a          movzwl 0x2a(%rsi),%r8d
>   11bd5f:       41 8d 45 28             lea    0x28(%r13),%eax
>   11bd63:       0f b7 56 28             movzwl 0x28(%rsi),%edx
>   11bd67:       4c 89 ff                mov    %r15,%rdi
>   11bd6a:       89 45 d4                mov    %eax,-0x2c(%rbp)
>   11bd6d:       48 8d 4e 18             lea    0x18(%rsi),%rcx
>   11bd71:       4c 8d 76 28             lea    0x28(%rsi),%r14
>   11bd75:       48 83 c6 08             add    $0x8,%rsi
>   11bd79:       6a 00                   push   $0x0
>   11bd7b:       66 41 c1 c0 08          rol    $0x8,%r8w
>   11bd80:       45 0f b7 c0             movzwl %r8w,%r8d
>   11bd84:       e8 00 00 00 00          call   11bd89 <mlx5e_ktls_handle_=
rx_skb+0xe9>
>   11bd89:       49 89 c7                mov    %rax,%r15
>   11bd8c:       58                      pop    %rax
>   11bd8d:       4d 85 ff                test   %r15,%r15
>   11bd90:       0f 84 4a ff ff ff       je     11bce0 <mlx5e_ktls_handle_=
rx_skb+0x40>
>   11bd96:       41 0f b6 47 12          movzbl 0x12(%r15),%eax
>   11bd9b:       3c 06                   cmp    $0x6,%al
>   11bd9d:       0f 84 cc 00 00 00       je     11be6f <mlx5e_ktls_handle_=
rx_skb+0x1cf>
>   11bda3:       49 8b 87 f8 04 00 00    mov    0x4f8(%r15),%rax
>   11bdaa:       48 8b 40 30             mov    0x30(%rax),%rax
>
> One load of sk+0x4f8 in this range, at 11bda3 (the fault). r15 only
> becomes sk at 11bd89 (mov %rax,%r15), so there is no sk+0x4f8
> dereference before 11bda3 in this range. The only other sk+0x4f8
> load in the function is 11be20, after the fault and not reached. So my
> earlier "two independent loads, second reading NULL" was wrong.
>
> Thanks,
> Nils

    resync_update_sn() handles CQE_TLS_OFFLOAD_RESYNC by looking up the
    socket with inet_lookup_established() / __inet6_lookup_established()
    and then dereferencing tls_get_ctx(sk) on the assumption that the
    returned socket owns the TLS context that produced the CQE.

    That assumption is not guaranteed. The established lookup matches only
    on the 5-tuple and does not filter on TLS ULP state, so it can return a
    TCP_ESTABLISHED socket with no TLS context attached. In that case
    tls_get_ctx(sk) is NULL and the RX resync path dereferences it.

    In the observed crash, the returned socket was TCP_ESTABLISHED with bot=
h
    icsk_ulp_ops and icsk_ulp_data NULL, i.e. a socket without a TLS ULP
    attached at lookup time. This can happen if a stale resync CQE is
    matched to a different socket for the same 5-tuple, or otherwise
    resolves to a socket without a TLS context.

    Fetch tls_get_ctx(sk) once after the TIME_WAIT check and bail out if it
    is NULL, then pass the sampled tls_context down to the resync helpers.

Patch:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index c0676148a36e..754b6a45f604 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -478,12 +478,12 @@ void mlx5e_ktls_handle_get_psv_completion(struct
mlx5e_icosq_wqe_info *wi,
 /* Runs in NAPI.
  * Function elevates the refcount, unless no work is queued.
  */
-static bool resync_queue_get_psv(struct sock *sk)
+static bool resync_queue_get_psv(struct tls_context *tls_ctx)
 {
        struct mlx5e_ktls_offload_context_rx *priv_rx;
        struct mlx5e_ktls_rx_resync_ctx *resync;

-       priv_rx =3D mlx5e_get_ktls_rx_priv_ctx(tls_get_ctx(sk));
+       priv_rx =3D mlx5e_get_ktls_rx_priv_ctx(tls_ctx);
        if (unlikely(!priv_rx))
                return false;

@@ -507,6 +507,7 @@ static void resync_update_sn(struct mlx5e_rq *rq,
struct sk_buff *skb)
        struct tls_offload_resync_async *resync_async;
        struct net_device *netdev =3D rq->netdev;
        struct net *net =3D dev_net(netdev);
+       struct tls_context *tls_ctx;
        struct sock *sk =3D NULL;
        unsigned int datalen;
        struct iphdr *iph;
@@ -545,12 +546,20 @@ static void resync_update_sn(struct mlx5e_rq
*rq, struct sk_buff *skb)
        if (unlikely(sk->sk_state =3D=3D TCP_TIME_WAIT))
                goto unref;

-       if (unlikely(!resync_queue_get_psv(sk)))
+       /* Established lookup is tuple-based and may return a socket withou=
t
+        * a TLS ULP attached. Sample the TLS context once and bail out if
+        * none is present.
+        */
+       tls_ctx =3D tls_get_ctx(sk);
+       if (unlikely(!tls_ctx))
+               goto unref;
+
+       if (unlikely(!resync_queue_get_psv(tls_ctx)))
                goto unref;

        seq =3D th->seq;
        datalen =3D skb->len - depth;
-       resync_async =3D tls_offload_ctx_rx(tls_get_ctx(sk))->resync_async;
+       resync_async =3D tls_offload_ctx_rx(tls_ctx)->resync_async;
        tls_offload_rx_resync_async_request_start(resync_async, seq, datale=
n);
        rq->stats->tls_resync_req_start++;

