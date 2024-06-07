Return-Path: <netdev+bounces-101867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E6490054F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C930286CF6
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3C194158;
	Fri,  7 Jun 2024 13:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0A47A6B;
	Fri,  7 Jun 2024 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767808; cv=none; b=TOVuPwItA/Af9KaNRi4/qz+/+ob4dzfkn41E7CCr+efXHvm+r3FqJBPnCekAd7pDYXCWSH3le4t/T3mdji+FNDIGGLFkFoX8CMc1dY2KXNAEHvzb/7+/WTjVQ+NtC24e7dVDdZhXFo0lu6SlowMSiRvUdXfBTbF5KT3cgQ8H61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767808; c=relaxed/simple;
	bh=Ig7h/WAJSPZ5uoCGDgSSvbxyZnPPVSC1ewqn6DJmRdo=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=u/DsQaNrestlsQa/jhnFA2wIFo4B1RgwDg7blOE5ZLSE5RkoQahFPWqZdj1jNAsuwMaxMcIVapZ1oYgp3/CfcTv3zLvd1fe+XBIIi2x1fFz7I/14/DwufgZIeDmjX0q/GCjUQxUr/hAurk1CFg47FARTLb4tJ2zwHwo6+16+pZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=990276a841=ms@dev.tdt.de>)
	id 1sFZsK-0061eg-GO; Fri, 07 Jun 2024 15:43:24 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sFZsJ-0088wo-Vd; Fri, 07 Jun 2024 15:43:24 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 9F940240053;
	Fri,  7 Jun 2024 15:43:23 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 2A1CD240050;
	Fri,  7 Jun 2024 15:43:23 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id C1D9120974;
	Fri,  7 Jun 2024 15:43:22 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jun 2024 15:43:22 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 11/13] net: dsa: lantiq_gswip: Fix comments in
 gswip_port_vlan_filtering()
Organization: TDT AG
In-Reply-To: <20240607114456.sm2wwtu4aqbyn3sk@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-12-ms@dev.tdt.de>
 <20240607114456.sm2wwtu4aqbyn3sk@skbuf>
Message-ID: <3ff925fb12bc1de7dabf1b0e4eb6b0ac@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1717767804-34DF7522-D85C077F/0/0

On 2024-06-07 13:44, Vladimir Oltean wrote:
> On Thu, Jun 06, 2024 at 10:52:32AM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> Update the comments in gswip_port_vlan_filtering() so it's clear that
>> there are two separate cases, one for "tag based VLAN" and another one
>> for "port based VLAN".
>> 
>> Suggested-by: Martin Schiller <ms@dev.tdt.de>
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> ---
> 
> Here and in whatever the previous patch turns into: please make more
> careful use of the word "fix". It carries connotations of addressing
> bugs which must be backported. Various automated tools scan the git 
> tree
> for bug fixes which were apparently "not properly submitted" and mark
> them for auto-selection to stable. You don't want to cause that for a
> minor comment.

OK, I will eliminate the term "fix" wherever it is not appropriate.

