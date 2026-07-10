Return-Path: <netdev+bounces-306484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iOkTAYe5UGoz4AIAu9opvQ
	(envelope-from <netdev+bounces-306484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:21:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECF5738F98
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:21:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iUz4zImG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306484-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306484-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE47D301ABA3
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA153DA5DC;
	Fri, 10 Jul 2026 09:10:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74193D75BF
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:10:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674657; cv=pass; b=HwEwYwjUkwVG0BXMi0/08JWSIlZsi+NfvW052S9B5WYZu3YziLGy84TEbukeaO5AdfeNWANUstfe0eJRfwBjoHNlKjGDXSLnubNzuL7C74KeEiA+takE0m5Ju7b04SG+oi3llPGzOessPDc3h4UNb3fU8+aV0KC0JOkIwtBZqXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674657; c=relaxed/simple;
	bh=7VRjjiYf7VsPZRU72hng4qVFsOX57FJEhq69ROQS9W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+wcQcYi/cQaegWV2BZeU6GOeSwNvuiLzDmxBV211VdViP5znO6K9In74npS9LqYkhHDtR2raa8EKljwpWPAj9lMCDrCWSTz0bIrIPe5X+pDNoVFun9/C9urTLwyhu35rDPHxCjE//eu4z0Xr6I3jHFlwieIlthiEFfBObtlIyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUz4zImG; arc=pass smtp.client-ip=209.85.218.53
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso84408466b.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 02:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783674654; cv=none;
        d=google.com; s=arc-20260327;
        b=cAw3p4H3WECjd7OhNzmB1oBXbnMcmY+mG1o9rEDvtBqZdtRRvgKZ5veYOKGhnKjcXR
         dJbobfJclCywGcb8g49Q5HJ0OfIUov5bXQpfqkY9Qi3CAGHqAQ1UDx7L51ssXeH71HlP
         McbFzJfi3POVlHelAZNY7e6B3f7n/bmlnMV0t7DW1BU13L4Qu/qTKXMvnRPo4B+LTSie
         pmg0txUxVq7ZOym68SJKXzFnGKeHEsDk+mNH4OvkFwL+OQ0AZBXteTNpL00zX1wLs2D3
         cNIIcdS207ZVGQFacaTtltO0/gZg4ffTLrXHWJ4aCQPgVv8yJl7SJt+wpKuZ5UJBfbJ8
         AoIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=63OqeDSCaj1h6ZXr3VoxtulDj7w9Hpihc2AgE3wNxBI=;
        fh=S0KCh9nYaGnmWadtxpatI13J1j6xRJC0HiN61dg1IvU=;
        b=PxVLaR0wn5ipxkScdTxwMyJdC24I3YcCZY8hL2ey2mXkKpj1W7CLTpk+3Td8Q4C31h
         kAcY7V7ef2FLi3XVJbKfjmTv2Z78SHPx2e0VwFXUA9qh1StsxUW8KPTZTci8/GVqSfHk
         PMAYm2M/sXa83Mq4VbGwXeEhgkboGIMWZqoqGSo+9U7tIZsRGdhx/n+XluXvssaH1EDb
         W5ieQ3Tn1O39o0R8C1BexDb8Xb9fbCq8O5f/E0gA/Tgev6rmmicbScvKuq4RBl1xKvR3
         Ei9xAZsQ4Q02t++hAx3HoLSYwOspoUgiziaaSxgE1GD8Wiqk/LNCVvexxxBeVs0nRmV5
         BROw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783674654; x=1784279454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=63OqeDSCaj1h6ZXr3VoxtulDj7w9Hpihc2AgE3wNxBI=;
        b=iUz4zImG7/gi6rhoepnmHEbk5Abz3BlRM0633rnPMrD81DZLc7xjJm3NEiWiI0qkT5
         bLHXkmxefvFYNHoL95gntY3dIoQTMl3k6kjhf3zJDGmCpTLEKjwSqhLhvNRHb9OCRgs8
         6ndyd7MKyFAF0KJaLUJzKt7HRIIrD4GFP/8IoTPwvfcsy2FF7BUa0yRhepJNN06QDROc
         VsWeBpH/sHYEpjxvQeJpNBB/4dzSyHgeaFIod3XhHD4JeGbHJMxfgNGsFitNjN7MQ7dI
         QZPzNSqTPyovC4T0Defga9JeJ2gVI4UqnMwl62Ihvp8SOPNQak/EmTlnoc7n4TTvrcQw
         bVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674654; x=1784279454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63OqeDSCaj1h6ZXr3VoxtulDj7w9Hpihc2AgE3wNxBI=;
        b=p82HhFibuK6ir90VRSpm96AGgoZsFoMwX5BmO7LV32SdZMlv+/Rjjf0INmnBEhUNPb
         qWm5/jFGu/hgKibZw5j+lt2TB1XDE6Smy3S0vJ+8UTBkNQSR9dXD+2zgprXAK3tPhZ2U
         Osv4dgi5BJd3E+XJszHqBvzggOkBfb1Liae7PMcPYC/biNEmNkqr4+AJxjJ5HIZeiKsX
         xriEL2T55AjKZpnqSdpZLcCix0utuuGhMK1zMTdHcsBnq3xlOQ/inW0DziN3xC5UqDTz
         ZTHgpDC+xeglcOAbHe8x5TjBRZB6jgs77G4vkopLF9+LQ9yN30OvHqfSHTs7jUOK1yhd
         wF9A==
X-Forwarded-Encrypted: i=1; AHgh+Ro9Z5ldBiO8piRQmEeX7heZ6qnw+K4yOZjdatVk+sPKp/3bHfDP6/goB8E1yfQYQIiFTh4GKiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmNHfQFYE8Gzc8/Q7+osgD282G+v++pU++caTftYt83HlIBOCD
	A/7eB51Ql7/CDuQLQovbSxhcAdOnuvgBrcG6y0i1+Lf311bn37GQHVvNej/owuL6R2evaCoLYq4
	quSb3O7i7h4CtnwbZCLlYBd9lHDRx0n0=
X-Gm-Gg: AfdE7ckmP0rSYW8ugr18wcWGK6thOjbHpjzBqUewjiArU/Dh/JBCiBIotQ0THNmLkPp
	L5SrKichWxapbnZVASNlAee03AK4mbnN4T2GpmDn/wnAq0eAKMhRvpQyP5xytdjQ/QMoYRFW5Ha
	qTVXA4AgCRhOBSVvNRWEFslVnWpdLS4dfVKz0llfKIZz4tA3ffpJ4qCt4q5x4lAkvdfZBamn5Sm
	ggz+/sKlx2nFnh8Uz4x9hD/L1mCzmDjiD+YrXG11eiYyaqOE1qd9aC9U1hI+rZPjZdqC1H5rEq9
	SwYUZQ==
X-Received: by 2002:a17:907:d641:b0:c12:3c96:83a with SMTP id
 a640c23a62f3a-c15ce14468dmr473366066b.38.1783674653759; Fri, 10 Jul 2026
 02:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh> <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
 <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch>
In-Reply-To: <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 10 Jul 2026 14:40:39 +0530
X-Gm-Features: AVVi8Cd5znmWkFPkHNasW53XA8Yxqr82wjkGlYTTGZ7zlu8uEaTgeVqYBL6bRu4
Message-ID: <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux Stable <stable@vger.kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306484-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4ECF5738F98

On Fri, Jul 10, 2026 at 1:31=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > History: The multicast stack currently supports decoding of IGMPv3 =
and
> > > > MLDv2 exponential timer field encodings, but lacks the correspondin=
g
> > > > encoding logic when generating multicast query packets.
>
> RFC 3376 says:
>
> 4.1.1. Max Resp Code
>
>    The Max Resp Code field specifies the maximum time allowed before
>    sending a responding report.  The actual time allowed, called the Max
>    Resp Time, is represented in units of 1/10 second and is derived from
>    the Max Resp Code as follows:
Here I can give you some input. Default value is 10 seconds for which
the protocol value sent on the wire will be 100. This means 100 *
(1/10 second) =3D 10s. Similarly, setting just 14 seconds will cause
issues. The protocol value transmitted on the wire is 140, which, when
decoded as a linear value, results in 224. Similarly, values greater
than 25.5 seconds cannot be represented directly in the 8-bit field.

>
> Let me check i understand the issue. If the user configures a value >
> 127, linux continues to use the linear encoding, but a peer decodes it
> as a floating value.
Yes, you are right and that is what it does till now. And the Kernel
applies same to the QQIC field as well.

>
> 128 linear is 0 | 0x10) << (0 + 3) =3D 0x40 =3D 64. So the peer sends the
> reports earlier than required?
No, it is not 64. This becomes (0x10 << 3) =3D 0x80 =3D 128 again.

>
> 255 linear is (0xf | 0x10) << (7 + 3) =3D 0x1F0000 =3D 2031616. So the
> peer can send the reports much later than the 255 1/10 of a second
> than userspace expected.
Yes, you are right. But the calculation is incorrect; it becomes
0x7C00, which is 31744.

>
> What is useful here is, 'maximum time allowed'. The RFC does not
> appear to say how to pick a value between 0 and the maximum time
> allowed. Which gives us some flexibility.
Yes. However, this can lead to excessively slow membership
convergence, increased leave latency, and in some scenarios may cause
multicast membership state to expire before reports are received.

>
> I think a much simpler fix for stable is to clamp the user space
> request for setting the max response time to 127. That seems like a
> one line patch.
In mainline I encoded the value according to the RFC. We can clamp to
127 in stables, if we are not willing to take the entire series. This
will force user to use value < 128. Also, please consider QQIC; a
similar encoding issue persists.

>
>     Andrew
>

On Fri, Jul 10, 2026 at 1:31=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > History: The multicast stack currently supports decoding of IGMPv3 =
and
> > > > MLDv2 exponential timer field encodings, but lacks the correspondin=
g
> > > > encoding logic when generating multicast query packets.
>
> RFC 3376 says:
>
> 4.1.1. Max Resp Code
>
>    The Max Resp Code field specifies the maximum time allowed before
>    sending a responding report.  The actual time allowed, called the Max
>    Resp Time, is represented in units of 1/10 second and is derived from
>    the Max Resp Code as follows:
>
>    If Max Resp Code < 128, Max Resp Time =3D Max Resp Code
>
>    If Max Resp Code >=3D 128, Max Resp Code represents a floating-point
>    value as follows:
>
>        0 1 2 3 4 5 6 7
>       +-+-+-+-+-+-+-+-+
>       |1| exp | mant  |
>       +-+-+-+-+-+-+-+-+
>
>    Max Resp Time =3D (mant | 0x10) << (exp + 3)
>
>    Small values of Max Resp Time allow IGMPv3 routers to tune the "leave
>    latency" (the time between the moment the last host leaves a group
>    and the moment the routing protocol is notified that there are no
>    more members).  Larger values, especially in the exponential range,
>    allow tuning of the burstiness of IGMP traffic on a network.
>
> Let me check i understand the issue. If the user configures a value >
> 127, linux continues to use the linear encoding, but a peer decodes it
> as a floating value.
>
> 128 linear is 0 | 0x10) << (0 + 3) =3D 0x40 =3D 64. So the peer sends the
> reports earlier than required?
>
> 255 linear is (0xf | 0x10) << (7 + 3) =3D 0x1F0000 =3D 2031616. So the
> peer can send the reports much later than the 255 1/10 of a second
> than userspace expected.
>
> What is useful here is, 'maximum time allowed'. The RFC does not
> appear to say how to pick a value between 0 and the maximum time
> allowed. Which gives us some flexibility.
>
> I think a much simpler fix for stable is to clamp the user space
> request for setting the max response time to 127. That seems like a
> one line patch.
>
>     Andrew
>

