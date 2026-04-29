Return-Path: <netdev+bounces-282196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK8tIA1m8WlfggEAu9opvQ
	(envelope-from <netdev+bounces-282196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:59:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1426948E320
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28FA03031ADA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D059230BE9;
	Wed, 29 Apr 2026 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFBldmeQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945F35B136
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427923; cv=pass; b=uciMKqOl+ExUtARftqpHguclv3T5COnff++ScekH6bbFKSZmMfHFwKB+zVpz2wQ/kT9DywuSsVxdCrBdLsSQb326aObhQeCkqXLXnkNmUvcMokF4KHTlK2JZQjr//YMYwLVjWvTF8TscPWrWatz9B6oIN6+Dq1/E4uQ6h/VK4sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427923; c=relaxed/simple;
	bh=Pxrojmrc2cY8YLtMnn3WHI2wj4Rjocszi1DAJUpeITE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsJdkWbGpZpiDdXqqn+KEDirEemUQ1tG52BZe2tV108V+NLoGM46YCWLDI8LdKtKd0AICEgKOAwtqkWkRbxTtQaM1hmrrkkr6eY1Q+sgHnFAZr4ZUhYJDML9JS7W1gzrhAFnG15VuILf4QhFXljKrg/A2SwLTw67Ul/r3NV/LnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFBldmeQ; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44509921fbcso1767999f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777427920; cv=none;
        d=google.com; s=arc-20240605;
        b=DOb3ky901hRMTM5ZDJdCGmdxtmgv2y4PIumGVfTIUL2xfUGRB2CANib53kXWlsLhwV
         Wn/qk9MYqO0+R4uVZo7RZMEwjExOjwDGD/wotMvaDyM6MZ4BxlZ2rtfkfw/vENYSJQTL
         1DesEgHvBqh6HDbVpW5j7BerNMGzkVJKYDdJylxM9orIyTn0CtL082TokfeR78eOBcGO
         U5x0ldnJzy8Ods2L0cbLySgKWpHjPV3CpSULWi47bvJfJt8LONz9yRADUODai6sHqMxX
         xKfNolXue2g2zm1RW78+vVGzRatQixI77sHYlX4hkJdCdi7N3+1WHdauhU8aBRt4ZEvy
         rWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yuqGeXahbxcUk1u4/2wMgxO+sa3eSW+uWGPH0ECvggc=;
        fh=OudhDefOu6sZXRYVe920DUgUFCeVD3MLrIvwmz6g8ws=;
        b=B+R2h2Pr+LAUKLqJAJihVmTr7yxfUljAmszIi9HepeU9V/N7iI5a7dYVmWCUtiVqUA
         b/bXLOS757EmDC+bp0toQQYl8CnCNZJAdXCH2mB9I0GGWWj+N4qPm/xsa9cDV9jUiqRU
         5az2AwiXxMHWgwVNGhnMZbsF4kkHQR0F8BrrcKXpos+oRU/9qCg66fLuZ2/29nV3vIgG
         HZ3s2Ne7KQwlcw93Q0YsI/Jqv+DvtZWmiXjl7za2eTOwwxocdPkl9SQabDk/HxjybRGW
         0FLXQsIbxAH3MmXBtRpHxF5MsV+/R1EfoXbhqE99aWGcE95Nrn7DS3UUSUpm5dLhTNTi
         oxnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777427920; x=1778032720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuqGeXahbxcUk1u4/2wMgxO+sa3eSW+uWGPH0ECvggc=;
        b=nFBldmeQPfcpVzNubkTFn1V/ReisvKU1H1uz0rVgUM6z9F5I4MjjEeopC6jgZWgPpj
         oRUPQw6Zs+Pitn1CG4yz2KEhZblX8MAcTpJNusQRzqrgOcY25X5aONEUOQDL2baZcUBz
         whMjUtqv1bgCkqwrsrpQppBsemsh/CrJHjRLQBdfJGIiDPNb0QQpGwN6XR0tHEnH3x1V
         DqVy3+OgEuzBa1EaDbXlURMoH2QiytRHrVkAH4n7sDnCxipaccG6xGeY6RTHwCcAh5Y5
         wyUo5Sv1OusV7PrrSSnxbDGCyfxO253B4qFB5d1kzAcWIMN45suzKVWOXI7teS1DyrBL
         gPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777427920; x=1778032720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuqGeXahbxcUk1u4/2wMgxO+sa3eSW+uWGPH0ECvggc=;
        b=RXCUoLEgh8oDOq1NksQ40jYnfVgQjTg8RGBAL3WYV2ylGx391zLeg3v3hcb9Ci0S1c
         elP7Bo6JVL8xhGCvZroM7Cscxn6JzbsRKKPj2NtPhDVcM1eFEb/kqHSP3Nxfbb+v6/ek
         ed6Ygt6YrUzTplv3O1+4DR5UgpYBA00Ck1f8VozOmUq2+Z8M7ztMBLpd4WmpVxioqgNP
         7DGbn4H7JANPhddQZMVJikA/ESY7s1uJL7NoU+weMN/Bf6kbIF9qRLPJd7Z3m7X7m7PM
         JrUrVDxCtCir1NJp0wOPC/ya5ChULvr82z6kyN7sAgV0Ny497NbJsrliHiY5sP6o0wwL
         LcyQ==
X-Gm-Message-State: AOJu0Yyz33Kl8NgCSnqrsqiREkay0FaxwXfvvxLmh2yPoGnZwGI9hhh/
	lLCOPztWQMNrCiHb7KwQxjv3mOSVbJA9qo3I9CpvXxKoU1fOnb1K2obTcuYH6z6y4bYCVuYt4Sr
	S8vKSlVqyFgceJfPF20uie04+vSWnrPo=
X-Gm-Gg: AeBDieuAS5iAC4qhEc4zvA42unURk81whpbzoR1Ldkut3IIwPpamHP3Fv/Gvskznxmt
	JLWWCNcvBqzhKyxWYyU1ixRenQyf5w88zGppqq3OfgeFA/Eit8pG4v8JcjNQ0q9KTg9M/hMI8jg
	UwUEAYsEb0Jw3xr1hr0xYe75YUR3IRxY/unqbPWbQlx2W/CKZx0gBt2Ce+TVdf6GcuA8qZ/Olao
	HlxUN4v+uc6marKfdHcAkQAVrRYpdQ2C75+6Cfm0DKHNKDfLnMQ8Tt4IOlzkL03Z61PNV1dhYVq
	j7e1QUgh4rsg4+3DilgbQFeDnXTAg4bd4hdmu6mHgA8wINR669qcvIKCpeg=
X-Received: by 2002:a5d:5d0f:0:b0:43d:71f4:7ed4 with SMTP id
 ffacd0b85a97d-4478e9943c5mr2778885f8f.15.1777427919385; Tue, 28 Apr 2026
 18:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com> <20260428110713.2550315-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 29 Apr 2026 09:58:01 +0800
X-Gm-Features: AVHnY4LERK-_-glKNSMAd_6o281Ks5DC7YxO0koEJgi2NjQopuPz9tDFTvsvn7c
Message-ID: <CABAhCOTmZ4hAuhtimOX1YQDGFC2fbXm5WmwT0Z8PxZU7Zq-2Fw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: netdev@vger.kernel.org, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1426948E320
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282196-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawleon@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,ntu.edu.sg:email]

On Tue, Apr 28, 2026 at 7:07=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
>
> After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
> ip6gre hash via link_net. ip6erspan_changelink() was not converted in
> that series and still uses dev_net(dev), which diverges from the
> device's creation netns after IFLA_NET_NS_FD migration.
>
> This re-inserts the tunnel into the wrong per-netns hash, leaving a
> stale entry in the original creation netns. When that netns is later
> destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
> slab-use-after-free reported by KASAN, followed by a kernel BUG at
> net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().
>
> Reachable from an unprivileged user namespace ("unshare --user
> --map-root-user --net"); cross-tenant scope on container hosts.
>
> Note: ip6gre_changelink() (the non-erspan sibling earlier in the same
> file) already uses the cached t->net correctly. The bug is specific
> to ip6erspan_changelink() copying the wrong shape.
>
> Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link=
_ops")

The changes look good to me. But why is 5e72ce3e3980 mentioned
here? It neither introduced nor was intended to fix this bug.

Thanks.

> Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> ---
>  net/ipv6/ip6_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index dafcc0dcd..38ac14cc0 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -2261,7 +2261,8 @@ static int ip6erspan_changelink(struct net_device *=
dev, struct nlattr *tb[],
>                                 struct nlattr *data[],
>                                 struct netlink_ext_ack *extack)
>  {
> -       struct ip6gre_net *ign =3D net_generic(dev_net(dev), ip6gre_net_i=
d);
> +       struct ip6_tnl *nt =3D netdev_priv(dev);
> +       struct ip6gre_net *ign =3D net_generic(nt->net, ip6gre_net_id);
>         struct __ip6_tnl_parm p;
>         struct ip6_tnl *t;
>
> --
> 2.34.1
>

