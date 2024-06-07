Return-Path: <netdev+bounces-101816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3B19002EF
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F561C237CC
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88EC190692;
	Fri,  7 Jun 2024 12:02:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBD190682;
	Fri,  7 Jun 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761724; cv=none; b=C8NGOJbkY7CXKS2bImhtOKTgX46ZSZxbW2ztHutrUZXH8MF6JJajKNQnI1r6iFiYoejiFXb39rhX5DkNDwOojy2PjkX5QJsxdEbROXxyq9x9egVPRLSHBecUQdmC2jd7WKUF2zo1pLk7Z8DHMCQL0IeLcE9qbPblHhFidKoQMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761724; c=relaxed/simple;
	bh=9ahM5q+SYr/ja3n2M2hkdMF+HWZWuvn6I+naWc5+fAQ=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=ISFXAz46oGR2GBRVGZNRPsS0c7NcqMc1WLyrWoCJ1jYkEfSQ/XLYPsB5AeGOb0dN7dXZqk0saIUhn6d7Q2+2epiEHJH7AUhv6qKZaxV6ffiVwUnGVoLwc/2KsAJoNEsFm7UDAF9zd/jyhf85a23/mrQVKkTVgEhFzjzYpuk/T2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=990276a841=ms@dev.tdt.de>)
	id 1sFYIB-007m1k-PA; Fri, 07 Jun 2024 14:01:59 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sFYIB-0069Yi-4p; Fri, 07 Jun 2024 14:01:59 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id CC79E240053;
	Fri,  7 Jun 2024 14:01:58 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 57A48240050;
	Fri,  7 Jun 2024 14:01:58 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id D7A483829D;
	Fri,  7 Jun 2024 14:01:57 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jun 2024 14:01:57 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/13] net: dsa: lantiq_gswip: Only allow
 phy-mode = "internal" on the CPU port
Organization: TDT AG
In-Reply-To: <20240607110318.jujco3liryl7om3v@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-3-ms@dev.tdt.de>
 <20240607110318.jujco3liryl7om3v@skbuf>
Message-ID: <bc660eb043143926ef267d1b96dee939@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1717761719-B9ADCD95-00516752/0/0
X-purgate-type: clean
X-purgate: clean

On 2024-06-07 13:03, Vladimir Oltean wrote:
> On Thu, Jun 06, 2024 at 10:52:23AM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> Add the CPU port to gswip_xrx200_phylink_get_caps() and
>> gswip_xrx300_phylink_get_caps(). It connects through a SoC-internal 
>> bus,
>> so the only allowed phy-mode is PHY_INTERFACE_MODE_INTERNAL.
>> 
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> ---
> 
> This is for the case where those CPU port device tree properties are
> present, right? In the device trees in current circulation they are 
> not,
> and DSA skips phylink registration.

Yes, as far as I know, this driver is mainly, if not exclusively, used 
in the
openWrt environment. These functions were already added here in Oct. 
2022 [1].

[1] 
https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=2683cca5927844594f7835aa983e2690d1e343c6


