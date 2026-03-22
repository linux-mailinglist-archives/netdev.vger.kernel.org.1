Return-Path: <netdev+bounces-270288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ESZCzRQv2lU2AMAu9opvQ
	(envelope-from <netdev+bounces-270288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 03:13:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB642E7F21
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 03:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006253013A4C
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 02:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81BC366062;
	Sun, 22 Mar 2026 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErhrGH4X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65994311973
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774145556; cv=pass; b=dchyyw1sTCbqdEKP+wG3hxho0+lYo0CK2DeerCHyicQxm0bGHfCuC2+IpUKitWBUWx9Qd1v6H2pJ4MAfc2zwSv8lP3iLpBHbnPjJeSbdrZdjzunqlcWOI1Z1V56bXnw3gefokzlWJVPml0dUukWRIWl6p2EHgAulbXSKat9Bjhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774145556; c=relaxed/simple;
	bh=6fD/q1Qsxzb/jb2kkxpS1VnijIUcf8B0ptymLmzk210=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR1wEcJYM07kHSJ0EOzsNRiP32hwNBwA9Xu11Jpbfx0DGLsvn5OE+TdlAw7ubx53s1CKNSutXUUBmHGJnh8EylmXExomqYJdNqfTc0X34+x8OUblszPBkcEAyhQ2NooK1zT2E0ts/LZvB8eZIoG3r3ECmzAIxmpS+fUgcEkAtw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErhrGH4X; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66966a394ceso991238a12.0
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 19:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774145554; cv=none;
        d=google.com; s=arc-20240605;
        b=bmAClcjVDSEUOx0U1TyTiR+BZkUgyjv3sNgUTqPTl0O1g17TInY+riJatdHGu3eqWc
         besO44YLkGSpKjEFC0jpEm8iSWN2lhowB2kMxpAhfHdXle3LCRQlm0/kDSSI5OhDFuOZ
         Nb01bahYI/Ny4IzpvlYSOmzJ6MKoC6JqJNY9btDsasI3Nr/LsU7z52brll4d/LANLC80
         i73g7qDTLAhZxaXil0wWJln2LdC3zU+VGifm2IGPW+cX1BK4WurUvAxWeBTQ/vYX2Uw7
         LvonoBcllphEY6RaC7OIKqjHOmV5ILrzXpvtAneP5oIHv90/BfwjB+GQ0fCcJVJsQ//9
         xI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dG3xkxQxc2r4hrUA4bCorikr9wEg+eMEMtsgK/HEPog=;
        fh=5Wc7PWoz5xUe41ZTORwiV8gRRPSenlzg7ww3M4qZcPs=;
        b=Xy/4gogTt4CJWbp7JTlA88MHyXt54pD7yM24y8Pc/LC716c8rU84uZ73aUVTHhRRuc
         OuWO1O05Qb9iayiXx4Ne+gob8mkcVq6CL37IfKJl6GS08vb+nAtQLhUPqjt1J1QCldMr
         vVamqoxgz1SUcW+qD+F+wbJEg9f6DQlV8VgFOuiqLtwnee/xRXZhOlo+s/gLNDb/PSig
         rc3QHPz9tUoU4pT1f3vcYDGjM1xFhQL3djuPRqNI8BR45GWnTdJftYSQxRCb2DY3I9Tt
         p8mLidBAfYKqrwvIqfO+gPN9e8L6DFJt3/sKbFbbqmHiycFhJCZS//v07Y2ZJJGbSXO9
         rklw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774145554; x=1774750354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dG3xkxQxc2r4hrUA4bCorikr9wEg+eMEMtsgK/HEPog=;
        b=ErhrGH4XH1FnoWq5mmvdifLLo3D1A/BTfhuk2skh3aXpqAaPsBvH1hgIFpUhIv6YKp
         HFFypYkEc0m4Tz2BTyLB2csQtsbpwzZTjuuI5C9s5nj6UukfhFhq5q6w3+1iA7vnl+L5
         IH0TLdrskZF3jGQMsKDZGIuzqTFuQowMF6q3uVJX0i/khpDLRiuYHI8ABxrV4ppJ2Oh/
         SkxznBiA5XXSyun8Fcr4WNYA1XiW6BwbfL2ZKW5p4g/2ovut3O3cWDIyfh8j38pJXcOP
         lqp2kQCAkYdrrzhxMiShNcrLRqG1Grebpva4TwsuGYC/pjyFHfHMgqO+O0LlmiCWLYCJ
         upLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774145554; x=1774750354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG3xkxQxc2r4hrUA4bCorikr9wEg+eMEMtsgK/HEPog=;
        b=CpOeA5FIkoPnES0AfGmvlpkAbG96jnrv8RRegWnN+DPtmjHpkg3cMov3npwRyw8iO9
         c0ETI0sf31olnfxL4vElNpUT2HT77B90c6fXsuH8Rod2ZjZGK/tPpuponRe6MJxBwowa
         YsGJUOeq/bjtPhwF2wh5zPFe2vHyq7cLcJE+0bc/ip1qq7K1mIWII0DH7d6UiNTVWEFM
         7pLGK7XkgF7KtkqU5qmB39el36M5q/+GS/hEUWifUjFPMSs0ddpc91EjxL3gp4HkNkDN
         W9zFv61ZHJ8kAa3crgTYtZYpD9omkxb95HqNxdkmz+6UrcREOuS4jNmT9AEKsDjMEB91
         mRHw==
X-Forwarded-Encrypted: i=1; AJvYcCU69chvlffKoyLpRb8btSHeVkTt4UbkXqBypi1Kq17x8x+fwseFx9mYS/TB6GzwaO4ROdjI1MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmnWRIIVef7jEPbzuRnK8TgovBQPILkOuoqcxhRek5eEQ3kyHx
	MJEgW34DYz0/VqwZ67p/ITrytv+HZG8VpyhglOvacR2BxcnY1/MhaKkb1hyOs2zaYXevGT29vWx
	qPw7Sdakks85Yn555KSdTKDf2ttFdgOM=
X-Gm-Gg: ATEYQzwnnefk8/7gV4cSws7GS2Tg0Rujrezn1DCGUwSQ+jfp88zf0riH1ZPWLMoSxRO
	ZEyQI9btdBxA1/NYc67ac4HSTbqzeknRmsldwDgLi6Dvkh62jLkRkbKfIHSEw/hbjkn7vVr7RqM
	G+KsMVLgYtUhLveTtkoFXU/6MSiyUtFDaO9Zlp4H1Y1BBMtVCMcUaKrR/DS6qyuGSV7XHGOcHbx
	AtAG5oYRE5TnAwhT0dFD4JttI0uk4QyfVuL/wE1GO54LzVCSDag4RgUK45yaQ2icCVTWLRKZoMZ
	7Swl/fo=
X-Received: by 2002:a17:907:982:b0:b97:f8d4:2fe7 with SMTP id
 a640c23a62f3a-b980fb05f2dmr787025166b.32.1774145553392; Sat, 21 Mar 2026
 19:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320132356.63194-1-teknoraver@meta.com> <20260320132356.63194-2-teknoraver@meta.com>
 <1d708196-7b89-431f-bb17-177564196894@gmail.com>
In-Reply-To: <1d708196-7b89-431f-bb17-177564196894@gmail.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Sun, 22 Mar 2026 03:11:56 +0100
X-Gm-Features: AaiRm53ww1-ptJbyTPXmgTKJ3HBDK88IzK0UHxVqUtqlnjypi32Zi5Q0XiIBTGw
Message-ID: <CAFnufp0LRVxwh50cLrg=hUe6itshTqrNy53HkvBWk6MQ7uL0KA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] e1000e: add basic XDP support
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270288-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,checkpatch.pl:url]
X-Rspamd-Queue-Id: 8CB642E7F21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno ven 20 mar 2026 alle ore 22:23 Mohsin Bashir
<mohsin.bashr@gmail.com> ha scritto:
>
>
> > + * e1000_xdp_xmit_ring - transmit an XDP frame on the TX ring
> > + * @adapter: board private structure
> > + * @tx_ring: Tx descriptor ring
> > + * @xdpf: XDP frame to transmit
> > + *
> > + * Returns E1000_XDP_TX on success, E1000_XDP_CONSUMED on failure
> > + **/
> > +static int e1000_xdp_xmit_ring(struct e1000_adapter *adapter,
> > +                            struct e1000_ring *tx_ring,
> minor nit: alignment issue
>

Uh funny that checkpatch.pl doesn't notice it.

> > +             if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
> > +                          !(netdev->features & NETIF_F_RXALL))) {
> > +                     page_pool_put_full_page(adapter->page_pool,
> > +                                             buffer_info->page, true);
> > +                     buffer_info->page = NULL;
> > +                     goto next_desc;
> > +             }
> > +
> > +             /* adjust length to remove Ethernet CRC */
> > +             if (!(adapter->flags2 & FLAG2_CRC_STRIPPING)) {
> > +                     if (netdev->features & NETIF_F_RXFCS)
> > +                             total_rx_bytes -= 4;
>
> Looks like, total_rx_bytes can go negative here since it is not updated
> after being initialized to 0. Is this expected?
>

No, that's a bug. I'll count the crc size separately and take care of it.

>
> > -static inline void e1000_rx_hash(struct net_device *netdev, __le32 rss,
> > -                              struct sk_buff *skb)
> > -{
> > -     if (netdev->features & NETIF_F_RXHASH)
> > -             skb_set_hash(skb, le32_to_cpu(rss), PKT_HASH_TYPE_L3);
> > -}
> > -
>
> The function was just moved. Looks like an unrelated change?
>
> > +/**
> > + * e1000_xdp_setup - add/remove an XDP program
> > + * @netdev: network interface device structure
> > + * @bpf: XDP program setup structure
> > + **/
> > +static int e1000_xdp_setup(struct net_device *netdev, struct netdev_bpf *bpf)
> > +{
> > +     struct e1000_adapter *adapter = netdev_priv(netdev);
> > +     struct bpf_prog *prog = bpf->prog, *old_prog;
> > +     bool running = netif_running(netdev);
> > +     bool need_reset;
> > +
> > +     /* XDP is incompatible with jumbo frames */
> > +     if (prog && netdev->mtu > ETH_DATA_LEN) {
> > +             NL_SET_ERR_MSG_MOD(bpf->extack,
> > +                                "XDP is not supported with jumbo frames");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Validate frame fits in a single page with XDP headroom */
> > +     if (prog && netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN +
> > +         XDP_PACKET_HEADROOM > PAGE_SIZE) {
> > +             NL_SET_ERR_MSG_MOD(bpf->extack,
> > +                                "Frame size too large for XDP");
> > +             return -EINVAL;
> > +     }
> > +
> > +     old_prog = xchg(&adapter->xdp_prog, prog);
> > +     need_reset = (!!prog != !!old_prog);
> > +
> > +     /* Transition between XDP and non-XDP requires ring reconfiguration */
> > +     if (need_reset && running)
> > +             e1000e_close(netdev);
> > +
> > +     if (old_prog)
> > +             bpf_prog_put(old_prog);
> > +
> > +     if (!need_reset)
> > +             return 0;
> > +
> > +     if (running)
> > +             e1000e_open(netdev);
> > +
> > +     return 0;
> > +}
> > +
>
> If I am reading it correctly, this can be problematic (maybe with very
> small likelihood). If e1000e_open() fails here, we will still return
> success. How about the following?
>
> if (running) {
>      int err = e1000e_open(netdev);
>
>      if (err) {
>           /* Remove the XDP program since interface is down */
>           xchg(&adapter->xdp_prog, NULL);
>
>           return err;
>      }
> }
>

Makes sense.

I addressed all the comments and I'll send a v4 soon, thanks!

-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

