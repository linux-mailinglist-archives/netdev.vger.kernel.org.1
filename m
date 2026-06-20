Return-Path: <netdev+bounces-300815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i6/ONleXNmo7BgcAu9opvQ
	(envelope-from <netdev+bounces-300815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:36:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 375AD6A8F39
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:36:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=fNPo1WnB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300815-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300815-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10A05301724F
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3AF33F8B7;
	Sat, 20 Jun 2026 13:36:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369812BB17
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:36:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962581; cv=pass; b=mM504AxsL51qjZqjDH90SJtPIM4eGU0yavBgWE3X41hnRRApHvkFzDH7HE02gwSQNpNKXcrhNYb1178j3+EjLoXLUNeSollAb3C8e7xqWT7kgKPxOu7JfaYt186X+kxfTcjegOjzTga31CW3BSa/w0qWEzsUQLe9gfC9R43v7Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962581; c=relaxed/simple;
	bh=MN1s+Z+Xu5aFRgSauLt5FFTso1rCRaYXtl0n4UoTUOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXVHxLCRzwSbViYvuOmXYbwJ7dpij2xvLv3tUEXknHYuFBAwXVd7ibc+2QbKJnCNqKJOv0LE69lDZ+Qkdj63AYnt7T02sgFcEMYRBAVahw2sCdBZsangKeyBFvJNc0Pi0Pnw4br+NjAn4062HEWnFF95UBT4lMEOSTsMYdUyF2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=fNPo1WnB; arc=pass smtp.client-ip=209.85.128.178
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8000e21f014so29679187b3.2
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 06:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781962579; cv=none;
        d=google.com; s=arc-20240605;
        b=dEWXtf0WR6HKcS0bV/YFlhjfrRO8AdYjuBfWft0Lbrs23b4b/I2L36EhY/1kCOEHPM
         1QsCMjoOZKq/grzE3yw4Z7r+jlpiQ8PXDYI3FRH+tKYGaz0Mq78TkHaxRyHj2sQSTdj3
         a2xq35qQAjjf4P+ncnrWhOQ9x0rWmyYMXmO9xZMlOlcXoj2cI6Lv27Db77L/yx26D55q
         oapXorx/5ohA8tyvek491kQVJulj/gyp6hqP7l6OqCcW4acS3ZoA4aMW587pKNVm7/Ra
         uTjP3ZSgfSxMmYoQctFEVk1qeNNUH8dgDE6qUF2d1nrgiwMJvQwNlDjelTUP/czpAQAS
         zUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HNXxrQW8BiAnWvUn2VdMTxhLOGhlRa3nkN0KOSpPFGU=;
        fh=OaO+3kx0/721xRtdNa7POUbCKMzRu6bcovlF8EZJpek=;
        b=KPYLSuN4fpO+zKigfWcs/47+PXR09jPt84QGtDcfw5fhtcX5DUJcpC+HjObA1fEwjT
         kp4oUSJQ0b4hYjgJ3GExdjSGYEfmq87AcrxLXMAB4jU0oySHr5VQTBaHXsHrS59Pv//z
         MvTtaJg1Swlm9+sX4jmxOEcJXzrxacc6Ao/qQYqQQaWxl5uDwt5q0LgsxZkpnjdSyRHE
         vZ5+MPpeBMFlPAwyfHsVTmUOO86p+PGeUEXyTrym0xtC5lxIJs8JR6kGu1obH4ufVxRL
         xGlyb/riiYhfvQgrbvtT8CT2yNjdPMkYR810RMbbr2m1Jy9lk4kMNbRtSQVdBne/yfkG
         1tAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781962579; x=1782567379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNXxrQW8BiAnWvUn2VdMTxhLOGhlRa3nkN0KOSpPFGU=;
        b=fNPo1WnBCup5r6KOJh1GMtntwUFusp2h89q84fXZcTmlQJNT5sm6bul487KtvdUbTF
         lk32LPBT4IHzIcQr6SYPEm9s3Ajn71+ZaVj57xRjzizd1CC4F6s+WIdtBEhYrNAq/HF5
         N2zKSmTt4eVkP0rm9pk4/SLZuzuIrbAmA8SM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962579; x=1782567379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HNXxrQW8BiAnWvUn2VdMTxhLOGhlRa3nkN0KOSpPFGU=;
        b=iyes2kNAjE9WqVxbD+bW2NQ232oyRZOP4ewjiuZZyc+jyRt3WvBttqxIhJ5xaOmfUO
         8/TkkEDjXB1TuLWwkM4Y1eJjMXg1uomtTkw2S77lpRhz6FOuL5CLScUDh89mPSqeGIuV
         g1LlEfXsh6wKkKZkyXLGEXC/Uo2yQSAKXV53J2EBXUonafrtuxqAqDMGKNx4ndH6cKlZ
         rHdFCEgGBcmqcTzbmeb1ocnWHkH3A5ZvlIVqFGSSleZuztLIJCbA1GqDuXCoKGIaiff6
         LTdxCvXkpnZm0BktF12YjkS5Rl+kXPVS1LIB7EkokRwA0ERfXuzT5gemwqJ/aKIRdOqn
         BRig==
X-Gm-Message-State: AOJu0Yz6qWwNOoIoBUxX7jE3wmMm0KQ1XvBCt2dFuus3j6bSRdwf+naT
	F2sqbx1kiNFev8d1v9G/bYyY2RarhOVp6MlsE5yBFVLv2+WA59AsUsLf/sjPnGMonofpc99sueG
	MZsyvcbjNVPT521pdCJ+PqWkP/FJOmTOpYZRROqszFgI8pjUu1YU=
X-Gm-Gg: AfdE7cnUd/ytFtJ6XtjvO1NlBFsAG1hqfRz4oaWHqewNO0tMEmjLHXeF4Q52yPhnxAh
	nploviWLwLrHBMfFfQG+hAs2sjIMj6lQnu3tH/Tw2GTTBMmwBOxZR0Q49nN5um/nSTgK26VNyWE
	mPyRyFEBKPFrV4dKsfRBRdTnbBFuxY0WldkkPB6s9n9s+yNrNBZfrXP5Ymae9LdguFvWU/Bx6Ni
	5q9ZkJcdWeenSsHFTr15dogT2TTtWiGMtsKCe6+C7aF+VinPADHj4CGSIN4B/0acHdZ1w==
X-Received: by 2002:a05:690c:6609:b0:7fd:a4e0:7919 with SMTP id
 00721157ae682-8013227679dmr87522757b3.0.1781962579315; Sat, 20 Jun 2026
 06:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619151447.223640-1-b1n@b1n.io> <20260619151447.223640-2-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-2-b1n@b1n.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 20 Jun 2026 09:36:07 -0400
X-Gm-Features: AVVi8CfQUoncW7_tfjZxRR2A5b-4Jex5w5efpfja42_2Wo1uObhYdqQh167V2E4
Message-ID: <CAM0EoMnfAuWc2VAHB9g6druz8hkutX7Wk9eq3hUWe+HdRNF_tA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/tc-testing: Add DualPI2 GSO backlog
 accounting test
To: Xingquan Liu <b1n@b1n.io>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:b1n@b1n.io,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:chia-yu.chang@nokia-bell-labs.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300815-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 375AD6A8F39

On Fri, Jun 19, 2026 at 11:16=E2=80=AFAM Xingquan Liu <b1n@b1n.io> wrote:
>
> Add a regression test for DualPI2 GSO backlog accounting when it is
> used as a child qdisc of QFQ.
>
> The test sends one UDP GSO datagram through a QFQ class with DualPI2 as
> the leaf qdisc. DualPI2 splits the skb into two segments. After the
> traffic drains, both QFQ and DualPI2 must report zero backlog and zero
> qlen.
>
> On kernels with the broken accounting, QFQ can keep a stale non-zero
> qlen after all real packets have been dequeued.
>
> Signed-off-by: Xingquan Liu <b1n@b1n.io>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  .../tc-testing/tc-tests/qdiscs/dualpi2.json   | 44 +++++++++++++++++++
>  tools/testing/selftests/tc-testing/tdc_gso.py | 43 ++++++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100755 tools/testing/selftests/tc-testing/tdc_gso.py
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.j=
son b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
> index cd1f2ee8f354..ed6a900bb568 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
> @@ -250,5 +250,49 @@
>          "teardown": [
>              "$TC qdisc del dev $DUMMY handle 1: root"
>          ]
> +    },
> +    {
> +        "id": "891f",
> +        "name": "Verify DualPI2 GSO backlog accounting with QFQ parent",
> +        "category": [
> +            "qdisc",
> +            "dualpi2",
> +            "qfq",
> +            "gso"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$IP link set dev $DUMMY up || true",
> +            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
> +            "$TC qdisc add dev $DUMMY root handle 1: qfq",
> +            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 1=
 maxpkt 4096",
> +            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: dualpi2",
> +            "$TC filter add dev $DUMMY parent 1: matchall classid 1:1"
> +        ],
> +        "cmdUnderTest": "./tdc_gso.py 10.10.10.10 10.10.10.1 9000 1200 2=
400",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY",
> +        "matchJSON": [
> +            {
> +                "kind": "qfq",
> +                "handle": "1:",
> +                "packets": 2,
> +                "backlog": 0,
> +                "qlen": 0
> +            },
> +            {
> +                "kind": "dualpi2",
> +                "handle": "2:",
> +                "packets": 2,
> +                "backlog": 0,
> +                "qlen": 0
> +            }
> +        ],
> +        "teardown": [
> +            "$TC qdisc del dev $DUMMY root",
> +            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
> +        ]
>      }
>  ]
> diff --git a/tools/testing/selftests/tc-testing/tdc_gso.py b/tools/testin=
g/selftests/tc-testing/tdc_gso.py
> new file mode 100755
> index 000000000000..b66528ea4b68
> --- /dev/null
> +++ b/tools/testing/selftests/tc-testing/tdc_gso.py
> @@ -0,0 +1,43 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""
> +tdc_gso.py - send a UDP GSO datagram
> +
> +Copyright (C) 2026 Xingquan Liu <b1n@b1n.io>
> +"""
> +
> +import argparse
> +import socket
> +import struct
> +import sys
> +
> +UDP_MAX_SEGMENTS =3D 1 << 7
> +
> +
> +parser =3D argparse.ArgumentParser(description=3D"UDP GSO datagram sende=
r")
> +parser.add_argument("src", help=3D"source IPv4 address")
> +parser.add_argument("dst", help=3D"destination IPv4 address")
> +parser.add_argument("port", type=3Dint, help=3D"destination UDP port")
> +parser.add_argument("gso_size", type=3Dint, help=3D"UDP GSO segment payl=
oad size")
> +parser.add_argument("payload_len", type=3Dint, help=3D"total UDP payload=
 length")
> +args =3D parser.parse_args()
> +
> +if args.gso_size <=3D 0 or args.gso_size > 0xFFFF:
> +    parser.error("gso_size must fit in an unsigned 16-bit integer")
> +if args.payload_len <=3D args.gso_size:
> +    parser.error("payload_len must be larger than gso_size")
> +if args.payload_len > args.gso_size * UDP_MAX_SEGMENTS:
> +    parser.error("payload_len exceeds UDP_MAX_SEGMENTS")
> +
> +SOL_UDP =3D getattr(socket, "SOL_UDP", socket.IPPROTO_UDP)
> +UDP_SEGMENT =3D getattr(socket, "UDP_SEGMENT", 103)
> +
> +sock =3D socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
> +sock.bind((args.src, 0))
> +
> +payload =3D b"b" * args.payload_len
> +cmsg =3D [(SOL_UDP, UDP_SEGMENT, struct.pack("=3DH", args.gso_size))]
> +
> +sent =3D sock.sendmsg([payload], cmsg, 0, (args.dst, args.port))
> +sys.exit(sent !=3D len(payload))
> --
> Xingquan Liu
>

