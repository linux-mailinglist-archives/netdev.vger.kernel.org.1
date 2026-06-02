Return-Path: <netdev+bounces-294178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cjnFCkbJHmpcVAAAu9opvQ
	(envelope-from <netdev+bounces-294178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:15:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E50B62DE4C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:15:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KnuMgVLY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294178-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294178-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18EA03087E7D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0BE3DD532;
	Tue,  2 Jun 2026 12:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F763E1D08
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:08:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402085; cv=pass; b=eUpqTXNI3FU7+IHS0gD7hVLMbnmZzA1jHC7j0hAoLdPWXevNoAAkOCxmkbZF3DqDQ37TaUtooEAlXgT1DB2Ny3FRQp2KAOYsT27Cuf8sozjhw9ucgnzG4xV8QmooR7XFx6xyLziiKoWUmS6R1PI10JhIWB3SDzWeoTbOwf5759w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402085; c=relaxed/simple;
	bh=MsBFhBpDydg2/TVCkdkSklfi1mw397s+5dUeEBJ/m6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrsPQMfmUpD1a6wbFV6nDgAHWRgXwTNUDaupseAA0h5U6tGHBsjSMCOOSoPH5/EAStkQCYQlubRHEhrn6aiiZ3x7hJ4hi2RmLUlMOqJZX5hmyZSoYM4PdEjqBQxN0CMlt3Y4DiTfdSYSKFoJqpevXMQvZmbXFSO8AzBFR0YyzqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnuMgVLY; arc=pass smtp.client-ip=209.85.219.53
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccef25789fso26036946d6.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 05:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780402083; cv=none;
        d=google.com; s=arc-20240605;
        b=kQdiaRp0s9yWQJhwofgq4O3Yf+OtLzs8rW0glRhl4VhHlr3nGZ7AhJE+9QNttbT03c
         +jEG6zLF2y+mSpKIHFvO7HsNeT6ES3KWZ8hcHVUS1bea8A24rG41DAhPCukaTVoxDxDn
         07pc8zSnRe4HJ9Fyl9D0hHMNKbofoYwyr7OJ0Wop5mOQKN++XD0h+egRZ9kktTnm3ulf
         VNc9T3aRvuj/ittct+P6voaxhypLgtEhJTvXwOiwdIEmj71KkCKBr8Eg6FGlYMIIWF3x
         sdMx1acEMvPin93ObnvMORxt4ycPnJBMecRRB2CSIjxZHMKyzLo7fAv2LjIlSi20WGzV
         GbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xi1M3cxdtsOl2Z+2W78fiPOB8WMC/qvrqLPm8nEso8w=;
        fh=yUUT8IL5qfnbx0sK/KguLCwJXxdHkHpyP9UdNqchPc4=;
        b=bGMZ1X12RkCBD2D68wPgbQQ4cyOGQ4HKEuNMrkX4ehOELCO239AgguHwUFl9ZO1ipC
         F2j2fwQVKdD/IICy9MYiEShCJMmIaC09E3vqIVpwY66udJp0PBv/OlM9qSIhECOL6S8t
         Efk7pATtsSADMijjc70XrZZXYnsIOVNR/EdBXKQbdWULbNMqhD8rlVx4dD/eoVdqVtm4
         7yBEhslBPPrq8mZn6UAiWSPJl942H7q+7atzgQeL+B59c0R2pws9lpyZgYZZiRrAQqJ7
         jJPRTyVzhAQOi/2rommM/PGWbXvJm4A5ToqDQbIAVB08EnwmxioaH0m7eWpYW+f5xNUw
         iwlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780402083; x=1781006883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xi1M3cxdtsOl2Z+2W78fiPOB8WMC/qvrqLPm8nEso8w=;
        b=KnuMgVLYtHpytnzH8sJA/Tjup5fDWMUhqwjugdL7991mvL4fX9EobSVVh4kAxW4Nb+
         PJnOo93vcyB6mhZEasNaGhZUP6bO5te4ObQnP2VVNnvjts5b6AkLf0JVvjyD3sJrvynj
         pvCSvaaUjKUg8G6X2/RL8pnKmSs8tAfb1aNoLMW6jL2HMuGoxkiARO3BHO+nvwD1/Rok
         lcoD93l8es4zHLOnqd7AUZlVZTWhEry6FnbzN6z71ug8dF01rMpqqDDsfU85i0vU8mIQ
         0voJim2hCgpvdyPZx7U5hGJXcyKfYVcUWHgUXRtuuJ0IS0rfeR0nHni+7dUBctrYOrLy
         sTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780402083; x=1781006883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xi1M3cxdtsOl2Z+2W78fiPOB8WMC/qvrqLPm8nEso8w=;
        b=OWxeFeYtcqQiWqV8wgUEFwh0s33nGuZ8zPp6CUHGkJjJVaNyDGBnElzjkDHy4sTE9d
         CTfsXP7xo8PTMKj3zlVumcNi/F/by5Q5l2mkrCah1VO4ArAFgG89O7TrSamXxb+kP3/i
         XdjRfKjzUuYInVNi9EPyCYCZRQZAnEjTnvtD0HU4z5RsIU4MnYyy3Fhj2fA4e1TKMEmE
         RT1m0YyAV1QE5M7LDbQbgY3xYPT2uyoygUjn57/qPDZCsIS8V9NBiaDLvAURcX4jcAJR
         Oc7CM3IXeUtLRH7SxuVC4DszTO17HjmguIyW8IKOHjYRaBCuiCj7uaXOB77vYAJv/Ft0
         Wd5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+47KvnPhaRzxjJbq5qkl8L4X9VcJ07+B32XbWzHAfESOuZFXccMDJqIiYe7E1M4E1pa5+E9sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCBnOrwtSV5qbUUn8NYRXU3lQwS24WfVaUSsNsgPH9PI+Ih9B
	/64X8IKI8f3eRL8JIhNTvcO7/RK3ndZJXqmFC+Xc4XBuWKjGGvvyWdIyEQ0+qxAIBlzeX7NuUXX
	f0ylmSkiiyJLU99WPuqCS9qg2B0DoNHSVgNV8mmPO
X-Gm-Gg: Acq92OFwriVOdjR7CqiUtxvgevRHwsOgX74mLPjBeiTX4g97ymRlD0obyX0o2cz2jBN
	69bSabM96bss5WKGKeOVTo3wxxGBZ+GAK0yeFytiiArR/idIcblIrKY5r7aSyNL5yZgoj0n9AnB
	eU2tEEePrwWZxeATCzbRyDDRDuBz1EbduSwjNPjlM59mDBa+Fym234BS94NLs+jKT1+nQe+t0de
	L0NZid3g6Ma4yiYKbyF3Hd/X27Cdk8oUPhItbnz5UjX3K1lnPR3nMT/gG3Bv/UMWpjlF0+ITaY3
	xbIXVx0V9oo+WQa0rKsnwcf3XH4PzlmFJjvaYq5rxYNZFVAvOdAnZmah/OLbtl0PK0LXfajMsZ1
	cluK6BH7jBG20cT3jquyhRRxgzDOt
X-Received: by 2002:a05:622a:4c0b:b0:516:d955:ea4 with SMTP id
 d75a77b69052e-5173a712bfbmr233974401cf.17.1780402082085; Tue, 02 Jun 2026
 05:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601124157.699463-1-edumazet@google.com> <20260601153401.GA391068@shredder>
In-Reply-To: <20260601153401.GA391068@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jun 2026 05:07:50 -0700
X-Gm-Features: AVHnY4JDM1szQpedc_y9hgnWvgcAG2RCeKWaykAstHUMMr9dx-oIDsNApgHElj0
Message-ID: <CANn89iKA+g0HhOvPpJta62ur9EgMKBeUu8dXqw0rgf3MuHLDEA@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Tamir Shahar <tamirthesis@gmail.com>, Amit Klein <aksecurity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:tamirthesis@gmail.com,m:aksecurity@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E50B62DE4C

On Mon, Jun 1, 2026 at 8:34=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Mon, Jun 01, 2026 at 12:41:57PM +0000, Eric Dumazet wrote:
> > This patch restricts setting Loose Source and Record Route (LSRR)
> > and Strict Source and Record Route (SSRR) IP options to users
> > with CAP_NET_RAW capability.
> >
> > This prevents unprivileged applications from forcing packets to route
> > through attacker-controlled nodes to leak TCP ISN and possibly other
> > protocol information.
> >
> > While LSRR and SSRR are commonly filtered in many network environments,
> > they may still be supported and forwarded along some network paths.
> >
> > RFC 7126 (Recommendations on Filtering of IPv4 Packets Containing
> > IPv4 Options) recommend to drop these options in 4.3 and 4.4.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: Tamir Shahar <tamirthesis@gmail.com>
> > Reported-by: Amit Klein <aksecurity@gmail.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/ip_options.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
> > index be8815ce3ac242372eeae4a97091cda26d40ceb0..ac0d147c4b8cc347839a044=
adc43897faffd95c8 100644
> > --- a/net/ipv4/ip_options.c
> > +++ b/net/ipv4/ip_options.c
> > @@ -283,6 +283,10 @@ int __ip_options_compile(struct net *net,
> >               switch (*optptr) {
> >               case IPOPT_SSRR:
> >               case IPOPT_LSRR:
> > +                     if (!skb && !ns_capable(net->user_ns, CAP_NET_RAW=
)) {
> > +                             pp_ptr =3D optptr;
> > +                             goto error;
> > +                     }
>
> This might be a problem for netfilter which calls __ip_options_compile()
> without an skb from ipv4_find_option().
>
> AFAICT, user space can include IP options either using the IP_OPTIONS
> socket options or using the IP_RETOPTS cmsg, but the latter is not
> applicable to TCP.
>
> If we put the check in do_ip_setsockopt(), we create a weird situation
> for non-TCP sockets: They can't set these IP options using IP_OPTIONS,
> but can set them via the IP_RETOPTS cmsg.
>
> So maybe we should just put the check in ip_options_get() which is
> called from both paths? Something like:
>
> diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
> index be8815ce3ac2..09d745112c15 100644
> --- a/net/ipv4/ip_options.c
> +++ b/net/ipv4/ip_options.c
> @@ -530,6 +530,10 @@ int ip_options_get(struct net *net, struct ip_option=
s_rcu **optp,
>                 kfree(opt);
>                 return -EINVAL;
>         }
> +       if (opt->opt.srr && !ns_capable(net->user_ns, CAP_NET_RAW)) {
> +               kfree(opt);
> +               return -EPERM;
> +       }
>         kfree(*optp);
>         *optp =3D opt;
>         return 0;

SGTM, thanks a lot Ido, will send a V2 with your suggestion.

