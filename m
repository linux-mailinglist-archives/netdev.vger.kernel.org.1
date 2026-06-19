Return-Path: <netdev+bounces-300758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TB7BD1qtNWpr3AYAu9opvQ
	(envelope-from <netdev+bounces-300758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:58:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A0A6A7BCA
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:58:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=wI6tXNsB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300758-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300758-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B166A301A73F
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BF533F8CA;
	Fri, 19 Jun 2026 20:57:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41352C21C5;
	Fri, 19 Jun 2026 20:57:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902679; cv=none; b=TOLBOnS8kkMNEHvLKV33/7yT6FQhWIQBs2LNNy60RnDX4qX3YETiWeRkUxZnEvd93NFSlqxoSk2CkZUOfxT77a5xuQahFl1oilTNlITAFoc+ahyzr4kgQ4qb7hkgnn2o6Oj1Rc3q49FWRTb+TMYT2Y6+FHA0/WAcPkSn0NB+hBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902679; c=relaxed/simple;
	bh=zb/zwiu6U1Je/QI5KdWKTdnm/EawPEKRqNP1ppJPp2M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rgcX3ljPa65bPLYa9HdMwvqH4ku9+ZMQVIco0NDlAQWMUXV0/KOlIl2Itq8ZhCbr/RzDbcHcDzX5cJR2Q0GhEF/uakpzlaUSzVJR/75xiC4zw5B9DWUq6sFeZABcHjlkfh1T8GcwksVFMmvQcvl4vR6xZwW/Jyux/drlgdFirI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wI6tXNsB; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zb/zwiu6U1Je/QI5KdWKTdnm/EawPEKRqNP1ppJPp2M=; b=wI6tXNsBDI2gyGsoLzuiGamiRu
	K0EVY0oR8ZaHkuXBqzUe/tEBC6davvhLrt/+ykB9vQ0ZhLSn3jJ1k6/j7zpXKrgLDMhx44dN6ZMV+
	i0bWDnxz1yvUhl/ctuBuayW50KUQeQq4ueCCudc1fyDJxc5E2/6avEyIMN2/ZFEGI7xxVvApN3e7p
	UY2RSHxHUduhgZHYyHZAOf5liQ3gt+0y3Nyivz45M6lkDNSPr6p/v4C5bfKoMndn8L0MDRRuRn0sQ
	bOrCbC+KP9yuVuPcBhV+uHFiIO8VDIzkx0RttWnmCTTz1gmxupufaYWYqgmpxVdkAa0L6OmPs3Oct
	UprZnvrQ==;
Received: from [2001:8b0:10b:5:c1ae:7fe3:825c:da7d] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wagHe-0000000GpZJ-2opZ;
	Fri, 19 Jun 2026 20:57:51 +0000
Message-ID: <4f985ff0ffb3142d8b6dabf2be21a4667bb20494.camel@infradead.org>
Subject: Re: [RFC] Enabling CONFIG_NTP_PPS for NOHZ by adding ntp_error to
 system_time_snapshot
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Richard Cochran	 <richardcochran@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>, Alexander Gordeev
	 <agordeev@linux.ibm.com>
Date: Fri, 19 Jun 2026 21:57:50 +0100
In-Reply-To: <87v7beb7s3.ffs@fw13>
References: <3616fc9718614bf11915569599038a5bcb268c02.camel@infradead.org>
	 <87h5myd56x.ffs@fw13>
	 <02564e5f0b6be4aeb6198af87b46269963985768.camel@infradead.org>
	 <87v7beb7s3.ffs@fw13>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-RTNOOZVDWb2yyaly0Mk0"
User-Agent: Evolution 3.60.3 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-300758-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85A0A6A7BCA


--=-RTNOOZVDWb2yyaly0Mk0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-19 at 22:21 +0200, Thomas Gleixner wrote:
> On Fri, Jun 19 2026 at 16:34, David Woodhouse wrote:
> > On Fri, 2026-06-19 at 15:34 +0200, Thomas Gleixner wrote:
> > >=20
> > > This formatting makes my brain hurt. Can you please split that out in=
to
> > > a separate function?
> >=20
> > Yep. There's also a potential error there =E2=80=94 an *additional* dis=
crepancy
> > comes from the enforced monotonicity that timekeeping_cycles_to_ns()
> > applies (the case where it just returns tkr->xtime_nsec >> tkr_shift).
> >=20
> > I couldn't work out if I cared about the clocksource-is-non-monotonic
> > casse, and even if I did, what I should do about it.
>=20
> I think the right thing is just to ignore it.

Yeah, that was basically my conclusion; I had just meant to *mention*
it when posting the RFC.

> The problem is very narrow and mostly related to the historically badly
> synchronized TSC between sockets. The TSC_ADJUST fixup is obviously
> error prone as it adjusts only to the point where the error is not
> longer observable. But in the update transition phase it can result in
> time going backwards because the readout on the other CPU is slightly
> behind tk::tkr_mono::cycles_last. That happens only once in a while and
> we talk about a very low single digit number of TSC cycles.
>=20
> > I also wasn't sure if this should be a new CLOCK_REALTIME_NONMONOTONIC
> > or something like that, such that e.g. PTP clients could *ask* for it.
>=20
> Hell no!

That was not about the above clocksource nonsense; that was the
question of what the caller (in my example case, the vmclock PTP
snapshot) should *do* with the reported error value.

If I just unconditionally "correct" the CLOCK_REALTIME values then
that's arguably an ABI change. We're silently reporting something
*different* to what we did before.

Maybe that's OK... as I said, in the PPS case we can justify it and
just call it a bug fix?

Or maybe we want a way for callers (not of ktime_get_snapshot_id()
itself, but *their* callers) to *ask* for the "corrected" value
instead. I happened to call that CLOCK_REALTIME_NONMONOTONIC as a straw
man, just because monotonicity is *one* of the reasons why we present
the xtime values that we do, not always the raw "corrected" values.

--=-RTNOOZVDWb2yyaly0Mk0
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYxOTIwNTc1
MFowLwYJKoZIhvcNAQkEMSIEIKZUtVqng2gARXZqUs1enOhmsYNVGJFSTJHErSGO/oIwMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAsjiZGmBRNnKI
45A7s2qVh2+old/v4yrZHEicgpk20w5PtCX+WBH4xCLzHMBk/YSY02UICdl0vsEY7BgasgoOptBW
BqqKixaozSUlXvW+pqfPYFzLRg3BiC81RKrgRqV9dtjmue6mu7tWtKOl90LvEfZMvKzJaZE2h1qq
kJlnwQ6lhhZXjVDzkmThJs+09P0uB8vP8Kprdzmn8wAKY+YxEzW1AD2TYhhva+StECB76V41RsF0
xAzcBwcv4Rh15V6ykF3Xl7MW49rmaGJHux1VH5zUX8y5Gjpuf5zfpK7OGjWxWiwuYajkq3UTnqDO
YcYdNQLhS+FC4ZLNXK+nBiQV1+UJds9rePdZjl9O67kE45QuIyTtnunxsMs8VPoO9H/ncp3bKWVL
mbzFc3hYD7OqtW75xgbvj7uJSxhXoXUPzWVM9JbaqCDgz2zqpj980VSaIeYUt5hVVl/r3WxFvCn3
ZP1Sju2w+6JTEt8PqBtuscsoX7jZzc1jB0H4V1ehIQMy32BVcmyUzJD24cob7CY+kv+YL7tyH0Np
ZqgkuLKuJ9+MyTUsNyo418zpmOVlikSai+DtLix0HUlepoIz6TRYDC3uZu656TS8EilYw2sQJElF
Bhq3uQtF8vyv61pfWFsHNO/v/mD/MVt6Rt9Lg+CPUBP/MdGkLeGGEV00b3eje1oAAAAAAAA=


--=-RTNOOZVDWb2yyaly0Mk0--

