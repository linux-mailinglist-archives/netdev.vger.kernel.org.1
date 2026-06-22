Return-Path: <netdev+bounces-301123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ksKFCdw0OWogogcAu9opvQ
	(envelope-from <netdev+bounces-301123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:13:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E346AFB6C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:12:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=csO9aqHb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301123-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301123-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B1713008D23
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01082DC78C;
	Mon, 22 Jun 2026 13:11:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2933B2FC6;
	Mon, 22 Jun 2026 13:11:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133916; cv=none; b=B93zkT8lvQJMaXmCzw+7C5dyGThwJpXSOisxHrr1oxFeOcQyuSTuH5iwBbeVuy+WAd37yC2oE6StPfTbt4uRuu6zoxLcnEppFOWhHdD43zhVwtAiFrxOqwNT6gsmqr+CiEhbRv/0tBjXlEsIMhiCqOrwPpdYyDLpmzmWDYKR08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133916; c=relaxed/simple;
	bh=RD6sgqMgiMmzxwOo8cHxKol1PLoXVJvIaS+OfhwVGFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVnZ57SQ1MNI6UTVeFEj+NTNlHVGll5apk6RGY4XST5KcPRgVPalHXzIc0L4xkCJbs72uhF3qdyALFQG4hvSNEN6prONYzELVonGNEH4QOnXV+dmYmBw4/e2ThSHt9X0UVBcfa9uTiS7Rru0cjEs905KYxrs57Z+6LQXokD+KqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=csO9aqHb; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2jkQcA3dVeev5SG2ZjfrQw+qF4h08JwP+IW4W9bGSuQ=; b=csO9aqHbvmNjFk93lhbKMdaelP
	CMUt/SxFP6xPyhAnrh/3cKI1hWePdq9DxFRKAcEkT1QMJlpUxfRkRaOPlIAa/7DEIyq39HGSTCOkM
	745wNlZj7G9r+qvBzlDgShxGCPvmbDkyb2Tler0uKNZRiKrK73dATTnQyiyQ292biYJU2NL5j60F6
	ickLGXgzIj6iuup5jMAU2fAZpTD1i7o0thXwaMzxgflNZweJ2FEq4eEeBAPKv1YrCYNW5eQYnJIPV
	16rK2Ju2qHRctI9YUuky/ashLMsLxpoSWNJKN9L+477Z46UuxwwuNFUuEtE8F+4YftxKj0G3aQNb2
	3obXtyDA==;
Received: from [2001:8b0:10b:5:9b49:795b:48f5:139a] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbeRL-00000004H83-2Z2X;
	Mon, 22 Jun 2026 13:11:52 +0000
Message-ID: <4f54eb6a2779868c81db7231f4cf803547a83d00.camel@infradead.org>
Subject: Re: [RFC v2] Enabling CONFIG_NTP_PPS for NOHZ by adding ntp_error
 to system_time_snapshot
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Richard Cochran	 <richardcochran@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>, Alexander Gordeev
	 <agordeev@linux.ibm.com>
Date: Mon, 22 Jun 2026 14:11:51 +0100
In-Reply-To: <fea6f61960132ffafc94a8b74adc37d8dd2f79be.camel@infradead.org>
References: <3b10d2e91b18f49d8a3e6226b08ac8cd9cb49aa6.camel@infradead.org>
	 <fea6f61960132ffafc94a8b74adc37d8dd2f79be.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-xvD0bpTEcR6+5xeHTw1N"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-301123-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid,infradead.org:url,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4E346AFB6C


--=-xvD0bpTEcR6+5xeHTw1N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-22 at 10:04 +0100, David Woodhouse wrote:
> Hm, I'm leaning towards adding it unconditionally in
> ktime_get_snapshot_id() and get_device_system_crosststamp(), and not
> adding the extra field to the system_time_snapshot at all...

That works.

https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Drefs/=
heads/pps

David Woodhouse (4):
      timekeeping: Apply extrapolated ntp_error to clock snapshots
      pps: Drop the !NO_HZ_COMMON dependency from NTP_PPS
      pps: Always use ktime_get_snapshot_id() for pps_get_ts()
      ptp: ptp_vmclock: Add simulated 1PPS support

Booted with NOHZ_FULL in QEMU with a test program as /init that sets
the clock coarsely from vmclock using clock_settime(), then binds the
simulated 1PPS signal to the kernel's hardpps support.

Then uses PTP_SYS_OFFSET_PRECISE() every second to see the difference
between the kernel's timekeeping, and the vmclock that it's supposed to
be converging to.

The only "problem" is that if there's occasionally a nanosecond of
jitter after ntpdata->pps_jitter has literally reached zero,
hardpps_update_phase() complains:
   [   33.917103] hardpps: PPSJITTER: jitter=3D1, limit=3D0

That's *probably* only an issue for the vmclock hack; even with
upcoming PTM-based PPS devices that literally latch the counter value
on the pulse, I don't think it'll literally get to *zero*.

When chronyd on the host adjusts the time, we see it propagate to the
guest and the guest's timekeeping quickly converge from +36ns to +0ns
again...

[    0.653414] Run /init as init process
PPS: coarse-set CLOCK_REALTIME from vmclock
[    1.655824] pps pps0: bound kernel consumer: edge=3D0x1
PPS: enabled, bound to hardpps, STA_PPSTIME|STA_PPSFREQ set
PRECISE: dev-sys(adj)=3D+5609ns OK
EXT[ 0] diff=3D+5608ns
EXT[ 1] diff=3D+5262ns
[    2.917076] hardpps: PPSJITTER: jitter=3D5173, limit=3D0
EXT[ 2] diff=3D+4914ns
EXT[ 3] diff=3D+1197ns
EXT[ 4] diff=3D-297ns
EXT[ 5] diff=3D-103ns
EXT[ 6] diff=3D+0ns
EXT[ 7] diff=3D+0ns
EXT[ 8] diff=3D-1ns
EXT[ 9] diff=3D+0ns
EXT[10] diff=3D+0ns
EXT[11] diff=3D+0ns
EXT[12] diff=3D+0ns
EXT[13] diff=3D+0ns
EXT[14] diff=3D+0ns
EXT[15] diff=3D+0ns
EXT[16] diff=3D+1ns
EXT[17] diff=3D+0ns
EXT[18] diff=3D+0ns
EXT[19] diff=3D-1ns
EXT[20] diff=3D-1ns
EXT[21] diff=3D+0ns
EXT[22] diff=3D+0ns
EXT[23] diff=3D-1ns
EXT[24] diff=3D-1ns
EXT[25] diff=3D-1ns
EXT[26] diff=3D+0ns
EXT[27] diff=3D+0ns
EXT[28] diff=3D+0ns
EXT[29] diff=3D+0ns
EXT[30] diff=3D+0ns
EXT[31] diff=3D+0ns
EXT[32] diff=3D+1ns
[   33.917103] hardpps: PPSJITTER: jitter=3D1, limit=3D0
EXT[33] diff=3D+1ns
[   34.917102] hardpps: PPSJITTER: jitter=3D1, limit=3D0
EXT[34] diff=3D+0ns
EXT[35] diff=3D+0ns
EXT[36] diff=3D+0ns
[   37.917105] hardpps: PPSJITTER: jitter=3D1, limit=3D0
EXT[37] diff=3D+0ns
[   38.917010] hardpps: PPSJITTER: jitter=3D1, limit=3D0
EXT[38] diff=3D-1ns
EXT[39] diff=3D+0ns
EXT[40] diff=3D+0ns
EXT[41] diff=3D-1ns
EXT[42] diff=3D-1ns
EXT[43] diff=3D+0ns
[   44.917107] hardpps: PPSJITTER: jitter=3D1, limit=3D0
EXT[44] diff=3D+0ns
[   45.917105] hardpps: PPSJITTER: jitter=3D1, limit=3D0
EXT[45] diff=3D-1ns
EXT[46] diff=3D+0ns
EXT[47] diff=3D-1ns
EXT[48] diff=3D+0ns
EXT[49] diff=3D-1ns
EXT[50] diff=3D-1ns
EXT[51] diff=3D+0ns
EXT[52] diff=3D-1ns
[   53.917104] hardpps: PPSJITTER: jitter=3D1, limit=3D0
EXT[53] diff=3D+0ns
[   54.917099] hardpps: PPSJITTER: jitter=3D1, limit=3D0
EXT[54] diff=3D+0ns
EXT[55] diff=3D+0ns
EXT[56] diff=3D+0ns
vmclock: host_cv=3D0x998433b116699 offset=3D0xfff667dd86c7d42d guest_cv=3D0=
x20c1d93ac6 tsc_khz=3D2400000
EXT[57] diff=3D+0ns
[   58.917101] hardpps: PPSJITTER: jitter=3D18, limit=3D0
EXT[58] diff=3D+36ns
EXT[59] diff=3D+26ns
EXT[60] diff=3D+41ns
EXT[61] diff=3D+44ns
EXT[62] diff=3D+26ns
EXT[63] diff=3D+40ns
EXT[64] diff=3D+31ns
EXT[65] diff=3D+33ns
EXT[66] diff=3D+17ns
EXT[67] diff=3D+21ns
EXT[68] diff=3D+23ns
EXT[69] diff=3D+14ns
EXT[70] diff=3D+10ns
EXT[71] diff=3D+21ns
EXT[72] diff=3D+23ns
EXT[73] diff=3D+24ns
EXT[74] diff=3D+14ns
EXT[75] diff=3D+21ns
EXT[76] diff=3D+23ns
EXT[77] diff=3D+14ns
EXT[78] diff=3D+20ns
EXT[79] diff=3D+23ns
EXT[80] diff=3D+24ns
EXT[81] diff=3D+14ns
EXT[82] diff=3D+2ns
EXT[83] diff=3D+0ns
EXT[84] diff=3D+0ns

--=-xvD0bpTEcR6+5xeHTw1N
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYyMjEzMTE1
MVowLwYJKoZIhvcNAQkEMSIEIA7eR2MTaR9QVonH3t1zc66hzgGS5RAtZ51C6xCy8jc5MGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIARjYjiiSCQC+E
XiF7QyoX2pbNB86NcStshVsqbwLKa+imChIaFIXhB4DNNYR8RWuqa142oVr3c2y1mdK6I3gn2QWB
UWncpDyNAI1mzrR8Kf5JxfJEfQstndJ88utcmWXJxIscWUtQu+RQgavPnk/6JzdbXYwQVsp1rOEX
xha+89AXiM0bKW7PnQgZ6k43sfBbGl28h21+13HLfpZ376FZmqeRXJTAkjsk7Pn99Q6zXcEvWMcC
F/HucOAmFBN8D0WrjRghZE4zUqiGxNYnDKyTg5m/EiXZhljDYM2yzngEsWlxsvteIggv5tQ7qXdh
z5qFVOVDx2EoUTQC4p/lku8NFsYDoIuRv5LIufIWfEil9SZJioryRNDWd7fWhIeME9xo9imPgEhG
pxcjS6JZSDwvWJHrE89rwgqZIDqg/RI2h6n1SSzgCbZOJKSHQ4fuZgjxx0X9qV/tUWCkzM9YtxEk
J2dHZGN0Y8fTvY+DGgO0YoHyBSTIXbF6xZQDkiO7v6G+5aySbQMMIyCLQSXJjqt1pCKIsom4MYLc
4nuTj1q9wIQtwr6+4DVQDGlS5vrj70cHqjsCd2LtrSTyE1JlWrVD/htY2dS20KTUCznzApUFe+L1
KtedyaroemZnPKplD6YtvzoqVl5YoxTNAX7nmq8Vuxb81LoFEI0WtsHjyup6ax4AAAAAAAA=


--=-xvD0bpTEcR6+5xeHTw1N--

