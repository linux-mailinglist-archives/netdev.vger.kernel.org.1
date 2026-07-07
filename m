Return-Path: <netdev+bounces-305618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1YC7JM+CTWqz1QEAu9opvQ
	(envelope-from <netdev+bounces-305618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:50:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B3720491
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:50:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=everpuredata.com header.s=google header.b=MBCnfe1e;
	dmarc=pass (policy=quarantine) header.from=everpuredata.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305618-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305618-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9CC83037D52
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 22:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA29346A1D;
	Tue,  7 Jul 2026 22:38:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572B314A65
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 22:38:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463919; cv=pass; b=QoNQwjUC5LpQOTetwLGBmBlHVHZzF29qZ1KPEUOgjcBv1JvbSDCeXm+qm9IujUxl+kaAwX8MMV1ejDc1bFd4A9i2snDn9kHZGjHLlbFES+XhL//NjsbYuLX23gGMPNdnwLIa1VLlROC7Qg1xtRitVQPi4IZora3y2SES8MrelSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463919; c=relaxed/simple;
	bh=+706iKs3HtU8uwYBgqTLy3ryLrJrgFejzKV9JW3HFcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXJvbvZX+D3wug2zfSVZtyBmUb8w8bY2WtwgYwTv8EpWxtvXTjKjuTokRTJ2XThyIh3tYP2oLlcV19zqfUV+Bpuhrd69zCGKwY5lir6iBq/06sheUmNpootcW6phoIkSw/SUd8ohbuCpyZ2GwAQvmaNoeAC3B4N9Ppx5ubZN+Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=MBCnfe1e; arc=pass smtp.client-ip=209.85.217.41
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-73b7c3791dbso16566137.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 15:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783463917; cv=none;
        d=google.com; s=arc-20260327;
        b=LyhizUkRU27FnkGaqrLIECNBzve71IJboAS+9YNJ5OLjV3ldHb24FsCSVu5KGOjoMA
         RgXfxtQ8lPSwmKee8l/qKI3wpCxC8Nvlgd6KC92HbB/c+2pSD8p+N+jANc9kjfHjXJdJ
         n75yP91/IEixBuEm1q7OcZ+wWfvYAncaljiNZaNYuam32nl8Rmp9h+FXiAtyvIc68SzW
         9ikrPc559d/x2SXNyyG8MLsKKluyApBKnp6nnW5RWGIjyJTAgnpGRFXPBcRy2HBNhSI3
         dAYPM52BEaEpBvzCbC9w0zaLtlNf6REcH4+bfnsorjDQRgrRkSorz7khxkODjrR7ZxcS
         Qs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2yp2ZaGx23q8R3iPZhwW6u/KyF4IRtLz3bFvQN0Wh3A=;
        fh=jalqJ3L6lzNrLiQ9CNNPKnQWpkLrGAJK4oPuVLTX8hQ=;
        b=rvd/9DiGZO6K1EoV3ePx0PiGorN970hn8tF9zEnjFQp1nmhceROvI9m36wt3ZztIWn
         SLAG3W1ZeP+F7rtubz46zNUcInDjdBK+8S+ceT7pcyzbewex7BOiwovMoP+fYHiUHxNI
         UGTCgPvI1Pxxtx3udcNIFc1uzQjeu/I3eJtXK9o0LUmx7O1B3g2hancr4nTXEQTMEPAy
         hqxyEdvK0Nj78NjzEuB/KWHqMMkOnsiktY4eJW/mqatE5rqH94e/bqqOI5vWTywNUj6g
         4dWtD9hZstPsAWHByOqI0acfT+0FUI0UHds/8m+ci60rrj3rhOK1dYhMWPMND7cBViyt
         QuAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1783463917; x=1784068717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yp2ZaGx23q8R3iPZhwW6u/KyF4IRtLz3bFvQN0Wh3A=;
        b=MBCnfe1e1URI32mY8k9S0OjddhFxbu3Tbpob1ZpYtctUvw7oeUazRRYyuzjfZctvUs
         3NCZj9bY9BhuWGfJgUflyQQbmaOLrDqwbNXkoTeRBXuCI65H2Rp2Xf+ts9KKhRxTOYJZ
         7QOl4XhJIzD8Q4Plk0JB61tg7s72MerzsL6Ce4fWGyvFQSX5MvqHkdZOM7jQrbT+lRMy
         sR1ZGU9IJQCLmB1PRJ0Bra74XNiY5j2TG9OGUwd2cklPvT7tZNDUJTD+38V2FOtdSoQJ
         AdyvVtNm0B5qnxk31mF7JFwRfSz9/NUgbV462ulBPt8ihZyzTzaPfKT6cfguO/RYzDZK
         FG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783463917; x=1784068717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2yp2ZaGx23q8R3iPZhwW6u/KyF4IRtLz3bFvQN0Wh3A=;
        b=Zrq63Jt8bnmoiBdoajLIPvyUs+V8BNVna39QD7OuOsjR+24TphX2A4w9zIX+d+txM4
         DtCK9F6Ozhr6GRpfChSJOsIScXEvCIwOBB2TyMx09yfo7OK2GDHa1/If+znfxg+VcaS+
         bs5BpG8SxQZxg6TGhz5pKhges8/XuNl+NzSNmZ9EC1l6ppKW5TVDbSnoY39+33aoFRB+
         Igimt+728t8M2zJwkpPF2mGdzeqq+TO8cDjmCS15Yynj55jH7QvkKm3OSgYhQlP1jofe
         LDcMtbsq01WufJxUK7fbiw5+iwCoXl69SLi//6vihsLEjd1dou4QF9SZAMpxNZCSDrmu
         HXzg==
X-Forwarded-Encrypted: i=1; AHgh+RpKYazLfDuB1AwoovTh1lA+rpztN+z6cvWLhEb8YimrUG3wlVDSFrXRUM57ZOe8XDEagPo4Is4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwpRb38U7pEOXV0Oq/KUtr7mC1K105bBwk1WZVredYfLL+yY3
	B2ayX2XaUaw7nso2IztP09u4VYMqrEnO+6bZlKVPAvOmx1kWoIH1Gg7PY+i9RIy7nYLzZbbL4Xg
	vP/SAalO2XhLq/7/iYworzSQou8B5oRpH9Kub9JivHA==
X-Gm-Gg: AfdE7clhelz57vrMbvgX+lz0AmKtBGb5U1w7CSMJ1Ga86iMXRVAQnmtQPDksG33re69
	gCLPRptLyhlmTzz352+rrmOP03LwuSjaiKGyGN/qZkYm1Yoj9BRpf804gQHp9E63uxak1aoQNwL
	iBTaYz3MM0LTIaoCX3wwK8ZLFWpsjnRgo2n5jjxEVa1aoa6/ydYm4LwjEfyQqvQITfFRzqvCs7N
	VYYnqq8QffMP8ZagfsytCRHpiPL7r2SjHE4BMT3pa0uI2nDY31PwrMf/xI1BkoX1w3Zq9cmKrNS
	ibUUm7lB1nLozwSlfrx1uGe9lfa8Hy/MNy8lApor63BMbOjC7stmC9hc1p7NMRHfsq88kyZMPtt
	KiwRF3MVvsyO5oqExvFmylP6jeY8/BjvPzmTAbX8v2CF2LG12JLxiRn3wFdmtohPMs14=
X-Received: by 2002:a05:6102:c01:b0:738:fd01:5b63 with SMTP id
 ada2fe7eead31-744b7a7694emr4061751137.4.1783463916751; Tue, 07 Jul 2026
 15:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515212715.3151307-1-rjethwani@purestorage.com> <20260705104419.4014-1-nils.juenemann@gmail.com>
In-Reply-To: <20260705104419.4014-1-nils.juenemann@gmail.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 7 Jul 2026 15:38:25 -0700
X-Gm-Features: AVVi8Ce3HFFZNYh1gN1x-OK90K4K9Ev7G5xyNE8ckKkLNZpGpsyMs-wV00FT-tQ
Message-ID: <CAKaoeS3misLGVi4wEqQg3OwbisTBfB0zx-i3b81g2-vnOS_UYA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nils.juenemann@gmail.com,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:nilsjuenemann@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305618-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,everpuredata.com:from_mime,everpuredata.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC7B3720491

On Sun, Jul 5, 2026 at 3:44=E2=80=AFAM Nils Juenemann <nils.juenemann@gmail=
.com> wrote:
>
> Hi Rishikesh, all,
>
> Another NULL deref we hit while testing v14, on the RX resync path. Looks
> pre-existing in mlx5e rather than introduced by v14. TLS 1.3 RX HW-kTLS,
> mlx5/ConnectX; seen once in ~3 weeks of load:
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000030
>     RIP: mlx5e_ktls_handle_rx_skb+0x10a [mlx5_core]
>     Call Trace:
>      <IRQ>
>      mlx5e_build_rx_skb
>      mlx5e_handle_rx_cqe_mpwrq
>      mlx5e_poll_rx_cq
>      mlx5e_napi_poll
>
> It faults in the CQE_TLS_OFFLOAD_RESYNC branch, in resync_update_sn():
>
>     resync_async =3D tls_offload_ctx_rx(tls_get_ctx(sk))->resync_async;
>
> The NULL is tls_get_ctx(sk) itself: RAX=3D0 and the faulting instruction =
is
> the priv_ctx_rx load off struct tls_context. CR2=3D0x30 matches
> offsetof(struct tls_context, priv_ctx_rx), and [sk+0x4f8] is
> icsk_ulp_data in the matching vmlinux.
>
> So the socket returned by inet_lookup_established() no longer has a TLS
> ULP context. resync_update_sn() reads tls_get_ctx(sk) twice: once in
> resync_queue_get_psv() just above, which also dereferences it, and again
> here, where it is NULL. This looks like icsk_ulp_data being cleared
> between the two reads, i.e. RX resync racing TLS ULP teardown. In any
> case, the second read is dereferenced without a NULL check.
>
> I can send the full decoded oops or kdump specifics if that helps
> narrow it down.
>
> Thanks,
> Nils Juenemann
>
> PS: aside from this RX issue the series has been solid here. TLS 1.3
> HW-kTLS TX has been running stably above 100 Gbit/s egress (~99.5% of
> eligible TX traffic HW-offloaded) on AMD EPYC (Zen2) from a Go server
> using a small in-house kTLS library and sendfile(). On this workload the
> main win is not just AES offload, but avoiding ciphertext writes back
> into DRAM: our measured DRAM-bytes/egress-bytes amplification drops from
> ~5.4x to ~2.2x. Thanks for the work on this.

Could you please send the following from the dump:

Full decoded oops: regs, stack, and ideally disassembly around
mlx5e_ktls_handle_rx_skb covering both tls_get_ctx() call sites in
resync_update_sn() (ktls_rx.c:486 via resync_queue_get_psv(), and
ktls_rx.c:553 directly). In particular, I want to see which register
holds sk at the fault site (RDI/RSI, depending on inlining), and
whether the compiler emitted one CSE=E2=80=99d icsk_ulp_data load or two
independent reads.

State of sk in the dump, once you=E2=80=99ve recovered its address:
crash> struct sock.__sk_common.skc_state,__sk_common.skc_daddr,__sk_common.=
skc_rcv_saddr,__sk_common.skc_dport,__sk_common.skc_num
<sk>
crash> struct inet_connection_sock.icsk_ulp_ops,icsk_ulp_data <sk>

icsk_ulp_ops->name if icsk_ulp_ops is non-NULL. "tls" vs anything else

Only if icsk_ulp_data is non-NULL in the dump (i.e. NULL was
transient), the TLS context fields:
crash> struct tls_context.rx_conf,tx_conf,flags <icsk_ulp_data>

