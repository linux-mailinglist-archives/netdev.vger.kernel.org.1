Return-Path: <netdev+bounces-263112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP8VFL+1pmk7TAAAu9opvQ
	(envelope-from <netdev+bounces-263112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:19:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F911EC926
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 435D8302A3B3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 10:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0566939B94D;
	Tue,  3 Mar 2026 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uin2x54j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB85395254
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533180; cv=pass; b=JJo+4nItjw+wWo0DQCXhh11mee+Gf/iX/nbH+rCP+mN6TEP1dnA7PNHkCjoggJzjJ9DSTFHLx52+Yah1PTTTh2tUbY8C0Y5veznEzxSypWKJE1conMkeHIxA5mgUKBuL7R8SX5BMhEDQlVyAtv2rC+tCYJRjUqnOefCmnAqgnB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533180; c=relaxed/simple;
	bh=L6xBecXDNKKJjA3BidIxnDUBNu+38hDbDTRiIBPmcm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIM+FQnJY7ABZGiHLwOZ1NtAeCj2HG6p+4Xr8TUSaSFkhOSWY115WpkobN8Who9mGiyBfD8AzNq73yb5iV43CXt6NnqwBY2ilZ2MGrbjPXNI6+Yj+d0ccsgGdkJBulUgv+FNAJ5ayFxtU6mAEQTsjoja6YWWEG7Kz4iyT5aN4I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uin2x54j; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a019a7f3so68744871cf.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 02:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772533179; cv=none;
        d=google.com; s=arc-20240605;
        b=Q3TniuZnmsILiuWOXfo0aVuxe0ZaKh+0vfDUW9Twh7e6kZDZdNd12iWrC9URGobE7l
         ThvvJ1gxMtaGyHE2FQnE5cBJev+1Ru1ADinfFUZrJj3p24SARwcPJVbCiM+Ly2BYVYPB
         0yfhAO+4rSUhd657k5n4u/iWX4IlyGAAeQDCLe701Ye51pdU1EtUrC8YYToFkORFKs7C
         vtq3D0U/I9XbJTM0GgPsO9n0NPzmJE56U23VzD64VKSH84Ac3Ce3zfrlQgUuOVEYiTN9
         harzYd64KHYDDTbgFE5Fsr5eOomfzDedz4BcS8buK/MpbpM3Q/+Jsfe/hzrsBGlbAV9W
         hJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5tpxZyfOhLlXWbzxEfVpHySW/amFUqYsZxjE+wKixMs=;
        fh=RxdLDFiQZ42dlBDcmsO1aCZVhxG1XIe7Zh218oCAlsI=;
        b=PkufpFcwBBHad3GBEW5HpN6VhFNcUuS+UDScUCF3uGG8ndu/tNEcb7jMUSdJpxXiHN
         tVb1Rc2obD1OOMddNzTO0ds5Lpj/fntM5l24dcuOV/Z8GR/DTdTrUDrvR7Sa31vWhl67
         rR9+ViXmQC0QqRTwBRuuiCJjIlqwZMt06KRjZXCxVg5XFs31UDo/B3SxKmy0qmT6fO8Y
         TCdlxBtxB2A0OTLy93phq+RctCX2q3IEaeagI1IUtTcOojWLsG81xNoHY/GTlZOO/qUg
         v+W+NrrY/ziTz0VmyYEEt4TUFTlGNqatgN2mwxC5664VLTMfo9SFRhz6hKgZnHSIKpBS
         5crg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772533179; x=1773137979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tpxZyfOhLlXWbzxEfVpHySW/amFUqYsZxjE+wKixMs=;
        b=uin2x54jYGFW9ZhL+ilMAYRxjjaBnyUlMIx/+yM0PvOr3gfTWLKbDhXdRRMsFrK2Qf
         PHr6eh7tQ+JOvBn0DOxvIpzaxI418goKzFLeli8LGl4UlMbvW2YJfen0nH56tYeux1Va
         24FFNvVXb/Q70JDuCW7T/azpl8iOC3jy8LlAyKO5zu3a4l/RaACtpeahshQ98iHU+Qoe
         CsVtEJS2767mWugLxFZidmjaDXU+/HXWm2V6laz5fI14LjdB0ReuHe0SkH1fyxgJKcp/
         jujSCuP90zhn++1r3P4elyYnhiqPb7NirKdI1CFgLMStCBvK8Ju2sCZ2y+9x9zF6hvY+
         Vo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772533179; x=1773137979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5tpxZyfOhLlXWbzxEfVpHySW/amFUqYsZxjE+wKixMs=;
        b=iAOg9xLYdgLVSX6jnG7TsnShiPj1x1gbYyqO0JZ75Lox+/MbKRNeUIeB8xUOCnuPqu
         gdAkRYviwCUIPSOEE3r6iHzLZOFzthqt4Q6/C8RcZKjmJ/ktJU3if3Ow309GsQvLV7Y1
         s4hSv8MEu0g1Eqnd2TseL5igXAS1/vZQG40Nr5wziH/wa75ZPiQ6K29O+fS6bxkTzNuK
         czGegVYjEZUxviMa7gt3ELRo++FNRO29nUwzgpheu6nUADKZHAJBHBFGD4HGyLVIwo0R
         J35WnV50cTRnMyY9ppH7GwivJYKNLySbx8GNQLOzROktHltpv7coWaTGYGBXiQhUgvgX
         PN1g==
X-Forwarded-Encrypted: i=1; AJvYcCU6rRwiYL2/ekGxXS76cQwEEbfm8As5IE5JeAvWbSDvu0OHSDnSM9tglDyqNx9/RxD/QVOnIDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfCvQ5J6R1Un3t4NUOKVCjc3vAcgytD1HaBr7BHmv3/AjoMgA
	gfCkwVvRWRQTcfWA59qkpqqNh9D8NFq2JdzHLB6PtA8Z9O0nCd4Tl5S4GJrIGZS/t5gII+qy8DK
	RvRB3H6MTWKc6YdTnKkd170QvUqKEOYxap5dkFx8i
X-Gm-Gg: ATEYQzxWq0klaIRg9iY6XG1hmQ4ahuVnJavHfyMVAqf5lVCtTQ58zv1pTqQJmYKF/R7
	6gymIADEA6IgTnHIMBaWt8G++FwgzghjyiyTzz+weuWzU+xBNfY1oRU3pEWu+ciom3hcY/a4qvi
	K8cx1GeeRvvKgtOQd7HNYCLc9q2w/qYt3bwmjGl/imSd9qKPAYXrs9AeeP+2SItvXhAiLu4MnQ/
	txWRWoVStmImiWjrbZCnVrw9bQ9PxDO3pY7HMn0fYeF2vsvRAEpBPYxzf++bRvtD/6cMPlJQ4O7
	SfRtTgA=
X-Received: by 2002:a05:622a:134e:b0:4d2:4df8:4cb5 with SMTP id
 d75a77b69052e-5075273ada3mr223945261cf.4.1772533178263; Tue, 03 Mar 2026
 02:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303100439.3172296-1-kmta1236@gmail.com>
In-Reply-To: <20260303100439.3172296-1-kmta1236@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 11:19:27 +0100
X-Gm-Features: AaiRm51B6TTY1LFq4MuKQeALL9CaUBBtA9iidPyKok_cWwkoYgWe7j8YAj-ijcE
Message-ID: <CANn89i+xwmBA-QiYwd_UR2_XK0aXZGZi8+uvBugQ2-MnmZvpaA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: shrink per-packet memset in __tcp_transmit_skb()
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E7F911EC926
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263112-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 11:04=E2=80=AFAM Keita Morisaki <kmta1236@gmail.com>=
 wrote:
>
> Use struct_group() to group the three fields in tcp_out_options that are
> read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
> (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
> with a targeted memset of only that group.
>
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> bytes to 4 bytes reduces per-packet overhead on the hot path.
>
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dy):
>
>   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
>   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
>
> Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> already used |=3D without a prior clear. tcp_established_options() alread=
y
> clears opts->options at its top.

Please read Documentation/process/maintainer-netdev.rst (about the ~24
hours delay)

Also, please CC MPTCP maintainers, since this patch could impact MPTCP.

