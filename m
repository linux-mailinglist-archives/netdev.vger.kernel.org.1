Return-Path: <netdev+bounces-265152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vBNwOcJVrGlvowEAu9opvQ
	(envelope-from <netdev+bounces-265152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 17:43:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D67522CB6A
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB9D3017791
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5ED3A63F7;
	Sat,  7 Mar 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuzzSMKP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A752D877D
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772901822; cv=pass; b=g3AQo3T8InXtRJqVEwkJGgSmWWUvP9jrgvAYKUnw9knZzByFXehahlYIZ4SmY8s+Z7ckY88wGa6qt70KCfl9aetpZYL3D6neYzzWhTKs8BOtIINQo67i9WkCxbtraKLhDDLMcLEb+03AE208UjNTkn84AlC+4pMrzx9nxSvfBa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772901822; c=relaxed/simple;
	bh=VmqsC2ZOzAjEDREONaQ5bo5cteXzdyYDPLla5Txg7ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HS/U0w4X+62EexCaM95KnDK/DRsaw86CPweN2hT7dGfdEcBtel2jKU77RSDAu4LEqpcy7q5ARY+JBptS/O33ywIrES9BwPpiGJD6cJlkkQ7rb7k+zcr0HgSJX1tGpnPxIyp7JE1oQO+wgKVm8i6V4Di/QIW4g6Sz6FHEupYpqPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuzzSMKP; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89a15b9a556so63049866d6.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 08:43:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772901820; cv=none;
        d=google.com; s=arc-20240605;
        b=lLgd3DzenPY2hbooiaqO7mm2Oz8sFPWGteeo/Ix/ct5NmC468njt7DQSpXKQFzKVda
         0TZ+tUgt0R1CdWOL09qc8xRvfw4xR7HdfFiY9tjZquTeuaJbF/jip6gSKVBFdmQdKnkX
         pa/Ho0W+FihpKTvakunWjo7apqzVPteZ56TGFmZ9B8BaATf94pz6K+6RskfVB7P5OFGa
         d8PgzJH6MqX6NhQyknAorQ7U6YJmtEI0fJ12ah6zLM0ntc5e+KUDKh+cbOpllc3Daov8
         n1/If9aSAus1n002fk6z4sy6OorndOZzGCREFlggmsbxLOqCjIWc6m3CBXYvVdKZJDbd
         jRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eKgpUbrVmNyMZC1IB7c4wRi8BzaImvn4akHqVzx6BS0=;
        fh=vwaMzn6kl2t1J02FMQDJSAjjXGnSI4nUITAvDq1UeCw=;
        b=f8DwL4/zxPH6XTcdcqjJvEbf95akoQH5oCQFH8F4Hfp4+M4uw+XtzM7+klW/ma2E0q
         lOeQ0CUoPex6nj8M8i0nsujVLg22+2u1bUOJpPwcqumSX3OGSSpxikeu7O0ryANQlMM1
         OYBmhMfW/sKCoAxWRKdTHQ/9qlN9vQNddZ+EvmhUB8h07m4wJ6gzSe9a2zBpWGFi1rtP
         a/escmPVGUSDGndITrauXLOe5N5VCjPsTtUqehMt1NlIJ2j5/IJu0WMdvIk/HeRdZu2Z
         47ixo5+QhUYkp8ljhoz2CdZvFBLWuVhH5Xj9m4kflNqgoPivjU/sx6Vq3ZMJhdXnVHwo
         JVig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772901820; x=1773506620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKgpUbrVmNyMZC1IB7c4wRi8BzaImvn4akHqVzx6BS0=;
        b=BuzzSMKP6osZAlzhncIR1mngQ0nUDBKKoZsu7+47nTYysDEXT8M+GI0XAK986WagMq
         LPInWFvIGOFoe78i9Z2SPtwKU5bia4pLsGRVvOmKCre4z0zGo031OoOXw345eLZXM6HI
         nHvU9pQxUQO+C3hKAePC40ZqNqGbNrvPjjv5tR2mkTLRVmnAYekLZGJBGiwQbJVjmcv4
         3zZ1xGp1RvQG5LcKVWngkFBp1zD5kxT4Or+wqnut1EJZN6RvBB3Ou5bX6FuTG/inYP7D
         voF0ikCp4cWc79+8ONtGFK7HKomKrR0BWIdOnEkN7PngqjVgX94naenuUVCsHF5p3715
         jM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772901820; x=1773506620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eKgpUbrVmNyMZC1IB7c4wRi8BzaImvn4akHqVzx6BS0=;
        b=NQPU/MYvcmE5sLx45YgAbA+rt+0Vk+KhIRS2Cc8cxdD56pqZH55uYxvZOUJwndQpK8
         pj7vvwru/w3UyaTy5IbqeK0e+f5v8NJTp3vXapEc9Tl1h/nSCqgI5ChdMXoZTd4H+zRp
         EWBrD1od/GRWlqktPVPYUXUteRZAnc/Dl9bHET3/QSvHLeM3ZwzogzDl23H9gXZn9TSM
         G44XFlwIDQ4vTtU8Y/VCgaAz47mwQJna0xpOdQoeWtOrXJJyVG4jkwPvZ/2BVxjzHAZc
         Ab1bO2vVX3GMwR37Jb/mac1WQlcAGrU9jiERhoVsEse+xBKnjX5pk+snzYn+7vRo8sGH
         7wkw==
X-Forwarded-Encrypted: i=1; AJvYcCWLYrpMlgVMUweuoQohS59q3NNt/GuKeSgfC8on6fK6tXAmjjAk+eOwd73/Y2AjX9RPS1zia20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBB8iaQo5W+pS0nxFUo0LJKEViGSiYA8xE+73v2+uL9EcGMpE
	CNp76/BgoZhTY5SF+Ayxjx1mRYLUeDtQ0mFAGx4a0fyXowpqkYbILjEpgpxqtoDfp+RvEjz08za
	melBV4zJ7eJEUWfe6vAZKr/55eVUVnCLa0SKjJtyAGJcpVziNhYikYciJAp4=
X-Gm-Gg: ATEYQzyKh/O6vFoh4SaJo9WUwFrAUoQyaO3vKn+CxyfcNzd+9X1R0u71Er+hzZ9irQT
	ICLe1rz8qZcMa63SbFAoMdVXxLZOWLjnKq+PqRC5AULudxoodnYL9VKCBk7LkbFGd4qqoiyHpOd
	GFDCkU5rs+f01WWhxlfdKJORrDIfYKRbRggSAdARdTJlxFhXVbyekwFF+QrPIcRxlERgq+cnsZe
	6Ha4UPFkZvwjaPTAKdhgeoXzXe7o7eorwen8SR97XpVwQB8oUuWaK+7LebzjhqHC1p4wPuLe21d
	aMwo2Wae
X-Received: by 2002:a05:6214:d66:b0:899:fdd1:4a56 with SMTP id
 6a1803df08f44-89a30ace6e7mr85307326d6.35.1772901819868; Sat, 07 Mar 2026
 08:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307162905.3697050-1-yss2813483011xxl@gmail.com>
In-Reply-To: <20260307162905.3697050-1-yss2813483011xxl@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 17:43:28 +0100
X-Gm-Features: AaiRm53CZNV-mygWIm42S9O0nG-0dyvR8SzJXSlTsLpzJ5HwwjVyLtLpA6EKJ4M
Message-ID: <CANn89iLYGsCr6i+rP13nq8H8H1pT6h=hGDn+kds0js6v4gr6Mg@mail.gmail.com>
Subject: Re: [PATCH net] net: clear mangleid_features for SKB_GSO_DODGY TCPv4
To: Guoyu Su <yss2813483011xxl@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3D67522CB6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265152-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 5:29=E2=80=AFPM Guoyu Su <yss2813483011xxl@gmail.com=
> wrote:
>
> Syzbot reported a KMSAN uninit-value warning in netif_skb_features() [1],=
 which originates from gso_features_check():
>
>   BUG: KMSAN: uninit-value in gso_features_check net/core/dev.c:3804 [inl=
ine]
>   BUG: KMSAN: uninit-value in netif_skb_features+0x6fb/0x1870 net/core/de=
v.c:3828
>    gso_features_check net/core/dev.c:3804 [inline]
>    netif_skb_features+0x6fb/0x1870 net/core/dev.c:3828
>    validate_xmit_skb+0xb6/0x2400 net/core/dev.c:4003
>    ...
>    __dev_queue_xmit+0x3016/0x5a50 net/core/dev.c:4795
>    packet_snd net/packet/af_packet.c:3077 [inline]
>    packet_sendmsg+0x91d9/0xa320 net/packet/af_packet.c:3109
>
> SKB_GSO_DODGY marks packets whose GSO-related header metadata should be t=
reated as untrusted (for example, packets injected via AF_PACKET).
>
> gso_features_check() checks IP_DF through iph->frag_off for SKB_GSO_TCPV4=
 packets. For DODGY packets with untrusted metadata, this may result in a K=
MSAN uninit-value report.
>
> Handle such packets conservatively by clearing mangleid_features when SKB=
_GSO_DODGY is set, without relying on iph->frag_off.
>
> [1] https://syzkaller.appspot.com/bug?extid=3D1543a7d954d9c6d00407
>
> Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
> Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68e4b5d8.050a0220.256323.0018.GAE@goo=
gle.com/T/
> Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>

Missing FIxes: tag. Please help us.

> ---
>  net/core/dev.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 14a83f2035b9..9b19154b6f7f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3808,7 +3808,12 @@ static netdev_features_t gso_features_check(const =
struct sk_buff *skb,
>                 struct iphdr *iph =3D skb->encapsulation ?
>                                     inner_ip_hdr(skb) : ip_hdr(skb);
>
> -               if (!(iph->frag_off & htons(IP_DF)))
> +               /* SKB_GSO_DODGY packets carry untrusted L3/L4 header met=
adata.
> +                * Avoid dereferencing IPv4 header fields and conservativ=
ely
> +                * clear mangleid support in that case.
> +                */
> +               if ((skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) ||
> +                   !(iph->frag_off & htons(IP_DF)))
>                         features &=3D ~dev->mangleid_features;
>         }


You are not really fixing the bug, you hide it with another.

Please take a look at qdisc_pkt_len_segs_init() for a hint.

