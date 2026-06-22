Return-Path: <netdev+bounces-301008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fiOBAMz7OGrLkwcAu9opvQ
	(envelope-from <netdev+bounces-301008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:09:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1C06AE10D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:09:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=Ht2lyFaM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301008-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301008-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85A0430610B1
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471F139A805;
	Mon, 22 Jun 2026 09:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE03976A9;
	Mon, 22 Jun 2026 09:04:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119063; cv=none; b=TxuFacbulCFiuWJ2GNx39AF2BlnTsaU5yL1CjJVPDZXG1tLY/CsSgJnV/W5Znn7qs5Sb7/lJYT6qKx7QuVz4uvvT4u8Sd6WWOxqbqlw4ehj/Txlz9wFlCg7bjwONIYBAnLz148qcKWuZHrHFfKgxZE3Jos15UY5S9ItH9WNUJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119063; c=relaxed/simple;
	bh=3hjWglHfSljhPOd/KvcczoPtK3bNrdWdEtX0URalaSI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qlFpjZCq407Uu8QwC6cQyuSwyLmDugv2SXMpl9PHp60TJNcYcw87T5M4VF0Gc3nh6+W5ViK4ObDdpGBroCDMtUboqh1ZJMice3S7D1TIcDhQT7ZPYY0xDize0jDOFXZh5wxRepRnphfHms+YQ+vunCG7OzNkKYFEopfWc7DmMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ht2lyFaM; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yasKb5W57OYgDjTdoL+qW578UUtpnhFARQvgvno1ejw=; b=Ht2lyFaM+zdnEwULFhcA9HVWuj
	IKC1N7xu8ERo0ujtaYSlx/YufdsnAzTwutKe4jHhzEgFzH8dmhjLk2eV1LITp/p1Ztcm4xEhWQ3bs
	dnKm5/QG6Oi8tnfXA5uNPQMc6aTUj6Rh3nu5cx9pplg/GNHvJR/qPb1/OIKkuQ4o874yECThrdWjt
	WLCdC3cHH96GwFcfkhbuamuTDxG0h3nxa3cwY3ugzUu1dpBngDSlEbTRnEBoa+3k8sNobQrxIZD24
	hIpbmQh5H2E+e0iXHJdkB/w4oZD9B5BkB/TkmeFyalKwpJWFk2oKH3WFuEt2INBv2I4MsWHtdxhtm
	CMGdMzug==;
Received: from [2001:8b0:10b:5:9b49:795b:48f5:139a] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbaZl-00000003www-0nrv;
	Mon, 22 Jun 2026 09:04:17 +0000
Message-ID: <fea6f61960132ffafc94a8b74adc37d8dd2f79be.camel@infradead.org>
Subject: Re: [RFC v2] Enabling CONFIG_NTP_PPS for NOHZ by adding ntp_error
 to system_time_snapshot
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Richard Cochran	 <richardcochran@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>, Alexander Gordeev
	 <agordeev@linux.ibm.com>
Date: Mon, 22 Jun 2026 10:04:17 +0100
In-Reply-To: <3b10d2e91b18f49d8a3e6226b08ac8cd9cb49aa6.camel@infradead.org>
References: <3b10d2e91b18f49d8a3e6226b08ac8cd9cb49aa6.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-Q3Q2zOmnLo31GFPkE090"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa6 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:jstultz@google.com,m:sboyd@kernel.org,m:mlichvar@redhat.com,m:richardcochran@gmail.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:giometti@enneenne.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-301008-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,amazon.co.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B1C06AE10D


--=-Q3Q2zOmnLo31GFPkE090
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-06-21 at 23:30 +0100, David Woodhouse wrote:
> Open question: *how* should this be exposed? It's all very well putting
> it into ktime_get_snapshot_id() like this, and we could easily make an
> argument that pps_get_ts() should just add it unconditionally, because
> *not* doing so makes no sense.

Hm, I'm leaning towards adding it unconditionally in
ktime_get_snapshot_id() and get_device_system_crosststamp(), and not
adding the extra field to the system_time_snapshot at all...

From: David Woodhouse <dwmw@amazon.co.uk>
Date: Fri, 19 Jun 2026 00:00:29 +0100
Subject: [PATCH] timekeeping: Apply extrapolated ntp_error to clock snapsho=
ts

The time reported in ::systime of a system_time_snapshot is known to be
slightly inaccurate because of the way that the reported realtime clock
sawtooths around the *intended* time series, limited by the integer mult
value used to calculate the inter-tick times, and designed to ensure
smoothness and monotonicity for its consumers.

It is particularly inaccurate in a tickless kernel, where ntp_err_mult
is not adjusted on each tick, allowing the reported clock to diverge
from the intended time for a large number of ticks before re-converging.

This appears to be the reason why CONFIG_NTP_PPS is not enabled on
tickless kernels =E2=80=94 because at that scale of precision, the realtime
snapshot at the time of the pulse bears little relation to the time the
kernel *actually* believes it to be, thus introducing random errors into
the PPS phase correction.

It would be better for callers of get_device_system_crosststamp() and
ktime_get_snapshot_id() to receive the *accurate* time, not the
sanitized version provided to gettimeofday().

Compute the deviation in snapshot_ntp_error() and add it to the returned
::systime so the snapshot lands on the ideal line. It sums four terms in
ns << NTP_SCALE_SHIFT before converting to signed ns:

  - tk->ntp_error, the deviation as of the last update;
  - (cycle_delta * ntp_err_frac), the fractional-mult drift accrued
    since then (cycle_delta is at most a tick on a tickful kernel, but
    many ticks' worth under NO_HZ);
  - (cycle_delta * ntp_err_mult), subtracting the applied +1 mult dither
    over the same span;
  - the sub-nanosecond fraction dropped when the read was truncated to
    whole ns (low shift bits, exact despite the multiply overflowing).

The helper uses the timekeeper selected for the requested clock id, so
all NTP-disciplined clocks are corrected, including the AUX clocks (each
has its own NTP instance); only CLOCK_MONOTONIC_RAW is undisciplined and
gets no correction. The residual is then a single clocksource cycle, the
same bound as a tickful kernel.

Note that this *unconditionally* changes the ::systime returned by all
snapshot and cross timestamp consumers (PTP SYS_OFFSET_PRECISE/EXTENDED,
etc.): it is now the ideal NTP-disciplined time rather than the raw
accumulated clock.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.8
---
 include/linux/timekeeper_internal.h |  6 +++
 kernel/time/timekeeping.c           | 71 +++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper=
_internal.h
index 5dc7f8bf2740..b487e7d925fe 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -97,6 +97,11 @@ struct tk_read_base {
  * @ntp_error_shift:		Shift conversion between clock shifted nano seconds =
and
  *				ntp shifted nano seconds.
  * @ntp_err_mult:		Multiplication factor for scaled math conversion
+ * @ntp_err_frac:		Fractional part of the per-cycle NTP-ideal mult that th=
e
+ *				integer @mult truncates, as a fraction of 2^32 in
+ *				clock-shifted nanoseconds per cycle. Used to
+ *				extrapolate @ntp_error to an arbitrary cycle count in
+ *				the lockless snapshot readers (ktime_get_snapshot_id).
  * @cs_tick_adj:		Per-second adjustment handed to NTP via ntp_clear()
  *				accounting for the difference between the nominal
  *				NTP interval and the real time taken by the
@@ -187,6 +192,7 @@ struct timekeeper {
 	s64			ntp_error;
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
+	u64			ntp_err_frac;
 	s64			cs_tick_adj;
 	u32			skip_second_overflow;
 	s64			skew_delta;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index de07ef65da32..56f4a22d13d7 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -422,6 +422,7 @@ static void tk_setup_internals(struct timekeeper *tk, s=
truct clocksource *clock)
 	tk->tkr_mono.mult =3D clock->mult;
 	tk->tkr_raw.mult =3D clock->mult;
 	tk->ntp_err_mult =3D 0;
+	tk->ntp_err_frac =3D 0;
 	tk->skip_second_overflow =3D 0;
 	tk->skew_delta =3D 0;
=20
@@ -1226,6 +1227,51 @@ static inline u64 tk_clock_read_snapshot(const struc=
t tk_read_base *tkr,
 	return clock->read(clock);
 }
=20
+/*
+ * snapshot_ntp_error - record how far a snapshot's ::systime is from the
+ * ideal NTP-disciplined time at @now, in signed nanoseconds, so a caller
+ * can land exactly on the ideal line by adding it to ::systime.
+ *
+ * The value is summed in ns << NTP_SCALE_SHIFT from four parts:
+ *
+ *  - tk->ntp_error, the deviation accumulated as of the last timekeeping
+ *    update (tkr_mono.cycle_last);
+ *  - (cycle_delta * ntp_err_frac), the fractional-mult drift accrued over
+ *    the cycles read since then -- at most a tick on a tickful kernel, bu=
t
+ *    potentially many ticks' worth under NO_HZ;
+ *  - (cycle_delta * ntp_err_mult), subtracting the applied +1 mult dither
+ *    over the same span;
+ *  - the sub-nanosecond fraction that ::systime dropped when the read was
+ *    truncated to whole ns (the low @shift bits, exact even though the
+ *    multiply overflows).
+ *
+ * CLOCK_MONOTONIC_RAW is not NTP-disciplined and carries no error. Every
+ * other clock id uses its own timekeeper @tk -- including the AUX clocks,
+ * which each have their own NTP instance.
+ */
+static s64 snapshot_ntp_error(const struct timekeeper *tk, clockid_t clock=
_id,
+			      u64 now)
+{
+	u64 cycle_delta;
+	u32 nes;
+	s64 tmp, err;
+
+	if (clock_id =3D=3D CLOCK_MONOTONIC_RAW)
+		return 0;
+
+	cycle_delta =3D (now - tk->tkr_mono.cycle_last) & tk->tkr_mono.mask;
+	nes =3D tk->ntp_error_shift;
+
+	err =3D tk->ntp_error;
+	err +=3D ((s64)mul_u64_u64_shr(cycle_delta, tk->ntp_err_frac, 32) -
+		(s64)(cycle_delta * tk->ntp_err_mult)) << nes;
+
+	tmp =3D (s64)(cycle_delta * tk->tkr_mono.mult + tk->tkr_mono.xtime_nsec);
+	tmp &=3D (1ULL << tk->tkr_mono.shift) - 1;
+	err +=3D tmp << nes;
+
+	return (err + (1LL << (NTP_SCALE_SHIFT - 1))) >> NTP_SCALE_SHIFT;
+}
=20
 /**
  * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
@@ -1238,6 +1284,7 @@ void ktime_get_snapshot_id(clockid_t clock_id, struct=
 system_time_snapshot *syst
 {
 	ktime_t base_raw, base_sys, offs_sys, *offs, offs_zero =3D 0;
 	u64 nsec_raw, nsec_sys, now;
+	s64 ntp_error;
 	struct timekeeper *tk;
 	struct tk_data *tkd;
 	unsigned int seq;
@@ -1300,10 +1347,12 @@ void ktime_get_snapshot_id(clockid_t clock_id, stru=
ct system_time_snapshot *syst
=20
 		nsec_sys =3D timekeeping_cycles_to_ns(&tk->tkr_mono, now);
 		nsec_raw =3D timekeeping_cycles_to_ns(&tk->tkr_raw, now);
+
+		ntp_error =3D snapshot_ntp_error(tk, clock_id, now);
 	} while (read_seqcount_retry(&tkd->seq, seq));
=20
 	systime_snapshot->cycles =3D now;
-	systime_snapshot->systime =3D ktime_add_ns(base_sys, offs_sys + nsec_sys)=
;
+	systime_snapshot->systime =3D ktime_add_ns(base_sys, offs_sys + nsec_sys)=
 + ntp_error;
 	systime_snapshot->monoraw =3D ktime_add_ns(base_raw, nsec_raw);
=20
 	/*
@@ -1552,6 +1601,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 	unsigned int seq, clock_was_set_seq =3D 0;
 	ktime_t base_sys, base_raw, *offs;
 	u64 nsec_sys, nsec_raw;
+	s64 ntp_error;
 	u8 cs_was_changed_seq;
 	bool do_interp;
 	struct timekeeper *tk;
@@ -1617,9 +1667,10 @@ int get_device_system_crosststamp(int (*get_time_fn)
=20
 		nsec_sys =3D timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
 		nsec_raw =3D timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
+		ntp_error =3D snapshot_ntp_error(tk, xtstamp->clock_id, cycles);
 	} while (read_seqcount_retry(&tkd->seq, seq));
=20
-	xtstamp->sys_systime =3D ktime_add_ns(base_sys, nsec_sys);
+	xtstamp->sys_systime =3D ktime_add_ns(base_sys, nsec_sys) + ntp_error;
 	xtstamp->sys_monoraw =3D ktime_add_ns(base_raw, nsec_raw);
=20
 	/*
@@ -2447,6 +2498,7 @@ static void timekeeping_adjust(struct timekeeper *tk,=
 s64 offset)
 {
 	u64 ntp_tl =3D ntp_tick_length(tk->id);
 	s64 skew =3D ntp_get_skew_delta(tk->id);
+	u64 dividend;
 	u32 mult;
=20
 	/*
@@ -2467,8 +2519,19 @@ static void timekeeping_adjust(struct timekeeper *tk=
, s64 offset)
 		 * scale it back up to the full per-tick rate for the mult bias.
 		 */
 		skew *=3D NTP_INTERVAL_FREQ;
-		mult =3D div64_u64((tk->ntp_tick + skew) >> tk->ntp_error_shift,
-				 tk->cycle_interval);
+		dividend =3D (tk->ntp_tick + skew) >> tk->ntp_error_shift;
+		mult =3D div64_u64(dividend, tk->cycle_interval);
+		/*
+		 * Stash the fractional part of the per-cycle ideal mult that
+		 * the integer @mult discards, scaled by 2^32, in clock-shifted
+		 * ns per cycle. The lockless snapshot readers use it to
+		 * extrapolate @ntp_error forward over the cycles accumulated
+		 * since the last tick (which on a NO_HZ kernel may be many
+		 * ticks' worth).
+		 */
+		tk->ntp_err_frac =3D div64_u64((dividend - (u64)mult *
+					      tk->cycle_interval) << 32,
+					     tk->cycle_interval);
 	}
=20
 	/*
--=20
2.43.0


--=-Q3Q2zOmnLo31GFPkE090
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYyMjA5MDQx
N1owLwYJKoZIhvcNAQkEMSIEIN47exOOV8Grh514hhl4KVRHl0MYw6BIhdyW3FGcn16VMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAZl+WB4Nz+pRT
3y9ncaduCdLcqlSWy7jXKREH4Z1ymk4ZPsDt50YESfPkhutEk1uZxtqeB2L/SUKiYoZnILZ9096A
9FPeDl4IKy821+LwHeyg1WWvFVVBLy9m5fiL9PqkTV3dxihSHD+WGJwY2ROmRlceoF/LCE7vymvl
9udU25bPSBLWnCR/x93iJubwWCxek7TUaoAgPJqdRKll0fQLGzwMG2oPeA9WKvPuTS/Wp0mEx0NF
uQaB31xQoIT5z27P4sUQNJmV75yUiw2IEL5taVg5zabSiS0Qgh0NbARl/Ka0GhQKMd6lMjBRLTkR
gg5nxc5BjlFbCmDgVTs5ywwzjw/8PaClQRh7phhKqJvM8GJm4HJ1q4x8Yj/2+OwTlxRJPXn3o0Xn
Qbs7bsjqCLiPSXvYQNYi0KdJsfkLQPln8rFOp9/9aNp4j5+IypWFVcJtkUKnUleLjhvbuK6g5Z+q
xfkXJLgB0qP9oQAE1EOvY56Jqgz2j8kJkCNss1t039w26FevPxD7Kqh+1xVz7bXjbdrWB5JN1lhV
TozE8zr0+5EoFj+0LPg7OZvcHqg1EjWmB02dUGl6RBYOSaMWvW3S3aJboC88i1Av9fxPyJ+ZWjFO
FDg0nDSWT/ao7iLI+dY/TXoiKMVp1kQj+tqF5brLRAkGyht+KEvtZnttbkmndoYAAAAAAAA=


--=-Q3Q2zOmnLo31GFPkE090--

