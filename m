Return-Path: <netdev+bounces-279575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIzQI66f5GkmXgEAu9opvQ
	(envelope-from <netdev+bounces-279575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 11:26:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA44237FF
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 11:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EC9E3010521
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B5B37268C;
	Sun, 19 Apr 2026 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GarnT5AS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DFD33689C
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776590760; cv=pass; b=mMBtr1RLnq1GGSXTgpoKAbcgBi2PcDBTHgl/yF8ucqwYhlL9b5Necsd+4bllxcjZFrhf+COLJr1UqnjwTMq57JlW+UdboPW+Gl619xqgWXmoe1Yf7kNzcWQCpa8lVf9xE1Py85nb2YJrPrTQdRiQDC5LNdvNGK29IKZVZjmgTks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776590760; c=relaxed/simple;
	bh=KA2eaj1KTMF7JiURFIArjk9hCqPJILQRp+sBxV8Rwlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5YT2IyYdq7GmRuwMB+NhilG41vUCtMRMEU8DkxL9UeMZnCDJ4ZMtqLMyveJNtH8nyjVm82b56CxtdVLclDfcbESonwZo/sJwwvvv4m+wi9NX4OK4GRghU1gCx6jyulc0YkaJRD1hTepKRJVrQRFv0u9rqnA3Cwnd2QfPRYb4nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GarnT5AS; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d7c12e48eso23462291cf.1
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 02:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776590757; cv=none;
        d=google.com; s=arc-20240605;
        b=f9MY2tVFXYz/Zw8vtH10zd+HGOiBdeeXPEtpq6+6BCZ8Lz2JDKU2S+0N+9i/1I2dPt
         xJgtPxxab27iRPBy5Zmdoop4CW3RKmQv7LX0upgP6UzrVsuYRgOBwcZv28JTydE0qT9W
         IFMFX7CWo0WK0rfpQTgHSJNYBsTfCTozMa9oNMg1qGAWu79txMNDSYIGG4xV3yK/48Yt
         KStY+8HybuoTRBbHqV39b8/u/VOlhQlJ4Zzc7SGix2X4E8BKKYDYvQYkOysCmxpMqlnC
         hmV5J1Bd7mElh81EGou5EtfxEF1ZJzuAz47DP7FLeUelVnKzCwdVw/hD2aMtH2DXF/2H
         JhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ns0EhvXKOFhY1hex9eB+EUZJkcV6nA7fGQgrXRO+R4Y=;
        fh=Nq+TKXw3vmmY1L8vl8vOk05zSjpX9Ti3YoeH5OY7VlE=;
        b=SixoyFQWbnvliG5btK2BiuWRowXHEOahkcihpxAbTXS1ABKhKC1k4MsvvkLC0FM3pz
         O+wq1jL5AbtWXr5FLR0LHHaN56IILr0CuPaUJ7BLkGIkGg/NNY3bErrCCuBhNpRwI5pj
         ze2qjiRYMi/1hOLfAcyx8JaOBz7q8ecScqh/b0v8rTiHGcPbd5b8r3B7Go6f6P433/js
         +eNVB1/sDb0/vXpAjxe9MyT5mlWLN21kbkOZ9tBdagGedtjeMBC+6U75YQFC/YmGClpC
         pxVu3gxr+U6AEEazp+xOMlvIi+I5KnwcT5E2sTtVviTW35YT/iu4u+98bN8stqHM17Pq
         3bwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776590757; x=1777195557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns0EhvXKOFhY1hex9eB+EUZJkcV6nA7fGQgrXRO+R4Y=;
        b=GarnT5ASxGSo8StNSNyxnLnYyfdOEHDntBeO/54wfLCoQw+oRxPmiS6XED9VV/P7wo
         zNcjwh+eYpfAUUJauv4KofHgtpcDcaPgGGNuWq6YdkURmT0Ng6yor/9xedhSYL1c5nVF
         pVDs8+yo6MMQt7DXfPJ+eqH58EtrWXr66fhVFsQVdCfzuI3iqWUIniF/atAvHEk1mfH4
         hmFLsnk8oLbF8OsOPttD5mNEWtqvuRwhUrrSTTqBgg40j4Cp/eBvVRbHHLPcyDEyDxKQ
         dKj1K4wSx0XACPtrMTokDyBadq1nFhJ9l6hCWJNj9UZXEJSVCIwchi68ZVydRbeTcQFI
         5yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776590757; x=1777195557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ns0EhvXKOFhY1hex9eB+EUZJkcV6nA7fGQgrXRO+R4Y=;
        b=lVvtKcyRTMJ2D9UBRuWTFgyce9V+JNFBQ88cl657BbHdFSf/RGmxr1ZE/kVVj7tex3
         E/ay1205u3W03FhRRrCJRYU4+4aBOWT8dE3LSxZiNnBW3eAan6kt7edf9Swz8wz5xMq4
         XtfSfUbdk2woHzugdqVdR/qVQR2L8hZKT0oWo0U+JeoxOOK6yxcfJd17qsj93bNcASZI
         dn9caT7EeS9bHHzq/AEw+Pt7tynaj58L+zvyOOMM1JDGZA6rQbNB0FWaYr8Q6PS3WP5d
         PwEuBnHHK15D/HHq5fsMR8iEd45XvspZ/Ryx0taP/xezQvTrLRLx0etderY77B1dFYKI
         IPnQ==
X-Gm-Message-State: AOJu0YzboPxJZjicBXzkWS9m8CHR93qGggOeaZE0TXY7JUUE3Yhgmbll
	cx3JqkZoeFqtZ7SddJtLKMMtG3qdhQ/fJzv/6Lzk31Ch4xKnu1ED9P2Xio5XuqA/zY3T3xYvluT
	yRVjpoqjinjzrlZ7gYtfJWjbR260dIna6vRRJoeqB
X-Gm-Gg: AeBDiesupcR/6XlWp6RBS9e82xLomYjafc2qz8eYzinBXIfHVruYaf/7mBGSiEor+hS
	ZGMqqt3hzrr4y91r5gurVV9A/Vkp+G8irYUFO1J1sk0M/OXXdslqXJsEl1vwB5FDu/E27+xdcKv
	A33cyLYdctIRFXPMPN9lmOpO1p0baNa+7cf3Pvpgqfn+1bmJWAYPxkYpiMnrUjSwoVvPVDS1n7I
	ly5b/x6A1kJh9RREI9n687ex3bqH6u2dCBRvqxr69AlTPtfc7GFLFGCZZmS2Spxr8ZS0h+6Xxkn
	vRm5qAUa9fCOnNQxeZGdDOpcSRsFSDjbfTs32CjDIVe5o+FLt2g5q11uoLZB+eiDP/FNpQzc35C
	wcPf1pY0=
X-Received: by 2002:a05:622a:6846:20b0:509:20aa:49ea with SMTP id
 d75a77b69052e-50e42635c9cmr53038471cf.18.1776590756870; Sun, 19 Apr 2026
 02:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419090817.127334-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260419090817.127334-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 19 Apr 2026 02:25:45 -0700
X-Gm-Features: AQROBzBbVkrtAdeym8XHtzeCjrZpomGYTVx6hfQK67CeyjEtIH-hi3w7tEP_Rx8
Message-ID: <CANn89iKJFCw9gPdQN4hYZ94j-0Ua84N+DyYjPjwBTRLveK-j7g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: iptunnel: fix stale transport header after
 GRE/TEB decap
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, 
	syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Pravin B Shelar <pshelar@nicira.com>, Tom Herbert <tom@herbertland.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279575-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,83181a31faf9455499c5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DFCA44237FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 2:08=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> syzbot reported a BUG.
>
> I found that after GRE decapsulation in gretap/ip6gretap paths, the
> transport_header becomes stale with a negative offset. The sequence is:
>
> 1. Before decap, transport_header points to the outer L4 (GRE) header.
> 2. __iptunnel_pull_header() calls skb_pull_rcsum() to advance skb->data
>    past the GRE header, but does not update transport_header.
> 3. For TEB (gretap/ip6gretap), eth_type_trans() in ip_tunnel_rcv() /
>    __ip6_tnl_rcv() further pulls ETH_HLEN (14 bytes) from skb->data.
>
> After these two pulls, skb->data has moved forward while transport_header
> still points to the old (now behind skb->data) position, resulting in a
> negative skb_transport_offset(): typically -4 after GRE pull alone, or
> -18 after GRE + inner Ethernet pull.
>
> In the normal case where the inner frame is a recognizable protocol
> (e.g., IPv4/TCP), the transport_header is subsequently overwritten by
> ip_rcv_core() (or inet_gro_receive() on the GRO path) via
> skb_set_transport_header(), and the stale value never reaches downstream
> consumers. However, if the inner frame cannot be parsed (e.g.,
> eth_type_trans() classifies it as ETH_P_802_2 due to a zero/invalid
> inner Ethernet header), neither rescue runs, and the stale offset
> persists into __netif_receive_skb_core().
>
> When this stale offset is combined with contradictory GSO metadata (e.g.,
> SKB_GSO_TCPV4 injected via virtio_net_hdr from a tun device),
> qdisc_pkt_len_segs_init() trusts the negative offset: the unsigned
> wraparound makes pskb_may_pull() effectively a no-op, and __tcp_hdrlen()
> then reads from an invalid memory location, causing a use-after-free.
>
> The UAF only triggers on the GSO path, where qdisc_pkt_len_segs_init()
> dereferences the transport header to compute per-segment length. Fix
> this by introducing iptunnel_rebuild_transport_header(), which is a
> no-op for non-GSO packets and otherwise re-probes the transport header
> via the flow dissector. If re-probing fails, the contradictory GSO
> metadata is cleared via skb_gso_reset() so downstream consumers cannot
> trust stale offsets. Restricting the rebuild to GSO packets keeps the
> flow-dissector cost off the common rx fast path.
>
> reproducer: https://gist.github.com/mrpre/5ba943fd86367af748b70de99263da4=
b
>
> Link: https://syzkaller.appspot.com/bug?extid=3D83181a31faf9455499c5
> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> Fixes: 0d3c703a9d17 ("ipv6: Cleanup IPv6 tunnel receive path")
> Reported-by: syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69de2bee.a00a0220.475f0.0041.GAE@goog=
le.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>
> As a follow-up for production reliability, I am wondering whether we
> can extend the existing safety net in __netif_receive_skb_core() to
> also handle set-but-negative transport_header:
>
>         if (!skb_transport_header_was_set(skb) ||
>             skb_transport_offset(skb) < 0)
>                 skb_reset_transport_header(skb);
> ---
>  include/net/ip_tunnels.h | 12 ++++++++++++
>  net/ipv4/ip_tunnel.c     |  2 ++
>  net/ipv6/ip6_tunnel.c    |  2 ++
>  3 files changed, 16 insertions(+)
>
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index d708b66e55cd..9b4e662833a1 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -662,6 +662,18 @@ static inline int iptunnel_pull_offloads(struct sk_b=
uff *skb)
>         return 0;
>  }
>
> +static inline void iptunnel_rebuild_transport_header(struct sk_buff *skb=
)
> +{
> +       if (!skb_is_gso(skb))
> +               return;
> +
> +       skb->transport_header =3D (typeof(skb->transport_header))~0U;
> +       skb_probe_transport_header(skb);
> +
> +       if (!skb_transport_header_was_set(skb))
> +               skb_gso_reset(skb);

I do not think this makes sense.
What is a valid case for this packet being processed further?
The buggy packet must be dropped, instead of being mangled like this.

