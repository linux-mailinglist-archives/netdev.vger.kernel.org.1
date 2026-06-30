Return-Path: <netdev+bounces-303315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZlP3HKYARGqpnAoAu9opvQ
	(envelope-from <netdev+bounces-303315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:45:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA476E7039
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:45:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=QrLyV+od;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303315-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303315-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D53F300B510
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1993DE422;
	Tue, 30 Jun 2026 17:44:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA93DDDC4
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 17:44:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841443; cv=pass; b=JgtSZxAjx9DO02x4yRpKnJUds1jJZUvkdLe+qbDVWkOcBLqDpk4cmVjAamVKb0e5hfAZ1XVNd8HAq+/B+Fta90zSuoes1swl8to/+uVzbuQQuaBKf8oJAoHQpFCwH3WRimr9AIPRgU8IPIID0UeixYdTKvSq797GOKk1M4uNPzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841443; c=relaxed/simple;
	bh=JawNW4Pqc50AtoDA7MmXMZBmvwYBX2KlZo2Gx2Uk9xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3PR82ZmU1oDrI7Zxt7p/jMIoYjlyTh3+MQxyLzEbTUQjzS3oXcyPQgltGOcls95DhkTZkMNBeZK52Fqmi2h24yhN2g+Vah5zfJzd++aPr85HhoYcJJWEqkGGrE1OwLG41a8nvxLulbanlcHmTlvzLhwoxGlvdYuNeM1jeV8uPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=QrLyV+od; arc=pass smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c74383c93cso44160665ad.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782841441; cv=none;
        d=google.com; s=arc-20260327;
        b=RU/kuk80E7up+NVBpUTvhH2JDoRVkAhO/shGelR0o5yYOEynK4wuAJb3JAThgChmFY
         PeIX5UQAdIa1tzqvh8XTm6VHsFvEvCAe9lZpVCg3UbcResSatgx0UnAlm81fzKmRgzEz
         kNW5coszyTbyfsiG6DOZzqjC4D5aiXsgz4OIgTgPbgt+uOhrFkthsDvVkx7YYZ8VBKEe
         calL26AyZ10zI626XnJse1XsaZ/aZvwdqIJxkZcqDAXL8lQIcavlgpdHMj8bHvvft5H3
         qf09oOD5cvEvVhdgxZ6EZPLRHLCDN3ljDuqsdxxI+q/6kkn0iGrXJfhwhNktKSsBuYY3
         pCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=URUGPjnqsQCliGYebP4MIXMTsTKoR6R+RTcTkNmd7wk=;
        fh=tmNaBeXQ49tCQYYWZLiMksWdbnbN87gvs+kgI40JWAI=;
        b=KQZ6pmNTIxQ3BY8gdnf6DD2cX9BXEW+VjY0DPogTzpTSnuhOUsIOxgcQe+xRir9bii
         cxWeI81TGO0reO7jI4vDLQK0+2JwgwvpIs5o/ELGd4GQ3NdxCOWvF0LPvg/wAAnImFLB
         QJgRtqBf7pOADstTgMgZVx6G7CqpCqDsp0amUkXPKENQyTJ6n3A1Pv4SwC4ZCYrdyNJg
         tGvGYLX6ATzVNvKOt4lyjbT5oSmqLcinHWXPVmNN8IXei3AkfL4fMp/hmG96FLnFb9lV
         NDicQIJAzhLbilCqkUg9vfWEAGU+bbn9ZgUGz/Wtvloz++eO0ZrGL65atzdRoZ/gHT4z
         dwoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782841441; x=1783446241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URUGPjnqsQCliGYebP4MIXMTsTKoR6R+RTcTkNmd7wk=;
        b=QrLyV+od9PlDgQBC4XE+Tk/sLHlkBAN5jFl+EfTrIgCPHGAre17AhRsIXkj2ojbLr7
         /+F8BS+ut/EDq6eErORXIw+ZxC2vHqzL5cgfgOe5Pxm7PO52JfPe308prVUHjJfSW1Fk
         eJWT3M/eapqUVDX7RzQOvQAVsFDv1bgeiYIQKao4iP1pvjM7BFfmCT43rkI+as5xP35t
         0ozk8zZIrhfYetDtrqpvXAUFDZM85tRvbsVNHMY8/jH8CVusuR5e8bJm5gHDJANJLcOB
         tz/Gy9gehN3zzOokbNewNsEzelYrhE59eTCIUSWiZXD7T/CTrpDB3yFgQXISB/iGP6qF
         d/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782841441; x=1783446241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URUGPjnqsQCliGYebP4MIXMTsTKoR6R+RTcTkNmd7wk=;
        b=kzQFAbYnCyI4An1TtuQYvfYYLiW+N5VkWr0/XcuogXjakTSJ/4dMlAWPNYVE7Mogu7
         TWfzqdmIM1eeieh1F6wdThOgIuH529wKCr96zm4Ri9RGeTk3gWH2cXGp6ytSwRMQUMN8
         UXlMLbv69ecbzUHbi2Gx3Dig9IUZ3OVV6PBbcu8eAJCIEaP1GO5i09BEGw16zGqtbqaP
         9zPaFr97ooWuZj9wpZf3B5V2SgEIY+GC6fPvqRn5fOQCwTveb/Sv6n6EcOBE9IdIpsQq
         03i2F0Tj4Gx3bVmDxJtlO6hQFDZaPq9gd5FKA5YQIiDJ4kH7UFJ/B3M+2Vg88SuzlcBG
         Q45g==
X-Forwarded-Encrypted: i=1; AHgh+RrjBqmmWrSQXE7sYT5fYbLgOY/WjLxkhKZxYVPS/B/Vv6jjznuzQ9xOjhpFsqgLN35OE2VwbNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8yMqxlKXb/95j3H+CdVyZGZ6viLAdAE2vJcCajqk6StD0VyV
	ysAFhrcJGn/TmGxCDEVU9l4TSHik4TReACbvi+sBvrYR3TDIbC01L39bHHte67D1OC1QAjsHANL
	FNw4RI+Sy4GtBgWzUT+25B5f5CIzPR2jyRQrHDkq1
X-Gm-Gg: AfdE7cnnei0X7S66meJHPy+GjuxKNeS39UZXWoDtnS8ijlRaAdQlq7dIvdI3i/4pkR2
	EdUgJBOZNbbooXoaxjaacjIYttBYZZ3ry+e77OrTPb9vtAkNWzOxrdbuGz/5mjsEmTXSOVWzbBV
	yWCuZbdY/zUdEE8CMSQMYFL8rMHBUX6xS1BNktN7tyjI5vftbM4M+gVMfsG5ZW/FpSRKaqMrOJK
	b7jf5MqUr3g8vWhX2y+NOHAVCApHuIFGmMOKax5ltIwCw48eD+C/nC7IT91k7KMi2p0FF0SBv+Z
	YubfxVonZePvM5MssynRaqqc8w3k
X-Received: by 2002:a17:902:da88:b0:2c9:e6d7:fbb4 with SMTP id
 d9443c01a7336-2ca5a6101d9mr12888615ad.31.1782841441354; Tue, 30 Jun 2026
 10:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630174110.2003121-1-xmei5@asu.edu>
In-Reply-To: <20260630174110.2003121-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 30 Jun 2026 10:43:49 -0700
X-Gm-Features: AVVi8CccJahYpOmchuic4l9yBmy1i9BwC8vBSl9Tk5g4PsMcnfGQHAM0THUL6rA
Message-ID: <CAPpSM+SkjzOKfKBC00E19ZQ930GbamqonpwVV7_91e2WkNJHYQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: qualcomm: rmnet: validate MAP frame length
 before ingress parsing
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: sean.tranchetti@oss.qualcomm.com, netdev@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-303315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:subash.a.kasiviswanathan@oss.qualcomm.com,m:sean.tranchetti@oss.qualcomm.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FA476E7039

Thanks so much for your refactor. It's better! I took it for v2 with
two small changes:

- Dropped the goto err1/err0; the helper has no cleanup, so it just returns
  0 or packet_len directly. (err0 was the success path anyway.)

- The no-agg caller leaks the skb when validation fails, since
  __rmnet_map_ingress_handler() is the one that owns and frees it:

if (rmnet_map_validate_packet_len(skb, port))
__rmnet_map_ingress_handler(skb, port);
else
kfree_skb(skb);

I also bounds-check the MAP header up front (skb->len < sizeof(*maph)),
since the no-agg path can get a frame shorter than the header before
maph->pkt_len is read.

v2 sent with you as Suggested-by. Tested with the original repro: OOB gone
on the no-agg path, valid frames and the deagg path unaffected.

Xiang

On Tue, Jun 30, 2026 at 10:41=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> When ingress deaggregation is disabled, rmnet_map_ingress_handler() passe=
s
> the skb straight to __rmnet_map_ingress_handler(), skipping the length
> validation that rmnet_map_deaggregate() performs on the aggregated path.
> The parser then dereferences the MAP header and csum header/trailer based=
 on
> the on-wire pkt_len without checking skb->len, so a short frame is read o=
ut
> of bounds:
>
>   BUG: KASAN: slab-out-of-bounds in rmnet_map_checksum_downlink_packet
>   Read of size 1 at addr ffff88801118ed00 by task exploit/147
>   Call Trace:
>    ...
>    rmnet_map_checksum_downlink_packet (drivers/net/ethernet/qualcomm/rmne=
t/rmnet_map_data.c:413)
>    __rmnet_map_ingress_handler (drivers/net/ethernet/qualcomm/rmnet/rmnet=
_handlers.c:96)
>    rmnet_rx_handler (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c=
:129)
>    __netif_receive_skb_core.constprop.0 (net/core/dev.c:6089)
>    netif_receive_skb (net/core/dev.c:6460)
>    tun_get_user (drivers/net/tun.c:1955)
>    tun_chr_write_iter (drivers/net/tun.c:2001)
>    vfs_write (fs/read_write.c:688)
>    ksys_write (fs/read_write.c:740)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    ...
>
> Factor that validation out of rmnet_map_deaggregate() into
> rmnet_map_validate_packet_len() and run it on the no-aggregation path too=
.
> The MAP header is bounds-checked first, since this path can receive a fra=
me
> shorter than the header.
>
> Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial im=
plementation")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Suggested-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@os=
s.qualcomm.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: Validate on the no-aggregation path by reusing the deaggregation
>     length checks (factored into rmnet_map_validate_packet_len()) instead
>     of adding separate pskb_may_pull() guards in __rmnet_map_ingress_hand=
ler().
>
>  .../ethernet/qualcomm/rmnet/rmnet_handlers.c  |  5 +-
>  .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  1 +
>  .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 72 ++++++++++---------
>  3 files changed, 45 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drive=
rs/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> index 9f3479500f85..d055a2628d8c 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> @@ -126,7 +126,10 @@ rmnet_map_ingress_handler(struct sk_buff *skb,
>
>                 consume_skb(skb);
>         } else {
> -               __rmnet_map_ingress_handler(skb, port);
> +               if (rmnet_map_validate_packet_len(skb, port))
> +                       __rmnet_map_ingress_handler(skb, port);
> +               else
> +                       kfree_skb(skb);
>         }
>  }
>
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/ne=
t/ethernet/qualcomm/rmnet/rmnet_map.h
> index b70284095568..60ca8b780c88 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> @@ -59,5 +59,6 @@ void rmnet_map_tx_aggregate_init(struct rmnet_port *por=
t);
>  void rmnet_map_tx_aggregate_exit(struct rmnet_port *port);
>  void rmnet_map_update_ul_agg_config(struct rmnet_port *port, u32 size,
>                                     u32 count, u32 time);
> +u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port=
 *port);
>
>  #endif /* _RMNET_MAP_H_ */
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drive=
rs/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 8b4640c5d61e..305ae15ae8f3 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -333,54 +333,62 @@ struct rmnet_map_header *rmnet_map_add_map_header(s=
truct sk_buff *skb,
>         return map_header;
>  }
>
> -/* Deaggregates a single packet
> - * A whole new buffer is allocated for each portion of an aggregated fra=
me.
> - * Caller should keep calling deaggregate() on the source skb until 0 is
> - * returned, indicating that there are no more packets to deaggregate. C=
aller
> - * is responsible for freeing the original skb.
> - */
> -struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
> -                                     struct rmnet_port *port)
> +u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port=
 *port)
>  {
>         struct rmnet_map_v5_csum_header *next_hdr =3D NULL;
>         struct rmnet_map_header *maph;
>         void *data =3D skb->data;
> -       struct sk_buff *skbn;
> -       u8 nexthdr_type;
>         u32 packet_len;
>
> -       if (skb->len =3D=3D 0)
> -               return NULL;
> +       if (skb->len < sizeof(*maph))
> +               return 0;
>
>         maph =3D (struct rmnet_map_header *)skb->data;
> +
> +       /* Some hardware can send us empty frames. Catch them */
> +       if (!maph->pkt_len)
> +               return 0;
> +
>         packet_len =3D ntohs(maph->pkt_len) + sizeof(*maph);
>
>         if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4) {
>                 packet_len +=3D sizeof(struct rmnet_map_dl_csum_trailer);
> -       } else if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) {
> -               if (!(maph->flags & MAP_CMD_FLAG)) {
> -                       packet_len +=3D sizeof(*next_hdr);
> -                       if (maph->flags & MAP_NEXT_HEADER_FLAG)
> -                               next_hdr =3D data + sizeof(*maph);
> -                       else
> -                               /* Mapv5 data pkt without csum hdr is inv=
alid */
> -                               return NULL;
> -               }
> +       } else if ((port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) =
&&
> +                  !(maph->flags & MAP_CMD_FLAG)) {
> +               /* Mapv5 data pkt without csum hdr is invalid */
> +               if (!(maph->flags & MAP_NEXT_HEADER_FLAG))
> +                       return 0;
> +
> +               packet_len +=3D sizeof(*next_hdr);
> +               next_hdr =3D data + sizeof(*maph);
>         }
>
> -       if (((int)skb->len - (int)packet_len) < 0)
> -               return NULL;
> +       if (skb->len < packet_len)
> +               return 0;
>
> -       /* Some hardware can send us empty frames. Catch them */
> -       if (!maph->pkt_len)
> -               return NULL;
> +       if (next_hdr &&
> +           u8_get_bits(next_hdr->header_info, MAPV5_HDRINFO_HDR_TYPE_FMA=
SK) !=3D
> +           RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
> +               return 0;
>
> -       if (next_hdr) {
> -               nexthdr_type =3D u8_get_bits(next_hdr->header_info,
> -                                          MAPV5_HDRINFO_HDR_TYPE_FMASK);
> -               if (nexthdr_type !=3D RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
> -                       return NULL;
> -       }
> +       return packet_len;
> +}
> +
> +/* Deaggregates a single packet
> + * A whole new buffer is allocated for each portion of an aggregated fra=
me.
> + * Caller should keep calling deaggregate() on the source skb until 0 is
> + * returned, indicating that there are no more packets to deaggregate. C=
aller
> + * is responsible for freeing the original skb.
> + */
> +struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
> +                                     struct rmnet_port *port)
> +{
> +       struct sk_buff *skbn;
> +       u32 packet_len;
> +
> +       packet_len =3D rmnet_map_validate_packet_len(skb, port);
> +       if (!packet_len)
> +               return NULL;
>
>         skbn =3D alloc_skb(packet_len + RMNET_MAP_DEAGGR_SPACING, GFP_ATO=
MIC);
>         if (!skbn)
> --
> 2.43.0
>

