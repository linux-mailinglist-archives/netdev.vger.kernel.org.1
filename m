Return-Path: <netdev+bounces-252431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIA9HthQcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:31:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C069FB5
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B0F03000FE2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B13DE808;
	Thu, 22 Jan 2026 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dm8qy4zt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A43DE35F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098461; cv=pass; b=ZSmgpynKV97EC/lE3LEsatOhCsQ3dPyTU/BNn9JWrzPemvYg4PFT1NXulHCDtQftsJXtn9L64V7E2l3sg8UZMVeYj4AXJgS0pX8nLA3oTwLm+Ln8XCHYsFDqsmTOoqLA4REicYv9KUOVy/gEyRIYE+fCtoBUQnFKpX3k/Tpolrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098461; c=relaxed/simple;
	bh=DMMIT4OBOGCSABOIq/HSUVkir6AqQt0iZ7vlBLj9du4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE4qKvNUIXM+tPJLyPEAYWlXpaQUZTscez/LOSiTTzXHJSnmBnZOwTp1Q4ombXGSPAkWVQCLGCKrBXyEinvCWlPahQmBlVJHK64a9pEJp2Pr8cRt8q/QO3325OepneDG/lHBueW+d8/kutYCgW35zrep+5XLs67cBDEmb957+mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dm8qy4zt; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5013d163e2fso12475211cf.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:14:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769098447; cv=none;
        d=google.com; s=arc-20240605;
        b=Iw3BOyCzgV2zl+zcyrZjDp6P652GV/CtsRvoY4vXSeHiuzY1F/ZEgSAzYEicOZrpf8
         fo/JzIEPPM6YFDzQx9jsQGxFcXz2k2GY+UtsEjqm5BJLLKJvj7AS4Hf8Yo1zZe790WKV
         XzIUPiLZ2Ujvs6+v1JDNJACuJtMHnyjbRyZMHZlTFb1xRCOA1lWCh4JovFRfQGa8dPLM
         2+voB6pmW1DAsHs65Xwyiazf/Z7YnaNTO/UJEVvHiBBmb6n6CuhQM/Zmrt6VgF/ZRsC6
         sMXBujkj5g3031yen6EfVyq+FInOOZTVJxzXAe9Y/E9FAz64sYREUQvDSxPl02y6QJoQ
         t8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6muVKn0SpU0orx+YFCCOdy33OaYBtEbvdotyL/4ShE=;
        fh=/C3D6bwA/9nbO+b+fbeNCxuXO+8+Mw+etWT7MXbhw8A=;
        b=cmwd2ZuMd+y0ulEuBf3Z4r5+JpulbfbZ4mJC7zPwg4XGvV8CmCz9qb+eOHJBYJEzOB
         ngA4wmvBuz8u4rB68pXlcUvKONhpVsV9I0cwjARFZQLsGI56/v8nd0uMhq7hvC3yUnyx
         vO6ex9mUPo5TZ0T7c8zs51l9fHUW7SoSQEPiHkjPKOi3wnJ/Zo1CKMu/Wza7/Nz88Byv
         up+K/5PBTj2ke3NXHd9bXac+v/pMVaU3Ay9o7jmL/8MUSJwa+ZR/aKppHyOU1RvvdgVt
         l3xBJfETL6Y+7x0jWeU6K8K+tuUaJ4TutoLouLsw1CW7jh5wpwrJkCl8F0mu+t2BK/RH
         uR/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769098447; x=1769703247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6muVKn0SpU0orx+YFCCOdy33OaYBtEbvdotyL/4ShE=;
        b=Dm8qy4ztv0HPu1sQquTUM0VNAHM4en6p2JJEOcwPPSbFoLrt4vgKx5DgvAbKu4F3zW
         GeFMIigvLqfR2P/Av0/oyrPwsHvsGoWEjeQFkfRg6Xwg5IQO7RqCKGjU6sjD3GJz5pin
         lC4b8R9YOFMLxIRYQjTsShoYxz5wdZwTj/NwEiM+kMFpF17qDDKQ/S6e9AW25UxO3vwQ
         KowBBK0uemrZsGRNvQCPHmvPX6YT+Axn2bONIFm5BiULvRmzHiOXm6gD/S2v0ybGL4oK
         mgtQUb6FoH8uvyDqZzuIcvdz9ZqLX+PR08WUZBqtOFCbwhbYJMwiu2tZIOKagUY/BpEz
         rrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769098447; x=1769703247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6muVKn0SpU0orx+YFCCOdy33OaYBtEbvdotyL/4ShE=;
        b=PvKSeqBcbVbjT8uAFJkdh6gJCjs26kcuhXG+B0farFJgmumV+4LgQXJuyi2mx4twiV
         f4VcLPT6oybkG1dW2Dxfomnb0/ghHw4HumwpwEA/jjqJioNlFjdBPhxarEfK0OUrOqtS
         zdr15bBaudEmn4wNt97hzdDIAgP1MjmT0WKMqtbLZXHVjEV92+AaxoKsdqSHtrQ626DC
         icHXg3aKH6DD87lp1iyLpp2FTdhBG97RL7knL06s+M5jiUSqrGHM+BnOZgsYkawp6KBp
         Uyb6iJjTOpi7k/0Me4i8s8sQtW3yy+2jFHKTt0gcwxXnTlBEXJUaMYRxIGEQ/uYRIda6
         TsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpdTiTXbRUrf8aDKYJgyfpTxx52caUMgIvv/RJhXbfomEjD4ooEL4ZyjOGxIr00xy3GJiT/Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRRc9wLDNyZNh3Va5EUvtoDC7pGWFJOTbJi07XW3j8XUMNuUF7
	2V58UsrZRu+V9SMI0xQ+4pqcoboT8Fh0QWGmWgqixTJkdUUDYymNqFNwEcuvBO4CqOsTf7Bm4f6
	RPyHlW0vUH5nNL65+WN2wrG0NZiS5sPzV/0NVNOLd
X-Gm-Gg: AZuq6aIp+TyCAAhj933p960bp5Uyag5HjR0Q6i2vsgrfs7GcXMbexi3k7B2rjESFqpC
	TlkhC/dqhM4aEkxX+YpUzXPEfdKIhaqCi88RW6MHgHhJXQZhtEypHvqTUGuoQTMz5mOvG+aR24+
	8GnkRHBsYzmH22LchJyyDHkOIM6QZjV0DO0uQK6FwTErti68r4G/RxfgHS3Wiy8+3QFMEUiZHKz
	7xQ+wyG++lKa1eHqm1huG3YINkARtq5AAUfQ68ZVSL/rTrBKAMyPmvcQVEdLrBRHhn0WUnT
X-Received: by 2002:ac8:7f49:0:b0:502:9a98:34cd with SMTP id
 d75a77b69052e-502f7764b86mr979651cf.22.1769098446887; Thu, 22 Jan 2026
 08:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122091527.339180-1-schalla@marvell.com> <20260122075206.504ec591@kernel.org>
In-Reply-To: <20260122075206.504ec591@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 17:13:55 +0100
X-Gm-Features: AZwV_Qhok7oKZjawaEjN94P0-ccBoOOH9sRA_7UQ4L2cNNkzKf_7jQWnXt6qA6Y
Message-ID: <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match NETDEV_RSS_KEY_LEN
To: Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, pabeni@redhat.com, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, ndabilpuram@marvell.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252431-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[marvell.com,google.com,vger.kernel.org,lists.linux.dev,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1D2C069FB5
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 22 Jan 2026 14:45:27 +0530 Srujana Challa wrote:
> > Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align with
> > the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LEN.
>
> I've been meaning to bump NETDEV_RSS_KEY_LEN to 128 or some such.
> Most modern drivers can't use netdev_rss_key_fill() either because
> core generates a tiny key. And the devices support hashing over two
> layers of IPv6 for tunnels.

Seems fine to me. Back in 2014, RSS was limited to 52 bytes on all known NI=
C.

>
> Willem, WDYT? Is there a reason to keep the core key small?
> Or deprecate netdev_rss_key_fill()?

What do you mean by deprecating it ?

One of the ideas was to make sure multiple NIC would share the same key,
for some bonding setups.

commit 960fb622f85180f36d3aff82af53e2be3db2f888    net: provide a per
host RSS key generic infrastructure



>
> > The virtio specification requires devices to support at least 40 bytes
> > for the RSS key size. However, devices may support larger key sizes
> > up to 52 bytes (as reported by the device's rss_max_key_size config
> > field). This change allows such devices to work properly.
> > Previously, devices reporting rss_max_key_size > 40 would fail with
> > an error during initialization.
> >
> > The driver already handles variable key sizes dynamically through
> > vi->rss_key_size, so increasing the maximum limit is safe and
> > maintains backward compatibility with devices that support smaller
> > key sizes.
>
> > -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> > +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     52

