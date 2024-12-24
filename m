Return-Path: <netdev+bounces-154152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D20BE9FBAE9
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 10:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363C1166B1E
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90E18FDD5;
	Tue, 24 Dec 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="P+lMinXO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD218C903
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735031050; cv=none; b=cil+D3auEw2fXS+NMzfKChtwGHoVic/cgi6NbRU+fiqzFaaHIKTvu/YT9PxgkQzGm/Zhz9ljUvIkKioXd18YdBQw0rUnuO7O51/Y6SuABynlyUKR7vGBkYMthvbimFYFyBh1HNUBjQuhc/zPO0ORI78u63SfB/+jGrZN9eIjVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735031050; c=relaxed/simple;
	bh=dR3J2AO7c6sZEVZYUFLwld1S6Z3ZBTYtkfqqtrwEmb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZBcpWuKnw25sQC6nNkxEuNuzafhhqoLoOIWVaaSxWyxDblb5Qe/8iNVi2UwFXLZ9rZ8TexiePMVssNQLzBeFco9YapvcF7A2u/RhzlQA8U5moHAEv+pcKY/uDpiwhLU60wD/YgXfkRJUIpEVd49bs626ZTfahwBd9MUE1JJYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=P+lMinXO; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1735030936;
	bh=pnRVptCir55iRN6tACq8biJmBmLFjYWt0eJCtl4slZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=P+lMinXOiThCQiKcOQOGiyQDlg4ZKTuBdXLODby06XtRVA+Z4Sl/ki8Wr0hGhtJMU
	 erZ1LrC6YOjriwM/0/qz+RXPaFvINtcHZ3wVwEccbJvfcNNSKRkaTR0AmixmZyRcE7
	 5c77dalEE2jhUIgsL6RPt8zy26QKiNM4utLonco0=
X-QQ-mid: bizesmtpip4t1735030894tk5g8f5
X-QQ-Originating-IP: 96GmDbkbkKRgISxbB+698YkwYAo3Wyh+yJTBMgPP/c4=
Received: from [IPV6:240e:668:120a::253:10f] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Dec 2024 17:01:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9337975073141793265
Message-ID: <EA91BB1E8AC92ED0+6715c92f-3b3b-4a86-82bf-4704c3b9f36a@uniontech.com>
Date: Tue, 24 Dec 2024 17:01:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error
 messages when -EPROTO
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexander.deucher@amd.com,
 gregkh@linuxfoundation.org, rodrigo.vivi@intel.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 raoxu@uniontech.com, guanwentao@uniontech.com, zhanjun@uniontech.com,
 cug_yangyuancong@hotmail.com, lorenzo.bianconi@redhat.com,
 kvalo@codeaurora.org, sidhayn@gmail.com, lorenzo.bianconi83@gmail.com,
 sgruszka@redhat.com, keescook@chromium.org, markus.theil@tu-ilmenau.de,
 gustavoars@kernel.org, stf_xl@wp.pl, romain.perier@gmail.com,
 apais@linux.microsoft.com, mrkiko.rs@gmail.com, oliver@neukum.org,
 woojung.huh@microchip.com, helmut.schaa@googlemail.com,
 mailhol.vincent@wanadoo.fr, dokyungs@yonsei.ac.kr, deren.wu@mediatek.com,
 daniel@makrotopia.org, sujuan.chen@mediatek.com,
 mikhail.v.gavrilov@gmail.com, stern@rowland.harvard.edu,
 linux-usb@vger.kernel.org, leitao@debian.org, dsahern@kernel.org,
 weiwan@google.com, netdev@vger.kernel.org, horms@kernel.org, andrew@lunn.ch,
 leit@fb.com, wang.zhao@mediatek.com, chui-hao.chiu@mediatek.com,
 lynxis@fe80.eu, mingyen.hsieh@mediatek.com, yn.chen@mediatek.com,
 quan.zhou@mediatek.com, dzm91@hust.edu.cn, gch981213@gmail.com,
 git@qrsnap.io, jiefeng_li@hust.edu.cn, nelson.yu@mediatek.com,
 rong.yan@mediatek.com, Bo.Jiao@mediatek.com, StanleyYP.Wang@mediatek.com
References: <1E6ABDEA91ADAB1A+20241218090833.140045-1-wangyuli@uniontech.com>
 <a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com>
 <5DB5DA2260D540B9+359f8cbf-e560-495d-8afe-392573f1171b@uniontech.com>
 <531681bd-30f5-4a70-a156-bf8754b8e072@intel.com>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <531681bd-30f5-4a70-a156-bf8754b8e072@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MZQHZNohqAr1ySumv8rKqCLq2N9jhH+RgB/6fBsMx78mVjsVlTw8EviR
	9EC4j7yBQUHaq/slMyoMN070kRYJM33CUSpMKaydBzBrB8ysAz/Bf5V3aKUiMtwk2Dn/N+a
	jUD5OmJFI8ETCl6/yHo1+a5ptUTbFAZT0beS1CXaGeT0oroUlozvKZWWH25QzV96Wfh83Jg
	pPfyLVhwzkxI0z3Gsz/mwxLGGnEcnmon8jiLohh1qi7Htq4Iy7svdALJdI282wkG3trDM5W
	+t+Rhr2HSfPXnEQK/zd/eaezB3Pds1HiboetSnaUFaduyCcM5Vg4fd47r/BnGUJi+b/rOOZ
	n2fV4ngL4QefO/jE6bbnd8K8998vzbI4Ve5piYJWtjfTTdGH3bInMQU/vyLhf544ms9IIQ0
	Iq0fc6KrU/x2577yHtqV47wI/ljuOmvugmQauoO8uEt8RrBMjTE032WSadewRzSFCZa1Dc8
	tx02FlWEJbphZN6gdX2/JO4+efnKmz6w8dTGb6HGvM6Gh8P0anH5Bj9PoLRoQveyqdHuh5G
	9Ra0JL1dmPFdvrGOHJw0N9WjOOe8YbwR6YjrD6uyQ6jgmfIBtJTCIZP+XaLnSgFdNx7Q/FP
	5mS/j+OX4ebaVIr88DbGA3oHF7TNu+YLqrR9PiqMvZfg9mC4XcublZarzsrk09cBUyjGDA6
	+uVS0DlTKS1xh5yZmRmRPDNEOLe9iTGKC4MIi0zTyoFOMwNOhABheZzkAP5Pp5cPEp+dcQf
	dVwH+DJkesXfO6Yw7lPIXgB01UZ+MgkJo7IuRy0MURWKu55/+FN0gK6K1ue6rFKxKk+S14Q
	10jgsJMWtcL5TzRX+oXuYauPyuiLu5tAO8mA+rup+NG0BCjFYPLEu7MhVVoqfqC6L0kXkEm
	hFUVbsPkS2ioqFlgZp9K5KU+D6L/wcq0BNN9Qq8VqJat+mZhGuNETI1KtYN9k+hm1W2uHhU
	PwKqs90l1YY2QxjrB3+68Iim0uRk2JlCHnnJ4GbWlN5/f6PnyA+L8jYVCNBJCp9iVIgfNtN
	iYu7+iu9y5UxFHQYO4
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0


On 2024/12/19 23:23, Alexander Lobakin wrote:
> So you need to add the correct tree and/or subject prefix and specify
> "Fixes:" tag with the commit this change fixes.
>
>> ...
> I'm not a wireless expert, from my PoV sounds good. Just describe
> everything in details in the commit message, so that it will be clear
> for everyone.

Hi, I have attached the new patch as requested for your review.

Link: 
https://lore.kernel.org/all/BA065B146422EE5B+20241224085244.629015-1-wangyuli@uniontech.com/ 


Please let me know if you have any questions.


Thanks,

-- 

WangYuli

