Return-Path: <netdev+bounces-300931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DGlaDhxmOGqobwcAu9opvQ
	(envelope-from <netdev+bounces-300931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:30:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDB06ABC11
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:30:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=muj4RWoH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300931-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300931-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55401300187A
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271437881E;
	Sun, 21 Jun 2026 22:30:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079E305684;
	Sun, 21 Jun 2026 22:30:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782081045; cv=none; b=FLHExIhtFVSP2Ng25Uwep7lIrSF8nf6825nar+VerXBRXwnrpkFd0TnMKSJ1GlejEUsUN8p3/MCCmxZMpbTEWJX6Ssf7dJuNmWuyMvzEnCk4HL8N/k2aJ9SqX+jtnVXwP6LR1/+357pckb5VT6JvNSpLoDUwWPFu0V9drc9ppuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782081045; c=relaxed/simple;
	bh=SEYIyBfse9XwQmZoqq77qs+QS8GFG89YvmFRv4OEW/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=qhByq31loDJlcwh1yswq5vxRHrq0IYX6d0T4sExKeXQIZsVE1FIQ10bwWQC9d+fOltkB0W61rnZ92/GOHBRfx+K2XvVu90Tr0MrsBq8I6b/h29M5Bocewbxubq69JIpI5qlD7bsOb2J7CTZ96dQkBH2PRVAZK2PCRPt11MAoVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=muj4RWoH; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=TfrIMk6Iycp4r6ZcbQDJIvnD0InmDTXAwL+C7DFF38o=; b=muj4RWoHHaQlAO7GJv6mJksPi6
	THUXtYyylova0aHLWYlRN5ZtxgtWGQCdhCuDWzsQI0BWC+7vbDWZ6IPd8VgPc+eFMr4YyUugaMf/B
	LwbiuPcRJDmxbHepw6UlOtPPgZVxG9Emk8wDO+1fmw4rh3aDvY99gYTrfHAr+44nL1nsxm7NOrFMn
	L5LY0FfyooEipc4tU5wnbi4I5VUAStGPlAnLdH2OHje5PmKp7MYcgKVwMEbKIXWYIPABbirW8mSHO
	CINEGTcQYCeQfrCnon++FOKskArQG7B6C0nDjk95gu0ZYQMxALCF430dukosvZ10g7+M99+c0v81i
	oL6jZT/g==;
Received: from [2001:8b0:10b:5:9b49:795b:48f5:139a] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbQga-000000036hP-1S3i;
	Sun, 21 Jun 2026 22:30:41 +0000
Message-ID: <3b10d2e91b18f49d8a3e6226b08ac8cd9cb49aa6.camel@infradead.org>
Subject: [RFC v2] Enabling CONFIG_NTP_PPS for NOHZ by adding ntp_error to
 system_time_snapshot
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Richard Cochran	 <richardcochran@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>, Alexander Gordeev
	 <agordeev@linux.ibm.com>
Date: Sun, 21 Jun 2026 23:30:40 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-6ImTasvTsIePIk3mFeGC"
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:jstultz@google.com,m:sboyd@kernel.org,m:mlichvar@redhat.com,m:richardcochran@gmail.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:giometti@enneenne.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300931-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amazon.co.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EDB06ABC11


--=-6ImTasvTsIePIk3mFeGC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Since the series at
https://lore.kernel.org/all/20260621220051.1030462-1-dwmw2@infradead.org/
we know *precisely* how much the xtime reported as CLOCK_REALTIME
differs from what the kernel *intends* to report (but doesn't, to
ensure smoothness and monotonicity).

Some consumers of time would be very much better off with the "correct"
time, not the sanitized version =E2=80=94 especially in a tickless kernel,
where the sanitized version can diverge *far* further from the ideal.

I believe we should be able to enable PPS on tickless kernel, if we
just give it a way to know the *true* time =E2=80=94 which is basically as
simple as reporting the existing known ntp_error (plus... details).

This RFC patch adds an 'ntp_error' field to the system_time_snapshot
and a snapshot_ntp_error() helper function to calculate it.

There's a temporary ptp_vmclock debug hack that prints the offset and
applies it to the returned timestamp, for validating the field against
the host vmclock reference under QEMU.

Without this patch, my vmclock reference test reports errors of =C2=B115ns
on a tickless kernel. With the patch, those errors are corrected and
the results are clamped back to the =C2=B11ns that I see with a periodic
tick.

Open question: *how* should this be exposed? It's all very well putting
it into ktime_get_snapshot_id() like this, and we could easily make an
argument that pps_get_ts() should just add it unconditionally, because
*not* doing so makes no sense.

But what about PTP? Should we just start 'correcting' the clock values
we report in ptp_read_system_p{ost,re}ts() too? It's strictly an ABI
change?

And what about userspace which wants to discipline the kernel's
timekeeping? Surely NTP d=C3=A6mons running on a tickless kernel want *this=
*
time rather than the approximation that CLOCK_REALTIME will give them?

Could we add it to adjtimex? Do we want to make a new clockid e.g.
CLOCK_REALTIME_PRECISE for it (we'd need it for each of the AUX clocks
too...).

I can't see a perfect answer. I'm inclined to use it unconditionally in
PPS, and probably in PTP too?

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.8
---
 drivers/ptp/ptp_vmclock.c           |  2 +
 include/linux/timekeeper_internal.h |  6 +++
 include/linux/timekeeping.h         | 10 +++++
 kernel/time/timekeeping.c           | 67 ++++++++++++++++++++++++++++-
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index c09ae06d7f68..37a9c8390055 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -140,7 +140,9 @@ static int vmclock_get_crosststamp(struct vmclock_state=
 *st,
 			ptp_read_system_prets(sts);
 			if (sts->pre_sts.cs_id =3D=3D st->cs_id) {
 				cycle =3D sts->pre_sts.cycles;
+				sts->pre_sts.systime +=3D sts->pre_sts.ntp_error;
 				sts->post_sts =3D sts->pre_sts;
+				pr_info("vmclock pre error %lld\n", sts->pre_sts.ntp_error);
 			} else if (sts->pre_sts.hw_csid =3D=3D st->cs_id &&
 				   sts->pre_sts.hw_cycles) {
 				cycle =3D sts->pre_sts.hw_cycles;
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
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 984a866d293b..6df32d5ead2d 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -283,6 +283,15 @@ static inline bool ktime_get_aux_ts64(clockid_t id, st=
ruct timespec64 *kt) { ret
  *			which @cycles was derived
  * @systime:		The system time of the selected CLOCK ID
  * @monoraw:		Monotonic raw system time
+ * @ntp_error:		Signed nanosecond offset of @systime from the ideal
+ *			NTP-disciplined time at @cycles. Extrapolated to @cycles
+ *			(so it is exact even when many cycles have elapsed since the
+ *			last timekeeping update, e.g. on a NO_HZ kernel) and includes
+ *			the sub-nanosecond fraction dropped when @systime was
+ *			truncated to whole ns. A consumer lands on the ideal line by
+ *			adding @ntp_error directly to @systime. Zero for
+ *			CLOCK_MONOTONIC_RAW; valid for all NTP-disciplined clock ids
+ *			(CLOCK_REALTIME/MONOTONIC/BOOTTIME and the AUX clocks).
  * @cs_id:		Clocksource ID
  * @hw_csid:		Clocksource ID of the underlying hardware counter for derive=
d
  *			clocksources which implement the read_snapshot() callback.
@@ -295,6 +304,7 @@ struct system_time_snapshot {
 	u64			hw_cycles;
 	ktime_t			systime;
 	ktime_t			monoraw;
+	s64			ntp_error;
 	enum clocksource_ids	cs_id;
 	enum clocksource_ids	hw_csid;
 	unsigned int		clock_was_set_seq;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index de07ef65da32..a2cb588b5be8 100644
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
@@ -1226,6 +1227,54 @@ static inline u64 tk_clock_read_snapshot(const struc=
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
+static void snapshot_ntp_error(struct system_time_snapshot *snap,
+			       const struct timekeeper *tk, clockid_t clock_id,
+			       u64 now)
+{
+	u64 cycle_delta;
+	u32 nes;
+	s64 tmp, err;
+
+	if (clock_id =3D=3D CLOCK_MONOTONIC_RAW) {
+		snap->ntp_error =3D 0;
+		return;
+	}
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
+	snap->ntp_error =3D (err + (1LL << (NTP_SCALE_SHIFT - 1))) >> NTP_SCALE_S=
HIFT;
+}
=20
 /**
  * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
@@ -1300,6 +1349,8 @@ void ktime_get_snapshot_id(clockid_t clock_id, struct=
 system_time_snapshot *syst
=20
 		nsec_sys =3D timekeeping_cycles_to_ns(&tk->tkr_mono, now);
 		nsec_raw =3D timekeeping_cycles_to_ns(&tk->tkr_raw, now);
+
+		snapshot_ntp_error(systime_snapshot, tk, clock_id, now);
 	} while (read_seqcount_retry(&tkd->seq, seq));
=20
 	systime_snapshot->cycles =3D now;
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


--=-6ImTasvTsIePIk3mFeGC
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYyMTIyMzA0
MFowLwYJKoZIhvcNAQkEMSIEIMQIItxn76EXHwcrypx/ZzgD/4nN4FUZXHW2H7F6NKOrMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAsaaGhEl3vZR3
cy119J2j44VqhP0zPZsKnjGcEmb2F2ZTP+tjb+RTDZkWASZqXpVPul16iHdnjr1wibin5F+6qnBP
VYe7y778DWUPpvH7BjtxBpncjE4QuHtdyoioftZzRSgJF4DJvnO5L+t3DyRX5Djxz0e2eR/gng2D
QZspOEwwOCnK3/siaFTVipkunhXNm/DuQIHLkc6qrKkgPLqr75sqIme2xPf6KU5ZrGTIihzPdA8d
sCE/lLtNBhpee3yuC51EV//eCHaGpP1HK/SLYTbtYIZMYCFkKZD9tQBtMoMtKSg8V6/JXLIaZGcx
sjN3Q+DCKu9e8U6rhYGYVyjRWIRSz++VwJ9fqPZ0SGeYLoHSNJm3gnOwAesNeT1P2kiFgi81c82z
5g27+sAwIaYNCjEgCzVxX8RN4s+TF1GByXRhwtKyaI0GlUeIwhoe9DEihghZwT7VfdUivrJbC9HO
tokkhV0f1GgFEFUCBPuGUtdj7FbLHzsA0rQwOURMRKmF75OUGRnq4iG+S+gH7GvihYfxD8rubktf
2DWMkq1K0UvsfnIEn6yY7Q3VNJxEfvkbj1kJ8posJO/E7mFC03pEgVg6f5tvBU5HP9lvZdbRYXkD
nPxFqP6M4BVYomqquhLAgHpJmF4Clw/C5poigR0ZOXYqK37G9Bb+aFhP4uoXOEUAAAAAAAA=


--=-6ImTasvTsIePIk3mFeGC--

