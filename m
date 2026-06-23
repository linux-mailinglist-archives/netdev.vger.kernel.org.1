Return-Path: <netdev+bounces-301279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yPDnCLMpOmpv3AcAu9opvQ
	(envelope-from <netdev+bounces-301279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:37:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 976AC6B495D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:37:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="sT4Ch/Pi";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301279-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301279-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2562A305A462
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 06:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC769331EB5;
	Tue, 23 Jun 2026 06:35:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCA1547C0
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 06:35:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196538; cv=pass; b=YcUR209rcfNdCeK6InXenNx85kJUEhIu/1jC15sdbQsGfBcahm9C4PzIj8c4g5S50CR+a8Z1uZjdTgGh3Ct4Hlufx/v1aSFOdh9kLc2aQDnGJ6jC7tbP444KgCuoTh+xdPcLbL2kxPogRflEIUnuNW+eKOggP3iOUaWrBZJ6jho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196538; c=relaxed/simple;
	bh=U0ircmHktCJ8xCYoMbhZqHyHDmgQ0AnW9fZmB+Vt7TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbT7yx9CmuD2QxSXQ500nzxP0VEfapVUufnMPp04MK+F/9N7XWwS3htnomjf6oEp4YdJnae7uSCAj5QNJSegAOwzH4KW/hGxrnY+EmMzrVzQmtTVBmjmMU+W3VuzqnOVJoUCzh+QteVF2rzNORzW3VcNiCzMhuEpMwD7uFMfoDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sT4Ch/Pi; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5176ca6bab1so7870521cf.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 23:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782196536; cv=none;
        d=google.com; s=arc-20260327;
        b=hH74Z9EYHguDZv7pPFRciGYs9qadbFzFcH9huJfM6FnnND2ujlmrvKHOHTPeguQEK9
         i3ntXmP44V56SiUD9Q9+rXihA7U66Iwp8tS0zs9QTVVNDZhDQCPLVRjz0xq6eZHAqatD
         rOc9gP5ZlFvgulQIJfQKKKX/kUiFHNzUhJQqMrKy1jvJlUndxkEDB5Tz87niBVYNqC7E
         M7nNfmfRHCQnbLbjZD47GpRgFHKDKB/5q2esisXWzT60KZTdsE2UV11hWCVjXQ89KPDd
         tLmrnitf1RLHdXbb60G688RyutOaTv8SWHiyhrhwlTZBHBQP5YjkOmKa4pvXQev+B1ba
         Upxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XNp8OOr9Dg85fWjggrG8LtNFt4/KIkDIH3WeFv9MgkE=;
        fh=NLQX11mEjMLhyGjPTkWeAzSfQHVYbNoubEgGRrLiQnU=;
        b=jis72afKSHha6FZWK32NkvH8dT4AkinxTB4HQlvdRwSfVOAI0leQ+Uf+tEnFHa8In4
         THkcCCxkGvW3N9yEflwQzkzufGSRfQzXaAXKpLf0TJfyVAm4z0p4ie4vV3iJLMQ4ig+q
         sIK2FWH1JG4WQgeQ6K3EcfGGZPBFIuEDJFS5/X36x4Sk7fEBxrM4ggBE8CrKl03rkgjo
         lfJNl2VInePrU0KOflYnaZGC0XaT7YWSh5HDM9LcIl9J2Uhlg6xrOmDzhuTq3eAH6eHK
         pOsFXmPwZUUV26/G055Lfldc51Kr+bVDEJ5e/2L5bnh+Me3nkhZSA+/DFAEJIpLsvJSB
         XiPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782196536; x=1782801336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNp8OOr9Dg85fWjggrG8LtNFt4/KIkDIH3WeFv9MgkE=;
        b=sT4Ch/Pi6emaXTwh5t6EAHLphL21e6uerAuHjYmVe8+OFK/Pe+eINs8z8d7N9vGe6w
         SLW6RKovRlMbd6HjSs9a0K5n+5xY9d2s9VWqd+e4pJqC6OndDO/leiRywbM4sC1MCgey
         W6APcgWIjtvwfjWTKw8An8n48hnxKU1D5LGRid9/NSsNH6Ut3Tk4wa/gsn6CO8qFNGiL
         CPtHdMnXdoWR0uHFQ3dx7TNh55T/M/SAQHUA93uwcx6Vsl1VuOvVwAXppfdJif0r7rcU
         MPOHDTms0cPdKcZn9kIbo9NbWcKvmUYLUZgOa1+eCwf7NXLNmjqza30OrvEssfvcPROd
         sn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196536; x=1782801336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XNp8OOr9Dg85fWjggrG8LtNFt4/KIkDIH3WeFv9MgkE=;
        b=X7rVZNiK7kf1RvaWMKzTU5a/es4DDMUr+MlxGgfySZupJYYkw9O9R6WDs0ziwdqlF+
         cHvC7dxHi3LEPsAI5Z1CHgIqn/0X0sjAVsiccxHXOhorDU+h8FhZhI1lbEyIJNgzgK4k
         xwL9qeuU4i+WXOLNIoiHnZR8zmpEZti+AMdb+ZmVyvUNmyxZoJ1109/dGrlXw/8+D8Xw
         5g8LApizUhy/LkSJgbalzqXamL0eKJMP6n0qoIj0+/tf9dA1vhpE1D5kJaDjFMhLVB+2
         L6Oc3NzYcK+1ASBNHVrenFh6gkjTFFolzOxsPO3gHU0wyahuBqwh3xJwP0NqEEuEZviO
         JNoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Nw7HKOp7z9g6pLykUpvej2NZRTJWgGsGPlon5S9Z78YFTWydgwQGaJe9GgNTn2MW7SlS56z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbMaLpRo1HzKn4veNB8yp8id40RbUNQ/9wkOWkD4MKt2S84c5
	9H9hnq1+5Y+Gl07xcXJGuOnuiYiza/cDfwDwSZneVjja7v47HwkgqozTDfbOOrxaYrKcFj0+xFO
	mYsWFhv7DRxak5qvNc4hgMiB771RhO2yA/XdQAQZe
X-Gm-Gg: AfdE7cksRlwSFWPZJzLeXDg1zpeso3mU4WvrmwT5v6J2/DphBG339Voq6s2SrdYDxZK
	Zv3Q6fMpNU8zLTH0gCsaeqjEjObelsTVKVVAof0HLmRGveptqoi1p7bbE8zjr+zGTtds9cpZ9iq
	qSXqQKy0KakpFA020tOJgZoS12hhgxbMkCzhh+PWNmRvru/U8+y9y4Q4rLc9Fz6KPaExfN8hjR0
	DyTIcLuRiYUQXZ1UR6th6C/UPXsYdykMWuSSMYucZE4m7pacIcueyk6kj6SEpM3IgirY49Ok1ej
	9nbETDR8XKnj3RK2ehypUI/mn8bEM6fCCBgwlkEXLYWrsC2iW5BJbBsLQM3D+VPoktYKLwDqSEN
	2pIaI1cZ/z0AhipmFTNE=
X-Received: by 2002:ac8:5a48:0:b0:516:ddfa:b6b9 with SMTP id
 d75a77b69052e-51a51b2e6acmr34930681cf.23.1782196535612; Mon, 22 Jun 2026
 23:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622171048.1626022-1-edumazet@google.com> <CADvbK_e_7184a_jm5ASjKafXrJqaOKFUKJF6V1wp7AnFxK596g@mail.gmail.com>
 <CANn89iKFj9vSS6B-=KAMnLyqFqY5edZ-eChfcq+SuGckU6T9yg@mail.gmail.com>
In-Reply-To: <CANn89iKFj9vSS6B-=KAMnLyqFqY5edZ-eChfcq+SuGckU6T9yg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jun 2026 23:35:22 -0700
X-Gm-Features: AVVi8CdaYF7Y6jL9GrW6H3t7INWD9i274710TrnB97EVpN869s4FVrVBu1heiOg
Message-ID: <CANn89i+dkbrSAwvaWXW7yWMfcwUebuTBLG5T7AGZaZcpVYGyfQ@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
To: Xin Long <lucien.xin@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com, 
	Jon Maloy <jon.maloy@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-301279-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com,m:jon.maloy@ericsson.com,m:lucienxin@gmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,ericsson.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,e14bc5d4942756023b77];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 976AC6B495D

On Mon, Jun 22, 2026 at 10:37=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Jun 22, 2026 at 6:48=E2=80=AFPM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
>
> > Could this corrupt the list for concurrent RCU readers?
> > When list_del_rcu() is called, it intentionally leaves the next pointer
> > intact so concurrent readers can continue their traversal. However, the
> > immediate call to list_add() overwrites both the next and prev pointers
> > to link the entry into private_list.
> > If a concurrent reader is currently positioned at rcast, won't it follo=
w
> > the newly clobbered next pointer and jump from the original RCU list
> > directly into private_list?
> > Because private_list is allocated on the local stack, the reader might
> > interpret stack memory as a struct udp_replicast. Furthermore, the read=
er
> > would miss its loop termination condition because it expects to reach t=
he
> > original list head, potentially resulting in an infinite loop or a cras=
h.
> > [ ... ]
>
> I think you are right.
>
> Considering there is already one rcu_head in udp_replicast I will use it =
in V2.

While looking at many syzbot reports with RTNL pressure. I found this
gem in  tipc_exit_net()

while (atomic_read(&tn->wq_count))
      cond_resched();

On some kernel builds cond_resched() can be a NOP, so we might loop
here for a while :/

Added in

commit 04c26faa51d1e2fe71cf13c45791f5174c37f986    tipc: wait and exit
until all work queues are done

