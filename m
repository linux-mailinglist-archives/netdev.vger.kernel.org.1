Return-Path: <netdev+bounces-12603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A723D738480
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF14281568
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53147168C0;
	Wed, 21 Jun 2023 13:10:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404DADF4A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:10:20 +0000 (UTC)
Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A071519AD
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=8UoH+idalnUpQmcaZ1lY5Un8Qxa8aRoGfhmVKfM+sXg=;
	t=1687353018;x=1687443018; 
	b=wK7UKa9oz3nNFvjQPviB5EcMDayTY1LsnaKhIsqrh6S00D9KIsIYGwO0zShXNiEogA81Sby+SxNYvrw4/1Aks+3SNh6/r/OGQV3NMoAq2+InsPvsgZR17Ab+tHKJj2XJ6JwsIFe4pqxODAA6LazNDYzVyS13XXYslR/UWXYWBw8P4pROeNjUn4U9brG//7QN9lxqL8XD8d0WTk5E0EEYK8JqudT9mzti2pDVtBg01NgxupEbzBEV+omw0IdLXM3Gbz/xmN8TX7pRInAH1lT1H1JqOJJZ8CX0vSdsmQwikjQZx8af2vvJWIBTpvuUJaHYzEPJ5rPQCWZdp9bWFrFLuA==;
Received: from [10.161.100.15] (port=42350 helo=smtpng3.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1qBxbE-00G0mk-GY; Wed, 21 Jun 2023 16:10:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=8UoH+idalnUpQmcaZ1lY5Un8Qxa8aRoGfhmVKfM+sXg=;
	t=1687353016;x=1687443016; 
	b=mnqskDBLngjnYZ1PrArA/a/y52WEQlEiYZ8MRKy45quhsF0uy7ZqmJvCFEzudVdmABQ3n84avI4MWLTpvy8p99VYoTighDzBYQ3cVPJFO11Ub5HafFqnr5Pe0XFdDFZdZzJYYuY2wTv9REjfvCFsPKrp5HypJz54q5k4MthYQRxskSyKdKAngb3P7qaRbfVoKxkaAufV07qpg7HoifjEfj6Pk6xo/x9R/+gHrN/VQfuf0TsIzOlssGgt/JUVuj297iyz17E5H7htV/lMXSnQLopB85n5wDXIw8cdExpz9IiYQl/4EFIJi48utBy5ByJmytNOWYam3NnBf/7ljX8Ipg==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1qBxb5-0007PP-0T; Wed, 21 Jun 2023 16:10:08 +0300
Message-ID: <0273daf8-7eeb-17bc-2246-6b29ae27a99d@inbox.ru>
Date: Wed, 21 Jun 2023 16:10:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] net: axienet: Move reset before DMA detection
Content-Language: en-US
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230621112630.154373-1-fido_max@inbox.ru>
 <MN0PR12MB5953C2C8784514E9270787DAB75DA@MN0PR12MB5953.namprd12.prod.outlook.com>
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <MN0PR12MB5953C2C8784514E9270787DAB75DA@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDCFB14F17D0E9EAA49C0FEF2B22CA0AFAD182A05F538085040B44ECD70E72B90A1C7353EAF187005552EA5ED39D79F3D75C08906BD2F7D89B7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70D278D70F8433719EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375ABF1810CDE7D0E9EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA33A0F5DF476A30A0971C869230D0F2B120879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0CB629EEF1311BF91D2E47CDBA5A96583C09775C1D3CA48CF4964A708C60C975A117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7461A70166B335A6C9FA2833FD35BB23DF004C906525384302BEBFE083D3B9BA71A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F83C798A30B85E16BCE5475246E174218B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5C7665F0965BF676094CE825CDB77D22BEF5B8AB05602438DF87CCE6106E1FC07E67D4AC08A07B9B062B3BD3CC35DA588CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD112376CCE7498FB9CBFCB5D401BB18F622B7175CF24EB457EF6F00A15DAB1FE0FDE042572883009C17492877F82D9B8D901DEB25329734293F040D49FDC2017464E0F6E1F48538C02C26D483E81D6BEEB84411BD425175970A7FB4ED9620804ADE12199CE9660BE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojw7uTMtz3/lxRFo++Or8dyQ==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986BA32DCDD1994A7535DD38DE2913B0E5CE98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E9028C5D3AAACA541B7C9AC5AE5CBE45D64F8DB41054FBA7B647ED114AB003ACD3EABFC29535B18677DD407DF9775FB6A5D4421D9AD4EC05B97C44F3C5683DC8
X-7FA49CB5: 0D63561A33F958A5B7665F092FC6B9F43470C9FF8CE02E4D7066BB07DF88184CCACD7DF95DA8FC8BD5E8D9A59859A8B6D4CB5A318535FB75
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdGZgddNfoakNfJgIR1JeInQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 21.06.2023 15:23, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Maxim Kochetkov <fido_max@inbox.ru>
>> Sent: Wednesday, June 21, 2023 4:57 PM
>> To: netdev@vger.kernel.org
>> Cc: Maxim Kochetkov <fido_max@inbox.ru>; Pandey, Radhey Shyam
>> <radhey.shyam.pandey@amd.com>; David S. Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simek,
>> Michal <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org
>> Subject: [PATCH 1/1] net: axienet: Move reset before DMA detection
>>
>> DMA detection will fail if axinet was started before (by boot loader, boot
>> ROM, etc). In this state axinet will not start properly.
>> So move axinet reset before DMA detection.
> 
> Please provide more detail on the failing testcase. In which scenario we are
> seeing DMA detection failure? What is error log . Is it random?
> 

XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to 
detect 64 DMA capability here. But datasheet says: When DMACR.RS is 1 
(axinet is in enabled state), CURDESC_PTR becomes Read Only (RO) and is 
used to fetch the first
descriptor. So iowrite32()/ioread32() trick to this register is failed.

