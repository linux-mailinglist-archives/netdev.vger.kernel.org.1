Return-Path: <netdev+bounces-267816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEZgOimitWk02wAAu9opvQ
	(envelope-from <netdev+bounces-267816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:00:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B0128E5AC
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087283020D5D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4C32D42B;
	Sat, 14 Mar 2026 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sG8KNhoO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2B329365
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773511207; cv=pass; b=rPtA3K3ftLr+92ogXyNWUkJu96PipsmqQaXTi5ZR9I9dfKL+MKo4cMsPGt1+lvPMAJ3huInZ43li6qZjgnj7WqMjBAJdxczOQkkup9iMl0Zo3g5IvGFjg1nVgtUZeCabRUv3tF0L395MJZixObRr0v07afIcd5vCRRG27Vko3Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773511207; c=relaxed/simple;
	bh=2vl1lVHTgJoitgWCyF/or5qAvKiZIieX1PT3g2+SW/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDzLyQxRqr8BKhA3kCLqeTeoXyyu26K2OZqxBylGfTvYKw4I6pY9kNctmQaHaTWCVbCC3BQ5JXrNX5ELpFE7l9Lk+mKatubiM+JxWZRzHuKMBW04KwBgV7yTJiBI3NL5HTMUg9+gmancZACtvJ9yQFtnDd88G5bB8iBSgoOsMoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sG8KNhoO; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899fc9853b7so42723006d6.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773511205; cv=none;
        d=google.com; s=arc-20240605;
        b=B0NolHZqK9fS0bVdalFwWKfQf5mjs+h9Zm/c0YYqgU4f+SfY2HEo+CJnIzFyTOpCF3
         VVpqDEZdB5wmqmg946n/IaTwHYI80PRJl1w1pZxA3/ug4gK4+o4SKmb+hOcZ//bM8Izt
         L2RDoKlrz9BZDsAeqzBZqFVtzBWzUFdkrgTSDzcmq+CxAKj88H9BbuhqxxKGK4VjfBL/
         89aslmAj0FEEqSMNXy4Q1VRnCK+BJGa3QGsR05qXBPz0fNMjn0654y5Ey3CCO3QhcAbW
         TnRZYWJiLFYMdHKwLLa0R8PCu5hjNtAxBtT1mAqCx/+LWhv6Ku8zqxje1EkiQKNSo5cu
         o7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CySx8YZL/9J+9WVfyj5OkZXQdOXff5KPmxsBQSlxXWk=;
        fh=Lzfw2YJZbfUv0jHtzSGqw3H5dtPiL6UCRzbECaH2ZyM=;
        b=cW39lm/IZGSqfLLEcKDlO18IU9AlBo6Rp1vH7K384Mh16qQdxfa59r4luGHUzC7zvb
         4X2MQVbzoG4v4A1Zwcx98ANcjit6qkQfUNSoIsLNaW8sSxpupw+Qh6DOLcgM7h6Hg2x2
         VFSAXmOpX9KJ79L6rqYtrAqGLrUKFHrFSYAZyEYkabOH6bYwqbKGGExrSRwyB+rbC3dH
         wkUvDd5ecHG18Unfgm0eitK/BP5mpq037D0VBnKf4/YBlskVjt9Cwg1U7Q24HkFNgx2p
         d9h32c+EZIzo+vrXR5WTj3+MK8yumd1w0WK6vQOW0nVzspQuxeeDd+dMrrTpyO2qtr3q
         wQlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773511205; x=1774116005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CySx8YZL/9J+9WVfyj5OkZXQdOXff5KPmxsBQSlxXWk=;
        b=sG8KNhoOQF9+T445TRSULoD2ZmTKLYjj0W2VyVVUfzlf3vM7uPsBCc0hqIqC5kGZjJ
         8N3fjzew3dHBHsFj8oOviOgMIXoGaoR9HcYqp88+hzAOqptSLbgSrZGIGgZex0LV3NpN
         ROt1T+TRDBwILd9aRCAgSkxCgz59ouW2Puj6Z8g/sa+G149G4hb3h9HFbDSQAe8v9EbG
         lRn9BFVto2XKcfv1xdGGr9xqfKhrnMyAl9EC8QbBdKqGblZoasHlErE6mnS4WX6LIbL3
         LEqhuuBmioKUcY5QnkaBsDBR28p0HhTHqDeb2vFs/gn8EAMA/nJ+Ae6EQo3HbMWAwZV9
         m3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773511205; x=1774116005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CySx8YZL/9J+9WVfyj5OkZXQdOXff5KPmxsBQSlxXWk=;
        b=bfgmuytn/pR+bML3m7Qksr8hQ3iV9jksYMGkVVnQh/189SOH10Lj2siQ2BdP9/XTSL
         UAm0RywpWEaAngUEyM6sW1cXAZqL/5z7H4xv7lnc4mXE8z/88zHbFCjZInmUJAZoTxX0
         c/iwYqyC30VsKbkbnw8FQlG8H9JFdmUPjSUqECNvkpJuAC9Ekp5u+vGZSXoItBs3q0LN
         AI53HGjuLm+ZkmLC5igdLCnElH4321momRwaNVK0KKaBHWOYYpORFXTFPCUZApeIN1xv
         puEM2jl7Or17ubmnywrMc0qz9HTutweA8Hca2XQ6fZ9EvCnzHhdPZcmWGhf9qLpMIhca
         g2RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu5UztWIlkXq89U9KwiOGbOEqusfxYHJTWIpKIAHFIfFTwBdrGP4qDVso1MizXnqSWsetZbsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkR3YfjJG6RhGlzr5yEfCNTizFNeCOzaCti2NY1o7ZDfAFEna
	2Jv6E3cTgdccitRaNrb0tpqLKs6dFYOkkxqfZGEIBOCxqcmVvx3cvnswsh/hXbYTjZXLc98zCgP
	DQfSFMw5nxoTAu40sOX6kvDiZV68hxxn+rNL5OCdekGvZBX0cVLKep3Nj
X-Gm-Gg: ATEYQzzEXUEi50QHhZHiV2QWopIAFWCb5F/OPr3xEFNaQYgGQ+5Yx2b/ZxohdEtbtFq
	VO8GMzDrT4NEh2XsPPGnlbQo+xhq7razzgJeXU7AIdneYvaXN687MwoOxZ1wzCeM0C/UUWnKHNq
	YleUlms0S24zxPrnvN6QVa+Am0tgUI32gT1zwq4pvsByFiHrhnJzhOiw2FhzHMg0p5o0xqMQP8A
	p0+IQoOdU4MbuThzDO4VzKAA561NSgc49TGbQikV971W8WZelHVjE5GC6HFtq1wgM7xEDY4wt6S
	PMezA98srMtq+1vjHzM=
X-Received: by 2002:a05:6214:2529:b0:88a:589b:5db5 with SMTP id
 6a1803df08f44-89a81a0e7a8mr110184706d6.0.1773511204780; Sat, 14 Mar 2026
 11:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314115650.3646361-1-edumazet@google.com> <20260314105036.4d8bacd9@kernel.org>
In-Reply-To: <20260314105036.4d8bacd9@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 18:59:53 +0100
X-Gm-Features: AaiRm53eMAXsRx9arwG6z_nTyuCFcL6H_oEM5U53Maf1hHmgJX2mqx86IUnxkas
Message-ID: <CANn89iKdhpWPoeCdx1yK=D4a5A1GfwE8Y+qR2tn7jz2xtnUVew@mail.gmail.com>
Subject: Re: [PATCH net] bonding: prevent potential infinite loop in bond_header_parse()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jiayuan Chen <jiayuan.chen@shopee.com>, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com,shopee.com,jvosburgh.net,lunn.ch];
	TAGGED_FROM(0.00)[bounces-267816-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50B0128E5AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 6:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 14 Mar 2026 11:56:49 +0000 Eric Dumazet wrote:
> > --- a/net/ethernet/eth.c
> > +++ b/net/ethernet/eth.c
> > @@ -198,7 +198,8 @@ EXPORT_SYMBOL(eth_type_trans);
> >   * @skb: packet to extract header from
> >   * @haddr: destination buffer
> >   */
> > -int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr)
> > +int eth_header_parse(const struct sk_buff *skb, const struct net_devic=
e *dev,
> > +                  unsigned char *haddr)
> >  {
>
> This function has an (entirely pointless?) kdoc
> You'll have to update or delete it

Right, I will delete it. AI really made these comments useless.

