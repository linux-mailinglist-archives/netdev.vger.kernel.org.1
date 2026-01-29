Return-Path: <netdev+bounces-254901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGs8GSO3e2neHwIAu9opvQ
	(envelope-from <netdev+bounces-254901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:38:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF5EB40A6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD19D3001F9E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFD62F5A36;
	Thu, 29 Jan 2026 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYZ6M0pp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AB631D39F
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715485; cv=pass; b=dk/jeNozqud4U+O8oaouZ1cJeNc/DKv+aAUbHMiuOlH1osDvme6n88Hxf+c8DlR94FfWxPhM/o6fzUPqY1A3s+q364ccroEE3K/mgJdaGVT0k8d75e7S2G92glKNojhIXN221HUVahsTty6Fv0AuGlLDXNPrnU4+18s+jFLktuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715485; c=relaxed/simple;
	bh=an23PzgT+ETDMUmkvQg/3z0rXD8Ts/s/wrp73SCQ/LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1DIik1ZLtsGb6t9ET4BRL7YK61nKOdOXkgxhFh9969WF3e4X2CoBmxNejp95zo1MD7R/UCG2+2xdtH8bD8DAjKzUAjjUvqDC8ECpBsx+wAq7K4AGd9Mk0+4KB5wD7ofPj1tZey4kCj02i8Wyi2bBLuyLvwFrUJiEkPRAdrqjpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYZ6M0pp; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6541e35fc0so742454a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:38:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769715484; cv=none;
        d=google.com; s=arc-20240605;
        b=lFqNXYKoymp5Y7w95qLcMOmei6sfVTtrXSvh2wxbY7wH6xAXMp4bSum6zzk97252bR
         7d9atSRrY7jtrDN85Pac31UU4/CqJwUaFfpf/5Y3ZkW4RKF4CNPg7EM3eeu/+LEGKfZ0
         DLVYskhJNoxJG80uq7kYPqyIQqXPloEngK8H7mVYhmub58iEWSdSAdkFzFHeqKwwWLan
         eydmR02FKTwzopwpbiqs4UTZuBc+ttCvI3/a171XBSSqb4niY4mluPd7jZ8Kd1DfiDqt
         QvqObyWkhoU9jkSSZ7dd7Ot7KZhFV65n6kZFAIZsNHGbNmhThQSkL9zr8x9CUX8CUcwd
         wZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8jgscGADAtGExE/c6eNO9k9qz7qLCMhugDMGIDtgfTs=;
        fh=fDbUfIcx4Ncec9AV4wxOHXS/c8ilfxJ4Jm8OWBj8/eg=;
        b=acDpFPqjHI5eQ5kpuShYa6qXh2v2LQ/05oE8mtg4SH2bMNmkZbzFiJaVvP5Fv5BVul
         r2BTHbqSg+I4AQFiH12J5NolextO1MH1jOCVg1R0bTNlKJBnldy3cLKx03R0iJzQ5UiQ
         +43QT9KHsTlBYpIqCsw+dPrtGE9ikNbS8wJfJNcQ8R56HhvQT7CIUcETjaEgcx8epyKL
         ZYr1EGgvc7afeFufUMESYbSlx0fHgWMd3ctWSPEyUKz3afXTGDZ3N6z4X4Qf2Vjft3k2
         9PeJTt6xSO7qC7qOd+4K3BToxWdXrT0VLfGzwbs0VbJlsiOtCxtfYdC4iqafdfdIMOks
         eRmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769715484; x=1770320284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jgscGADAtGExE/c6eNO9k9qz7qLCMhugDMGIDtgfTs=;
        b=WYZ6M0pp7StBiH0QhCleefLkkUZV63AuuHjsHSdlz5vyyqS5z8ieYx2NGEgq/4rEbq
         O1hdHOHNdjzMWb2CsfCfG08SjPoJURiem90RbFKrMCruqynrKovrOFV30g78NEDDDiF6
         70Ty8ggEZPPKvKsNKzp9Ib2jva9Yg+9uDn6vEu/X/UTAhvwq7J490DDnbAdhHbm+ZWcv
         COeewiSJoU7mxEglT929POlgK2P/6kJ5Fnu9RjkFFZJn6uk/qNlU60j6UCFyJjI7eTHj
         ph3cLx3KTt9hS1WQoEKmrKP9MehBM9Vxjx/Q1tEs3amPNny9oPn+Uu3J2hELQWRJz2Ka
         1fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769715484; x=1770320284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8jgscGADAtGExE/c6eNO9k9qz7qLCMhugDMGIDtgfTs=;
        b=pDMAF0bCefPByx6YRfd0Gy17PoXL2T1dSsPxIk5p40cSLpIdSLYXYpgs82B+SJP/JC
         ESc+5da2076todByoYDRRcK6ldOlT9yLdw25dhbf7O0BJJe7+pSl7avw34ZfsG8hB1gr
         nwb2vM5eqdUeF7SyJX1d5/YtfgEnIy6XQ2gFlHOhwW/MLPvO41XK4kk2Ey3mbdlrW9kD
         xNQTG3NhYGY2SP83CsN9yaf6ZlWqQjoMmwvubmcLMWadLd55gIg6B8yw/s2OBC5EMgiH
         wpiVzZb3uk9/0QpPDpGe+c4h9Nr3Q40mAgRqgPYJK+T0kZC4SG4QBJ8pCF6rEwbaMA/U
         /Y0Q==
X-Gm-Message-State: AOJu0YyjSfByxMLgnpuuUB+OVj+H73e3Mr4gUdcu8p7i19cgI2QP9TLC
	BvsjUsDtfqpAtPmhJzUoBLLy2vYy4zHuXxEnMQVOQkRbbPjXd6bH94UnUp4eO/6ywna0pfE/Csl
	1MTB2osPTwOBftqRB8CIA6TBzrqLiNrM=
X-Gm-Gg: AZuq6aKakyQ6tvfQYgQ5yw8Y9yNXC3Q0WgaYcxczB+rsSWaGJHq9tCU50asEd5i74e3
	+IMHYgnG8D6EX3a+bVhyLZ/rUvwEqBkJHhnB0BysHRQgucV362tHqJTjNFL8Hm1YcEye20H8cOS
	nCGvmA+MhsGkAIXufSBgEWkelzdhpBz0oN/JNv4eGieu5X/lZs0x6NsLRrDk5Rs+RLKM/XqTWJQ
	+wzKUXesr7QwCrrUzjRZSDL3mQFRKU9JijO9n3YQDzSoYEKsbu7hpfhxbmeRDyZFEpoxlIlAktY
	nOaB6ZJeIFGJC7gUEwZE4tS2LGE5zk7igmSoO2el
X-Received: by 2002:a17:90b:2e10:b0:32d:a0f7:fa19 with SMTP id
 98e67ed59e1d1-3543b39c961mr584686a91.17.1769715484009; Thu, 29 Jan 2026
 11:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769439073.git.lucien.xin@gmail.com> <46f93cbee41da1e1f7b7f408b17915fd93b39ec1.1769439073.git.lucien.xin@gmail.com>
 <bbbaf4e5-1c31-4c84-adb4-dbb94b8d07f4@redhat.com>
In-Reply-To: <bbbaf4e5-1c31-4c84-adb4-dbb94b8d07f4@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 29 Jan 2026 14:37:51 -0500
X-Gm-Features: AZwV_Qjv2qurpUKIB7y-u0yeOaDoaz7ma2YS0Xi_VtbJ92jOQ4X9Nw-fNxtkIAs
Message-ID: <CADvbK_eHu0=8G7--neMHz5CDT4_MV-MONRu8obOsYbUhCc1ocg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 15/15] quic: add packet parser base
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254901-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,manguebit.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FF5EB40A6
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:53=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 1/26/26 3:51 PM, Xin Long wrote:
> > +/* Lookup listening socket for Client Initial packet (in process conte=
xt). */
> > +static struct sock *quic_packet_get_listen_sock(struct sk_buff *skb)
> > +{
> > +     union quic_addr daddr, saddr;
> > +     struct quic_data alpns =3D {};
> > +     struct sock *sk;
> > +
> > +     quic_get_msg_addrs(skb, &daddr, &saddr);
> > +
> > +     if (quic_packet_parse_alpn(skb, &alpns))
> > +             return NULL;
> > +
> > +     local_bh_disable();
>
> Is this really needed? If so, it needs some comment explaining the
> rationale, otherwise please drop it.
>
It was needed, as a spin_lock use in quic_listen_sock_lookup(), now
it's changed to rcu_read_lock(), maybe I should drop it. will double check.

Thanks.

