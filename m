Return-Path: <netdev+bounces-273806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UESTLdlxzGn1SwYAu9opvQ
	(envelope-from <netdev+bounces-273806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:16:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C13CD373694
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 083CB3058450
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7146282F31;
	Wed,  1 Apr 2026 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vanvalzah-com.20230601.gappssmtp.com header.i=@vanvalzah-com.20230601.gappssmtp.com header.b="ph9Ny3rZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187B2853F2
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006111; cv=none; b=LBi5Y00ACyeY9QmyMGQM7nexzV3O19xv8/W/fX9X1uhl2OERCJGtsJpqk04yS/GraWQdUWeCx+7SCATTRfoUADyuXXn3qqH53qpa2wU4V0BvwJ+4MEYfNN8UWLoJr861lzi0cPZCCvAeLVshD51UIauRKR1FjfGBP9Wmwzii0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006111; c=relaxed/simple;
	bh=EAdNCTpnm0o3FjGR4EQxD11XzSl37BZXCQ8+0vaw+lk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Oy94MWWw2xQVyNGNrjscydAGih3FbFrqXV1+ccib2XBELY1Z2OuJjbCZiZw+E5he2aYqa33kwVMAWaicpJ4KOwIon889aot2EbzQXpLKhgQ3ncp8bpx1DunRq3l75dXMl9FpQraf2Ztm8meB1dp6rT11mC7l0UvxNSdeWMdPjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanvalzah.com; spf=none smtp.mailfrom=vanvalzah.com; dkim=pass (2048-bit key) header.d=vanvalzah-com.20230601.gappssmtp.com header.i=@vanvalzah-com.20230601.gappssmtp.com header.b=ph9Ny3rZ; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanvalzah.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vanvalzah.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso5653925eec.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanvalzah-com.20230601.gappssmtp.com; s=20230601; t=1775006109; x=1775610909; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIG+o0e1lfuEhl1N7MrCiLFaDTM++cyzhQ07Sz+94dM=;
        b=ph9Ny3rZWUTSvYvEvrsgK2c2fkOAaC22rAp4GDSRIKdCyIiYaz3HTu3Ksrgd6BsvMX
         njQWJQ0btGDVc3sd7S8bPMA9t872FMjZkC6C8Jq9ztwEDA+wxaAhdUnpvOm8tGBbTzzR
         Li0DJu4TnCPop3Sy6nN+ps8Y0ot8kXARbJfzlS5+Q2sv3TkYsP6J3EvBo6leQe+1fm2Z
         J1pfHiKs8smxaReZlNyWSDQAME+LoU1FuKAjbOwZyD7mD6WlyE2wQODqPqt6kv8Ty13O
         cPZ+VJ84SWuuwVLEHaceHwIjYtDeFDPHrzKaUB2zMVRRJVTTozDDrxeEmqEeb9DwMIFI
         eKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006109; x=1775610909;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIG+o0e1lfuEhl1N7MrCiLFaDTM++cyzhQ07Sz+94dM=;
        b=CTvUkEnZJlfp97E+eqVuSCBkgTzTNZzlXHSVVPhGO5e70wYvo3Oe7YY4N+yVdbbkME
         DvSB5F/L31uu4fIs6MzWrkaNNQj+kXmp/uT7lxr/fYP2nROK/E5v+1jrfc7groxA/a28
         Eob0MnjmKCfB1dZ+6pfUDG6ml3iAVpCQrcpjTkSYO8j5xc6cHAeBxigUgTTjbu15PLVQ
         M7QXli+q3OcOmWdCTXwnysRXciV65+bHWBVKJQ34uMdNz1EoS1FrfcyT6SOABkfJtm31
         DX8mMTI8BQWY2fRvOS3VolGltLGWKYwZot0pxTv5Q6dqHpRGRQ5N/5PsjEQZ1OAmkGwQ
         YWlA==
X-Forwarded-Encrypted: i=1; AJvYcCUfCfDGytndezDMSyePQgAlrlWGlOdyIhU4CdJqft8aBjePgLmgFKsWe08rvvoHinjog/ide7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDBiiqrIaP6ypzzyqS6evLXVgA35dhp1+8IFSE3SVoHAlPdBQu
	U/rUwx1oFxypTNFIIaHKGfAytRQAe3IVCT6Kox4IL98pqCwXDlPYrW6UjzKLdtzJHtYyak5mImG
	1ttIcuzwIeg==
X-Gm-Gg: ATEYQzwhVVX2h4Yn7L+elxM+OARCb5yUIQVdTTpOerSsnO7xbHZIzU0BP/kZU+UV3dS
	EXbIkYFaQ4YIgJ9n4GstzGz9JO28F2PF0aHuzVAV0EtQ3VF5dQks0G3j3TzBGHjqVdGQaunh97G
	9HNnmWPmallbH0WK5A/jqvZ9t5HZPI78rgikPpX5B4mqfNM52WJjNZSAIgew+TCgeEwIRO+PWH4
	phb4CUeUs7MSjBECtqiNssk7muKU3io1iimo1yBF6jmOkNrskfv2SQxcKDZ/lfuVG8d9nvkQs1L
	K9fd2yb6SN4IDNzDY1BlWyvkZq9Fitrc/GfJX4NEo/X6O0PiciPmQ8iI7W7vO+hQgxhRuu2Egr0
	n+kolF/jUJhXKf+vwq7+mEVnzlIlOW/sL4tkfpc4ONQQ5oFNF5S6aIeZTAgdDbtZ/Yy7pnFTZKz
	Mq9GWVSHF9dzYALCl74H0DY/vVUMO8N7aVJe4xGJK/vB28S9p3yfA6xVYbsD8HfixEkdpU1xsiO
	vCavekz
X-Received: by 2002:a05:7301:6895:b0:2ba:6b3a:7696 with SMTP id 5a478bee46e88-2c930e6bd20mr867370eec.8.1775006108584;
        Tue, 31 Mar 2026 18:15:08 -0700 (PDT)
Received: from smtpclient.apple (syn-108-178-167-002.biz.spectrum.com. [108.178.167.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c4cbbc1fsm11057586eec.13.2026.03.31.18.15.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2026 18:15:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] igc: fix Tx timestamp timeout caused by unlocked TIMINCA
 write in adj fine
From: Bob Van Valzah <bob@vanvalzah.com>
In-Reply-To: <B22CCB1A-15FE-4233-9F47-7FE522C8D6FF@VanValzah.Com>
Date: Tue, 31 Mar 2026 18:14:57 -0700
Cc: intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org,
 julianstj@fb.com,
 jeff@jeffgeerling.com,
 Lasse Johnsen <lasse@timebeat.app>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CAD61B95-35BF-4BAC-AC26-6AC043DE6FC1@vanvalzah.com>
References: <D1C3B3DF-960F-40C7-BBD7-994359F0C8AD@vanvalzah.com>
 <65977d5b-16eb-418c-995e-6a918f67707a@linux.dev>
 <B22CCB1A-15FE-4233-9F47-7FE522C8D6FF@VanValzah.Com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: Apple Mail (2.3864.400.21)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[vanvalzah-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[vanvalzah-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-273806-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[vanvalzah.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bob@vanvalzah.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vanvalzah.com:email,vanvalzah.com:mid,vanvalzah-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C13CD373694
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is one other symptom of this bug that we neglected to report =
previously: PEROUT stops. That=E2=80=99s PPS OUT for us, so it=E2=80=99s =
how we first noticed the problem. Recovery was to unload and reload the =
igc driver.

I take this as further evidence for my hunch that the hardware just =
reaches some internal =E2=80=9Cthis should never happen=E2=80=9D state =
and the PHC just stops ticking.

Hoping this additional symptom report might help with diagnosis.

	Bob

> On Mar 30, 2026, at 12:42=E2=80=AFPM, Bob Van Valzah =
<Bob@VanValzah.Com> wrote:
>=20
> Thanks for following up Vadim. To be clear, we do not see our patch as =
a solution to the problem, since it does not eliminate the underlying =
contention, it just reduces the likelihood.
>=20
> We now have a bit more hands-on time running the patch and can see its =
limitations. The driver just throws the timeout error less often now. =
Moreover, our code calling adjfine() has to be ready for an EBUSY. The =
patch is certainly not an elegant solution. It may well have worked =
better, or perhaps been a complete fix, if we had taken tmreg_lock. =
Sorry if we sent our patch prematurely.
>=20
> We think the contention happens when a system call made by a clock =
disciplining daemon like ts2phc changes a PHC's frequency, while a =
timestamping daemon like ptp4l has requested a timestamp against that =
same PHC. A plausible explanation is that the hardware fails to produce =
a timestamp for a packet when it collides with a PHC frequency =
adjustment, leading to the timestamp timeout. We see this contention =
128x more often than the average user because we cranked our PTP sync =
rate up to 128 Hz. We care about every ns here. The likelihood probably =
also scales with the number of PTP clients.
>=20
> Sorry, in retrospect, we may have overstated our case in declaring the =
root cause as the lack of locking, since our locking only reduces the =
likelihood of the timestamp timeout. Intel may provide insight to the =
underlying cause of the timeout, but my hunch is that the collision of a =
timestamp request against a PHC and a frequency change of the same PHC =
causes the timestamp request to fail, leading to the timeout. Our repro =
code makes this happen so reliably that it should be easy for the =
hardware guys to explain exactly what=E2=80=99s going on. Hopefully, =
they can advise on a more elegant avoidance strategy than our ham-handed =
lock.
>=20
> We have not tried recovering a timestamp following the error. We may =
have used the term =E2=80=9Ccorrupted=E2=80=9D poorly here. Since the =
error message says =E2=80=9Ctimeout," that could mean the hardware =
produced no timestamp at all, rather than a corrupted one.
>=20
> This isn=E2=80=99t a show-stopper for us, but we note that timekeeping =
daemons with imperfect error handling could react to this situation =
poorly and perhaps fail silently.
>=20
> Bob
>=20
>> On Mar 30, 2026, at 11:39=E2=80=AFAM, Vadim Fedorenko =
<vadim.fedorenko@linux.dev> wrote:
>>=20
>> On 29/03/2026 04:25, Bob Van Valzah wrote:
>>> Hi,
>>> We found a race in igc_ptp_adjfine_i225() that causes "Tx timestamp
>>> timeout" errors and eventually wedges EXTTS when a PTP grandmaster
>>> (ptp4l with hardware timestamping) runs concurrently with PHC
>>> frequency discipline (any GPSDO calling clock_adjtime =
ADJ_FREQUENCY).
>>> Root cause: igc_ptp_adjfine_i225() writes IGC_TIMINCA without =
holding
>>> any lock.  Every other PTP clock operation in igc_ptp.c (adjtime,
>>> gettime, settime) holds tmreg_lock, but adjfine does not.  When the
>>> increment rate changes while the hardware is capturing a TX =
timestamp,
>>> the captured value is corrupt.  The driver retries for
>>> IGC_PTP_TX_TIMEOUT (15s), then logs the timeout and frees the skb.
>>> Repeated occurrences eventually prevent EXTTS from delivering =
events.
>>> The attached reproducer (triggers in ~17 seconds on i226):
>>>  One thread calling clock_adjtime(ADJ_FREQUENCY) at ~200k/s on the
>>>  PHC, another sending UDP packets with SO_TIMESTAMPING requesting
>>>  hardware TX timestamps at ~100k/s.  A Python reproducer is at:
>>>  =
https://github.com/bobvan/PePPAR-Fix/blob/main/tools/igc_tx_timeout_repro.=
py
>>>  At realistic rates (1 Hz adjfine from a GPSDO + ptp4l at 128 Hz
>>>  sync), the race triggers in ~30 minutes.
>>> The attached patch holds ptp_tx_lock around the TIMINCA write and
>>> skips the write if any TX timestamps are pending (tx_tstamp[i].skb
>>> !=3D NULL), returning -EBUSY.  This doesn't fully close the hardware
>>> race (a new TX capture can start between the check and the write),
>>> but at realistic rates the residual probability gives ~25 year MTBF
>>> vs ~30 minutes without the patch.
>>> A complete fix would likely require either disabling TX timestamping
>>> around TIMINCA writes (via TSYNCTXCTL), or making the timeout =
recovery
>>> path more robust so a single corrupt timestamp doesn't wedge the
>>> subsystem.  We'd welcome guidance from the igc maintainers on the
>>> preferred approach.
>>> Tested on:
>>>  - Intel i226 (TimeHAT v5 board on Raspberry Pi 5)
>>>  - Kernel 6.12.62+rpt-rpi-2712 (Raspberry Pi OS)
>>>  - Intel out-of-tree igc driver 5.4.0-7642.46
>>>  - Stock upstream igc_ptp.c (same code, same bug)
>>> Bob
>>> ---
>>> drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++++++++++-
>>> 1 file changed, 17 insertions(+), 1 deletion(-)
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c =
b/drivers/net/ethernet/intel/igc/igc_ptp.c
>>> index XXXXXXX..XXXXXXX 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
>>> @@ -47,8 +47,10 @@ static int igc_ptp_adjfine_i225(struct =
ptp_clock_info *ptp, long scaled_ppm)
>>> {
>>>        struct igc_adapter *igc =3D container_of(ptp, struct =
igc_adapter,
>>>                                               ptp_caps);
>>>        struct igc_hw *hw =3D &igc->hw;
>>> +       unsigned long flags;
>>>        int neg_adj =3D 0;
>>>        u64 rate;
>>>        u32 inca;
>>> +       int i;
>>>        if (scaled_ppm < 0) {
>>>                neg_adj =3D 1;
>>> @@ -63,7 +65,21 @@ static int igc_ptp_adjfine_i225(struct =
ptp_clock_info *ptp, long scaled_ppm)
>>>        if (neg_adj)
>>>                inca |=3D ISGN;
>>> -       wr32(IGC_TIMINCA, inca);
>>> +       /* Changing the clock increment rate while a TX timestamp is =
being
>>> +        * captured by the hardware can corrupt the timestamp, =
causing the
>>> +        * driver to report "Tx timestamp timeout" and eventually =
wedging
>>> +        * the EXTTS subsystem.  Serialize with pending TX =
timestamps:
>>> +        * skip the rate change if any are in flight.
>>> +        */
>>> +       spin_lock_irqsave(&igc->ptp_tx_lock, flags);
>>> +       for (i =3D 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>>> +               if (igc->tx_tstamp[i].skb) {
>>> +                       spin_unlock_irqrestore(&igc->ptp_tx_lock, =
flags);
>>> +                       return -EBUSY;
>>> +               }
>>> +       }
>>> +       wr32(IGC_TIMINCA, inca);
>>> +       spin_unlock_irqrestore(&igc->ptp_tx_lock, flags);
>>=20
>> It's a bit weird solution, because in this case we may end up having =
no
>> successful calls to adjfine with high amount of TX timestamp packets =
in flight. Another problem here is that access to timing registers is
>> guarded by tmreg_lock, but here you use ptp_tx_lock, which protects
>> queue.
>>=20
>> Were you able to recover "corrupted" time stamps to figure out why =
they
>> are discarded?
>>=20
>>=20
>>>        return 0;
>>> }
>>> --
>>> 2.39.2
>=20
>=20


