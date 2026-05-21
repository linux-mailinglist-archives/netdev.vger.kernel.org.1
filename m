Return-Path: <netdev+bounces-290461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKCzOCwTD2pzEwYAu9opvQ
	(envelope-from <netdev+bounces-290461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:14:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF9A5A6F65
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC99F3283401
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6903EF673;
	Thu, 21 May 2026 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qpLZp8DU"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC993EDE7E;
	Thu, 21 May 2026 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370893; cv=none; b=jcRU+8cMPUtLpX/KfDoV45swmUqbV43UBjPcoaPdzxj0iEIyeXOLijoSVuCxhTv339N1UMgjzCfleg8IPBTuvs2frfMMXiL3MZNoLfAX7i/9OTU9qHnFG2IOKbbGOfkRD9Hf5boQjt2zPneuQpaL1YnCSWzciPHJN5MDR/o6faI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370893; c=relaxed/simple;
	bh=Ivomev2fteu7ili1VrS4dLtj0Pj5kX0LCvSSMeNrt88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rfpcIaQLMOJYlL7+6ZvAY+6Yj+iVT5pkXURK3LUvit1frOFcR8JsUu/SxAVq5FBDlm9XIJrHFUHfRJUsYqUawEqyHV5oSRWKtwdEYkiaqkeUkzwxzVqBFpbmbfQg8TNG0M3p0Xgh9THLaVTLN5SNgI7axeDSG2nVYNUNZ3AHH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qpLZp8DU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ik9emxM1CPUicb0wRR0R2dmYREC4CpMHp/KNKqe7Ssk=; b=qpLZp8DUp5nQuzMSvgWJchp/R5
	Q9m1FeTRlsmCTYUHzp7r8TyNK4MWE0sHy21RntzBBqUqTWiy7YZAEzQJCrqVEpmO7X3rEYLvBKyrh
	3f7NNBtlZycenFMRCMyYnAO/Ok4RR1GmiqYOT820pV0hWkZGvFLLHQMED6r6brrHX+C5EfICpy0Yq
	g0CaXPsxdAKU/OqpDJrV/CbT/qqWARXNqmiMoONEwtYZ3lqu30B8WsfEe7gXsIzPgFz7gO6K/ffU1
	RDv05Ze5jO4sh7mvZ8mwsB8t9fBznA+qlhf1QwjAq89Q572yKkL8bbAMr6OfIelKubjnseEI0vJvf
	3PehD+Eg==;
Received: from 54-240-197-239.amazon.com ([54.240.197.239] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3eR-00000008XjC-1Umv;
	Thu, 21 May 2026 13:41:27 +0000
Message-ID: <53809d76b3f402156240aba3633b110d88e6eb44.camel@infradead.org>
Subject: Re: [PATCH v3 net-next 1/7] ptp: Add ioctls for PHC timestamps with
 quality attributes
From: David Woodhouse <dwmw2@infradead.org>
To: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
 joshwash@google.com
Cc: Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, Yonatan
 Sarna <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, Alexander
 Matushevsky <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>,  Anthony Liguori <aliguori@amazon.com>, Nafea
 Bshara <nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>,  Netanel
 Belgazal <netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin
 Herrenschmidt <benh@amazon.com>,  Noam Dagan <ndagan@amazon.com>, David
 Arinzon <darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir
 Tabachnik <ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, 
 vadim.fedorenko@linux.dev
Date: Thu, 21 May 2026 14:41:25 +0100
In-Reply-To: <20260515164033.6403-2-akiyano@amazon.com>
References: <20260515164033.6403-1-akiyano@amazon.com>
	 <20260515164033.6403-2-akiyano@amazon.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-XcH8JhwhmOWmUw2kiNuW"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290461-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,linutronix.de,lunn.ch,linux.alibaba.com,amazon.com,vger.kernel.org,kernel.org,linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 4BF9A5A6F65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-XcH8JhwhmOWmUw2kiNuW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-05-15 at 16:40 +0000, Arthur Kiyanovski wrote:
> Introduce two new ioctls that extend existing PTP timestamp interfaces
> with clock quality information:
>=20
> - PTP_SYS_OFFSET_EXTENDED_ATTRS: Extends PTP_SYS_OFFSET_EXTENDED
> - PTP_SYS_OFFSET_PRECISE_ATTRS: Extends PTP_SYS_OFFSET_PRECISE
>=20
> These ioctls provide quality attributes alongside timestamps:
>=20
> 1. error_bound: Maximum deviation from true time (nanoseconds), based
> =C2=A0=C2=A0 on device's internal clock state
> 2. clock_status: Synchronization state (unknown, initializing,
> =C2=A0=C2=A0 synchronized, free-running, unreliable)
> 3. timescale: Time reference (TAI, UTC, etc.)
> 4. counter_value: Raw hardware counter (e.g. TSC ticks) at the time of
> =C2=A0=C2=A0 the PHC reading, for feed-forward calibration use cases
> 5. counter_id: Identifies the hardware counter type (enum ptp_counter_id)
>=20
> This supports three use cases:
>=20
> 1. Managed PHC devices (e.g., ENA, vmclock) that maintain their own
> =C2=A0=C2=A0 synchronization and can report quality metrics directly to u=
serspace
> =C2=A0=C2=A0 without requiring ptp4l
>=20
> 2. Applications that need complete time quality information in a single
> =C2=A0=C2=A0 call, regardless of how the PHC is synchronized
>=20
> 3. VMMs that need raw hardware counter values paired
> =C2=A0=C2=A0 with PTP timestamps for feed-forward clock calibration, avoi=
ding the
> =C2=A0=C2=A0 feedback loop inherent in NTP-style synchronization
>=20
> Timescale definitions use a Continuity/Discipline framework to describe
> timeline properties and steering behavior consistently across all
> entries.
>=20
> This implementation is based on the RFC discussion linked below.
>=20
> Link: https://lore.kernel.org/netdev/20250724115657.150-1-darinzon@amazon=
.com/
> Signed-off-by: Amit Bernstein <amitbern@amazon.com>
> Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>

I confess I kind of hate the way we add entirely new ioctls,
progressing from PTP_SYS_OFFSET to PTP_SYS_OFFSET_EXTENDED and now to
PTP_SYS_OFFSET_EXTENDED_ATTRS.

The historical change from PTP_SYS_OFFSET to PTP_SYS_OFFSET_EXTENDED
wasn't just changing rsv[0] to clockid; it *also* changed the
subsequent array of timestamps from interleaved ABABABA to a set of
3-tuples ABA ABA ABA.

That long predates me paying attention to PTP, and I guess it makes
sense, even if it might have been possible to overload the same ioctl
with some kind of flags field to ask for the new mode.

Even so, part of me wants to insist that you try *really* hard to shoe-
horn the new fields into the existing ptp_sys_offset_extended, turning
another of the rsv[] words into a flags field in which the user *asks*
for the error information, and/or the pure cycle counts, which would be
appended at the end of the existing structs without a whole new ioctl.

As things stand though, I settled for looking at least a few weeks into
the future and asking that you add both the error bounds *and* the
cycle counts at the same time, so that at least this new ioctl handles
the use cases I can see on the horizon.

So I'm OK with the new ioctls.


However...

+		extoffattrs->ts[i][0].pct.sec =3D sts.pre_ts.tv_sec;
+		extoffattrs->ts[i][0].pct.nsec =3D sts.pre_ts.tv_nsec;
+		extoffattrs->ts[i][1].pct.sec =3D ts.tv_sec;
+		extoffattrs->ts[i][1].pct.nsec =3D ts.tv_nsec;
+		extoffattrs->ts[i][1].att.error_bound =3D att.error_bound;
+		extoffattrs->ts[i][1].att.timescale =3D att.timescale;
+		extoffattrs->ts[i][1].att.status =3D att.status;
+		extoffattrs->ts[i][1].att.counter_id =3D att.counter_id;
+		extoffattrs->ts[i][1].att.counter_value =3D att.counter_value;
+		extoffattrs->ts[i][2].pct.sec =3D sts.post_ts.tv_sec;
+		extoffattrs->ts[i][2].pct.nsec =3D sts.post_ts.tv_nsec;

... that's nice for the cases I personally care about most where we
have a counter reading at the precise moment of the external clock
reading which is ts[1], but what about the cases (like the patches now
being posted for GVE if I understand correctly) where we still have to
have the sandwiched ABA readings. Don't we want the counter values for
those (ts[0] and ts[2]) too?

Other minor nits:

+	/**
+	 * International Atomic Time (TAI)
+	 * Epoch: 1958-01-01 00:00:00.
+	 * Continuity: Strictly monotonic and continuous; no leap seconds.
+	 * Discipline: Primary atomic reference; no phase jumps.
+	 */
+	PTP_TIMESCALE_TAI =3D 1,

The current TAI offset is 37. If I add 37 to a value with that 1958
epoch, I don't get a UTC value with the 1970 epoch you described for
UTC. It's cosmetic... but confusing.=20

+/*
+ * ptp_sys_offset_extended_attrs - data structure for IOCTL operation
+ *				   PTP_SYS_OFFSET_EXTENDED_ATTRS
+ *
+ * @n_samples:	Desired number of measurements.
+ * @clockid:	clockid of a clock-base used for pre/post timestamps.
+ * @rsv:	Reserved for future use.
+ * @ts:		Array of samples in the form [pre-TS, PHC, post-TS].
+ *		Each sample consists of timestamp in the form [sec, nsec],
+ *		while the PHC sample also includes clock attributes in the form
+ *		[error_bound, timescale, status].
+ *
+ * Starting from kernel 6.12 and onwards, the first word of the reserved-f=
ield
+ * is used for @clockid. That's backward compatible since previous kernel
+ * expect all three reserved words (@rsv[3]) to be 0 while the clockid (fi=
rst
+ * word in the new structure) for CLOCK_REALTIME is '0'.
+ */

I don't think we need the 'from kernel 6.12  and onwards' part for this one=
 :)


--=-XcH8JhwhmOWmUw2kiNuW
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMTEzNDEy
NVowLwYJKoZIhvcNAQkEMSIEIB6IEs2Y7TjdZiMuUkLeRbgiGNQusjzWTbCOaS2MR9TjMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAltqIVE5j4iNE
5SL9Rx1ZZ1ZKjCazpaBvKlENJDsvLlib/gmWvyvfixxM67NZElqg9A5ToRl9c+8PG7foujStk4Ff
gKey6S5zY8PtR0+2ylV1Q1B9yv/YBV9ohOgE8bAGeonTuYyLHohyT+ojhNKjhBf9o2ieynE+WPjL
hNQyfTXjvgvMk31M5n/4N2xY4rsjhWmNQICuPjx/ZkGufvXKOpUOlGCvaHG0k18xLridPn3gB3fH
6we8Hy21ohkIsf0qvbwZxTS/qok2/iMOZhdSb7Cv6/Bo6XBsQWyFGk882KuSBf4L0Xj7VcVR0Jcb
bUQ9ecrW6dtjkF29QKGW1jAn1xrp/gfVm2B5FNx0D0aeFSplDM2OdxT2rgl0fTAezAucNQvoz4Ft
05hYswmbiuKA8phC0knrvbKAm18D3//BaJoFclfGyvL/FJqoDcJRyiPaFgBpxnQW5BWlbj58bhfR
AZvKws+0boUNTiO63rV6MjW6hPbivbeewLZBvJ0pJG7eFWU1y+Pud/lNm+cY/cBw99VauCmtBJKm
YsVdvK+E09t2NhL2eeGe3JozwQO64FFQLf0GqNVWVWoLD8AiaTIGscw1GQ75Bxc8oT7QVIn1QbKq
xIHSBa0QO5JmNrqkNQpDMoXuiwk8SdKlqSRA8y/A4zClkAFC8pVi+mFpv9nNxNIAAAAAAAA=


--=-XcH8JhwhmOWmUw2kiNuW--

