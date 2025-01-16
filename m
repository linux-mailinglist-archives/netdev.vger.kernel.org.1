Return-Path: <netdev+bounces-158830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1078DA136BE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609391885F8A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1DA1D63E8;
	Thu, 16 Jan 2025 09:37:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B026198842
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020276; cv=none; b=jxAYCWGdv7arQyguQkVIrSG2wDGSoi9CqFFlnXZLcErfMCe40069WB7tJbN9GXqLhlSle22mCs5Rh6XNd/1SJSvo7LdY5ucPTW4y9lvH1gXKpUeZ6y1LLe40jCT2G1zpgQhDC6V9AYyPestZJkJdnssISfdiu9tIUdf72LWzBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020276; c=relaxed/simple;
	bh=a6+tibndAKlwXdWPaRI3Lm6drvTa6W9RsPmJHhJYfBY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qSE6/31yZ7tCauZVhRXWXTnBixsUv+PONOxYZDf3XujON6oTZesguyUFH0zAPo9vRNj+Yyz2/oejYqyvV6tEl5c0y39TA+P4IB4Ve+bPaPODixfpwGgwNVPwr/9IkR0MoR/K9n1SJB98Hj1277+qOJM60Tk9HHF6Aum9b4Ns5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpip2t1737020243tl76ym1
X-QQ-Originating-IP: GzCd0LfbCFwjdEnpv3YsPOIijKm7AJ9HQXcvJy6giHQ=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jan 2025 17:37:21 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1748168556563864666
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3814.100.5\))
Subject: Re: [PATCH net-next v6 2/6] net: libwx: Add sriov api for wangxun
 nics
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20250114144454.16bc139e@kernel.org>
Date: Thu, 16 Jan 2025 17:37:10 +0800
Cc: netdev@vger.kernel.org,
 helgaas@kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1EFCFA3D-B0E1-4EEF-9441-A594C7796485@net-swift.com>
References: <20250110102705.21846-1-mengyuanlou@net-swift.com>
 <20250110102705.21846-3-mengyuanlou@net-swift.com>
 <20250114144454.16bc139e@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3814.100.5)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MCg5+ArSTX6cAqeP+eal8AwVC5s5AJ6HEeO7MABvETufEhwR6myH/VgU
	R5pxEq2bJ17guCx1QavtPkmsj2qqdsvmTLVxdft3mSdu4vDrR65yeqvodUqLCJGs+aUMDjb
	Rv4JJ9ybaRLkecBok+VHWLQr2/9xdSU3YHSZ5OXWD4ap7lAW+zoEldHZUCFYhobxWkeSjbn
	5vLCz+S/eRBJ07xltst69F2E8EJbnd+LGwVDPZKSs/U832dGNageqCTNXQyKM2onrgnJ/0Z
	F7BYE2gY+du8huIrlxo+QemRrX1O56RIu0fCgFDnqLGZgPvE6o49Ttane0CJFfyBDiCBFBw
	zG1/WzfPEHD4qOPUTtFkAiAlrH0zUoFDMXxwz2Nqwf2Vn3tScpfdX53jMv2quO7MGW1HRCN
	UsDA/pFPuZNF2qxulIKDhuzO+OnFuqNNZoyALzTpC1YGDZi+pdaREPMKaiAZ6qRukNzT49O
	u4QNuuR3MBS3fJQ7JJd9MZ9JsKl8HJZYW9FtLMLVdw3Fn8BsDGCFL9UdabngGu92q1+djgK
	VgRcoDxfe/JS2h+4qhXJj1gtRJCeaHsFXowajA3GeOMm5FHXvPA3lX1zh+BrZ0nXSmUlxvS
	4yqlKccqFN2zFKlaco9jNfHHuxxQ7rR0Q98oCAKcPibJ6I87JMnX8rLJCWOM+pA7QNdeujE
	0ZUo5OuDtTnvidblCkxpCfaqZW0EQwUu4xeCzA5WSLysafFmLPd4fL4QeXTey97R0wANPii
	tmj0I5CrbzD97Y5JBBHj/wlbGiCLdMjCV8UTbYOslgxX1MxpNTYlUFtgOB9i6wqgH2+STEm
	2JCMgY5mbIN1+KC1L5L+iHRSg8KecfdaaF3TsEY42TK7RFLYCl9loI5k7Nn9eXtV/AYXivb
	xghiMKZ8khya7emZar+u8deMp4oXdWAGb5qZe4p6be1HORnf8j4j4oArsw+mhER9ag/F6C5
	KtvAOUKLOLWsGblfq+Fm8KMRNyu6Cx1m000RyivXr0AhcTdgnnWsy4cp9x3Kex4+1xITYgo
	n8Ayt20DpKmnnrwt5+u5V6E5GbDXs=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B41=E6=9C=8815=E6=97=A5 06:44=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, 10 Jan 2025 18:27:01 +0800 Mengyuan Lou wrote:
>> +static int wx_check_sriov_allowed(struct wx *wx, int num_vfs)
>> +{
>> + u16 max_vfs;
>> +
>> + max_vfs =3D (wx->mac.type =3D=3D wx_mac_sp) ? 63 : 7;
>> + if (num_vfs > max_vfs)
>> + return -EPERM;
>=20
> You should use pci_sriov_set_totalvfs() instead of checking=20
> the limit manually in the driver

Thanks for reminding.

> --=20
> pw-bot: cr
>=20
>=20


