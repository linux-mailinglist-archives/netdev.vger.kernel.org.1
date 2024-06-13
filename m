Return-Path: <netdev+bounces-103220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9A907186
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F8E280C04
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29CA1428E9;
	Thu, 13 Jun 2024 12:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66598142654;
	Thu, 13 Jun 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282254; cv=none; b=XaDMs/wWeY+CvFjaFV0agy5K+co3fOvku6/EEde7w9g8BPYWLzHB7wQsvVochbfoOzCz08wqwuN8vr4Rg8F9tmBSbRsS0uVAYzPXlEEgdk4gaxFYhxG8tgldeCguHzv6XM/hWgNFLs3HQJj/b+10wcy8xnB0y1W5o9zORQ6+PX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282254; c=relaxed/simple;
	bh=j/mjhU1X2GxfRi8fOLaRUoOXPbNo3HzwBNVoqGZBIZo=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=poLKYadMk0RFkmz9DUcmdhboHmxb8xv0pRsWXSh5kWpxQmWlRANM6nbU/eVDmjHUTWi1Efjfz47NFK1R4Wi4e7zp4qm9kzhsJVZ8WajJnn3wEwSISyWtstCOlR+yMzGxfy2PNKJBduQSb7NOvpWqIbXp/VX81I/7u2PXjVWbBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=99085fba10=ms@dev.tdt.de>)
	id 1sHjhq-003Fy7-5c; Thu, 13 Jun 2024 14:37:30 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sHjhp-003EDT-KM; Thu, 13 Jun 2024 14:37:29 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 49844240053;
	Thu, 13 Jun 2024 14:37:29 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id D0B67240050;
	Thu, 13 Jun 2024 14:37:28 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 8C2543852A;
	Thu, 13 Jun 2024 14:37:28 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jun 2024 14:37:28 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 11/12] net: dsa: lantiq_gswip: Update comments
 in gswip_port_vlan_filtering()
Organization: TDT AG
In-Reply-To: <20240613120218.yem27x7sf3yld3bv@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-12-ms@dev.tdt.de>
 <20240613120218.yem27x7sf3yld3bv@skbuf>
Message-ID: <0deceb09e3b38f3e95bfc6f9e69a6392@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1718282250-34A72D11-E88E9E77/0/0
X-purgate: clean

On 2024-06-13 14:02, Vladimir Oltean wrote:
> On Tue, Jun 11, 2024 at 03:54:33PM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> Update the comments in gswip_port_vlan_filtering() so it's clear that
>> there are two separate cases, one for "tag based VLAN" and another one
>> for "port based VLAN".
>> 
>> Suggested-by: Martin Schiller <ms@dev.tdt.de>
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
> 
> Needs your sign off.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Signed-off-by: Martin Schiller <ms@dev.tdt.de>

