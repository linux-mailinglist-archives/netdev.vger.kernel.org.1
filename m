Return-Path: <netdev+bounces-177930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1236CA7318E
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D009C1898B5B
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E214F9F4;
	Thu, 27 Mar 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fTLvbnHU"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE91E86E
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076909; cv=none; b=WWrD7XKx/Qg6Uz9EK3nddWdutJKidOuaW0aXiq5ljFOrQQQyVL9sFHCsfsSEk9vQBdzo8r9Y0KKvqIKBxs7zAfKniHFbgK9QzTdrvXXGWw7U8xV09Cr4W6W9O8R6XXD2z+xGwziRgm+NpO0agkrCbNBiFZ3X/VyE6xZlU4WyEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076909; c=relaxed/simple;
	bh=GJLuGFUznugGGI0Jy42eG8sJW6oqOm8ZjSPwI3BNY4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVxBiTAFKJbKxI+8gkJGx6hGuNHBy5mKxL2ZnPC1T+EHTfXjjXkNji4k58EAcDO1jjnehbiyhhtEvd4gcXPxg4U5W10+s9wo5Nb1ojz+piznzaaQc3xbTjDnEpTsCohry/tXjoWDlwTPSKsGuSAi8CVwhQ0Xk9x7RoTdf0AYCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fTLvbnHU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GJLuGFUznugGGI0Jy42eG8sJW6oqOm8ZjSPwI3BNY4Q=; b=fTLvbnHUVuBs2uLA7oMVbf4y/A
	2HPB1lrZRPh92+AMPoHH3vTbT+l2eW2VINJ/UkLvz4u0sQey59/DgbBvOyeMF9bHRgPTdmahb6FNo
	8EPqqsFYGAUQS/MIkQ51YQFImTiw8iZTO62ehi6ZSJlmHjelVQzQ3obm5y1I2IXWgpriWm7y81+e0
	E0Wmtew8cyvrfnLEqnZOtYo+23PR+kTXD8pdV2WoNcV6aC4mYNfXQZ4MW8gC1aNRo8ydyzSxkYIFC
	ETVGI67z2KWGdv4oULBUpGjMMYHNHo+jPklrLl6d3CEC3vB8qHtxUuVpCxfFua5nFA2Zd3sWF+1Gu
	twUbTBsw==;
Received: from [172.31.31.145] (helo=u09cd745991455d.lumleys.internal)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txlvY-00000005yUW-3xqQ;
	Thu, 27 Mar 2025 12:01:41 +0000
Message-ID: <aa348a55d8a5574e6ceaede7d40f47e5fbcb9b6c.camel@infradead.org>
Subject: Re: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
From: David Woodhouse <dwmw2@infradead.org>
To: Leon Romanovsky <leon@kernel.org>, "Arinzon, David" <darinzon@amazon.com>
Cc: Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, "Machulsky, Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>, "Bshara, Saeed"
 <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
 <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
 <benh@amazon.com>,  "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan,
 Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Allen,
 Neil" <shayagr@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Date: Thu, 27 Mar 2025 12:01:40 +0000
In-Reply-To: <20250327111522.GA21758@unreal>
References: <20250304190504.3743-1-darinzon@amazon.com>
	 <20250304190504.3743-6-darinzon@amazon.com>
	 <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
	 <a4be818e2a984c899d978130d6707f1f@amazon.com>
	 <65d766e4a06bf85b9141452039f10a1d59545f76.camel@infradead.org>
	 <be15e049-c68a-46be-be1e-55be19710d6a@lunn.ch>
	 <20250305175243.GN1955273@unreal>
	 <db859110a34d440fb36c52a7ff99cb65@amazon.com>
	 <20250327111522.GA21758@unreal>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-l3ML5KgFy2SqzplZkz1+"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-l3ML5KgFy2SqzplZkz1+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-03-27 at 13:15 +0200, Leon Romanovsky wrote:
> On Wed, Mar 26, 2025 at 03:32:00PM +0000, Arinzon, David wrote:
> > > > > If you read the actual code in that patch, there's a hint though.
> > > > > Because the actual process in ena_phc_enable_set() does the follo=
wing:
> > > > >=20
> > > > > +=C2=A0=C2=A0 ena_destroy_device(adapter, false);
> > > > > +=C2=A0=C2=A0 rc =3D ena_restore_device(adapter);
> > > > >=20
> > > > > Is that actually tearing down the whole netdev and recreating it
> > > > > when the PHC enable is flipped?
> > > >=20
> > > > Well Jakub said it is a pure clock, not related to the netdev.
> >=20
> > The PHC device is a PTP clock integrated with the networking device und=
er the same PCI device.=C2=A0=20
> > As previously mentioned in this thread, enabling or disabling the
> > ENA PHC requires reconfiguring the ENA network device,=20
> > which involves tearing down and recreating the netdev.=20
> > This necessitates having a separate control knob.
>=20
> I appreciate the desire to keep everything in one place and provide
> custom, vendor specific sysfs files. However, there is standard way
> (auxbus??) to solve it without need to reinvent anything.

Using auxbus would allow the PHC driver to be loaded as a separate
module. But AIUI enabling the PHC involves reconfiguring the device and
thus bringing the network device down and back up. Which isn't ideal.
It *isn't* as separate as auxbus would make it look.

We don't want to unconditionally enable the PHC support in the device
even when it's not being used, because of the potential blast radius of
such a change if *every* guest starts enabling it even when they don't
need to use it.

--=-l3ML5KgFy2SqzplZkz1+
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMyNzEyMDE0
MFowLwYJKoZIhvcNAQkEMSIEIDDeRKNOaon8BcZPLUGwO9yF0WDXlQcXm4iSKH1vddwGMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAskZOl1LKlK3F
3FU6wnoItUWiTAG/xrKV/PHJlA9h/cuEjVZGFntC9Lf8BQyI22arFeAPzgNKdDbe9WIaxm0MmBDL
pszAS+f2bZ0Cs4icibozK7oOVS3blSzxRH3Y0eGJv/ydPqP6k9TlQwSjoh2iBIqwQgcIP//XzLGq
MUWEyV62NPvX3v0BX94ezwGuRKUzjJ+Ts7HKZ0aYA672cMOqDEmWBCph2ajJbiBY1EGBq+96Chcr
TXAAlI0uhxJj16eTMSVlDLA60/8qBWj3eJ6mAEPn482jZgltX6tomRw1pe25DKn7wm3XeHy77OLM
EN8G5lPoo/inTm2CXFuMYPNUFSwUnjmlqfECKIdz+iS3SZ+0/7YoEly1M0m+9X0WtEMAyHjTRDyP
+Ndvzck/FflfsGuDwGQ/0PPmUMPYrgiBFMCk4RoGibSjS41v90I1eU0xfsHxyTAg6sT5h6O72Og3
Mj1g78SF1LOVBt9dI03xqGO/JNx1UbrSDtvmTuMJdJG+QXvRDwk1PPYm48BttAYmiqw24cp69WYj
0T6KYscNKvQ1SvQkoV30u7b68VBCactCCksjVkvdd0eiVtsFbc5kgdN8ywugIALn2lo/nSbEAzNT
6d2E0RNI2PcXj+7pzDrb0uBoJkm6AjAZQFpLprsuv+BQ8kQo6fUau60LpomerQgAAAAAAAA=


--=-l3ML5KgFy2SqzplZkz1+--

