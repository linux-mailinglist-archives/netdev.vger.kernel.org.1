Return-Path: <netdev+bounces-296250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ISkKWOBJWpGIwIAu9opvQ
	(envelope-from <netdev+bounces-296250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 16:34:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF2650C38
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 16:34:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=g98Jo6+i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296250-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296250-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 707D3300FEDC
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BED3AA4E8;
	Sun,  7 Jun 2026 14:34:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4773264D0
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 14:34:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780842843; cv=pass; b=gR+Ua3V94t4gvtiXi13EY7tTH1okz16WUYkyTXQl+GqeAU3ib93Pxk2bPRJ9YF74cZXE9sR+CWEj8axMNsg32S9F8sOnqSKV2WT2oE+xqEJZ80wIZR6Hoi1DWNQCUUdG0iVKyQWEYVD1RDGLilX9Mw4/JXIYp9NJ6os9+EA3hr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780842843; c=relaxed/simple;
	bh=T9GE5eXzrNAz4VGE5rOsvFKtLGT8u9fcz4i/AknuEgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heBqaPckjKDsgf2SCw/HzBKCHbvaq3GvGQ6AlBDhEGuEfxOFAQG8pNUB3pu365eK1ibq79EN0WP+9Vbao2Dlh9IVzTHNh14/tanMYs5nKreVKfyNqBlSVWELR21DW8rEFD87nWkRpxlE8pPcB1L57pdXlRXcOJwqh/7M+qeV53A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=g98Jo6+i; arc=pass smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa6863327fso2905795e87.0
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 07:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780842839; cv=none;
        d=google.com; s=arc-20240605;
        b=Z97hvdU867naA42L+7jJWTfHgiHUC/rBQqQLmMEme6nvenwkVkK6JHQ2Dp9ASJBCsd
         eTwABOk91pgTYL89L4BDJMOFobC3zz5+G9XKQ9wJfbOpF3SoO+GNnCW6dS9NRp8z6APp
         5llGQJ1wd/TfHvz3QtW6nqSoM/E/GBVlpxS1DYPbpqzknOi6BK4nlDoIume2Ys466aXI
         ogNfMrbD+hld7ZkFjvO0ftkOE8F8BfsKOx7WXmfwG91bIBv6arRymIFc0CfgkN0Wetdk
         +MkwfJiqnlLOtaFkRSmIT431rFr3BqGCF83MDxJqMXNK1pD/d6UtzKXpZZNEDR9a0Dvu
         NrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7C14YURADh7hq1Zism3wRTF+TwlbmOv0MNpx2ZDOl9E=;
        fh=jDQM5lXtOenJ6CEZkKeFvxFTY7+lPiMAd7dmuII+5Rs=;
        b=iAZimdPkz+xYipwrZyuci8deEeWJUt4FWRM0dcT8dC3vi4fxg3U6sDX4PP0BXE/5Da
         QsY7vk04MyDyPFYoliEFn+kV+TLxZ77U+r0tvEpRYJAUqz92O+IlQy8OrbQ1P7FnlOPX
         l8Fq8pnv3PSDkHVwAb5ZCx5lMznii0PGsO0/Dwl/23RkXApYlMSxtLUxJC4d8PTfKrKH
         DlSgic5A1hmeVLzzNQq02mMMoc4bw5xb7UbCbXzir9il0UNEnPzkOMCxsSoJKIMu+0SM
         Wu8g9nas3EoUrpOEufC5HGp/HKt4VvrqEqn/I859r8RcWIwsMiszpBhB67p1raTzlygt
         Wz6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780842839; x=1781447639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C14YURADh7hq1Zism3wRTF+TwlbmOv0MNpx2ZDOl9E=;
        b=g98Jo6+iO1ol4OuNSTNTrFG2zQ2cvNnzU2E4nNfFwPFkL9LETvgmCUyHym126h64Jc
         pGO2HWwZeoVcrmD9xjrTMTnveFcO0AQro5N1vnUGgAlFRpGLQB7Lkb5kPCiTwvzYAKDx
         1rfpI4rH3E/Z5lnv5nDNuVgdSXJ3Gb1SZfsn1g3eFMzLQ5qKQI6UYKRON9VcVl/nQbYO
         7TmwMhRdbzFzAJKbJQQJcE8HGsQszoGgibQlqVLniK2q8EcZ8fGRQ1CPSr2ns4VcAJrC
         hLd/ymHD+KId9+k2yI2L/DdoTkD2IwrmIRaKcCZKh/9wbIcMDaiZaLWSmRvlpoabr7LV
         mzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780842839; x=1781447639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7C14YURADh7hq1Zism3wRTF+TwlbmOv0MNpx2ZDOl9E=;
        b=aOiLDeUgf0BxWbfSnWy4vtXRsVjisCrcAfdThyNhtbIo8kClvaddT+GMyd1h5iwpBD
         wk+AWO8BqqA2ArX5G3bq1fheY9OVB6EUwGiZ4/4HAQ46vW+tUdAdsyF9XSOqVtKaaG+v
         xsXK85Y8XM0U2Pan1UiuhkSyvFJZT/93UNx9cSHwgAgj/cyZmIYn3kA7R7b71WVGf102
         5/YzUkT1JueAAERK57BZCFbIessPqzLGzsvJBBLutlmlfPyPxe5+VfC7at9hK0Ea7PCB
         y1mLdIqD3ZsFp/awW3BmXLrts2tPipZpV0M4C9Y0FLBEwYfJ9lh+rEE01z7A+7/EPGL5
         xJ9w==
X-Forwarded-Encrypted: i=1; AFNElJ+B3MgDhPd73GXgwsEk1PoWznoD4mm88R3g1ZTKr6iDxQgMBB60kAfOUhp1gdl9glkqlqPDpvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwf1Qj1XhoQy5MXCCmUXqjUhFlilqSSVkR5pLfMo4KO4mqKV/k
	S2yE3pnSMM60EjhbD/Iv9TEoSI0tkEfKWt2Y2FbVHEftkkyMa6nn1IYU5m1TabjIv3BuLJWoRZE
	Lb64MSi1dHhGAQZQPY/sjGKZqo9EIy1TUsdZ7mqsRhKSwx0gyjox2DbY=
X-Gm-Gg: Acq92OGXy36+eoFqz4+Q79ymEUJKBOVzEDSMBzoZ/XQYfbA1vgsOFmeDs2cmwjDXZLO
	gtugOH0X39KZa9zhgGRG4aPcXPn+2DBtalVXWwwLZ6YckPPkzeePS4cuUYuPuUwG5G8tTuCQ1me
	VvUP47CWXFPkFMBHVd4BNuj1SzFrMkARPbYgo0g/WIqjnxIfoN6v0jRV1ng75oxmUbYy7fX3six
	CLQQ5tFssqjrPljcsdvZMuUOXIuNLLzzUmmVU3mejch8jXMPe+Mvmhe3v1pOY4s58IqyamZ13hi
	1UrkD6cpXZ+47HsJ
X-Received: by 2002:a05:6512:15a5:b0:5aa:61da:f44 with SMTP id
 2adb3069b0e04-5aa87b670aemr3347321e87.5.1780842838503; Sun, 07 Jun 2026
 07:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605194640.2645386-1-sam.moelius@trailofbits.com> <CAM0EoMmeftLxWNdQqWsJonxEtMoCCuJdeTEjNzQfc2GYUX+mtw@mail.gmail.com>
In-Reply-To: <CAM0EoMmeftLxWNdQqWsJonxEtMoCCuJdeTEjNzQfc2GYUX+mtw@mail.gmail.com>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Sun, 7 Jun 2026 10:33:47 -0400
X-Gm-Features: AVVi8CfjDvxpey4KY4eMr6JTO65pRw4-bmDI3IJwXZQ-lDcBK3tVHTPesMTdCOg
Message-ID: <CAE+C+DZTme=GQBy9BaXCiPe0pO7Pv7XNM69iru0VTGFX_ybBKg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_pedit: require matching IPv4 L4 protocol
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296250-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,trailofbits.com:dkim,trailofbits.com:from_mime,trailofbits.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47AF2650C38

On Sat, Jun 6, 2026 at 5:29=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Fri, Jun 5, 2026 at 3:46=E2=80=AFPM Samuel Moelius
> <sam.moelius@trailofbits.com> wrote:
> >
> > The extended IPv4 L4 header mode in act_pedit can select TCP or UDP
> > header fields without confirming that the IPv4 protocol field matches
> > the selected transport header.
> >
> > That lets a rule written for TCP or UDP modify unrelated payload bytes
> > in a packet carrying a different protocol.
> >
> > Verify the IPv4 protocol before applying TCP or UDP extended header
> > edits.
> >
> > Assisted-by: Codex:gpt-5.5-cyber-preview
> > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > ---
> >  net/sched/act_pedit.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index bc20f08a2789..9a4590451f7e 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -341,6 +341,8 @@ static int pedit_l4_skb_offset(struct sk_buff *skb,=
 int *hoffset, const int head
> >
> >                 if (!iph)
> >                         goto out;
> > +               if (iph->ihl < 5 || iph->protocol !=3D header_type)
> > +                       goto out;
>
> From inspection the fix looks reasonable.
> At first glance it seems that the only fix that resolves the issue you
> are describing is to check the protocol header.
> header length seems to be an extra thing. But let's do what the v6
> side seems to and skip frags as well? Something maybe along the lines
> of:
>
> if (iph->ihl < 5 || iph->protocol !=3D header_type || (iph->frag_off &
> htons(IP_OFFSET)))
>         goto out;

I will submit an updated patch.

> Are you able to describe how someone would configure a tc rule that
> will allow this to happen?
> IOW, how did you verify the problem and then validate that your fix works=
?

The bug was validated using a custom init script in QEMU. The specific
line used was:

/usr/sbin/tc filter add dev veth0 egress protocol ip pref 1 matchall
action pedit ex munge udp dport set 18053

An IPv4 TCP packet with destination port 2222 was sent through that
path. With the unpatched kernel, the packet was received with TCP
destination port 18053. With the patched kernel, the same packet was
received unchanged.

I can provide more details or artifacts if you would like.

