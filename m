Return-Path: <netdev+bounces-263558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBSGMyeap2ksigAAu9opvQ
	(envelope-from <netdev+bounces-263558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:34:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 324361F9E5C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C339D30AEBD8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986425783A;
	Wed,  4 Mar 2026 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2c4LPOPC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1793A1C9
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772591653; cv=pass; b=O1tYbXDJ3D/ZWUkMbhf1tlYiw7fq67vKL4zW+QD2Uf5xfVaf+JMYrmBBKwlwlkR9vCfZH45cyK2gKvUK1m/SnbHoPQ7nVo2OXfLO7fx7udv7OcIRldRGFcVg/vaHhMC5nU8koLRMdMHwF3PkM+KT1cq8J7D60baxTUSuXLnj0Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772591653; c=relaxed/simple;
	bh=Kent9a7uYWnAHkVCPx0WZ+BkGOvVNWHFpkOFgJnc+OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhrbUOj5CSKICv+LsfC9Ov/uS9ykXqdiAGwg+4aNUhss3dQiMN+d31rwX6jYclDlT+2WTZjm/WchTwKlF1IT1KWHwPYNDaoj+LMStnpiBIu3e472U7MQdEZzHbwrZZVz0w/c0wWrZ0TByeqhK/MPn0voQGKI4AGCllSFMHBo9lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2c4LPOPC; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7986d231b3cso86721987b3.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 18:34:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772591651; cv=none;
        d=google.com; s=arc-20240605;
        b=kvBx6hOlMDJuM3tC4QaFSCZoN1Kr8OZtrDiSCuUGAq+vYI2z4QRGiAvMTa+BaIgm5o
         QgMjh1TKxHSXB35dLeqteNFLSAIkD0inQC/WB01MAP8IIdHAtZlUUPO38WelnT0tasnY
         8RZBl5pK28X3e1A7WfojzKv4ZYRpRW9yHaBEPYU4b6kVyFt0wMewV2jfD/y2JgpHySWM
         S2u/PSB2ESPJW+OedATwQOWxeBM6vVMEUTuNSEunwETjnBx9T1X4iVQdUOxpuzxSnc3i
         iy7KY1TGQujdCSus1Fm1CJTzPF67EX5EQZBJB8E8KfGC2Jl6HfcuE62mI1CWM3a8RbU0
         coSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eLBJId3hA1B3EKZDijtquBb1A93aOLQ1MH+9ly8YPVA=;
        fh=DsM3CgL7tRmZRRkJkAzHfaG44TvYU+WKcpUkoN6+w0M=;
        b=QdkVmkLKktUEhtHMFcn4wOoE7gidh476wgV/nLLXaAtC6izDXE48MCigikZUK/0igr
         0chriF9WP1SGSF6hx664MiImrk+lbvma5kAF2vcPBV3ZB3fEJnAz0PpJIwHBj7z17BeF
         Wu9SuIYkcbwPaS2vIN7QnuJ5D0HODBRxnY5BxucHBlFksHWd5h6ePOsWfK3KANLewA0q
         QxOOWn7FHPvIn/HbZqbl3/J/4E/D0sCW4+kjBqQvvWJZNif4cgKTYr4Ff6YOa3tnNzeh
         HVeRrH/iZcHHoO8DVjYCjAs3/MMVlWe+EWSh214pBCsFxBCMedrPCfcLGV6E3WqvK7dz
         HW6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772591651; x=1773196451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLBJId3hA1B3EKZDijtquBb1A93aOLQ1MH+9ly8YPVA=;
        b=2c4LPOPC52w+RbIhrpp4cwpa/nrF1RE5WWJmT6tBBMRHTLlcGmP8KpEfm6NREYKKSq
         QppDeCNmtJhTdd1QmpVFvxyHndatmzzcd1CrLMXFSwfGL8+T1E3M2AcHNlNJADZn70Q/
         2BA7qiiZhwZzRWA2UAjHsFrUBkBHZFmqFtR4P1ULhGOnzutma3mQNMdd3OiwjFC7H4NB
         A0vKDBwl/HDroR6qlCk5zCy3KT287oszl9Hci2ev7jYtVGwNTcCR97rU3c+hLA3b+0Zm
         XDnzSselfVUFObIeTKOuf8JknePLOSOnZQboX4BWZ1z67oyNnQVUo96piH/UGdlgwREx
         A72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772591651; x=1773196451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLBJId3hA1B3EKZDijtquBb1A93aOLQ1MH+9ly8YPVA=;
        b=FitKEbWmJrUwcevhAJtEjEl0uP/TYr6ppXKJUHc5k9YpKHG6lc9QVBO0dAr/7LrbmL
         goeSw120SlHV5gl71rkGFaCujFlx0R7Booh7S0TJhRKDafkyt6G9Wn8x/grh89ZBgjgx
         eXOpkEgrja0r38NL7oU7xAeqzbAMgCAGKlJR7d/dflTYioFLCgFMUy3r+Ok0pk3M3n+F
         w1G/cFRVCDJWNYizzUFe5vyS0k4AUyo4REVO3f2C57BguOJM8L0eTlGl+UKk+8IxJo/V
         D0qqqrvn799Os2W3CmxY/WiTcOx4qrTPY6OIyZM8sHJgNZQG2N1uC3amd032hYz+0BTP
         g2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCX+kQ0D0rlhzlMtHl+MAzYl3YNT2wofBxBy9Rmh5ht9x2uvzRlrJMYc14jIlDiSFtX1dBOFZyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qqsa47YX7XSzpAtB94vulF5fteQmbk9KyXus5sSwFb27Zw/T
	vz4dl8QOpv89ripAErDbXYkTUR4U+SeeaUfwaUGh856Jzqe/1pThOaQDcVHo6Uwdsmr/yGpOM5G
	q3nMkxap8AmYm4aqqZVeryexanBgVfpGnt02K4AfQ
X-Gm-Gg: ATEYQzz+J17DX4W3MhPZ40qBbfBrTOuFjJo+yPSXXGPAliu7Fod4GJVzwCLEDnzqFJ5
	aeHxVPQf3WwTSDKTcrNCKBw6ZoSMiWHlLh1E0dbmiTAEm5oQlW1XTUGbIXqjHyt6qj30jHQzuDl
	/XujNnduSKby45Mk6muJy7iHw5DwG8p0bF9p/ILoTFyfa8LLsaFR51MJ+C7JJGBPUO0Vf4hlBah
	55WAvZqFTzF/+UIhHe8jiZ1kiRmOoqhGio9vpRJ8Hs0Y2r6+UEK9zSXCFlEsnyLemL26GBzi0nE
	rgvbsWEZ
X-Received: by 2002:a05:690c:7244:b0:798:1be:1c34 with SMTP id
 00721157ae682-798bb4554a2mr34694967b3.26.1772591650604; Tue, 03 Mar 2026
 18:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302154201.1621117-1-edumazet@google.com> <20260303170841.218b0816@kernel.org>
 <CANn89iKBDxAqT4MGGuQ8xxXjbNRo7HadXoYYq5QpyP0S_4rfTA@mail.gmail.com>
 <20260303182429.49645ce8@kernel.org> <CANn89iLox=oWvU6VZKSKKtt36zstfJ6Lp5TgQvfmOz1g_-rMnQ@mail.gmail.com>
In-Reply-To: <CANn89iLox=oWvU6VZKSKKtt36zstfJ6Lp5TgQvfmOz1g_-rMnQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 03:33:59 +0100
X-Gm-Features: AaiRm53-UAt13Ot1pzL7WFrJdmdShEjyaVPIP4c1sjQIC0yEz6DBBXFPEX9OvY4
Message-ID: <CANn89iLU9F3PKP26U_m22V6E=mpqA8LqvMfe42Xp3u5L4Q0k8g@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 324361F9E5C
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-263558-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 3:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Mar 4, 2026 at 3:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed, 4 Mar 2026 03:13:40 +0100 Eric Dumazet wrote:
> > > On Wed, Mar 4, 2026 at 2:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > >
> > > > On Mon,  2 Mar 2026 15:42:01 +0000 Eric Dumazet wrote:
> > > > > ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE()=
,
> > > > > even if this pointer can only change once.
> > > > >
> > > > > Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
> > > > > direct calls when CONFIG_IPV6=3Dy.
> > > >
> > > > Does not apply to net-next.
> > > > It sounds like we're going to remove IPV6=3Dm, however, perhaps tra=
nsform
> > > > this patch into that removal?
> > >
> > > This seems orthogonal, unless the plan is to force IPV6=3Dy ?
> >
> > I thought if we remove IPV6=3Dm we would delete ipv6_stub completely?
>
> So we will add #ifdef around helpers ?
>
> Lets take :
>
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/add=
r.c
> index 866746695712aeae425100eefb231e44d52d52d4..5de8fd283ac9b0dbc07d5851f=
05d15e84c3645e3
> 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -411,7 +411,7 @@ static int addr6_resolve(struct sockaddr *src_sock,
>         fl6.saddr =3D src_in->sin6_addr;
>         fl6.flowi6_oif =3D addr->bound_dev_if;
>
> -       dst =3D ipv6_stub->ipv6_dst_lookup_flow(addr->net, NULL, &fl6, NU=
LL);
> +       dst =3D ip6_dst_lookup_flow(addr->net, NULL, &fl6, NULL);
>         if (IS_ERR(dst))
>                 return PTR_ERR(dst);
>
>
> Is the plan to define ipv6_dst_lookup_flow() differently for IPV6=3Dy and=
 IPV6=3Dn ?

drivers/infiniband/core/addr.c was probably not a good example because
addr6_resolve()
is guarded by #if IS_ENABLED(CONFIG_IPV6)

But other places do not have such preprocessor clauses.

