Return-Path: <netdev+bounces-289660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pf1Dxf2DGolqgUAu9opvQ
	(envelope-from <netdev+bounces-289660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:45:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 824B758617B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC47F30688D0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D32A26056C;
	Tue, 19 May 2026 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kB60je+F"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13983233946;
	Tue, 19 May 2026 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234322; cv=none; b=XQO1GVbrSs6N0Io2ZYxzFg7QTnCpAs21ujnXH2FWWtGHw65D2MX8/9g0aqP2OhdGS0lsNfSjW+3CuVlVbmZ7GMoa1W167PgruzgKP972v2xe6GQKDZpo2z6dZI5NbohPNtNFn2E3VYfDT03JIUB0tIsyzSIyTpy1v+jMt80k78I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234322; c=relaxed/simple;
	bh=pejzsyelfw4YPmJszrxyLUpGLAXPmm1twYLbN3j1v4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wkqow3anm7XWHUZJj5bs572VvNjFD20OaU2OtD4BLZG12KuIkOs6wmnEClbgrPTh3d/TEgazj5+cPyEb1t0yyK3CBjOfYmryJzi9YA2MW3GZ9y22u7hLs0rKPQOKqDE/UFD0yLQD6peUz21KVy/T5Hn+l6wLCst1GI6db/6ieWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kB60je+F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pejzsyelfw4YPmJszrxyLUpGLAXPmm1twYLbN3j1v4g=; b=kB60je+Fm1WhYuRCacOBBa6WQT
	oMyjmcqBjgNw264WgCRELj9GSftet0fXmnnN3wAqI4YU1mK7bt3pdGM6wN8s6+57ERETaoTBEOLFN
	UG5zasTD/KcYUKjM58V/fcWR8q4qXIrvk8K2JV51F07TO41IfEkhyQKKM6HYN9x4wVRP5QHzlUFkx
	t/CaOdjM0iRwVjMuL/h+nMoPxWY/+jAPGWR0ZxfRh8Xxp3CYfbRI3+t1LKKhJy6JSfgZ6FuVe6I/p
	GhKQcA56mw2X6+hNaar/2LOtKfl9RRtAmY1UzvrEhisT4M5cCxPLEr9rHdGzFkJvPN2OqtiEthSX2
	gRM+ku6A==;
Received: from 54-240-197-233.amazon.com ([54.240.197.233] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPU7a-00000006TDK-2aR6;
	Tue, 19 May 2026 23:45:11 +0000
Message-ID: <3685358a639c27a0f0b0ccfe2969c0cfa34cc392.camel@infradead.org>
Subject: Re: [PATCH v3 net-next 0/7] ptp: Add PHC timestamp quality
 attributes
From: David Woodhouse <dwmw2@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>, Arthur Kiyanovski
 <akiyano@amazon.com>,  Harshitha Ramamurthy <hramamurthy@google.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, Yonatan
 Sarna <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>,  Alexander
 Matushevsky <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>,  Anthony Liguori <aliguori@amazon.com>, Nafea
 Bshara <nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>,  Netanel
 Belgazal <netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin
 Herrenschmidt <benh@amazon.com>,  Noam Dagan <ndagan@amazon.com>, David
 Arinzon <darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir
 Tabachnik <ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, 
 vadim.fedorenko@linux.dev
Date: Wed, 20 May 2026 00:45:09 +0100
In-Reply-To: <20260519163351.61b746d0@kernel.org>
References: <20260515164033.6403-1-akiyano@amazon.com>
	 <20260518182646.2d1337d4@kernel.org>
	 <177921463623.22936.15326822041328476600.b4-reply@b4>
	 <20260519163351.61b746d0@kernel.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-NBv116Y22KIvgWZJhCJD"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289660-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,gmail.com,google.com,redhat.com,linutronix.de,lunn.ch,linux.alibaba.com,amazon.com,kernel.org,linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 824B758617B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-NBv116Y22KIvgWZJhCJD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-19 at 16:33 -0700, Jakub Kicinski wrote:
> On Tue, 19 May 2026 18:17:16 +0000 Arthur Kiyanovski wrote:
> > On 2026-05-18 18:26:46-07:00, Jakub Kicinski wrote:
> > > On Fri, 15 May 2026 16:40:20 +0000 Arthur Kiyanovski wrote:
> > > =C2=A0=20
> > > > This series adds quality attributes to PTP Hardware Clock (PHC)
> > > > timestamps, allowing userspace to obtain error bound, clock status,
> > > > timescale, and raw counter values alongside timestamps in a single
> > > > call.=C2=A0=20
> > >=20
> > > How does this proposal relate to:
> > >=20
> > > https://lore.kernel.org/all/20260517220326.4625-9-dwmw2@infradead.org=
/
> > >=20
> > > ?=C2=A0=20
> > The two series are independent and complementary. This patchset adds a
> > generic PTP subsystem interface for reporting quality attributes (error
> > bounds, clock status) alongside PHC timestamps =E2=80=94 it's a userspa=
ce-facing
> > API extension. The RFC is about kernel-internal feed-forward clock
> > discipline, letting the timekeeping subsystem lock directly to a vmcloc=
k
> > reference.
> >=20
> > Both touch ptp_vmclock.c but in different code paths: this series adds =
a
> > gettimexattrs64 callback for PTP chardev ioctls, the RFC adds
> > timekeeping_set_reference() for kernel-internal clock steering. No
> > functional dependency or overlap.
>=20
> I suspect David will agree, but it'd nonetheless be good to see his
> review tag on these patches.

Yeah, I'm generally happy (I'd done a round of review internally, but
it's considered bad form to include my Reviewed-by: unless I give it
publicly on the list).

My series is basically orthogonal, as Arthur says. What I do want to
check, though, is the intersection between this one and
https://lore.kernel.org/all/20260511231812.1801984-1-hramamurthy@google.com=
/
which also appears to be giving the sandwiched timestamps as raw cycle
counts =E2=80=94 which is what I'd asked Arthur to expose to userspace.



--=-NBv116Y22KIvgWZJhCJD
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxOTIzNDUw
OVowLwYJKoZIhvcNAQkEMSIEIDPsKiqbWzEngV28hbHjZ1Wttp1KtZB0rCUCwowltPBDMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAIOyJ6uc1HmAy
vTAef0/UZQyk/+Gc3M6gcoV3SHuTwptx4kkrIjy3yjOqYV/FY2ZGLvnXucZkGmYThV9Xptg1bMfI
Xm5KrpzgExVWkmXnCAJfJtRgjDtKKIRHCjuFv+VB0f61FCS+BiuTfKWgAzG5Irktmcb0eAOzLatQ
pWnTEmx69rOnPWTwFpqs8GKiMocXIpafJbj9+ZlbKEv76UfTHBmdUrjQPduoKad4oK8I/YuwZj24
BsHZ9DpjzWn1582dNqXWbkNjohDG5EWeXc+F6wThpGy+u2M4iJu4zo5Hxcn8AHOhPYouwxMTX7sA
NCTs96rCi+FR7+7NoiMT121V7CDgKMHYGYmBziROKQ+mR4X92LPuDz/gUt+7568NDT8zTzkdqLuI
89uoUJuRMv7xDxFYb8VFmbbTkzN1Dp3/jgbto0a8q/Uf4aR7EbWGi8W1BudwgpZghGMi7j6KjzA5
g/XYgw/XLWurXwZQ0pvJDFZuMY3py5ehTf139WHJ/Ob9n2qMsbFyGNNkG9Q9Wfw19oJu6o3JC4Ux
8P6bRITHCmGxYVYUWzfoT3MX2AFev1Sz0VSbcTjGtxhtTrx1y/pa4marJaWuMx1kp9r1LQV6cXku
b/dbZWvVis8ogoXtqvroCqX1f0Bo0tfo6kc3h+oilGihiJ+9E8yFTLYijdOoMvEAAAAAAAA=


--=-NBv116Y22KIvgWZJhCJD--

