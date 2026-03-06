Return-Path: <netdev+bounces-264946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMYgOAdTq2n3cAEAu9opvQ
	(envelope-from <netdev+bounces-264946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:19:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42024228496
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96682303205F
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 22:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01BA35028C;
	Fri,  6 Mar 2026 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="DQs2h5hw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFE134F494
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835588; cv=pass; b=IRE1LGnGp8R7ElBvGXFGaiW890g2+g2agKKGrLFbll8MdWHOEGk1iDOnRs63KlrpnMNXqLvtCv0ZWl2Yyy7/7CZOu+3h9D5s1IhOkWQjv+mrqwwZXuPv+/A7WTi/2TPkaDZxOokQOM8QgB4shNEV8hAnEBkX8KOK7Uvqh8ogvBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835588; c=relaxed/simple;
	bh=40/opyP63DwtAqK5sVsxkmSjna4LpVB7H/fyosAsNm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4t9XX8YVsWu9J6YhMrtYI1gt8W+629EXYYZLjOBxYsa9jZFo+OZ+bFFeRYM1fU9TFUkviRo5HlzoUBZND41AQgFU70ER3qcPI3Iz4ePT8u3qjEKyD5hpZf9x8bS84A03NtOEMH44JDkCht7jqBQVmVw4IVd46BLMmHr/9WmeRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=DQs2h5hw; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-127380532eeso4735926c88.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 14:19:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772835585; cv=none;
        d=google.com; s=arc-20240605;
        b=HFd0MxQ1dcUykkXAW7QDaTnwRmoCnhDcPoTI3zfjl8FQ24wFm6PyazdczrPJNg9bYr
         CdBTJQ4quvckuZmZtAMJvlHez95ONpU3eL3VPqLydGd6Snl9wfxlaJLLJKtIbQsYiOTp
         uXPTovpoYcAcJVA1v1NVw3lbCicvOqYQu07icuH8LjsLaetKLsMiwg8LSeLoicdvxG4R
         EO3ZLcMRtXT542zr6U1mEizVanfwDZwSgPjjkxjwSRZKvtBZ/IEUrqThgKBLGnNtXRHS
         wXDUlOJKAWp8AlS+EM4Pxsz8ta63x5v7oK1YEvfotLyalxQGW4dWmLL1DmJdua6tLJye
         9RXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mLMbkur/mxWcPJWJ3te2dVJdmws6UY0OGSWn+cWeuVE=;
        fh=n/ixBTKeur/t7m7V136tEntaKWAEatOYekMt+/w68Gw=;
        b=lDR+WHAPLQlzEfsVdvXdUfCGka6xL4B83Wj7PjOAkIMivJfYUw9il/E+XU9T3sqq5X
         oy335B6DC9nryeUmEjedWa9CqmhbpUaoBPSO2w+hYKkrXoBJkjo6w1UgMBPf0YeIAs5T
         O93I3jgOgAXHrOQ53Dt9vFng7kWQso773D8MlXJJ9+QVGPI5PQ1dQbCe35hPu/B1SjDg
         Z/B4zW8610QDRCAb0F82Ho6a9geiNUKEsA6iN7NBZovjCMdcbflpgW2koF7YK8rnlkWc
         3rog8apbRVMIjkHAvbzRKEOcA39EaY25orZnF3TowM8QxW1WV0djShrYq2I5rjYQ5DLx
         0AjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1772835585; x=1773440385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLMbkur/mxWcPJWJ3te2dVJdmws6UY0OGSWn+cWeuVE=;
        b=DQs2h5hwAD1CafcnibtY3Ckk2P6rpX9rLXqtDmvaKR4pWEkRo41lbrA9j9xWeAuS40
         s2gTjQz9ZzVv6KF0wuqz6g+lJFhRdr7toOwldwwILd6cypXzXK3QXXnxKAnbdDj2NUmd
         SFLHwHtprkYYtPkkE/tGP3cRDk6/UAqx0CHanUiliJJV0Wg+dK0z0fEE9hO5qWxg7UMZ
         cZOxUM5IlMcgzhvEciGNWMnx86mH0vBUEw3iyprmu/8pXWRxVRT7tdv0zkCyT8Bs0adR
         cMXljJOqp+0yzbiQsC5fS10fA5CTFeagvvz5wqAuNjqKwUU0npDlJ6CGZCtdXg339pna
         gX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835585; x=1773440385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLMbkur/mxWcPJWJ3te2dVJdmws6UY0OGSWn+cWeuVE=;
        b=Xl6R6HI6hzbgUFZaJTkAl4mT5xwToLx9OckLXUlkMu65WtP7Qxheofm/6scrRWEYIp
         9X08+7QiGfvtuBUS858RCtl4xcFx3BGK9s6S+TNxudSt5D0V49bZiIgvip1QYKjI0csT
         c2M3bx6+iEO2KT9mDWPf5OV5yrAzFETnee/daaVeu20T53YlOM1gVaeS+NHHVFx35NYF
         IR0julrP7T+8dfQtstgNbm3//57vz47QeRTPlPmQTikOtUlPSFzDOgjlTHEUNrle73X9
         jKouWUIn+TuMhnkWPNkrO537ffIIzUR0OHa2H8A3kgZ+1JvUup6gmCGgXrloeljoaecA
         0A8g==
X-Forwarded-Encrypted: i=1; AJvYcCW6BPvwkBin6KRATJzQ124QFsinpp0lDp4zvmo6C7y0/qDJlq2c6JYOVO6cMbL40FbOQZWLKes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9jb8MmIfVmL9bvrpktkRfmhuy7O18ZZ/C66i4Zj5gyk/E9Rq
	Sk2V6LsH2ETDt00CoRKVR8pSBVwXqyyPdg/8anzU7dOytV+JecJ0jktaMWce/+sMJnTJn07Oexa
	S6Aa/735ln/oAWyNTY48r3DR9XSEMWPSHsN4MAEbddA==
X-Gm-Gg: ATEYQzwsSYMyA/F2ghacEvoZ03o02a0WVYRHVWPQ7QMn9pQcmLLcDkIzg+iDA6LTzE/
	qiRrRwS0hjgpuozEk8lg05QCjnst8w4pRCYt5ZTUMFU1Dd5PWyzgTBPOzWJH3l5BgoDrLet3Qhk
	0fUi9pKDodCgiaw9GznpAbqC8K9SvVSMesIkjje7YhT4x+gHDWqtMTPrGVnNnQ+inzof8Dmw/zf
	bm10ELFyCmF+74OlW4QBJY/qDR2evUROdyCocVqpXTzJRGhP4z8XxKJgQIXBE2/v1wYn8t/uP8P
	/f+eutqXgb1FPme0Co4AMj4o19fvB2idL203XWhIKQKY3AB8JyNtxFpB9UVf+C7TGWEv
X-Received: by 2002:a05:7022:eac9:b0:119:e56b:c74a with SMTP id
 a92af1059eb24-128c2deb303mr1616785c88.15.1772835585020; Fri, 06 Mar 2026
 14:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
 <20260226201600.222044-3-alice.kernel@fastmail.im> <willemdebruijn.kernel.346c48b49836b@gmail.com>
In-Reply-To: <willemdebruijn.kernel.346c48b49836b@gmail.com>
From: Alice Mikityanska <alice@isovalent.com>
Date: Sat, 7 Mar 2026 00:19:28 +0200
X-Gm-Features: AaiRm52wN5urXpq0GtAUGLEZE3NZKQbJ4zt8WBssd1nvrLGZ3XpqWeW0_uMHI3w
Message-ID: <CAD0BsJVgvbmk5y5TKkeFcdMLj+VuCWisX4VXv9g15uu=5ddLVA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] udp: gso: Simplify handling length in GSO_PARTIAL
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 42024228496
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264946-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[isovalent.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org,lunn.ch,strlen.de,vger.kernel.org,nvidia.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

Thanks for reviewing my series!

On Fri, 6 Mar 2026 at 22:55, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Alice Mikityanska wrote:
> > From: Alice Mikityanska <alice@isovalent.com>
> >
> > Taking further the idea of commit b10b446ce7ad ("udp: gso: Use single
> > MSS length in UDP header for GSO_PARTIAL"), simplify the implementation
> > and fix the checksum (apparently ignored by hardware anyway).
> >
> > The mentioned commit started using msslen for uh->len, but still uses
> > newlen to adjust uh->check. If the formula for check is fixed, newlen is
> > assigned but never used before the loop, and newlen is overwritten after
> > the loop. This makes msslen not really necessary, as we can reuse
> > newlen, if we don't adjust mss before.
>
> That's a big if. Why is the udp length now set to the segment length,
> and not to the GSO packet length, as before?

Just so that we are on the same page: the behavior of the UDP length
field changed in Gal's commit b10b446ce7ad, not in mine. You reviewed
that commit and approved it:

https://lore.kernel.org/netdev/willemdebruijn.kernel.218d53621fba7@gmail.com/

I'm just refactoring to simplify the code a little bit + fixing the
checksum field that went out of sync with length after Gal's change.
Hope that clarifies it.

> > The adjustment of mss can be
> > simply dropped, because mss is not used anywhere else below.
> >
> > This brings us back to one variable, drops an unneeded arithmetic for
> > mss, and fixes the UDP checksum.
> >
> > Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> > Cc: Gal Pressman <gal@nvidia.com>
> > ---
> >  net/ipv4/udp_offload.c | 13 ++-----------
> >  1 file changed, 2 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index 6b1654c1ad4a..e831234326c4 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -483,11 +483,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> >       struct sock *sk = gso_skb->sk;
> >       unsigned int sum_truesize = 0;
> >       struct sk_buff *segs, *seg;
> > -     __be16 newlen, msslen;
> >       struct udphdr *uh;
> >       unsigned int mss;
> >       bool copy_dtor;
> >       __sum16 check;
> > +     __be16 newlen;
> >       int ret = 0;
> >
> >       mss = skb_shinfo(gso_skb)->gso_size;
> > @@ -556,15 +556,6 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> >               return segs;
> >       }
> >
> > -     msslen = htons(sizeof(*uh) + mss);
> > -
> > -     /* GSO partial and frag_list segmentation only requires splitting
> > -      * the frame into an MSS multiple and possibly a remainder, both
> > -      * cases return a GSO skb. So update the mss now.
> > -      */
> > -     if (skb_is_gso(segs))
> > -             mss *= skb_shinfo(segs)->gso_segs;
> > -
> >       seg = segs;
> >       uh = udp_hdr(seg);
> >
> > @@ -587,7 +578,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> >               if (!seg->next)
> >                       break;
> >
> > -             uh->len = msslen;
> > +             uh->len = newlen;
> >               uh->check = check;
> >
> >               if (seg->ip_summed == CHECKSUM_PARTIAL)
> > --
> > 2.52.0
> >
>
>

