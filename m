Return-Path: <netdev+bounces-171401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA21AA4CD90
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 22:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DA616E680
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979B9230277;
	Mon,  3 Mar 2025 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b="T2ai1hFe"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0A1E9B3D
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037701; cv=none; b=UL4gKOP0FXEyYC73nZL2tkVb5kKJCX8jWNaj5YRxvy1di+ZXyuMtPy4CoC+i+9YIoECrF8X7CyMaVWcxzldWGnGcF0URCZIJNmfEKF5B/tLWvlZ/6zFm1qQgiztXphscsGlwQQQD/ROYhEAjj8cHkMNRGTFw1Bs5dBqSP1WIp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037701; c=relaxed/simple;
	bh=D3uMHcIXTF2m+r73NVEXtNnrCFnvMfodCOCP8z6Cyjw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GzCfalvqhj4XEt2gWl2uG4hJAJJHYIeAp/wbqSjltjnxucjbv3R1wNX9h7toAM9jowlM87iSJrYuYXBRxBP2gMt41ssEqKQIzEfpscmjJyLekpnpRy2y6yN02y8x6jRhDLPyyhGui+HBy94d81FqjVvAwJ0AtekPRZaszsZcxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b=T2ai1hFe; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1741037691; x=1741642491; i=max.schulze@online.de;
	bh=GkMUYHTATf4WJITOjs7tmaL/Hc96qlrL/WFX84yJLmk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T2ai1hFeJKsRxEiB/xOYYb/mdI8ER9ypnbeyhUawMl5ADvCrih1khZL1D4sGfziw
	 6+u4KoCwag1qIv6H+QCtsfsQvGxZElDqCyqA8PlZt5mipqOg99Oed+zBDzqZoWOmf
	 E3Ety+l0zhlexa/IoHthJhycwqe8+1nY7E2e1g6I5GH2vRaUbOGJlqP3zc7WUH38B
	 80+Ay7QLqlJuoeCd3uaPUwxFoRe/qswIKHI7XNZBLKcOuv/K1mdiiz4DOhH9h7B0D
	 DIq/m0c9VDGM37ACLbvuJgECK/uiwDJaOPRbvJRV7p/E0TSlR5QsxKkBYbIRbwT7c
	 Qlsa7WedVP9xbwEDEQ==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from [192.168.151.48] ([84.160.55.49]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCsLu-1ty33h3VFQ-00CfBO; Mon, 03 Mar 2025 22:29:37 +0100
Message-ID: <5f649558-b6a0-4562-b8e5-713cb8138d9a@online.de>
Date: Mon, 3 Mar 2025 22:29:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: fujita.tomonori@gmail.com, hfdevel@gmx.net, netdev@vger.kernel.org
From: Max Schulze <max.schulze@online.de>
Subject: tn40xx / qt2025: cannot load firmware, error -2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s3Xo4JCpzgAAeVIPmoKwtOaJg5REIdDP7UMAV1yHk8dWz05LjRx
 kRFHZs3ThL6r3U4v7uJgbyqmKOHEopRsAHTkz7u9lflKOx/YXf55EpO6ZTt/Xa4WDdXzDOf
 Wd6LLUyRPiholIdrxuZ3Xr3QHBFH8XSfmagIAh7GbiaxIMvvJCqvfLOMNo9IknSjYalF2yd
 X51nIT+EaRNAYHfNvYEKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S+koYXc3Q8o=;tzYqCGclzB5Z0RSj37CwuCpVPLZ
 AH7g1ZabGeuASj1mRolXVp892hwcJZLRyq12Gl6cd3ZQ6mDsMmjxJGBxbTrTzSUTa+Tm6BRy9
 IEJcwinms+JEGo6qwaXUWu7PhNPAIzPOiRrB3xGf0WkuZcZBTN4lTvB6dPvGs21a8C/RL8Vn0
 oYRsyuIjKNwF9NNXF3UngRZ+KwsfBeR8px/LZZ7ctabkRB9zrfzS/LrynKZS6ivL8rH/F9Ixw
 gDxY30w24uGeWIqu5W8BMvW0KwT+ZCA1HGunq9NFwGpXX1rQSHKNuY2vUBYtewzaugTQkzRR9
 iUR4QsJ/p1ENevmBD7t6XEQgcjjZch+4lQq4BgnydOmGTQMWBjS4KfSvR4BCwOAd6b8sr3/H5
 n6fERi9eHabR/nEYxqnzUWytawMcS8oDn1MtCVnFw4dq1AlC0h/T4RJDBriuAFW6lUlzJoBF3
 mprJJd8DmlL+350BBoZFD5wCvhT7QWVad87xqKp0KyPsjD8Ey48YIOSJqvEJuv7OxtutP61XS
 7hdxUnCBTy2rX1iUBCbDrAx4P3d1b9dbqB669lznBOhKaaeMN2MiWvj4QLqL3rYiAMBr5UqBo
 q4o1hPMEGzqee4RtquXbdll8gHyXW0RwjQQ04rdl0AoPxNq9djxwGQgbZZkpxL6IOJoh2LpYU
 2CL3EHOMIxCnc3cT5slcf+Flt08DRZwnMRM/vFWmxuYKTGKNDW5FTSx/LyXaFl8SdipkYC4Yp
 MkAtbXhGqk0ti4XFsBpRjvIbUmujzJoCbW+ncF+tUhcD8cdj1JypZvA6Gog9xx5ZSgdgJ3kfK
 ynyRngk1s3al485lyss+XhgNItvb9jHteyknaHYhxOpphAiRBETCeD6MK2TJRDyzh3FZspFoW
 QuxfkEIKcP05MZlb30tbMeymP+5YV5k08SU828TLkpbIEx9Sb0U++bR0+UJUAnzuwJdw/4GTJ
 XWAyXUWle0LtR+24mHh5GmPVl5PZlEdlQuaavhghXhQkrREwc2dJhX+V8bSGnVYIzNz49JVe3
 tXniBnQDsu9Yn6mIqV1KOEikX6m3j0YMnus8i4Lo3cdtkgWLBd1/ngyRtbWUSCydRPB8khW4B
 q7nn0uiFxER5qQC60+mIuUEIKk6mSoiavasEMvHxEPSKp4B4ZrH5czogQK9zw9Wuq2Ly92rHK
 eZKKkkce+wh8C3KFjBI37QF9ZARbNnvYIG5Dy7j1d0gFoMvRa8N5lEWt4b5a+W+RTm+XRVul9
 fuHBdXOduNECDS4SM2rNDlcDS/EsVL9fKO8CpdDzvzuR94YxKAnbAx3EEfy5stktIlPQ2mpSu
 qmu0GOUhzxXtk+RHRGVHaFn+Slxr6TnElWpDC8sIgVrObVO4JqpOfnbJ5InIOk7TflV

Hello,

I am needing help with this:

> [    4.344358] QT2025 10Gpbs SFP+ tn40xx-0-300:01: Direct firmware load =
for qt2025-2.0.3.3.fw failed with error -2
> [    4.345075] QT2025 10Gpbs SFP+ tn40xx-0-300:01: probe with driver QT2=
025 10Gpbs SFP+ failed with error -2


I have built a mainline kernel 6.13.2 with rust support and have this card=
:

> 03:00.0 Ethernet controller [0200]: Tehuti Networks Ltd. TN9310 10GbE SF=
P+ Ethernet Adapter [1fc9:4022]
> 	Subsystem: Edimax Computer Co. 10 Gigabit Ethernet SFP+ PCI Express Ada=
pter [1432:8103]


I have put the firmware here:

> $ sha256sum /lib/firmware/qt2025-2.0.3.3.fw
> 95594ca080743e9c8e8a46743d6e413dd452152100ca9a3cd817617e5ac7187b  /lib/f=
irmware/qt2025-2.0.3.3.fw



Is there anything else I can do?

What is error -2 ? Who generates it?

( NB: You could mention the hash for the .fw file somewhere in sourcecode,=
 until its in firmware.git (doesn't look like it ever will, huh? [1]), so =
others can verify they have the same file as the driver authors...)


Best,
Max


[1] https://lore.kernel.org/all/20240922102024.218191-1-fujita.tomonori@gm=
ail.com/

