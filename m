Return-Path: <netdev+bounces-283387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XxFhAq239WlEOQIAu9opvQ
	(envelope-from <netdev+bounces-283387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 10:37:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F217D4B1768
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 10:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15A75300608C
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 08:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3730BF67;
	Sat,  2 May 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLVmJq+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18826AA91
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777711015; cv=pass; b=u8tRBjONQEjeI5po6D0btM5fmHG3obG5+SZlHo7np22/Ihc3vy/sw88eFrk67s9nDFMYC/eqqGx9oSKt6BcE+9jD05wq6PROZ8wPJeiqQsGEcQlQxtbWQ0Th2WpbYo2JFHWDvEkeW98Lj8nL3tHbfVGj2/UEr2f9Pu1agMxhVrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777711015; c=relaxed/simple;
	bh=andkUIMouYoLywoxy/vpQvybL6Zo84bzdPTc/xLOSSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVH1RV5VGWDLaYXXFeEiCzWtNNC0cimRYdeLLG21vbO4+mEkcGZGrYiFkzcp1Tck+CAmwpsDio18BAq7p/ZHL2aRnqvP92htSs4Fk8+Yhk6lgezAVuTHoMqusqVwFRc46lIi3UYGMCIfoipknPI4qlGa2SlLu6D4LZSpvv32Uuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLVmJq+C; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b4aeddfacaso21865816d6.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 01:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777711012; cv=none;
        d=google.com; s=arc-20240605;
        b=MNcINQernqYvR8VbMY5T9tH3SGYgHHM5OAyOi+oMEDy9wqvGH4LT/S+G3jTdgobMf9
         66oe1RWRR0gPD6e8DGEMDRbfXQzL/3h3K79MLbZvpMDF3p1mZEcSWkSUApostaqRlZ3W
         KsdvNTjkinWsNoJOre/VHDKoZgsYSgxmck1p/QWIoWJnuUXEEj7a9YzoxKu97+Ya9nug
         i0nByrUo1azlJa6F6vrEOrZ7YaHbHkPUq1UEBl8i5O4GtwxSyhxgfnghcI3PDFRGGk8i
         dBFJR3oHOCU0CKCMHt6jza+sCIvQ9C/T6DGGWsFd3DVK9psgH7zjOdJcW2t99dwaUrVH
         b0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tLRhkfcuYeStvcRa0E070mAcvp+waesXIZSTr6q6CXU=;
        fh=sZjX/0ZSmv2KIvF8Zb1ZdfFQ3pyDd9evrn5duo0bkpI=;
        b=R4TpqgF8wyp+LpYSmrSp1MGr6PiGkXBPRTXEw1BKN200UO5Irv1Wwom8gyhWhSp54i
         cg3P3IBcCgbN+jCIMYiBeLsXMlsTpXeprxshVMeW626TYNasnVQQzefIP5AVr47SV2J9
         q7Xl0eQNdB/EuOi+bLHXuoAkIxvYjbyF1r+EoZupMAfWgUzpJ7vbI1FHQyXp4/aT+UfZ
         dEJtIeDxCBLHr7ydHtMUYz3iVn+rWa4GKDvr2KhlOJqqHTffHVfAW19+G6fydyJg2h9K
         5LW5GuaJmDOyb4uVbCWfkzI8n/YnY/nX1zi+LxNhQn4FI0p6NuWZ40uv6GG2reCdMCf7
         d3fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777711012; x=1778315812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLRhkfcuYeStvcRa0E070mAcvp+waesXIZSTr6q6CXU=;
        b=mLVmJq+C34vY6I5Fll+zd3WGZ2dibCGxx/rBEgTHpiwYK+m+mGIIWI29NfSbBPnGE9
         h+G6grbmbTxbPnEzQuCWTPk4FR5pcqqGSk+lD+HjwMpRFyWjdMUHk5MYwPk2awd5cdYv
         rcG0oq6kUa6aWcfDV8bAHLY1VYCImHYtLpQsNuUxZAhKjmP0FRDSqPfHrhBBOgTrh8vo
         /zjE3Pnnr6dCH8t/7UW7qqjafjAOVrXB5X6cOJQfpj5PWdBSyILj5nIOCY2lan0Wetaj
         V3RnmXt/jCICzwuKGk47lUjnzt4z9iOXN97etxDgXcR29jlA04ZQo5XxehjP4b9UrYFB
         +yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777711012; x=1778315812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tLRhkfcuYeStvcRa0E070mAcvp+waesXIZSTr6q6CXU=;
        b=gBTti4b7sTd4fx37NOnCJTSqE8pnuGpwXdZPDph7QRkTNnPQ6uFBnJoDXRiHCpFbQR
         gNZKYoIEDIzC1gctPEWUhSeHDukodfitT/TdKn9lN/EKKLZoa6W29enIGqAPFciFh7Lo
         R+94jssxyuoANIqt2+OJrRqSSdB2W75CTb3m9ltVEYlG9mZs9qc9PLSspJZ5BX+LI/PQ
         16aUC5ZSEbIl3meBRYZ1n7N70+apqCA3hZiNQSCfZisKJIVW5Pj4HcOK/HuhV/gnSofc
         wjvu6UqfQap81/Kd2fYMc61zAcmrk3O5gQq/uS4hQINUBAUrGhGa1Ag0FIEeQjhd+6oq
         UTOw==
X-Gm-Message-State: AOJu0Yw8kkzPtFHk+QHkknhHaDOlFmPi2KhpnL+YMcQJ6Bvi7Hzb8hfI
	ibpparwE8NZ0taC0FhHi//MZ3TjvseJHOK+yggPq/DWoSYyblZiA9gmJ+/DDkdKdxyKMzS0gOJ+
	yE3O5/DRrGymgDa1HWQ3uFW7rLgcnVag=
X-Gm-Gg: AeBDieuDt9HXE3aYa7+cQGF4ohufkC3U6PkS6IEL6596NIA34pTj4HleKn5Qog2dBtE
	iqBrH7xfwZg02dbFN2jdxYoLF4+TqY207D6Kzf561kCIEfd9OwvFAJCyYHd18d/a3ghkeKbZ5CK
	GLDb9ULxvKLmsHx0dhOqw1woPrH/0R1CZZUISbxryxmGTR2HeM9zgtjBtBHnZ1tH8I3ie2rtDzT
	lZH/neN4Y58HP0t5ymQFZVBT2o8j64IMhRKWe7HFMUsocCa2KsiKIJv3dinIjQzppR7vMuvNUEE
	Pcql6KC5hzKSwkJ2lso=
X-Received: by 2002:a05:6214:43c7:b0:8ac:b0ef:47a5 with SMTP id
 6a1803df08f44-8b668929286mr56552296d6.35.1777711011711; Sat, 02 May 2026
 01:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026042133-gout-unvented-1bd9@gregkh>
In-Reply-To: <2026042133-gout-unvented-1bd9@gregkh>
From: Yuan Tan <yuantan098@gmail.com>
Date: Sat, 2 May 2026 01:36:18 -0700
X-Gm-Features: AVHnY4Ly2M_dFbHI8dnVbHtG50l1O1ncf3WBij1ADNv8VN0yN0KxKF1-ujtuVHk
Message-ID: <CAPuPA7JS-yG_dYaPVjv9JiGOEXSpExXSQhsZaexUkr-WMeQHrw@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv6: rpl: reserve mac_len headroom when
 recompressed SRH grows
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F217D4B1768
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283387-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,davemloft.net:email,mail.gmail.com:mid]

On Tue, Apr 21, 2026 at 6:16=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> ipv6_rpl_srh_rcv() decompresses an RFC 6554 Source Routing Header, swaps
> the next segment into ipv6_hdr->daddr, recompresses, then pulls the old
> header and pushes the new one plus the IPv6 header back.  The
> recompressed header can be larger than the received one when the swap
> reduces the common-prefix length the segments share with daddr (CmprI=3D0=
,
> CmprE>0, seg[0][0] !=3D daddr[0] gives the maximum +8 bytes).
>
> pskb_expand_head() was gated on segments_left =3D=3D 0, so on earlier
> segments the push consumed unchecked headroom.  Once skb_push() leaves
> fewer than skb->mac_len bytes in front of data,
> skb_mac_header_rebuild()'s call to:
>
>         skb_set_mac_header(skb, -skb->mac_len);
>
> will store (data - head) - mac_len into the u16 mac_header field, which
> wraps to ~65530, and the following memmove() writes mac_len bytes ~64KiB
> past skb->head.
>
> A single AF_INET6/SOCK_RAW/IPV6_HDRINCL packet over lo with a two
> segment type-3 SRH (CmprI=3D0, CmprE=3D15) reaches headroom 8 after one
> pass; KASAN reports a 14-byte OOB write in ipv6_rthdr_rcv.
>
> Fix this by expanding the head whenever the remaining room is less than
> the push size plus mac_len, and request that much extra so the rebuilt
> MAC header fits afterwards.
>
> Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: stable <stable@kernel.org>
> Reported-by: Anthropic
> Assisted-by: gkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v3: - skb_postpull_rcsum() should not be changed, it's chdr NOT hdr, ugh
>       Link to v2: https://lore.kernel.org/r/2026042158-sediment-elliptic-=
a954@gregkh
>
> v2: - fixed up if statement to actually work properly, and test it
>       against a working poc (poc will be sent separately)
>       Reworded the changelog and the subject to make more sense
>       Link to v1: https://lore.kernel.org/r/2026042024-cabbie-gills-9371@=
gregkh
>
>  net/ipv6/exthdrs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 95558fd6f447..03cbce842c1a 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -491,6 +491,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>         struct net *net =3D dev_net(skb->dev);
>         struct inet6_dev *idev;
>         struct ipv6hdr *oldhdr;
> +       unsigned int chdr_len;
>         unsigned char *buf;
>         int accept_rpl_seg;
>         int i, err;
> @@ -592,8 +593,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>         skb_pull(skb, ((hdr->hdrlen + 1) << 3));
>         skb_postpull_rcsum(skb, oldhdr,
>                            sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) <<=
 3));
> -       if (unlikely(!hdr->segments_left)) {
> -               if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr=
->hdrlen + 1) << 3), 0,
> +       chdr_len =3D sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3);
> +       if (unlikely(!hdr->segments_left ||
> +                    skb_headroom(skb) < chdr_len + skb->mac_len)) {
> +               if (pskb_expand_head(skb, chdr_len + skb->mac_len, 0,
>                                      GFP_ATOMIC)) {
>                         __IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), =
IPSTATS_MIB_OUTDISCARDS);
>                         kfree_skb(skb);
> @@ -603,7 +606,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>
>                 oldhdr =3D ipv6_hdr(skb);
>         }
> -       skb_push(skb, ((chdr->hdrlen + 1) << 3) + sizeof(struct ipv6hdr))=
;
> +       skb_push(skb, chdr_len);
>         skb_reset_network_header(skb);
>         skb_mac_header_rebuild(skb);
>         skb_set_transport_header(skb, sizeof(struct ipv6hdr));
> --
> 2.53.0
>

I am happy to see this bug is finally fixed.

However, it seems the Reported-by tag does not include our credit.

We first submitted the security report and patch to
security@kernel.org on February 23, titled:

[SECURITY] IPv6/RPL: 14-byte controllable OOB write via SRH len
overflow + skb_mac_header_rebuild() u16 wraparound

[PATCH] ipv6: rpl: rebuild MAC+metadata safely when rewriting SRH

We have aslo followed up and resent the patch several times, CCing all
relevant maintainers.

Could our credit be added to the patch?

Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>

I noticed this patch has already been merged into the mainline. Maybe
it's too late to amend this patch. Is there any other way to document
our reporting credit in the official records? Maybe in the stable
backport?

This one is pretty important to us and we would appreciate it if our
reporting credit could be reflected.

