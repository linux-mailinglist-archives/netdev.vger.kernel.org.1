Return-Path: <netdev+bounces-263030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAnhM8ZbpmlnOgAAu9opvQ
	(envelope-from <netdev+bounces-263030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:55:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B32F1E8992
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9249A305DAAB
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A8137DE9E;
	Tue,  3 Mar 2026 03:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ioJT4qp+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D137DE89
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772510119; cv=pass; b=Nz0AvWXYP5lB6qnScGP3LnWxeyibwIdkPSO/bIw9eslJsEaWQmjDMNVYmWUwfQFw1TbEMnerU3JkQgd48F2l/013lcs2l3id6ETUhYqMkuGa1KkSsNC9DTA4ueQgBYguQDg3I/QuXqqp1KZ2huJZSsDJ0fxXFV0UqgoWDtJImG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772510119; c=relaxed/simple;
	bh=ejc1Nj9JSexTn5t/j4wyckbSfdpkEdCAy4NmiTGXn2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mia9Soa5Hha+2qi/hUnfC0S3gS0e2XNjxbPfXLEeumtdh9KpHFm0IGFIvzBzE49WwxN8hx8zJpwJ1vomgT30qHf/vBPGL5h4dQAyitJASAUhfrTJTrA3USEmy4wGEDlLQshmXRWg35JXjhbD8zOzRv9JqRrW9JOjPff5aGhmxFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ioJT4qp+; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50334dd44d2so61407821cf.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 19:55:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772510117; cv=none;
        d=google.com; s=arc-20240605;
        b=QH+sH+lWcV70kl3eiVu0ucu6Kvs0jem+vjfkhAqu4j1xtO7D2Oi7vk4OMWk2N125WE
         r6ueN6N+hNijmu6hF+faW4DAxs58ni7024xXKbbgrhWtC6c9V2uSJKFRc7paFBEfRT9G
         LELS/BMV9prsEP82gSf0rBKlDnJg1uG5R4dW8GPpJZqetG21cWrtSteJ0pXEoGssYtyA
         4vPn4aGbxKGPHA2FVklNxsMgcdDa/Tlk1IZD0JYTh3gnqD11v2fOaY1/Iup/CPk3q8Zi
         rHpHAy5poRMGzM66CKbcZ5brMG9dl/bCfjDl3PLJtGZ0oa1G0NEz8emkwVbiIqmn/rgz
         HRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ejc1Nj9JSexTn5t/j4wyckbSfdpkEdCAy4NmiTGXn2w=;
        fh=F/O7CDH8ZgraapkW6TqZmGBDQ1JJgJ4NNA92XqhSu0o=;
        b=gG/N6Yj7aWzeRM3cQeolH/64bM8jH2rhIXkPHDriQkoDiUN4dJckwQJRlysKAyUsJr
         H7YEn6FN18Vrm2mENKq0cNrxXfazPlQ8hrrIYOpKiHxXH9Q78NBR0mBf7SoswTD572CX
         YQxg7SeZDJYT9WDZJkigHoDSVZEvqfhKcpRRVk0DmLB/oHQPgvM99ugXprp+49nD5gnx
         x+LOA65kFhZneHAz8RETNj3gIO5LJugyEr5ZPwRPaHVzGt1g3MpKJr3+sulylE0SmOOc
         s7kQiQ4fBVYtl0DblVJ4rtlbZKp8/Ok7vWHYUecXWn4U5yfoZa2Wp3VcondJIZajCmp7
         LHzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772510117; x=1773114917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejc1Nj9JSexTn5t/j4wyckbSfdpkEdCAy4NmiTGXn2w=;
        b=ioJT4qp+Bka9DieWPGsi5DF+PSUYMp6RyPtNiLaQwT6cD+gmfR78uj7C5RL9+GQMwJ
         bRQSWOcXnJ1zQ6R211Q6VSTYpm/dtJay8rSUJ1Hq34+cy0Zreoac427VoRZ+ev9VCP5q
         /UurnMLpbHiuoxzWIPe8bS8pDmNIl/CJ1CWtBArIJnHyHEWrLgB35eWa1eDX282X4rf7
         IktbzZ6KCGkYMp4R4dfvsaSISFFj2WnqBYYiX/iC6+Nv6S7le2IPR9IvqSoE2GxOf9ng
         p8nVMSIufWOnzwlIxnMK9rW0rfllaEq0oEOfD2dTGVdhjuls+Tq8wvLmDWgZpYXZXVAc
         5OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772510117; x=1773114917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ejc1Nj9JSexTn5t/j4wyckbSfdpkEdCAy4NmiTGXn2w=;
        b=tgH4G4s+GG7Vj4D5+HJ/iLV4mddDJMvi2nhICgLjggwEGk6rwgwEUU6JGVZViBq147
         4MS3LakTVH8sqv+pCVkL1hq2i13jdmW0B3aGmLu4MNyamddSHHNFfA53A+kE84WtV2sJ
         9W71GJD4dJHmGRD2yFNGf+vWg0AwfB/3P/XgDmoMtpVadi/FI5IYevwIzZ5xK4Trm8nE
         PLNAAT3ZVIe9VN/oolbhALakTmRJTi7z2Tirt/vWjSaCvtkrXz9HyjyzBOZ3y9UjL5Et
         Vcq619FojatH4Z/YRU1UTVW4t0sRuzwVJRogaNuFv7EEHn41TwKoU7EI51VI9UzeZC77
         20ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXw2cusYZBbdem2dft9o219ahkbyyu55Xi4oANP0n4y1+80I/s26CL2EMXnhDAZj3inRWMWKDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLCxIvPVTJzaFgXrY9wwbLsROLUPij2ijmwkwsBOsbBuJ2vWB
	14eMW/J44hwX0ytULbwsJ3z6d3LNv/7Gehw58d8AL7/ZYn2vKj9FmGy79oUnoux/SdUgw5xaarL
	j2qefrggntMjjpXew6x5SnaTD78rPXEFpKAUkGtvM
X-Gm-Gg: ATEYQzza6NwTklEMtS46lMXMkS+eCfgEAmPA7zaW6f5vy2AIS7qd+CuPnb9cS6RCNiK
	xuY8iT+ZUHXNDHziVksCvjielkOZ2kqtknFviIP1aN+sUgGuq9HTVXwZNY6GgtBsBK2kxO2Y5xG
	BlNOGq45WdSNdo79BDSxotLSbt59TxDRSygyLhnaO3c/P4R1uBtx1eWvyuLFqs4D4rk9b0rcXVV
	D/lEMRvfPiSJCjq8r/6SI+OMD/On2yiv0moKLJ2cRhB6bhtnzGFNO+L+g9HjAhiKXGCiieFcuoS
	Cd5XuA==
X-Received: by 2002:a05:622a:1808:b0:4ff:9737:dd15 with SMTP id
 d75a77b69052e-507528e0544mr204798791cf.60.1772510116881; Mon, 02 Mar 2026
 19:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225074633.149590-1-leon.huangfu@shopee.com>
 <20260225174354.5a698ddb@kernel.org> <f611be70-8280-44c8-86af-5866c0b302be@linux.dev>
 <20260302162251.733b520e@kernel.org> <3a623176-fc5f-4dd4-bbfc-64d211f53645@linux.dev>
In-Reply-To: <3a623176-fc5f-4dd4-bbfc-64d211f53645@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 04:55:05 +0100
X-Gm-Features: AaiRm52DDhLLpoDehAr1KJ6oYz7Y6Nl096pl0WNYjHph9qwo9g7s3_ZXePnqW6c
Message-ID: <CANn89iJ0=Tx0i+1UXEdcoFuk1F_MfP41-L-kgGDTN+RcLTRcFA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: Add net.ipv4.tcp_purge_receive_queue sysctl
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Hwang <leon.huangfu@shopee.com>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, kerneljasonxing@gmail.com, lance.yang@linux.dev, 
	jiayuan.chen@linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2B32F1E8992
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263030-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,shopee.com,vger.kernel.org,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,google.com,nvidia.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 3:12=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 3/3/26 08:22, Jakub Kicinski wrote:
> > On Mon, 2 Mar 2026 17:55:59 +0800 Leon Hwang wrote:
> >> On 26/2/26 09:43, Jakub Kicinski wrote:
> >>> On Wed, 25 Feb 2026 15:46:33 +0800 Leon Hwang wrote:
> >>>> Issue:
> >>>> When a TCP socket in the CLOSE_WAIT state receives a RST packet, the
> >>>> current implementation does not clear the socket's receive queue. Th=
is
> >>>> causes SKBs in the queue to remain allocated until the socket is
> >>>> explicitly closed by the application. As a consequence:
> >>>>
> >>>> 1. The page pool pages held by these SKBs are not released.
> >>>
> >>> On what kernel version and driver are you observing this?
> >>
> >> # uname -r
> >> 6.19.0-061900-generic
> >>
> >> # ethtool -i eth0
> >> driver: mlx5_core
> >> version: 6.19.0-061900-generic
> >> firmware-version: 26.43.2566 (MT_0000000531)
> >
> > Okay... this kernel + driver should just patiently wait for the page
> > pool to go away.
> >
> > What is the actual, end user problem that you're trying to solve?
> > A few kB of data waiting to be freed is not a huge problem..
>
> Yes, it is not a huge problem.
>
> The actual end-user issue was discussed in
> "page_pool: Add page_pool_release_stalled tracepoint" [1].
>
> I think it would be useful to provide a way for SREs to purge the
> receive queue when CLOSE_WAIT TCP sockets receive RST packets. If the
> NIC, e.g., Mellanox, flaps, the underlying page pool and pages can be
> released at the same time.
>
> Links:
> [1]
> https://lore.kernel.org/netdev/b676baa0-2044-4a74-900d-f471620f2896@linux=
.dev/

Perhaps SRE could use this in an emergency?

ss -t -a state close-wait -K

