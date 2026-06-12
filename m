Return-Path: <netdev+bounces-298449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DAYJCe1+K2pj+gMAu9opvQ
	(envelope-from <netdev+bounces-298449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:37:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE2167670F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:37:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AszGR0ef;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298449-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298449-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9D6830E9D6C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50438655D;
	Fri, 12 Jun 2026 03:37:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620034B1AD
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:37:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781235433; cv=pass; b=sqxZ2AKm5KJTt19gQK7y1Be701Th+iqWte5AjIEimsaJq49GTlOnamWQih+mMAt573KMZWLVSRwqdxhiKOtDM9vKvmBupE1LsnUE+hMAKok1qm6vIf1bXFRibHxVn6rxpzpTmXvkttcqbcscjdjkQAXQu2HFMIXqJkYf4RakDnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781235433; c=relaxed/simple;
	bh=f9eM4QECuMJVJ64dYWKjBS1Ex/yKf9yovNHknSmTlro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Es0dG/DtG58GDm+YvGXoneJs5rl1CASGYDqOYK5u5MAmlbc1y2B+EabdKzAi+P8+R2STDq/aXvHq2mpudJwVrJDVlQGT8T/P2RT0TDFp85TpZggEq6Gp6xEm+rdGho0JtChF3M+VOz2UwEMVmamQTwHvreKY7oxGD3/PgUCF/cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AszGR0ef; arc=pass smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84229481d44so302490b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781235432; cv=none;
        d=google.com; s=arc-20240605;
        b=JK1/WNb0ublDTxOb8Zf7dz1t9S6NTg/lquc3awo2tAqrZ/hMDTD7oE4ZN+5PKHrCpz
         /mLwMsxV/cYBfLsTfTtQKwFP3Xn9tL9CGxMMK0rj5L3GOOtgclDrzxDcUjdff5pCgE7z
         v23GKnzIDPmekPk5kLGknnMCT8ClI4DAW6g9+v3ClyuQzBez8wWmNxBMy+eBO5nylyp9
         kprnVrespZdig+EKUbalA5eXPlO316Te6CFR3+Y6CWbR24N290EJrtbe/BMk/i6IqSlj
         pla3H9EqiCt4yvNzqSlIEMu0zX4nd1pg/d4yGhomMThD1fvEM34rmfq3gVcUTyPADZst
         xssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hZuKy8KsBKoVzcM4mWt3Qcn4TgT+cGVHbQHSYBpfjC0=;
        fh=JC2eqlgE64LRm4zETyd+0LMD4PT5UYY0x4x3/25GFHA=;
        b=ILJMonQyXnINtBkq/z1RN8zKgoLpx8K2oAb0wEeDKij6GB4xsk8/551RYrAUO3hNFj
         tIGD6BCeZTT1BhpC7v/xTNSdEaPXg5viqe2QGW38rsuNx4XnFyupsePjB/yfVAjvhPrl
         PAV/PEV5fuTgN2U50YQ1PPQsfDfjVy1npy3Edmu0W31kaItaVlNF5t9iFmv64PpDrJAp
         wsYbpURdXyUK0QK6EMUPLZglAtZXjnaPhMBo1WMq4/QiyHqLlL8ciIn+RfsRvOckb7sK
         fm4A9mNk6WCgRn13YHIyZrZPVvT1XZJiu1hjO7RewG4av0u7MOFIU9okPJd7xxgTLEKe
         FAug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781235432; x=1781840232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZuKy8KsBKoVzcM4mWt3Qcn4TgT+cGVHbQHSYBpfjC0=;
        b=AszGR0efURKv8R8m3r5xUF5tjCTzx9ZtypU7J4Vw5u6BUY9QOylE0GcZcdXO/bQG7Q
         0qQAtsvS0yjKfew586AvYVBpqFiBlTR2j8vnKuuaJtPaO5C1O/oRDn+KjsJI0Rbmv4xQ
         3RHmYViuAHHOQmCs3uoFfl7/h+SVfZY51x2liYvzNuTfepbJI6Z33pxwMgvvY7TjKilP
         9Qn6RR7+tTf5CASFz7Sv698P/o3HwL4SFDM6HnMStd4yQ/HylWVpYa/Qv2GKLxZiyELT
         xRUXYeTBp1MJd8m9elf7Whp8QhVcnWkpYuPVEQxK81qJj3kI0uR4xv8z48+xghfqzP18
         /W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781235432; x=1781840232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZuKy8KsBKoVzcM4mWt3Qcn4TgT+cGVHbQHSYBpfjC0=;
        b=q3AIJUlsgU0Ig41+UwSU9MIsv106HDq4Mm9DeLwqi+HYQXMPwDDESok/gAzwQA56Hk
         mVCG3Id7ARAwgdhkvvp0fc1Ba21oGbx+NMzjSAEwhWIc4ktYlavnIGDn/23REh7146st
         sSFNKEDDgJl4Bn5LZW97U6/4Q237nNJ3lE21rdFmfl9mSsZHBBGUib5zf7em37xLeIgN
         JYQNWWXqKqb+jj7kCw66r+pE+I7jdPwJWdKJrRExOe1sEUyn0LEXvwkJPGvF1UrC5gRk
         t/59Bx96uaNV6YxwXBf4CK5X9e8wAMLSPA1oTqij32N4fNPiPkhXZHB568/qqdOCRQMS
         8GHg==
X-Forwarded-Encrypted: i=1; AFNElJ8t4eS0en1rFx2sicb6ST5CQ2boO+iQAmf9bsZVDXQOEknAzK3LjgIL7SHvTDOuppztsmQGAHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBuL4+fw84dSn4b1QR2juJBCTHM/v1CJ3B5SmDcJ8i7lGXCziZ
	QOka392VHsLZfphhsh0H77UYQW1pTcH0ZLYlQeuYJTmYSm3nTE+N8MvbHZO3a4HxnBP95ZR2es9
	6ALEBifZ4h+knde+xAdNGT/zZX10K5zM=
X-Gm-Gg: Acq92OGIMDOFwgB0b8qmn7nIe6taXAl+Tybx6UssvbsrOVJOHgxtK6SDdX4yxP8veK3
	6qAghwRmQ0PqxgPFKKe2QEQS8JFcG9CDDeNReB7PnwTrOdP1hPRwL3TBm3ojqRAy39dpCFCa2dL
	wYDHaGip61c3GT80xq/r1aJ4+Sr456y2jwA7haDw96TfF0aW03ligm9XZOak/YezD03/bqZgnKI
	ZKewAdZPf3mAmh2OfFytdrjRfQDXtnBmtX4IyoGccp1N9zqATfMfzBExUUg9eSXBBnTk7KDIdd6
	yuuiZP/YtUIMRiHo6nSENUzf1M389c5xGvcs2RfJWXUxm4UQF9S2c6OMDoOhOcVaa2l1SDChIjv
	zikpQsOKpHu95W/aaBTWIKep1
X-Received: by 2002:a05:6a00:130f:b0:842:7fc8:eba with SMTP id
 d2e1a72fcca58-8434cb0aee8mr976470b3a.11.1781235431674; Thu, 11 Jun 2026
 20:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612001803.23341-1-kuniyu@google.com> <20260612001803.23341-5-kuniyu@google.com>
In-Reply-To: <20260612001803.23341-5-kuniyu@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Jun 2026 20:37:00 -0700
X-Gm-Features: AVVi8Cc3LWqeHHmqgGwv1rpYa72x9cqFhMV1KKvuFVbN6h0AgGgzm1GevRLaZhg
Message-ID: <CAADnVQJjHDbpAt2=Jkytz1GxHebPXeSEM2drekh=7vXhgQBkmw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 4/5] bpf: Add kfunc to proxy TX HW Timestamp.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298449-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AE2167670F

On Thu, Jun 11, 2026 at 5:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index b4ac1180f5a8..bd9343288928 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4706,6 +4706,14 @@ struct bpf_hwtstamp {
>         u64 reserved;
>  } __packed;
>
> +struct bpf_tx_tstamp_cmpl {
> +       u32 tskey;
> +       __be16 protocol;
> +       u16 network_offset;
> +       u16 payload_offset;
> +       u16 reserved;
> +} __packed;

Here and in the prior patch..
let's not penalize modern architectures like x86 and arm64
just because somebody has sparc on the shelf that collects dust.

Also don't use 'u16 reserved'. 'u16 :16' is better from backward compat pov=
.

And consider addressing sashiko findings.
Everything with [high] or [critical] most likely needs to be fixed.
[medium] and below is a grey zone.

pw-bot: cr

