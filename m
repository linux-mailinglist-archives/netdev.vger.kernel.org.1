Return-Path: <netdev+bounces-305180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X03jE6/pS2rScgEAu9opvQ
	(envelope-from <netdev+bounces-305180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:45:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1571407C
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:45:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s8C6YITl;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305180-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305180-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D468301BB93
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7257A2BE644;
	Mon,  6 Jul 2026 17:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994F3AE1A8
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:45:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359916; cv=none; b=h4yXvubIlkuT34I9uwOPPBRrezvpnN0z6+zgFCZAPRLeQVqxZedLzi4VHcWTFvCJYEYv81wxb4R1V9BPu6ZYQjOYcxRbVRS8OD16Fz8DKUC7p3OjZnhuPma93QN65w62t8uGNZKo7CB7JkOCwMVq0Ak74MzPxHhrc8qCqKjz0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359916; c=relaxed/simple;
	bh=cn+VU197UgOgFy+ZlUz1XqNMPTdsd/01FYsqu2dr1Bg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PrZ4yq7zPXEFoCyfBKh0O6uAh2m3pK/04Sic3wStYo8kv1UNS3AV4ZxCrTl+O+BV7ePoBumd4M2nS8xipBE4fMyDJCT2WqJzptMX9UkNAsubqm1irs34gGjqsTcm6U+LaRhCnvCegGHVAMV7Zz3xSzqcbpAWwzc6JMb6HzVlJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8C6YITl; arc=none smtp.client-ip=209.85.128.175
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80bb8287d99so41375557b3.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783359914; x=1783964714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHTEazAohpw6CA9quM3em+lASZBTbzUOB89kn7A3dMc=;
        b=s8C6YITlYiK7IZsp/oPuR77c2Z1GqAPEw4lRSYmpEKcT7GOt5aOJVFGp01NiIEolUw
         v00biLgckLy3qFcGo+9cb2i91vdXVgn1lhxvoZVK6CT+ruzfkGRLCfeBFd/vLUw+eH1S
         tSXH2iXUS5NxEzlC6O66LdR+wEajlEn4V912gmYXRyfjNEKDE1Z3IO2Ud9c9EaILSBwW
         6gV6l7rT+WRtkZWzU5z4G5mHnpYOEKKowHmaR3xfKhyk6v6QW3CZbHIQNQfUN2xoLgdz
         sIy0l6WSi8l2DQhakeTvREUEMoAreeh9LMcs2F0eUvyJ6xWy2pThTd8zXOny+z6LYdVJ
         tmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783359914; x=1783964714;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHTEazAohpw6CA9quM3em+lASZBTbzUOB89kn7A3dMc=;
        b=MYoJ/ty6fHsNE1K0xGIN8mEjiYQMNR0fza79y4RnjarMAWHWl+N6mniXDcbkJZe/wA
         KcbYiA05f7jjrEeq+xEgkZMdJJDCKqWY08gUnWBBX51P83mERF/CA6k+c+1PG+MaRWTH
         pThcr5AzkXChFL9k0UtevSCO0YNqVudCbcr8zcFNWiF455wOl+zHSC34iMtHW/dumQoR
         vIpqIbY9akoieajBsGEJTRbaCdiJaeUCz7IqiI/hnjhx0qhOrorsaEBgiy78NIn1fVyk
         we7ckGToHOCOM2nVBOTUXF3j+Va0WbGqEJE8iOLaG3rG4qMc9S64LY3V6AsoJAXqY5J5
         t6cQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBlROy+zl4IZCnqidj81Km9bJ8zVdLxKLvvastLC0KA8mQ9CS4zCcDRDEp1wFJeUNDuXagh+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpRgDH6pig2SFBdfmqNur6SRgpXqaq8WJp4dLBzUmJvkqAqOF
	QhpydDejnItOvsBAT3JWoiSm8Ny4ENR1yjj36Lo474AppXMDu8NMqqOV
X-Gm-Gg: AfdE7clz6lYOcvv+jPT0gJJyf/nBJMK2bX8rbmq17LNynFVuwSAaRmg6M8/r1M+ZRO3
	kPXwfOabPTJbgQ98/P57T+6LzGTNEPN26ck6LJcICofsw5BBbnSq2I3ruKmasbcBcWDv/31wbH6
	/xBpCv+i43hCCwHSbTmCpFDcnlaSm/5hAyTe9sNa4tJjiXWJSvltVUlx1VUISh+meIcKu1TpyfA
	XFh79ARlmLs8oMdflt8XmjSTArcswdIeKrNXlyWxx0cq4i85hkBsS319bpozXrqAsr6AaioNKp8
	wUjEu4nnrOROZM0YVGUBkszv+jj0YHxlpFZ62R41J15/8o3qqKPT5qnJ2olKe1O0GyBuqfZ32+S
	4n6KXfMYVNW+sL+1iGHLHPnOJ9qM9Xa7ZzL/bd2jlnpm8DiTm/2ISg9Bk73H3PSesAQn5xmvqkh
	/lbF+VW0xkxPIbVkp9BIE61Svb2g4sroaIj/xARfwVAlsyTxylsyEXUkAnvp1yrbqDGA==
X-Received: by 2002:a05:690c:63c2:b0:80d:c24f:b790 with SMTP id 00721157ae682-81be0d35bbamr10567447b3.5.1783359913613;
        Mon, 06 Jul 2026 10:45:13 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144783f9e2sm61157457b3.3.2026.07.06.10.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:45:12 -0700 (PDT)
Date: Mon, 06 Jul 2026 13:45:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1ab21e66eb906@gmail.com>
In-Reply-To: <b66a8b13a33b21a1d0bf620bc51b68d78a2c16e1.1783218197.git.littlesmilingcloud@gmail.com>
References: <cover.1783218197.git.littlesmilingcloud@gmail.com>
 <b66a8b13a33b21a1d0bf620bc51b68d78a2c16e1.1783218197.git.littlesmilingcloud@gmail.com>
Subject: Re: [PATCH net-next v5 2/2] selftests: net: add FOU multicast
 encapsulation resubmit test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:littlesmilingcloud@gmail.com,m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305180-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,fib_tests.sh:url,fou_mcast_encap.sh:url,fin_ack_lat.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2D1571407C

Anton Danilov wrote:
> Add a selftest to verify that FOU-encapsulated packets addressed to a
> multicast destination are correctly resubmitted to the inner protocol
> handler (GRE) via the UDP multicast delivery path.  Both IPv4 and IPv6
> paths are tested.
> 
> The test creates two network namespaces connected by a veth pair with
> a FOU/GRETAP (IPv4) and FOU/ip6gretap (IPv6) tunnel using multicast
> remote addresses (239.0.0.1 and ff0e::1).  Ping is sent through each
> tunnel and received packets are counted on the receiver's tunnel
> interface.
> 
> The veth pair is created directly inside the namespaces to avoid
> possible name collisions with devices in the root namespace.
> 
> Static neighbor entries are configured on the sender because ARP/ND
> replies from the receiver cannot traverse the unidirectional multicast
> tunnel back to the sender.
> 
> The early demux optimization (net.ipv4.ip_early_demux, which controls
> both IPv4 and IPv6) is disabled on the receiver to force packets
> through __udp4_lib_mcast_deliver() / __udp6_lib_mcast_deliver(), which
> is the code path being tested.
> 
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../testing/selftests/net/fou_mcast_encap.sh  | 177 ++++++++++++++++++
>  2 files changed, 178 insertions(+)
>  create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 708d960ae07d..7e9ae937cffa 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -39,6 +39,7 @@ TEST_PROGS := \
>  	fib_rule_tests.sh \
>  	fib_tests.sh \
>  	fin_ack_lat.sh \
> +	fou_mcast_encap.sh \
>  	fq_band_pktlimit.sh \
>  	gre_gso.sh \
>  	gre_ipv6_lladdr.sh \
> diff --git a/tools/testing/selftests/net/fou_mcast_encap.sh b/tools/testing/selftests/net/fou_mcast_encap.sh
> new file mode 100755
> index 000000000000..728513d55db4
> --- /dev/null
> +++ b/tools/testing/selftests/net/fou_mcast_encap.sh
> @@ -0,0 +1,177 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Test that UDP encapsulation (FOU) correctly handles packet resubmit
> +# when packets are delivered via the multicast UDP delivery path.
> +#
> +# When a FOU-encapsulated packet arrives with a multicast destination IP,
> +# __udp4_lib_mcast_deliver() / __udp6_lib_mcast_deliver() must resubmit
> +# it to the inner protocol handler (e.g., GRE) rather than consuming it.
> +# This test verifies both IPv4 and IPv6 paths by creating a FOU/GRETAP
> +# tunnel with a multicast remote address and sending ping through it.
> +#
> +# The early demux optimization can mask this issue by routing packets via
> +# the unicast path (udp[6]_unicast_rcv_skb), so we disable it to force
> +# packets through the multicast delivery function.
> +
> +source lib.sh
> +
> +NSENDER=""
> +NRECV=""
> +
> +FOU_PORT4=4797
> +FOU_PORT6=4798
> +MCAST4=239.0.0.1
> +MCAST6=ff0e::1
> +
> +TUN4_S=192.168.99.1
> +TUN4_R=192.168.99.2
> +TUN6_S=2001:db8:99::1
> +TUN6_R=2001:db8:99::2
> +
> +cleanup() {
> +	cleanup_all_ns
> +}
> +
> +trap cleanup EXIT
> +
> +setup_common() {
> +	setup_ns NSENDER NRECV
> +
> +	# Create veth pair directly inside namespaces to avoid name
> +	# collisions with devices in the root namespace.
> +	ip link add veth_s netns "$NSENDER" type veth \
> +		peer name veth_r netns "$NRECV"
> +
> +	ip -n "$NSENDER" link set veth_s up
> +	ip -n "$NRECV" link set veth_r up
> +
> +	# Same sysctl controls early demux for both IPv4 and IPv6.
> +	ip netns exec "$NRECV" sysctl -wq net.ipv4.ip_early_demux=0
> +}
> +
> +setup_ipv4() {
> +	ip -n "$NSENDER" addr add 10.0.0.1/24 dev veth_s
> +	ip -n "$NRECV" addr add 10.0.0.2/24 dev veth_r
> +
> +	# Join multicast group on receiver
> +	ip -n "$NRECV" addr add "$MCAST4/32" dev veth_r autojoin
> +
> +	ip -n "$NSENDER" route add 239.0.0.0/8 dev veth_s
> +	ip -n "$NRECV" route add 239.0.0.0/8 dev veth_r
> +
> +	# Sender: GRETAP with FOU encap (no FOU listener needed on TX side)
> +	ip -n "$NSENDER" link add eoudp4 type gretap \
> +		remote "$MCAST4" local 10.0.0.1 \
> +		encap fou encap-sport "$FOU_PORT4" encap-dport "$FOU_PORT4" \
> +		key "$MCAST4"
> +	ip -n "$NSENDER" link set eoudp4 up
> +	ip -n "$NSENDER" addr add "$TUN4_S/24" dev eoudp4
> +
> +	# Receiver: FOU listener + GRETAP
> +	ip netns exec "$NRECV" ip fou add port "$FOU_PORT4" ipproto 47
> +	ip -n "$NRECV" link add eoudp4 type gretap \
> +		remote "$MCAST4" local 10.0.0.2 \
> +		encap fou encap-sport "$FOU_PORT4" encap-dport "$FOU_PORT4" \
> +		key "$MCAST4"
> +	ip -n "$NRECV" link set eoudp4 up
> +	ip -n "$NRECV" addr add "$TUN4_R/24" dev eoudp4
> +
> +	# Static neigh on sender: ARP replies cannot traverse the
> +	# unidirectional multicast tunnel.
> +	local recv_mac
> +	recv_mac=$(ip -n "$NRECV" link show eoudp4 | awk '/ether/{print $2}')
> +	ip -n "$NSENDER" neigh add "$TUN4_R" lladdr "$recv_mac" dev eoudp4
> +}
> +
> +setup_ipv6() {
> +	# Skip cleanly if IPv6 is not available in the running kernel.
> +	[ -e /proc/sys/net/ipv6 ] || return "$ksft_skip"
> +	modprobe -q fou6 || return "$ksft_skip"

Is the equivalent not needed for fou?

More importantly, this means we need to add CONFIG_IPV6_FOU to
tools/testing/selftests/net/config

> +
> +	ip -n "$NSENDER" addr add 2001:db8::1/64 dev veth_s nodad
> +	ip -n "$NRECV" addr add 2001:db8::2/64 dev veth_r nodad
> +
> +	# Join multicast group on receiver
> +	ip -n "$NRECV" addr add "$MCAST6/128" dev veth_r autojoin
> +
> +	ip -n "$NSENDER" -6 route add ff00::/8 dev veth_s
> +	ip -n "$NRECV" -6 route add ff00::/8 dev veth_r
> +
> +	# Sender: ip6gretap with FOU encap
> +	ip -n "$NSENDER" link add eoudp6 type ip6gretap \
> +		remote "$MCAST6" local 2001:db8::1 \
> +		encap fou encap-sport "$FOU_PORT6" encap-dport "$FOU_PORT6" \
> +		key 42
> +	ip -n "$NSENDER" link set eoudp6 up
> +	ip -n "$NSENDER" addr add "$TUN6_S/64" dev eoudp6 nodad
> +
> +	# Receiver: FOU listener (IPv6) + ip6gretap
> +	ip netns exec "$NRECV" ip fou add port "$FOU_PORT6" ipproto 47 -6
> +	ip -n "$NRECV" link add eoudp6 type ip6gretap \
> +		remote "$MCAST6" local 2001:db8::2 \
> +		encap fou encap-sport "$FOU_PORT6" encap-dport "$FOU_PORT6" \
> +		key 42
> +	ip -n "$NRECV" link set eoudp6 up
> +	ip -n "$NRECV" addr add "$TUN6_R/64" dev eoudp6 nodad
> +
> +	# Static neigh on sender: neighbor discovery cannot traverse the
> +	# unidirectional multicast tunnel.
> +	local recv_mac
> +	recv_mac=$(ip -n "$NRECV" link show eoudp6 | awk '/ether/{print $2}')
> +	ip -n "$NSENDER" neigh add "$TUN6_R" lladdr "$recv_mac" dev eoudp6

I think these two functions can probably be deduplicated easily. But I
may be wrong, e.g., if there are too many nodad, autojoin, etc special
cases to have to take care of.. Fine to leave as is too.

> +}
> +
> +get_rx_packets() {
> +	local dev="$1"
> +
> +	ip -n "$NRECV" -s link show "$dev" | awk '/RX:/{getline; print $2}'
> +}
> +
> +run_ping_test() {
> +	local family="$1"
> +	local dev="$2"
> +	local dst="$3"
> +	local count=100
> +	local rx_before rx_after rx_delta
> +
> +	# Warmup: let any initial broadcast/ND traffic settle
> +	ip netns exec "$NSENDER" ping "$family" -c 1 -W 1 "$dst" \
> +		>/dev/null 2>&1
> +	sleep 1
> +
> +	rx_before=$(get_rx_packets "$dev")
> +	ip netns exec "$NSENDER" ping "$family" -c $count -W 1 "$dst" \
> +		>/dev/null 2>&1

Pass -i 0.01 to speed this up?

> +	sleep 1
> +	rx_after=$(get_rx_packets "$dev")
> +
> +	rx_delta=$((rx_after - rx_before))
> +
> +	if [ "$rx_delta" -ge "$count" ]; then
> +		echo "PASS: received $rx_delta/$count packets"
> +		return "$ksft_pass"
> +	elif [ "$rx_delta" -gt 0 ]; then
> +		echo "FAIL: only $rx_delta/$count packets received"
> +		return "$ksft_fail"
> +	else
> +		echo "FAIL: 0/$count packets received"
> +		return "$ksft_fail"
> +	fi
> +}
> +
> +ret=0
> +
> +echo "TEST: FOU/GRETAP IPv4 multicast encapsulation resubmit"
> +setup_common
> +setup_ipv4
> +run_ping_test -4 eoudp4 "$TUN4_R" || ret=$?
> +
> +echo "TEST: FOU/GRETAP IPv6 multicast encapsulation resubmit"
> +if setup_ipv6; then
> +	run_ping_test -6 eoudp6 "$TUN6_R" || ret=$?
> +else
> +	echo "SKIP: IPv6 unavailable"

Use KSFT_SKIP for such cases.

> +fi
> +
> +exit $ret
> -- 
> 2.47.3
> 



