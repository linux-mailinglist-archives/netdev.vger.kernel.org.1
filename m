Return-Path: <netdev+bounces-248403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8284D082F9
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 687F9302AF82
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DA23590C6;
	Fri,  9 Jan 2026 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fvtvMDXk"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF75357A50;
	Fri,  9 Jan 2026 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950768; cv=none; b=OBeZcnpBz/PeKUIwNw+Ey4S4UNidYjpCzgyMcPfrt288MkUhueZ0hJkGvnOf6UMb5obgGHYyx+v5lRBlmjdAXUBXO2FHbR5j1eygUAfaMGjL69M4HJeBcNwBibTW3/iIesnWt3ouuy+5uOWZaHAJLnKVWaKlAWhKpAQ9/eY8ICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950768; c=relaxed/simple;
	bh=8jAejCTMBqRj/zTJElggrFjYxpaPRAiXv9AdmoVr1Yk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LKz0ChYcGaofSPJGUwrQHdk/8l99GvvFva9gH044QiryeBXMbLaB9PJaFnWj9drDcpbrYQ3dGB83+4Wpg0rP9Q8VsvW3kgF61Vad1MfvnpZyZqiRO4AyZkvFyToxrr89ApppueelUpcEb5qIDjnKpVlwg6UQ/J2mu5YSIPHUFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fvtvMDXk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8jAejCTMBqRj/zTJElggrFjYxpaPRAiXv9AdmoVr1Yk=; b=fvtvMDXk2JQLYyCP/k0OTso7mZ
	Zj2IKi40uVaXHzxNkHhLSwDKJvxMvPC82JwzTxNvNhD9eHT9fXDwiMsxrkvHix8tqdrO3p0Wi0dIR
	ajPulRACZykMJdbTaE9DUIBwZ+fDS5bcNiOVrsmpdz4doYrt/l6S3Quna202MEGhcfD7NR0JB/pCZ
	0k+SYLuaqx7MpvDoCHRfV8iWFDPNVGBu6kmvsTo4GD5bi2n6hHzscslQL9xUOKQb53rGdHgmSr3G7
	QkaEI0sX6Dwh0gET1zXFWgWq/ggpIq2PO8+MNhlWVrWfBElAlmy0GWzXQoQP1O8XmiVnAzuKBGMYX
	a/2Np23g==;
Received: from [15.248.2.252] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve8ki-0000000EtSm-0OWO;
	Fri, 09 Jan 2026 09:25:52 +0000
Message-ID: <de8952121036deb58c07be294a044b5ff5bc00f4.camel@infradead.org>
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
From: David Woodhouse <dwmw2@infradead.org>
To: Wen Gu <guwen@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Richard Cochran
 <richardcochran@gmail.com>, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 09 Jan 2026 10:25:51 +0100
In-Reply-To: <3e137dbb-4299-4adf-9e19-b78ce6cfe4c8@linux.alibaba.com>
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
	 <20251030121314.56729-2-guwen@linux.alibaba.com>
	 <20251031165820.70353b68@kernel.org>
	 <8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
	 <20251105162429.37127978@kernel.org>
	 <34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
	 <20251127083610.6b66a728@kernel.org>
	 <f2afb292-287e-4f2f-b131-50a1650bbb1d@linux.alibaba.com>
	 <20251128102437.7657f88f@kernel.org>
	 <9a75e3b2-4d1c-4911-81e4-cab988c24b77@linux.alibaba.com>
	 <c92b47cf-3da0-446d-8b8f-674830256143@linux.alibaba.com>
	 <20251213075028.2f570f23@kernel.org>
	 <fb01b35d-55a8-4313-ad14-b529b63c9e04@linux.alibaba.com>
	 <20251216135848.174e010f@kernel.org>
	 <957500e7-5753-488d-872d-4dbbdcac0bb2@linux.alibaba.com>
	 <20260102115136.239806fa@kernel.org>
	 <3e137dbb-4299-4adf-9e19-b78ce6cfe4c8@linux.alibaba.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-3TwAc/IFG4QDX7SXHUa/"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-3TwAc/IFG4QDX7SXHUa/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-01-04 at 14:11 +0800, Wen Gu wrote:
>=20
>=20
> On 2026/1/3 03:51, Jakub Kicinski wrote:
> > On Mon, 22 Dec 2025 15:18:19 +0800 Wen Gu wrote:
> > > The same applies to ptp_cipu, since it is already used and relies on
> > > exposing /dev/ptpX.
> >=20
> > IIUC you mean that the driver is already used downstream and abandoning
> > PTP will break the OOT users? This is a non-argument upstream.
> >=20
>=20
> I know.
>=20
> My point is that I hope ptp_cipu can use the PTP interface as these
> existing drivers, because many user programs and their ecosystems
> depend on the PTP interface, such as chrony, or other user programs
> based on `/dev/ptp*`. A new clock class device node will break this,
> requiring changes to all these user programs, otherwise they can't
> use the clock.
>=20
> > > Given the historical baggage, it seems better to keep using the
> > > existing ptp framework, but separate these pure phc drivers into a
> > > new subsystem with a dedicated directory (e.g. drivers/phc/) and a
> > > MAINTAINERS entry, moving them out of the netdev maintenance scope.
> > > This should also address the concern that these pure phc drivers are
> > > not a good fit to be maintained under the networking subsystem.
> >=20
> > I'd rather you left PTP completely alone with your funny read only
> > clocks. Please and thank you.
>=20
> What you call 'funny' read only clocks have existed as PTP clocks for
> a long time, and there are many examples, such as ptp_kvm, ptp_vmw
> and ptp_s390. It also exists outside the drivers/ptp directory, such
> as drivers/hv/hv_util.c[1]. And there are also recent examples, such
> as drivers/virtio/virtio_rtc_ptp.c[2]. Even the PTP interface definition
> does not require that the ability to set the time must be supported.
> So I think the clock itself, as well as the use of the PTP interface
> is reasonable and not funny.
>=20
> IIUC, the main block is that you don't want to maintain these pure
> phc clocks, as you mentioned in [3]. I agree with this as well. So I
> propose to group these pure phc drivers together (e.g. drivers/phc)
> and move them from the network maintenance domain to the clock maintenanc=
e
> domain.

I think that makes sense. These clocks can still be registered as PTP
clocks because that's one of the most sensible interfaces to userspace,
but the implementations can live elsewhere outside the networking
maintenance domain.

In a lot of cases we'd want to use them for RTC too, so that the
kernel's CLOCK_REALTIME can be initialised from them. And especially
for microvms I'd like to *synchronize* the kernel's clock from them
automatically too.



--=-3TwAc/IFG4QDX7SXHUa/
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDEwOTA5MjU1
MVowLwYJKoZIhvcNAQkEMSIEINrXxYJS9DYz+D/sacwSm2eHRkfXn3x9mWUDIOak7ePEMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIASAgP80A8XcbT
70Iy820/vGTHtagMUarUSTTFxSvlps8OupEuK5xKKkzRvsPR1aKqOKAe0vbBDv8t4zvhyx04Ol3t
Mu+YgH26rXOId9wsCD6jWTcbfyzHu72vFwwEgukq3VqzjD9jvhJAAKfuTVj8XB5vVByj+43/m7st
ew8+Uld/07ysrMfNugDHa8ZYeD+AKDoJyB1LUA/2627KMA6Jt0m6mGIdWPvOavo7tStFNKHp9Wy5
El386fX4OYn5PeGOROatlhHcCHHO0RB949aYOIfgNY3U37dwMPGVMkNVaR8xsfUnv17XowH+/L5Y
U7jbzTekSTDV8rzn56/PXG12pYgd38Cr9khZjE9bRJqqLF6zTWXLK12ZCNV2wgVD6hBs5yZQS2v9
o86E+VlHgh94BFs2eoboLrLJns76QPhca4wf73+tq6MOSVcdDNMmDXTf7f6v45Fl/6G4nwPdqV4+
Dg9TLHpLHJjmqYG7ZHvrzFVQX1QijYPIp5owMgSLizu77BzlqZvdHDwgV9VA9rZZs95vQWXJu02W
hU+IEwYvgOdTDSLKJByu6jQWYJAWNzIYV3Clx1EWAywGuweneEmR1htwlS0AZZqBKjQXSLWzHqm/
7DZEpPFwazz73fAE/DKlOcUXIcw6Tcs/cqGrSZhC36M6jSBY+wmbVH7ND/jXnBoAAAAAAAA=


--=-3TwAc/IFG4QDX7SXHUa/--

