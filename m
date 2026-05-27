Return-Path: <netdev+bounces-292092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNf3NRN+FmqOmwcAu9opvQ
	(envelope-from <netdev+bounces-292092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:16:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 754505DF5BB
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0859D3036424
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3213D503;
	Wed, 27 May 2026 05:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="om+Ki35v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528E405F7
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779858960; cv=pass; b=SWyXl3H2KYMzc3taRsxsCvn68+FrLZ+4UN54CgRjDDMrAZ9jFOSSvqKIXg0LMSE2b+ZsiOsDTQ6v6D0T86rvrpCTk+2iSEORk/Z/WrGvThQXrYgkxLYZng7+Mb86TFnDfBdVLR51TeU+kmgIWw5xnkO5lnk+KT6w9+DesZKTr9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779858960; c=relaxed/simple;
	bh=+BZYiDmFDs8VocYA6WvYp7eXlbp/u3NKtGRhi1Ra3S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMHrdVP0e6k+/0jhi6tVKspw93LlsIGRcTXzhAicbSyBqixBG51wsGsqMQ2xFqpvoprP2GEfKjYa0OuVGybRpZk1p+pDbGM6uf8mX1pQ035Sr5zk4J1JKzBrnmn/f9/u5nzXBJUh6SAlFb/a2+jFxid3tQswwC+TeU2JrkYB3wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=om+Ki35v; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-516d6402264so33635361cf.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779858958; cv=none;
        d=google.com; s=arc-20240605;
        b=bW/K/9urlgC38fqcAQrEBsAk088/GkDbTlc1FIhGzqlnotaA0PqRxYzRKDqtEA2TxD
         sxcvJN3zph+y9Nw0kW4TVFcvuew99B2j2i+OxT1cqtSwEAOHdr8sxjQmkiPJKJ65cLOq
         t9EkpTMWy6CfvcokhjuhIghcCT9NeQuvSM8aePTXVLKaJqDHL7IPiVqe8+Jf8hw2oZ8A
         mxYXnf5BYvFTsSPt01UmOr1x7kJFviGIRvKZ7sY3tb7aW29fJScAvRsgfa5He8YCjJWa
         j2o0t5LBYkEAE6//pmY+kXhUN8Gu4lR/3EdECPfhc4pxx8zKRK7XF+4m4z7yruwmUqu6
         qg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLmfiOziickoeDad7IZmf7iwgKszrwbo5EgY3UZfDwc=;
        fh=Mdm4sCRLAPyTUgeO6wS8nF2c4m0JpTMeE0I8pR5D7ko=;
        b=ksezcy2FNhQyIDbC8l1V8OVFfa0Y8O7IJWB0fO4WhuEqwmLD61CUUSZAuiJbFf163e
         h2tVCbAeDCW2TK7XxChtkph4q6HSXOJ7ley/XQHMNx6Lcy7TSaXq+iHtzMTiu/so0Z5K
         o7y8nxszVUC5ZbtFLQbFhwUI7io2VHGZwKRKNpwzRDIZ8Kl2H/AYQUwPtl7rxzCQycZe
         3c6pG4E8KF0NzuXYpqkihlaP35XwklXULhoUpFt7YCbsTwA5r0/JZkKEqFoe3H+rnUJ0
         si+fIIOH/8FYlrOLUGCI5KbCI0+hWskKUW5EXzJ8Paya65Q2v2VEnvjqSQHLip0Xreup
         NGng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779858958; x=1780463758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLmfiOziickoeDad7IZmf7iwgKszrwbo5EgY3UZfDwc=;
        b=om+Ki35vc44nRH166qhy3IzCs2donc5A1F2BJqOg2licUhm/+urMguTTZMgPF6XA9i
         mgYwJE2Bc58yG7cDLtHe33fNstJW6Z3QR5kBIngmVmZKx6frXcQ+3/d6N57r2qhaEYS5
         xae2YPtdQ7sMjpc8x3N6Y/VJS2zMUyCDmxs1YxEYaLGllhkFVBLoIPO6966JLdaSa+aJ
         EUoauQUKHHcb4lQgzF0oYbn2Dj075RtWBYH3YS9eVQvCZ08YsWHERh0636X35QTcmAdU
         h+yLWpzYu2LUELn3beKvRDWB+ct9cc5dM2p/MJuGQS8rfdw2GDboBTcA0OsVSCfp76vG
         iROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779858958; x=1780463758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLmfiOziickoeDad7IZmf7iwgKszrwbo5EgY3UZfDwc=;
        b=Q4kiDpG63zdMahmde32XthrqjIgkN9rcsVmN0rbLeT4gaAZgkTQz4UMbEWSJnsL+ri
         S715AuClA+I4v/0mVeQUsanQtE00Z1Dj4CbmSXaBUZA5DjR4RcgpCblwlr2FnjMWxyC+
         kdmtyc0ZstCX/B+V+zlCF44YQ33Q/IeQ2ZBsRZ+/jxF3PrGeMjIN32+7FjBOXyAprMXG
         0PAam5Hxz6crOsYuI9G4VE2D7n56hRHtgjet8+8uAaJHVxs8wZby+rKxoc8wsRT8NHYA
         npEKYwdBrm22YztSUQayRsbAAvY0si29E0CMQFMjwblwO2pqK2ipiZnK71lWeRtDJOhs
         rM0g==
X-Forwarded-Encrypted: i=1; AFNElJ+fEfqa7A7W+fNwNtrREyP3h4WwZqW/eZYdbwQgvUmWhybBzsDQPws2vC/ij5oDKi0HqdJd0aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyizkWkGcpGtMlBXbtvDkKu6KhP1GYoKcMlyf/FkOgM7wiwp/
	P6eRPzAw3/DdzRD2ark7u8D2cpkN6TePWLCO+okBwob/UJPav39x1PnNglcxNHbiVoqQHahQB4G
	P5ZFubUmF10jZoxfepVa9XBTpb9a08tvZnQXfFNWj
X-Gm-Gg: Acq92OFN/HZWaGlIU5O3xBNjXFJnkhPal5lWNDxGVcPfgyE6L66mNaqqrDGgUc1kcKH
	wPEWtzygzFZg3BjGxsRVU9g0cvA8h8RyNZUivqEqxb/NAPDm439B0o/gvGd1AnHcJTZXo/40xz8
	3qb5x0nmqo4rEL+E24gVQ/33/i0plxqE4mmiy8Q9zrkll9Yz9t1sEMm/z9ht24wzUq0Z6gq0f62
	Kj+13Kjd4FgkMrDKLAL4SKee80oEXVymikF72+Oz6pxP3Gd/jd1HMn0JRsXGI7TjK0U9Uug3F89
	vQOmO49KGw71C/+7qMdu1eegGxisELoWdBebKnR5HuysnEXNnd/oLULSLE1e8Hu4p+58Q7Xsclr
	Lq7nlHNFB+fY37vXs+URD5ah7cD70hA==
X-Received: by 2002:a05:622a:134d:b0:50f:c5d3:a191 with SMTP id
 d75a77b69052e-516d429f541mr291702451cf.13.1779858956995; Tue, 26 May 2026
 22:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525083542.1565964-1-edumazet@google.com> <20260525083542.1565964-4-edumazet@google.com>
 <20260526193003.692cbf01@kernel.org>
In-Reply-To: <20260526193003.692cbf01@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 May 2026 22:15:46 -0700
X-Gm-Features: AVHnY4KTfh06WcDD5E8WR3UA8k-BgcUIQTemfdcpGUL3GJJGe18pz9CkZhsOYh0
Message-ID: <CANn89i+UMyx-rKO0ScZkcJYG_vk=_kddcQC+SxbbYSEyUTPgGw@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 3/5] rtnetlink: do not acquire RTNL in
 rtnl_getlink() with RTEXT_FILTER_NAME_ONLY
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-292092-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 754505DF5BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 7:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 25 May 2026 08:35:40 +0000 Eric Dumazet wrote:
> > +     need_rtnl =3D !(ext_filter_mask & RTEXT_FILTER_NAME_ONLY);
> > +
> > +retry:
> > +     if (need_rtnl) {
> > +             rtnl_lock();
>
> I'm probably paranoid but can't shake the feeling that we should add
> a check here that the device is still registered / alive. Running full
> rtnl_fill_ifinfo() after we may have already called ndo_uninit() seems
> a little risky.
>
> I don't want to delay the series any longer tho, please follow up
> if you agree. Otherwise we can defer until/unless syzbot proves us
> wrong..

Ack, I will send a followup, thanks!

