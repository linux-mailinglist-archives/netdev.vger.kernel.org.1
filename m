Return-Path: <netdev+bounces-300257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L8pPIrofM2oH9wUAu9opvQ
	(envelope-from <netdev+bounces-300257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:29:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E670169CAB2
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:29:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=everpuredata.com header.s=google header.b=NzUJkHnn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300257-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300257-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=everpuredata.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF83E30E2960
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138613A16AE;
	Wed, 17 Jun 2026 22:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D73783B0
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:29:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735350; cv=pass; b=oE8LnDgFqYd+zHkWkbmKQ5iLg2MkM9beG0ZaLsY0gXqfQU49mz8FygKsyshgAO21XV1FRRcVW+fMW283fLZ+VJkM0xz/pMzkX0WjFLfY0DTRZuQBDaq5h9ztUpdXendW/Mlxj4RTUgYTOSFL6bNm0rvi/8iUvBOy7ITgl57TlSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735350; c=relaxed/simple;
	bh=O8dO8F5HH+NwhcXBuPVjKNdxvPb7f5JVoK1aU2MfjRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIwACLAYqcY4EPYrB0PZCudOkyPbLGYdJ0pWV5JPE8u2W/hqE4qp98PkMhPPQgIQbFv8VNWh2dNuWpziC5Gw3uqknNqpJY5l6NBbVPTKXuFo3ZSynVGYcBlYg1ieQZkv7/3NYVFW433WmlRajfTbGKVp7TBZ3ElS37vbTwPpoGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=NzUJkHnn; arc=pass smtp.client-ip=209.85.217.42
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-728f9ecd56aso8662137.3
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 15:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781735347; cv=none;
        d=google.com; s=arc-20240605;
        b=Lfui749DCaT55Q1NB3TiudedQFD48nOpvv2QBrwKmKJG983XcJ9NoAfc74iMmXezwx
         bIJRhpIWnamua2bV5K9RZVhnd7W9gKTM/DLXYtKLDXCsfSpXJy3UEh5Zi2kUtff1S5Sn
         hfJf3HATYLGM5XDE4vqYQ4VEJ7UG5//YRL4yZH9MagvqLSD/o2t8MmPzZP5kzcSBFwN4
         88HS5Gs9Ufsl3QS2mzBP4iyxJDfbzpY/r3ERX+9FmcjUCQKwvmbIJScB7Y/NZ7hxHdos
         U9Yh59u60OztFHuM19dpuBC76y2Rx0OckWgzkVs5glCEyisPfCcnfQEqOxQ1+zS3i3PD
         adXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r2YZvXsHNZTG1lq0j/+EIfpH0cC0WuA+zvcp1Z82vjI=;
        fh=AncD0AS9UsLKDFSJyg9EIrmTarBUaKA1UHVIu3FeFWo=;
        b=Pu4FJLXph9/bc/Qg97O/l0ShYqTk/LnweDffMeD6re8cdyUv8HGthglGBbIY/XstHM
         v5G0wlu2iK/SQjwtz5vZwjR9Bw/7aJj5OgGjRcMTLbmnPXFS8bXsQ32oUAu2fzNtYtbM
         Hfol8UfoECPYjTCpXE1dq4A3sCYVZO21O+QK0MzzShRCYbkrpF6W+jMZEnPvZg6T0yg7
         ZXiyLbLlVhz9/A3VRX1EKpD8sb6omlKuO36XkouMM/wn8Cr0UzFVPIF9WXg+inmfKg7X
         6kl032AVJtUUYITBenPl/jIEa6qPe7WkYTQAq2NRekndi6OdHwmi49MtOVkWeLUXUXIn
         eLnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1781735347; x=1782340147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2YZvXsHNZTG1lq0j/+EIfpH0cC0WuA+zvcp1Z82vjI=;
        b=NzUJkHnn1gClFGxLyg+hER0anySVm02jVCwz4ZPAU8eshrq38HOlvJgz2/kysUJGfA
         JVBt86c6qHBy7WkLeWS9FSaqieSYTBFoTGgpkRGIzgWWXEuWHB3p9NAAa5gSzfqy5Ljy
         jEbg2PV7ENHOOn5BHXulsqAZBtPHj2kzYjdcQtP3+tw3DXqxBiGneef8YM1R1XefitA6
         HFJM6Rms5AToMT54FnkNLdvnexF7VSzIWgSp8chco0etvjUgc1lHNEzszBgfBRYGcHQm
         +3reTwMu7S5dyXhJ+FXcgOq3zHW4+3MNaoMyLyCYYTcx8YAl6rCof7SZ+lbam9jAOGXA
         +D+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781735347; x=1782340147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2YZvXsHNZTG1lq0j/+EIfpH0cC0WuA+zvcp1Z82vjI=;
        b=IrLn4CMW97mf2ZvSbiXhuPhasGk5Wnf4Su7aWd/AlUTA1Dsaq7w9ph92oez9woYldm
         38PGOQivnKtQBcnb0Ti0mppAmRihE8OzSpnV+g2v1v6L9lYs7OqDtg9TNzcY8kTu+IjI
         WRe5ZU6Bbj0RrG7tR7yIX8/X34xw+1PwAFgzPwZSZwOJTEdqpEO730kZHQtDIbih8JXi
         YpTJGFVOZCpSjV+Dc5fnqdNuh5M7lCE3o3Ja+m97tV/wt1QJwr/lzH7/v2WHwwu51JPn
         J2C8uH5PwXUrlZ6ptoT1PRrL3bhqQivJA57/+cyDeX86njD1asr8AD4ILe0Kkt1K/ld8
         4eGA==
X-Gm-Message-State: AOJu0YxoqDnHOvoIQb6dGGgEsu3S3BLdb/wJ6Dh+xhhJiLo1bwvuu4Hw
	37tJ9S2+SVtSrLrosE/NwY55xBOX4b65xZoU3yIrkhtF3MY8XEobZkd2V/LnqmXPTbtbuaQcXeA
	7a70Ac19B05wH5lfDUCVzGynMEPZ3JkOpdB8SupZHoA==
X-Gm-Gg: AfdE7clC2uR91Tw8bvGgttMhHllVpZYSvz+Tp3AOUpz6HuK0BedCUmtusxxpGagCT9q
	a4rRIQ43KT2Cbw3ag+r6y4EcDTpcf0waB948ZUXQSi2MUPygE3KqDVW+54VgSkucWvdvhakt/oS
	zG/bcl+ik2q0MUWucY8yzWX8cJ1QfUlMyEAKBqCVXgwZZWojBMtq0OiJr1ksW3y0qDbHtCtr+Oz
	X4NjG11HDebESVS3kd3JEY3Itfa2WPrZcjY51943NhPrESlWw5WS2S7rBlD3S3/3uF52hVr
X-Received: by 2002:a05:6102:54a4:b0:631:26f6:701a with SMTP id
 ada2fe7eead31-727c74b8693mr1046661137.29.1781735346674; Wed, 17 Jun 2026
 15:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
 <20260429181016.3164935-6-rjethwani@purestorage.com> <afsmVLSn2tA7UP9W@krikkit>
 <CAKaoeS2=W-WFxAmo2M_FOzS4d65L-1WM+3CJ2x3dy0U0NvMapA@mail.gmail.com> <ag8PQ2pxvKMHglWV@krikkit>
In-Reply-To: <ag8PQ2pxvKMHglWV@krikkit>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Wed, 17 Jun 2026 15:28:55 -0700
X-Gm-Features: AVVi8CebBTGcJhInYkhi4VY-xFGyGAyIr5mKgH-s1w1Wo5RByS1ntA_Vqr-AOe8
Message-ID: <CAKaoeS1zv03qhT1TvY_fJw7MqE90GXFHHQG_Fw3KK1OG9zALPw@mail.gmail.com>
Subject: Re: [PATCH v13 5/6] tls: add hardware offload key update support
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[everpuredata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[everpuredata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300257-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[everpuredata.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,everpuredata.com:dkim,everpuredata.com:from_mime,queasysnail.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E670169CAB2

On Thu, May 21, 2026 at 6:57=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-05-12, 10:55:35 -0700, Rishikesh Jethwani wrote:
> > > Not blaming you for NIC behavior, but... the NIC passes up as
> > > "decrypted" records that have failed decryption (because it was using
> > > the wrong (old) key), or passes as "encrypted" the incorrectly
> > > decrypted data (that it has "decrypted" with the old key)?
> > >
> > > Or this is only the first record(s) after the KeyUpdate message, if
> > > they fall within the same packet, the whole packet was "decrypted"
> > > with the old key but only the KeyUpdate itself (and maybe some more
> > > records before it) decrypted correctly ; but subsequent packets get
> > > passed as !decrypted and don't need this reencrypt dance?
> > >
> > > (this is maybe more of a question for Tariq or the other @nvidia
> > > folks)
> > >
> > >
> > > I haven't reviewed the whole patch at this point, because of Paolo's
> > > suggestion and this confusion with the RX rekey.
> > >
> > > The traces show how both NICs behave during the key transition:
> >
> >   Broadcom (NIC preserves decrypted flags):
> >   - decrypted=3D1: NIC fully decrypted these with the old key; one reen=
crypt
> > pass (retry=3D0) re-encrypts those frags back to ciphertext, then SW de=
crypts
> > with the new key.
> >   - encrypted=3D0, decrypted=3D0: boundary-straddling record; same sing=
le
> > reencrypt pass.
> >   - encrypted=3D1: NIC never touched these; SW decrypts directly with t=
he new
> > key.
> >
> >   Mellanox (NIC clears decrypted flags on auth failure):
> >   - encrypted=3D0, decrypted=3D0: NIC partially processed the record bu=
t
> > cleared all decrypted flags on auth failure. retry=3D0 reencrypts with =
the
> > wrong frag interpretation and gets EBADMSG; retry=3D1 toggles the flags=
 and
> > succeeds.
> >   - encrypted=3D1: NIC reported these as untouched; SW decrypts directl=
y.
> >
> >   The retry path exists specifically for the Mellanox case: cleared fla=
gs
> > hide which frags the NIC actually touched, so the first pass may pick t=
he
> > wrong interpretation and need to flip it.
>
> Thanks for describing this.
>
> I don't think the core TLS implementation should implement workarounds
> for HW/drivers doing strange things. IMO this should instead be
> stuffed into a driver CB, which would implement the necessary steps to
> perform during a rekey.
>
> The core can provide a helper, but I would move the whole
> "reencrypt+maybe retry" logic to a CB.

The driver callback approach sounds good.

