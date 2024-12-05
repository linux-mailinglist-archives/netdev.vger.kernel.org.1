Return-Path: <netdev+bounces-149353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B63169E535A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DF11881D50
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E11DB929;
	Thu,  5 Dec 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="AIb/bUr4"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9161DD0C7;
	Thu,  5 Dec 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396858; cv=none; b=QWxIFYbQbsU6gZclBkDF9pPiiN54Gbk1ZdAQhNEXv+i4q/5eATYO9Obs5DEt8jWUqi7mfYoggo1CsVFBnL3oXFhNKNXLS4VWVQo+yLrvcQI4HxHbSQIjI7TxAPcUfMrNcTGCwWzQE8W1hdxSJ3r0I4yypJYxTkkoqDZAS6/UxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396858; c=relaxed/simple;
	bh=7bFBc3/3uDOJYg0WdMsRPAxsNz08WlwezQMA83Qbl+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8JOaKg1ivVbVsYIrbaM1RE7bl0vPQpda3WDXPkkN/BDGNJ7xwRi5DHpfH4zPllpkNEx7vFxFdVRRRv+kQKJ4gLljCoSZtmXM9abZLsWX6OUMg8breuvnt7RqvU6C5/pbYptuHDvBPs6DmkA+sKytRNNDDF6kXpXAfggGMyfUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=AIb/bUr4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733396842; x=1734001642; i=wahrenst@gmx.net;
	bh=NLarr+ntzxVvGLWqrHEgsyePTJ1n/hSq++kop0hKzcw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AIb/bUr4am9zGbNSXcb585+iqo1eqvv4mLcAnZiWH++Zn5OH/FuRhZK9GeOgeeiW
	 WRVLyLo2W/Q3VkNBxQ8MEpZUKxTqnw5RrKa75RXlT0AHFeMMDnaooRORME6nvwynT
	 cJXDMnGcrYF8QmafW28/NbR+pLrLvNeQkgbMMRLscI2JWRRpUsKWBCzaqQpNRP60p
	 XntUvoAPAjVIly2BLFo2s8mpuCrtwXSp6YmR8Z+Xpvu5+B7bUHOgWBFvzLCmRp4tk
	 Q8NL7FFjmDVSnn+lzObeiDMLwPAaIKisfbQOb/ihduZUbyd2RtJYcNoLRvLT1jB+k
	 oPvDuHjNZ7wXI1l/vQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.106] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1tC7CO2bn4-00NM2Z; Thu, 05
 Dec 2024 12:07:22 +0100
Message-ID: <90137949-650d-4cc0-b40f-9b8a99a5e7e1@gmx.net>
Date: Thu, 5 Dec 2024 12:07:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] qca_spi: Fix clock speed for multiple QCA7000
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241202155853.5813-1-wahrenst@gmx.net>
 <20241204184849.4fff5c89@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241204184849.4fff5c89@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/w9J199l9P6ialYPW5/C4wBTspmuXr6rPkuL+iSILJL580PP4i3
 e/DZZvwGjEv7LJfjlX/cN78n/hS87+4nPQxsflq3cJqnf3XLtlcCpCacfy3I8LBsPIuGxr4
 r1tcl7+5hQ65Nkm9jfGfmbv5ApBPKSxk2HJpnRvdTlN7nYpX+14roYOXcphj0Z72V+a5PXa
 /KymYu6J+5rTT5R9paUvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uB7ZbMisOMs=;FFwutNRPc80u1x2yma38LxUq1iE
 nLNXGMICLsEb3FKRZ5+3tBKX7HfRsngbiZJow7S08Wb8qefhtNDiX291C0IOuL/Mr4d3Tu2XM
 oyNNtXYWG+RFKO2mEgckJ927KhQfcsdSvwi/Da0+ud4ol8wB0FzdiomU6IUd9N8m0ThC2knYX
 zwYcbaa6Tv9YezmyKsummxCzHvMjlw0WnIcjE8nwmii9GOdSDkwU/3Yri92DfC1ohg1VGJP02
 DHzskCbQAmx/ChCuM/3QJ7+QpSuR/WHwD3UfhNabpdXoqQToHWvqa6y5OTnYn+6TZ2q2eSNPY
 fS87CNLK7+iS3c0qPDBlDp3XnPgyCCO0wJCEIOa21iQppJsCOKyCjxj+7IBhnbP+FBMJeK0UF
 CbyR5lLxrXrIVmsLl0LSTmMUKmzZcud5NqCSgxFJUyi0ntXQUPNWZo7wmigA6Gwdv5ec9UfS5
 J8fSKvr9+8XShFKnY+Cr1YjTQN6348SpbOrrK2BX7MK5B37rz3aLD1gqoLMYxyUR7kYN+iRFr
 N446mewjl2wOa062o3tdDLEsKR2zSkjnfg1p9y6ZfgiWuqtUA+vJJGwvu8Av6GoCoEINzWqYa
 yo7NtVkfq2TZiuoUczXNKu0WPa77QYwt4UOIwfm1gyY7TxKaVJYDlJMaYtONzkROw1Q6gAMzJ
 QkDLmsgitgljuSU2+95QdzKV/bQ7bbLRJIgbuCG3rI6CSGBrQiZMuytQ78FdAMBJE+S5s2NJT
 wLdFu9FNwmpPgZJ5VS1agIGSO/XwOVvvmwlkrhd/jPPfVOOlEXE+9kUx532rzWlkgnDKqozw5
 Pt9xQRShAyfPllhf8jSg5dEiY7mOHFLsJv7i2wiCskcWipiFusCO6qwPaUkKKHfoX8zIVZ7Cd
 UVhTPC9hp6wHdG3+iz43+sMGkGnfyhkwWkL8fvWa6RLBZZevY9IyMvnh+zouLgh/WTPaZPHCN
 9Kuq9Vgu7KPJTbOITLJ2CwsW4doxb3VGDfXdMmaWnlb1tHF2LpKAlVE4BkxFAip11rX/MZrGg
 up3T5irm5HnJbZwYewcbC4ng0u/1JTm9V3ueoY+UqH9bQDpk5jjCPMWVedMvb/3f5UBb+v3vd
 NZ7sxqJPUt2dIoj1VcV4DfaPMwHi2g

Hi Jakub,

Am 05.12.24 um 03:48 schrieb Jakub Kicinski:
> On Mon,  2 Dec 2024 16:58:53 +0100 Stefan Wahren wrote:
>> Storing the maximum clock speed in module parameter qcaspi_clkspeed
>> has the unintended side effect that the first probed instance
>> defines the value for all other instances. Fix this issue by storing
>> it in max_speed_hz of the relevant SPI device.
>>
>> This fix keeps the priority of the speed parameter (module parameter,
>> device tree property, driver default).
> I think we should also delete the (seemingly unused?) qca->clkspeed
> in this change. Otherwise it looks surprising that we still assign
> the module param to it?
Good catch! But shouldn't this be a separate clean-up, because the
clkspeed was already unused before?

