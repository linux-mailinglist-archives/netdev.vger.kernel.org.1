Return-Path: <netdev+bounces-257989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMmfCnJSimmmJQAAu9opvQ
	(envelope-from <netdev+bounces-257989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 22:32:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF4A114D3B
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 22:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB2330053EF
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEC52DB7B9;
	Mon,  9 Feb 2026 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XphtyStZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA582472A5
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672751; cv=none; b=YXZhJ9fng/EIYIOoj1XyKuKsF0u7oaCi/8ZuVPfJBmAOIT0pcxaL6gn3j5IHn1/fFR5avY7clJIgUbiaVpQMyOrlfV/sbTpbB5kmEtg80yxohXuBWJmOQ6bc6OSWeB7r2JuRZ+OcfMgiPDWp2ZxjDRAtIztvyXr1M6Kux0eqV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672751; c=relaxed/simple;
	bh=T+Fk21dUvrQZYxgSv0XUKkLSAScvJhgCZ/DlSgD/nOo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=DmasgkF5zyVQak6nXzWJ7alA6P+ZXco3GXRjEpNmwWVlTJW67m4ZVrm/2obg5nm7oK2GBfXwCMhu6hbNEcxwmnu6NP7layi1xJ0YxixFJ3M+Vqq4H3zYrGKBOii30/tn8sE18xfm41SzgVC19oSk+IMTPQg9vfUCI63PbZ7RwDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XphtyStZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso47159645e9.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 13:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770672748; x=1771277548; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dJtO70FFnrhjiNDZOxoNyFZn62CGtwxcp8ZJ6fPpIg=;
        b=XphtyStZmPZty5PoT1+ef0Cv76n1Q8VfkkZRN7SPmnwmf+RKjtG7wUZlO1x1RYw8B+
         TXwph4lCdMCMZ5R3UlZodsjldxmakqkKR/QVeIOeIvX+neETePNhj9ABy9Oc+Ooxg7Ke
         ToEHVnq0qxfkYcu/VAXH7Mb6IHCNHZOs8lb2AL33L84YTiIY7AhX4xyXBLAkkaTbyhht
         OGgOn38AgI+NS7P5EX1O7J/angSet1R9RrpmwMMIETaIRhf0pxHdtI1dvRdwTGHtRpM8
         ySNsO9dR/YffJoJuqdH+DOHRYPJQiHgXkmSx8u+DAkoFWGBfScB1nUOmWVh8Jmehfd5R
         UOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672748; x=1771277548;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dJtO70FFnrhjiNDZOxoNyFZn62CGtwxcp8ZJ6fPpIg=;
        b=S+2s5qjczpFg3uTM7OcASxK9uhrg8xF9zE+7KBDuP2TxC94bJMQigPskcfd9idzmcd
         48zxPWRT8nPtSfOwgLG0ZTnEYO08RZ6u4CR8qNHHYSQxWH+Sfh4m+T7OMOmXNXc7KzK/
         YGpl+dVMOEefB47YcYhj88MELPAM9F0+qK37O0dX48qvBd4tbBQOwH+8jghjZxRGlbSP
         /tYLpiYKC+PCCdkUc12+E96pSmJo+emlDFuPuRJou6i8sJgbohYeLlWqzeyWtNrOXKZV
         524Yq1wnfvqwBkUPGqlEP5tceQP9OE86H2gCfgpBuj4OrSIf5BuPlxO0MF7CEePmL20/
         Zp5g==
X-Forwarded-Encrypted: i=1; AJvYcCXa6646UX94/EdNsiqzU9NMGGx94zVx/+BZ3pahPZfmMuSJ13pf7/P3uS16FU1nquvrgyQuXow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyOQcfVX25E84KzlwuOgVCPTi2B9VSVqV8YhPC/XZ3QTr3p4HF
	onal8xO9x1OHNsmvD96T1QuaNBZ4bP7thkimwzpbVEGFP6Hwc8Ayu62PRHxCzUfBUes=
X-Gm-Gg: AZuq6aLqRuhtCrWseHWadTYnv8XY5Yi97AUkeWQwMVli5RlK9I55/3y+ocKNBNqXfPG
	O+i7uvkquq4zqncqFT5fLVfjY1VjNoKMLh79XmSE1Zg7mKxmJRcqQrktN5+x8G88VKivh5Yx1VN
	vkwNtWbCIBwDEMG4PgkR5XAC20cexSprpsin503yMepsg/akJhl6F88zO8qBD9jAjK3hg+gCRV4
	Zv1a/CRQq+9fXxR1HoKg8RPOy8MYqtB6eut5Y1w8EYFwcw7X+C7TRdvDK6eycPXc/MEJ8WO36dz
	3ImfSxu6yo6qzPRoDDXz6d6XWGblgs67jBiUZYhaSbJR753NR5mLB2GPWwOtJKJHwyi0eWoEuWC
	BVHu9FjTg36WnjdtXSRN/vWsniphioEFbj3MoRQJyyYmRmi8PUzZk4bvZlYKC11Wm6Hon1siXqz
	M=
X-Received: by 2002:a05:600c:450f:b0:47e:e97e:11aa with SMTP id 5b1f17b1804b1-4834f6c154fmr3313985e9.4.1770672748490;
        Mon, 09 Feb 2026 13:32:28 -0800 (PST)
Received: from localhost ([179.228.217.110])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649f256f97asm11342578d50.22.2026.02.09.13.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Feb 2026 18:32:25 -0300
Message-Id: <DGAR3PO1D33S.1TI7W7U4SPTOG@suse.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH] selftests/net: add test for IPv4-in-IPv6 tunneling
Cc: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
 <kuba@kernel.org>, <morikw2@gmail.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>,
 <syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com>
To: "Linus Heckemann" <git@sphalerite.org>, <edumazet@google.com>
X-Mailer: aerc 0.21.0
References: <20260208144604.1550582-1-git@sphalerite.org>
In-Reply-To: <20260208144604.1550582-1-git@sphalerite.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257989-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ipv6_flowlabel.sh:url,ip6_tunnel.sh:url]
X-Rspamd-Queue-Id: 5AF4A114D3B
X-Rspamd-Action: no action

On Sun Feb 8, 2026 at 11:46 AM -03, Linus Heckemann wrote:
> 81c734dae203757fb3c9eee6f9896386940776bd was fine in and of itself, but
> its backport to 6.12 (and 6.6) broke IPv4-in-IPv6 tunneling, see [1].
> This adds a self-test for basic IPv4-in-IPv6 functionality.
>
> [1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvR=
jcGS31CBw=3Dg@mail.gmail.com/

I used this script to test the regression in a clean v6.12 tree with
commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
__ip6_tnl_rcv()") applied on top:


# ../ip6_tunnel.sh
PING 172.0.0.2 (172.0.0.2) 56(84) bytes of data.

--- 172.0.0.2 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms


dropwatch shows:

1 drops at __ip6_tnl_rcv+74 (0xffffffffc05c7064) [software]


Now, when also applying commit 4b406f814817 ("net: tunnel: make
skb_vlan_inet_prepare() return drop reasons") on top of that, the issue
goes away. Is there a way to trigger stable to pick this up?

> ---
>  tools/testing/selftests/net/Makefile      |  1 +
>  tools/testing/selftests/net/ip6_tunnel.sh | 41 +++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 tools/testing/selftests/net/ip6_tunnel.sh
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 45c4ea381bc36..5037a344ad826 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -43,6 +43,7 @@ TEST_PROGS :=3D \
>  	io_uring_zerocopy_tx.sh \
>  	ioam6.sh \
>  	ip6_gre_headroom.sh \
> +	ip6_tunnel.sh \
>  	ip_defrag.sh \
>  	ip_local_port_range.sh \
>  	ipv6_flowlabel.sh \
> diff --git a/tools/testing/selftests/net/ip6_tunnel.sh b/tools/testing/se=
lftests/net/ip6_tunnel.sh
> new file mode 100644
> index 0000000000000..366f4c06cd6a3
> --- /dev/null
> +++ b/tools/testing/selftests/net/ip6_tunnel.sh
> @@ -0,0 +1,41 @@
> +#!/bin/bash
> +# Test that IPv4-over-IPv6 tunneling works.
> +
> +set -e
> +
> +setup_prepare() {
> +  ip link add transport1 type veth peer name transport2
> +
> +  ip netns add ns1
> +  ip link set transport1 netns ns1
> +  ip netns exec ns1 bash <<EOF
> +  set -e
> +  ip address add 2001:db8::1/64 dev transport1 nodad
> +  ip link set transport1 up
> +  ip link add link transport1 name tunnel1 type ip6tnl mode ipip6 local =
2001:db8::1 remote 2001:db8::2
> +  ip address add 172.0.0.1/32 peer 172.0.0.2/32 dev tunnel1
> +  ip link set tunnel1 up
> +EOF
> +
> +  ip netns add ns2
> +  ip link set transport2 netns ns2
> +  ip netns exec ns2 bash <<EOF
> +  set -e
> +  ip address add 2001:db8::2/64 dev transport2 nodad
> +  ip link set transport2 up
> +  ip link add link transport2 name tunnel2 type ip6tnl mode ipip6 local =
2001:db8::2 remote 2001:db8::1
> +  ip address add 172.0.0.2/32 peer 172.0.0.1/32 dev tunnel2
> +  ip link set tunnel2 up
> +EOF
> +}
> +
> +cleanup() {
> +  ip netns delete ns1
> +  ip netns delete ns2
> +  # in case the namespaces haven't been set up yet
> +  ip link delete transport1
> +}
> +
> +trap cleanup EXIT
> +setup_prepare
> +ip netns exec ns1 ping -W1 -c1 172.0.0.2


