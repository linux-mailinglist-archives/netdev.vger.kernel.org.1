Return-Path: <netdev+bounces-289720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMhKLrcaDWo5tQUAu9opvQ
	(envelope-from <netdev+bounces-289720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:21:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2966586D06
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BBB730055F6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21A42F0C45;
	Wed, 20 May 2026 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q10VyzRW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D89443
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243697; cv=pass; b=OnTK0Racb6eZiD+wrKH+95jknylpzQRCN9DYW/a2sE3Cnq1diwXGz7lg0z1JKDDF4qRz9PJqziVm+XfdrQa0U2IYW+vO/AUSwOQ60nfK1w1D77Kl7ZsLi8H40NCC26s+nNOh6AQM76w9e+DVoa1J6+KshG5ll+RhrNyRCaqoFNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243697; c=relaxed/simple;
	bh=utIE+Owl2zmsYQ3xJCcWtruZ98YQ/r37WtQFE6AI/Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHDLEBfqaPFyOUxVyqWSAHsZ3sTv3Hb5pAmBUiHwsW4ZqT1t3Xdp8v7CNs1WEA/8Eqqx2DtUtMHltZVBZGP3Us9PUyLlwTO/+kdXPj4rkwPvhPRvKz0nZKHZw6SHRjyPDW+WE3zmWP2QREbMkOZGJvyj5eVKO8X+Aq/KRzdccTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q10VyzRW; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1332772f6b3so5376105c88.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 19:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779243695; cv=none;
        d=google.com; s=arc-20240605;
        b=ahe2M5nsHyr53SbEwupSlZQOL31/v3Egyq2j87+ghv9kJQ/1FKTyiSQISKJqw5ly2r
         PeCLIcwrmp6AjFYcnwUx9MopmbzjgkFKKJ4XlXwcGwb1secg8dbu8u3A4IMqAJ79KQh5
         St/7gM/YAAJoECExWkdRB2QftBn+urGlcIFQdPwkeAcDmpGPGFFSCt8FLbRXCjpCWwx6
         JMmPJ5+ORhC6UmDg6y6B/n5B/ohCKMajXbWzAlwbrjhsQEMMC3p7SVtdtJ54C4OQocNd
         jKFnS4g/KKIbkSvogTlztnkEPtMyxlMbjnz5NBuycb1MgrBPalS0CNYsTf9itQRmaej4
         QGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H4CGGvkZsUV7Z50p0yzoy83QnmPM6+FsK1x3jARyv3s=;
        fh=fLDYWFtX3NlNm5FtIQW44UNGDxFoJXRLji7t0s+fCNI=;
        b=f7O8wkvUHZEMlDqhnt7HM1ds89XAxgTUbTB9DYOtwR+uaLi+ialtNsywF+9qiEQxR2
         xkk9aGwxoauGdXbm4aWeSxSBWrmBrheLIKCMMsTbUotO2yhqF0Y20P85UtkRl+12+I8S
         SwEYagSml8mn6KWk0DqhV5bfHowAHvcbfUNrrJKqvi6kURCtupe2b95aj8XCBTDvByJg
         U4yjovBWBYU2pF7CffiGHhGS/15Zjzh3rBsMZ8xGxmjv36m2pdXqQ0ODaZQ/tz/raPL1
         YkWpzxWj1EqHSS92yEPoMYVaqTmdddzNtCrypVUt/HP+Qa4ZtYtLCiCXWeWUnWSMwYSa
         DgPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779243695; x=1779848495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4CGGvkZsUV7Z50p0yzoy83QnmPM6+FsK1x3jARyv3s=;
        b=q10VyzRW4CDhnGKCpRBPkQDW9k88a0j9gUYMklUyhqah2cTasmhBG9gbICEi9/cy92
         1rDCx3iuGIzxy4t+TXmtBCi2ILa/T/tB9LeR15lH5Klwi/OTq34PaaATwv/7wKyGuED6
         pwhn+KHpU+6IuRl9fbGy7RloDqHcDzbytUV7TU/W44125lBROXf5u+l2/KBZ3JgPgiYS
         KS42QX0pVzZ/xDPnHOJBHK9bnyYJUPCFFcoLVLAWi0SNn3Szmz5P3yJQ+5rwag2/9AWf
         7EN+YiCqTnBepBPF3TyDcrf05PsAjkofZUccxyDfJc44jlwdLB1gvmA7t1hliJCfhHNK
         hOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779243695; x=1779848495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H4CGGvkZsUV7Z50p0yzoy83QnmPM6+FsK1x3jARyv3s=;
        b=JGXPvHPiPaCZhS/qEM+kK04VQoA0V7HqM9x4d9uT31dhO6/IlZOyGyOtiQ2gMWPL4u
         PCCjU+//Q2fhYUNnhqfC8rdXfAKrTCJH6pfg2kQ5NfZRsO8b0dsyj3R1VY40iColg7w+
         ewu2VxXJbEkDLmu55GVrbH1ErLx2qUjlMR87Y6tuQ6vp3IVllWAG1Y+7z7OHDbumGrgc
         zmdS5xNiutaAVp9gVR2wFxTndedY3OxaMM0LwyxbvhaL6yv4N2sxeQAemrvx/L/j/l9o
         P8CKrh+Nzn9wkZAvPaChA3gWn2GV2mA0usXH6OuHQPsteAQ+18roSbCckJoJ9Jeglre0
         fV0g==
X-Forwarded-Encrypted: i=1; AFNElJ+HuvF9k1C+y9+wCIsYvb2YCzxec1bzSJCQb5eNMiodkrjQTOm4rG60SBKgYgEcy9t5VHQ9FwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ9PIs04KVPIIHu30ycYuvpQOF2qNY9iDWdBS8yyVv3gh3v1A4
	XyH3F/f+RcjPjYfIOSsr7+XMFPuysHx0HU4Wcs/uL2DpI1cF4+4OMzI/V34n/iHyxV8K/NYDS1G
	Iq2Xh3RaOSOo6r9bbc6RlvrWgyRA/lULsINHwWlsz
X-Gm-Gg: Acq92OEzHV+Z47qMn7YZpTFBHj7BpbVaz6MLZKwsOSkFXydaFS7Xso5ouIf6qB/E6LB
	Xd/h4Nm69zdjl2aQsreNdgRfe7urvKyvIFn6JlqR4DoKxgq92EbNq2tRBxqpsxbhJ6X5qNyJuhN
	KCVpfXp8qbjya21lRgbek6wR6f2pjceHBYPbZXbT0w2dE1Ye4R6XFBBzI01s3FWQ3fw2O+TieiK
	csTWqOPPdIyFbQT3C5Ju94d4Wq/4QqOZ0iNf4vrK3rgYf+Eg7KICOV+I5XyIa4CKt8OJfutHg3A
	nf85D+Y5G7QtsqxVtw4+wFLzD0+cn18RrkA03onov11tszmGUUQR37IaxQ7oAHhC2QU23NhV4RI
	4MTGQ2rWzwSslPaHM/GfaMQSkxbA1EA==
X-Received: by 2002:a05:7022:23a4:b0:12d:de3f:d84a with SMTP id
 a92af1059eb24-13504945b23mr9625483c88.35.1779243694775; Tue, 19 May 2026
 19:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518050726.318824-1-kuniyu@google.com> <20260518050726.318824-2-kuniyu@google.com>
In-Reply-To: <20260518050726.318824-2-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 19 May 2026 19:21:23 -0700
X-Gm-Features: AVHnY4LS89ckkR-uA8fZJiWB11jrJk2vY6O6FsSAj4RmmrX5WE1txRriY9Iovyc
Message-ID: <CAAVpQUDvvr-VQCajAMpZsexb4QPCx479yMBtEe39biC-UCJxyA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/5] vxlan: Remove synchronize_net() in vxlan_sock_release().
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289720-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C2966586D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For Sashiko review:

On Sun, May 17, 2026 at 10:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> Initially, a dedicated workqueue was used to defer calling
> udp_tunnel_sock_release(vxlan_sock->sock) and kfree(vxlan_sock).
>
> Later, commit 0412bd931f5f ("vxlan: synchronously and race-free
> destruction of vxlan sockets") removed the workqueue and instead
> invoked these two functions immediately after synchronize_net().
>
> This was intended to prevent UAF of the UDP socket in the fast path.
>
> ( Note that the "nondeterministic behaviour" mentioned in that
>   commit was not addressed, as another thread not waiting RCU gp
>   still sees the same behaviour. )
>
> However, a week prior to that change, commit ca065d0cf80f ("udp:
> no longer use SLAB_DESTROY_BY_RCU") had already moved UDP socket
> freeing to after the RCU grace period.  This made the synchronize_net()
> in vxlan_sock_release() completely redundant.
>
> Since vxlan_sock now uses kfree_rcu() and is invoked after
> udp_tunnel_sock_release(), vxlan_sock is guaranteed to be freed
> either at the same time or after the UDP socket is released,
> following the RCU grace period.

---8<---
Is this reasoning complete? The commit message notes that the socket memory
is freed after the RCU grace period, but does this account for references
taken inside the RCU read-side critical section that escape it?
In the transmit path, vxlan_xmit() accesses vn4_sock inside an
rcu_read_lock() block and passes the socket to udp_tunnel_xmit_skb(). This
eventually calls skb_set_owner_w(), which increments sk->sk_wmem_alloc to
keep the socket memory alive until the packet transmission completes.
---8<---

The skb_set_owner_w() Sashiko mentions is the one called
for a fragmented skb in ip_do_fragment().

In this case, the original skb still holds the same amount of
sk->sk_wmem_alloc and prevents sk from being freed, so
skb_set_owner_w() there is safe without synchronize_net().


>
> Let's remove the redundant synchronize_net() in vxlan_sock_release().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_cor=
e.c
> index 00facbfabced..8c3885665b58 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1515,7 +1515,6 @@ static void vxlan_sock_release(struct vxlan_dev *vx=
lan)
>  #endif
>
>         RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
> -       synchronize_net();
>
>         if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
>                 vxlan_vs_del_vnigrp(vxlan);

---8<---
Does removing this synchronize_net() introduce a use-after-free regression
when tearing down the socket while packets are concurrently transmitting?
Without synchronize_net(), udp_tunnel_sock_release() runs immediately after
setting vn4_sock to NULL. If sk_refcnt reaches zero, sk_free() is queued.
...
---8<---

Same.

