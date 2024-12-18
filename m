Return-Path: <netdev+bounces-153141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21989F6FC2
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 22:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067B3169399
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6C11FCFD2;
	Wed, 18 Dec 2024 21:55:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender2-op-o11.zoho.eu (sender2-op-o11.zoho.eu [136.143.171.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BA1F63D5;
	Wed, 18 Dec 2024 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.171.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558912; cv=pass; b=ANS8v2mns5T3wg5Uauv6S+QeN0+S3HEYv+bQ4bSYL0j8zDxtdtTpdJ9WToSZdHJ05Z7KrYR91gHmyT/kFMjZXgNuOo2O+KknH2RTznbg5Ys8OpjDtyx/iXVZ17+X6R3wOqd6Tca/xP8ElK9H17trIvL3t6Xjn7eSOmk20bqfeK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558912; c=relaxed/simple;
	bh=pyyDpIDAm3TXBlVbYSyzly1hM/RGmRyYavZYESyY1j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCHwGFpd/8poDTsL5tiIxHves866RXnneIkcCMf2HAg96nQwXnVDgtCnLF1moXIICcQhIQxEtGzQtvhJ0mheU/LNzEZjokYLujsHnlVGnKxW2NVMuTuBO8a7Z0r50PiB/VM7io1i7laKro1JxsKGWKkLvGN6dklwbWJJY4gDPMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trained-monkey.org; spf=pass smtp.mailfrom=trained-monkey.org; arc=pass smtp.client-ip=136.143.171.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trained-monkey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trained-monkey.org
ARC-Seal: i=1; a=rsa-sha256; t=1734558876; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RkvryVTCXbKm36LKL8Pu2zGmrkxaVAkNtIAR67hTc4au5WULkpj//IsrhbyIjb3T5Mb78K4kx0vQDiMUHhpNvtghGYgned5xmv0V3yuPBSDABb9UqGYUjkw9Ml7jT0J/PRdqI13IFCGKpB5RXBcZ/b8+yU3qEF1MK5GGyrtSd+Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1734558876; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AbCCgIQ4kREKGgQgAXdjH7laVuupWapCYL9Iysam8wA=; 
	b=XtIbhevJDQtZZdVK5tTeQGuF95Ndus7bZiZHkEwBNq97vVSGi+2RFFL2ZXR+1ZMViH2PnlZwUaYurApRRr2UNsKKauvoPDB7PZ/0EdQrPLfVPSGwBZrx1BV7kAOXdzBt5IicQJrRNugKizDkiCHfz2dkClGaO9XDPK7lGMacoWA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	spf=pass  smtp.mailfrom=jes@trained-monkey.org;
	dmarc=pass header.from=<jes@trained-monkey.org>
Received: by mx.zoho.eu with SMTPS id 1734558872983404.94538270672706;
	Wed, 18 Dec 2024 22:54:32 +0100 (CET)
Message-ID: <3500c9d7-2b81-41e0-985c-7a63bcb87723@trained-monkey.org>
Date: Wed, 18 Dec 2024 16:54:30 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Remove bouncing hippi list
To: Simon Horman <horms@kernel.org>, linux@treblig.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241216165605.63700-1-linux@treblig.org>
 <20241217105102.GR780307@kernel.org>
Content-Language: en-US
From: Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20241217105102.GR780307@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/17/24 5:51 AM, Simon Horman wrote:
> On Mon, Dec 16, 2024 at 04:56:05PM +0000, linux@treblig.org wrote:
>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>
>> linux-hippi is bouncing with:
>>
>>  <linux-hippi@sunsite.dk>:
>>  Sorry, no mailbox here by that name. (#5.1.1)
>>
>> Remove it.
>>
>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Thanks David,
> 
> I have no insight regarding how long this might have been the case.
> But this seems entirely reasonable to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Yes sunsite.dk has been gone for at least a decade

Acked-by: Jes Sorensen <jes@trained-monkey.org>



