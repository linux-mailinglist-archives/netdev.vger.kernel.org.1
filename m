Return-Path: <netdev+bounces-255199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPopM0fpfGlTPQIAu9opvQ
	(envelope-from <netdev+bounces-255199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:24:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD64BD05C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B003068158
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECB535E55B;
	Fri, 30 Jan 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="WE3/f3aL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795C35CB6D
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793780; cv=pass; b=qtQjN0Sa+kbL7TL50i18Mo3Gw6k/+/tpbDla49vxz1y5+Pt7eyzekB2RiCqOTUylrC5gEXrXY7iJhoFLDGStS5dE18i0NBROGY9aJb+f+rnVAdWy2Rs8zjRYf2w+2nMLkEprdf2Fx2+dyZZ4x9zNGxkhuMm1PXsbuwojam51flY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793780; c=relaxed/simple;
	bh=ocjG46c88QGqMkXQFFZZO7jfT8JcxSXik8sxiLd2fUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pl/9+8aoOAqFWil1gPbnd+1XgYwRKDCp8SvrQmsQv4bM4usyBBK/CXLlrD44em0eVWrhbvFd4SHAGZ+Sqqikqh/XvxyKYInqfaTMNflZsKNAE0DS6Dnph8ZfyJwrvMYDexYz1TsQqPfVLo1DFY2CvjH8/P6sefxN7niAF4Xk/iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=WE3/f3aL; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-385b5174f54so20293951fa.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 09:22:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769793774; cv=none;
        d=google.com; s=arc-20240605;
        b=RNyYaPMYZjYaZey6W+zpTEPlWD9JDMu8fFZRyrdg7g/K1R3dcZt6H2b0uuxYgTnsUv
         5+8FjraAGi45K97Nl3MK2ucynE1KPNoMYzvZYS9H7YFdmKjWcI/DxsVKRGZiI/trFNdi
         iQJgFUnA+Vt3iMsVY3Q8YjmSLonxg5AFOCRSIfewE/b7UIrRvkPEGIcYFDql4hXBBzXR
         b+lrnT3ZECHX6TYtJHYwcDayHd9X2s+JR77d0ZWRYuPQ8EJ3DoUHAC2qvesfB9ldrmZI
         UVI3SRUbPuaxqnX6yFKVkIoup2ss4dETEStiNyLBqNa0y2uJbVjJzvblDjx/7Kosd+Ii
         0hsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2jTh3EtSrX+tiLurIKSfJpP9a1rQldqnpR/gv89ljaA=;
        fh=atUgrihWuAdpbARaTVJA5ZvnLp3d5A7dHp7VujmWYgY=;
        b=P/wzDmN028nH8sBqfs5Ckm9k6eZD24t2STsqrue6zXm0EJQx03MyQxez/YYKPobiO/
         ZAlBaYdf/fQf3dAjCIK7bMhuf6Ff8HD1vejfTXetl0n1YOzwxRelCX6d9jwOS0IIRoET
         BthcTcFwcxuSF0PxRKkf4+UmxxCNxDmmFaxQpT4U3HR05QvssN+FGKF/eDbPUSZwufjP
         lHMD2AKhrKCZP+CVk8A9cvCM9uR0t1uBq+oSJNWNOVbXx9pMLvhkndyEUCrBCrSy6OCb
         yIqsXwMtS18ZSen7568XvhgY1SwD6MBu5RnWClg0KwQtCTfTFrqB9fmB8Km6MSy7iVIm
         LgoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769793774; x=1770398574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jTh3EtSrX+tiLurIKSfJpP9a1rQldqnpR/gv89ljaA=;
        b=WE3/f3aL49lltjLVzq1UDSSS1fNdjT8HsbKQtNIER3CEvtgEZeDu2Xyo0S2Z3RMdnL
         1u8jCM8ntZaSoaU6jP0V09LfAlf52lbFmZog7W2Z0mtMrf/Z0lvu6TwGsdw56K1YMJAS
         5S/IWpmUBNhb6oV8LDpV+GrqFniEQNdEt0NvSF2CUR/yEVe+sjHX2vGmVHShVDbmtNS/
         eSiSIUHAZZlQJbplXUMESXqm4g4xqAGml2NKUEf5trwmyFoIXAukdaP+BDE+UhvFAiGm
         oDW2r8jqBOniSELHQL/Y45xPbrISJcqTh15zQI6x3JpiyMZzq2Ii8PAdsC7kfigAVQdR
         vmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769793774; x=1770398574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2jTh3EtSrX+tiLurIKSfJpP9a1rQldqnpR/gv89ljaA=;
        b=IYaC/M650su3VoSTLmpioH62ZbjD54ZpQPhRfY0Y4DNc8afOjtbsD3ui1wwya2SCVJ
         ckkZL4nzYvrqKjNwHQyWRmBICbkfc3aWvqEqxi6cSo3ce0oCxhkM19B/zm7eezpKPNfJ
         UNdn5OpFNK7aLsYkk68PFwY/BJhX3PrTeHK3B2i6B9Z5pfWDO8ixQIww1MLCVR7pRGWH
         zHElxnyRC7WSRrdV/IkP/POMbrH7Do7cSET0zwr0IAdY+2Kp1w8SZb3q5kIGT2UKmW4A
         qgXyi6lApD2oj7BiBUWk4s7t6MpznUzd4jn35eyKqu37I9dSxwZHxbbf35WVICQPFr7B
         yRWA==
X-Forwarded-Encrypted: i=1; AJvYcCWDIaXcg0ufzfrVKTNOhwXk+zfBQIvIkyZuZ74gnNtevpAU7ulk2U9bfQoWv42TNMv2BHRtwOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznvcracyosCDNkLbMhXyAtgBJ5skKXUqMFwizsPyjy8TO5y9dB
	3dyABBzxvW1zEMXPUcakX8HdCt71FheHrubU+bSrxSqY8rm+57M6GiRjdVQ0Kw8mRQaFWp+1tV/
	7ZIqp78Kj2/gZ06oRW9Wq2B3EIbbkQwpnxXUqwrQNbgz7WCm9fKk=
X-Gm-Gg: AZuq6aKDf/cfSUSUaslSOcGWky0yP7fzdF63b6ASAtEX77QKMcNAB1tUiqNMWjiBUun
	GiAA8KCScciqjgvj9ENLaejBhRNzC+1uOizL7QhMwnoFpLJ6eGH6RTnJzAo3z8hssXLtzKE9yfl
	BzzT70EpxCntLKB4L/InZjqcKJDHLASAGyGAbej0ouEa+mgSly0Ohc7qNmYCEsP77YCDAWctC5I
	P3LojYgRjEc7YEWbC2/76RJ5g1sFrUJlByBkrZFSNQjjslOtCAUufJ2I9utgZjEqX7JynwwPnR2
	WRnXFbuvlfFFOqr63yA05r/b34gmb8GV7agSwrSO8VlQFdXbjdiIFhLLrxRy
X-Received: by 2002:a05:651c:50d:b0:382:fb5b:38f5 with SMTP id
 38308e7fff4ca-38646538b3cmr11855581fa.12.1769793774335; Fri, 30 Jan 2026
 09:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126194826.236075-1-tom@herbertland.com> <20260126194826.236075-3-tom@herbertland.com>
 <willemdebruijn.kernel.235a1f46c52f8@gmail.com> <60fb02d8-77ca-457b-be24-33a3cc7b344b@gmail.com>
In-Reply-To: <60fb02d8-77ca-457b-be24-33a3cc7b344b@gmail.com>
From: Tom Herbert <tom@herbertland.com>
Date: Fri, 30 Jan 2026 09:22:43 -0800
X-Gm-Features: AZwV_QjWPMwor3uUGO294d47RvW_z90CFWfED180mww5EX9S4BEfpFmxZTlzS6M
Message-ID: <CALx6S35Z63WDMOkZLJ7PzR6BcEV4h5f7Jm-Okw9izcuFcygNoA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/7] ipv6: Cleanup IPv6 TLV definitions
To: Justin Iurman <justin.iurman@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BD64BD05C
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:13=E2=80=AFAM Justin Iurman <justin.iurman@gmail=
.com> wrote:
>
> On 1/29/26 06:30, Willem de Bruijn wrote:
> > Tom Herbert wrote:
> >> Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
> >> of the TLV definitions. Label each of the TLV definitions as to whethe=
r
> >> they are a Hop-by-Hop option, Destination option, or both.
> >>
> >> Signed-off-by: Tom Herbert <tom@herbertland.com>
> >> ---
> >>   include/uapi/linux/in6.h        | 21 ++++++++++++++-------
> >>   include/uapi/linux/ip6_tunnel.h |  1 -
> >>   2 files changed, 14 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
> >> index 5a47339ef7d7..438283dc5fde 100644
> >> --- a/include/uapi/linux/in6.h
> >> +++ b/include/uapi/linux/in6.h
> >> @@ -140,14 +140,21 @@ struct in6_flowlabel_req {
> >>
> >>   /*
> >>    * IPv6 TLV options.
> >> + *
> >> + *  Hop-by-Hop and Destination options share the same number space.
> >> + *  For each option below whether it is a Hop-by-Hop option or
> >> + *  a Destination option is indicated by HBH or DestOpt.
> >>    */
> >> -#define IPV6_TLV_PAD1               0
> >> -#define IPV6_TLV_PADN               1
> >> -#define IPV6_TLV_ROUTERALERT        5
> >> -#define IPV6_TLV_CALIPSO    7       /* RFC 5570 */
> >> -#define IPV6_TLV_IOAM               49      /* RFC 9486 */
> >> -#define IPV6_TLV_JUMBO              194
> >> -#define IPV6_TLV_HAO                201     /* home address option */
> >> +#define IPV6_TLV_PAD1               0       /* HBH or DestOpt */
> >> +#define IPV6_TLV_PADN               1       /* HBH or DestOpt */
> >> +#define IPV6_TLV_TNL_ENCAP_LIMIT 4  /* RFC 2473, DestOpt */
> >> +#define IPV6_TLV_ROUTERALERT        5       /* HBH */
> >> +#define IPV6_TLV_CALIPSO    7       /* RFC 5570, HBH */
> >> +#define IPV6_TLV_IOAM               49      /* RFC 9486, HBH or Desto=
pt
> >> +                                     * IOAM sent and rcvd as HBH
> >
> > Explicit labeling with HBH or Destopt is quite informative.
> >
> > Does this mean that IPV6_TLV_IOAM should also be accepted in ip6_parse_=
tlv
> > in the Destopt branch? RFC 9486 indeed did reserve a number.
>
> Nope, not right now. The only IOAM option currently implemented in the
> kernel is the Pre-allocated Trace, which uses a Hop-by-Hop option. It
> wouldn't make sense to have it in a Destination option, although you
> could (i.e., it's not forbidden, just weird). Actually, the only IOAM
> option that would make sense to carry in a Destination Option is the
> Edge-to-Edge (E2E), but it's not implemented in the kernel. Should it be
> implemented at some point, then yes, you'd have IPV6_TLV_IOAM in the
> Destopt branch as well.

Justin,

Conceptually, someone could put IOAM in Destination Options before the
Routing Header. There's about 0% of that ever happening though.

Tom

>
> >> +                                     */
> >> +#define IPV6_TLV_JUMBO              194     /* HBH */
> >> +#define IPV6_TLV_HAO                201     /* home address option, D=
estOpt */
> >>
> >>   /*
> >>    * IPV6 socket options
> >> diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip6_=
tunnel.h
> >> index 85182a839d42..35af4d9c35fb 100644
> >> --- a/include/uapi/linux/ip6_tunnel.h
> >> +++ b/include/uapi/linux/ip6_tunnel.h
> >> @@ -6,7 +6,6 @@
> >>   #include <linux/if.h>              /* For IFNAMSIZ. */
> >>   #include <linux/in6.h>             /* For struct in6_addr. */
> >>
> >> -#define IPV6_TLV_TNL_ENCAP_LIMIT 4
> >>   #define IPV6_DEFAULT_TNL_ENCAP_LIMIT 4
> >>
> >>   /* don't add encapsulation limit if one isn't present in inner packe=
t */
> >> --
> >> 2.43.0
> >>
> >
> >
>

