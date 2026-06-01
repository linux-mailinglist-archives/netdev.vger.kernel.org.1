Return-Path: <netdev+bounces-293849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKY6D9y8HWo/dQkAu9opvQ
	(envelope-from <netdev+bounces-293849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:09:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE7C6230ED
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AEFA30376B9
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68623DC4A2;
	Mon,  1 Jun 2026 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="c8zku+oa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA23DB65A
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333439; cv=none; b=oVW35SUGHQZvDrOsfBagrO7jQLWifL+EjzxjtGe3v4fg4zSfnsQu6H+NE/w5pzhSPGZoP7UvXDz4p5O97gaTwVLMjSODIatL2jw3tSU8HNnl9F2kGPiE5TkOCKupWKr0gHYFnpN0IYbqveedvmK19S/1w51q+6XXsW7HjSD5aUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333439; c=relaxed/simple;
	bh=CJv+ORdfM4d1gC+/h8eXW8d3TcRUhKDuN3NsrTLwwrY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sB8P7+WDQ7LM+Jrvovp0e5fYjzZHT15+fPwshJaPAw/JwIP5Qjgkn1n6ddUr8ONjgBf3gkg2YSU6cZK7WkoaIvsaVEoBcY8VFX/TFO7bY8QFa7eVrcGNXXnb4PDu7objscTXP2rbRomVmXFqb8gbY1I+IHZt7ayLIuL8wBTBdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=c8zku+oa; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304545f5206so14332363eec.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780333437; x=1780938237; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDxjxajjjz+WXaa2HC01+77k69ejzz46zXU7TmxK8gU=;
        b=c8zku+oaTIE4+vxpg+7KrmNNGHSop9C2WtVqZ0oNF05BPNaGvHUFnuI+zI6GzXfbwe
         ikqnmpozZwPsBcNwcOMRiaiGeY+Uz/Ei7hVEf1GFRfspgu+JnJWGtvWUvwLzNNBxzmZV
         C1Jl8n4oCCOf4D+8PkSlfit9DAhknGJU5mkSt4wST1Uakbpbh62lZ2mY8EVCgOVf/t5W
         EapBjL4E3k85qK76XW5vZn4P8pBMK9m0p4UwoguxdeybgyWnuMfD1ct2hIW/KA5rvMyi
         hmaw0U5n2Kc6SHQH+69W/JX9K1Ty6GamRqnYNR0jHm5TDEfoaU6EGInEEh1t5+Mzagtp
         +f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333437; x=1780938237;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDxjxajjjz+WXaa2HC01+77k69ejzz46zXU7TmxK8gU=;
        b=sar/2JckOKWg+qZNlYlVI8f4LSGJyNiunC6P9YzUWJlJSsS4LZAgxoTxqthgunaDjD
         2L1yBcrNHYPBzk2pSf1ukba4kH3J5fGcrxGFt/ZUNawiBcijaqfbZu+uc8SWkb/LXb/O
         UxqkWtsqxsCVjuQFOGwCYLUPY6ya+WPjO33Bvwub3X3sW9KeXJMn73VOU234xJPcly/8
         RiJvvw2z6BpcrxNxYpTCEVz6ChRuk1XWEMyfh9f/rZtn6/DLqJ7c4UzrEPx2NzPZyMVp
         MXrk+mMc3y5SPGCTBYEdYK9xpyaakizMSaxSDm3TOPm+x9OIS6tm9eqlG3uv91VDudTS
         7bXA==
X-Forwarded-Encrypted: i=1; AFNElJ9PCLFx/o4inXdC/84+tsCl4Of7SbX1q76lty0278V3nyZkgddhPswD0ILm7ItFxF/IBAAY7vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV6793YZ7F+DE2HLImsHNVnK5gI7War+C+ImMLa2cKKSKdUAQt
	sH2yEPrN+vXgngD/hgm81ScPlzdgZP3+MiJU1U47ubQrIa0dKpEj3FGZsewq+vDkQLc=
X-Gm-Gg: Acq92OE35bVxxAXm7JutphSF/pJxKZvdkyhli+gcE5T+Dmu0oZhCWLPjU03LnJfJTq8
	W3qiwk3EsSO2DX+VxcN3bPrtBqQgHXGO/Q5qKq3Ewyi969G73JivFfxUa8/4IubWMt9Rv6XYui2
	fvi58qQ7CPumBnkySTIupNtMyv+gnIPIk+NCR25cXkULzqtb2RkUH+szgoHjRugNq7rtwKE9w5L
	SJSjvJHdsCWH9aqXuo/4EIz0y6AlD5CaHvdgQI9nHBPgJrOJuTUxcHgqK2tDG0qnNUijyi5E/St
	DMqMoiwZD+AzNejEggLWGzuLI5SHaHU7xXJvlMWvkJ6/z90VGF0xvC/Fnjg+Alz0+LRu3cf+Ath
	UMGeuLIh6e1HC2/d8hArLOLNpjqoJx6xa7qNlK/Hq9H8THGZWDJSyZRQU4Dmc4MBCZxcpF7TJBe
	wHPm7L2miXbpDmLks=
X-Received: by 2002:a05:7301:1f0d:b0:2ed:e14:42e9 with SMTP id 5a478bee46e88-304fa693628mr6131496eec.34.1780333437177;
        Mon, 01 Jun 2026 10:03:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::a996])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a0b7dsm9613132eec.22.2026.06.01.10.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 10:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 13:03:52 -0400
Message-Id: <DIXVJ45H90X3.3DOQOUXJB6DVN@etsalapatis.com>
Cc: "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Guillaume Nault" <gnault@redhat.com>, "Ido Schimmel"
 <idosch@nvidia.com>, "Fernando Fernandez Mancera" <fmancera@suse.de>,
 "Peter Oskolkov" <posk@google.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>, "Leon Hwang" <leon.huangfu@shopee.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601150203.20352-1-leon.hwang@linux.dev>
 <20260601150203.20352-2-leon.hwang@linux.dev>
In-Reply-To: <20260601150203.20352-2-leon.hwang@linux.dev>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com,shopee.com];
	TAGGED_FROM(0.00)[bounces-293849-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[etsalapatis.com];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8CE7C6230ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Jun 1, 2026 at 11:02 AM EDT, Leon Hwang wrote:
> Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
> When a driver, e.g. ice, reuses the stale skb->transport_header to
> offload checksum computation to NIC hardware, VxLAN packets encapsulated
> by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.
>
> Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
> encapsulated packet uses UDP, so checksum offload works correctly.
>
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_pus=
h_encap")
> Cc: Leon Hwang <leon.huangfu@shopee.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  net/core/lwt_bpf.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d..65d1dfbf3312 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool=
 ipv4, int encap_len)
> =20
>  int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool =
ingress)
>  {
> +	bool is_udp_tunnel;
>  	struct iphdr *iph;
>  	bool ipv4;
>  	int err;
> @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void=
 *hdr, u32 len, bool ingress)
>  		ipv4 =3D true;
>  		if (unlikely(len < iph->ihl * 4))
>  			return -EINVAL;
> +		is_udp_tunnel =3D iph->protocol =3D=3D IPPROTO_UDP;
> +		if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof(struct udphd=
r)))
> +			return -EINVAL;
>  	} else if (iph->version =3D=3D 6) {
>  		ipv4 =3D false;
>  		if (unlikely(len < sizeof(struct ipv6hdr)))
>  			return -EINVAL;
> +		is_udp_tunnel =3D ((struct ipv6hdr *)iph)->nexthdr =3D=3D NEXTHDR_UDP;
> +		if (unlikely(is_udp_tunnel && len < sizeof(struct ipv6hdr) + sizeof(st=
ruct udphdr)))
> +			return -EINVAL;
>  	} else {
>  		return -EINVAL;
>  	}
> @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  	if (ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
> +	if (ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);
> +	else if (!ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + sizeof(struct =
ipv6hdr));

Minor nit: Could we do something like

if (is_udp_tunnel) {
	size_t hrdsz =3D ipv4 ? iph->ihl * 4 : sizeof(struct ipv6hdr);
	skb_set_transport_header(skb9, skb_network_offset(skb)) + hdrsz;
}

to make the logic clearer?

>  	memcpy(skb_network_header(skb), hdr, len);
>  	bpf_compute_data_pointers(skb);
>  	skb_clear_hash(skb);


