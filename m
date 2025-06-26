Return-Path: <netdev+bounces-201503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C6AE994B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859B7189B6D6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890526B76D;
	Thu, 26 Jun 2025 08:58:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8825E448
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928325; cv=none; b=EVoN7nDw1IzTFEzFTt6J/DTT2RhJtq12GKe914zgUURN+e/CRWQYH1kilFNTzju5mnuz9oO57bQtvfANcfVYMsBclpWcpCi+PPXACWe8VZ0NUIqiEVeAtlPdugyEe9x5C4l/ijUGRodkPUIS/3Sup6sgtrgLtSS/iF8qwcGnW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928325; c=relaxed/simple;
	bh=owZAA/HjnAQ/3YG6vzn4GCsQkpRhZDYaR5HJkXE+S+I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PS7Y0gGkDi9/BiqWEHktfmo1Ol2tXirGPVleCjsaUrnFg/loaGorPif2FUy2Ql6PHleWxJ+THl1YrmD3blY4qTzANDTJHaFzYDaJ7oVUbhUETpazxbStzL11KbWoJ0hs0SX6GJN+fAkk2/NO1D7kSWzpinVZQTn4q02lPUAbs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz5t1750928276tc11ada7e
X-QQ-Originating-IP: so1L5+cHOi3A8/PwEJlEsUdgEAKUK1F1oZwmPNPmnKY=
Received: from smtpclient.apple ( [36.27.0.255])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 16:57:53 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12615979159928299772
EX-QQ-RecipientCnt: 10
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next v2 08/12] net: txgbevf: add phylink check flow
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <f8b268e5-3f0c-4eed-9f78-2ec2be1ebd0e@lunn.ch>
Date: Thu, 26 Jun 2025 16:57:40 +0800
Cc: netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 andrew+netdev@lunn.ch,
 duanqiangwen@net-swift.com,
 linglingzhang@trustnetic.com,
 jiawenwu@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC2C38E0-D25F-4FB3-B7AA-E7F973EA5B69@net-swift.com>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
 <20250625102058.19898-9-mengyuanlou@net-swift.com>
 <71d0b663-c717-45a5-ae23-f5b91d199eac@lunn.ch>
 <B649FE55-96A3-4631-8714-51128EDEE810@net-swift.com>
 <f8b268e5-3f0c-4eed-9f78-2ec2be1ebd0e@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N6hZ4SoP+w9xReiU9qgH9qZD0Ns/qiTO4IFpl+oNrVgoeQ0rJN/jKhih
	cV8mN28yKVAViDLb+0XB9bPJqzyZNvo29pCOQFtZ0BwXqSWlrq9HxxpG/IXbTVbhKks/jim
	dDZ/oPYFwsosf3UTDJOWN64IQChcu/TId6qT/kAvMVAzYinh0YDDVMCW9+af82Vt2ZYPZAg
	vDhlZY52yGat/2gClQPJhnQF15qBAGTqFII/EhfD1IzzfG+KR6HQhvnzGEg4GFZ/Guf1KtF
	f98Tp10rHoUn/l5M1oJf2qfS5eSnRY8HloHvj2eV2e4mHGA8px0IIk5QhTrn54r/HAkoZbA
	w/EPVjTfJqV+91/47lEE9Ld8joUrdHOcEa5ikH/2czGIRHSPbNdwsea1CR4IWg/2ETwOSxS
	RRTQn2q+wN2ZyGylvzCqDN8v6BWy7D1Jiadz6XU6Ofrr1AoPjrT1pyo/EG4Nv4BKVij6wsq
	uB7OW5briTi894pxscZOBj1NpZOxN7hmlHpnAu44DHVNWmEbrdftpfyeaQ46LwuFPGrTMxZ
	mkRgmMwMNn/f/5fg57AUVDNFDbMuVSoZGQv6B0H+xboniDQ5ETJRgXsybccHzKURa05PLqg
	ii9xOQ1gavFgSgjvRxKGE5eJfzOV5dgbOkPQ1izB0qLlKmFjecWDm8NeHkF0eHMHwESMe++
	SYkbjpzEB9NAeqJN08+26LkrrIIFYpI0wIXj6mD77KY6cCtgWGxW81n/mVj8wg8z8JkSW/w
	PSdGxYWMyKkjrqdj3zsAB9q8KSDAc66xX2wD1kVpP6wCEzP/HngTEiRUlsC1ThWoivBFAip
	uongyHsIVrMGi8rexLhqHXd84CpYjUHK5RgS3BFHRP7G/MJbJrGv84vF1jeUIEMTIrQ7nF2
	9f63MXBWUBCs9qcsIGAF8LDsCKefZ28nPOMX0gTbQDlmDVSPu7fzoFoHQsKYRGJR5ghqoi4
	iYmJlAfA8EaaP1EOhmFhnn+XCqSQFwIz8XJfbCDX67Vw/3X5F0yeNg3qBT7UzLe8ZSoXL0/
	7VM03pIlf+KL1xf05vdavRQWc+ReaBzSrdjyzqQFw7ybwinKVd+N1XDhxLXp9HBlt3/PCZD
	LLZKlpSczwDkc+9/eWZq+wjKHXLrQzMfelVkNU1K611Ug+CSFbMhoA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8826=E6=97=A5 15:55=EF=BC=8CAndrew Lunn =
<andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jun 26, 2025 at 02:31:36PM +0800, mengyuanlou@net-swift.com =
wrote:
>>=20
>>=20
>>> 2025=E5=B9=B46=E6=9C=8826=E6=97=A5 01:08=EF=BC=8CAndrew Lunn =
<andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Wed, Jun 25, 2025 at 06:20:54PM +0800, Mengyuan Lou wrote:
>>>> Add phylink support to wangxun 10/25/40G virtual functions.
>>>=20
>>> What do you gain by having a phylink instance for a VF?
>>>=20
>>> All the ops you define are basically NOPs. What is phylink actually
>>> doing?
>>=20
>> I think phylink helps me monitor the changes in link status and
>> automatically set the netif status.
>> Besides, I can also directly use the get_link_ksettings interface.
>=20
> But does a VF have anything to return for get_link_ksettings?

Just link status and phy mode set by myself.
>=20
> My understanding of a VF is that it connects to a port of an embedded
> switch.  There is no media as such for a VF. The media itself is
> connected to another port of the switch, and you can get the link
> status via the PF. Also, even if the media is down, you should be
> still able to do VF to VF, via the switch.
>=20
> What do other drivers do which implement VFs? i40? mlx5?
>=20

None of the vf drivers do it in this way.

Ok, I will change it.
> Andrew
>=20


