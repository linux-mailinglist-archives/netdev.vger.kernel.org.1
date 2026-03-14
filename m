Return-Path: <netdev+bounces-267869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF21E1netWlT6AAAu9opvQ
	(envelope-from <netdev+bounces-267869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:16:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 551B828F461
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D004C3015150
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 22:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869AB3002BA;
	Sat, 14 Mar 2026 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4gJbQfg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17543EEC0
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773526610; cv=pass; b=reglkgWOU7BRcFoF5b/1w10/gEe1LqYqF26JdwdWVPyPG5m6XRMEtlGSepzanR1/4TTW6qNeZ8mV3oB+zPere8alI8gormLsQY+VwNGYvPccdJUJ7UaKD9BKzSZu3PdqVthGXGTncJNVPuyjhAHmpFTf0SUcy/9IP723027iPhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773526610; c=relaxed/simple;
	bh=AUAU206tazAsbgCoI/voDWbB3uRpWuYbp4omMWTwwLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBNaGMo88ZEX4LV4LtfmtfT3AplEi32w1+uO9Cc1vwCVaKf8BPvbhEzmRKbLfhgsumcGPSarNCOkH8s36W62CAGSGkJSt8PgFiKSCOJPHVlG1LTURav3igfIXm98skxCrhZe350T/a3BZ+ba3Sh4vfKd1Dpu1s/NoNDPd57I0hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4gJbQfg; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89a133cdd4aso43708316d6.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773526608; cv=none;
        d=google.com; s=arc-20240605;
        b=TsnvJWIyOLOXLRfFW0n1beLkK98xhYPWsDbOQyaZD+4/Ty6B7Du5SS8LqulAevE8G7
         DpyAYc1IZePM4BvmQD70Kwpo6DETTrw4a/6e3foR1ybYR5L6aA0Jcm6hvYQKsXECi5ju
         UeJJg+lH20zkFqn+5yLeJp9kSb8BL+EHeA5A4n7n6TLDr7PSLVUEGyuTxiQupG5yrhHz
         vROATRvjfwDACJdlfJ4FUszSSOYRPLKCcaZhAMSmtUhpXHt7s6NlH1aLBb+/nRFvULiA
         SNeIJz+mpSxv7kwQVk90zP3HADSAEkjXHXTw5moWamxGJlcuS1ij7fb+KEZkx2hrDfff
         0oxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G0tXSjBlrHGT9o29rlF0f6tEkAF11nriwN3UoDjVXjE=;
        fh=8mNnFledprRfz5vyiSMmkewNGWWxH6/fwshfnfCG0r4=;
        b=N0ao7HbSLfUkehbM2heKvxXrsS+/wZeW/vA3p6ov4T4n5kHkeghiHGy5ZTC4Su1UED
         br4gv36uzaVMf/7cLjtyMnAF056Hj9uIgoFJ+3qUOzLQqCSKpYicQ6QUnjPCfRcCAIkA
         MBLhjVaVkKbYKh3LslXoKXEzFMvnJ1DAF1Hh4cteSkiJdBXaCXEWKbNsiyKnb4VV1vdy
         vpgVKOclaBBHUBts9pvnTwprlvbTqgf3jO9O4b3xmTxHMLxgsq0kBmq9RvbT5XpKKOCV
         t8dQofV7fKp4sIog0hpbZsW7glkkZYa2rhrjLwqx3/9VDkKf9uSN7z9vNN68tVeEhSPS
         QBvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773526608; x=1774131408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0tXSjBlrHGT9o29rlF0f6tEkAF11nriwN3UoDjVXjE=;
        b=Z4gJbQfgILOU6MWtvbUdQ4kF2mRIFtGNTFipeQ2UHAlCyAz2PpljTOh86foefByst6
         f03+C9UiUBVkdH2MP1klRA6jCPWzet8zu5XmkgMP8AoLmAyE99MQgbJdXNc3coV+NG6m
         1OeQk9nJClMh6mI3Ek7QZZfm7c5p2TED30ACuo24ngvMRTt8t98QlJDuj+PbZQALVcOj
         SC5D39bZtiJadDm9HovLFsyoxzdNbj0f0omGgzdrsP5Pu5VlgjDtnYKMl/t9dTkZOGhc
         T5wElgmiOmlVq+KETUydGnOTx8LSbxfO+S8nz3elUY1pLldsRIpCLagGVA1Yyn+Ov8Zv
         l9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773526608; x=1774131408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G0tXSjBlrHGT9o29rlF0f6tEkAF11nriwN3UoDjVXjE=;
        b=URN2SiGvEpxhI3LhouzNOtMw88Ms7MUqo6yzA3Ldat4golVO1pcpIBlObMRj7ioTDN
         k2gF1x7Acw//Bb8H0YjVetp46In+rbkuGl3cupZisXt1erM8avuIU4T2+u/qI/SA4438
         xwWLEjOsIVjvp4WcyGr8oGMispihb5U2XqEc8NJ8MLMeIy+KVth2oCsPN6y5ngFpuCho
         C2aMCaWjAhMKg1i0SWQw8cdH8kIUnm/gyhzseFFXLnvHb0/+FnSRqH0JETSjTw71N7bA
         HUxE0ZYVmmLSEcrn8602XUrolvL/69G5IaPzJfOLrCRhAF1vItGsA3Lwa9lF/M5fHsGp
         p9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV5E3WNOSq1VPhnQhBljHwT9h3Hg7qkj7UYS5uZvVeT83JJd1qBu3f6hfBZpw1SwuEqPK1VdwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5vxFAA4Xez7BV1yopppSdmtzUD9Ul7NcPC8DSMnQ8tMzcoLb
	SgdHBqpDQVpnaB/tOaNRkNdnekAt34c8Q2RdxOMGx64LpyNJvmrR2p+ziwIORXZgJscUPgcUBFq
	avBw3dxaveAMKk+J3tToArh3lftsbs20=
X-Gm-Gg: ATEYQzwoYkaqAjNYFn0OiJF+V6BB17qRZ+nOcTvHMKQYOUbcJCrYXmtg90ewUEp5+nb
	i4V2fV8rw0pVNxyRy1BGMLBs1Q6daqSQH57zhRIOOeWIHi9Qb4nyPnQo+xlonKUj8XmtJ8DrD31
	GIDoZQnKsY7eXWmqDG0QDtPIPpc/vb57F3ShT46WsuGB501n1GBO2jiSiC6+ISCJRs9qmDO0ZGH
	AA3XvLgLRe8rMC+k0f/4SkaEJoosXxqZmp01VZloeDZbTta5HGllzywbBIa/Jjiq3FUhfTo7pZn
	AqLbUYM=
X-Received: by 2002:a0c:f20a:0:b0:89c:3f22:c89e with SMTP id
 6a1803df08f44-89c3f22cd88mr38210226d6.24.1773526607950; Sat, 14 Mar 2026
 15:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313150614.21177-7-fw@strlen.de> <20260314161236.2454291-1-kuba@kernel.org>
 <abWph_Nu9TBQ4r6I@strlen.de>
In-Reply-To: <abWph_Nu9TBQ4r6I@strlen.de>
From: Guanni Qu <qguanni@gmail.com>
Date: Sat, 14 Mar 2026 15:16:37 -0700
X-Gm-Features: AaiRm53U-YxvRHMnI-41Cs6pO5s3TBMB9CUSqSi58p3r8jc9CU69w0krWDJLG2Q
Message-ID: <CAFzOa16enGosPApaXYmypkUb8JK=SMsvi2XMSrDP+DShm=GMLQ@mail.gmail.com>
Subject: Re: [net,06/11] netfilter: nf_conntrack_h323: fix OOB read in
 decode_int() CONS case
To: Florian Westphal <fw@strlen.de>
Cc: edumazet@google.com, pablo@netfilter.org, netdev@vger.kernel.org, 
	davem@davemloft.net, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qguanni@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,strlen.de:email]
X-Rspamd-Queue-Id: 551B828F461
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Florian,

Confirmed, the AI review is incorrect on all points.

The UNCO, SEMI, BYTE, and default cases all advance bs->cur without
a pre-read check, but each has nf_h323_error_boundary(bs, 0, 0)
immediately after (lines 358, 410, 483, 512). The pointer can
temporarily overshoot bs->end, but the check catches it before any
subsequent dereference.

The CONS case my patch fixes is different: get_uint(bs, len)
dereferences *bs->cur++ inline (lines 258, 262, 266), it reads
1-4 bytes from memory before any post-advance boundary check can
fire. That's the gap the patch closes.

Jenny

On Sat, Mar 14, 2026 at 11:31=E2=80=AFAM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Jakub Kicinski <kuba@kernel.org> wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
>
> Jenny, could you please double-check?
> I don't think this report is right.
>
> > netfilter: nf_conntrack_h323: fix OOB read in decode_int() CONS case
> >
> > This patch adds a boundary check in the CONS case of decode_int() to
> > prevent reading beyond the buffer after get_bits() returns a length
> > value. The fix validates that len bytes remain before calling
> > get_uint().
>
> SO far I can follow LLM response.
>
> > > diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/n=
f_conntrack_h323_asn1.c
> > > index 62aa22a07876..c972e9488e16 100644
> > > --- a/net/netfilter/nf_conntrack_h323_asn1.c
> > > +++ b/net/netfilter/nf_conntrack_h323_asn1.c
> > > @@ -331,6 +331,8 @@ static int decode_int(struct bitstr *bs, const st=
ruct field_t *f,
> > >             if (nf_h323_error_boundary(bs, 0, 2))
> > >                     return H323_ERROR_BOUND;
> > >             len =3D get_bits(bs, 2) + 1;
> > > +           if (nf_h323_error_boundary(bs, len, 0))
> > > +                   return H323_ERROR_BOUND;
> > >             BYTE_ALIGN(bs);
> > >             if (base && (f->attr & DECODE)) {       /* timeToLive */
> > >                     unsigned int v =3D get_uint(bs, len) + f->lb;
> >
> > This patch fixes the CONS case, but the UNCO case in the same function
> > has the same vulnerability. In the UNCO case, get_len(bs) can return up
> > to 0x3FFF (16383 bytes), and the code advances bs->cur by that amount
> > without checking that len bytes remain:
> >
> >       case UNCO:
> >               BYTE_ALIGN(bs);
> >               if (nf_h323_error_boundary(bs, 2, 0))
> >                       return H323_ERROR_BOUND;
> >               len =3D get_len(bs);
> >               bs->cur +=3D len;
> >               break;
> >
> > The check only validates 2 bytes for get_len() itself, not the
> > subsequent len bytes that will be skipped. Does this need the same fix
> > pattern?
>
> I don't think so.  Pointer can advance, but right after the swtich/case
> there is:
>
> 358         if (nf_h323_error_boundary(bs, 0, 0))
> 359                 return H323_ERROR_BOUND;
> 360         return H323_ERROR_NONE;
>
> So bs->cur can advance past cur->end, but then the function
> returns ERROR_BOUND.
>
> > The decode_bitstr() function has a similar issue. In the SEMI case, it
> > calls get_len(bs) which can return up to 0x3FFF bits, then advances the
> > buffer by len >> 3 bytes plus partial bits without checking that
> > sufficient buffer space exists:
> >
> >       case SEMI:
> >               if (nf_h323_error_boundary(bs, 2, 0))
> >                       return H323_ERROR_BOUND;
> >               len =3D get_len(bs);
>
> AFAICS we've checked get_len() doesn't cause oob access.
>
> >               break;
> >       }
> >
> >       bs->cur +=3D len >> 3;
> >       bs->bit =3D len & 7;
> >
> > The check at the top only validates 2 bytes for the get_len() call. The
> > actual advance at the bottom can be up to 2047 bytes. Should this be
> > checked as well?
>
> AFAICS it is, right after there is:
> 410         if (nf_h323_error_boundary(bs, 0, 0))
> 411                 return H323_ERROR_BOUND;
>
> > The decode_octstr() function has the same pattern in both the SEMI case
> > and the default case:
> >
> >       case SEMI:
> >               BYTE_ALIGN(bs);
> >               if (nf_h323_error_boundary(bs, 2, 0))
> >                       return H323_ERROR_BOUND;
> >               len =3D get_len(bs) + f->lb;
> >               break;
> >       default:                /* 2 <=3D Range <=3D 255 */
> >               if (nf_h323_error_boundary(bs, 0, f->sz))
> >                       return H323_ERROR_BOUND;
> >               len =3D get_bits(bs, f->sz) + f->lb;
> >               BYTE_ALIGN(bs);
> >               break;
> >       }
> >
> >       bs->cur +=3D len;
>
> Pointer increment, right after there is:
>
> 483         if (nf_h323_error_boundary(bs, 0, 0))
> 484                 return H323_ERROR_BOUND;
>
> > len bytes without checking. The existing checks only validate the bytes
> > needed to READ the length value, not the len bytes that will be
> > consumed. Should boundary checks be added after both break statements?
>
> AFAICS there are such checks... :-/
>
> > Similarly, decode_bmpstr() (which handles 2-byte character strings) has
> > the same issue in both the BYTE case and default case:
> >
> >       case BYTE:              /* Range =3D=3D 256 */
> >               BYTE_ALIGN(bs);
> >               if (nf_h323_error_boundary(bs, 1, 0))
> >                       return H323_ERROR_BOUND;
> >               len =3D (*bs->cur++) + f->lb;
> >               break;
>
> We write to bs->cur, but AFAICS the write has been vetted for.
>
> >       default:                /* 2 <=3D Range <=3D 255 */
> >               if (nf_h323_error_boundary(bs, 0, f->sz))
> >                       return H323_ERROR_BOUND;
> >               len =3D get_bits(bs, f->sz) + f->lb;
> >               BYTE_ALIGN(bs);
> >               break;
> >       }
> >
> >       bs->cur +=3D len << 1;
> >
> > After computing len from packet data plus f->lb, the function advances
> > by len << 1 bytes (doubling for 2-byte characters) without verifying
> > that len << 1 bytes are available. Should this also be checked?
>
> AFAICS it is...
>
> 510         bs->cur +=3D len << 1;
> 511
> 512         if (nf_h323_error_boundary(bs, 0, 0))
> 513                 return H323_ERROR_BOUND;
>
> So AFAICS this LLM response is bunk.

