Return-Path: <netdev+bounces-47016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B97E7A12
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59AAAB20E75
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575F8CA44;
	Fri, 10 Nov 2023 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meinberg.de header.i=@meinberg.de header.b="D8Uzg4Kj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4485D269
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:24:34 +0000 (UTC)
Received: from server1a.meinberg.de (server1a.meinberg.de [176.9.44.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504D593FA
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:24:30 -0800 (PST)
Received: from seppmail.py.meinberg.de (unknown [193.158.22.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by server1a.meinberg.de (Postfix) with ESMTPSA id 4707271C01DA;
	Fri, 10 Nov 2023 09:24:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meinberg.de; s=d2021;
	t=1699604667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFUFpSiEbfsJnXRyoTudfmoeR35GSoVj+KdvMJ8AAu4=;
	b=D8Uzg4KjR4z83+5KadiORA02NzoKzXGa5aerNCZpRBZ9+6fykPPtAyFo6jgfNX0hSx7noi
	qcdVCxUpSw45uoONOKKfr2+bBE0W9hVHNZ0vDhzSCn0OJksoS8FP2L7cv+WmaziU2CJhHI
	cJU13+EJmn51RLXR+t7ai1IdJ0C93aIWa3kqM0R09PXSpVKzKlZbWyHTN/XO8UDhB1yNCX
	gga3f6GLjsowOn5VOK0Tj3iTpuhEv4ZOgMLXoIN4sNjZRRJ7/WZMLwZs15iANV385XzgBe
	/aJvOrHNCsowxstGRrgDfytPb2Y9b2O7jwtbCJLbzuj8WXKDFBRgbakj36SoYQ==
Received: from seppmail (localhost [127.0.0.1])
	by seppmail.py.meinberg.de (Postfix) with SMTP id 4SRX1661zwz36pt;
	Fri, 10 Nov 2023 09:24:26 +0100 (CET)
Received: from srv-kerioconnect.py.meinberg.de (srv-kerioconnect.py.meinberg.de [172.16.3.65])
	(using TLSv1.3 with cipher AEAD-AES256-GCM-SHA384 (256/256 bits)
	 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by seppmail.py.meinberg.de (Postfix) with ESMTPS;
	Fri, 10 Nov 2023 09:24:26 +0100 (CET)
X-Footer: bWVpbmJlcmcuZGU=
User-Agent: Microsoft-MacOutlook/16.78.23100802
Date: Fri, 10 Nov 2023 09:24:24 +0100
Subject: Re: PRP with VLAN support - or how to contribute to a Linux network
 driver
Message-ID: <9AAC668A-22F2-4A91-84C9-93F0186344CC@meinberg.de>
Thread-Topic: PRP with VLAN support - or how to contribute to a Linux network
	driver
References: <75E355CF-3621-40D7-A31C-BA829804DFA2@meinberg.de>
	<6ab3289a-2ede-41a3-8c57-b01df37bab7f@lunn.ch>
	<DB0904D7-4F30-4A61-A4CB-48C7BFF4390F@meinberg.de>
	<CAGL4nSN0ZLHjARRRvS8Df8gLQLUb0ddiSJ5UfjNte0oX83VTOg@mail.gmail.com>
In-Reply-To: <CAGL4nSN0ZLHjARRRvS8Df8gLQLUb0ddiSJ5UfjNte0oX83VTOg@mail.gmail.com>
Importance: Normal
X-Priority: 3
Thread-Index: AZ2x3tU+NGVjMGQzZTRiMzdiMzk0Mw==
From: Heiko Gerstung <heiko.gerstung@meinberg.de>
To: Kristian Myrland Overskeid <koverskeid@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
X-SM-outgoing: yes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg="sha-256"; boundary="----6155F50A606A41F2218C689D1D7393E3"

This is an S/MIME signed message

------6155F50A606A41F2218C689D1D7393E3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-version: 1.0



Am 09.11.23, 13:20 schrieb "Kristian Myrland Overskeid" <koverskeid@gmail.c=
om <mailto:koverskeid@gmail.com>>:


Hi Kristian,

> If you simply remove the line "dev->features |=3D
> NETIF_F_VLAN_CHALLENGED;" in hsr_device.c, the hsr-module is handling
> vlan frames without any further modifications. Unless you need to send
> vlan tagged supervision frames, I'm pretty sure the current
> implementation works just as fine with vlan as without.

thanks a lot for your respsonse - we tried removing the NETIF_F_VLAN_CHALLE=
NGED flag and it did not work for us. We could set up a VLAN interface on t=
op of the PRP interface, but traffic did not get through. I will retest thi=
s to make sure we did not overlook something.

> However, in my opinion, the discard-algorithm
> (hsr_register_frame_out() in hsr_framereg.c) is not made for switched
> networks. The problem with the current implementation is that it does
> not account for frames arriving in a different order than it was sent
> from a host. It simply checks if the sequence number of an arriving
> frame is higher than the previous one. If the network has some sort of
> priority, it must be expected that frames will arrive out of order
> when the network load is big enough for the switches to start
> prioritizing.
>
> My solution was to add a linked list to the node struct, one for each
> registered vlan id. It contains the vlan id, last sequence number and
> time. On reception of a vlan frame to the HSR_PT_MASTER, it retrieves
> the "node_seq_out" and "node_time_out" based on the vlan.

I agree that it would be necessary to handle frames arriving in a mixed up =
order.

> This works fine for me because all the prp nodes are connected to
> trunk ports and the switches are prioritizing frames based on the vlan
> tag.

> If a prp node is connected to an access port, but the network is using
> vlan priority, all sequence numbers and timestamps with the
> corresponding vlan id must be kept in a hashed list. The list must be
> regularly checked to remove elements before new frames with a wrapped
> around sequence number can arrive.

If I understand correctly, this would make the discard process more robust =
because in the access port scenario the frames can arrive in an even more m=
ixed up order or do you mean that the access port is removing the VLAN tag =
and sends the frames untagged to the node?

> ZHAW School of Engineering has made a prp program for both linux user
> and kernel space with such a discard algorithm. The program does not
> compile without some modifications, but the discard algorithm works
> fine. The program is open source and can be found at
> https://github.com/ZHAW-InES-Team/sw_stack_prp1 <https://github.com/ZHAW-=
InES-Team/sw_stack_prp1>.


I will reach out to ZHAW and check with them if they would be willing to im=
plement their more robust discard mechanism into the hsr module. The github=
 repo has a note saying it moved to github.zhaw.ch which I cannot access as=
 it requires credentials.=20

Thanks again,=20

=EF=BB=BFHeiko





tor. 9. nov. 2023 kl. 09:08 skrev Heiko Gerstung <heiko.gerstung@meinberg.d=
e <mailto:heiko.gerstung@meinberg.de>>:
>
> Am 08.11.23, 16:17 schrieb "Andrew Lunn" <andrew@lunn.ch <mailto:andrew@l=
unn.ch> <mailto:andrew@lunn.ch <mailto:andrew@lunn.ch>>>:
>
>
> >> I would like to discuss if it makes sense to remove the PRP
> >> functionality from the HSR driver (which is based on the bridge
> >> kernel module AFAICS) and instead implement PRP as a separate module
> >> (based on the Bonding driver, which would make more sense for PRP).
>
>
> > Seems like nobody replied. I don't know PRP or HSR, so i can only make
> > general remarks.
>
> Thank you for responding!
>
> > The general policy is that we don't rip something out and replace it
> > with new code. We try to improve what already exists to meet the
> > demands. This is partially because of backwards compatibility. There
> > could be users using the code as is. You cannot break that. Can you
> > step by step modify the current code to make use of bonding, and in
> > the process show you don't break the current use cases?
>
> Understood. I am not sure if we can change the hsr driver to gradually us=
e a more bonding-like approach for prp and I believe this might not be requ=
ired, as long as we can get VLAN support into it.
>
> > You also need to consider offloading to hardware. The bridge code has i=
nfrastructure
> > to offload. Does the bond driver? I've no idea about that.
>
> I do not know this either but would expect that the nature of bonding wou=
ld not require offloading support (I do not see a potential for efficiency/=
performance improvements here, unlike HSR or PRP).
>
> >> Hoping for advise what the next steps could be. Happy to discuss
> >> this off-list as it may not be of interest for most people.
>
> > You probably want to get together with others who are interested in
> > PRP and HSR. linutronix, ti, microchip, etc.
>
> Yes, would love to do that and my hope was that I would find them here. I=
 am not familiar with the "orphaned" status for a kernel module, but I woul=
d have expected that one of the mentioned parties interested in PRP/HSR wou=
ld have adopted the module.
>
> > Andrew
>
> Again, thanks a lot for your comments and remarks, very useful.
>
> Heiko
>
>
>





=

------6155F50A606A41F2218C689D1D7393E3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
oSqrfruFfGVmcKfpItvuuzL6q7GGP6tIgbir8yrdN8cuC/ar31WtVCAUOreJRG3n
6D+uiCEYjkdWlQDJ7GVuVkcUTa0uJtLUi2zK8zMt+fCbjreGJoHnC56LDHwFpzx6
+fCFkJyJZzl1EbFjsNQjLH3cHyt27QStuhHJB0kN4ygPLhEU0ray/3i4/lpTgCSs
C0i6TjIxUeyq/rtELAvX+X2rjdpsqwjd80E9j/VBQVzGzFHKDkQft2qAdlVpUeZM
/ReA+7NU7rBKHTOTBnm5YRGs5A5bs93gsSVct9TTzfR7ngFUK4KQoeHKQ43wQaQc
B8DWMxajRUaPhExp/ZNXndPlb8skDDEtA5jCADlEeSKBbeTq/AtkJm78yp4aA0Tt
f01N6RGydr2GfXu7VD9RkEfHi/j/TizyCDCMGcEsRzWevatTpCKunwwhGSm9npvP
hNyO0TVLIhCBG2LtwEvTK5AiSR8tIa6Rxd/x1kFUcg7eyjQQ9cmandVcFuTNJbHH
qHFGrPhThReJqyQaOBgyJHPpVa74gGMDb4Sw36CUtalT8Itq9VR55f9bnKJvIuH/
QCllbG+OSGkxPoEbO4tY+lsvO2t9ayTwvPKN5ZrmrHjL2IIrABcdeWoJLtZuds8w
+9tZAgMBAAGjggFnMIIBYzAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBQJDL8q
oh0EJAyy+UAKQcLPWnKqgDAfBgNVHSMEGDAWgBRbJXuWpGVRfrg588B4Zl7oOufw
7jAOBgNVHQ8BAf8EBAMCAQYwgf8GA1UdHwSB9zCB9DBHoEWgQ4ZBaHR0cDovL2Ny
bC5zd2lzc3NpZ24ubmV0LzVCMjU3Qjk2QTQ2NTUxN0VCODM5RjNDMDc4NjY1RUU4
M0FFN0YwRUUwgaiggaWggaKGgZ9sZGFwOi8vZGlyZWN0b3J5LnN3aXNzc2lnbi5u
ZXQvQ049NUIyNTdCOTZBNDY1NTE3RUI4MzlGM0MwNzg2NjVFRTgzQUU3RjBFRSUy
Q089U3dpc3NTaWduJTJDQz1DSD9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jh
c2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnQwDQYJKoZIhvcNAQEL
BQADggIBAAL46l3QisysCAM2VGb/CimG4VSDLDPox2yuEKlUgX8qLYgmraaoNCgP
GQapneIClQQyZEwLyvnjfcMTW+iXQI534+OCgYetAWAHw8XhIP23MJc+uhxxdItf
Taex/k58CXh6h1/xrKElEZfHLBGckOpyFj0CNam75SPYH1JAt9COXdojvDPpMv24
dZ9Dvj1XS4dh3u2WyHB8frcT4QlAuxkCBw9r3R/SzA5aEhjkwbGcvr4rER7lmsXg
oTWx5OGyYq7A6Gx8lof6YN4tiRwUQUA5onfvsBVbAT8ezuYUqZy+gp+xYhffIkO1
Mm+3BfwYytp6Q11ltSb+WkGhaXSX8UNRjdx/2VeEpx1R8oJtqw5806Pl4MmVBG3y
x5134qX4yMW5ZwZvbf3Gf26+xWrbBDbbMG9dvciZ/sRylsy5y3SLJKkTC3i1Bsr1
iyYWc5gdcZWd8/BS6WxVfgUiF9CJPGXtV4B3/NisvbNTjwd7WBN6sefJsPjjyaGR
4nTOymgbshvElmCUkNvlCLc+zIh9Z8BV/Chz3hw72s8PHLYI0jM++TySSKBacIge
EBeYenbdYEg+ckU+cGuM60h8WbVWBRIUCkZNAjYJ0WxzIVIn2GvE0nKnTH7bNs7T
Pctc4u4b3fk6/U0T/w7OUrYWcTOgl8Vf9oIYF7U6m5u2eKsb6/1aMIIHcjCCBVqg
AwIBAgIPRXOLMhlC+HUxekgG6wqVMA0GCSqGSIb3DQEBCwUAMFMxCzAJBgNVBAYT
AkNIMRUwEwYDVQQKEwxTd2lzc1NpZ24gQUcxLTArBgNVBAMTJFN3aXNzU2lnbiBS
U0EgU01JTUUgUm9vdCBDQSAyMDIxIC0gMTAeFw0yMTA4MDMxOTE2MjhaFw0zNjA3
MzAxOTE2MjhaMFwxCzAJBgNVBAYTAkNIMRUwEwYDVQQKEwxTd2lzc1NpZ24gQUcx
NjA0BgNVBAMTLVN3aXNzU2lnbiBSU0EgU01JTUUgTkNQIGV4dGVuZGVkIElDQSAy
MDIxIC0gMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAK1mlxAxJhlg
BGAMtBG6/Pgsc+zJkd8OTSALhaNK2f0/+ieNt0TnI7gkyJ0phAg6V8l3E+j0Faku
40/nj/lejhgsHyF8gvhhgV+P9JZu75PSlvUT4mPSIe8RlQzMrjun92kx7IXbhySl
gsQOM/SD/lbxKLnElbMEyeQfn09VHrRP4GwSuwzRIWxZleo/hb7Kd+cPIf8FNNPX
qXfd5MX4lT90WJ3UdTQFYdK01JBW3tVP4Ath9jtRldmqutgz5+4/7/u/usb3DcM7
BBxxM295hRybgfVACJKsYjLkJk0JAqMf0A5FBdIt/0k3rU+AxfQDATjFCqYDAzn0
2LzAGcJbcox9Odl0+aOwQhFPHp8Ry6I85nXQWHjX8ii0jTesFXTkTb5eRQuoTkpI
0BYE76Sct1O2GH1HkAIdg4soI4bjap7M3nyJRNmDit46hV71NbECqO14j33/DkUv
s/r6u9EF6qJh1DYcWW+Xyom+Yd4HPIqaKjztIltqHCEc7FvGmlkQqUvpzn2iYuCy
dPLbHatMqIu3F/MPEVljeIlz47zkwy0DCc+CIUdtrDajQDH8HoQAdewJmWKWUQgT
QGRKZRkc0eh3MKaoMvk/hTkcvjHd1sMnaM+aa3Gp7YoY6IFcItC3ORUqy8YGHe7H
eRS4+uIjmy+iU6T26YivkV24j8GiROMhAgMBAAGjggI4MIICNDAOBgNVHQ8BAf8E
BAMCAQYwNQYDVR0lBC4wLAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgME
BgorBgEEAYI3FAICMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFCtmGmME
GQOnGfw158O40TaPTppBMB8GA1UdIwQYMBaAFAkMvyqiHQQkDLL5QApBws9acqqA
MIH/BgNVHR8EgfcwgfQwR6BFoEOGQWh0dHA6Ly9jcmwuc3dpc3NzaWduLm5ldC8w
OTBDQkYyQUEyMUQwNDI0MENCMkY5NDAwQTQxQzJDRjVBNzJBQTgwMIGooIGloIGi
hoGfbGRhcDovL2RpcmVjdG9yeS5zd2lzc3NpZ24ubmV0L0NOPTA5MENCRjJBQTIx
RDA0MjQwQ0IyRjk0MDBBNDFDMkNGNUE3MkFBODAlMkNPPVN3aXNzU2lnbiUyQ0M9
Q0g/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNS
TERpc3RyaWJ1dGlvblBvaW50MB8GA1UdIAQYMBYwCgYIYIV0AVkCAQ0wCAYGBACP
egEBMHQGCCsGAQUFBwEBBGgwZjBkBggrBgEFBQcwAoZYaHR0cDovL3N3aXNzc2ln
bi5uZXQvY2dpLWJpbi9hdXRob3JpdHkvZG93bmxvYWQvMDkwQ0JGMkFBMjFEMDQy
NDBDQjJGOTQwMEE0MUMyQ0Y1QTcyQUE4MDANBgkqhkiG9w0BAQsFAAOCAgEAvFxg
4AvqZothV0hW7gudd8Vcu7lstjDrIKinahkT30x0mL1n00ASbhR7wbFVvpCZy9oj
Aj3VKdf9Nu++c4dYVrgspkWANg8lj8rZAUtxdl628dISURAXc1xKrvnKqSWvdmfT
IiAkWKi5I8RF14ktxHuHZk8+I8ndFU27iqKRvvehqiXpb1uIaZ/gY+laTfRJ48KO
/0iV+E2AJAd6UudNVXLOCMhHXhbZm3mDkxjzKX3qHTU68/TSt8TTCZSl+Ql/jXF9
T/4dZMm15ev20a4Xliki4J9PbxTZvpiVdPzcl5YYm+5lz6l/TevFjFAiUflYSRk8
zqhrVvRyTQDNj3x3SYbN2YAD1r5I7X3hu+Fxf+O9lCjABECS3ZI1b29vzWYm83vk
LY9xyqjMvIEtANwk+keHTW2qP76bShVz2eu7CJeHymMm0xnfZSIp46vXpmJuumth
/XKebCCxru+Unc2dn6tsPZ8/+WmC8DkGE9snIO30PVMKIAyPKFMOldt1NC2zTN1e
n39aMqzjc7ehKNsxc1raZku4audhwNbUnUL5CSDIsvZk0RGaLuYuji0nzVD8jXlx
bDOBBdi75pB8Sw9LNia88W2wX3SNQSZ6xE1WvNAhJ6eLpozm5zh1rPFw4hONonwm
kHTW/3EV53wUltrlizW88HtH2LzbGp+UpyHNcp8wgghcMIIGRKADAgECAhQVL+XE
YjWLu5PiKBQAQdinUZu7kTANBgkqhkiG9w0BAQsFADBcMQswCQYDVQQGEwJDSDEV
MBMGA1UEChMMU3dpc3NTaWduIEFHMTYwNAYDVQQDEy1Td2lzc1NpZ24gUlNBIFNN
SU1FIE5DUCBleHRlbmRlZCBJQ0EgMjAyMSAtIDEwHhcNMjIxMTI4MTAwMjIyWhcN
MjMxMTI4MTAwMjIyWjCBiTELMAkGA1UEBhMCREUxCzAJBgNVBAgTAk5JMSkwJwYD
VQQKDCBNZWluYmVyZyBGdW5rdWhyZW4gR21iSCAmIENvLktHLjEpMCcGCSqGSIb3
DQEJARYaaGVpa28uZ2Vyc3R1bmdAbWVpbmJlcmcuZGUxFzAVBgNVBAMTDkhlaWtv
IEdlcnN0dW5nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA0Mt9WUkJ
5VzhEJ9WvZOQNGtultgIbRbOPyPbdaiw+4zmtkWhBVWZDqqCwd4QuFhTXvrCgqse
pohLtPqW5RnrgmSs6vqEoFVBM/vaxnYrYuCOuj12JqgK+lH7NXtpw8CbS69XPXEx
oMe2V/0gAehUW3ngevkrJWY/iZ0ck/PAF7liYrww2DJvg7tYRvDtXlkdIonw5QZQ
bFrn+uLOmhBsTZg6u9Dbvcg/UYuuEAhfgpQQ6bDLDvFY+rGo071LDkEDoApqQO9l
w0ljRy6oafo7HTYTm5ahtydi2Qt7V1TulsxaBC5E80hfLn1Nw3RyhfLLYdWag9LI
rGbmnqKLEgzY9leOGfH7i/W92FkQd8WavxhNBqABa2NBpzz81gypP3f7uxIlqsHL
yqZud8SIKZdCjquFV7vbNnHHvKRPkXSccG/EaNvud7hCFVi3YM1q2WwZnSXPdBBS
t3aUgd6T9tOLUR1LEgkIr7Q2gMhpRtG/j7ki2005Lf6Tpt1W97EBJEL7adkxoMc2
febuc2zAQh6v+gQlw1Ie/q86eHjN9++qHPWxwvzjHok1OxOmFnyeM3uVmvIrNiLv
WuwCFZ14sr8G2ZIsAOCW857oTqH23uqtRhVgxl6u6i/Vqbt+YqEivnPNEEbUVtT3
YpiZpxNPMBYldRL8EjaCA57EZu79H+PXoaMCAwEAAaOCAuYwggLiMCUGA1UdEQQe
MByBGmhlaWtvLmdlcnN0dW5nQG1laW5iZXJnLmRlMA4GA1UdDwEB/wQEAwID+DA1
BgNVHSUELjAsBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwQGCisGAQQB
gjcUAgIwHQYDVR0OBBYEFBYFwRRVUSm02JRgOFnxcbriy1QKMB8GA1UdIwQYMBaA
FCtmGmMEGQOnGfw158O40TaPTppBMIH/BgNVHR8EgfcwgfQwR6BFoEOGQWh0dHA6
Ly9jcmwuc3dpc3NzaWduLm5ldC8yQjY2MUE2MzA0MTkwM0E3MTlGQzM1RTdDM0I4
RDEzNjhGNEU5QTQxMIGooIGloIGihoGfbGRhcDovL2RpcmVjdG9yeS5zd2lzc3Np
Z24ubmV0L0NOPTJCNjYxQTYzMDQxOTAzQTcxOUZDMzVFN0MzQjhEMTM2OEY0RTlB
NDElMkNPPVN3aXNzU2lnbiUyQ0M9Q0g/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MGcGA1UdIARg
MF4wUgYIYIV0AVkCAQ0wRjBEBggrBgEFBQcCARY4aHR0cHM6Ly9yZXBvc2l0b3J5
LnN3aXNzc2lnbi5jb20vU3dpc3NTaWduX0NQU19TTUlNRS5wZGYwCAYGBACPegEB
MIHGBggrBgEFBQcBAQSBuTCBtjBkBggrBgEFBQcwAoZYaHR0cDovL3N3aXNzc2ln
bi5uZXQvY2dpLWJpbi9hdXRob3JpdHkvZG93bmxvYWQvMkI2NjFBNjMwNDE5MDNB
NzE5RkMzNUU3QzNCOEQxMzY4RjRFOUE0MTBOBggrBgEFBQcwAYZCaHR0cDovL29j
c3Auc3dpc3NzaWduLm5ldC8yQjY2MUE2MzA0MTkwM0E3MTlGQzM1RTdDM0I4RDEz
NjhGNEU5QTQxMA0GCSqGSIb3DQEBCwUAA4ICAQBk4hY2HMpe0jUw9zE6V/OH3EiZ
6qVRSAamOA13nPdWhjI0S85fDEtH9T9Gzr54cBtZFsmwmPpa7jB51h6SXKdeLgdJ
6OHDe2MiMW5p2u6XgU53qSkB5LicLFCfKaBv+nHziPJk0EE8uA8Ia0GhHGy+Xl8W
M1oWr7P6gLi/zaqajGEnDbmYRXj/u0yzoa1r6XnFKmyD7ZfK8aBvT1EXAuD5T6Nm
Yqknzk4oguExuAmP+2xljBVC0VSB6ClOB+KW+TBlhqRE9mUUS2RwTrVmXF7cWl4G
vUCEpfbDP9PT8yI5WW0ngKXlOGR10kMaoxHNEondN79s3VT/pdh1FgX4RqoUluju
CEOUCnE8bz2242RfbgLP0/TnP8V/AIsyust5SL0JjVtk3/tQAFh+WM40KK1MJjqT
NjkpXSElZNBigmZr3xu4r5Q6J4M3rTIbx8MBKy3t8H+SfJngeeVd8qgFhg3al1EH
e/JfywzV7beUkuwo1bnR+jbKyXSpj9ywva92r52J/ExmaLoJE/+ufzkdDz5D/4ZY
yhpkfksy5VdnHirtVfs5WucoWVBzxSf2pNEhdQXVWD7oLVKiX5CyrZDmnaueXjQX
ciEGc8WNG6M0hwwENPOGZ2ZMjWR4j/J+qCuN9Kf129/2KHYd/6e58HxrqTwWWOio
c8K3oAvc9LKnRI1wBDGCA4QwggOAAgEBMHQwXDELMAkGA1UEBhMCQ0gxFTATBgNV
BAoTDFN3aXNzU2lnbiBBRzE2MDQGA1UEAxMtU3dpc3NTaWduIFJTQSBTTUlNRSBO
Q1AgZXh0ZW5kZWQgSUNBIDIwMjEgLSAxAhQVL+XEYjWLu5PiKBQAQdinUZu7kTAL
BglghkgBZQMEAgGggeQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjMxMTEwMDgyNDI2WjAvBgkqhkiG9w0BCQQxIgQgRXhadK0R4gTe
uBm0ihH1lcu0wqZlfa1TdT/D3b32GM8weQYJKoZIhvcNAQkPMWwwajALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggq
hkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwIC
ASgwDQYJKoZIhvcNAQEBBQAEggIAiQsP8kK76EaQES92bzMUQ3cesQEM5cuw5Twu
VcNyYOpvqRvG4EE0wrsJjWJIGrgkVv45+/faWWBdiDPqYdaM9S2xn2O/vNpsexUc
0b9xMI9MHdblXQVxjaKp/mbLofRFJkZCzMykLnGoXLu0Gz7e5vuHea/4M8zk7ivR
Do7qLO5+qFJZHbtfrVyFS5TCioQbfxKmgsTQTeKPmrOb4wJlWEJ5ycEpTC8Q1syS
gLx5fXHZLf7yuJ1/5J1GmDTAw2rLlK6KIqjgWZBSm/4C2Ig9YXcsxkS+uyDMrrl+
WhVLbYe2IFgi68/tSWSmdGX1P5Z6OPcWCLOusUBENrwYs7GYSAkE1AEakMqdsRIX
o43H8PZNQ6C/q7hazDAsvXGqdWj2gH+CCERkvgIxfr+LNjICXSp3WCrY9Yqt8wnO
mM4GOYDHADkAsX2hQNlreXMPTRhL1nRfvmIFmK8wzMJbo8ZMQEJckUgtszaYeCIL
YLyd3ACbi6JZoYWlPEtwHCDuhl2YMrbpNep82MNrIffsBtUTvy4GlahbJGukuaQw
AC9w/aKkKD5opkdQl8QEF0qNKtSFGZxdxYTyTAP8baybShwjbCWkCoXFif7HDPlU
NZxNEiSlWqXhFrOy+AEFfocXw72Pn6aRUFr58iZOT75zw1aolLZw5ZMtq0GM2rtp
F+OLFAo=

------6155F50A606A41F2218C689D1D7393E3--


