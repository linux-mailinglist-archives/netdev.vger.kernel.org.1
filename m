Return-Path: <netdev+bounces-265883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIwwGZ6Kr2nJaQIAu9opvQ
	(envelope-from <netdev+bounces-265883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:06:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BF424497E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEFEC301A16F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF407205E26;
	Tue, 10 Mar 2026 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvaCuvE+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKwTOCZk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0C18AE3
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111963; cv=pass; b=DspsBk/SH0vGNuwlMPSsEJia+7wjpRnSCsvp3ct75ZbpJ/A6tNRT0TxoMKhRNPOeGH9CfgryoWr/xG5l/mU2HD4kbWG6rFhdfKimJjyZY+exFK2cXu7jsHAMBEtD38Jap9Tv0SOQ+vdpJRUWW8qqXG6T8Md6DM6BG0C5OvSkYSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111963; c=relaxed/simple;
	bh=5d5ZgKFjpMZUgiSFD8yWv0iyoc2ASp+Hz/FCq0sxsoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDcoDA/LaNtlUueiSEetAJBi6ZgLiXGvOzMtmRQ8l0yNgny7YxqfFNpXB9v/Q6s40fFkuDRXHcgxCHHKd2hKqft6NqLxMpLZXC772MyNBbAu8XQhMGDsNrSMBxisqpm2DwLa10c2n2ASE/OJc7LWC40Czp0kVS6g7FtkFWrbZsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvaCuvE+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKwTOCZk; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773111961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZn0Boo3x89EFxqie/JvdvARfbAGd/0AJYiLM3RQAng=;
	b=GvaCuvE+/S2rrslFHnOLoG+TtiFPJ6CLGrFKzVMN0WNMskhCKKkBPx7saF3aHg++BRuR5I
	FtH3GraL/LqNsvASaJUWTq0BeQyxVkz8n5N/T8kEAIgyzBb2fEPM0M3Y0dLRTWCaxNK8IQ
	I4P+Cdp+OVlHt4n/ZQsQAsXDh6TkNec=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-HVH9sOyyPdWDjxTDPMPpuQ-1; Mon, 09 Mar 2026 23:06:00 -0400
X-MC-Unique: HVH9sOyyPdWDjxTDPMPpuQ-1
X-Mimecast-MFC-AGG-ID: HVH9sOyyPdWDjxTDPMPpuQ_1773111959
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so7440210a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 20:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773111959; cv=none;
        d=google.com; s=arc-20240605;
        b=Hzdkgemv227Z8NUuN9yliBeXp0Js69sFGUS7PvQ9L06eZps9wSo9hR0r6PRwSrZKI7
         t7U3u0Z9//TqbUP1vv+L9H2C5QPKW+MlJ8bcSo95AXbWgNNCti7Vx9gsTR3gV/I6HWXy
         t7jSWylfqyeVrYBgyogrlbzyqnz7VohibGjxwRtx2QLoVLaEuhvW8EoP0Ndd1u862OaG
         22JEXZiBXQK288wXfJ/ClvpmEuviHkn42SqKxQM03czi7UrmB6/LDHoajafWUj6s72GN
         +Nplv79d6KFGu1cRg1rACi+ctZONrwsNSd3duPTN4KMyflEJdtAZFKz6qiIugHAM8oJY
         0vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cZn0Boo3x89EFxqie/JvdvARfbAGd/0AJYiLM3RQAng=;
        fh=LLqbKS3O/TWLpPiiyZepelxXjuLs+xOBTKZLLydgE2g=;
        b=RtJ3cVymaGWKAxn835rcUcqCmYd1m48ZOrXfnoh9yPOTx/J1u3IIFSXNly0EBUGxB3
         ziej2pE79i2funokT7JoKiufzEytb62KJLPIcam87g2X32eokjcokflwvpeyfwEp8yzb
         aJC2QNEoi0W9rOdcRWc/QMEQnUwAJ7QGl4qdn1IZiU3taVGk0tPLTsBIsr/OqwGnp44c
         gewXIxdzt+89nbCn4hjl+Z7c0fkkGgcEiISOUsV+NWLgfuwOdhqtqNZrgGLSvaBhtny+
         BVLUF92jLmR3TBQzKs65iUZ2Kh0qyjFUgCJD79y2AIPzoJu6Psv4vtt7NGqviH7UR4xY
         +sPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773111959; x=1773716759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZn0Boo3x89EFxqie/JvdvARfbAGd/0AJYiLM3RQAng=;
        b=JKwTOCZkd2zDl+S1agv52lOhQAraCJiG5HgCkd6Zxfy7GqEZwk5VYMOnqbIISKidmd
         fUqQcTBnoe7KWCMaYSl7vRTvNO5kuljcWNJk32hPsolWf/US0bBJ8eT9mh25XLFhBzXb
         L/5w/TwneGQuPmcX/p85/yLUmrGMGqYbQkeUcs7wK2xlUlK5hV6OCpbawMhCKUyzDFfh
         e5NP1A1j8UaxOE5/jisgg4/TBfdwc+HkaQKWPYQCwefIpFVabeJo1cDtkb5wyHtdz/2O
         e4Vmhuu3ETclBWMsADYTPkKI4KHhdfI1EI12R9+hPRh2dN/DKEvhVJIsQ84GR7o1A1A+
         7SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773111959; x=1773716759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZn0Boo3x89EFxqie/JvdvARfbAGd/0AJYiLM3RQAng=;
        b=wd8/dblI+/a2fVYZ5cYkiX5pttMNdvsf0xY0OVMrg0KiujKMvx6KDRCohZvu/Y+AMF
         eeMk8a9irupJA1TwNwb3J3GrXdyqy9tlM6vQigE3mNi0e+XryYJTPGah9zn58rSZVFel
         eVclLke4aoKNkeAQ0zxZfiD2GH5jNoaVpgyqn7b2qd4cBnoFO0IJZAYfId/Nl+mJU8je
         8qD3zi8xNfsbi1Mr9oBx2NZQIwG3bDpPnLRsJ11QuXjX4ThMvcLWGFJOI7IABSc3dTDg
         TnEyDUW3yo/0OkossXmQ4oqqId6gpVfgTxVkioMIgnBvDMNf2nOOvR9W7gnm97ksGlar
         D0Kw==
X-Gm-Message-State: AOJu0Yxr9EVihNNx1gqKCfTy/j2VSFFN9fqJWkQSNvtySTV2vsBw+RPp
	d99PoKuNIyYtffi4WT+L5e8CVHJYJLfx684srpgmH2oTR10rbu95y/B2OIl4NTk0FW8UnHWJjX5
	bjxbxkXjxncszJtPrF5IbfvmyyhDl3U1LUB5NrWK2K5eJA7+bPBgphvctEgXyV0qqFmsLj4xC57
	mj7AgPteb2E0jjxCAZn5SVPvjcqz4V7OXN
X-Gm-Gg: ATEYQzx/2xiJKVMou1e2Ctm4NO3RwF2Nq2gHE1wiUCYULN1j2lOxCUnT7aReBhbauWe
	8hpgcm8dsL+rmuey/ezsNN3Wrs+EG8LB4v6imLX2luzXteFJ0J1HJHGUScwHpA1UeBMPIaEPcnx
	Beivoe4fQTAFgljsbrOVMH21eXnB8G4BHYqMiUmWPiWmgR8C5Y5s7RYY3sNZW7ub8u/S9kVTSxA
	kcpe8Ac
X-Received: by 2002:a05:6a20:939d:b0:398:7d4a:c2c5 with SMTP id adf61e73a8af0-3987d4b21d3mr8226194637.20.1773111958825;
        Mon, 09 Mar 2026 20:05:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:939d:b0:398:7d4a:c2c5 with SMTP id
 adf61e73a8af0-3987d4b21d3mr8226160637.20.1773111958351; Mon, 09 Mar 2026
 20:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305031938.24518-1-xuanzhuo@linux.alibaba.com> <20260305031938.24518-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260305031938.24518-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Mar 2026 11:05:46 +0800
X-Gm-Features: AaiRm53j3o9ttCcbKPPrTBWFnUbFVEVN2OOQqeYsV4P7O_agGBEhxYtBLpYEBAI
Message-ID: <CACGkMEsmDiTP1tz1hur_tduOUFU1bYqNzQm9nQgPUfdfHrmcKw@mail.gmail.com>
Subject: Re: [PATCH net v8 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D8BF424497E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265883-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,solid-run.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 11:19=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
>
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
>
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.
>
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gues=
t feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/tun_vnet.h     |  2 +-
>  drivers/net/virtio_net.c   |  6 +++-
>  include/linux/virtio_net.h | 58 ++++++++++++++++++++++++++++++--------
>  3 files changed, 53 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index a5f93b6c4482..fa5cab9d3e55 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>
>         if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>                                         tun_vnet_is_little_endian(flags),
> -                                       vlan_hlen, true)) {
> +                                       vlan_hlen, true, false)) {
>                 struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.hdr;
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..7106333ef904 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struct =
sk_buff *skb, bool orphan)
>         struct virtio_net_hdr_v1_hash_tunnel *hdr;
>         int num_sg;
>         unsigned hdr_len =3D vi->hdr_len;
> +       bool feature_hdrlen;
>         bool can_push;
>
> +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> +                                           VIRTIO_NET_F_GUEST_HDRLEN);
> +
>         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>
>         /* Make sure it's safe to cast between formats */
> @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct s=
k_buff *skb, bool orphan)
>
>         if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
>                                         virtio_is_little_endian(vi->vdev)=
, 0,
> -                                       false))
> +                                       false, feature_hdrlen))
>                 return -EPROTO;
>
>         if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 75dabb763c65..23f42bb8ece0 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,20 +207,40 @@ static inline int virtio_net_hdr_to_skb(struct sk_b=
uff *skb,
>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_=
type);
>  }
>
> -static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> -                                         struct virtio_net_hdr *hdr,
> -                                         bool little_endian,
> -                                         bool has_data_valid,
> -                                         int vlan_hlen)
> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> +                                        struct virtio_net_hdr *hdr,
> +                                        bool little_endian,
> +                                        bool feature_hdrlen)
> +{
> +       u16 hdr_len;
> +
> +       if (feature_hdrlen) {
> +               hdr_len =3D skb_transport_offset(skb);
> +
> +               if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> +                       hdr_len +=3D sizeof(struct udphdr);
> +               else
> +                       hdr_len +=3D tcp_hdrlen(skb);

I may miss soemthing but this still looks wrong as we could have e.g
USO and other UDP GSO packets.

> +       } else {
> +               /* This is a hint as to how much should be linear. */
> +               hdr_len =3D skb_headlen(skb);
> +       }
> +
> +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> +}
> +
> +static inline int __virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +                                           struct virtio_net_hdr *hdr,
> +                                           bool little_endian,
> +                                           bool has_data_valid,
> +                                           bool feature_hdrlen,
> +                                           int vlan_hlen)
>  {
>         memset(hdr, 0, sizeof(*hdr));   /* no info leak */
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> -               /* This is a hint as to how much should be linear. */
> -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                skb_headlen(skb));
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> @@ -231,6 +251,10 @@ static inline int virtio_net_hdr_from_skb(const stru=
ct sk_buff *skb,
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
>                 else
>                         return -EINVAL;
> +
> +               virtio_net_set_hdrlen(skb, hdr, little_endian,
> +                                     feature_hdrlen);
> +
>                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
>         } else
> @@ -250,6 +274,16 @@ static inline int virtio_net_hdr_from_skb(const stru=
ct sk_buff *skb,
>         return 0;
>  }
>
> +static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +                                         struct virtio_net_hdr *hdr,
> +                                         bool little_endian,
> +                                         bool has_data_valid,
> +                                         int vlan_hlen)
> +{
> +       return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +                                        has_data_valid, false, vlan_hlen=
);
> +}
> +
>  static inline unsigned int virtio_l3min(bool is_ipv6)
>  {
>         return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> @@ -385,7 +419,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>                             bool tnl_hdr_negotiated,
>                             bool little_endian,
>                             int vlan_hlen,
> -                           bool has_data_valid)
> +                           bool has_data_valid,
> +                           bool feature_hdrlen)
>  {
>         struct virtio_net_hdr *hdr =3D (struct virtio_net_hdr *)vhdr;
>         unsigned int inner_nh, outer_th;
> @@ -395,8 +430,9 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL =
|
>                                                     SKB_GSO_UDP_TUNNEL_CS=
UM);
>         if (!tnl_gso_type)
> -               return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> -                                              has_data_valid, vlan_hlen)=
;
> +               return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +                                                has_data_valid,
> +                                                feature_hdrlen, vlan_hle=
n);
>
>         /* Tunnel support not negotiated but skb ask for it. */
>         if (!tnl_hdr_negotiated)
> --
> 2.32.0.3.g01195cf9f
>

Thanks


