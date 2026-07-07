Return-Path: <netdev+bounces-305263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WFUYKIllTGrcjwEAu9opvQ
	(envelope-from <netdev+bounces-305263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 04:33:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3703F716DC6
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 04:33:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nxxy2yin;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305263-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305263-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A33423004D1F
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31070374195;
	Tue,  7 Jul 2026 02:33:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8359373BE6
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 02:33:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391622; cv=pass; b=Cbe0vGubnAPFSU8nAU53SSTv2Z3vhTwAwrUa6VOLghT9fXMEMeUdTSF59TIMu0dueTs/lPAra7vyzofXEOEnf3YjPBd60yXDAErO53JYlEJ/yU7Jlz76k23wtMGi6fsbIB4m3dSB4Jhj951kDrWqcmMBcEL9/NFD/Suj972om08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391622; c=relaxed/simple;
	bh=VIByZO26F9BvMh0HA/pZggLPJftI42AhZhjzZK8Jwdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoBinrMB20ETbSlS3H8uQqWDLfHKfYVxqBeOuNDc6QmzZWqANVMiKX+F+cy5BOFj+wmDowyqJvdXN0OaUVewY3nH2XfDi4yEfuQ5Vno/LYwlFXpjGZswuFE5ewAtukFvihZKAINPCqjP/KSlWqRCeAP/1vxbfM3Rd9xLRs5exIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxxy2yin; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c10e86e52so32681cf.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 19:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783391618; cv=none;
        d=google.com; s=arc-20260327;
        b=A5xLBINAsyot+cdIHTbfziCTXHn1/jJh3GAFHitFWBP29zrkPX4qdZPFqFQj+3WAQR
         pPcU+C6SfFUma24RBGwBXwSopiw0JenUITS//C8lTz+4ME7fnHK3QQjK+qPxQfio+3iT
         d2V37h2zqHoAJ2/obXhhHnx64gpaqNeLJMgaDelhljnAYPL+NXRKSaRJghA8BU9LlKW7
         OT0WGXwTb83fczj/MQ0qK4COovUmY/wj7dJRxKeSEvoXwq79/Zn7Wj5UZf7lX6DpW0cq
         RpQ0k6YQPbPUneDDpRv/D8IKYNIr1/kzlTH+K04ymMqfttoIsotN42jrEAZF0i2KVB4g
         1zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u0pnKlNwkx+PCiEPrTc95sXmEyjpAS4UPx0yxvtOvrE=;
        fh=7gy9dtB+4lad9oQelT+JE3Kg9/+qv6KPIJgjzMkORL0=;
        b=juTfpL54HHuHmi6oblpFy04QyMVYOanJlRw235VmLhSHyyv01aypNPEFOAovSyYwGo
         TeM9cHXzPkJUZsyc1i7G4vPF4yj5TUc3v8CU8BhMrNAS8a/RWZD1dFYpFryv34l19AnV
         5WTBi9sQ2lio28428MCIfiuKBrpGZbD7o/CaxmLgtyIz9kSqwLDHJVcLt2GjL9LVW4pi
         Fw2w8iMrr8hwm+UuWNaT4W6ZOwTRAEpVd/JchGQGwhsIZTrVLxdEYSB9ihch3+cYbNSm
         oZ/ZgomLFTOP6uhUX7G25IpTW9RHXHddO3yWY3d1UwruAzXb5kMAOIhTW4H3dSTILUvR
         42YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783391618; x=1783996418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u0pnKlNwkx+PCiEPrTc95sXmEyjpAS4UPx0yxvtOvrE=;
        b=nxxy2yinUCzIwMDnyNZnd6t/MI6Erv2lWCBLWn90vuxZSTUgjdhkh/MEInC6sHoCJ9
         wUnnbHHN8CweYbae+wnjK9mQia7ItmDtAK5if8gN5uyKScj9NMz5ZPk9gNFiaSnnfPJd
         CJf/0H/l5nDlAmypebT3GJDMu8+ahzmfpje/9KIVAm7Sp9aG1DGylMAwIvHnGH6e2X4H
         xMbwAFreWWaOYGQ26CMJi13pCXqoaycdpiWpOOEnm5LBczENQIcqVbZ1JVgA/RGE3y1c
         sJhUEz+0n1+VbUmFnI+xLzt3kOYeaZJRjyImpEBRNUm/ATOzf5flDYhJNdb1Fwu5tkMg
         N7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783391618; x=1783996418;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0pnKlNwkx+PCiEPrTc95sXmEyjpAS4UPx0yxvtOvrE=;
        b=LFcBJVQRNMOWJwrzAVYQkrYnLxL9LpOQRiPLdWEZiSMJLoJpjkQIMi8oxNuik03ENf
         LoIpaXxu0/g85SW5xp17aNddqVAv9lZzU9M8/hz0b85+tc5AhlMg/HSoZpvI1EJFhAgr
         jCZ2kjVWh9YoMmTAKm4xNptwxc3g2KIoEV5jU/b5PCDAvFg4GeZmgMJYzGdn9QNldYwU
         XSOYwOVGsE37TQTdiwqTGbQ7fkBlAwqz/rwv3+PwohckUn95eZISiBTgZZgNOkeKqigd
         RjaH+qNJAoOb1odjCpFC8iKO1f5+Ha5qoMqyrogrkBDoRdmKbPi89aLX3RwbkmiTyMKn
         Leow==
X-Forwarded-Encrypted: i=1; AHgh+RrqLsGHiPxNMTe+4A+3dj2dsZhx0LBVm1sxejy/X0GRYsvdewUtlqHzsAPwNNKtHoDD9liTMc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8FVINgjQCIifvjMSkt4CO04xPmxVqphiSJ9tEEspOem2R3+oX
	b0/NIfBh8AYdqOrFoTxUZoPqqvmntoeScqdy5IZFpFjI0eA7q/8dk6i7XG6chTzo4bB/a87gveo
	lIxBoVrqTqHYmJzknMfLsdkjqtyV7MxdDCMRg7Tt/
X-Gm-Gg: AfdE7cl+aIqOXtrj4KJCHkRf+ayUZzJ6GgNT5otrbRGcDD9o4xIoDhwQ58k+s5mMz1y
	/9vqe1u5Of76o+Uxcfl12B2SmIlLIBFf9PIKvX0XjI5ltep1th3s0NmETscsjWJom0zl+Wv4C8D
	+3FMb3NBRjBSlSyDRylrFLjLTuD5hRKaa54RVtnu4qC/uKuQ3a5nSexvqK2lfLCsBtCAiglponL
	+uCziqyUesflkWgCaGGKcfT2bfWIdlm9PjohrfJyLuLBtDaktJnyi9tuCtiGdYFdPH2+WhsHgoS
	Ke4NrZwHjNFtF0Jyp2umN+Yi6uNDJIBHKk2bVg==
X-Received: by 2002:a05:622a:1a98:b0:51c:e80:9e88 with SMTP id
 d75a77b69052e-51c7b438b6dmr1624001cf.16.1783391617593; Mon, 06 Jul 2026
 19:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
 <20260613131552.2562d433@kernel.org> <ajDlFUhMfJP36qA8@Antony2201.local>
 <ajvzbVLCce1p86i6@Antony2201.local> <CADHa2dAtGVsph3Kq0id7QqgNdJww0Q=Z1PK+=fomVxKE-Mmvjg@mail.gmail.com>
 <CADHa2dB9e=O_thTEPo3Bwtj9qRxE0UJd_MBriC8qqrPFB+x9rw@mail.gmail.com> <akfveJrtxW9yMLXK@Antony2201.local>
In-Reply-To: <akfveJrtxW9yMLXK@Antony2201.local>
From: Yan Yan <evitayan@google.com>
Date: Mon, 6 Jul 2026 19:33:26 -0700
X-Gm-Features: AVVi8CdwUr6KOHtE61w3LoYvZzjTaPFl8oWaKMsS72ld0hXI94qicIzLBTDQ1No
Message-ID: <CADHa2dA2Sru-3smx-Ted7AdYBG9Qrm7Z1misBxpokZYLeOeofw@mail.gmail.com>
Subject: Re: [PATCH 0/18] pull request (net-next): ipsec-next 2026-06-12
To: Antony Antony <antony@phenome.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Nathan Harold <nharold@google.com>, Antony Antony <antony.antony@secunet.com>, 
	David Miller <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, 
	netdev@vger.kernel.org, Tobias Brunner <tobias@strongswan.org>, 
	Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305263-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:antony@phenome.org,m:kuba@kernel.org,m:steffen.klassert@secunet.com,m:nharold@google.com,m:antony.antony@secunet.com,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,m:tobias@strongswan.org,m:sd@queasysnail.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3703F716DC6

Hi Antony,

I agree it starts to feel very convoluted. Please see the results inline be=
low

4.2. [Wildcard Mark] Creates two SAs differing only by mark: SA
(mark_1) and an SA (mark_none). Migrating the mark_none to mark_1.
Expecting it will fail with EEXIST and both SAs intact BUT the
mark_none SA ends up being deleted.

The test fails the same way: EEXIST is returned and SA (mark_none) is
deleted. I still think we need to fix the collision pre-check in the
following block: x_new is expected to be SA(mark_1) but ends up being
SA (mark_none)

// This probably should be xfrm_state_lookup_exact
x_new =3D xfrm_state_lookup(net, new_mark_key, &m.new_daddr,
                                             um->id.spi, um->id.proto,
m.new_family);
if (x_new) {
    xfrm_state_put(x_new);
    if (x_new !=3D x) {
    NL_SET_ERR_MSG(extack, "New SA tuple already occupied");
    err =3D -EEXIST;
    goto out;
}
/* self-match via wide mark mask; not a collision */


6. Creates two SAs differing only by mark: first SA (mark_1) and
secondly an SA (mark None).
Before the patch: Migrating the SA (mark_1) to mark_2 fails with
ESRCH, two SAs remain untouched
After the patch: Migrating the SA (mark_1) to mark_2 fails with
EEXIST, two SAs remain untouched

Thinking it through again I think the behavior of the new patch makes
sense. This migration should not succeed because we also not allow
adding a SA(mark_specific) after if there is a SA(mark_none)
installed. So now the migration behavior is consistent with it.

All other tests still pass.


On Fri, Jul 3, 2026 at 10:21=E2=80=AFAM Antony Antony <antony@phenome.org> =
wrote:
>
> Hi Yan,
>
> thanks for testing. Would you please test on a new series?
>
> On Thu, Jun 25, 2026 at 06:58:47PM -0700, Yan Yan wrote:
> > Hi Antony,
> >
> > I ran the following test cases and two=E2=80=944.2 and 6=E2=80=94are wo=
rth disucssing:
> >
> > 1.  Mark Inheritance: Creates one SA and migrates it without
> > specifying a new mark. [PASSED]
> > 2.  Mark Update: Creates one SA with a specific mark and migrates it
> > to a new specific mark. [PASSED]
> > 3.  State Update Isolation: Creates two SAs differing only by mark and
> > verifies that migrating one does not affect the other. [PASSED]
> > 4.  Mark Collision:
> >     4.1 [Specific Mark] Creates two SAs differing only by mark: SA
> > (mark_1) and an SA (mark_2). Verifies migrating SA (mark_1) to mark_2
> > fails with EEXIST and both SAs intact. [PASSED]
> >     4.2 [Wildcard Mark] Creates two SAs differing only by mark: SA
> > (mark_1) and an SA (mark_none). Migrate the mark_none to mark_1.
> > Expecting failure with EEXIST and both SAs intact. [FAILED: SA
> > (mark_none) ends up being deleted]
> > 5.  Mark Mismatch:
> >     5.1 Creates only a wildcard SA and verifying migration using a
> > specific mark fails with ESRCH; SA intact [PASSED]
> >     5.2 Creates only one SA (mark_1) and verifying migration using a
> > mark_2 fails with ESRCH; SA intact [PASSED]
> > 6.  Mark Shadowing Failure:: Creates two SAs differing only by mark:
> > the first SA (mark_1) and the second SA (mark None). Migrating the SA
> > (mark_1) fails with ESRCH, two SAs remain untouched [PASSED]
> >
> > --------------------------------
> > My questions are as follows:
> >
> > Regarding 4.2 I believe is a kernel bug. During the pre-migration
> > collision check, the lookup for the mark_1 matches the wildcard SA
> > itself first, causing the kernel to miss the collision with the
> > existing specific SA with mark_1
> >
> > At https://github.com/antonyantony/linux/blob/migrate-state-fixes-v0/ne=
t/xfrm/xfrm_user.c#L3450
> >
> > x_new =3D xfrm_state_lookup(net, new_mark_key, &m.new_daddr, ----> BUG:
> > We are looking for the existence of SA (mark_1) but SA (mark_none) is
> > returned.
> > um->id.spi, um->id.proto, m.new_family);
> > if (x_new) {
> >     xfrm_state_put(x_new);
> >     if (x_new !=3D x) { ----> BUG: We end up having x_new =3D=3D x
> >     NL_SET_ERR_MSG(extack, "New SA tuple already occupied");
> >     err =3D -EEXIST;
> >     goto out;
> > }
> this should be fixed no. Would please try again?
>
>
> > /* self-match via wide mark mask; not a collision */
> >
> > Would it be possible to traverse the entire list or create a lookup
> > method for an exact match?
> >
> > Regarding  6.  I wrote the tests as per the kernel implementation but
> > I'm not sure it is intended. Intuitively, this migration should
> > succeed by finding and updating the specific SA (mark_1) instead of
> > failing. Is this failure considered an acceptable limit, or should we
> > aim to support exact-match lookup here?
>
>
> While trying to fix MIGRATE_STATE I fell into a rabbit hole:)
> I realized many methods have this issue. Just never noticed, as it would =
be
> a misconfiguration, and would likely cause operational issues rather than
> crashes.
> However, given that xfrm accepts multiple identical SAs differing only in=
 mark,
> a proper fix is to add __xfrm_state_locate_exact() for both spi and byadd=
r
> lookups.  This should be used in all calls from userspace.
>
> I just send a new series.
> https://patchwork.kernel.org/project/netdevbpf/patch/migrate-state-fixes-=
v0-1-a69e8637ba3b@secunet.com/
>
> -antony



--=20
--
Best,
Yan

