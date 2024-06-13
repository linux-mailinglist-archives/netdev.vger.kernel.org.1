Return-Path: <netdev+bounces-103214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 633C3907103
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DCEB22AAA
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D861EB5E;
	Thu, 13 Jun 2024 12:32:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A31E49B;
	Thu, 13 Jun 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281967; cv=none; b=XMn0CD+AnsMnQ2YtYJ09neAq/PWd/Av1i4MYk1rjytW0S7z2vT5FHAf7tRM9zOmHQn0672+XqcuEWktB7dqyrA0qzkbCutANubUPHunM0hTtmOMhivER1Qs5okYZRgT38Ll5tWelwtkoMlAziJ0zPhc6GhGGj233opdYtyUpqeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281967; c=relaxed/simple;
	bh=8z8mryihkPsMHrmTcB0xChWOv0muhpjdmBAMz3ALaUg=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=KBUoHG3A7FjQ7evkpLXVtHuqYcRFPlyskTpxzuhtCtdi0xEEhrh4VEhXngdb2/3iKPsJwRzVleGgKfve53gWFpIyYn9BKFWlAu4VeUAuzeQEhl4lM/7785iXVl1ZB1MGJRCjRibat8+ymOJVflF8Q9+pXutezSrHPTuh58rT2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=99085fba10=ms@dev.tdt.de>)
	id 1sHjdD-000Vos-Tw; Thu, 13 Jun 2024 14:32:43 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sHjdD-00FNJt-Bx; Thu, 13 Jun 2024 14:32:43 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 1A0F2240053;
	Thu, 13 Jun 2024 14:32:43 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 9F606240050;
	Thu, 13 Jun 2024 14:32:42 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 062B73852A;
	Thu, 13 Jun 2024 14:32:42 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jun 2024 14:32:42 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/12] net: dsa: lantiq_gswip: Use
 dev_err_probe where appropriate
Organization: TDT AG
In-Reply-To: <20240613115137.ignzu35jxmmorxys@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-5-ms@dev.tdt.de>
 <20240611135434.3180973-5-ms@dev.tdt.de>
 <20240613115137.ignzu35jxmmorxys@skbuf>
Message-ID: <8592951129cec26ef55b43a99c5aa913@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1718281963-36936522-5FB1A390/0/0

On 2024-06-13 13:51, Vladimir Oltean wrote:
> On Tue, Jun 11, 2024 at 03:54:26PM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> dev_err_probe() can be used to simplify the existing code. Also it 
>> means
>> we get rid of the following warning which is seen whenever the PMAC
>> (Ethernet controller which connects to GSWIP's CPU port) has not been
>> probed yet:
>>   gswip 1e108000.switch: dsa switch register failed: -517
>> 
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
> 
> Needs your sign off.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Signed-off-by: Martin Schiller <ms@dev.tdt.de>

