Return-Path: <netdev+bounces-296719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7oraAlIsJ2qxswIAu9opvQ
	(envelope-from <netdev+bounces-296719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:55:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F965A8E1
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:55:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=s2QqLDp9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296719-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296719-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E11803012541
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 20:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4503A48C5;
	Mon,  8 Jun 2026 20:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865463A1687
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 20:55:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952139; cv=pass; b=nuncidn8oCvK0eEW6hLb0aiim9QBdYFyhsJwdMttYQYQIeOlZSqpGhUuSqLdJcCJjbzhnnOAZK8L1oO0TskIt7Z+bQpq6nfs933qXJkRc4D36nSaIW8fzFiaSZsYYuQ42S9TgI9ErjU3uWNoB00Z7vx1NhRG25TgLbWclrMdLdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952139; c=relaxed/simple;
	bh=bGtzFFBnoXEhZVNSTDAVHXSCy3yikKw674g7i910kvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie3fnNX8KdB0LmsclquGQRn/rvqBcguNcWSCU9nodBdNXVhVr2sF3ssC60CbGz5D4s7ykSmXPAwrWppxF5YROUcRFBMjJXMsGAnPSVPi9O+kn97Kaxo46f0WM1R4vIAxKiAbW3Le3STQcvo1wflSoncCq0RoLwpvl2XlEKf+V9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2QqLDp9; arc=pass smtp.client-ip=74.125.82.41
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-13809223fd4so4145344c88.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 13:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780952138; cv=none;
        d=google.com; s=arc-20240605;
        b=k8Rez2aDbmmqS0uVNrzX8rGdpb4HZqFKEVc/SqRQofD85Hznnp0Xcx2jKNdG+2mHFv
         69jMyfG4XtqNtbQUtCkC+wQvwhFEI6jcrCCqiGJB3hbFZbkJeUWoAZr5D3o+2zTNs683
         Laq7C3f7R32QoY01p9A5tFRK9NMDuKNqG+dhuECL+M7an1f1c1J/pUGr7fBBThBQYSFB
         uoKs6D50bJnSSvBKx45b9Eep4W7P1MjLJF2mSNdwPIEG6I8nkssSL9qYj+DqFbaOPg8x
         26NnJ7cTXeNkzIDzZ5d0n1VU5N4DlYWFBTR8UO5Q90JpkI70AjpakvZ8apFx8JMS/f3K
         RCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cj99u35GkuQHW83anj+PxNMaqIiv5iTy7TcOXLK7r+Y=;
        fh=yan7JvrqlO2q2JnX0JG6Qv/jYsGKBC3saSEjSg1LbVY=;
        b=SIJq+MCgCcUL/57eQrFMZSU+TNKwJEXFvSwxpHzpg5RBFn3R9APds9M4noWuyGwKHO
         X/KFXXuVkrW+HUxjoCLYrOemkTAGfLxGMlL2syguHxGXzjvwJ2mBVGq+d2cWK1FI9xXX
         oH1yrI4dT6RKSVbvUDk1crcuV+/RjItmv1deF93DKrTwNTDFOFftPNWUWXbhjyjrzh25
         yUgyX8lD22hDXutR9VQBxTB36tcqFX20WGcrIhT4VZce/Pfe1NkyI9KJ0xi1iDdgh+00
         BAzEy0TH0EKtUk5Nuqt1EaAXjL7TrHT8SRHVL/pwUpCOa4IcyyTbYimoiOvtFiqkA8d8
         mzGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780952138; x=1781556938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj99u35GkuQHW83anj+PxNMaqIiv5iTy7TcOXLK7r+Y=;
        b=s2QqLDp9XrrWOGmFJ1MKZT1i60QMzpv5ZpxkPwapPijH56t6sLElVNYhpagFn4tHhW
         qDZQ02PjzDY+FtkwsSDmLNFSjnM3hLM/Q287EAJ/T6xU70EjB+MYhib9sP60ho4WKeWF
         eVADLhMM2TrOgM2Th8VfqZ5xmrKaEMH2cLPOY19nhnpBQYL5J3DRZPubvIe8mGArNdsd
         2a8SVRSdzy72XgUTQgv4Hn/sB5nTBC5qrDBjQN5U3rwD6QDeGstnQpZP06RsOK4O4Q0j
         mnryWYSwQ5cuTcw9ZOYYenuHZH9JT2eHlY2lYUlowwWcuTAGb//PRZlpWg/xyzOUmhV3
         1GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952138; x=1781556938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cj99u35GkuQHW83anj+PxNMaqIiv5iTy7TcOXLK7r+Y=;
        b=Et5idLH6BRWAmaucz/xRq5EyBfI/KOsQsR7pw7tL59fFfTmSLtUpUmPsPy3hjT6iIQ
         sxST6blz1PyD6wlDGIbCEM0BJI9Z52SmKc8WG3WLA3+4yc5dF7e+pJdceyCDjsjVyQEK
         huXkfHj3IKepj005i+hzUpn0ofLEDGqYT4NyfLEXZBkZ/Bb8B98VCctnFr6yjPUNydfO
         DWx8XGkg0Yvx2ok+5la1YhLB7YbR2AwHcy1VXTi+dNn042UTjWRy792FUvghN9ul+MFp
         TVANQ7z9w1jSTS5j4ua+YJGiyy+YeOL6fXgWGYEM2Vb7eRvF5yFlxoeRSaVim052N9BT
         AdDw==
X-Forwarded-Encrypted: i=1; AFNElJ+fL3/93sTM3v+EAYxXujLrDQFrOX80+cQp+AoJk/ceaxU1WItS0lc1JBelaj9pDmvDFMvuTu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mgom+W7RxeFHS7rczYr6yWViVjx8IXEsmThzQNOC/R2rxLdF
	a98ps71w1HqmPG2AwH2eGDM0WlNc531ncGf+BlW+5FaK4RaMmNO46NwpWX/82FrI6RRq3+hrMNh
	4usjjvGYnDrXLX45Wg9JZTR1lqyKBvqYf8bgkQL71
X-Gm-Gg: Acq92OHvPrH8dJdaCe2wsz3VFHgsar2jBzraGqdWubMnDTwsWpLnG/natRNZ8SAgwYj
	OiXD/Q6/BCccaX+S158EPwe2YzMlH7AgUrb3YLp3M2uW5PmWm3XGFqb3akJmae2DHqmPBjXVvMW
	30pLH6MG5r37N4SKPnkUUuj+3vooekoq6Wnx6jD9IMNV1IBhleoeLU/M7IZZwaW6yDElEB5ERJc
	4X7EIOmDWWEI59xiaUqOmuwHaCAev7Pspm8jqsUueNnvqhsqIMcnGH4U7nrJkdSlSnCD/4xWtPj
	918I2hHAoyufJtw72mAjZ5o4sz3gaL+zAEjY/UD8raDImnEvs2dmpJfdNgH4yPNZdjeZTp0wlw0
	va1WzxF1UoMVJUrN25mqw9QSm/Db9epWwTMX3qLrddkQnZaLuWHMbFmR5dcuSmCsd1OcHxLE=
X-Received: by 2002:a05:7022:fb04:b0:138:51c:c5bf with SMTP id
 a92af1059eb24-138066c6ab3mr8922615c88.15.1780952136864; Mon, 08 Jun 2026
 13:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev> <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com>
In-Reply-To: <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Jun 2026 13:55:25 -0700
X-Gm-Features: AVVi8CfcOCPt_p28nph01Kh8d_ahK1oBr_59XCUgMmWvjwIoHLnnauWUude20WM
Message-ID: <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Joe Stringer <joe@wand.net.nz>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296719-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,iogearbox.net,wand.net.nz];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A9F965A8E1

On Mon, Jun 8, 2026 at 1:02=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon Jun 8, 2026 at 10:21 AM PDT, Kuniyuki Iwashima wrote:
> > On Mon, Jun 8, 2026 at 5:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux=
.dev> wrote:
> >>
> >> bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
> >> causing a panic when the skb enters the wrong L4 receive path [1].
> >> An initial attempt tried to fix this in the BPF helper by checking
> >> iph->protocol, but Sashiko [2] revealed that BPF programs can bypass
> >> this check via a TOCTOU attack by modifying iph->protocol around the
> >> call:
> >>
> >>     iph->protocol =3D IPPROTO_TCP;
> >>     bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> >>     iph->protocol =3D IPPROTO_UDP;
> >>
> >> Furthermore, bpf_sk_assign() has had the same class of vulnerability
> >> since its introduction =E2=80=94 it can assign any socket type to any =
skb
> >> without protocol validation.  Since the BPF helper check alone cannot
> >> prevent a malicious BPF program from crashing the kernel, add protocol
> >
> > I'm curious about the BPF maintainers' stance on this kind of "bug"
> > where admin tries to shoot oneself in the foot.
> >
> > I saw Alexei said this recently, and I guess it applies here as well ?
> > https://lore.kernel.org/bpf/CAADnVQLh7VEKAtckzz=3DXOVPT8ovpDQshvPPCWHDQ=
u2OWQx27_w@mail.gmail.com/
> >
> > ---8<---
> > Not every "bug" needs a fix.
> > If a malicious bpf user wants to crash the kernel they will
> > find a way to do so. Especially with agents.
> > We cannot realistically close all of the holes.
> > Right now the priority is to fix the issues that normal
> > users can hit and not bots.
> > ---8<---
>
> In addition to that I have to add that skb_steal_sock() is performance
> critical path of networking stack. Adding runtime overheard there
> because bots can find a way to abuse the interfaces is not a good trade o=
ff.
> If there is no simple way to fix it completely on the bpf side
> then we have to flag this issue as "won't fix" and move on.

I asked if we could fix this in the verifier but it seems difficult. [0]
Since this is triggered only by BPF misuse, treating it as "won't fix"
makes more sense to me.

[0]: https://lore.kernel.org/all/202648182730.i4ki.martin.lau@linux.dev/

Thanks

