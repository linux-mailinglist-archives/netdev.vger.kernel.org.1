Return-Path: <netdev+bounces-201413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BCFAE964C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9E41682A4
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 06:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD771A23A4;
	Thu, 26 Jun 2025 06:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39313A3F7
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919571; cv=none; b=rkrvqDilyhCpEAS7mZAn8iifU3PlQ87ms/lP8tLQaxXdozJC6L+jPY8zMjFt6wxs8d46jdA7HjFqZjrgnyqNTLWLbLHBfb2/9JhUxzG4VeZlGT4wXqyivLpwVSM47YaTYMjWvu3PF1yu8xl55Mx7tzBRlCN3DLARWRh5TtUOxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919571; c=relaxed/simple;
	bh=TDalTunvn+bElhwPUzbvPpsFu1PtmiCO8ngSflWTgFA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=X+33SbxUydOQZ6ItcNsizjM8prEqF0Wj8AIayjtStwP+u5OjW8gCs5CfAGGmd7ZDCma7fkrgNPjI1iaUVx5JN8lT/W8Zho9oaOdmJ/6N2UsZWDRWCV5RXld3Ix4H98YHYpn8gN6ITzPUr4vAg55yWs+y7Zp315gW/JNA8FfRq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz7t1750919509t638f7b38
X-QQ-Originating-IP: youq8oWcb23IKTfGp+nG3DY+36M5LvSROlFByKM0GxU=
Received: from smtpclient.apple ( [36.27.0.255])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 14:31:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18266739101542888331
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
In-Reply-To: <71d0b663-c717-45a5-ae23-f5b91d199eac@lunn.ch>
Date: Thu, 26 Jun 2025 14:31:36 +0800
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
Message-Id: <B649FE55-96A3-4631-8714-51128EDEE810@net-swift.com>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
 <20250625102058.19898-9-mengyuanlou@net-swift.com>
 <71d0b663-c717-45a5-ae23-f5b91d199eac@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M//muKyjQOU46/zlIP25euEQArTG40H60+sTGyW5cZastvY1o2N0R7f6
	CpKvs3LEyVyd/d06w+jgsx3m/Dz0EtNBnK85L0N65uxJNNEN1Ffstw9Kq1Dtvzxa0ap/BZO
	AL8TbSEFd+1ZqLArI3noPnKI0G3ha/INeb4S0olZOy+HuBT9+4x+KPU4gDLZI8dc9K3coxv
	tpSjguDRPsxNPMGOtGyR3k1dFgxmNAwI36GLr3I+MYFw/dw9D2HFX5kbnEBzlUaGq2zOxon
	3PMxfrz3hFC85RTxGZWgxAYw/qlDjkhp56bf0I44p6cEh+aAsvDNJw3o2blx/FI4stZoiiM
	/pvtAXVYiBYSD8rtDwDOkYXVJnWCc84OVp0K5faiwTckLLGYUvGRPn+WtJtURKecxAyQ4ec
	CA9WJ6aOMcGlEn+qEmcVVEXpMcaHU+SZtxT7HK77birhblwHZOe4+duzkAw2PC/cgSUzaWH
	eXOX0Y3YFBgAjmBLmqxGvwh+L6JHmpeMRhwnTQ8SG702dwNLgImtiNW50PDB3nywpv1teMU
	AYycfAzfbJIk5Fc7X0rfbwTcphIreBJVhCLk0nKF+7RtcGUJazNru7d7Du/O4oMfZYWX1+R
	1h6AqCgH5Zdv7JxSu5N/z5DrBNtxIIlUZhQARIV6iIpM0Fj4zGz9fDQ7wpwh/BwRc/BZqjc
	ihb2nLAMNO5sT9ELzyEtKvtAtPJn3P/2pWtrPnbA4l9RDCTNtt8/s86zbn/19Jx8gNAMvSp
	JGGja8EOCqAMP7MUTMa6ybKR0osieFjvtc4Ck2fwLcVtBUxvLB3GZ7TrV4wyeM63YuTTpwi
	FUYMqqv8TUVJIiPEii8PiYeJQ7dGs4xypDBjhvcQHI4niMX0NnjXySh7ylohNu8zsOYzwND
	pgCS65CctuzGl1gPEDC2G3CzQqLTXudWc8rFuk22d5CsgG1vV6zRmkoN+5hXXEnWV+Azgb8
	DCcpeDNYtnl6f1nA8ijZOE3o7NUErWbtQas06jr+xkhzUM9hl2UsLw+9Q5vfr7WFH6GZ93l
	dFjPLXGr9Za1VIkIIxq0DBHuUGch4=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8826=E6=97=A5 01:08=EF=BC=8CAndrew Lunn =
<andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 25, 2025 at 06:20:54PM +0800, Mengyuan Lou wrote:
>> Add phylink support to wangxun 10/25/40G virtual functions.
>=20
> What do you gain by having a phylink instance for a VF?
>=20
> All the ops you define are basically NOPs. What is phylink actually
> doing?

I think phylink helps me monitor the changes in link status and
automatically set the netif status.
Besides, I can also directly use the get_link_ksettings interface.

>=20
> Andrew
>=20


