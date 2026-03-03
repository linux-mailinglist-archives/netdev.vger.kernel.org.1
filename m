Return-Path: <netdev+bounces-263071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCZpG7WapmnfRgAAu9opvQ
	(envelope-from <netdev+bounces-263071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:24:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 140341EABE5
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58962303B815
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51033876AE;
	Tue,  3 Mar 2026 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+0ZMgXD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz5ZPSTz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AE33F5A4
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526191; cv=pass; b=Nk4NLd1hbmElb/Tdj7C3pWAtJl8AY6Kvo38jmncGHQhF/UQIwHdiOFqbwFGsb2R5r9rXtts7boR/3AZG01Qb02tuigtxRGndCiaa2ouBF+6R624I4WDzvGvIVQ5feM9zDBIC922MLhx9FWoj0+O7bJ+ITDD58oBHNbj8p4/ZbBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526191; c=relaxed/simple;
	bh=FIcra+QdGWbVK7dEeENktNZZV+zMM40tLcIz85kVF4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2O6wnd6S5SzO+tjcgaWOA+17Koo4qXjUT0gf1wQirO/5dkC2blJWe5QYQFHL7MBEuvDUyVa2NMXidP6f60YnedpsBrjfwnWxhuKNPrHHdUA/uTzUj2lVTmpfBK/FhPUhHf9rsGwa4B7WWdpSJOJWoaYoq4JKnRCYxk/Atc3hFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+0ZMgXD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz5ZPSTz; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772526188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bNVvSG62xl9Jk3X2cnvC9Xwc7/DlqVbGbtIj6kzPkCk=;
	b=J+0ZMgXDEEcYvs7FQCr1kSPOKz23PH/ZKwrpuEWRWMzI6Gzq3/dLoPacSiJbLzHc9vZX8o
	lnM423gd7MytN9Gc9LIaL1jTe45Q6/dVAkYm6QE+YAG3FTOjUF3PybF6n2YrAwVFWGM6fi
	9Giea5dxIJWtrI8S9S6nvmHXNRKn4tc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-kTNFLJX-O8e9GfxavyNUUQ-1; Tue, 03 Mar 2026 03:23:05 -0500
X-MC-Unique: kTNFLJX-O8e9GfxavyNUUQ-1
X-Mimecast-MFC-AGG-ID: kTNFLJX-O8e9GfxavyNUUQ_1772526185
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7965223b026so66865827b3.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 00:23:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772526185; cv=none;
        d=google.com; s=arc-20240605;
        b=RkZRhczwcQWKN7Ylf2tYxxw3Ln3saaN0AmCVIw+bqk32xp4Of2nUZXA+oZ1gy9tvR9
         lLSCmQ9CYfFn1H47lSYsIODAuu5J6cpT2yJZBVp6uG8PxzAki1rL32Fdm9Ga7yyIj2pK
         hQhMEy5mlkgL3jfMtw77PKvzLnUEjX4cOlOfWCEIjoD4glpQT6BXSYxgxxwDa3PemVVX
         Ypj2O2fV8/eLEjZL7AcSuFOQijzgLUqoAjmxxmVymaIHgcRsCXwz9kOPtlZ4apGxZ3FP
         i3djVgQQQ7+zQTrjh0+mWSWASooUgSSafKE+Xo0jmMC2kfv+Rek8EfedvIPFAFZcSZjB
         NI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bNVvSG62xl9Jk3X2cnvC9Xwc7/DlqVbGbtIj6kzPkCk=;
        fh=ajRzdjuqHNDpBhuwRYqWZVp2XDSFFitxD1dTKt7PPrY=;
        b=Qjh9OGDl/lwT1cRYwF9Pn5QBFyaUFNeg6lrsIbGQFKBGYEmOGAjC+9ZrTE9f9xbuLO
         hJ3xGjH0adH8OC3PP/PbCWlUZxLKcYXOULerDkQMY15F2GH8SKestVwaNOrgVbithXXr
         ZSYPwlzFWIh9ziB4r+xjnYvbkAH4rPk/eC2UsXq+nADVbVEx9wappaopKeapdmAuAkrF
         BB21URon/PdS7iTp4gfbJ/NWhyNrdX/u2hbqlt7Fz5vIvqHoxiQaGqp32OCRbyQiJZ+d
         SM9aMFjNicKcGg9cHEo4fcSoTc4r63EvUR0E++AEOPGm0Gzt+jy54qfFS6Vbeozlns0z
         5mfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772526185; x=1773130985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bNVvSG62xl9Jk3X2cnvC9Xwc7/DlqVbGbtIj6kzPkCk=;
        b=Dz5ZPSTzB1QnHShb7H3duoiabAMi1QRIPPx2HelXRQwedTnemV1ufDLx5vFCk2pWHy
         2szjC+W9eOL36AtP77ka72hSc0PLAEDGOhEe83rydjgx0tLS1Y/znmh3mncsP4SWZU4w
         4JTLqNVrLGpngTAfTiW9oYOnZqbv+C9tDA6Jq8TP67wgETh+xnVH9knxSeR2kRyyvMa6
         uAArwaSYPlMLXMbEOzSa+i//t4gI3VdHwTPBV7IzCxwdDcQKthgzIsRx4euOrqCPmgao
         ZJzPQ+N1mWYOQnKeqq0zXApN4c1OV/BuNVaQpRC657XLjUW1umc7uQGswkU1XZl9WoVz
         rDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772526185; x=1773130985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNVvSG62xl9Jk3X2cnvC9Xwc7/DlqVbGbtIj6kzPkCk=;
        b=tI5n6ySbTHuJPWG05bhaMHi8y+irkw/Y5G9se1iq0v5XCbWip5A9G+vaGGdxVwo7VQ
         t0a3rzj5fTrbCmefIBOYU9M1p4XGz9e/Q935z0teF/dSwRKfPW+DUbFd51dHHzfFwHQu
         ZSmJokyPljPKncEawN1Y/Oxio4SYrx7frt50PmRhMAAXCA9zoz0spIfUaBOAXCPgcoEF
         V74IfFZc4CSjQVH51MfD+0w7NvY7CxiYQP6C6ioPiIrhV7Fc7r6tDF1/cQUliZJy6fY0
         vafoRnREF9DyQx8NM5h3S5Uene7oyNLU5MCTMhp3Ihjcd95kRJCVSjpt8XSBZZrV/7iB
         2ajA==
X-Forwarded-Encrypted: i=1; AJvYcCUSrqcqV51AqygOBoMl1z2SKZnAUdPUOj0/d1zq15TUssia2Wh/r9f4/VautkLMkHqvcrBbnDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDiola4BUFXKpaPgkk2Upr7Jp62BcdZEsD+yLEbYZI1txOtk8
	4NdzZGGQ/+K0oso1r7gbDf2EoePrPm+tNtgLBQWvna/xpUQB265szU9Lz5HpT1WvpmXHL1en93v
	mB1NH0LXtWtR4IeR+ANpbZy5q3NQ3oJy9VCR30Q5OyPFmwvicnIu+SGftHQ+Pl2izlegaKQDr8r
	6G53iG9AvnC0CHzeLUkK3cJif2jacTbSsZ
X-Gm-Gg: ATEYQzzDjpN6pCGGQqZKnl1b5V0PSH93rEU3G7XbpcwWcX0O6pltcTjnoOiBCNxKLGV
	vS3NY2jEpz/3h/dL0/WqYZY9vc2ZpA8g70Xl5//AShUz18jtqepY2UPig8SWunustrcanND9K3l
	lSfeQukUY5FfUE+piXQHvntedreHKq4NFwraz7OE2T4czEJqcCn66EA4bWnlsl8sotQ2ydEf1D0
	ZJOHaI=
X-Received: by 2002:a05:690c:4b01:b0:797:a162:f7c1 with SMTP id 00721157ae682-7988547cfe9mr125761057b3.16.1772526185027;
        Tue, 03 Mar 2026 00:23:05 -0800 (PST)
X-Received: by 2002:a05:690c:4b01:b0:797:a162:f7c1 with SMTP id
 00721157ae682-7988547cfe9mr125760857b3.16.1772526184694; Tue, 03 Mar 2026
 00:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771986861.git.lucien.xin@gmail.com> <4e03deebdc944d9c963b0732abe8ba631893d82e.1771986861.git.lucien.xin@gmail.com>
In-Reply-To: <4e03deebdc944d9c963b0732abe8ba631893d82e.1771986861.git.lucien.xin@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 3 Mar 2026 09:22:53 +0100
X-Gm-Features: AaiRm53wLfsp6dwR6Y3kD8_sIr5QwiEb9N3a51XBSB8vMJnsYCaEYRcNMDa3ON8
Message-ID: <CAF6piC+W=QKU53vix1f8JxxFhRKCcMvXaX1NKBT3kcZLfCydEA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 08/15] quic: add path management
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>, quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, 
	Tyler Fanelli <tfanelli@redhat.com>, Pengtao He <hepengtao@xiaomi.com>, 
	Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	"Marc E . Fiuczynski" <marc@fiuczynski.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 140341EABE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,mail.gmail.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263071-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,fiuczynski.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On 2/25/26 3:34 AM, Xin Long wrote:
> +/* Binds a QUIC path to a local port and sets up a UDP socket. */
> +int quic_path_bind(struct sock *sk, struct quic_path_group *paths, u8 path)
> +{
> +     union quic_addr *a = quic_path_saddr(paths, path);
> +     int rover, low, high, remaining;
> +     struct net *net = sock_net(sk);
> +     struct quic_uhash_head *head;
> +     struct quic_udp_sock *us;
> +     u16 port;
> +
> +     port = ntohs(a->v4.sin_port);
> +     if (port) {
> +             head = quic_udp_sock_head(net, port);
> +             mutex_lock(&head->lock);
> +             us = quic_udp_sock_lookup(sk, a, port);
> +             if (us) {

When the quick socket is already bound to a local port, reusing an
existing udp tunnel sock is allowed, but when the quick socket is not
bound, UDP tunnel sock reused is prevented. This looks confusing and not
documented, please clarify the behavior and/or make it consistent.


> +                     if (!quic_udp_sock_get(us)) { /* Releasing in workqueue; retry later. */
> +                             mutex_unlock(&head->lock);
> +                             return -EAGAIN;

Why not -EADDRINUSE here?

> +                     }
> +             } else {
> +                     us = quic_udp_sock_create(sk, a);
> +                     if (!us) {
> +                             mutex_unlock(&head->lock);
> +                             return -EINVAL;

It's probably better to propagate an error code (PTR_ERR) from
quic_udp_sock_create(), or use -ENOMEM

[...]
> @@ -332,6 +333,12 @@ static __init int quic_init(void)
>       if (err)
>               goto err_hash;
>
> +     quic_wq = create_workqueue("quic_workqueue");
> +     if (!quic_wq) {
> +             err = -ENOMEM;
> +             goto err_wq;
> +     }

AI review noted that:

This isn't a bug, but create_workqueue() is a legacy API marked with
__WQ_LEGACY in include/linux/workqueue.h. Should new subsystem code use
alloc_workqueue() with explicit flags instead?

Looking at include/linux/workqueue.h, create_workqueue() implicitly sets
WQ_PERCPU, creating per-CPU worker threads. Since quic_wq only handles
infrequent UDP socket cleanup via quic_udp_sock_put_work() in path.c, is
per-CPU allocation necessary here? Would alloc_workqueue("quic_workqueue",
WQ_MEM_RECLAIM, 0) be more appropriate, or could this simply use system_wq
if memory reclaim safety is not required?


/P


