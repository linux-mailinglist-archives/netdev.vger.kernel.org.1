Return-Path: <netdev+bounces-268014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCVONndqt2nXQwEAu9opvQ
	(envelope-from <netdev+bounces-268014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:27:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED7293FF8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E8773039DE4
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0C262FC0;
	Mon, 16 Mar 2026 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXSwBLHb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E130BBB9
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627740; cv=pass; b=o12y8uiL8DoI/S2YExwnC39a8OkvLCp+8qlhgEbtNZe1El2wrURHEVD685ky+i3NEa5XkP2hnmnIA0Th/LUshdOQixjJmIyEBi6j4BMP4B7W9sXLitcdsRqvvIE0Ba25ykH+mCgjemAvEmUMAXFN7d/+u/4XMlbwSsgFbqorIjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627740; c=relaxed/simple;
	bh=zOT3dF3Qr1SLBSrSJN4L3csl5Uni8XIh/I9xkzcY5+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ow+ApKNrwrQAMIPm53BK34RWKoF7u1EBdDGDTrpSrIijjOXJBa5aQkSWwB3X8Ni8t+oOhrmd/Fv1H9FqD3x0Ug9Gs/tQmDZlCct3gGpuaJrqwmwK9Wic2AKZrxbES5r6QJJC73AHOk0X2lchgc7gb9NU3LK0ex1jOYppYzFb0Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXSwBLHb; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5091d71aa11so53184801cf.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 19:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773627738; cv=none;
        d=google.com; s=arc-20240605;
        b=UGBEm1JgIVAPn536HqwKoajU96F7AhJcDjQ99jfiXe6J9VyBopVDeejHzTbBvy9pWP
         qmWWstdRXPqzfpl36Gc7GgdGNTQ6G381sqH9xxieRSwlxpB1dMLYDfKgo5iTLrhbFAsR
         QEmY7V4U3ViTen5rpl2IJ+5+ZgYl2YmAWXtgm8c/sBS/TgAT1kKEXPm/WeAEVNawlRus
         ud0qQ3A5HPkP0NlUPyo6BgNUTQ+B234hacCBK0ZbB3mvXLIPqrbXWMTNKmJhL16AW00a
         5ZMUwTTElQGZaw4IvFaNa1wDZD8ed4M2aDHVk1QxO+prkuSPYAgph+L8X2YCKg3YNFBq
         FpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+tNHUxkY7tWmFwLsEk3Hh+UfARSHDjxgdzLE9MaCBMo=;
        fh=enE2G8zM+FlJCQZkuOXbmpdVZEtjKPFUOFc43oP5qFk=;
        b=Ik3oclFrochAAGTW/GOgWacwl8RH6IKeYwnkTxD+8yEHlYM4QLsRW7pp+xYt+BveRU
         PqP52HUndZ5C+2iIF9q6W742ICxTPvRkNxl36zw3CC9wFc94y3reu3RicPoOGPWzg8+v
         B/yzFyz34AEYa0grDjNbV5zqosJYml6q6IbQEvPpsHv+5VK2pSmYXm/bBdbYWrqqG1vE
         FtJvEiEWi9RwulFFr4GNIX3u8OVOsVVnIXR2ARdzSpu+2bWaqcE/ktQomcNsPZK+94ii
         fhjr4fDWPEL2pcExW+WmM9atwddJXY6VcvQ2+nkL/HT5Bb7zs3Xriu16OK4UoNElzTwG
         KMtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773627738; x=1774232538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tNHUxkY7tWmFwLsEk3Hh+UfARSHDjxgdzLE9MaCBMo=;
        b=YXSwBLHb7LF1dRdMuupIZ2a3WrHP55uFTaJIoVa1iOKjVlQyswjC+vZ2hR0WWz8o9A
         gVVil2NfUVlxxsVosqfzsru87WdEBQTMMnmev0Vnpr0/XtSw1DQqfTlo7uNPO2k3E1ET
         E1fyrEKDXRDLq+iwf8DrTym2nPUONt7aXnHNWPSKqj7A+zVaoYYojHFJtxAjvQJNxk8l
         MSAVBzWIJ2UiHlta/4eeAI6rXoWAo/qRTxuGuz4WqIqiX9DRQJbfdsZF7dpuvderbv3C
         hBe+Kzv5xwOH82E+HX6aysmxDc5o+K01T4LkFAXrhYwdnd8//w6iQDeMvNWSeeB/fA25
         /MjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627738; x=1774232538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tNHUxkY7tWmFwLsEk3Hh+UfARSHDjxgdzLE9MaCBMo=;
        b=U8V53P2RW7BGUYBoywyUSQRP7YTB2G5hzi1sYrj63RZDVkKhj9udJAwhqxJYJCL08r
         elLhQDIg0afLTpT3zLEs+6PXgmbpLHmNwf1n5h8tiQBX0eKE/REEsM+X91dYiihBb0ft
         DUWKWBGiFr7h/AfZlQ6eIpApE125JyV4QfYL8yhm/S/GrumdfIJY1ARkFLsA3zE8JEOf
         XhFbyLbkGCJLubPzX2tKbsSyenuflTUOmZxf8wJRtz0dGgJBlg9uvx4OYQX2W3G7xy/f
         xG5xS1+5msQFxDI9rPTsd4K9nOCbpFxHQC1BGUwbzKYtev16yf/3jE25NZ6XjBCm7Riq
         aS1A==
X-Forwarded-Encrypted: i=1; AJvYcCUXL+kcUe5e8IpPwFyJvMkPDg5CUEhpkKa/92Vm+/0ZRfXbkgjZN7FYdlokwflBmtEAY6GVR0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+a9JJIWOwOYhSg44lFGCf9G21oh0BPW+cl/XP5Hq4WvJIpnn
	ORH82kqdSSF2z6KsrNv0K7MgLYj1PeI64zyTnQxYqnFGvInGAfXA0mIAZVgDbfQ3adP9ZrnYuDC
	Us6/67wD2JfmZXyqiAt0xfF3s/PZCQRSaMJ6ZpOgND17hFhVC64SVjEXGoqc=
X-Gm-Gg: ATEYQzyr/WKTkGBp2jUs/+WdxK6gstrRGy5nSatAGk31Rlu8RPvZQqHyN7rLPiunq3p
	tZo9FauxVN3/uxeimgNL7Zl3MqhsmDJbgf8k5N2MstNsnXOYqHuNRwfyFy8w8bniTeF73GJTYIs
	P5RW5++ynuuP6SVIpenp53wgpWc60G2NXa476Gd4LgODXa5hBVtcVbCHRpsfluOh5n6zeg7qrd/
	T8SlTVLebCloZgoqCm9W+X9QaNNVBAMmASWdgv7ljkz/DHCswu8rpeczApyB/l//MCEyTiveMCM
	Z3QVo3A=
X-Received: by 2002:ac8:7e92:0:b0:501:3c56:6239 with SMTP id
 d75a77b69052e-5095714940cmr145199841cf.6.1773627737944; Sun, 15 Mar 2026
 19:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315154003.1851513-1-edumazet@google.com> <20260315145120.1a555d81@kernel.org>
In-Reply-To: <20260315145120.1a555d81@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Mar 2026 03:22:06 +0100
X-Gm-Features: AaiRm52flWYjRFbE53PhfWYNu97gQX1RT5PqiBk_UVjg9LcmI-wgWnZWz21Eces
Message-ID: <CANn89iKLvjHpp+OxOJ4=YrKSm9cVAXe9qcSHcGjP84jLGJH-cw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] tcp: add cwnd_event_tx_start to tcp_congestion_ops
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-268014-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 83ED7293FF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 10:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sun, 15 Mar 2026 15:40:03 +0000 Eric Dumazet wrote:
> > v3: fix tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c (Jakub)
> > v2: fix tools/testing/selftests/bpf/progs/bpf_cc_cubic.c (Jakub)
> > v1: https://lore.kernel.org/netdev/20260313202802.1201129-1-edumazet@go=
ogle.com/
>
> Builds but does not run:
> https://github.com/kernel-patches/bpf/actions/runs/23116079851/job/671422=
96478
>
> The BPF CI can be triggered by opening a pull request their
> kernel-patches/bpf repo. We can also also Martin to help.
>
> Error: #23 bpf_iter_setsockopt
>   Error: #23 bpf_iter_setsockopt
>   create_netns:PASS:create netns 0 nsec
>   create_netns:PASS:bring up lo 0 nsec
>   serial_test_bpf_iter_setsockopt:PASS:iter_skel 0 nsec
>   serial_test_bpf_iter_setsockopt:PASS:attach iter 0 nsec
>   libbpf: prog 'bpf_cubic_cwnd_event_tx_start': BPF program load failed: =
-ENOTSUPP
>   libbpf: prog 'bpf_cubic_cwnd_event_tx_start': -- BEGIN PROG LOAD LOG --
>   attach to unsupported member cwnd_event_tx_start of struct tcp_congesti=
on_ops
>   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
>   -- END PROG LOAD LOG --
>   libbpf: prog 'bpf_cubic_cwnd_event_tx_start': failed to load: -ENOTSUPP
>   libbpf: failed to load object 'bpf_cubic'
>   libbpf: failed to load BPF skeleton 'bpf_cubic': -ENOTSUPP
>   serial_test_bpf_iter_setsockopt:FAIL:cubic_skel unexpected error: -524
> Error: #34 bpf_tcp_ca
> Error: #34/2 bpf_tcp_ca/cubic
>   Error: #34/2 bpf_tcp_ca/cubic
>   libbpf: prog 'bpf_cubic_cwnd_event_tx_start': BPF program load failed: =
-ENOTSUPP
>   libbpf: prog 'bpf_cubic_cwnd_event_tx_start': -- BEGIN PROG LOAD LOG --
>   attach to unsupported member cwnd_event_tx_start of struct tcp_congesti=
on_ops
>   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
>   -- END PROG LOAD LOG --
>   libbpf: prog 'bpf_cubic_cwnd_event_tx_start': failed to load: -ENOTSUPP
>   libbpf: failed to load object 'bpf_cubic'
>   libbpf: failed to load BPF skeleton 'bpf_cubic': -ENOTSUPP
>   test_cubic:FAIL:bpf_cubic__open_and_load unexpected error: -524
> Error: #34/14 bpf_tcp_ca/tcp_ca_kfunc
>   Error: #34/14 bpf_tcp_ca/tcp_ca_kfunc
>   libbpf: prog 'cwnd_event_tx_start': BPF program load failed: -ENOTSUPP
>   libbpf: prog 'cwnd_event_tx_start': -- BEGIN PROG LOAD LOG --
>   attach to unsupported member cwnd_event_tx_start of struct tcp_congesti=
on_ops
>   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
>   -- END PROG LOAD LOG --
>   libbpf: prog 'cwnd_event_tx_start': failed to load: -ENOTSUPP
>   libbpf: failed to load object 'tcp_ca_kfunc'
>   libbpf: failed to load BPF skeleton 'tcp_ca_kfunc': -ENOTSUPP
>   test_tcp_ca_kfunc:FAIL:tcp_ca_kfunc__open_and_load unexpected error: -5=
24
> Error: #34/15 bpf_tcp_ca/cc_cubic
>   Error: #34/15 bpf_tcp_ca/cc_cubic
>   libbpf: prog 'bpf_cubic_cwnd_event_tx_start': BPF program load failed: =
-ENOTSUPP
>   libbpf: prog 'bpf_cubic_cwnd_event_tx_start': -- BEGIN PROG LOAD LOG --
>   attach to unsupported member cwnd_event_tx_start of struct tcp_congesti=
on_ops
>   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
>   -- END PROG LOAD LOG --
>   libbpf: prog 'bpf_cubic_cwnd_event_tx_start': failed to load: -ENOTSUPP
>   libbpf: failed to load object 'bpf_cc_cubic'
>   libbpf: failed to load BPF skeleton 'bpf_cc_cubic': -ENOTSUPP
>   test_cc_cubic:FAIL:bpf_cc_cubic__open_and_load unexpected error: -524

Maybe some black magic ;)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index e01492234b0b349498f8e56c2f07d8bba092c00e..008edc7f6688523dc86963d9048=
5655e9fa8374e
100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -272,6 +272,10 @@ static void bpf_tcp_ca_cwnd_event(struct sock
*sk, enum tcp_ca_event ev)
 {
 }

+static void bpf_tcp_ca_cwnd_event_tx_start(struct sock *sk)
+{
+}
+
 static void bpf_tcp_ca_in_ack_event(struct sock *sk, u32 flags)
 {
 }
@@ -313,6 +317,7 @@ static struct tcp_congestion_ops
__bpf_ops_tcp_congestion_ops =3D {
        .cong_avoid =3D bpf_tcp_ca_cong_avoid,
        .set_state =3D bpf_tcp_ca_set_state,
        .cwnd_event =3D bpf_tcp_ca_cwnd_event,
+       .cwnd_event_tx_start =3D bpf_tcp_ca_cwnd_event_tx_start,
        .in_ack_event =3D bpf_tcp_ca_in_ack_event,
        .pkts_acked =3D bpf_tcp_ca_pkts_acked,
        .min_tso_segs =3D bpf_tcp_ca_min_tso_segs,

