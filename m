Return-Path: <netdev+bounces-256026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIW4NPEqgWkwEgMAu9opvQ
	(envelope-from <netdev+bounces-256026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 23:53:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F633D2815
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 23:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E78E4314179D
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1903038E124;
	Mon,  2 Feb 2026 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="FlQP8GBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7835BDB8
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071858; cv=pass; b=TgNFrrWMIuJYCi7tNIbtbgPES/DRrAsDcoQr5+ndNkvCU680mNP4t39cPiNC+HWZo0LrrPQRrVLawCMZkAKLp6EksvCZI4800UhIm8R3/frHpaKo/8v8vfaLuxt4wxAlJvJGrVwCrk0jIGaRMP1dw/0w+7iD3wJ/bY+BnLKp+3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071858; c=relaxed/simple;
	bh=uqpVk1kXWM3Pmy/dC2HNpzzdgmO4DjT0q/bvcdp7gk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUhwwwt2AOpbgePSNBE0Sp5vT8yN9zkdhvHs1/dbaPdASkJrMpV3b2JQMmVlqUDrMupan+qX9KOQNB60u0O7Bo0GOH+BVZqTCNHaG9kmXUQDloTCpcMeGIzAVBMITEmSF6w06TDN4wditVvu9pyOEiZ1VreVNXT+C4jKRSt/JhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=FlQP8GBC; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59de8860b94so5911599e87.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 14:37:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770071855; cv=none;
        d=google.com; s=arc-20240605;
        b=QkIKYOr6LVY5HxMvZ6Bo10+4CgKEZrzs5dXxSkQQe4ShKoDvA+6CU0ZG50dfHv24gJ
         MWOqCL1gHc9YZLa03e0LXuJKDQ1tnWNvJzgl26zpx6dnnJckpMmNRKPiCWpCFsZf+HMM
         j34XMbZJ0GX+qi7NrPcdbgrfNSVZGOcZ/dMXy7G89VnA19Y9nH08xcVGBaF8gXAAfhGS
         ojJTHRSoMA4O81NXwLMvJORX8CrsMjI1DF2+Lj24I/SUV85swjOP17MQBe5tXJfVUB0Y
         SpoTldArR2xjX04DGbmR6Rb0N32scDLVPZuafd/csdJhlOwRXBUtIkdkjQYFxbJ+aEAi
         od0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rld5NdYNgKbh8fG9m8l42rpH9XuNkYcLSLYsgKSKvp4=;
        fh=BME+by8lQv8ih3QsC8/89cgMc/SDcxxAy3w0ajaed74=;
        b=LHq+lqwxOH3FnTTeBppeyms4ynZO4d7CIVew4y0TbY0MtvfllV2xe2y4NwxOQcJ7er
         farAmbf2pKDADpnridaRte2Hs4useXRcz874Tr1r/QPSfiuVVxcq4EP6wyVjST0tBRc+
         G7RlIKRm2s/MrAUVLzfNQvXOCkqh65KRrLVJNATsIDgYY3hRgbhAzGYsliDIGHHotrxr
         TFfkHlZIIlI2PguzfXnVO1jyMfwcBK+h4vKFUu0HP60QAa2jVwGuHC97h+i9ZBpn6lCI
         1TFxoWIOT7vUJ77oyUa6tJ5HZZmtb+4T+j9qTCKAIwXftO7n8MoHD1JrCp3hbTuQiYnp
         n4VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770071855; x=1770676655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rld5NdYNgKbh8fG9m8l42rpH9XuNkYcLSLYsgKSKvp4=;
        b=FlQP8GBCrR3Rb3Ne/Bnv6jHetFqiaxQPrWl3B/NM3xWmWXFPwTmXeHZfbEuNeCI0js
         Q7DFIOWJkrxFKXdmvfe0BEScfFXI7G7M/Dw6WtizlM6ZbwLQpK6k9A9ZqChnjzJM2M0w
         yauYixPRSebKOVvB2z/A7KEoYibH1tIbhFwe779/Q+nw5lMShjMaqMsim+z79jzUhg62
         3VUBIhHMIJR5ptIqZU70W+HSqunLv2AZVmcojm2N5jhbyEZaXHRqJebN2VuROeDVLT8T
         JKZ5CYEpzhjaUJEeJXuOvA4o27qFOVD5zs1QMAKoD/EwHslFUGo/23utCzkSHV2kTK9m
         7PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071855; x=1770676655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rld5NdYNgKbh8fG9m8l42rpH9XuNkYcLSLYsgKSKvp4=;
        b=H7/5KteTWATUmwPcY5n5mzPcUTIRUFFJ48V1o9z2MeCCHwXiEGiYTZ0Z4Cb+fTyck2
         vr+RksGUuCigTjZ/erc94WIq3/88bZBcRCVoE+N/YAuVn23d5zOQLhA+OnlS2N4i0zky
         jHJjrgxSxWdO5Y8ZXM2KE5zu99Z6CYDoc6a7Ebse5l2H9T290wUqDHlVBvbNnXivpQ7g
         V8TrdAYyvT4OXo/FYAOsv1mIy3ewsBk7wA6YjTHEEb4OivR4pbkq97SWtqa0Qf8GA08Q
         lXqV5htooxQGfdCPGv1RiFmdz8V28tJ2/nE2X8NZS1BYtvhg/r8bE9hIzGaEgYxLclbJ
         3ycA==
X-Forwarded-Encrypted: i=1; AJvYcCVd3sFtn4pMCMeZlri060QvCqh4rgelWL9EgjQGpFAQOQVsKDNTv8cBPhu29JPfR61yJA8a1FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKG3tQKgJrliSFhuqev3Ht6Z+46a/PwTyZfkJMUv2EDsJ0M4n+
	5/gd3eUvEPEaZRLX93EiEBHdX7VxyOgdZHNEw8FKI0UQTgLE5FnUHFshjFxQVpbTwz7N/TEyYlN
	xroufq+W0kk+OOiC3Ghu4wmARLQJeRs79frr417xm9rRrUNNmRIk=
X-Gm-Gg: AZuq6aL/sfQxILIGJ0RouI7mvPZ17KULv+5lG6rroHYaUrfzGaP8rJvqAe0vMLV8iRq
	T6OkO5CJGiEPZHRL6M1JpH6XAfOthNf6db3J0d40wY2dVidFqGDxNU/wSZg+4myZsNC+UjOQJJ1
	NPI0Zl6bIUxUb6Z/iKduqphu6mGfP3qsPCdAnU1onCHps0xXwphsJUjWYKFf8wf/NPAhH7IihMs
	lc3FiE5BTHSjYoXsgTCxepMPrtlvF9/AUAkRzLbk6T3L7C6HnN+L8D0iMDtKsdPTmMr9TW2RKol
	fDrNbAY84dhvhpolPRJjwyD+g5s9Ga64XQ3h8PaQtS3NIDEgP1LGSGyEdEEK
X-Received: by 2002:a05:6512:39ce:b0:59e:7e4:c019 with SMTP id
 2adb3069b0e04-59e163f58b1mr4219911e87.9.1770071855196; Mon, 02 Feb 2026
 14:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126194826.236075-1-tom@herbertland.com> <20260126194826.236075-3-tom@herbertland.com>
 <willemdebruijn.kernel.235a1f46c52f8@gmail.com> <60fb02d8-77ca-457b-be24-33a3cc7b344b@gmail.com>
 <CALx6S35Z63WDMOkZLJ7PzR6BcEV4h5f7Jm-Okw9izcuFcygNoA@mail.gmail.com> <d0b4b06a-94ba-4665-9593-2c507ffb552a@gmail.com>
In-Reply-To: <d0b4b06a-94ba-4665-9593-2c507ffb552a@gmail.com>
From: Tom Herbert <tom@herbertland.com>
Date: Mon, 2 Feb 2026 14:37:24 -0800
X-Gm-Features: AZwV_QhrW9P9xeG8aJ5-nv0javsLb96_jOby2Lzjq4tAaEWydj6f8_5K7MGMZ-k
Message-ID: <CALx6S36g4wVcHpXam80C5iMOYa+=G4_1rGFkhXKGBvvPvUmyDw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-256026-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,herbertland.com:email,herbertland.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3F633D2815
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 12:48=E2=80=AFAM Justin Iurman <justin.iurman@gmail.=
com> wrote:
>
> On 1/30/26 18:22, Tom Herbert wrote:
> > On Thu, Jan 29, 2026 at 10:13=E2=80=AFAM Justin Iurman <justin.iurman@g=
mail.com> wrote:
> >>
> >> On 1/29/26 06:30, Willem de Bruijn wrote:
> >>> Tom Herbert wrote:
> >>>> Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the res=
t
> >>>> of the TLV definitions. Label each of the TLV definitions as to whet=
her
> >>>> they are a Hop-by-Hop option, Destination option, or both.
> >>>>
> >>>> Signed-off-by: Tom Herbert <tom@herbertland.com>
> >>>> ---
> >>>>    include/uapi/linux/in6.h        | 21 ++++++++++++++-------
> >>>>    include/uapi/linux/ip6_tunnel.h |  1 -
> >>>>    2 files changed, 14 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
> >>>> index 5a47339ef7d7..438283dc5fde 100644
> >>>> --- a/include/uapi/linux/in6.h
> >>>> +++ b/include/uapi/linux/in6.h
> >>>> @@ -140,14 +140,21 @@ struct in6_flowlabel_req {
> >>>>
> >>>>    /*
> >>>>     * IPv6 TLV options.
> >>>> + *
> >>>> + *  Hop-by-Hop and Destination options share the same number space.
> >>>> + *  For each option below whether it is a Hop-by-Hop option or
> >>>> + *  a Destination option is indicated by HBH or DestOpt.
> >>>>     */
> >>>> -#define IPV6_TLV_PAD1               0
> >>>> -#define IPV6_TLV_PADN               1
> >>>> -#define IPV6_TLV_ROUTERALERT        5
> >>>> -#define IPV6_TLV_CALIPSO    7       /* RFC 5570 */
> >>>> -#define IPV6_TLV_IOAM               49      /* RFC 9486 */
> >>>> -#define IPV6_TLV_JUMBO              194
> >>>> -#define IPV6_TLV_HAO                201     /* home address option =
*/
> >>>> +#define IPV6_TLV_PAD1               0       /* HBH or DestOpt */
> >>>> +#define IPV6_TLV_PADN               1       /* HBH or DestOpt */
> >>>> +#define IPV6_TLV_TNL_ENCAP_LIMIT 4  /* RFC 2473, DestOpt */
> >>>> +#define IPV6_TLV_ROUTERALERT        5       /* HBH */
> >>>> +#define IPV6_TLV_CALIPSO    7       /* RFC 5570, HBH */
> >>>> +#define IPV6_TLV_IOAM               49      /* RFC 9486, HBH or Des=
topt
> >>>> +                                     * IOAM sent and rcvd as HBH
> >>>
> >>> Explicit labeling with HBH or Destopt is quite informative.
> >>>
> >>> Does this mean that IPV6_TLV_IOAM should also be accepted in ip6_pars=
e_tlv
> >>> in the Destopt branch? RFC 9486 indeed did reserve a number.
> >>
> >> Nope, not right now. The only IOAM option currently implemented in the
> >> kernel is the Pre-allocated Trace, which uses a Hop-by-Hop option. It
> >> wouldn't make sense to have it in a Destination option, although you
> >> could (i.e., it's not forbidden, just weird). Actually, the only IOAM
> >> option that would make sense to carry in a Destination Option is the
> >> Edge-to-Edge (E2E), but it's not implemented in the kernel. Should it =
be
> >> implemented at some point, then yes, you'd have IPV6_TLV_IOAM in the
> >> Destopt branch as well.
> >
> > Justin,
> >
> > Conceptually, someone could put IOAM in Destination Options before the
> > Routing Header. There's about 0% of that ever happening though.
>
> Tom,
>
> Correct. However, I wouldn't say there's about 0% of that ever
> happening. At some point, I remember that we even thought about using
> the IOAM Pre-allocated Trace in the Destination Options header (the
> first one, before the RH). The goal was to use it with SRv6 and collect
> telemetry for the overlay. There was also an attempt at including IOAM
> within SRv6 directly (draft-ali-spring-ioam-srv6), which didn't get
> consensus at that time.

Hi Justin,

For sure, there's always going to be someone who wants to use these
things someday. But to date, these have all been nothing more than a
pipe dream for the past forty years. I know that the Internet has its
roots in being an experimental network and a playground, but on the
other hand at some point we have to acknowledge that it's kind of
critical to humankind. We can't keep every option open just because
someone thinks they might use it someday. By definition, any code path
that isn't ever being used is liability, so at some point it's the
greater good to remove it rather than keep it around just in case
someone finally finds a use for it (other than DDoS).

Does it really make sense to keep code paths running in 5 billion
devices of which the vast majority, possibly even all of them,  don't
care about? -- I think it's a fair question to at least ask :-).

Tom

>
> Justin
>
> > Tom
> >
> >>
> >>>> +                                     */
> >>>> +#define IPV6_TLV_JUMBO              194     /* HBH */
> >>>> +#define IPV6_TLV_HAO                201     /* home address option,=
 DestOpt */
> >>>>
> >>>>    /*
> >>>>     * IPV6 socket options
> >>>> diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip=
6_tunnel.h
> >>>> index 85182a839d42..35af4d9c35fb 100644
> >>>> --- a/include/uapi/linux/ip6_tunnel.h
> >>>> +++ b/include/uapi/linux/ip6_tunnel.h
> >>>> @@ -6,7 +6,6 @@
> >>>>    #include <linux/if.h>              /* For IFNAMSIZ. */
> >>>>    #include <linux/in6.h>             /* For struct in6_addr. */
> >>>>
> >>>> -#define IPV6_TLV_TNL_ENCAP_LIMIT 4
> >>>>    #define IPV6_DEFAULT_TNL_ENCAP_LIMIT 4
> >>>>
> >>>>    /* don't add encapsulation limit if one isn't present in inner pa=
cket */
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>>
> >>
>

