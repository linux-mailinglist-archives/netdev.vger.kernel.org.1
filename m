Return-Path: <netdev+bounces-273433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BwKNKQly2lnEQYAu9opvQ
	(envelope-from <netdev+bounces-273433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:38:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D03631CE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9782305A8B0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063A23630AD;
	Tue, 31 Mar 2026 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZdffUEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EE306498
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920968; cv=pass; b=Xcn7/Fs6X+dTJl6X5kFn+0frFrgzQqhWaLUK+3+l6VTIPhyTeIySI2hFvhSpsvj0Ok7Ih33eWxZxrFhcSZ+gCnElTwk5uCVbA3iQjWmYgfJIS1BLj0pLfQ2TRF1ISf3s6Jv8Z2dEJfM06fNNwBIGmPR447B19R+ASQowhwB8grU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920968; c=relaxed/simple;
	bh=Fd6QAcJI16f3MqUm0f9PMci/8jTCJThqTHKrceWrBx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6Fx+ji6sEFY7+oy6Y+LySOMZ8D76ID3udc+CBukCYrLgBnS+0EC8+KpKGC4PgaPTk+W/Bhnt/FZzVpCtWGzuneK2HwP/lOmYXpKvi3V8dIIQBTKfCbK8C6LpNlH7yWxoB7ZBevqU3100lL5FvJFGzY6lj7yQZr+mgrA9J6zseo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZdffUEh; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1271257ae53so5131713c88.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774920967; cv=none;
        d=google.com; s=arc-20240605;
        b=DRK1GIEkol9y3QQjRlSn9bH6eujGJIVIHuvx+0lPoaOdKZzKlJ0R9bGGHKIrp4SefR
         QJYAicDps0RXVySzTr3CmqrWwLv6o3wOEoXj/blW914CHc/baV2y0gor1eWYOWrk1Ujh
         miyw+Je/KmtjQ7l1cT0JRohEFDqXU56g0FhHKjDXFcrAMR3pI09ofglOala7jqq7BKf3
         dng8WZ+xy/PHQDgOyzTWg8Fvsr5UqWNaPJgDOo6oNcY6u6H6Bytu3jYiIK9IFmW3/6F5
         CaC/7W8xNmg7dAE9m1JBe3T2NNE2caktU7HE7rWqtoLWIWoWV+WSbGJxGtaXZkHHjz+h
         n6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=65uWDB0Qv6BzU+J5GLRhSZeSW/d9SMCtWTbJ9K48rfo=;
        fh=ITILdp01/U0eTJDYfXXAYRhlmDnuPLyc1GdZzAHzwOc=;
        b=ZNudvYXfQ5lm+YQ2dWOM9yFebu0kbzMWGcAbK/ZRniBtjrw832YRtyRXCGLZf4V0jk
         nNUAd5Zd4IOEhhtTYj7HVO9hSEMn5QR0gMcKTHkv+vMG8HudAKs2MaCszc3K1HzPj8RO
         s5LuICNxuFNA7DnFL1QE103vN+Nn6zXt6HAR8rgPMOUXghHOwQP/KEHf4AAXkRkkRja8
         YC2w7XURWOKZgtuoeCgCfHw5kbhqEf3GcRDbth/np9pNLBF5MZgd3PzWtd20EhH5JKOX
         cBW0sYjc8cmNIIg/C8/uN6XjXxuuqnskRvVpyfRTbCHqgtrqzSg4b+ugLSh7tjV3/Tfw
         wOzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774920967; x=1775525767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65uWDB0Qv6BzU+J5GLRhSZeSW/d9SMCtWTbJ9K48rfo=;
        b=bZdffUEhwZTj6I+/0BWDtD7Mp6Ve92s6jNMnchowHJCU8Hq1Uq+75AKYcxyQd8/Cja
         HT8G1lYvQ4qq0y7HM5IpNIHiZv2e8/g7NyNXzRYdkB1kC6E3HK3g4CaopapLtfSSzj8f
         dcbhPJsiU6Ejng5l3p+eJxB2sV9tF10WiCcl24T0QWhyySyleAosf1qE3ij3mcGV6VFu
         dt6fD1d1zSCoumt4EkeAG6sIiUhml3HoLPcFxwgWjMwdgQI5VrGJZTLq1R8av85TrrC1
         91sCydZ1uxr+cf4idGzF5z/qntMNHzO581DKRJpjKAPEoGrBtiny94wLyHf0Xd2F1/RU
         PSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774920967; x=1775525767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=65uWDB0Qv6BzU+J5GLRhSZeSW/d9SMCtWTbJ9K48rfo=;
        b=g5iuTioekPM8Vu/luxU8Zl+RItw3WPcGEulj0kN8A3CdQ+RbzaFL+2WxILI+d0Qk4Q
         Yt/Hg34Mkdu4KKEOYENNTFCF0Fm035Fb5UCwXqTrFZXd2i7h5bkUXwNecdZhPMWIXR2i
         RbpRj3qivsdhx/BNhc+wOOxN5UMbqkasmRhGi3QIRRqQETUMraeZ9w6nXo4WlbD6A0Gq
         LWZnbdij4cHf/CmJ8f2Vr+PQn0uACTrupuJtBKYsvqjTjKD51Lxi6hLWuuVGfgnuDbtU
         dyp8bkptM31WdXKfqevGSAX8Y7B/Urk/VBrT4YyOnkw0khuR2PBsNzCaAd9mcM5g4z7r
         s3dA==
X-Forwarded-Encrypted: i=1; AJvYcCXToCByW8RI+L/gaP85jVpbwwa2K9aN8fk0KKysNVovWuEAP/GRWrTamr2AbTbVcg7Rcxlyr+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZmtxQTn3GmyKbCHZfFUJysLL0Www6iqSeSeszK+OexCUlY0j
	knro+QJIPG900sY9nMxNa29sIsXRivEA89X/Ds7QlJ+9Y8yauk5h8nudE9zQEmdILw6WNohGSs3
	OIb0hPeAVRYgzopwAxJovyFUPrUFieJ7da7MOL2Dg
X-Gm-Gg: ATEYQzyJ4az3YcxGFnj4wZmJsA5NtLMX1gFxdI9kjkCxvf7++HLLA3um2xBhD3ns1b4
	LV3HlBkW0f/WvLuNXz+cqNKYgrQM8BUYQDupWW2n2j+RDulrTFi4BN+y1z2nLFdCB7Dopn90aFK
	g0keylP5C5g4Xmiv9wxZxg33Ym9GQnDxo2W0F5t3zdFf7ghe9u9W/FmLXf2T9yT1ChJNQlD7ONr
	vzQGuK3KsfiZ9M23b8GMLBJWc767p8j39pMyzXv2/xfFdSn5Z+mbrpkZJDOFPpb+DyNiC6NKdD7
	MqqVe56g628b+Sg9i4fpN2/9xwfp8dbqpZc6e7HCxwku0VqyUU9YBMIzk8bCBosv6OPDVgMK
X-Received: by 2002:a05:7022:220a:b0:12a:6c4b:9cf0 with SMTP id
 a92af1059eb24-12ab284bbddmr7115803c88.3.1774920966145; Mon, 30 Mar 2026
 18:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330080746.319680-2-jiayuan.chen@linux.dev>
 <6ee24770a2b014219d86839b2243e1b7bad4dc4f520457269d5e8ca2b21c2cb8@mail.kernel.org>
 <d1a739d2-c4ea-4fae-aeaf-f49e75dac0f3@linux.dev>
In-Reply-To: <d1a739d2-c4ea-4fae-aeaf-f49e75dac0f3@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 30 Mar 2026 18:35:55 -0700
X-Gm-Features: AQROBzAoWaoGMz8lgwUE4cc5pzeu3Q6dad4Ef9SHjpneA1fRPQ9yGPYn9pz2kSE
Message-ID: <CAAVpQUD1n7L6LkP32H_Ct71RLNpJ2RQWFc8w08+c8h=U_tDjpQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, clm@meta.com, 
	martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com, 
	sdf@fomichev.me, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, 
	ihor.solodrai@linux.dev
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
	TAGGED_FROM(0.00)[bounces-273433-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,meta.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 323D03631CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 2:26=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 3/30/26 5:00 PM, bot+bpf-ci@kernel.org wrote:
> >> #if IS_BUILTIN(CONFIG_IPV6)
> >>      case htons(ETH_P_IPV6):
> >> +            if (ipv6_hdr(skb)->nexthdr !=3D IPPROTO_TCP)
> >> +                    return -EINVAL;
> >> +
> >>              ops =3D &tcp6_request_sock_ops;
> > For IPv6, ipv6_hdr(skb)->nexthdr gives the type of the header
> > immediately following the base IPv6 header. If extension headers
> > are present (hop-by-hop options, routing, etc.), nexthdr would be
> > the extension header type rather than IPPROTO_TCP, even when the
> > packet is a valid TCP segment.
> >
> > Would it be worth using ipv6_find_hdr() here, similar to
> > bpf_update_srh_state() in the same file, to walk past any extension
> > headers? The IPv4 check above is fine since ip_hdr(skb)->protocol
> > always identifies the transport protocol directly.
> >
> > In practice this is very unlikely to matter since TCP SYN packets
> > with IPv6 extension headers are essentially non-existent, but the
> > check as written would reject them.
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See:https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READ=
ME.md
> >
> > CI run summary:https://github.com/kernel-patches/bpf/actions/runs/23735=
111188
>
>
> Thanks for the analysis.
>
> There are many places in the kernel that check nexthdr directly without
> walking extension headers.
>
> I'd prefer to keep it simple for now and leave ipv6_find_hdr() as a
> potential future improvement if needed.

+1.

Given this feature is to create a reqsk to process on this running
host, it does not make sense to support such ext options.

