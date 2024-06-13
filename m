Return-Path: <netdev+bounces-103212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BF59070D1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD671F23078
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450192566;
	Thu, 13 Jun 2024 12:31:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA6399;
	Thu, 13 Jun 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281863; cv=none; b=pvAsQY8uuG2ohl3skruRTbdUmWyK5nWpQfqnxnUguZdb9CSvL1FBcY6S9pNPfAaHcKjJ//d8qG0mhZaDDCgEPyXtg1Iy2OyCcE20Qnrc1H6Z2cebMjukTrcAFRsYd+XD+DnAWE9018DBb2Tcf8Az4NPRCSgr0lXPZznUWRw/3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281863; c=relaxed/simple;
	bh=7K6byeNV/a8FAZlE6zuSjSiVcp+LG7CLBjBGax448NU=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=qz9bvy7kTCjJI6cj/8kRTUtj+1idwqsIxZzZJXWQNnkh4U4GIqt1c3lOvWtkCSDe90fKYzjW+UC6O+y5hvT/cdxDDksbPVmiXYD2ToPA/O5y8Zqh/QQleOUK0eFuyG4NpguNwORBxzuqKzlp+LkvcHOQ6rgWhPM6OGbTmQh7qWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=99085fba10=ms@dev.tdt.de>)
	id 1sHjbV-00211c-FU; Thu, 13 Jun 2024 14:30:57 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sHjbU-002BOj-JQ; Thu, 13 Jun 2024 14:30:56 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 2E02B240053;
	Thu, 13 Jun 2024 14:30:56 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id AD4D8240050;
	Thu, 13 Jun 2024 14:30:55 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 34DA63852A;
	Thu, 13 Jun 2024 14:30:55 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jun 2024 14:30:55 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/12] net: dsa: lantiq_gswip: Improve error
 message in gswip_port_fdb()
Organization: TDT AG
In-Reply-To: <20240613114832.23pvevg6wmyczr7i@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-13-ms@dev.tdt.de>
 <20240613114832.23pvevg6wmyczr7i@skbuf>
Message-ID: <89d63f2338d25e0466d7a35e59e059d0@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-ID: 151534::1718281857-CF4488CF-572BDD86/0/0
X-purgate-type: clean

On 2024-06-13 13:48, Vladimir Oltean wrote:
> On Tue, Jun 11, 2024 at 03:54:34PM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> Print that no FID is found for bridge %s instead of the incorrect
>> message that the port is not part of a bridge.
>> 
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
> 
> This needs your Signed-off-by tag as well. Anyway, if there is no other
> reason to resend, maybe you can post it here as a reply and the
> maintainers can pick it up while applying.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Thank you for pointing this out to me.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>

