Return-Path: <netdev+bounces-258087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDt/NlAzi2mLRgAAu9opvQ
	(envelope-from <netdev+bounces-258087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:32:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EAC11B39C
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E30A303E3A8
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357EE3164B7;
	Tue, 10 Feb 2026 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OfCb+HVo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D23016EE
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730318; cv=none; b=TNR3iT+kjTmkydwF6UUCcdbYUqqqYrhAb6a+jY7HPxY2PKY3uhbXlra8pflwbKjbJfUJ3mzAziuRrAzvef0GHmz9OgaSVxGVIclYMRZ1O6CCjAe4IT1b9DQiD8+87Phr0un4uGlBLfqO89/paVw2osPpiDiYxa/i0vlnvHjh1ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730318; c=relaxed/simple;
	bh=VZSjOzuvfMemL7dihLKw/YlnYrWtdPgaW38AFNLk1NU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tjznogHabuMZ/7DGzHxrYRGaqOKOLWo+W+jV7bxQ8Be43TsR2mXGrvBvyQ/trr5RVJ5C/bQa9B08zldLmflMXK2QfR/gj2h5XEnVYB5NDrGx0A4ZfRZN/IsIt+NdYTUliNC/7lurbD/p+96RZ7bnh/BbMRix+BXkJIupbHh3elQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OfCb+HVo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-480706554beso43776625e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 05:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770730315; x=1771335115; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uus/PtqPraf4MCXBLh2n0ofoHxf+Az8PQo4c5Pr7pDw=;
        b=OfCb+HVo9iSOGLpoPkZ6wQCyY2z5h9gUHdHvKl6ezBEEXkUw4qAGux8NRq6p5/owr2
         xLiAWp+zHKjzDsuR8fsTn74SNoSWvcnMQXUEBG/OeMdCMh0b14KqF/5Tf2KWphVDWSsu
         dB7xzMo5QW3OyN04UBty8DobgQXNekvxFeptqIinBBXJjo3f6Y27tKAmfTqMP8eXeN/5
         /4BIKMEhtEbVH52sK5u4PcveV9bK4qlfQ6UbZp5+dlBXUO3a6nPvqvhNeP6WXLcoR88F
         NDOwFxwcmCqpkZxTE2y0MwyH+L/anbpShS856Y6iCuiRUUpj4758XFaHBEGbnQeqL+0k
         slsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770730315; x=1771335115;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uus/PtqPraf4MCXBLh2n0ofoHxf+Az8PQo4c5Pr7pDw=;
        b=whJUj+gcvvNdzT3oq653PK3WoyCDbkNy/l4+tf7FNsGGqTf+9hMaFQksJ1pfl+Bedw
         SRT33xiC9ApC7ttRK3y0p5JMnwL/WCECEs14lcjCPGNDFmfhIsFcc2QozuXL4O+w48fZ
         1G93I3n94F/tjzm/iq8SXSrmC+r2Pq/PNGY8KZXwtvcCNGtSjq0g6tdINZtcuFAekoBv
         aKI3tMWIZJzUT/9Dwt+JPWSS5+7oH/ExoYOxEyzqS9Xs5aeav7co5JHjaPPhIAnEDGYz
         n9EaeF7+9NgVuznAiJOjemiQaUTlxOx4MudUdGgIo0/XxuhmhNTbuHnsbxuPx3azrXRt
         Rxwg==
X-Forwarded-Encrypted: i=1; AJvYcCVIUpqhgt4itRa7EN3XaLthVqBt9mN/x2koJuo3wx+PKxkGFQju+uSUEon1E+6mxKXvksIp0CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0nDaUd9B24VaBcYtfQNYRAL74nQnuSZq9CmY+bn+d9hs4PFm
	MZi3QW20JZ3kGsvoNWFQIolLl/Tpf9rAc/6dt8yOhmWxQpUzoNFIn2+Vo7qfTkxdKW6fSP4/uL9
	alB5j
X-Gm-Gg: AZuq6aIlfqYviRRy/VfMbKW9PfXp/bV0nL0Kp2DZwwdjP6e4v4Etwwp3axyfpiXf0+/
	knhGgf1fk9vs89wpfrDVyQ1WAiCJpAFQTYOJwV7vO2x7vkOWorX7fgjoYXqLMd0OXpA+pgzsPQo
	n+DC3wsJ0na13xMNttTvwlZWkkmrLIpXl7Rb2+i0Hz1587mTLlXxU6f4cu74dYnGpuYbBIxokxk
	qQGj+RMXeKJ3y1a75zBfvOss+VarpYy+Z8Za9mYudSN+/WM5oI+u+xSQ6ey6kHO6fJX+2G7tYvg
	Hm2VOC3D2g6JGO902qJKyuFY7hYD/SvMiFtBTOPabiW4xSjrdEgxyjPLNAQrjdU+4ogaygQqFmW
	jzskY39+r/PExm0tz5MEaFP+MNYC8RNmL1GASsvL6u41Dd9KywuzSDZ46Zl9M2UPrL8aCBMtXSB
	8FxI3bdKpQ9EZHqu27xcSoIw==
X-Received: by 2002:a05:600c:5489:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-4832022918dmr194685595e9.32.1770730314695;
        Tue, 10 Feb 2026 05:31:54 -0800 (PST)
Received: from localhost ([179.228.217.110])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796211d1b81sm105684947b3.16.2026.02.10.05.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 05:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 10:31:52 -0300
Message-Id: <DGBBIBJC7SH5.1EDF61ASA9WSU@suse.com>
Subject: Re: [PATCH] selftests/net: add test for IPv4-in-IPv6 tunneling
Cc: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
 <kuba@kernel.org>, <morikw2@gmail.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>,
 <syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com>
To: "Linus Heckemann" <git@sphalerite.org>, <edumazet@google.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0
References: <20260208144604.1550582-1-git@sphalerite.org>
In-Reply-To: <20260208144604.1550582-1-git@sphalerite.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258087-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email,ip6_tunnel.sh:url,ioam6.sh:url,ip_defrag.sh:url]
X-Rspamd-Queue-Id: 54EAC11B39C
X-Rspamd-Action: no action

On Sun Feb 8, 2026 at 11:46 AM -03, Linus Heckemann wrote:
> 81c734dae203757fb3c9eee6f9896386940776bd was fine in and of itself, but
> its backport to 6.12 (and 6.6) broke IPv4-in-IPv6 tunneling, see [1].
> This adds a self-test for basic IPv4-in-IPv6 functionality.
>
> [1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvR=
jcGS31CBw=3Dg@mail.gmail.com/
> ---
>  tools/testing/selftests/net/Makefile      |  1 +
>  tools/testing/selftests/net/ip6_tunnel.sh | 41 +++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 tools/testing/selftests/net/ip6_tunnel.sh

FWIW,

Tested-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>

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


