Return-Path: <netdev+bounces-272693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AL6HQEHx2kyRwUAu9opvQ
	(envelope-from <netdev+bounces-272693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 23:38:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C6434C017
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 23:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59CB7300CE62
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CF937998A;
	Fri, 27 Mar 2026 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jW70iwN8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88D63815E6
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651096; cv=pass; b=ogNQ7MuLQdtHwxoKJYBY0NTjID+IcNrHtylZZyRRAAa46APAY6QkLYDj4XOVsBQQub51ncNg2hdo4JkaKyz4PQR1g0iuWmlKtm9SDIgzJG6B4YsKuAxxiTB84yMLlnV2AuL0PfuzucxSBYqogG2bzroQqg7WJpVlgkKUr/8ZjOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651096; c=relaxed/simple;
	bh=2xgcvU7FSqsT2nbk5tvXQy2j0/60ObEtQdHNriQUQM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJqpDuwESw87tad1GHh6+uGCu8JLzEt18Fr0NTdyRCAezJ9QunrpqGNBaih5Qj0Ojig9CPArqPaLOOWTlusLJ1ZleYBNK4Yo9iEpk6t3/Db15bfYG80JtGKK1jVPY5LiwKCRqh97aZoKH/s08oz8mC4zvEhCP+qgi0GOYKxgB3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jW70iwN8; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-128b9b7e3edso2522826c88.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774651095; cv=none;
        d=google.com; s=arc-20240605;
        b=L/pLeISteYn0583CyRLu3VsaY3oqBW6zwK7nL9luKsRTkuV4GFO5zOQWjn0eRxoJ+x
         WxWUuL/aGt4czF6hOODDrJHPsRlzhNlT0tEqLRI19D37gHoeAN8he90xkRhKskmDneQk
         IYvasF1ckaXXThobhdN6czg6bA5otpb059/KxrzBEpIyCr1AVZx62YCEXMHT4TH2OhU/
         /o35p5vJPc1ump7a5soACt0Ldv2uSV/FRjja8Az6gi7ypWXF3SzkQ9sx18N79NAeRdhs
         K6cNSYW4b21MARRCeY7FN/9FOZUraLv9+fjJUuwhJhZnUO51993FFc+eQKwEzrIYxdci
         qM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=30D3BvfyTBd+g5W0HOUT9lW7hcSxS/JDjXsOx8kf2LE=;
        fh=sLcLFHH8jvYha3R8WrhKldB31Yp6edTt89E3Sdmhdto=;
        b=L+isrWqQCo8Cn6GJE3seXTFMTTfGNpuN+wSAzyG3dD/ncbzClQx+2wh3mDp84vWO2y
         hr9ghts07WSuP6QQJelxtCAJZnrDwVoPqO779umFnBNlGicpGNkeyVc5hBwSsP2pzl4P
         iPKVCHYGHPUbXaz64wc9NRyhsTOGyA6faa6Abd1GDqffCVkEVzEKgz6ngHOD91m15vbW
         LOMHGeo2LvJ1HX6z75GfTzqp4fUWyjZezIHXHC8LSEegTBGvpW17B9D4PPF5zGIwul0X
         6JuKIy6i3BrAspq4d/CqWpMjnD4yF/4QH6MfSrbU6FJT+81UV/TidUQIcIzFupyzrTQY
         Ai6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774651095; x=1775255895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30D3BvfyTBd+g5W0HOUT9lW7hcSxS/JDjXsOx8kf2LE=;
        b=jW70iwN8IA8d9B4k89lsT2hJXxCetUtXDzUJNsGSRlkotYOAANRj/QraA0W2G5wRjr
         /STjlV4zJ+FAeMgdZiv25bCFaxKskkGbnHqnUNwADiUAyzf8QuLOd4c5bL7WS6d5uh5f
         1CT/HUrhPAO5WDj0eDCw2MDRFB+jPPV0UozDn7wdw9VnywK/TsZqNqQEMaP76RIgo9Gz
         gW5Q1S+l4mNJSUdc2ZX660WwaePo9CjpYTQqMsx+D/dYajcXiWvnR+ec0KxCSTSJiz6i
         qvT7dmkmFXM0J1oDXzNy8OMSkqPDQvZfg0Cw7H3+QJ+r+kGhTooKEzZ4AgvnTdk78PmB
         k8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651095; x=1775255895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=30D3BvfyTBd+g5W0HOUT9lW7hcSxS/JDjXsOx8kf2LE=;
        b=TC2Bpvo9X9Q9NQj3iugDxm8fBabYPbAYskpfFWiVaXXpqg1NZDg2mpnv/I+KvHX0g8
         hQ76IRYpAmXIbwqZRlZ5Xmzc5oNdeQ2cdDvjCsUXFpCJponS9alBfxMU5rNhyWQFZxP+
         sb0KWtqJfkPBDaz37hZ1xMm1sVo5lRzvKbBzKOEdr6O+yBLN1McdIw7xDuAtIMkwn2W3
         SFUHo1p6sAuxWLoDmqxdkNErnUlboCZa9tH247QR8N0KRglF0YQig6fpL/gKTq1Yd0J0
         OQanygySWcNb0HFAZ76u265+JrTamf/rBMRtYzzWu11wkdbLhZAY2vkLTBuEwrkd0Wta
         wbUQ==
X-Gm-Message-State: AOJu0YzbTRC4l4YbwYN8VWIBo+cOntnlgOv7jeX4lBsrCBvtNDwpbbJK
	swiQCWMhPpFDyloKZvBT197WyjqDl/z4fSIbJ/OhkXaWLI8oAAC3KfEbv7PlYKIenPC61Df14cm
	JmBb5R5u83iJ6Tlvfqhbx05XAta6aYtOMEM8zMHX6azGRlybYIXTj3bDHsT4=
X-Gm-Gg: ATEYQzwgDOs6YE0VYpu0JWT2jKXhuuGOoBctfWRwPNLE+dxJCfUdXp07PqTB2WMPbJz
	nRG8HhkajEz4FvlYASVbY5hJM3jmnq4NrFaZMOqrGwctbTKfPjNlwmgRa4GR2nmrFD/RHoui3OW
	pKwbXRjjtNzuOjx0WFStScVv0M156wOe9H75tJoBqdeABXZEbU9ob0cM67WgZVCKu9lUwHft/Mk
	JojtSVEqKGlP82sRUMmwRH0as/jbmb5JrKCQWS3YNDLdVQxhASOATK3VrJSLw3Dw+vXZoL3Cevv
	BQaaCxMWFSV2KAV+Emlf2efyt6sSGRGwI0DgDqHXpbLmnptzTyyYfziCs9VQZly43srAYKMDfsv
	WtANq
X-Received: by 2002:a05:7022:6085:b0:12a:7165:7405 with SMTP id
 a92af1059eb24-12ab28a6f5cmr2306467c88.8.1774651094215; Fri, 27 Mar 2026
 15:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327221203.430454-1-nickgarlis@gmail.com>
In-Reply-To: <20260327221203.430454-1-nickgarlis@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Mar 2026 15:38:03 -0700
X-Gm-Features: AQROBzAVNcK0rb7300OcbQlbjoANdrOg4IHJtsBbrhrkpYVcC4layu48CO_LJbg
Message-ID: <CAAVpQUDSYmdaVCfJr1Y-3FFbFawXX6kO0NAv_BmGuNrCr-yrfQ@mail.gmail.com>
Subject: Re: [PATCH net v2] rtnetlink: add missing netlink_ns_capable() check
 for peer netns
To: Nikolaos Gkarlis <nickgarlis@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272693-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1C6434C017
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 3:12=E2=80=AFPM Nikolaos Gkarlis <nickgarlis@gmail.=
com> wrote:
>
> rtnl_newlink() lacks a CAP_NET_ADMIN capability check on the peer
> network namespace when creating paired devices (veth, vxcan,
> netkit). This allows an unprivileged user with a user namespace
> to create interfaces in arbitrary network namespaces, including
> init_net.
>
> Add a netlink_ns_capable() check for CAP_NET_ADMIN in the peer
> namespace before allowing device creation to proceed.
>
> Fixes: 81adee47dfb6 ("net: Support specifying the network namespace upon =
device creation.")
> Signed-off-by: Nikolaos Gkarlis <nickgarlis@gmail.com>
> ---
> v2:
>  - Removed "Reported-by" tag
>  - Fixed "Fixes" tag with the help of Kuniyuki Iwashima (thanks !)
>
>  net/core/rtnetlink.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index fae8034efbf..ee7d9d65b2c 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4059,8 +4059,15 @@ static int rtnl_newlink(struct sk_buff *skb, struc=
t nlmsghdr *nlh,
>                                 ret =3D PTR_ERR(peer_net);
>                                 goto put_ops;
>                         }
> -                       if (peer_net)
> +                       if (peer_net) {
> +                               if (!netlink_ns_capable(skb, peer_net->us=
er_ns,
> +                                                       CAP_NET_ADMIN)) {

I think this can be moved after the last rtnl_link_get_net_ifla()
in rtnl_get_peer_net().

If netns is not fetched from the peer tb, rtnl_link_get_net_capable()
just below this chunk will perform the same check redundantly.


> +                                       put_net(peer_net);
> +                                       ret =3D -EPERM;
> +                                       goto put_ops;
> +                               }
>                                 rtnl_nets_add(&rtnl_nets, peer_net);
> +                       }
>                 }
>         }
>
> --
> 2.34.1
>

