Return-Path: <netdev+bounces-92416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B3E8B6FB7
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 12:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC471C20E36
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A3C12B176;
	Tue, 30 Apr 2024 10:32:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857DC27442
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473125; cv=none; b=tIGWqJcvjzCIWASi13D5y4tZkYgEfznzo6JqVzGATjjMtku65a/5UTOfibji/D/HrEU/FoQ1w+YWSLBjcGWBKC6u0q97mP1iqvLn+2Lw6B7xWBzhwFMR2UBp+SHBIyvGKkRthpk6jQPetuPSRc834UH9zmuu8C1Y4AxJv0u7hNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473125; c=relaxed/simple;
	bh=5TRLQDv1fpVbGYlMV1LAqay1ymacRWAKNcukGSpcfUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nt1QKq2o/D4ahHipHEbn9+n5U42QYNCh2eBOGVmFzXYZLD8A4kb0b/rOJcBuBUxTJchosk402t0e7O2Gm+cgh06cmYaXcTkxgCO1G/P6BjbsuVZ3S/xL0snbZEqh+zwn2Vs0rDdmLGFr7GvJvuTfHfyo6QEdyUszgbKF9EfnPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-HCexMwtlPYygLWg2MVn3tQ-1; Tue,
 30 Apr 2024 06:31:54 -0400
X-MC-Unique: HCexMwtlPYygLWg2MVn3tQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B80F38035A0;
	Tue, 30 Apr 2024 10:31:53 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 409A21C060D0;
	Tue, 30 Apr 2024 10:31:52 +0000 (UTC)
Date: Tue, 30 Apr 2024 12:31:51 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] inet: introduce dst_rtable() helper
Message-ID: <ZjDIl3F2amAKLX02@hog>
References: <20240429133009.1227754-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240429133009.1227754-1-edumazet@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-29, 13:30:09 +0000, Eric Dumazet wrote:
> I added dst_rt6_info() in commit
> e8dfd42c17fa ("ipv6: introduce dst_rt6_info() helper")
>=20
> This patch does a similar change for IPv4.
>=20
> Instead of (struct rtable *)dst casts, we can use :
>=20
>  #define dst_rtable(_ptr) \
>              container_of_const(_ptr, struct rtable, dst)
>=20
> Patch is smaller than IPv6 one, because IPv4 has skb_rtable() helper.
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/infiniband/core/addr.c   | 12 +++---------
>  drivers/net/vrf.c                |  2 +-
>  drivers/s390/net/qeth_core.h     |  5 ++---
>  include/linux/skbuff.h           |  9 ---------
>  include/net/ip.h                 |  4 ++--
>  include/net/route.h              | 11 +++++++++++
>  net/atm/clip.c                   |  2 +-
>  net/core/dst_cache.c             |  2 +-
>  net/core/filter.c                |  3 +--
>  net/ipv4/af_inet.c               |  2 +-
>  net/ipv4/icmp.c                  | 26 ++++++++++++++------------
>  net/ipv4/ip_input.c              |  2 +-
>  net/ipv4/ip_output.c             |  8 ++++----
>  net/ipv4/route.c                 | 24 +++++++++++-------------
>  net/ipv4/udp.c                   |  2 +-
>  net/ipv4/xfrm4_policy.c          |  2 +-
>  net/l2tp/l2tp_ip.c               |  2 +-
>  net/mpls/mpls_iptunnel.c         |  2 +-
>  net/netfilter/ipvs/ip_vs_xmit.c  |  2 +-
>  net/netfilter/nf_flow_table_ip.c |  4 ++--
>  net/netfilter/nft_rt.c           |  2 +-
>  net/sctp/protocol.c              |  4 ++--
>  net/tipc/udp_media.c             |  2 +-
>  23 files changed, 64 insertions(+), 70 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


