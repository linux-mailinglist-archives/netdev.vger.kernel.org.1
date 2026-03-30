Return-Path: <netdev+bounces-273320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPB0GLPSymmsAQYAu9opvQ
	(envelope-from <netdev+bounces-273320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:44:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5F36099E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21B1E300A671
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D239B489;
	Mon, 30 Mar 2026 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vanvalzah-com.20230601.gappssmtp.com header.i=@vanvalzah-com.20230601.gappssmtp.com header.b="08PxFZL1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EBE39B486
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899810; cv=none; b=hDsBlWV9HLKCb2h60/owhZtIgrh7HZIqB76WpH89+EH0KCxjaoiUdCTG+GmpjOBFl9dc0F13uSK3n+iYzd8Sqpgxw5T6rC+TDk4gB5qGC1AiTlFMW4eQTyj+IBi55J6fibwSIrniiKCMdBKT2T2/69itIXH2q/f18dXZjhU99x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899810; c=relaxed/simple;
	bh=+t3dAFdK+R3FJznv4V0o2Y4UBd8hPo2r6yQozGF55w8=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f3DvHrkM36ohe6uOW3mSdhSssMs4IAaBIaLO3Cpr7No+KqShrb8l7cLXW0juMokmh5eRPNZebsSCjp7KXRyvCct+x3wnD38l4zSEaNJBPYf5NXARPC0XBYGdm69Ck2wSin25PsFeYouvOXA/EsXS4HaNiVfE0h1YhekJVtVvNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanvalzah.com; spf=none smtp.mailfrom=vanvalzah.com; dkim=pass (2048-bit key) header.d=vanvalzah-com.20230601.gappssmtp.com header.i=@vanvalzah-com.20230601.gappssmtp.com header.b=08PxFZL1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanvalzah.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vanvalzah.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89fc349b5c2so23490626d6.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanvalzah-com.20230601.gappssmtp.com; s=20230601; t=1774899807; x=1775504607; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVnvOEnlzzcMRA6vcJ6WQFSlz4MS17QRsyRF4cxVWkw=;
        b=08PxFZL1Y7ad0sqNyF806uixloZgsyfFawUpR6WU5AAYUl2KeGGpE7s4jJ1TzC3OB6
         LRpvqVtQajOeKGy7f6yqeVOpBTSzeLSkjr6HZOH33/Av+WmJuK0j8aUUf9bz9qXU6FJr
         REWFUatehKq5NvbZ3shgnHoAxl3nBHibnVlozHMOBcPMuNqFtHvhPaGLAN1l+Ngp+dUs
         W7C2qssnHlf5vFHwKkD9Zg+UX8oUw2+Jp46FW6JnMf8tMgQ43hfBvCIPBMD3ykswUxxM
         l00tzAiDxjtHZsSyqzYQMBUWf+cLlhq4UYieooWUTIW9Q/jk4XfV1Gh/SbfcxnUJEB4n
         LI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774899807; x=1775504607;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EVnvOEnlzzcMRA6vcJ6WQFSlz4MS17QRsyRF4cxVWkw=;
        b=Tl4smys5oHedDCPwIgfS5zNw3AN2UJEUVFeT07keNu9ehWqGLiYSutLtfW1vlAGgSc
         fdpHbWfFi8rwuOill6lffZva6T6yY919ZdAL5aMkZ1r9yucbAH9q+yVRxQaJX6DGf1s8
         wwapFRN1iJ2x3ftpKf0VDw1eVFm5rnFb8zVk5xUJMSwxiyBAQc8Z3ml9b02l7nSVt69u
         icbcka1xBmlAdFcB5bw/10wBZrXxuG/5tLROPdOnAS6+o839LAoi0YQrjUqYRyfCqFK4
         mDcMzDUufG2mhYPSI3tldHoQQzvdeoyeWagDIrJaLgMxpYsj3fbtsDUD9S9cH0qDTDTr
         GIeg==
X-Forwarded-Encrypted: i=1; AJvYcCWPLJkxWJO5rUydQZltxqU/oHGlyT8tffRdI8cnsGSoZ9DwNzespHiuFuM3+U6YVsGjjWlVKTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Q4CqLUfRSHL+It/PE3G6ToveMJfzpLFU5PWF7cR16sg69589
	zRn/hiu8iVfwmNz2PFGhurZJ6AToNAj1IBfCAU1ueMWLxetAk4VckU4vXjtLc+hDdLQ=
X-Gm-Gg: ATEYQzyKeXt0jw74HQv72JSpwNQtEDs7wzXCqPzmDcBY2x05/9wWB4ZDK9CaU7urG6i
	MwgA8KBoqL6JxyUPCgjsRZl5vAEqFgCz1HlHPFvlEh1zM9wDJluEjaXKR1OGVgbFUF3m9fbYFR7
	x/WivIRdPSCnlv//5VaAhxxaEMlHI0NO2DLPkZGVjMEVSacogWT8p9mlEk31CIP6TxFWw5YHn4X
	aUXb5ARyC9xzcTqFyQUcmfTwOHXi9GTlAxbaAzCmXah4QGQTaaL/UbP6a9cK1KTQpmDRYaGs+op
	s32Pt/EEF1Wc16NlzCpUakn9mW1jGSYfM4RwtY4GacQpsJBQpf6LhAmTKCKcclarYb4v8cousx9
	IepbG9vAikP2o7xNSumxmx2ArGSKgtW0YIR9jVIK25TbUU7gwVrfu+kZa4deYzVLs68jm6Zd8Xu
	0GCY0=
X-Received: by 2002:a05:6214:4010:b0:8a0:29f3:1439 with SMTP id 6a1803df08f44-8a029f31c24mr90309166d6.27.1774899807239;
        Mon, 30 Mar 2026 12:43:27 -0700 (PDT)
Received: from smtpclient.apple ([75.104.94.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf95f4f9sm80203496d6.37.2026.03.30.12.43.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2026 12:43:26 -0700 (PDT)
From: Bob Van Valzah <bob@vanvalzah.com>
X-Google-Original-From: Bob Van Valzah <Bob@VanValzah.Com>
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
In-Reply-To: <65977d5b-16eb-418c-995e-6a918f67707a@linux.dev>
Date: Mon, 30 Mar 2026 14:42:29 -0500
Cc: intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org,
 julianstj@fb.com,
 jeff@jeffgeerling.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B22CCB1A-15FE-4233-9F47-7FE522C8D6FF@VanValzah.Com>
References: <D1C3B3DF-960F-40C7-BBD7-994359F0C8AD@vanvalzah.com>
 <65977d5b-16eb-418c-995e-6a918f67707a@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: Apple Mail (2.3864.400.21)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[vanvalzah-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vanvalzah-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-273320-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[vanvalzah.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bob@vanvalzah.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: C4C5F36099E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for following up Vadim. To be clear, we do not see our patch as a =
solution to the problem, since it does not eliminate the underlying =
contention, it just reduces the likelihood.

We now have a bit more hands-on time running the patch and can see its =
limitations. The driver just throws the timeout error less often now. =
Moreover, our code calling adjfine() has to be ready for an EBUSY. The =
patch is certainly not an elegant solution. It may well have worked =
better, or perhaps been a complete fix, if we had taken tmreg_lock. =
Sorry if we sent our patch prematurely.

We think the contention happens when a system call made by a clock =
disciplining daemon like ts2phc changes a PHC's frequency, while a =
timestamping daemon like ptp4l has requested a timestamp against that =
same PHC. A plausible explanation is that the hardware fails to produce =
a timestamp for a packet when it collides with a PHC frequency =
adjustment, leading to the timestamp timeout. We see this contention =
128x more often than the average user because we cranked our PTP sync =
rate up to 128 Hz. We care about every ns here. The likelihood probably =
also scales with the number of PTP clients.

Sorry, in retrospect, we may have overstated our case in declaring the =
root cause as the lack of locking, since our locking only reduces the =
likelihood of the timestamp timeout. Intel may provide insight to the =
underlying cause of the timeout, but my hunch is that the collision of a =
timestamp request against a PHC and a frequency change of the same PHC =
causes the timestamp request to fail, leading to the timeout. Our repro =
code makes this happen so reliably that it should be easy for the =
hardware guys to explain exactly what=E2=80=99s going on. Hopefully, =
they can advise on a more elegant avoidance strategy than our ham-handed =
lock.

We have not tried recovering a timestamp following the error. We may =
have used the term =E2=80=9Ccorrupted=E2=80=9D poorly here. Since the =
error message says =E2=80=9Ctimeout," that could mean the hardware =
produced no timestamp at all, rather than a corrupted one.

This isn=E2=80=99t a show-stopper for us, but we note that timekeeping =
daemons with imperfect error handling could react to this situation =
poorly and perhaps fail silently.

	Bob

> On Mar 30, 2026, at 11:39=E2=80=AFAM, Vadim Fedorenko =
<vadim.fedorenko@linux.dev> wrote:
>=20
> On 29/03/2026 04:25, Bob Van Valzah wrote:
>> Hi,
>> We found a race in igc_ptp_adjfine_i225() that causes "Tx timestamp
>> timeout" errors and eventually wedges EXTTS when a PTP grandmaster
>> (ptp4l with hardware timestamping) runs concurrently with PHC
>> frequency discipline (any GPSDO calling clock_adjtime ADJ_FREQUENCY).
>> Root cause: igc_ptp_adjfine_i225() writes IGC_TIMINCA without holding
>> any lock.  Every other PTP clock operation in igc_ptp.c (adjtime,
>> gettime, settime) holds tmreg_lock, but adjfine does not.  When the
>> increment rate changes while the hardware is capturing a TX =
timestamp,
>> the captured value is corrupt.  The driver retries for
>> IGC_PTP_TX_TIMEOUT (15s), then logs the timeout and frees the skb.
>> Repeated occurrences eventually prevent EXTTS from delivering events.
>> The attached reproducer (triggers in ~17 seconds on i226):
>>   One thread calling clock_adjtime(ADJ_FREQUENCY) at ~200k/s on the
>>   PHC, another sending UDP packets with SO_TIMESTAMPING requesting
>>   hardware TX timestamps at ~100k/s.  A Python reproducer is at:
>>   =
https://github.com/bobvan/PePPAR-Fix/blob/main/tools/igc_tx_timeout_repro.=
py
>>   At realistic rates (1 Hz adjfine from a GPSDO + ptp4l at 128 Hz
>>   sync), the race triggers in ~30 minutes.
>> The attached patch holds ptp_tx_lock around the TIMINCA write and
>> skips the write if any TX timestamps are pending (tx_tstamp[i].skb
>> !=3D NULL), returning -EBUSY.  This doesn't fully close the hardware
>> race (a new TX capture can start between the check and the write),
>> but at realistic rates the residual probability gives ~25 year MTBF
>> vs ~30 minutes without the patch.
>> A complete fix would likely require either disabling TX timestamping
>> around TIMINCA writes (via TSYNCTXCTL), or making the timeout =
recovery
>> path more robust so a single corrupt timestamp doesn't wedge the
>> subsystem.  We'd welcome guidance from the igc maintainers on the
>> preferred approach.
>> Tested on:
>>   - Intel i226 (TimeHAT v5 board on Raspberry Pi 5)
>>   - Kernel 6.12.62+rpt-rpi-2712 (Raspberry Pi OS)
>>   - Intel out-of-tree igc driver 5.4.0-7642.46
>>   - Stock upstream igc_ptp.c (same code, same bug)
>> Bob
>> ---
>>  drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c =
b/drivers/net/ethernet/intel/igc/igc_ptp.c
>> index XXXXXXX..XXXXXXX 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
>> @@ -47,8 +47,10 @@ static int igc_ptp_adjfine_i225(struct =
ptp_clock_info *ptp, long scaled_ppm)
>>  {
>>         struct igc_adapter *igc =3D container_of(ptp, struct =
igc_adapter,
>>                                                ptp_caps);
>>         struct igc_hw *hw =3D &igc->hw;
>> +       unsigned long flags;
>>         int neg_adj =3D 0;
>>         u64 rate;
>>         u32 inca;
>> +       int i;
>>         if (scaled_ppm < 0) {
>>                 neg_adj =3D 1;
>> @@ -63,7 +65,21 @@ static int igc_ptp_adjfine_i225(struct =
ptp_clock_info *ptp, long scaled_ppm)
>>         if (neg_adj)
>>                 inca |=3D ISGN;
>> -       wr32(IGC_TIMINCA, inca);
>> +       /* Changing the clock increment rate while a TX timestamp is =
being
>> +        * captured by the hardware can corrupt the timestamp, =
causing the
>> +        * driver to report "Tx timestamp timeout" and eventually =
wedging
>> +        * the EXTTS subsystem.  Serialize with pending TX =
timestamps:
>> +        * skip the rate change if any are in flight.
>> +        */
>> +       spin_lock_irqsave(&igc->ptp_tx_lock, flags);
>> +       for (i =3D 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>> +               if (igc->tx_tstamp[i].skb) {
>> +                       spin_unlock_irqrestore(&igc->ptp_tx_lock, =
flags);
>> +                       return -EBUSY;
>> +               }
>> +       }
>> +       wr32(IGC_TIMINCA, inca);
>> +       spin_unlock_irqrestore(&igc->ptp_tx_lock, flags);
>=20
> It's a bit weird solution, because in this case we may end up having =
no
> successful calls to adjfine with high amount of TX timestamp packets =
in flight. Another problem here is that access to timing registers is
> guarded by tmreg_lock, but here you use ptp_tx_lock, which protects
> queue.
>=20
> Were you able to recover "corrupted" time stamps to figure out why =
they
> are discarded?
>=20
>=20
>>         return 0;
>>  }
>> --
>> 2.39.2



