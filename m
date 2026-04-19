Return-Path: <netdev+bounces-279602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLAfJtIB5WlQdAEAu9opvQ
	(envelope-from <netdev+bounces-279602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 18:24:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8146424ADD
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3749A301A92A
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A1828B7DB;
	Sun, 19 Apr 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KdKkuyz+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57A29B8D3
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615876; cv=pass; b=tffNV9HWHdJM1JfjxKeQWaB9NT95TRQ0mWKJllNJ7wa8pYtvvXezdCsjAJ55mAzYK8RfGWFCgqQPVEot+2dLox4CwvaN2pr9Vj3WKPsXGZGpGbw9Jmz4C+AoeXtKlxnqiv7aV5IYzix/mVSt4qMaztxmA9pFAufuJ6tFJQIADz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615876; c=relaxed/simple;
	bh=Oa/bOtJS6oZncrmAuuUKDXtaufqkEKqCbkkonO+d9Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6t12GkXfXcdEiNrxx7r65jdQ2pK6hA9cWayuMMgqn94ZtbApvWHVpuQDFi2wCwcrfmNXNhUtVm9dyEikOtOqiLkwaQ2hnK8ykpavO6io8qa+30vKbhyIdL6jIfh07mrwSFrE7RRkmjXGzTydbRXwSTlrBQ33zsETMAvSYYgX5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=KdKkuyz+; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c1a170a50so2643099c88.0
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 09:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776615871; cv=none;
        d=google.com; s=arc-20240605;
        b=jsoXDh3c2SnDASConXqJ5oPAdS5EvSlqeqq6z3HMZ1tTX7gOuXcwPXDjwzDvIvJeRw
         oE6hiocT01wTX+c6qRCTSiTCZKQqseNNgDStqPfKNkSy3EanZ+2yxeI1NYNHyAQI6E6B
         oalJHjANnWSsdjsMwZf8wyzYXWvHTikfHgDtKUXYIa/o2hFBJ0gqeScrNIw1SedzeuyR
         DK4ZlhLBjtVVs8cu+vv41I66tYejxmubYpQSU8tSilCC2QYWBz7OywwDqzVhqsNdUafN
         yLP/DQn7e1HTwAF/sJ1sj/MXUfROh2rTqeM1F5Y9O0pgss5J+kqcnE7fHqApYHpOpOR/
         qySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fhz3ret054MdFaJXeInCPLO+ksTX9hC1dSGx3lEuqxI=;
        fh=FCoQNj5f0sTQAktXE4uXLg4kxzkNkaVkLDrBMsC92tA=;
        b=Fn9VBkYnzUJMQYCtaNvbkcqfQ7PVMZDYHO//L0FW6cFRvVGDFXrYBg+Kciyi5r2100
         rCSgLWMHEG7ttfpigSoZGSOWNsDKAYdVU8Ay7Ro+ETgi1AF0jo8TR7/X5PMgwYMinTfG
         iXn6P2F47dEGvkFM/0uIjBeZP+Tbrpp1Hd1ANvTHRNlAIfBLCmvPLskauHEx712SiaDW
         gt1mPcpQIq7P2AGNuwpKtfALS8ALEKTg6IdYFpW15xlfgOpWyfwA2/epkLdBabru7CqC
         44dUd8EKtKwRR5Zf2RXJjATvKUb9chIvZiNl4Z2zavlRgpuANk6TnQR52eY98l20eDxw
         VYTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1776615871; x=1777220671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fhz3ret054MdFaJXeInCPLO+ksTX9hC1dSGx3lEuqxI=;
        b=KdKkuyz+HmDWfklzKkq2tXJa8ESZzBWldgz8tfNsJhQ9NYKE9JCnIyq19t/fcdE2xZ
         JSUXjADUkX+Bv1+CuKSgrjeBJel1wyPfxNVPg6BTvtcJcqiRSYg7gcufar4YoS5XbsHx
         xlbo9R949teQsB/f7xh/0Ta1QWCwXH5cMEIptQ/1vhqe5lDO32qg32NXuAPkB6kfn3SG
         iHfQtXWKMUudEKNplCWkLqIsSI1og78zEDvNZk/NNDfofzG7SmVxccBbMyKeCXyWD4+O
         TrwcvswlL7w/nQNYOZGW4o9ARNspa6bVK+SPOlXF/54J6G/DpTeEquaLN6Sku6RSD7nQ
         KU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776615871; x=1777220671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhz3ret054MdFaJXeInCPLO+ksTX9hC1dSGx3lEuqxI=;
        b=KLAMP8W3jWfzcYwBVaiZBv/Qf8euknVXDJUGCkMZhYK1jaWdbnoYzsByWCwId6L80P
         LUdNPwJq+QLnG2UONnvQWDrmbmCBH3L1N6ey6RxdHUdcMDsZ06H2jnCHP6oR0kOm8OwK
         ReV9deGFWt4Zs+lcWffVJJDI55FU9HkGoxQgvLFQyyZEwyFjCo95P6KlxOPeoZIaTGcj
         PgunQklTlFrnxMbjgNePhUsLQZfMy4tiSSx68+SlLe/FV5A3hxLORATRd1pAT57XI/8Y
         2g+RboQMYEoYv/8QH/0ej5CIf1fhijQVbw5nW309JrIJFThuVGwcxICJp4a72lA3PjJs
         AUvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Xs/DWo88gi93gfy26iVOxAxsDyU55sU5l33TqpX5vzc5bg0RrYcujSeuoQhHDwEMX7+HJWVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6Tzql1lTfayIqmUMgwVdLTpVJBcwujEU0LjgApINPhZIrCTQ
	dMgxppQLUwz/+oEr0gYrzOhr081GHXQBCAzGcXD9s3W2f4zyrO4N2n/qTQ5twbwp8Wc5IroBj+p
	O+wJvncvZbT5iIFmLe9Saj2HNr38icFZUhj0D/i/pFg==
X-Gm-Gg: AeBDieva9Jazrc30Y2DOhI5bNvKzB6hdfMQUk+YYEVArHadE8pTU8QSSCRcY9459oSH
	wUwFj2um7Y3mvQIznJ/Z0s+uh3Rxr9Qr2jmmpny5fRTjYOuQkGldYx6JgvskYVrDU0aejcSKr9H
	iXOCOeTf/f/+l7dLT53ARJhvwWMH58/R1Vh9n1m+iJY39HL/diap4Q5HeYFFEgYIFwN8Nxl17wD
	Xs64YvlShwDywGdDgBxMj+5FokDk4HriF42xKlAA4FhdTanKdWgRHGi999v4t4VD2MUexayOMej
	9U1lPdv7UXJz6L4K4El12PeC3ZuLyUSJVE4nwsLgc1fqP9sMuFjMOclkmFcLaYDhTCey3KLp/J/
	rJ5GfSDHCc832tg==
X-Received: by 2002:a05:7022:f9e:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-12c73fa8fa3mr4508309c88.34.1776615871257; Sun, 19 Apr 2026
 09:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
 <20260410150943.993350-13-alice.kernel@fastmail.im> <willemdebruijn.kernel.cb6bcf72d6ec@gmail.com>
In-Reply-To: <willemdebruijn.kernel.cb6bcf72d6ec@gmail.com>
From: Alice Mikityanska <alice@isovalent.com>
Date: Sun, 19 Apr 2026 19:24:14 +0300
X-Gm-Features: AQROBzCiW8JQP6x0iu8lsg6sYPGBdE6EOrDcQti8Yy0YbMaErZ9KQrJHAcJ1wPc
Message-ID: <CAD0BsJXyHQADVymJw7L0sA72P-=E8Wz7p3CedyvCbqEHBu17JA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 12/12] selftests: net: Add a test for BIG TCP
 in UDP tunnels
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279602-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[isovalent.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org,lunn.ch,strlen.de,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:dkim,isovalent.com:email,bpf_offload.py:url,big_tcp.sh:url,mail.gmail.com:mid,bridge_vlan_dump.sh:url]
X-Rspamd-Queue-Id: E8146424ADD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 16 Apr 2026 at 14:06, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Alice Mikityanska wrote:
> > From: Alice Mikityanska <alice@isovalent.com>
> >
> > The test sets up VXLAN and GENEVE tunnels over IPv4 and IPv6 and runs
> > IPv4 and IPv6 traffic through them with BIG TCP enabled. It checks that
> > a non-negligible amount of big aggregated packets are seen in tcpdump.
> >
> > Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> > ---
> >  tools/testing/selftests/net/Makefile          |   1 +
> >  .../testing/selftests/net/big_tcp_tunnels.sh  | 145 ++++++++++++++++++
> >  2 files changed, 146 insertions(+)
> >  create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> > index cab74ebdaced..c8ea9d4bb94f 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -13,6 +13,7 @@ TEST_PROGS := \
> >       arp_ndisc_untracked_subnets.sh \
> >       bareudp.sh \
> >       big_tcp.sh \
> > +     big_tcp_tunnels.sh \
> >       bind_bhash.sh \
> >       bpf_offload.py \
> >       bridge_vlan_dump.sh \
> > diff --git a/tools/testing/selftests/net/big_tcp_tunnels.sh b/tools/testing/selftests/net/big_tcp_tunnels.sh
> > new file mode 100755
> > index 000000000000..b819911519ac
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/big_tcp_tunnels.sh
> > @@ -0,0 +1,145 @@
> > +#!/usr/bin/env bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Testing for IPv4 and IPv6 BIG TCP over VXLAN and GENEVE tunnels.
> > +
> > +SERVER_NS=$(mktemp -u server-XXXXXXXX)
> > +SERVER_IP4="192.168.1.1"
> > +SERVER_IP6="2001:db8::1:1"
> > +SERVER_IP4_TUN="192.168.2.1"
> > +SERVER_IP6_TUN="2001:db8::2:1"
> > +
> > +CLIENT_NS=$(mktemp -u client-XXXXXXXX)
> > +CLIENT_IP4="192.168.1.2"
> > +CLIENT_IP6="2001:db8::1:2"
> > +CLIENT_IP4_TUN="192.168.2.2"
> > +CLIENT_IP6_TUN="2001:db8::2:2"
> > +
> > +PACKETS_THRESHOLD=10000
> > +
> > +# Kselftest framework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +
> > +setup() {
> > +     ip netns add "$SERVER_NS"
> > +     ip netns add "$CLIENT_NS"
> > +     ip -netns "$SERVER_NS" link add link1 type veth peer name link0 netns "$CLIENT_NS"
> > +
> > +     ip -netns "$CLIENT_NS" link set link0 up
> > +     ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4/24" dev link0
> > +     ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6/112" dev link0 nodad
> > +     ip -netns "$CLIENT_NS" link set link0 \
> > +             gso_max_size 196608 gso_ipv4_max_size 196608 \
> > +             gro_max_size 196608 gro_ipv4_max_size 196608
> > +     ip -netns "$SERVER_NS" link set link1 up
> > +     ip -netns "$SERVER_NS" addr replace "$SERVER_IP4/24" dev link1
> > +     ip -netns "$SERVER_NS" addr replace "$SERVER_IP6/112" dev link1 nodad
> > +     ip -netns "$SERVER_NS" link set link1 \
> > +             gso_max_size 196608 gso_ipv4_max_size 196608 \
> > +             gro_max_size 196608 gro_ipv4_max_size 196608
> > +
> > +     ip netns exec "$SERVER_NS" netserver >/dev/null
> > +}
> > +
> > +setup_tunnel() {
> > +     if [ "$2" = 4 ]; then
> > +             SERVER_IP="$SERVER_IP4"
> > +             CLIENT_IP="$CLIENT_IP4"
> > +             echo "Setting up ${1^^} over IPv4"
> > +     else
> > +             SERVER_IP="$SERVER_IP6"
> > +             CLIENT_IP="$CLIENT_IP6"
> > +             echo "Setting up ${1^^} over IPv6"
> > +     fi
> > +
> > +     if [ "$1" = vxlan ]; then
> > +             ip -netns "$CLIENT_NS" link add tun0 type vxlan \
> > +                     id 5001 remote "$SERVER_IP" local "$CLIENT_IP" dev link0 dstport 4789
> > +     else
> > +             ip -netns "$CLIENT_NS" link add tun0 type geneve \
> > +                     id 5001 remote "$SERVER_IP"
> > +     fi
> > +     ip -netns "$CLIENT_NS" link set tun0 up
> > +     ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4_TUN/24" dev tun0
> > +     ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6_TUN/112" dev tun0 nodad
> > +     ip -netns "$CLIENT_NS" link set tun0 \
> > +             gso_max_size 196608 gso_ipv4_max_size 196608 \
> > +             gro_max_size 196608 gro_ipv4_max_size 196608
> > +     if [ "$1" = vxlan ]; then
> > +             ip -netns "$SERVER_NS" link add tun1 type vxlan \
> > +                     id 5001 remote "$CLIENT_IP" local "$SERVER_IP" dev link1 dstport 4789
> > +     else
> > +             ip -netns "$SERVER_NS" link add tun1 type geneve \
> > +                     id 5001 remote "$CLIENT_IP"
> > +     fi
> > +     ip -netns "$SERVER_NS" link set tun1 up
> > +     ip -netns "$SERVER_NS" addr replace "$SERVER_IP4_TUN/24" dev tun1
> > +     ip -netns "$SERVER_NS" addr replace "$SERVER_IP6_TUN/112" dev tun1 nodad
> > +     ip -netns "$SERVER_NS" link set tun1 \
> > +             gso_max_size 196608 gso_ipv4_max_size 196608 \
> > +             gro_max_size 196608 gro_ipv4_max_size 196608
> > +}
> > +
> > +cleanup_tunnel() {
> > +     ip -netns "$CLIENT_NS" link del tun0
> > +     ip -netns "$SERVER_NS" link del tun1
> > +}
> > +
> > +cleanup() {
> > +     ip netns exec "$SERVER_NS" killall netserver
> > +     ip netns del "$SERVER_NS"
> > +     ip netns del "$CLIENT_NS"
> > +}
> > +
> > +do_test() {
> > +     exec 3< <(ip netns exec "$SERVER_NS" tcpdump -nn -i link1 greater 65536 2> /dev/null)
> > +     TCPDUMP_SERVER_PID="$!"
> > +     exec 4< <(wc -l <&3)
> > +     exec 5< <(ip netns exec "$CLIENT_NS" tcpdump -nn -i link0 greater 65536 2> /dev/null)
> > +     TCPDUMP_CLIENT_PID="$!"
> > +     exec 6< <(wc -l <&5)
> > +
> > +     if [ "$1" = 4 ]; then
> > +             SERVER_IP="$SERVER_IP4_TUN"
> > +             echo "Running IPv4 traffic in the tunnel"
> > +     else
> > +             SERVER_IP="$SERVER_IP6_TUN"
> > +             echo "Running IPv6 traffic in the tunnel"
> > +     fi
> > +
> > +     ip netns exec "$CLIENT_NS" netperf -t TCP_STREAM -l 5 -H "$SERVER_IP" -- \
> > +             -r 80000:80000 > /dev/null
>
> is -r valid for TCP_STREAM

Yes, it controls how much data is sent in one send() syscall. If I set
a smaller size, the kernel will still try to aggregate the packets,
but there will be much fewer BIG TCP packets.

> > +     kill "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID"
> > +     wait "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID"
> > +     PACKETS_SERVER=$(cat <&4)
> > +     PACKETS_CLIENT=$(cat <&6)
> > +     exec 3>&- 4>&- 5>&- 6>&-
> > +
> > +     # One line is empty, each packet is two lines (inner and outer).
> > +     echo "Captured BIG TCP GRO packets: $(((PACKETS_SERVER - 1) / 2))"
> > +     echo "Captured BIG TCP GSO packets: $(((PACKETS_CLIENT - 1) / 2))"
> > +     [ "$PACKETS_SERVER" -gt "$(( PACKETS_THRESHOLD * 2 + 1))" ] || return 1
> > +     [ "$PACKETS_CLIENT" -gt "$(( PACKETS_THRESHOLD * 2 + 1))" ] || return 1
> > +}
> > +
> > +if ! netperf -V &> /dev/null; then
> > +     echo "SKIP: Could not run test without netperf tool"
> > +     exit "$ksft_skip"
> > +fi
> > +
> > +if ! ip link help 2>&1 | grep gso_ipv4_max_size &> /dev/null; then
> > +     echo "SKIP: Could not run test without gso/gro_ipv4_max_size supported in ip-link"
> > +     exit "$ksft_skip"
> > +fi
> > +
> > +trap cleanup EXIT
> > +setup
> > +for tunnel in vxlan geneve; do
> > +     for tun_family in 4 6; do
> > +             for traffic_family in 4 6; do
> > +                     setup_tunnel "$tunnel" "$tun_family" || exit "$?"
> > +                     do_test "$traffic_family" || exit "$?"
> > +                     cleanup_tunnel
> > +             done
> > +     done
> > +done
> > --
> > 2.53.0
> >
>
>

