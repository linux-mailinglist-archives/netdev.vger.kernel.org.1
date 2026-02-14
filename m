Return-Path: <netdev+bounces-258693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM8MB4k9kGlsXwEAu9opvQ
	(envelope-from <netdev+bounces-258693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 10:16:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8060913B8DC
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 10:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69E9D3012CD7
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5865C296BD6;
	Sat, 14 Feb 2026 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKF4koz4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D147244667
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771060613; cv=none; b=sqLhb6wnYL9qWZiN/vSibprtOvCwr0iqTz56wATpvBVD1BRbMaDiIUAu0vj64JL2W+J/RoDMK/qsTBVub+t4w0CXYM+QljMwFVoGzchEVyhIaGazHrRQthutAJdCqwcqD5+kMKlSvS6KKgCND3RUXL18GZQXA8zypA/W9ERO4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771060613; c=relaxed/simple;
	bh=HNt0VJ2HkxsGZyeRuhZle7vNxt+C1jmU3rUUdiOO7VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNZpIkzNHTZWzyeztY2uTXA+L32Q8Uw/w8RBVVJmiMOVWPqHOIcouVOzDPE4bEkvlduaOd6UaamiSvdITWSm7D50aNslS8ex3nIeRETz1HI2HLwS+SCbz4NU/P2XiBaz061qwfpaLAZ9GwLlKYry92JpXObJ18y6DKD0AkQzeXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKF4koz4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso1355815b3a.2
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 01:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771060611; x=1771665411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gi1ZY//tEIrvp4BDXWCtR0oF5AWirPZCC8vtm2Q4UoE=;
        b=GKF4koz41ZmBVH7Fi2IrerwCy+G8B8+EeAukkSdcon2+LqBMDOhg5S2qZq9WHtNtWk
         7luUL5aKbrcf6HDALH2KbJ3ZVL7MltfL+lkBaHW5ccV5rE86LJOg2j8Rkym3+ngJsDsw
         Z3H5Zy5o/yt2VpY7H8u3qF6WEe8whlCkl526rZuKwrWksEjEHPT29KJbEMQRRZhzoCpv
         fxLKG9kqZm99fjCzw8QNTBn8A6+J1sWqjSntb7O/MfdYFVN+gEOTdFD9nRkqgp4RAdE8
         BkGxOK53egBVAu8wv+stfZCNZxz5p7KYfRutlJzJv2c2ei+z2VerNSsV0nNVWNQGGVOn
         x1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771060611; x=1771665411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gi1ZY//tEIrvp4BDXWCtR0oF5AWirPZCC8vtm2Q4UoE=;
        b=qz43upABY3Wnw9e608F40AwBzDFIScVhaoU6XvHQadnWAKVA+8YIAlHIwgHdJPZ318
         1XpaOLT1/b+RueJmch611d8YIyRuVDEUR6SJwSC22BGlTFXghaxrucNVyUB+GI2QV8Ec
         kI5YjjuLgh+ehEvuo5+/RdYLiRO3jYFt4U6ULdWs7LEHKGnRbFkLJzFKbYh8WzAc6QJR
         Hl8502v+0heWHX4K5O8f9gNIa7Fk8EiBJaX93XhLWyy1dxs9GcFmMGTAOtF6K4EP+s5/
         SRAmFlRmDaa/M/t5EF6BVI63GEqoRNn8ZhqFphFY6S5glalnYpqyDxs6jnmOTE48WQ87
         Wg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcwSJOLHFIkqBD+ep4YPOWxnFzjIFm1b0ili6Qe4n4WH0aI7fBk891jGrf8e+W6DQ75U0qrSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPEwP5el5K9yFhVSImlJLn2UQGS75leNdV1AC66X8TKpMtvnUP
	3lIh6WAeJpegAYPnG7a+vZtF3UZjYOE84M3KuT9l1wJx9OuPV3Dtji4x
X-Gm-Gg: AZuq6aKqBef1W6qVJoWqi5CERMsOIb1eW1XcqwMfuPebFWoi+S4Sk/qzYz2HZqAY+as
	4f3zhUdSLQhRYIueN6i1vu6edBuhL3fkf5/jGvLDSNx0gkI9c1zeFPJwFBzgOGuUtJJrlaEtjji
	J5+W2wA6PGJQzpVH7ALZx2bWw/sPN7d+mLWyNXsUsHHQqi3QDHiEH5z+YrMuxbYCe/biKkV3cgG
	DwT2SV3obetkcOYt+d7pCZYhsxgWFGMTT/7k9dlaNlOPh+2HHkG8f3gmK6l9ZpJIVSBGAWKb4rY
	SZcL3yu1PjjHhcYADSdJdanlPkmm4J/Yc82xyr3NIvAHNlMi2RdLXOK2bwBndqXZN+egzShOt6+
	nNQ4A2ozi1jjU11/Gtbf3RLSO9iy0g55mt2OBeuXQpC5J2cTf+QM1qF0rOMOqbS9IynjzeXiP1p
	Lo65uK8VDNxyMDo1RR62cLWasOanA=
X-Received: by 2002:a05:6a00:3e04:b0:81e:f623:b9fe with SMTP id d2e1a72fcca58-824c5ea256bmr5342827b3a.4.1771060611335;
        Sat, 14 Feb 2026 01:16:51 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69f2asm4961910b3a.37.2026.02.14.01.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 01:16:50 -0800 (PST)
Date: Sat, 14 Feb 2026 09:16:43 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Linus Heckemann <git@sphalerite.org>
Cc: edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
	eric.dumazet@gmail.com, horms@kernel.org, morikw2@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com, rbm@suse.com
Subject: Re: [PATCH v3] selftests/net: add test for IP-in-IPv6 tunneling
Message-ID: <aZA9e73hxZY6eN1b@fedora>
References: <20260214080553.1317672-2-git@sphalerite.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214080553.1317672-2-git@sphalerite.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258693-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,davemloft.net,gmail.com,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lib.sh:url,ipv6_flowlabel.sh:url,io_uring_zerocopy_tx.sh:url]
X-Rspamd-Queue-Id: 8060913B8DC
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 09:05:54AM +0100, Linus Heckemann wrote:
> commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
> __ip6_tnl_rcv()") was fine in and of itself, but its backport to 6.12
> (and 6.6) broke IPv4-in-IPv6 tunneling, see [1]. This adds a self-test
> for basic IPv4-in-IPv6 and IPv6-in-IPv6 functionality.
> 
> [1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com/
> 
> Signed-off-by: Linus Heckemann <git@sphalerite.org>
> --
> Compared to previous version:
> * Added DCO as requested by Jakub
> * Suppressed output of ping and the expected-to-fail `ip link delete` cleanup invocation as suggested by Jakub
> * Added `set -e` as suggested by Hangbin
> 
> Not sure about the etiquette regarding the Tested-by line: Ricardo
> tested v1 of the patch, I guess I shouldn't add it to a respin?
> ---
>  tools/testing/selftests/net/Makefile      |  1 +
>  tools/testing/selftests/net/ip6_tunnel.sh | 44 +++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 tools/testing/selftests/net/ip6_tunnel.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 45c4ea381bc36..5037a344ad826 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -43,6 +43,7 @@ TEST_PROGS := \
>  	io_uring_zerocopy_tx.sh \
>  	ioam6.sh \
>  	ip6_gre_headroom.sh \
> +	ip6_tunnel.sh \
>  	ip_defrag.sh \
>  	ip_local_port_range.sh \
>  	ipv6_flowlabel.sh \
> diff --git a/tools/testing/selftests/net/ip6_tunnel.sh b/tools/testing/selftests/net/ip6_tunnel.sh
> new file mode 100644
> index 0000000000000..fe081a5218199
> --- /dev/null
> +++ b/tools/testing/selftests/net/ip6_tunnel.sh
> @@ -0,0 +1,44 @@
> +#!/bin/bash
> +# Test that IPv4-over-IPv6 tunneling works.
> +
> +source lib.sh
> +set -e
> +
> +setup_prepare() {
> +  ip link add transport1 type veth peer name transport2
> +
> +  setup_ns ns1
> +  ip link set transport1 netns $ns1
> +  ip -n $ns1 address add 2001:db8::1/64 dev transport1 nodad
> +  ip -n $ns1 address add 2001:db8::3/64 dev transport1 nodad
> +  ip -n $ns1 link set transport1 up
> +  ip -n $ns1 link add link transport1 name tunnel4 type ip6tnl mode ipip6 local 2001:db8::1 remote 2001:db8::2
> +  ip -n $ns1 address add 172.0.0.1/32 peer 172.0.0.2/32 dev tunnel4
> +  ip -n $ns1 link set tunnel4 up
> +  ip -n $ns1 link add link transport1 name tunnel6 type ip6tnl mode ip6ip6 local 2001:db8::3 remote 2001:db8::4
> +  ip -n $ns1 address add 2001:db8:6::1/64 dev tunnel6
> +  ip -n $ns1 link set tunnel6 up
> +
> +  setup_ns ns2
> +  ip link set transport2 netns $ns2
> +  ip -n $ns2 address add 2001:db8::2/64 dev transport2 nodad
> +  ip -n $ns2 address add 2001:db8::4/64 dev transport2 nodad
> +  ip -n $ns2 link set transport2 up
> +  ip -n $ns2 link add link transport2 name tunnel4 type ip6tnl mode ipip6 local 2001:db8::2 remote 2001:db8::1
> +  ip -n $ns2 address add 172.0.0.2/32 peer 172.0.0.1/32 dev tunnel4
> +  ip -n $ns2 link set tunnel4 up
> +  ip -n $ns2 link add link transport2 name tunnel6 type ip6tnl mode ip6ip6 local 2001:db8::4 remote 2001:db8::3
> +  ip -n $ns2 address add 2001:db8:6::2/64 dev tunnel6
> +  ip -n $ns2 link set tunnel6 up
> +}
> +
> +cleanup() {
> +  cleanup_all_ns
> +  # in case the namespaces haven't been set up yet
> +  ip link delete transport1 &>/dev/null || true
> +}
> +
> +trap cleanup EXIT
> +setup_prepare
> +ip netns exec $ns1 ping -q -W1 -c1 172.0.0.2 >/dev/null
> +ip netns exec $ns1 ping -q -W1 -c1 2001:db8:6::2 >/dev/null
> -- 
> 2.52.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

