Return-Path: <netdev+bounces-43791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0427D4CF4
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2151C20A65
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4DB24A0B;
	Tue, 24 Oct 2023 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBgX1dZM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C608CA4D
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:53:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA7F83
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698141200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jizRy+xlJgPxXiuvzP+nWemFyZJBR8bfBxFXl2FMKE=;
	b=YBgX1dZMOAWLeHlDWGtwo+4jlhV1opOaWWXYYQ7DPXlvHxXQWtpz53LEphQgnyDSsnx6w7
	ZvBN8mdUp5YOJA2xB41bG8bVGvKyRkSlNXocyo7tqpbwIRmVpODJD1c+wzrMuGWOQEAOzR
	l3sIKhPWvkyiXnoMBHpxHQDFzybCLN0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-aS4Crp3WMk-tuVQQltpLXQ-1; Tue, 24 Oct 2023 05:53:03 -0400
X-MC-Unique: aS4Crp3WMk-tuVQQltpLXQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51e3bb0aeedso656934a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141182; x=1698745982;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jizRy+xlJgPxXiuvzP+nWemFyZJBR8bfBxFXl2FMKE=;
        b=gW+ID3z2myRoMbPmtr6pbKEALq/BkjIdm0hY3I6la1//RpvqBJ40zWIL2CeqIy0fky
         E6QLGz7QmsDbOQ5+eqjqqRpVGXIcFVx0QL6zwWduupg9r5gEAxUtMx6B1VqD6ChVFGnw
         tlM6eXX9M/NDB5o37X9donIDY9ADgz935IF7ODqxMDMvMvTg0LXE79NUrKF0mZTNAO22
         XzkgcoCJ8vP783RElybZEuLDJCiGIRZcbFbDIpBOjnfQF73V/0lo0qQVWhZ9vxULG4ny
         /3FipAQlOslTDNvIR60BBe8N0QA2KbCpBVZsSnTr414tPCbyddpxlA08iDfAzc9lYnSX
         Gttg==
X-Gm-Message-State: AOJu0YyHH5whKZENPsySR9eZitN+n+c9355xc9HKTWwbg1vZ22RiYq/M
	UF4Oirf32pkLAkzrjTp3413JFTc0Dchb2bYMXlqtV6wHFem1QhaYs3wq6thOlPWSoxsIp/EjGTh
	gER4dU4Uq1Ke3DxEz
X-Received: by 2002:a17:906:2250:b0:9bd:cab6:a34b with SMTP id 16-20020a170906225000b009bdcab6a34bmr9534739ejr.0.1698141182591;
        Tue, 24 Oct 2023 02:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4N9+MtDIWyMIQGkPhANF5QiOjICssLop36bG69lHI8+/Jq9U6BipBQhs8vRhOV7PMbZJc5g==
X-Received: by 2002:a17:906:2250:b0:9bd:cab6:a34b with SMTP id 16-20020a170906225000b009bdcab6a34bmr9534732ejr.0.1698141182237;
        Tue, 24 Oct 2023 02:53:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-191.dyn.eolo.it. [146.241.243.191])
        by smtp.gmail.com with ESMTPSA id bu12-20020a170906a14c00b009c758b6cdefsm8054168ejb.128.2023.10.24.02.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:53:01 -0700 (PDT)
Message-ID: <ed2ce6dfbe6261219cb61f4be3e1db04cc0c335e.camel@redhat.com>
Subject: Re: [PATCH net-next v6] vxlan: add support for flowlabel inherit
From: Paolo Abeni <pabeni@redhat.com>
To: Alce Lafranque <alce@lafranque.net>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,  Ido Schimmel
 <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: Vincent Bernat <vincent@bernat.ch>
Date: Tue, 24 Oct 2023 11:53:00 +0200
In-Reply-To: <20231022191444.220695-1-alce@lafranque.net>
References: <20231022191444.220695-1-alce@lafranque.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-10-22 at 14:14 -0500, Alce Lafranque wrote:
> By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with
> an option for a fixed value. This commits add the ability to inherit the
> flow label from the inner packet, like for other tunnel implementations.
> This enables devices using only L3 headers for ECMP to correctly balance
> VXLAN-encapsulated IPv6 packets.
>=20
> ```
> $ ./ip/ip link add dummy1 type dummy
> $ ./ip/ip addr add 2001:db8::2/64 dev dummy1
> $ ./ip/ip link set up dev dummy1
> $ ./ip/ip link add vxlan1 type vxlan id 100 flowlabel inherit remote 2001=
:db8::1 local 2001:db8::2
> $ ./ip/ip link set up dev vxlan1
> $ ./ip/ip addr add 2001:db8:1::2/64 dev vxlan1
> $ ./ip/ip link set arp off dev vxlan1
> $ ping -q 2001:db8:1::1 &
> $ tshark -d udp.port=3D=3D8472,vxlan -Vpni dummy1 -c1
> [...]
> Internet Protocol Version 6, Src: 2001:db8::2, Dst: 2001:db8::1
>     0110 .... =3D Version: 6
>     .... 0000 0000 .... .... .... .... .... =3D Traffic Class: 0x00 (DSCP=
: CS0, ECN: Not-ECT)
>         .... 0000 00.. .... .... .... .... .... =3D Differentiated Servic=
es Codepoint: Default (0)
>         .... .... ..00 .... .... .... .... .... =3D Explicit Congestion N=
otification: Not ECN-Capable Transport (0)
>     .... 1011 0001 1010 1111 1011 =3D Flow Label: 0xb1afb
> [...]
> Virtual eXtensible Local Area Network
>     Flags: 0x0800, VXLAN Network ID (VNI)
>     Group Policy ID: 0
>     VXLAN Network Identifier (VNI): 100
> [...]
> Internet Protocol Version 6, Src: 2001:db8:1::2, Dst: 2001:db8:1::1
>     0110 .... =3D Version: 6
>     .... 0000 0000 .... .... .... .... .... =3D Traffic Class: 0x00 (DSCP=
: CS0, ECN: Not-ECT)
>         .... 0000 00.. .... .... .... .... .... =3D Differentiated Servic=
es Codepoint: Default (0)
>         .... .... ..00 .... .... .... .... .... =3D Explicit Congestion N=
otification: Not ECN-Capable Transport (0)
>     .... 1011 0001 1010 1111 1011 =3D Flow Label: 0xb1afb
> ```
>=20
> Signed-off-by: Alce Lafranque <alce@lafranque.net>
> Co-developed-by: Vincent Bernat <vincent@bernat.ch>
> Signed-off-by: Vincent Bernat <vincent@bernat.ch>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>=20
> ---
> v6:
>   - Rebase patch
> v5: https://lore.kernel.org/netdev/20231019180417.210523-1-alce@lafranque=
.net/
>   - Rollback policy label to fixed by default
> v4: https://lore.kernel.org/all/20231014132102.54051-1-alce@lafranque.net=
/
>   - Fix tabs
> v3: https://lore.kernel.org/all/20231014131320.51810-1-alce@lafranque.net=
/
>   - Adopt policy label inherit by default
>   - Set policy to label fixed when flowlabel is set
>   - Rename IFLA_VXLAN_LABEL_BEHAVIOR to IFLA_VXLAN_LABEL_POLICY
> v2: https://lore.kernel.org/all/20231007142624.739192-1-alce@lafranque.ne=
t/
>   - Use an enum instead of flag to define label behavior
> v1: https://lore.kernel.org/all/4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@ma=
il.lac-coloc.fr/
> ---
>  drivers/net/vxlan/vxlan_core.c | 23 ++++++++++++++++++++++-
>  include/net/ip_tunnels.h       | 11 +++++++++++
>  include/net/vxlan.h            | 33 +++++++++++++++++----------------
>  include/uapi/linux/if_link.h   |  8 ++++++++
>  4 files changed, 58 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_cor=
e.c
> index 6f7d45e3cfa2..341fd5eee9e1 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2443,7 +2443,17 @@ void vxlan_xmit_one(struct sk_buff *skb, struct ne=
t_device *dev,
>  			udp_sum =3D !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
>  #if IS_ENABLED(CONFIG_IPV6)
>  		local_ip =3D vxlan->cfg.saddr;
> -		label =3D vxlan->cfg.label;
> +		switch (vxlan->cfg.label_policy) {
> +		case VXLAN_LABEL_FIXED:
> +			label =3D vxlan->cfg.label;
> +			break;
> +		case VXLAN_LABEL_INHERIT:
> +			label =3D ip_tunnel_get_flowlabel(old_iph, skb);
> +			break;
> +		default:
> +			DEBUG_NET_WARN_ON_ONCE(1);
> +			goto drop;
> +		}
>  #endif
>  	} else {
>  		if (!info) {

I'm sorry, this does not apply cleanly to net-next as this chunk
conflicts with commit 2aceb896ee18 ("vxlan: use generic function for
tunnel IPv6 route lookup"), please rebase and re-post, thanks!

Paolo


