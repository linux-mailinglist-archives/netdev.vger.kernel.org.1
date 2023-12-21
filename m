Return-Path: <netdev+bounces-59383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23B81ABBF
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C668B260A0
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD3383;
	Thu, 21 Dec 2023 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="WWYf7v9U"
X-Original-To: netdev@vger.kernel.org
Received: from sonic322-20.consmr.mail.gq1.yahoo.com (sonic322-20.consmr.mail.gq1.yahoo.com [98.137.70.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1B441C
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1703118412; bh=oBl2s/++1sBZSlPoFhFM3yuWyXx+uTTOd2vyZIGz66g=; h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=WWYf7v9Umw+qKcIKnL2vxvFHE4e92s+rDi/1t8VTViusIVRxFscqBo+EWPfj+ZBYh/mToea7K79RoXfBs+gcHC9WgWpbYtaeIbRqTsaHMkRVeISqpDbaU1KJVmEB2coRuhmrWOfW6ytYOkKr60LfQhlHk9GnOTR2GacSap6+EDm1sWE1Y7XppKAJFFCp/lZqasfAP/QS7WSwkjh4R5T62WSFOw85pCuIyVAbxFOZSHOduOW7N0eYTunC1VgXay0b/ncwBuVabGeaBZvcdtT4WgzyunyPH9qMoIJ0TOK/9lXCHkTPwndi1VKkCTlFA9JEm6pgPYgOsos7595Z6/sd3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703118412; bh=XUx+WF2LwBJNhmbWbW/XiC4q5ndxfXXzdxeL+eZ66kU=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=t6LsqelNC1KKznwnUcX7TG6Woe5DoEoJRe2PuDfEKMwPofsaW6RmF17NbqrAZNC1KQR1k06m4H19qRdEX8sS4i3ZveT8ca26nGVl7cBrrX5hbpwGUYyY4AltwKLs7tL5vPRjvbn8I8s3fUnKg6tySKUARMX8O65R8H7w2Ptr71tt8Fevo+8WTypU4TQKhPSvhxEgr+OcsFnSPk3ZZlNRl/fsvLVy9AprjRseW5fjLrqNvGvwa181chIb9iXf4mgbxhzYy01ggClNa1gMqFZwm7ZwKKpbgOxyDfg2itUWZpmuAqPJ6pFg87Y6VC7AHDOy6gRQIyMp97Hlms3djnCIjg==
X-YMail-OSG: KM.oscoVM1n5CkmaS4cOD.kSRL1jSQItw9emHnFqtmsY392_32fV8cxm35t.gO5
 rxuXYvU4NS3JzTNWvRe1S7dxkH9qiVNG0Y3C7joWBLCsr4czwajn2PVB3NSr04S8tFTqFWvYkA8X
 NTRpeHeGJuevh4.DEBq.GOM1uUqBZ34B7OrPg4e2i4oW4AMtI5SuSPnsMjNZzgam5PmQw_7Zgdtx
 pRWFFx18fDMv4dss3slP9feBktWjucUWcL4mvG4UjW1TZzfDFHwmzcPYIk7jRH7h9t6nrJnf0I0S
 AL9RbCR1o6K6xULIzH8QMO.rEgVgNDTiEVVXE1uRdonruiLLZlUl4kBFSo4yBIVQ8GWNcrO1iIxu
 Gy1o8bq4Al2dUS2SYVck.iG9WqTFw1Wuv01N3PuGECX8C4aWEgM0uU1bBVK0aa7c_f_vmTPnr5Pm
 gLhpkOvnEzFni77MuaL74paBjNsjwD4BUApvIAG2Dn3dyEfrgilRps6DDBPt7d4D4dcceKyxtpsM
 IleGK4cs5b3g.pEUfH897zMxQR2lI7NpDCmd7zYKbmgRhIKYmemNxMt2aeQC6t45H16wj9MRIlgI
 T0H7CRS3grWf1KilCoLsh.8NXtJu_En8Bs__cqBWHazFPKv3OKbMAORCLfAWqSDVbhnpPWNvhjnn
 yCuvQuJ7Vtj1xU1GNM4.dtZ5KRIIoOn0CoFkFhqepzxoGYyLYPScUeuqS7kdQUFMJffEsfWQa5h7
 go7rVUIX4W3zZ4ybRvx1ClXhXmFe6RCne7hh5nlahK4bCWEQmZxrxuwEfesnPr.qxFlKWwkAJecF
 Smgt9OIi98wMwi4EI_QHZLIYPqnStamyTq3JKDkbvuO.IWGePAn8KQZ7eqad9zdHkun.QtriHntX
 QgqyiyyiRNfbI63T5ssn7k_h3_RhniRa0bLf1Ak_AgOHEi5EtjewfmJF1NgnVa1A_YzCppXp9_Tj
 GeCssR6zSFwUYuQj_AvhvSRMIiDLmV7ZTbBMRYMrxbVmMfbrjHNRbJbZ8k_HPCoWab7CZTQLbbbw
 sIq7PFCzasju3jV2XwfVmKmnCgi9VHhTNTjEOC5hP_.JsMVJ40dIwTLDraOCQelzTGc08p_0yn_i
 .fcT91bdcS4cyWlSRZzdPlIOH3uvjqTUlxjVDKZ5RZ4HirzZv5sZIzdwmBW8VWpZBve9s1Sv6VbP
 K7Fyo.L0Du.3nb9JUpQaSTtq12SjjqTILbq1GSlsH6D0_36KkHqhKCxtthRn5ctGEsmn.VyDBLq6
 i7iJrv9sdt18ytcc7eMgYPjWkEDYKfYs4TMwHmeCCnJthZoH2w9z5OwS7jH2lyoSeMVg8SbQW68o
 hqRk1jT4NAo2sb9qy.Z84hDFxIdI4ZPW3lGcDotl58KflW0gFc3_Mf3qMLIkG06HprpE2eLtITDk
 J89oyxlqzcOYIho7pW9OCosqtAah_07XCLOOnhgaYMFEsLwju6SWbc81XdQO9eB2XHC467GlD2z8
 zl9wnZ2Twci3SZFi0XPg6MF0R0cWRCT5HqIyqNgarj_UFTy31dKgTZAPW3wRJFZi3iZHN8k3CLg7
 2aSVNddFEwhQ6E8ZpZkan21R2byjTfEOm79iiMvJtYlDO7Zg6vq3RCEUIxmWTiI1uHNYKmr2RP3n
 pVCmpleqcwXaZlOmwYC4u4lon4ruMD2z6qh88F.Lrgb_vEM9OOGDbdsnNa39wdlDPv1jfGBiDF9k
 5o9z4baWEcgeZpMoUbLsuYhUuyGL0DwGbblELKY8t_UHZkGFW3uSZAazBHvoHs6JdtLev0sbimlB
 pkHrG0nyz._RqJZtqZEkLkwYek6.SYu3Phl7uq77YyTZuX2A6mNhLk8VzjgTwr1iZE50XOtccVTY
 jZVSxlYXhlP.WhU9NiqFxZHhM7qqr1wzLLZG74h0p5ed5n4xnCM21LqRJuGg1m0tkHS3DC6jvJ9X
 kfx8Y6RtxQz9NNkFcSNX1WHagzDV59MBlB3XleGoiIBB2.Lx9b8PDKGjFKKadSckH9B4xlzeBurD
 psGJMR6F27T8w9Qgx6OgLfeMpz44YaPQJ2_UgWxPJ3Z44LzhWuE_eo8Qxgg.EkkD93__SA2V6Mo_
 G2qExGHq3hiKqDQrWWlVtzo8Zr2jBzQ0QOi8BfXa9WDWngqgK2yIZBvbMqcI046OYPUPXtTrlwB2
 3faJDdWp4N8nlH75yriwnpeMuy8ww6Ke6ZE2OysYxQBhyD03H62e._dwhYZGRklw1
X-Sonic-MF: <canghousehold@aol.com>
X-Sonic-ID: 9ef6971a-632d-4867-be1c-82907704d0a4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.gq1.yahoo.com with HTTP; Thu, 21 Dec 2023 00:26:52 +0000
Date: Thu, 21 Dec 2023 00:26:46 +0000 (UTC)
From: Household Cang <canghousehold@aol.com>
To: "davem@davemloft.net" <davem@davemloft.net>, 
	"rk.code@outlook.com" <rk.code@outlook.com>, 
	"sashal@kernel.org" <sashal@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, 
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, 
	"joabreu@synopsys.com" <joabreu@synopsys.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <779092239.3209937.1703118406743@mail.yahoo.com>
In-Reply-To: <1969249613.3172645.1703107503559@mail.yahoo.com>
References: <2069419566.3127127.1703101273945.ref@mail.yahoo.com> <2069419566.3127127.1703101273945@mail.yahoo.com> <4108ff0c-7f5e-444c-90e3-1ec339d043a6@intel.com> <1969249613.3172645.1703107503559@mail.yahoo.com>
Subject: Re: RK3658 DSA Port to MT7531 TCP Checksum Offload Issue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.21952 AolMailNorrin

Sorry, did not realize someone prefers to use plaintext email. Will resend =
in plaintext.


On Wednesday, December 20, 2023 at 04:25:03 PM EST, Household Cang <canghou=
sehold@aol.com> wrote:=20


Thanks.
I will add the appropriate maintainers to the list.

Btw, during my investigation, the issue is very reminiscent of=C2=A0https:/=
/www.intel.com/content/www/us/en/download/19174/disabling-tcp-ipv6-checksum=
-offload-capability-with-intel-1-10-gbe-controllers.html, with Nokia ONT us=
ed by Verizon. It seems the ONT was appending bits at the end of the packet=
 it processes to cause a checksum mismatch. I have yet to confirm with Veri=
zon engineering.

-----
For my issue, to undo the stmmac patches, then re-compile is a very tedious=
 feat, especially it is a kernel jump from 6.1.1 to 6.6.0.
I have yet to conclude whether it is due to the stmmac driver or the MT7531=
 driver.

I read MT7531's datasheet and it appears the chip does not handle TCP check=
sum offloading.
So it may more likely point to stmmac is unable to handle something extra a=
ppended by MT7531 during the passage from DSA ports to the CPU port.

For the stmmac maintainers, could they point me to any specific patches tha=
t change the behavior of TCP checksum offloading, in the past year/9 months=
 or so?

Thanks.
Lucas.




 On Wednesday, December 20, 2023 at 04:00:50 PM EST, Jacob Keller <jacob.e.=
keller@intel.com> wrote:


On 12/20/2023 11:41 AM, Household Cang wrote:
> Dear all,
> I applied Linux kernel 6.6.0 (yesterday) from 6.1.1 (snapshot from Octobe=
r of 2022), and suddenly the RK3568 is not reachable via SSH.An investigati=
on shows the issue is restricted to=C2=A0stmmac-0:00 (SoC GMAC0, eth1), con=
nected to DSA switch MT7531, and on TCP connections only. TCP connection ca=
ptured in wireshark shows all retransmissions.
> Running ethtool -K eth1 (GMAC0 to MT7531 CPU port) rx off tx off fixes th=
e TCP connection issue.t> Issue is not exhibited on eth0 directly exposed t=
o RTL8211F PHY without passing through the DSA switch. TCP checksum offload=
ing remains ON on eth0.eth0 and eth1 using stmmac. eth1 using mt7530-mdio t=
o drive 4 DSA ports (lan0-3).

> Whether this issue is due to changes in the stmmac driver or the mt7530-m=
dio driver, or a combination of both?Is MT7531BE capable of handling TCP ch=
ecksum offloading?For GMAC1 (eth0), the GMAC seems to handle the tcp-checks=
um offloading.For GMAC0 (eth1), I don't know whether MT7531 is capable of h=
andling tcp-checksum as well?
> OR, could it be the something changed in stmmac driver that fails to acco=
unt that frames coming from the DSA switch will bear extra tags?
> Thanks.Lucas.
> Excuse me if this is not the correct forum, but please do point me to the=
 correct one...

Sounds like you might want to report this the stmmac folks, which
according to MAINTAINERS would be:

STMMAC ETHERNET DRIVER
M:=C2=A0 =C2=A0 =C2=A0 Alexandre Torgue <alexandre.torgue@foss.st.com>
M:=C2=A0 =C2=A0 =C2=A0 Jose Abreu <joabreu@synopsys.com>
L:=C2=A0 =C2=A0 =C2=A0 netdev@vger.kernel.org
S:=C2=A0 =C2=A0 =C2=A0 Supported
W:=C2=A0 =C2=A0 =C2=A0 http://www.stlinux.com
F:=C2=A0 =C2=A0 =C2=A0 Documentation/networking/device_drivers/ethernet/stm=
icro/
F:=C2=A0 =C2=A0 =C2=A0 drivers/net/ethernet/stmicro/stmmac/


If you have some experience building the kernel you could also try git
bisect to see if you could identify when it stopped working.

Hope this helps.


Thanks,

Jake




