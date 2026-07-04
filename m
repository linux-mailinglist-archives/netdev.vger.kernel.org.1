Return-Path: <netdev+bounces-304684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hvxVFiafSGoIsAAAu9opvQ
	(envelope-from <netdev+bounces-304684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 07:50:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08BA706B55
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 07:50:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UICjz+Bg;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304684-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304684-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF97300F952
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1067738424D;
	Sat,  4 Jul 2026 05:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8F381B1C
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 05:50:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144227; cv=pass; b=TXrZ+zCnqgJELTkf8OLCn5FIIwxIhzK6DowLv7atyW6pdOZlmuyp1asmSO0a7nnUM6bgJudFakO68QeI6q6JirOMsBA3S96kxenv60ZSFjznEhtdt65yODemrKJJVxDrGlYpDewNZ3gurENF9fnzBJonQsHKanKeLBoC21scpRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144227; c=relaxed/simple;
	bh=ZRYk8rUc0v5PjnNM82oYLX9kGjn4ucYipOPsdxWXZY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/+s/4i+WIlueA7O21JVXPX26Q+oGmp1apxZ28jaA3tfxZSoHNR4pHP8YkdFBZIFRGNkNmn/ek2tOdIsDDBBI3iULmrpkn2MnqeRr3IP6oYf+Vk71RBVLBRnqAhbfgBiHQNTcZnN+9BuJxx8CiVHQRDmhSJ6ZXY/OtR4q6y9Q9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UICjz+Bg; arc=pass smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4798bea72f9so754462f8f.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 22:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783144224; cv=none;
        d=google.com; s=arc-20260327;
        b=LckvlVs5DRi0VoZaS+PQO7TchLl/2bxPkGeCYoQW73qdthC9UzKmsWF7UQsMsTmRXs
         G3MuXPMjyyZJQrB2zrcyrgD/518+gxyZ4Nax5jQujuJogNl9aF7aw3DghnT7uICwgQTw
         KdKYp8t0zWPSWJDbzrzlWD48SincYpMvW284kor4FTt/cbwDc8rGhWe2e7Pj4PhO0/f8
         QYF4aY2VWrWKaz2rarQh1hfkTO4NxQHlmztMycQOgZT4q8aGUfgO4fYUCDdg93nYK80e
         GRvOyew9t7F+5v98YW9zjhy+w/D6Bmwk6bYaGjnyxZuJIuWr4auaMJnPnEZT/F+sZa11
         5dfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6+6YmgpaeM5juotgbcQnSfBdzNCdrt/VISxrQFcbQHI=;
        fh=hG3SgtV8NExFJskVc8NpU2i/fuUHHrhnw4ZEoY0XDQc=;
        b=oeKZg1K1dNv5hFy+YGHDMhhp0W8gF86xPDrFQt3jZYprH4qcmdxDcOtHzj0vCGcJ/z
         ezEDUY4iEtUY20X2yC7Tqn2KjmLtvJdg1M0K4lLbc+n4ptMB8c0x1ON5txOGrRVPJRbj
         Ifw6fc06ot74Q5g/6iefa5TqbhOTF4GHHLSHezmYOCNdJHi9gSLxtVW5zsI2EjcRhous
         vRJbWssOMtIKO/C0uaTJSnB8LvcraYSaTkwTA1O05kw7kMV/e7iyxeSqeuY5BN08jQCo
         E1R4/voehbQEehovAonIT0tbwGxdH5kyKkC29QVGD8P80BV89+rczvbppwBtJ3sIiJ/6
         0gOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144224; x=1783749024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+6YmgpaeM5juotgbcQnSfBdzNCdrt/VISxrQFcbQHI=;
        b=UICjz+BgMiVkxsRUgIRFD7YiUTb0SqaX3J8Rh6llMBEZjZTFWs4lAClWnMhy8vJCv5
         UKEIqqq8RGFQsNEwR22b+LmHWk+sG0UbuQCPoeJHoatoX6GxnIVkMh6YEFxxmkvU/PXr
         +ifsOTrkLVQzJAiiOr2RSGAv/LGNDsj5QhQAdBtXItP4dU6rPAPcEJynKw13Hy/2yFiX
         q2w6gYwL3JCuIVYHgx2zakavJjo3+T0XeEGLvD6c/Iap35A83F9YxFmp/wevnUsPbNzj
         JlGFkcHt0wXhwxoU9Z0N/zXrpClyGP4H+oSMglGNT0auSEyzdanNsxYD54jpEtdw9kPi
         KOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144224; x=1783749024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+6YmgpaeM5juotgbcQnSfBdzNCdrt/VISxrQFcbQHI=;
        b=PckVY+IJJRibISe7q+j9xBcuEtx4D668Nz2mL47UxtloGbIy95xexU88cVkf0gAOyw
         jTmyj7FRiULKeEomHaeGhL3tLK+cwql71iu6cs+Z/DPPsyeMbY07lgSdTalplULrW505
         uwgZ3AxAy+ExqSm5xmhhz2s1RiRN9AxtFZ0pexQvFugSsRIRtPKRTYXB/7Nh9nDuqFn1
         yhNXqzLJbQFLxjCwl5egX8slsGjCf1qmpDbphGcAzGYG9afAVrmuwDTbHGzmBZhimJJt
         0DvIqYSdF2LA3VIdqTXTCHp0uTUaQYbauxme5ULi6tFz1gda3lHgwfDlC2J6rOUn0GLB
         3F7A==
X-Gm-Message-State: AOJu0YxBci6+UWs0IV54uTJfwa3A2g9MT2w5Fif8Y/QPxuZmje87OuFQ
	8A02k3teCEbf2ca+zXCHUynSVW6HoAUHoefBWYm+ad1F6t5iqmv9zcTy1mBAnM2dxygKPvS4oPt
	Sw6F8qy6S40w4zkQ9OOq+tafadgkg8RI=
X-Gm-Gg: AfdE7ckIxyMdP+/yK/mJ2vnxcxtBWpYeKt51UVdDUjG9Mfxsox5dS5EdR9+87Omsw0b
	GjW4iY5OeP+Gd3Po4mA3aidKa5hPFjth+qE+ZUbC/EFMEiG51ov00yLwlpDE+UwFvcG8JvgVm9C
	/6S0EWskiC89fpKrAHyTk9/6WY/qBvIaQ9FrI2iwn9L2Bhvccd2eFeNfu1mj7M7S4OOXKIalJml
	TFCxOWxWKfkwusRWrFOe1FjotiU7jtemO5Ffvd8DjsmDE0YkFdpjFzA7NAp4yzCerWCCQ==
X-Received: by 2002:a05:6000:1acb:b0:473:975c:4fc7 with SMTP id
 ffacd0b85a97d-47aabb4cdf7mr2219612f8f.27.1783144223640; Fri, 03 Jul 2026
 22:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
 <29129c40-4010-4862-9b4b-3bafad874568@linux.dev>
In-Reply-To: <29129c40-4010-4862-9b4b-3bafad874568@linux.dev>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sat, 4 Jul 2026 14:50:12 +0900
X-Gm-Features: AVVi8CeSvpagGiT9Pdk8CHkTxPDqdZD1f9ODz7VToeC131JQxDxF1e8qrCd_jd4
Message-ID: <CAFk-A4n9U0r07tn6XHHqmOZ++-bmM4bSd-SwdpEU-88gjKts7Q@mail.gmail.com>
Subject: Re: [RFC] xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:leon.hwang@linux.dev,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304684-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[masashihonma@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A08BA706B55

Thank you Leon. I think this is a much better direction than my RFC, so I'l=
l
drop my tracepoint proposal and support your approach instead.

Since a user-space dependency on the existing tracepoint would make it hard
for you to retire it, I'll make sure the Cilium PR doesn't rely on the
tracepoint either.

Is there anything I can help with on the new approach?

Regards,
Masashi Honma

2026=E5=B9=B46=E6=9C=8829=E6=97=A5(=E6=9C=88) 0:26 Leon Hwang <leon.hwang@l=
inux.dev>:
>
> On 2026/6/28 19:39, Masashi Honma wrote:
> > Hello, I am re-posting this mail because I forget to add [RFC].
> >
> > The bpf_xdp_link_attach_failed tracepoint (added in commit bf4ea1d0b2cb
> > "xdp: Add tracepoint for xdp attaching failure") exposes the netlink
> > extack message produced when attaching an XDP program via BPF_LINK_CREA=
TE
> > fails. This is useful because, unlike the netlink attach path, the
>
> I really appreciate that the XDP tracepoint helped someone.
>
> > bpf_link attach path does not return the extack to userspace -- the cal=
ler
> > only gets an errno (e.g. EINVAL/ERANGE).
> >
> > We would like to use this in Cilium [1][2]: when attaching the XDP
> > datapath program fails, surface the kernel's reason (e.g. "single-buffe=
r
> > XDP requires MTU less than ...") in the agent logs instead of an opaque
> > errno, so operators don't have to inspect dmesg on the host.
> >
> > The limitation we hit is that the tracepoint only carries the message
> > string, so a consumer cannot tell which device a failure belongs to.
> > This matters for two reasons:
> >
> >   1. Correlation: with only the message, a consumer cannot reliably
> >       attribute a failure to a specific attach, particularly if multipl=
e
> >       XDP attaches happen concurrently.
> >   2. Scoping: a consumer watching this tracepoint sees XDP attach
> >       failures system-wide and cannot limit them to the devices it
> >       manages.
> >
> > At the call site (bpf_xdp_link_attach() in net/core/dev.c) the net_devi=
ce
> > is in scope, so exposing it looks straightforward:
> >
> >   TRACE_EVENT(bpf_xdp_link_attach_failed,
> >       TP_PROTO(const char *msg, const struct net_device *dev),
> >       TP_ARGS(msg, dev),
> >       TP_STRUCT__entry(
> >           __string(msg, msg)
> >           __field(int, ifindex)
> >       ),
> >       TP_fast_assign(
> >           __assign_str(msg);
> >           __entry->ifindex =3D dev->ifindex;
> >       ),
> >       TP_printk("ifindex=3D%d errmsg=3D%s", __entry->ifindex, __get_str=
(msg))
> >   );
> >
> >   - trace_bpf_xdp_link_attach_failed(extack._msg);
> >   + trace_bpf_xdp_link_attach_failed(extack._msg, dev);
> >
> > Before sending a formal patch I'd appreciate guidance on a few points:
> >
> >   - Should the tracepoint take const struct net_device *dev (consistent
> >     with the other tracepoints in this file, and lets TP_printk show th=
e
> >     device), or just the ifindex as an int (simpler for raw_tp BPF
> >     consumers, which otherwise read dev->ifindex via CO-RE)?
> >
> >   - For raw_tp consumers the argument order is effectively ABI: prepend=
ing
> >     dev would shift the existing msg argument. I've appended dev above =
to
> >     keep msg at args[0]. Is preserving the existing argument position t=
he
> >     right call, or is reordering acceptable given how new and rarely
> >     consumed this tracepoint is?
> >
>
> Good concerns. I'm not sure about these parts.
>
> >   - Is extending the existing tracepoint preferred, or would you rather
> >     keep it as-is and expose the device context some other way?
> >
>
> I'm planning to retire this tracepoint. But I think I cannot do it, if
> there's user space application relied on the tracepoint.
>
> I'm planning to add BPF syscall common attributes support for
> BPF_LINK_CREATE, including XDP link. By that way, the kernel will be
> able to back-propagate the 'extack._msg' to user space, when fail to
> create XDP link. Thereafter, the user space library will be able to get
> the error message alongside the errno.
>
> Thanks,
> Leon
>
> > This would be my first XDP/BPF tracepoint change, so any direction is
> > welcome. I'm happy to send a proper patch once the shape is agreed.
> >
> > Regards,
> > Masashi Honma
> >
> > [1] https://github.com/cilium/cilium/issues/40777
> > [2] https://github.com/cilium/cilium/pull/46546
>

