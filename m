Return-Path: <netdev+bounces-142083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834299BD65C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 20:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36ADB1F255C1
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B332139D1;
	Tue,  5 Nov 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=falix.de header.i=@falix.de header.b="Wius+2IG"
X-Original-To: netdev@vger.kernel.org
Received: from mail.falix.de (mail.falix.de [37.120.163.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2659213EC5
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.163.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836682; cv=none; b=nzxlID2o6X9JLe+HyrRqn+uayHizsI+e3vc96majIXr/ipyLCfHo0DJ/RkQz0M9ipZjs8QfBgKzrZ3bKg21sVeXmFHXG8M6XVDeAu4jskWhDi7CP4tAbkJgvWA1a0v1jKBQp7P8E48simC8Fz9K0YFZMsuR1TsvM5r8ZdCNv8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836682; c=relaxed/simple;
	bh=LrCmpnVRAvmG6JYexrhSRnMBzJNduej4sWTcjrRsdOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bbabv9TpsGdYxSc+N/ugLjx9ipjmwZLo/vhTSinX3gYgzHh+1FE80uKQA1oh/A7a0S2RsuyLqXRICoRz6RfM8N9zmUXNDhnJhcofAb9oAt3YhBoycgeXxXaO8hAPeozLHYKtbwbVUof5TLIVgOV4ApefKqRY9euzv4E63UwpJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=falix.de; spf=pass smtp.mailfrom=falix.de; dkim=pass (2048-bit key) header.d=falix.de header.i=@falix.de header.b=Wius+2IG; arc=none smtp.client-ip=37.120.163.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=falix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=falix.de
Received: from [192.168.221.20] (ppp-82-135-64-9.dynamic.mnet-online.de [82.135.64.9])
	by mail.falix.de (Postfix) with ESMTPSA id 0091E604BB;
	Tue, 05 Nov 2024 20:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=falix.de;
	s=trustedmail; t=1730836670;
	bh=LrCmpnVRAvmG6JYexrhSRnMBzJNduej4sWTcjrRsdOE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wius+2IGQfOyof5JacG89LFYpPEhp9DmmwAGKIexa/9+xls+7FDe1smA1GNS5A/ih
	 F1MUtvdRlHMY6GwO9W/ufX8dH0pds2G+WYht1NptnSz7Zi50UxpSlqQo80i27ul3lo
	 Ke53RCwOZPcyPXZghYbvoVrDfa6xn6F1nMDCyliKP7p6NATkGoG6tWvZUSCWm4aLfK
	 ImlhNH/J1hLcjFxEOLBASl4NjH3cOIcZtZyyshXAQank/Aqd7rgCX60dKrmaDttITo
	 9MbajsWfXtZVK9m505KW269LpP4E2Ap6Xum4t8/fcmvW5wTwPxP/Kx4rSIm1fyqHM3
	 O4Q6fUL3jiySg==
Message-ID: <c1eb782d2fedbb0dbd2b249fac19faadf6c36857.camel@falix.de>
Subject: Re: r8169: regression in connection speed with kernels 6.2+
 (interrupt coalescing)
From: Felix Braun <f.braun@falix.de>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
Date: Tue, 05 Nov 2024 20:57:49 +0100
In-Reply-To: <324136cf-80f5-4d3d-8583-85b603794187@gmail.com>
References: <ff6d9c69c2a09de5baf2f01f25e3faf487278dbb.camel@falix.de>
	 <c224bee7-7056-4c2a-a234-b8cb79900d40@gmail.com>
	 <a5bb19c7a363bef7e3a5f4abd69adb0c9fc666b5.camel@falix.de>
	 <324136cf-80f5-4d3d-8583-85b603794187@gmail.com>
Organization: Vectrix -- Legal Dept.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On 04.11.2024 14:57 +0100 Heiner Kallweit wrote:
> On 04.11.2024 13:47, Felix Braun wrote:
> > Nono, I mean 100MBytes/s ;-) My testcase is transferring a large file o=
ver
SMB and looking at the transfer speed as reported by KDE. (I'm attaching a =
full
dmsg of a boot of a 6.11.6 kernel with only irq_coalescing commented out
otherwise as released.)
> >
>=20
> This test case involves several layers. To rule out conflicts on higher
levels: =20
> Can you test with iperf to another machine in the same local network?

Measuring the performance with iperf3 I still see a difference in throughpu=
t by
a factor of 3:

WITH napi_defer_hard_irqs=3D0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
[  5] local 2001:a61:11c6:9501:982a:b19f:94fc:71d1 port 41716 connected to
2001:a61:11c6:9501:97a8:b80a:4317:435e port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   112 MBytes   941 Mbits/sec    0    315 KBytes
[  5]   1.00-2.00   sec   110 MBytes   927 Mbits/sec    0    340 KBytes
[  5]   2.00-3.00   sec   111 MBytes   930 Mbits/sec    0    372 KBytes
[  5]   3.00-4.00   sec   111 MBytes   930 Mbits/sec    0    372 KBytes
[  5]   4.00-5.00   sec   110 MBytes   926 Mbits/sec    0    372 KBytes
[  5]   5.00-6.00   sec   111 MBytes   929 Mbits/sec    0    372 KBytes
[  5]   6.00-7.00   sec   110 MBytes   924 Mbits/sec    0    372 KBytes
[  5]   7.00-8.00   sec   111 MBytes   932 Mbits/sec    0    372 KBytes
[  5]   8.00-9.00   sec   110 MBytes   924 Mbits/sec    0    372 KBytes
[  5]   9.00-10.00  sec   111 MBytes   928 Mbits/sec    0    372 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.08 GBytes   929 Mbits/sec    0             sende=
r
[  5]   0.00-10.00  sec  1.08 GBytes   928 Mbits/sec                  recei=
ver

WITH napi_defer_hard_irqs=3D1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Connecting to host leporello, port 5201
[  5] local 2001:a61:11c6:9501:982a:b19f:94fc:71d1 port 42338 connected to
2001:a61:11c6:9501:97a8:b80a:4317:435e port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  37.0 MBytes   310 Mbits/sec    0    806 KBytes
[  5]   1.00-2.00   sec  35.0 MBytes   294 Mbits/sec    0    806 KBytes
[  5]   2.00-3.00   sec  35.1 MBytes   294 Mbits/sec    0    806 KBytes
[  5]   3.00-4.00   sec  35.0 MBytes   294 Mbits/sec    0    806 KBytes
[  5]   4.00-5.00   sec  35.2 MBytes   296 Mbits/sec    0    806 KBytes
[  5]   5.00-6.00   sec  35.0 MBytes   294 Mbits/sec    0    806 KBytes
[  5]   6.00-7.00   sec  34.9 MBytes   293 Mbits/sec    0    806 KBytes
[  5]   7.00-8.00   sec  34.9 MBytes   293 Mbits/sec    0    806 KBytes
[  5]   8.00-9.00   sec  35.0 MBytes   294 Mbits/sec    0    806 KBytes
[  5]   9.00-10.00  sec  35.2 MBytes   295 Mbits/sec    0    806 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   352 MBytes   296 Mbits/sec    0             sende=
r
[  5]   0.00-10.02  sec   349 MBytes   292 Mbits/sec                  recei=
ver


> Would be worth a try to see how system behaves with ASPM enabled in the
kernel. =20
> Even though BIOS denies ASPM access for the kernel: =20
> "can't disable ASPM; OS doesn't have ASPM control"

I noticed that I disabled ASPM in the BIOS. So far I've not been able to fi=
nd a
BIOS setting that makes that warning go away.

If you think, that the current settings are the best default values for mos=
t
users, I'd defer your better knowledge of the hardware. At least I'm happy
because I can get my performance back by disabling IRQ coalescing on a vani=
lla
kernel.

Regards
Felix

