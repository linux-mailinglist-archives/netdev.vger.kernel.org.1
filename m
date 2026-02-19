Return-Path: <netdev+bounces-259585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F3xDQVvl2lSygIAu9opvQ
	(envelope-from <netdev+bounces-259585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:13:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D043162439
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A7253019925
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0572E0B71;
	Thu, 19 Feb 2026 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="nTMFYHsM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194B2FFF8E
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532034; cv=pass; b=DL8gY2B9aD7XM4xbzk5/qU+tKZJG1nSx9lnoxW53vWIx7JtOCia+m77rnSXaJxWCB6SCvQY8K/xXkfAdKlM+UXrdEVFqpdAVLTV9wziPEPvWEAKghTL92Gcp0xILgGnVRJ1/pIwCEspKb9qTAiGmE2drN82HPc283hzmRlB8tao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532034; c=relaxed/simple;
	bh=vhYbwXc19Kg+BTAuoWrhd56336ifTiAy67MDKNrWt04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc9kEAByyBQp5PeQpN+6z8RB8xPCiTfdDkanVeXGaf33HBorfHVqGEPwGB6Lu9udS9xU8QQ+3hX35FGK830TpbK3u6vD2IP0GoetSMEFqR6F8TCOWvowuxqI6WMA5O2Uu3uKmgX+LXF45yp16cQKUpw6wI5cnTCQ/gMSBDBJmJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=nTMFYHsM; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad20007c73so6382305ad.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 12:13:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771532032; cv=none;
        d=google.com; s=arc-20240605;
        b=abur1D+t0E6oBO0j8OQB1P8GqqWYjelm9NFNAX/dwrCz7pE0RwX9PomB5fe6RyspCB
         MQC0JYMVorEkRIKy51a8i6Qsp7ZLXnUBNEiZg5fLk03Sm7aLqJ4U88YVCeCYsTGMlurP
         o+o6sCsCJLqRXMm5ezvZWzhzL+WqE63SBYWjCpAZ85f7UZNwBwKT8Dx19xSdf0u5w605
         S99U5P3MFE6I1MHacFgP9YdwCMhINqbgrLMCbAgfSL8mvujv6tphSQfRpFwzwZA3+xha
         1G6cE8ZIWiBP9XF3aj0HBAopyZrK0Kk5hoPWaugTgHh5D7Du7CT6NOepTL85pSBTMgHC
         shlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/HwvyFv/slxn9yE9YxErLiklwYugDGhdGXpzBest8f4=;
        fh=iSslJSJ/M4vfovzfX7pysnhiDl4YQ1S9ZFpwgvXhHA8=;
        b=Uh7m8ULM2Cz3oGoHkTwyaloZf63n12vfvH/eMLNRkv5nmxlsM960hXbAaNl1AXdsqL
         ilTFxtgVgJUdnbIrqANPMKZIcyQDMYCWliz0O0uy/qpE1Y058DHPTLCku4S+ungiaHfk
         kSDerPTmcxRz9p8kAOKb4ZmJ5tzJ5cC5HhepTmjI8KNOcaUOVWiHYDekyTTXZoXau2CD
         2W+PJMdcS5JJYkZJePr6nSzFcm2gEZga/a3xL/qfWLTa0AX3PD/Q3KVnpmT7rBHuUbTT
         FNMubLjDhI0sRDbIXRoxysG/oiuyI5AKMSxaM/932QtX2EmxskFLiD71NcttqpjV19Xu
         GTNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771532032; x=1772136832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HwvyFv/slxn9yE9YxErLiklwYugDGhdGXpzBest8f4=;
        b=nTMFYHsMng9J/5gS1a08yqllZDQLS5cs88/Em2jQn7PB1G9IUYDB+qSmKhdvQSXKWv
         AYHbIT+WWQ/YOr0/S6jhGkm44WY4Xz6sgXrAzSplEq94NcaaeOYrFD5hUmruNfmcskdK
         tYcl2ST2Uy9qV7Pcf3Ysyo9r5gDBhGeQidXAQEj06UMCmceTbmAPaWAo/OvFNWN76N1O
         UYRp1R1y/D/zrVVVWkJR6zyNqTaGTWu+PXHYrDqHJzr4optzf6GOJ+mrTyYTPI4OBjVM
         4isfYNcy/ohPd64uaGqXsW9yS+RCwx1rZ9FaeqGisEaafofkX4DXkCfr33Wb5+OLQ6Oq
         Lfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771532032; x=1772136832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/HwvyFv/slxn9yE9YxErLiklwYugDGhdGXpzBest8f4=;
        b=CM+qttsP6whw13RTNXAnuRceOBjVXsPfYrCrsJ09DkAWdd+hiYA/NpCVSMsbYI1YLZ
         qQbtRtmI+giycz8I5/sUMUJcMIZmptpSuYMftztpadsuGCWvrhWoblHZDcpNYSw0Uw2j
         N6kT3JY/MFjmqhtHf459nCaD2HyDD6IvP3VycYGlE2zNzk6b+MtaQvT9XY2ilUnxjHZq
         ddkheOcofRMxiE0JaQ5NNw+qHeZJLJPsk8nnBRWGH7utaVyxPBvICtj+ikewRp7uuNuM
         hWlwlTPsZ7Db2eSBwnk5u3okK9ECkWnylzp/+5fXYRlNyqYyPgEx08I4y+7vYJubF/Nx
         jOeg==
X-Forwarded-Encrypted: i=1; AJvYcCUuipaMem5czf0In4xBWTVlYQ3d4W4HuiKyleEvXT+lOmMIPU87lcqiu5JFc20iGmkKlM8GggQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy50VI+OCxKth8+PI9e6ltiXOPiwepLa8xCyHsJ6V8DopyVlEr+
	pFJyvZOWTv7zt4kRWh6x0IR1tbxpx1xn/qdfXKmrvLJLp1L1ZaGGEFsn8oY38mPPj0y9WnrVecr
	GU2kpk24MQW7zbNBMHXSv7WW1SQ2d9ehy1N04aYPO
X-Gm-Gg: AZuq6aJZg6ptMlszEi/Bxb/gI5tTQ1LkqoKbd6EWgv2MZFuCpwTvQIYc1/KyG+9xKNe
	Y9Eu2z86GYChR9sjFvZoyhqRNTtTFQ9OboLjcJoDm16eETm2XSPU4V8FTrasRhuMzYnjYqR8eP7
	pcFCuyWEq687k7ipROaOgMwKB9IWYGjHbcSEcK8ibg/GAoF+ikbnkUr9pPBVi32LD6BfePcb1+q
	QLk8WokxQDJL8qQqllNi4bnRNUQlVvo9j0XMM3ZnHoe+0L9UF5uC0Aig716e1kEJKm2ornT8c9y
	dH2ZkF5+fLf6JK4=
X-Received: by 2002:a17:902:e788:b0:2a0:8ca7:69de with SMTP id
 d9443c01a7336-2ad17545608mr164593825ad.41.1771532031846; Thu, 19 Feb 2026
 12:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org> <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
 <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org> <CAM0EoM=g3ahJ704qDQmr4s-4sDJqbyRvWNDchb3YaRbD0zdyKA@mail.gmail.com>
 <90b25744-76e5-4d9a-865f-72832bbedfe5@ovn.org> <CAM0EoMmgigcc9aYmoj_vEM4TpopHDFjyjbdFeVyEN8QzVLb4vw@mail.gmail.com>
 <CAM0EoMm3zkJpkHkwHX0YQDSJD_gEMphihZ3CC+b1dMx49bdjWg@mail.gmail.com>
 <d07fdeb8-2b26-43f0-8fab-28907e88bd06@redhat.com> <CAM0EoMmq-aN98=TTh7YkODFr2DmZjD=Lzp6roGiCBog1tT9Lyw@mail.gmail.com>
In-Reply-To: <CAM0EoMmq-aN98=TTh7YkODFr2DmZjD=Lzp6roGiCBog1tT9Lyw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 19 Feb 2026 15:13:40 -0500
X-Gm-Features: AaiRm50g2kSVezvC1-oOXIx6TLnIiaRhnDgB9DGVJyxA3xlks2e-pjEwDl4bfu0
Message-ID: <CAM0EoMn_eXtLi36Nb3Y=oHCN3dNRjhB0UMwGVhZkr4zbAkxzuA@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
To: Paolo Abeni <pabeni@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Henrik Steen <henrist@henrist.net>, Olivier Tilmans <olivier.tilmans@nokia.com>, 
	Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>, 
	GangMin Kim <km.kim1503@gmail.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259585-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,redhat.com,strlen.de];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7D043162439
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 9:16=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Feb 18, 2026 at 3:43=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 2/18/26 7:44 PM, Jamal Hadi Salim wrote:
> > > On Wed, Feb 18, 2026 at 1:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > >> On Wed, Feb 18, 2026 at 11:15=E2=80=AFAM Ilya Maximets <i.maximets@o=
vn.org> wrote:
> > >>> From a user's perspective I'd prefer if RTM_NEWTFILTER just fails w=
hen
> > >>> it contains TCA_ACT_KIND "ct" with TC_H_MIN_EGRESS.  This is clear
> > >>> for the application that makes a request and for the user if they m=
ake
> > >>> the request manually with 'tc filter ...'.
> > >
> > >> The challenge is actions could be created as a standalone i.e "tc
> > >> actions add action ct..." then later bound via tc filter. Don't forg=
et
> > >> actions can also be shared by multiple filters (which could be a mix
> > >> of egress/ingress)...
> > >
> > > Actually, looking closely at the code - this is doable. Let's see if =
a
> > > patch can be cooked.
> >
> > I discussed a bit the topic with Davide, it looks like the thing you
> > mentioned above could be handled. The problematic part is AFAICS the
> > additional indirection level added by (possibly shared) blocks. AFAICS
> > whatever check we do at ct_init() time, shared block could later
> > circumvent it - unless act_ct is always forbidden for shared blocks.
> >
> > TL;DR: I think admission check at init time can be implemented only in =
a
> > quite (too much?) restrictive way.
> >
>
> True - the blocks will require more surgery but seems doable. We may
> end up again in ->quirks() land here. I.e when an action is bound to a
> filter (not necessarily when created) it should check its fit in the
> graph and see if it is legit. But since this is only the second quirk
> we know of, we can simplify. Note: We already have one such check,
> albeit ugly-looking, with skbedit (see flag TCA_ACT_FLAGS_AT_INGRESS).
> I will talk to Victor and see if he can cook at minimal a preliminary
> patch without considering blocks, and at best one that does consider
> blocks.

After discussions with Victor we concluded that blocks have no effect
on this specific issue.
Blocks are only useful in clsact(both ingress/egress) and ingress.
Both of these handle ACT_CONSUMED fine.
Code sample looks as follows:

        case TC_ACT_STOLEN:
        case TC_ACT_QUEUED:
        case TC_ACT_TRAP:
                consume_skb(skb);
                fallthrough;
        case TC_ACT_CONSUMED:
                *ret =3D NET_RX_SUCCESS;
                bpf_net_ctx_clear(bpf_net_ctx);
                return NULL;

The reason this works is because they don't have to deal with
queues(unlike the other qdiscs).
So, ignoring the block should work just fine. Ilya, for your case, if
you must egress, use clsact egress - the only problem is it will not
support the more feature-rich qdiscs...

cheers,
jamal

