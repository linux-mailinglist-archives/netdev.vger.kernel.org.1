Return-Path: <netdev+bounces-290600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C5TLD1kD2rlKAYAu9opvQ
	(envelope-from <netdev+bounces-290600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:59:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1447F5AB9F8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFDAF302BA46
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4730A405C5C;
	Thu, 21 May 2026 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BfbwIo5c"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44392874FF;
	Thu, 21 May 2026 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779393594; cv=none; b=e/CHTORNgS6RjMCr9/Jt108cVgO1Ug+sJRoXDuHR1fDLXxgp23jSpwWKrlAEDm1LsQtOWk+CpWA/ia1URm+ChpXJcMmouy32kqOPzZy+N12lPthVzXfUwiSvH478pwgmfo0qBj2jR5eA3hNVfUx3J11aAuMshE2luJCfaPQFOxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779393594; c=relaxed/simple;
	bh=gjfByCwzDky08+S3gslvXDg4oU73RpTakWgwED78hEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KAZR64MkpR+v1QXZPRRA5yC1kfn1X/u8rsQQHW0ySR6ZdMCZ3ym7ZFQlwcfZO5F1rFzuoxEyO08TOZu25rukdVkuUG01mSk4r6LCepgo17aHDqN4OJ98AKcMiEpEzwGWEYwYrHNY8YUP+9DSS2KPsBNpFll6BHKOED2BGDFFaY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BfbwIo5c; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V1UVcWNWNpiMHpcNF84e/m4vZrmrOofyw/ULpxYbqoA=; b=BfbwIo5cdZTdRwkHfOxozy9eIS
	aAjzscPmMVUuatLjJr+7/jksIVCnyCZ+fgW2aD+GxNDOTwOkDsWQao34Vmq6CHmFHObvFGGnpcR9J
	r2YsPi4chMJN6UzpViLt+0ER+6uSDrYPqSXQGE4KdcQM4H9Hs5Yqa4vVadnuB9GvglEo6kKfqpIAj
	mK/RKzMu55b8sok7OA1YtSSt1xq8L8hPG9uMKqLeJErLBxZgWdtszhff51RNOfhEQNK1hLBJPSEYZ
	0+yyoOejf2+bL49qF+w/cZRHfmWn2stkfZ/lbEsGqIxDxBQAZGxVDsPJaUy0pjuuKUDksEwEz13mH
	TDTiwBsg==;
Received: from 54-240-197-239.amazon.com ([54.240.197.239] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ9YT-00000008y2q-2FE3;
	Thu, 21 May 2026 19:59:41 +0000
Message-ID: <63ff978516925951df0f95aecbd4ea5d7bb2956e.camel@infradead.org>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>, Harshitha Ramamurthy
	 <hramamurthy@google.com>, netdev@vger.kernel.org, Arthur Kiyanovski
	 <akiyano@amazon.com>
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com,  jstultz@google.com, sboyd@kernel.org,
 willemb@google.com, nktgrg@google.com,  jfraker@google.com,
 ziweixiao@google.com, maolson@google.com,  jordanrhee@google.com,
 thostet@google.com, alok.a.tiwari@oracle.com,  pkaligineedi@google.com,
 horms@kernel.org, jacob.e.keller@intel.com,  yyd@google.com,
 jefrogers@google.com, linux-kernel@vger.kernel.org, Naman Gulati
 <namangulati@google.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <thomas.weissschuh@linutronix.de>
Date: Thu, 21 May 2026 20:59:39 +0100
In-Reply-To: <87tss0vdrj.ffs@tglx>
References: <20260514225842.110706-1-hramamurthy@google.com>
	 <20260514225842.110706-4-hramamurthy@google.com>
	 <cd5868258edee932fd9b4ed46a48b5a07b4c6da8.camel@infradead.org>
	 <87tss0vdrj.ffs@tglx>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-q4pv4qNVZy2MdWJ8X4OW"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290600-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org,linutronix.de];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 1447F5AB9F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-q4pv4qNVZy2MdWJ8X4OW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-21 at 20:06 +0200, Thomas Gleixner wrote:
> On Thu, May 21 2026 at 12:43, David Woodhouse wrote:
>=20
> > With PTM and the various virt enlightenments, there are an increasing
> > number of "PTP" clocks which literally *just* tell us a cycle count at
> > the moment of the corresponding reading, and we don't need the ABA
> > sandwich of local clock readings around it any more.
>=20
> That's what the PRECISE ioctl and ptp::info::getcrosstimestamp() is for,
> which utilizes get_device_system_crosststamp() and provides the
> translation from PTM, on x86 that's ART which is converted to TSC.
>=20
> It then correlates the converted system time stamp to CLOCK_REALTIME and
> CLOCK_MONOTONIC_RAW.
>=20
> That has been implemented long ago exactly for that purpose, but people
> need to reinvent the wheel over and over just because it makes the
> kernel so more maintainable.
>=20
> > I've got another one waiting in the wings which will literally just
> > latch the counter value when a PPS signal comes in, too.
>=20
> That can use a similar mechanism.

Yep. In both cases, some userspace actually wants the *counter value*.

> > It might be good to harmonise the way we convert to KVM clock if we're
> > going to support that (although I'll accept an argument that any guest
> > which chooses to use the KVM clock doesn't *deserve* to have accurate
> > timekeeping).
>=20
> :)

I'm not sure I'm joking. The KVM clock is.... *hosed*. It was invented
to work around the ancient broken variable-speed TSCs which stopped on
HLT, etc.

In *those* days, sure it made sense for the hypervisor to constantly
update a data structure which let you approximate a TSC=E2=86=92nanoseconds
conversion.

These days, a guest using the *actual* TSC is going to be a lot more
accurate, and guests basically shouldn't be using the kvmclock AT ALL.

When I made it DTRT for ptp_vmclock, I did look briefly at what it
would take to do it centrally in common code.

But that lumbers the common PTP code with x86 arch-specific horridness
about the KVM clock. And it literally has to call back into the driver
in the seqcount loop, so I guess drivers would need to have a flag or
something that says it's OK to do that (they're fast enough, or
something?).

I didn't spent *that* long trying, but I couldn't see a way of doing it
centrally, which didn't end up making me sadder than the initial
duplication.

Honestly, whether it was intent or omission, I suspect the approach
Harshitha took for GVE is the right one: Support TSC, and anyone who
uses KVM clock doesn't deserve accurate time anyway.

> > I'd also like consensus on exposing it to userspace. I think Thomas is
> > going to suggest that we should always convert to MONOTONIC_RAW, but
> > what I asked Arthur to do in=20
> > https://lore.kernel.org/all/20260515164033.6403-1-akiyano@amazon.com/
> > exposes the raw counter values instead.
>=20
> I'm not against that per se, but that really wants to be a consistent
> snapshot and not some pulled out of thin air cycles value.

Definitely.

> ktime_get_snapshot() provides that already today, so that can be
> arguably used for pre/post timestamp mechanisms, except that it lacks
> support for AUX clocks.
>=20
> get_device_system_crosststamp() does not provide cycles and clock id,
> but that's not rocket science to extend.

Yep.

> > From the dedicating hosting point of view, we *only* care about the
> > counter, and absolutely DGAF about the host's timekeeping. Migrating
> > KVM guests requires getting the guest TSC right (in terms of scaling
> > factors and offset from the host TSC), and feeding accurate time to
> > guests is done in terms of the guest TSC to realtime relationship.
>=20
> The offset has nothing to do with the scaling. It's the delta to the TSC
> value which the migrated guest saw last when it was packed up for
> migration.

Sure. As long as that guest TSC value is a consistent snapshot and not
some pulled out of thin air cycles value :)

There is lots to be said about accurate KVM migration, and a series of
30-odd patches on the KVM list which attempts to improve it.

But either way, we still DGAF about the host's CLOCK_REALTIME when
we're doing it at scale.

KVM doesn't *have* a clean way to get/set the guest TSC based on
realtime; it only has the scaling and offsets from the host TSC. So to
do things precisely, we end up converting via the host TSC.

So we end up comparing a {host TSC, realtime} pair between source and
destination hosts, calculating the *guest* ticks that should have
occurred in the intervening time, and setting the "offset from host" on
the destination host to achieve the desired results. Almost all of
which is in terms of TSC cycles and offsets.

> > So our ideal state is that we discipline the TSC against real time in
> > userspace, and enabling those PHC drivers to *give* us the raw cycle
> > counts that they actually measured seemed best.
>=20
> As I said, I'm not against that per se, but then we want to provide
> interfaces which are generic enough so they can be used for your
> purposes, but also for the requirements of chrony et al. Looking at the
> patch you linked to above:
>=20
> > +static long ptp_sys_offset_precise_attrs(struct ptp_clock *ptp, void _=
_user *arg)
> > +{
> > +	struct ptp_sys_offset_precise_attrs precise_offset_attrs;
> > +	struct system_device_crosststamp xtstamp;
> > +	struct ptp_clock_attributes att =3D {};
> > +	struct timespec64 ts;
> > +	int err;
> > +
> > +	if (!ptp->info->getcrosststampattrs)
> > +		return -EOPNOTSUPP;
> > +
> > +	err =3D ptp->info->getcrosststampattrs(ptp->info, &xtstamp, &att);
> > +	if (err)
> > +		return err;
> > +
> > +	memset(&precise_offset_attrs, 0, sizeof(precise_offset_attrs));
> > +	ts =3D ktime_to_timespec64(xtstamp.device);
> > +	precise_offset_attrs.device.pct.sec =3D ts.tv_sec;
> > +	precise_offset_attrs.device.pct.nsec =3D ts.tv_nsec;
> > +	precise_offset_attrs.device.att.error_bound =3D att.error_bound;
> > +	precise_offset_attrs.device.att.timescale =3D att.timescale;
> > +	precise_offset_attrs.device.att.status =3D att.status;
> > +	precise_offset_attrs.device.att.counter_id =3D att.counter_id;
> > +	precise_offset_attrs.device.att.counter_value =3D att.counter_value;
>=20
> That's exactly the hackery which is counterproductive. Why?

That's the same pattern as in the existing ptp_sys_offset_precise(),
isn't it? Copying from the internal data structures it got from the
driver, into the specific userspace structure for the ioctl that was
called.

> Where does ptp::info::getcrosststampattrs() retrieve the system counter
> value from?
>=20
> Either it has to convert from the ART based timestamp to TSC magically
> by circumventing the core code or it has to use get_cycles() separately
> which defeats the whole purpose of a hardware latched combo timestamp.

The point in ptp_sys_offset_precise is that all the timestamps are the
*same* time, isn't it?=20

So surely a device can only support this if it *does* have a precise
hardware timestamp, e.g. from ART? And the corresponding sys_realtime
and sys_monoraw fields also have to be from the *same* value, surely?

Is that not how it works? If not.... WTF *is* it for?

We're allowed to set *fire* to anyone who just throws a random
get_cycles() call in there, aren't we? That's basically just self-
defence, m'lud.


> While this:
>=20
> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index aee2c1a46e47..43a55f618235 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -296,19 +296,6 @@ struct system_time_snapshot {
> =C2=A0	u8			cs_was_changed_seq;
> =C2=A0};
> =C2=A0
> -/**
> - * struct system_device_crosststamp - system/device cross-timestamp
> - *				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (synchronized capture)
> - * @device:		Device time
> - * @sys_realtime:	Realtime simultaneous with device time
> - * @sys_monoraw:	Monotonic raw simultaneous with device time
> - */
> -struct system_device_crosststamp {
> -	ktime_t device;
> -	ktime_t sys_realtime;
> -	ktime_t sys_monoraw;
> -};
> -
> =C2=A0/**
> =C2=A0 * struct system_counterval_t - system counter value with the ID of=
 the
> =C2=A0 *				corresponding clocksource
> @@ -325,6 +312,21 @@ struct system_counterval_t {
> =C2=A0	bool			use_nsecs;
> =C2=A0};
> =C2=A0
> +/**
> + * struct system_device_crosststamp - system/device cross-timestamp
> + *				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (synchronized capture)
> + * @device:		Device time
> + * @sys_counter:	Clocksource counter value simultaneous with device time
> + * @sys_realtime:	Realtime simultaneous with device time
> + * @sys_monoraw:	Monotonic raw simultaneous with device time
> + */
> +struct system_device_crosststamp {
> +	ktime_t				device;
> +	struct system_counterval_t	sys_counter;
> +	ktime_t				sys_realtime;
> +	ktime_t				sys_monoraw;
> +};
> +
> =C2=A0extern bool ktime_real_to_base_clock(ktime_t treal,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 enum clocksource_ids base_id, u64 *cyc=
les);
> =C2=A0extern bool timekeeping_clocksource_has_base(enum clocksource_ids i=
d);
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index c493a4010305..11df7e25bdca 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1506,6 +1506,7 @@ int get_device_system_crosststamp(int (*get_time_fn=
)
> =C2=A0		nsec_raw =3D timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
> =C2=A0	} while (read_seqcount_retry(&tk_core.seq, seq));
> =C2=A0
> +	xtstamp->sys_counter =3D system_counterval;
> =C2=A0	xtstamp->sys_realtime =3D ktime_add_ns(base_real, nsec_real);
> =C2=A0	xtstamp->sys_monoraw =3D ktime_add_ns(base_raw, nsec_raw);
> =C2=A0
> Provides the information coherently and without any extra hacks. No?

Yeah, that looks eminently reasonable. It isn't actually that far off
what Arthur did in patch 1 of the series, is it? He was adding other
clock quality attributes at the same time, and ended up shoe-horning
the cs_id and cycle_count into those instead of using a separate
system_counterval_t as you have here, which *is* cleaner. So yes, let's
get him to do that, but that part is cosmetic?

> Extending get_device_system_crosststamp() for AUX clocks is on my todo
> list for a long time, but I did not come around to it yet. It's not
> really complicated to make that work.
>=20
> The actual ena_phc_gettimexattrs64() implementation does not provide the
> counter value at all despite the fact that it could trivially do so with
> a modified ktime_get_snapshot() except for AUX clock IDs, but that's a
> solvable problem. See uncompiled PoC below.

Huh? Unless it has PTM and is converting from ART (or is something
virtual like vmclock or the older non-LM-safe KVM hacks), surely the
driver has no business pretending to support 'precise' mode, and no
business providing a counter value?

In this case, we'd want the pre_ts and post_ts to be generated by the
common code using ktime_get_snapshot_id(cs_id) so that we have the
corresponding system_counterval_t in the 'A' parts of the ABA tuple...
but the device part of it can't pull one out of thin air unless it is
*part* of the device reading, surely?

> I really have to ask why we put a lot of effort into consolidated
> infrastructure, when every drivers/foo/ subsystem decides it needs it's
> own absymal hacks just because sitting down and extending the generic
> infrastructure is asked too much. TBH, that's frustrating as hell and
> no, none of these usecases is so special that it would justify a single
> one of these hacks.

Meh. I'm literally here trying to join the dots between timekeeping,
PTP and KVM, and come up with a holistic solution that makes sense for
all the use cases. And my brain hurts... :)


> -EXPORT_SYMBOL_GPL(ktime_get_snapshot);
> +EXPORT_SYMBOL_GPL(ktime_get_snapshot_id);

Ack. I think Arthur needs to use that in the pre_ts/post_ts helpers. Thanks=
.

--=-q4pv4qNVZy2MdWJ8X4OW
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMTE5NTkz
OVowLwYJKoZIhvcNAQkEMSIEIIMRN4v0JWlOF2Hvh2NqSYZJDW2NUwPy1J1aC+R4/R8TMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAjsINUALAM41U
SRm5CO19+HhbcEL2/ct/zi//u4/kvqBdOSjyBVbaMeXmc0nR+ZcgOh9L3BzBoMiSVc/npBSmrwiU
rTXl6ur8MBX/m/p0RE869tDUTeRYFFiCNPvYaJSBzfGx2wJd8L2AjviWmOJPNkRva5woqTSIpH49
knt+Zl1Wd/ed7hR5CHwS2iB9PQgtPwrVEmd9GMR5CdkqoAocbT3Qb6CVtBIPtErSpFjppdqdJTZ/
YTVUgsUtLAzSgysYNP4kuq6BtRWbAuBdNWLxsd0lDo60eCsVAA/U1h4lESlEXCaFcjoLViF/muad
PncPhT4sGuLixIYIz+dQaCuSValjbwF9FK2/dkBx0oFqvST660N/fq1U14NQRTbuMTQw2Vp4c27V
EZayQ1cyvkZKOQ13nXKnidZol7GaFYQqf+W9/H0c1FZwlVRIr75BRKv817+7CXz45AHUUponb0wP
GfXkgptfMkIlM29/3gl3nzz8e3aY0vRUjU6IDVl3JNtQGYTrrbgxpJpV/xDA9EuoNsybSYo6PpgO
R+JUzYIJY+MjKzvwpiD0vapgeIjnKlJIfowSf1Y/2i2EajmZNaWnjOWhsfc7Lh5NQ3ONIbqzHOdM
3fBhcr0EAIaHY+RZYUQKPIc3FUlD+fbJDu87N0ohxEv9VJllQd37CQA9n6C4b60AAAAAAAA=


--=-q4pv4qNVZy2MdWJ8X4OW--

