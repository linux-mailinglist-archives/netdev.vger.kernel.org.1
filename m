Return-Path: <netdev+bounces-269734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ4YDCKXvGni0wIAu9opvQ
	(envelope-from <netdev+bounces-269734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:38:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2072D47A6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F671300BE12
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE672139C9;
	Fri, 20 Mar 2026 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeULVs1X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nFAdu8Zo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E21F5834
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967133; cv=pass; b=EcvJEByFXNUNY0ZvNkguDpPztMTpBxcCCKtSCSZpOeSrsuNcaDFrAV1jvklf7E62hwup+eR2G4uvBJNVqWrmnSZfeo2UlP3dfmnDO0HeROfb1rpXRVz0aF5PkIoNzd2k+EiyBBJIVYkwjQmU/1RO5WnRo9a5c4O6QcCjLe76Uyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967133; c=relaxed/simple;
	bh=ISLLuaAIOwD3fI9L8hjfoPaDT2/sL6cQenYqI86Rzk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWDDOLj5Q7xUoPRAIsUdpeYM3HK4p8tTlqeggcvEuEEprMNRO62Sg8vcn/lqgS8J2uVMZpB+DDF6JdKub1hObW2smYTlg0e8XlG5LN90hJgiCtmG3loQNGKqWCCA1vn/l0OB2VDUfAWdVYZSya0zTff0QYVUa/8KJEY4DUjY2CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeULVs1X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nFAdu8Zo; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773967130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ezP0u+fBRK/LBUGyAtUi77M5iMbp2rxNDEQVpBVAwc=;
	b=aeULVs1XgN3y8ViJXw/zxVmFUVik4hh0yMDxPzrDfdjTLv2kHX8luIfiM9feg8u1cLfCYV
	X9S/0/uFN+GkVSGxa6HnOmans0LeAVAAAKOUyV6OZMLZ+JTApJuJyrYVzYZi3Qia/1hSXP
	aQbgJQula5CaJEfCP4uxSlTdy7qPGz0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-2UEkZcmfM_-S2mUFopIfsg-1; Thu, 19 Mar 2026 20:38:49 -0400
X-MC-Unique: 2UEkZcmfM_-S2mUFopIfsg-1
X-Mimecast-MFC-AGG-ID: 2UEkZcmfM_-S2mUFopIfsg_1773967128
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35a0337930eso1661862a91.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773967128; cv=none;
        d=google.com; s=arc-20240605;
        b=NIkntzWRXjA8gifObcn3SZiTcwQCPGADucFsLhm2yKcTvYEX9cg0Y3YpqLI+FyG6Jw
         4/VZMsNwiXF0LgsjztjoOExPas2B2KC/kM4QcWd9OqB/hjtWtwFuAiSGxVJOuk6VSP8m
         a1dsAHHsfFF9TsZtcWQA67z2MKrtyfY3WLfY34+PQfvjmql7XqwzpZWAFemCUx1xgC72
         cOzPyiDrGpLuU/uoO64an+GCT1qNzi3D4g3AdqkU6rtVcyW2FDCK4mhxNHlyvCVy1N5u
         HZVdvlxCGxiHr+2JKE4PKIDKK6uw/E+kcVeCk5imrblhvuhwcIyoEugoWaSxqAyt4qLu
         VhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ezP0u+fBRK/LBUGyAtUi77M5iMbp2rxNDEQVpBVAwc=;
        fh=f6ZUOXwfRqY0L11beyU7PrlmQ2cz06zmf4hmFl2AfzY=;
        b=eFNjg1ptj8LuUhIGT+PDliQkBIu2CEENah3MhfOlZFDkieCqBdB7qatxuCnO1I2Ny+
         kdO+n25pXpNZfaSKyL1/OVdo3qLA3orFF1t1xAxcOL2aS4MmuM42WtwvWPdhcuiBVEGp
         vylWqdD+vQdReB0uUeH+ECst5Mx5G9J7YbZy6C+zXPqsD081kR40iZjq/7iYyPePZAiO
         Xxv4BtLN/J0XCn0rB7OEMQcFvOs+csW+30TbxPIHD816yOpE4JyKjzatky2sGlnhv8m2
         2QROWW10FlhC30lKa6w8EJjDmLKFJJAaDrAJ5C0xquXPGoVupflTixsaoB8FaoQxsWID
         qf2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773967128; x=1774571928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ezP0u+fBRK/LBUGyAtUi77M5iMbp2rxNDEQVpBVAwc=;
        b=nFAdu8ZoQxe9JGWwbnFgEGzylTImgu69c3EtmXaBT7asvw2eTjOdOoYmwC8CJ88pI9
         txFrk92VdurpxF+FPAfL5Tlp5vYqI46CAxANzOzR2ZubVCCBDbBDtPvORjMV3s2iXcWW
         BHuPm9pXMW2u901uLJgInPPmCF7rvhVe0+lcNdMW+KVx33TuloZYVR8t8cxl1keE8WXW
         LzedR2teMIvpslC2tgBWKTR1L5bDVSVl+GHzHWM8+rQj4LrkJHuzq1tAffKhk0uJIZmK
         rSFTUoPZcIod4fkPfRBr7wmMRdVuZ3uTeMVey5V4a6xAUKjJQ1S6FHH3dqTWERae6K0Y
         Rteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773967128; x=1774571928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ezP0u+fBRK/LBUGyAtUi77M5iMbp2rxNDEQVpBVAwc=;
        b=EMN+HMQNZK0FKLySFDnoHRyIyjdFlLoPcrAn8esAW0UHaSK8jAbCZyCc5KfRyZIIY6
         +vNHv20xVLC4Zhu59N3BX4DmsWNniwKB06JWoycg2SqzPbaD18TKFmbUunRNVYy5Gm5V
         n+LVHlt8FcIahaAHa1CCxp6e+UUHgZCx71MRAeqEBY4XPmqQJ7wINKHiMjh2pGeduQ9B
         9YdMsoZS4OkkerKb21y4acSPjB1ZXTKksFmUVOpKKpqsLF2PknaIsVf0csu83zKGDLTx
         t0XSBkxyKBidsIf2w8D34IJkKylMp8ypgiZZg7a9gSaGQ+fAYpZvlRb1LXJi4XXkm4Rq
         o9fw==
X-Forwarded-Encrypted: i=1; AJvYcCXgjactHhej/m5JRsP3Ckr8ufYeXtzqKSipL/ACvofqFRJ+28VN4gDNnzQk5Fsoaw8/gX1bqak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22jS91sLf9HcwjtUoFcGsV0OBMmf/gpZd/rDfNcLJiSNTBLzu
	cjhA/xtPz4K2RzGcNRtw1VhN0LoSNZemEigUJ2QYIrXXbnEF26417jRc9kubmY78NEH4O/71tkx
	M6Gh1s+xzAEyJxUwI+DPCcqAvT7Uo3DqXmth6ntrcTGAYdUUA8o44tfFIBhrKvOhgSJex8W7yPW
	XlKiJ4EXWrTk4M2nxPx9kF+MRIEvelDCuj
X-Gm-Gg: ATEYQzzGIunyzQtlhtPyfKfAqpkaCQgrQB7qb/UeY4AiX9YWMZZvnSLOqJBK8OGvMgs
	OOMLA0KkF/IcIOgV14N3x+KhLDL8YmcaSnbuwxccYYzDE0usj/k+ykv6eUxo/OW7+6VLLB9QBLb
	vkixDt+9m+R6aPJXaQ+obmVuL/Ni80r8HEA2VfW9bYTKLOmHPWpwTWzXcTQF0hFP9t8I+yGy1Cg
	tCUdw==
X-Received: by 2002:a17:90a:e7d1:b0:35b:90e7:c458 with SMTP id 98e67ed59e1d1-35bd2bba0admr840872a91.3.1773967127733;
        Thu, 19 Mar 2026 17:38:47 -0700 (PDT)
X-Received: by 2002:a17:90a:e7d1:b0:35b:90e7:c458 with SMTP id
 98e67ed59e1d1-35bd2bba0admr840853a91.3.1773967127303; Thu, 19 Mar 2026
 17:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
 <20260313075930.105466-2-xuanzhuo@linux.alibaba.com> <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
 <CACGkMEutuueTx_QhEa9gV72NYTqaGD=69YvMKG=RcmEfdrJKhQ@mail.gmail.com> <6be7d6f0-08ce-466c-87cc-bc2ad3f26aab@redhat.com>
In-Reply-To: <6be7d6f0-08ce-466c-87cc-bc2ad3f26aab@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Mar 2026 08:38:35 +0800
X-Gm-Features: AaiRm51Cgmr_6KcHsvMLEhMg1ooE2wNm_OXHGeR3ESMy6iFQsh2XE_XRq9XTcsI
Message-ID: <CACGkMEvTXpQ8pxL5DQjWeaJPMLP9X3=c5=hc-Geoj1PSZ+_sJQ@mail.gmail.com>
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Paolo Abeni <pabeni@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269734-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,solid-run.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.873];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2E2072D47A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 4:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On 3/18/26 5:11 AM, Jason Wang wrote:
> > On Wed, Mar 18, 2026 at 12:07=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> >> On Fri, Mar 13, 2026 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> >>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> >>> index 75dabb763c65..48de4a16a96a 100644
> >>> --- a/include/linux/virtio_net.h
> >>> +++ b/include/linux/virtio_net.h
> >>> @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct s=
k_buff *skb,
> >>>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->=
gso_type);
> >>>  }
> >>>
> >>> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> >>> +                                        struct virtio_net_hdr *hdr,
> >>> +                                        bool little_endian)
> >>> +{
> >>> +       u16 hdr_len;
> >>> +
> >>> +       hdr_len =3D skb_transport_offset(skb);
> >>> +
> >>> +       if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> >>> +               hdr_len +=3D sizeof(struct udphdr);
> >>> +       else
> >>> +               hdr_len +=3D tcp_hdrlen(skb);
> >>
> >> Ok, I think this depends on the logic inside virtio_net_hdr_from_skb()
> >>
> >>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> >>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> >>                 else if (sinfo->gso_type & SKB_GSO_TCPV6)
> >>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> >>                 else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> >>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> >>         else
> >>                         return -EINVAL;
> >>
> >> To be more robust, I'd suggest moving it there.
> >>
> >> But I have another question, the logic above depends on the headlen is
> >> correctly set:
> >>
> >>                 /* This is a hint as to how much should be linear. */
> >>                 hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> >>                                                  skb_headlen(skb));
> >>
> >> Is the headlen guaranteed to be correct in all cases (e.g for nested
> >> setups or dodgy packets?)
> >
> > Speak too fast, I miss
> >
> > hdr_len =3D skb_transport_offset(skb);
> >
> > This is probably another call to
> >
> > 1) Move virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb() or
> > 2) call virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb().
>
> It looks like that the above leads to more complex code with a bunch of
> additional conditionals, which possibly the compiler can't optimize out,
> and IMHO not nice layering violation, see the already mentioned previous
> iteration:
>
> https://lore.kernel.org/all/cf62a942-e1e8-4b37-837a-b0bd76297656@redhat.c=
om/
>
> What about instead simply rename virtio_net_set_hdrlen() to
> __virtio_net_set_hdrlen(), virtio_net_set_tnl_hdrlen() to
> __virtio_net_set_tnl_hdrlen(), and add explicitly mention in a comment
> that such functions must be invoked only after virtio_net_hdr_from_skb()
> validation?

Works for me.

Thanks

>
> /P
>


