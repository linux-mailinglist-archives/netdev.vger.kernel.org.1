Return-Path: <netdev+bounces-301228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3JjqMqLdOWpuyQcAu9opvQ
	(envelope-from <netdev+bounces-301228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:13:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B65196B3197
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:13:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=REcp81NW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301228-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301228-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C59F6300C7EC
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8B36167F;
	Tue, 23 Jun 2026 01:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A202236EB
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:13:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177181; cv=pass; b=MsvSoAm9up2zdcCJW/nuc6U69V3+botQ5NqPF8CCCuCXm54YKDcGs8O4aZCzp62s8FCCb8Tp0ymBGMAGLx3bVvRiq8oeQLtEje5L4S4kSZhYI3+2HhdSRkt2czWUjgTbVMvUVbI267y66vzVrX/8z+/RhSN3ZAwI0dnSu9IXkyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177181; c=relaxed/simple;
	bh=ha5J7KcsWsHa2WnRzHHSgN225J99Al4jiusqrLvy70o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgjpdP6sDsaWMyTxYp3uFcwyUt/CQYAz1DzdzAyRreJw/+P7L4nZGouqDwHFeCw72ASNhZXL7zbmXQusy42esyZfBu2Hc4xlDWRCZaMFpi5wuRmngihCP/M+NyyVTiDhIcofk8pFrLRLI+JxUfZEfQfqvV/l7d9+v+2lyb6LQ3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REcp81NW; arc=pass smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-139a71baa35so8050846c88.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 18:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782177179; cv=none;
        d=google.com; s=arc-20240605;
        b=OTgd0RabGr0/5KfHk7xAt5P26/x1peKwIxtEVwagtUyqgmqrbjB+iVcLxslnlQfOnH
         KgFnR1CjsLzl6gfm06v7kN4o4h6rpbOMbvCiP5oYGWQpaENotAmKylrfSX1Y+/DVtF+s
         RYR8qbyIDNG4jRbdrobsTdF+ncXqPCcHF8rJEp+aaYXSVlssP130dy1mpNopIy+BWZ+S
         GpuoyRrBtrczUXxHSreqxZasVHhyNZsW/OXb+zhEDJJ1LUuDJN8hFEyWckO7YKL3s4UZ
         4ugwqR0uRONX+mpQAD/ZHVa2HN2dy3/8aEbryxaeN/fzf7GPDCCFWeHIlVSX1/mbe98T
         1VmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SkpnweLhYdGsT6aM6aIXDi4MN6QzXh3zfIpax8Yxt6U=;
        fh=KMLpsSBLHyaybX03JGNYIPKN+0KjwfjHKy39MDNIgdQ=;
        b=M+S5u6Rit+TN1Kaser2oeq7hraHdhoWVJwxVmAR7u8Nhl2ymCdGOpCL493R70Ybz+Z
         Ur3t8lHGJH/Dzu68h0qtzuteuXmEBJuGbPoSgpcg8YYBVyLelWHUiGp7tgwJrgXoFbI2
         jIw6flR46Xt6UE68EA2/51hhisps6NqTC0YVSmmAwKK0Jqtu0hh2/KzYI02abjXGN8wI
         aJzGCm2zUoDqd9vM+N+cvx2u8jsm2Txt7kR86xFqQcZiFN/Fkdt2XkvZnq7/lReirzim
         au2eniwTxDGM/4SroRYS7Lx5Yq9pWitT6hiUCNEzz2lTkFMUJUhCCMqjAeEVwjKE5JWH
         YakA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782177179; x=1782781979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkpnweLhYdGsT6aM6aIXDi4MN6QzXh3zfIpax8Yxt6U=;
        b=REcp81NWbB4ehyhFLnFL+rEdl6FuVL5wrpu0k7p2uCZrx2CgzWZ1+3mz/0vSD17Hg7
         l0/IpQncc8cSNhjwLT9OcWaxwm/bb33yu7xHDuuNU3aMap1p/QFSgdItGAD0s//pua0a
         URX05VHMs+w8wnHtJW+z11I04qFWhZMG9Q0/eBZ5Pxg2OgiArwYM7b+T/zyBngJHS3BG
         veKDBo56G2WH+9kG3Lzm+0h3OXfgV9KWgpQjMR/Gvdzs853Phm9obh6zIc/GMTu1Upjj
         Ps9mMYZs9jfPXXhzE7sUwqqKu/oHE7bUf3S8DkYRwo9TGIWC6u/Qrej4wMpds7HrT9bm
         23SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782177179; x=1782781979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkpnweLhYdGsT6aM6aIXDi4MN6QzXh3zfIpax8Yxt6U=;
        b=cUpZFggmrbqjYpF3r+XRprRxJ6LUyq2vf7yGgp/XQ31fZLzQaTDh66zlbWboC11RTl
         XbhZ8H+oqkRFJI0CYmNw+JJYyfTZIXAP7bB4htL+xWzqBk4/MCPP5yCpkguksHHnM87k
         jMO1pTw1PeCKozO1Uob7qtx0VA/ybqVLF/SjQYa+CH2XxF2Z/QdOcCFRNulGnPJE+5eS
         abSakqXQHKf5HQKlgGRPuMkH0JXtqQdY3ZZwik6fTGTzL22sPW7IsKAeRst4PiRdtr5w
         6DgIJIX76tqkaysqzSwSbzhw/ZbDBhfdpXZAznXeSpUvJBOiy3eAN5dUVEYJzi3uFbvy
         W7gw==
X-Forwarded-Encrypted: i=1; AHgh+RrDPR4j0eQuaEI5qgtJs60gy89tUvRRITVj4SQZAIJ2cEEOIGY/l81d+0RA+YVzoIHdCS5a/OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhywm4G/Q0rqTRI/8DukII/VFdjbP6eHXjTVxMQOBEQ3MGpDw
	uJ2GR8pZbJAbMuN18o+PgL+CJM5gtGSjRUt9McjRLltXs3rRJe2ot9JIALm/anTB6MmbaiwnDYN
	8+2TAZkfooy4k7GW35YLfmu8JjDHfe8g=
X-Gm-Gg: AfdE7cl6m6I2PyDPrHLu3LX/hp8Qz1LM+Y90Q/l0k+v889vGKe6jcwJscd0bKocLL3e
	UdnhLSTI+aS7lFU6NEz2msfmCecAbRt9mXM8ca+2uVgNtUA9K0xQmML9Loh6OnsOHeVSyHK0VP8
	P9XzNOl6niTcp8aWd+YM0QY0X+C1yKss6IzKu9ZqkUrpDhPxsrx7HfQKq8rIDxYxtRRW6ZHEnLe
	HwYEXq+WfY0l2aCnsUwBCVoGDCJWAXJGZQj3QWW7hkL7PT573cmY00vzzbHd2Q3adbv/FCLJMzH
	gO/SoqtZ31WdxmVyYcI4NZ3h7zDT5aMGJT0HKbn+hp2HlNg/AQEjnCd+0bS705N7FkzIOmBOXEZ
	LSbjkMuQqTVAA5bJN8i5UopnH48xKXcjUUdl/Dmfhkl/8/EukkPxTZS/CQ10S1jlppR3cNSj+
X-Received: by 2002:a05:7300:3245:b0:30c:550d:3c7b with SMTP id
 5a478bee46e88-30c550d416dmr1955813eec.1.1782177179309; Mon, 22 Jun 2026
 18:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622185248.1717846-1-edumazet@google.com>
In-Reply-To: <20260622185248.1717846-1-edumazet@google.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 23 Jun 2026 02:12:47 +0100
X-Gm-Features: AVVi8CfEw4J2WYFzuRyxWnYdLYiYprepU59vAz0o_FjTZORNb-eIBSAK4zGJub0
Message-ID: <CAJwJo6Zc7Raz9HkKEARouSnz+FgTi9C5kAA+sa=-5Cg-CLe=MQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tcp: make TCP-AO lookups more predictable
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301228-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[0x7f454c46@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0x7f454c46@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B65196B3197

Hi Eric,

On Mon, 22 Jun 2026 at 19:52, Eric Dumazet <edumazet@google.com> wrote:
>
> This series fixes a TCP-AO key lookup precedence bug.
>
> TCP-AO stores MKTs in an unsorted list and returns the first match. This
> allows newer, less-specific keys (wildcard VRF or shorter prefixes) to
> shadow older, more-specific keys if inserted later.

Yeah, at this moment, TCP-AO doesn't allow any intersection of the keys:
If you have matching VRFs, matching keyids for matching peer/masks =E2=80=
=93
then when the userspace tries to add the second key, setsockopt() is
going to return -EKEYREJECTED/-EEXIST. This is quite different from
TCP-MD5, where the most matching key is the one that's going to be
used by the kernel.

This simplification (not allowing any key intersects) is mostly from a
very permissive RFC5925, where MKT matches can be: ip-addr/mask; ip
address ranges; wildcards of addresses; tcp ports. So, this part was
intentionally simplified until there is a user who requires one of
these things. And based on their requirements, a better data structure
than a simple list could be used. Basically, the longest prefix match
is like adding power-of-two ip ranges. Also, that's another reason why
I wanted an extendable setsockopt(), where one can add new
flags/fields to uAPI without breaking the existing users.

Anyways, if you have the requirement to have intersecting keys with
bigger mask matching (imitating TCP-MD5 behaviour), we can do that,
but I think that needs a new TCP_AO_KEYF_PREFIX_MATCH (or something of
a kind). Then the keys with everything matching, but a prefix could be
added to the socket, and the longest prefix match will be used.

I think one API decision should be documented straight away (besides
the key flag) =E2=80=93 how this flag works with multiple keys.
Say there are 4 keys on a socket, all match the peer being connected:
keyA: ip 10.0.0.0 /8 (keyid =3D 100)
keyB: ip 10.0.0.0 /16 (keyid =3D 100)
keyC: ip 10.0.0.0 /8 (keyid =3D 101)
keyD: ip 10.0.0.0 /16 (keyid =3D 102)

So, keyA and keyB obviously will have to use this new
TCP_AO_KEYF_PREFIX_MATCH. Should keyC or keyD be copied to the
established connection socket or not?
I'd think the presence of TCP_AO_KEYF_PREFIX_MATCH flag on keyC&keyD
should also affect whether they are copied or not. If the flag is not
on keyC&keyD =E2=80=93  they should be copied to the established socket
(together with keyB, preserving the previous behaviour).

Otherwise, if they have the flag, what should happen?
1. keyB + keyC + keyD
2. keyB + keyD
If we go with (2), then if a user wants keyC on a socket, they could
either remove TCP_AO_KEYF_PREFIX_MATCH from keyC or add keyC1 with
mask /16 and the same password as keyC =E2=80=93 slightly inconvenient, but
quite flexible.

What do you think?

> Fix this by implementing sorted insertion in tcp_ao_link_mkt() based on
> key specificity (VRF binding, then prefix length). This keeps the RX
> lookup path fast while ensuring correctness.
>
> The second patch adds a selftest to verify this behavior.
>
> Eric Dumazet (2):
>   tcp: fix TCP-AO key lookup precedence (shadowing)
>   selftests/net: Add TCP-AO key shadowing test
>
>  net/ipv4/tcp_ao.c                             | 27 +++++-
>  tools/testing/selftests/net/tcp_ao/Makefile   |  1 +
>  .../testing/selftests/net/tcp_ao/shadowing.c  | 93 +++++++++++++++++++
>  3 files changed, 120 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/net/tcp_ao/shadowing.c
>
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>

--=20
             Dmitry

