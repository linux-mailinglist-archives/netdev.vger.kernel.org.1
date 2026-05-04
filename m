Return-Path: <netdev+bounces-283740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APuhNYhR+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:58:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E40704B9BFB
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42F9A3006239
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC73128D7;
	Mon,  4 May 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6NkiqGC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446C30F7F3
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881426; cv=pass; b=G3fNRZFuw0s+DHZczO86yD55f1epqLvhzj8/p3fWFJM8qOqiBU6Dn8pktKdJSx8Rtx80XBtB1083AMS78UFYpL9XoLiyrkI4tYTheTfgSRFpKj8bqWxwpY5hJXDLne5bTk08aEPU2XnDIQZ4dt+/JbthetY4uPcqKq3a8lUnaHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881426; c=relaxed/simple;
	bh=grV87D4KnRrDCveP21GyYaxC/ikTUnHKA2de2Ijk+Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XplI9zyyzR3LNeRlSDEG9CI8PMsgQTiUQddcniODgVisfnzigDqPVGGChz2XqI+4CFX5seTnrjAz05sUwYceIGVERpkKeRl3qiMH2iRWeJu7g6yg0Sujk3diXYbyycXdsKyc3lhkGX3s7akhJCPxotoYeMfCGh366V1LULHLQ+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6NkiqGC; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50fb1ad3734so42398411cf.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777881423; cv=none;
        d=google.com; s=arc-20240605;
        b=EnxDSLmrUT4FkXyvHq/8YXpg5j5ZyduZVWV010jwzkYc9mPbIraUm8QKgqeyDpv3zt
         X3j4k5qs/6oAp2lvnNFjalLn1zBZ4o6OitF9ZTbX/65HJlVOpL5sbPcyWraGHSThyiRF
         JlGG+0KLmLxpm98O6utoO8T59wW13rLk4Eq909JBAW2brnWxJsQEP3RZSi3FrVBivRZs
         loc/8rmEGxLHXqsaPcYWb4xRgZA2jZX5ZWiPqhMYXKgrY1iDWQxjxXBYOnrjZj6EosF7
         V2/goSiE8y+34ZbVztWlmPwNVpyY9pw++VWzcpNp/ceGJsZ5tBDzJFNwaCxGACAE+s3s
         bpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cuH7qR6pBEGQ7SVERasDZ3I/lDFydIi9a2rl1Ke8ZI8=;
        fh=Gp3zqhMukuHKYYKcMMrIkXsa8EtOo4kHaIcROXIbehA=;
        b=Thbb+TZjCE2Hv4p6Gx4+3lmbtZBRziMHcGavMmoNOQAw8i8qd43KNoGH0pGRRMb8VA
         N9Bl2wMmx+Pe9F0Sr3kruqTgCsFdoCL1x3cAPBZal6ovtYybGU7rLTw3w4UhSXETw9h/
         yoF1RiIZLbaWLsgFtBThSLYIyqcClkwYlm6F++2Tth3aA0dn/cTIKmmsquKcIGhrHwgE
         0y2fQArG+36xxl9fvZdW6omT5rFWyTa3TEKHHc8qtLhao7JjU0Sc0JDMfkPO/HGoTUgq
         IHGA/1gfwCAdn1lCj3MY5U3FnXHA0Lpoeb3UMdj2DJFPl+Hv78iaJP9KMdrqF9S2usbz
         4akQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777881423; x=1778486223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuH7qR6pBEGQ7SVERasDZ3I/lDFydIi9a2rl1Ke8ZI8=;
        b=L6NkiqGCk05d38tiqgqTERuZmmBngWD7b2IBM6J76j3t1TCsM5CAZoxf7Ba1lQRVEE
         OtZ5Wpo+uO9pTYP4521d1+WcdL2sLtrkttV8845HcsGfJ/Tk1e292j78hoLPFq3IxBZC
         AVU7BeqWHo9grbPspi8SkC+i0akviHF8DgrV+mFhzeITllzZ8QvHlC9T2NHQa9AArKu6
         uhSXxdk8zLpjnnQoaGyGi2quxr0hiZ8mKdKlNKzh/HpdRJjCCoAMmPN73FTuopndMsGq
         qLDX5tKO9FDlayMmbJf5vCRxSOEu9eKfUwjEtSwrlBtg3+KpHfGB+85KLpsOMauj0zgG
         QIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881423; x=1778486223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cuH7qR6pBEGQ7SVERasDZ3I/lDFydIi9a2rl1Ke8ZI8=;
        b=IybQ31cNkg7WMkbZoZLeTMDByEeYcJBFpby/nhG24WDsN0ZwpyQG+xjnHnlLrUKNUo
         QyeItn34Eim6xu61x/YK3edBOVnued1igqkVO9DNJjZwWiQ4cMKgpMq+NE1F/aoqi8Hn
         /SBmTJqU8BShLdvpSW6YKsG2M49IGTIBTY5TiD2gsiKptFXaqZBcPb3oFEspNAY0VCHt
         ewDxGsCP7MxmScPlKR4C+H1mGYcin+vRfyh+EeJO7L3Wv/hlpC26oWczEWkGcqAdQoy9
         RJ4dHEJcH3T+MoGzjDvp7LzYPRmasv8T5PNzOYieTbRuCQfUrbC/5421dBhLI7L6yTwM
         iltQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bf0owAxBEKmA2tAQEvFeF/5s/gR7AH3ymgKbPw/qdhUgjfdVBNyZ+1zjBGoL5y+AkyLMHVPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCw+2HU/IBMY2Sa6rUQXLqI4pY3FFb9Yl6/lf+3VfKCidY6Igx
	urtFFB+R1chO/hU42tbWvdJ2Bj0XI2sLjwhWvaEG+rgGNBk61g2BFGfp+8EVvvTRuasZ7o2JeGS
	bQQF2LcFKLugLfS9F2sR+VBJQNulJmOF2K5RhP25d
X-Gm-Gg: AeBDietjOSa523bYp5/uENW/KuHv0GhLMxQZp6QsI9Q6zE4LCuHIQprJ82l6sVF0w90
	o953rOfThsI5aV1tkZ3nj/hl8+TNV59uhKSUPLh2POMVnLcv2kMY2ud/fnEnFxEERIH07/6DrbP
	YpifeTWwojJwI2VsoNaT9RFa39TJpnlPo/4EeQNXoopc97G5Gocr93RU8VU0Ise+JiJkdeyeWjv
	BB0ENY/enasynxATpOLn0I9VyEAg8IFL93WBzw9jXJJdyc9hGTGsNUvoDElfUIHcumwmcW1oiZ/
	JO/Gg4L4sws3LGkQgJr9CxXGwcOg2HRmptjeBXJW5QrqUZPR+DBpb4lgyiN9/bVGbzXzZJcYJnR
	NlFfeXOSbBnDZboVDI1E9KaQEcsKZpGYz7hEyYYE=
X-Received: by 2002:ac8:7c47:0:b0:50f:bd19:657b with SMTP id
 d75a77b69052e-5104b484d0fmr111060441cf.10.1777881422720; Mon, 04 May 2026
 00:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504073403.38854-1-h3xrabbit@gmail.com> <afhQjlpmt2agPcRE@secunet.com>
In-Reply-To: <afhQjlpmt2agPcRE@secunet.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 May 2026 00:56:50 -0700
X-Gm-Features: AVHnY4InOZkTy45S5ArrVjoXUkWOTK3qOngu6FhvQFBjvoBHZi9oTl1o-iGk3TM
Message-ID: <CANn89iLeX5eZuH6c=_HcADzgejYzE36HhFxmvg+2U3gqsOqHkg@mail.gmail.com>
Subject: Re: [PATCH net] xfrm: esp: avoid in-place decrypt on shared skb frags
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: HexRabbit <h3xrabbit@gmail.com>, netdev@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E40704B9BFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,redhat.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,secunet.com:email]

On Mon, May 4, 2026 at 12:53=E2=80=AFAM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> We have antoher patch that addresses this issue in a different way,
> so Cc the author of the other patch.
>
> On Mon, May 04, 2026 at 03:34:03PM +0800, HexRabbit wrote:
> > From: Kuan-Ting Chen <h3xrabbit@gmail.com>
> >
> > MSG_SPLICE_PAGES can attach pages from a pipe directly to an skb. TCP
> > marks such skbs with SKBFL_SHARED_FRAG after skb_splice_from_iter(),
> > so later paths that may modify packet data can first make a private
> > copy. The IPv4/IPv6 datagram append paths did not set this flag when
> > splicing pages into UDP skbs.
> >
> > That leaves an ESP-in-UDP packet made from shared pipe pages looking
> > like an ordinary uncloned nonlinear skb. ESP input then takes the no-CO=
W
> > fast path for uncloned skbs without a frag_list and decrypts in place
> > over data that is not owned privately by the skb.
> >
> > Mark IPv4/IPv6 datagram splice frags with SKBFL_SHARED_FRAG, matching
> > TCP. Also make ESP input fall back to skb_cow_data() when the flag is
> > present, so ESP does not decrypt externally backed frags in place.
> > Private nonlinear skb frags still use the existing fast path.
> >
> > This intentionally does not change ESP output. In esp_output_head(),
> > the path that appends the ESP trailer to existing skb tailroom without
> > calling skb_cow_data() is not reachable for nonlinear skbs:
> > skb_tailroom() returns zero when skb->data_len is nonzero, while ESP
> > tailen is positive. Thus ESP output will either use the separate
> > destination-frag path or fall back to skb_cow_data().
> >
> > Signed-off-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
> > ---
> >  net/ipv4/esp4.c       | 3 ++-
> >  net/ipv4/ip_output.c  | 2 ++
> >  net/ipv6/esp6.c       | 3 ++-
> >  net/ipv6/ip6_output.c | 2 ++
> >  4 files changed, 8 insertions(+), 2 deletions(-)
>
> This looks ok to me. From the IPsec point of view, I'm
> fine with this patch, but it also touches generic
> networking code. So I'd like to hear an opinion of one
> of the networking maintainers before proceeding.

I have not seen a Fixes: tag.

Do we need to split this patch into two parts?

