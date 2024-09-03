Return-Path: <netdev+bounces-124343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E300B96910D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50638B225A4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 01:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783741581F8;
	Tue,  3 Sep 2024 01:47:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E181A4E8D
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725328026; cv=none; b=cpYXxNe+n1Wn0KqqviqDTzTHcMbj+k8/Zyl7QzLFoVifAXRrXspCmkgrtzxX/yDKeNXL8f/wujNXhTPgtwOkGzIKUdAuQHTIagQtgHJo4tAZeR++uOYOZp3b9IUE+r5+3SdwCqyn3V3GmHkbtbIP0cKviLIH/GXww6D/2tRgpVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725328026; c=relaxed/simple;
	bh=V9bTy+WdYbqYnhYznwZp4ooow7LmO6s8wCMsRTrHecA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=SunOWF8Wss66pv3BHgZ2AJbaCOCeY+s6sksSoJs6545xAcARBYBugpwb7A6qDMpP34C2mzfUMV+GB7XiGXpbVov4g8smXzX0pUEr17+kSYdfaD6ZMQs4MP9xtmEig0OLQ+ufkjRQX9ceFJDvhuGNNHBmFw9GsV+u9Yi98vlaJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from owl-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 5D6AE7D08A;
	Tue,  3 Sep 2024 01:37:03 +0000 (UTC)
References: <20240824022054.3788149-1-chopps@chopps.org>
 <ZtAmxA_xflBWGlYO@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Florian Westphal
 <fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
 <horms@kernel.org>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 00/16] Add IP-TFS mode to xfrm
Date: Mon, 02 Sep 2024 20:10:26 -0400
In-reply-to: <ZtAmxA_xflBWGlYO@Antony2201.local>
Message-ID: <m2le09ikle.fsf@owl-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Antony Antony via Devel <devel@linux-ipsec.org> writes:

> Hi Chris,
>
> On Fri, Aug 23, 2024 at 10:20:38PM -0400, Christian Hopps wrote:
>> * Summary of Changes:
>>
>> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
>> (AggFrag encapsulation) has been standardized in RFC9347.
>>
>>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt
>>
>> This feature supports demand driven (i.e., non-constant send rate)
>> IP-TFS to take advantage of the AGGFRAG ESP payload encapsulation. This
>> payload type supports aggregation and fragmentation of the inner IP
>> packet stream which in turn yields higher small-packet bandwidth as well
>> as reducing MTU/PMTU issues. Congestion control is unimplementated as
>> the send rate is demand driven rather than constant.
>>
>> In order to allow loading this fucntionality as a module a set of
>> callbacks xfrm_mode_cbs has been added to xfrm as well.
>>
>> Patchset Structure:
>> -------------------
>
> I ran few tests. The basic tests passed. I noticed packet loss with ping -f
> especilly on IPv6.
>
> ping6 -f  -n -q -c 50 2001:db8:1:2::23

[ ... ]

> Occessionally, once every, 3-4 tries, I noticed packet loss and kernel
> splat.
>
> $ping6 -f -n -q -c 100 -I  2001:db8:1:2::23
> PING 2001:db8:1:2::23(2001:db8:1:2::23) from 2001:db8:1:2::45 : 56 data bytes
>
> --- 2001:db8:1:2::23 ping statistics ---
> 100 packets transmitted, 38 received, 62% packet loss, time 17843ms
> rtt min/avg/max/mdev = 7.639/8.652/36.772/4.642 ms, pipe 2, ipg/ewma
> 180.229/11.165 ms
>
> Without iptfs, in tunnel mode, I  have never see the kernel splat or packet losss.
>
> Have you tried ping6 -f? and possibly with "dont-frag"?

I will run some IPv6 flood tests with dont-frag, and see if I can replicate this.

> The setup is a simple one, host-to-host tunnel,
> 2001:db8:1:2::23 to 2001:db8:1:2::45 wit policy /128
>
> root@west:/testing/pluto/ikev2-74-iptfs-02-ipv6$ip x p
> src 2001:db8:1:2::45/128 dst 2001:db8:1:2::23/128
> 	dir out priority 1703937 ptype main
> 	tmpl src 2001:db8:1:2::45 dst 2001:db8:1:2::23
> 		proto esp reqid 16393 mode iptfs
> src 2001:db8:1:2::23/128 dst 2001:db8:1:2::45/128
> 	dir fwd priority 1703937 ptype main
> 	tmpl src 2001:db8:1:2::23 dst 2001:db8:1:2::45
> 		proto esp reqid 16393 mode iptfs
> src 2001:db8:1:2::23/128 dst 2001:db8:1:2::45/128
> 	dir in priority 1703937 ptype main
> 	tmpl src 2001:db8:1:2::23 dst 2001:db8:1:2::45
> 		proto esp reqid 16393 mode iptfs
>
> src 2001:db8:1:2::45 dst 2001:db8:1:2::23
> 	proto esp spi 0x64b502a7 reqid 16393 mode iptfs
> 	flag af-unspec esn
> 	aead rfc4106(gcm(aes)) 0x4bf7846c1418b14213487da785fb4019cfa47396c8c1968fb3a38559e7e39709fa87dfd9 128
> 	lastused 2024-08-29 09:30:00
> 	anti-replay esn context:	 oseq-hi 0x0, oseq 0xa
> 	dir out
> 	iptfs-opts drop-time 0 reorder-window 0 init-delay 0 dont-frag
> src 2001:db8:1:2::23 dst 2001:db8:1:2::45
> 	proto esp spi 0xc5b34ddd reqid 16393 mode iptfs
> 	replay-window 0 flag af-unspec esn
> 	aead rfc4106(gcm(aes)) 0x9029a5ad6da74a19086946836152a6a5d1abbdd81b7a8b997785d23b271413e522da9a11 128
> 	lastused 2024-08-29 09:30:00
> 	anti-replay esn context:
> 	 seq-hi 0x0, seq 0xa
> 	 replay_window 128, bitmap-length 4
> 	 00000000 00000000 00000000 000003ff
> 	dir in
> 	iptfs-opts pkt-size 3 max-queue-size 3
>
> Did I misconfigure "reorder-window 0" even then it should not drop packets?

Is this a custom version? The output is suspicious. The reorder window is for handling the receipt of out-of-order tunnel packets, it's a `dir-in` attribute. The above output shows reorder-window under the `dir out` SA and is missing from the `dir in` SA. FWIW `drop-time` is also a receiving parameter, and `pkt-size` is a sending parameter, these both appear to be in the wrong spot.

Here's example output from the iptfs-dev project iproute2:

    src fc00:0:0:1::3 dst fc00:0:0:1::2
            proto esp spi 0x80000bbb reqid 11 mode iptfs
            replay-window 0 flag af-unspec
            aead rfc4106(gcm(aes)) 0x4a506a794f574265564551694d6537681a2b1a2b 128
            lastused 2024-09-03 01:35:57
            anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
            if_id 0x37
            dir in
            iptfs-opts drop-time 1000000 reorder-window 3
    src fc00:0:0:1::2 dst fc00:0:0:1::3
            proto esp spi 0x80000aaa reqid 10 mode iptfs
            replay-window 0 flag af-unspec
            aead rfc4106(gcm(aes)) 0x4a506a794f574265564551694d6537681a2b1a2b 128
            lastused 2024-09-03 01:35:57
            anti-replay context: seq 0x0, oseq 0x8, bitmap 0x00000000
            if_id 0x37
            dir out
            iptfs-opts init-delay 0 max-queue-size 10485760 pkt-size 0

Thanks,
Chris.


>
> -antony


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmbWaD0SHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAl4fIP/j2vUsGzN3hbwx/b/ZJvBzTY3mKp/5VL
kkj8kRZenyeF2FE+veIASyLfF+kfmrdcb55r0AS/ZiV78YfCPPcs3ynTJXNxBo18
/4DR0W2sD0xV7+Op1g/wDtpHjIhEapAOqqLnWFXkX2r9YmlUiVfyMedoAO+BE87Y
iP83iYKNrtZ2pF6/b/lte6kS3Xzd92k0NKEBv/Q5B93pDxLUDDgdYYbtimOonttL
fF6x7JKSN9HxH79VdeuQzjUipyKmWpFNjMuuF0rSW7EwjiHa2gtYlKMsba2LC686
RdD8rozaX3PNouIdVVxGElXEktPt59e61rR3FiRla/2V4O0RAR/Hu9EjpLTX1S3w
otXaRhqIpsFcssqY8D9qCtXrpFJoi4xAEg/yGqWoBiYbE5JisJWDPbEAT1l8UZCR
KXzRbMNB/VPQM2rvptDhf7745iZgbeD6P4w9q8IkYoU+dIqOkW0N4oha4ihCQ1kX
bxpNavkJwNJp22C0MnR5twZf96RBpKsylOM5JHJIKEuTGhqOfGEUbGvSrj77pajX
quprJWsh2kthPsNKj/efe+W9A/kNIdc1B6aZIvcVN+IFnD0XSWgGzESrlOfRMdIX
E0ziIHALzy4hagyCRYZk1ZSbPv/OP+NbfJcTGvtO4GxvEfCEeN6TfHxKP654wSMX
8SF6/fTeXnSE
=JhFr
-----END PGP SIGNATURE-----
--=-=-=--

