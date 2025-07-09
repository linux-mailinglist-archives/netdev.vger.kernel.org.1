Return-Path: <netdev+bounces-205429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0AAFEA50
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8872540FC3
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE52E0B6C;
	Wed,  9 Jul 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oxeeR58i"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357142E0B74
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068021; cv=none; b=RMkrf/i7DfTwMA7mhONY0HnvWj2Zpl6lMHfLdAbyNtWp5MKaqGmGuYPrg2hV/Xjsswv9WGC5uGaY1OOW6+FNtakT42Mk/OxKb9T8m58u1RzjndmVjWeD7kn4uLcLCGv1G7vOsjJSPC7hK3RwOm/hFzS+ELYamAkq+2V2sC9GFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068021; c=relaxed/simple;
	bh=oBbi2dwj3JlrxNgNY8Hz815kTsf3eBPKfewu1okkeYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNHiAh9/+ssC5zDj/Y88aMjauELT/s3kcZfCYMJHAyHDH2bf3VfNu1hmiOO82blPpKRl1ZcvGjGgqs0pY6hJapxM9wTh6Y8HXelL5bkMtN517tem/t5ylhctZSqJEbm9ozAsnsF01Z+vQQEmmLTjGnpuwRL3/KvS5Un5aORqNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oxeeR58i; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96cdeb5c-dd55-4800-9046-09ebbb818e8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752068006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBCmCKP8OFqBTk3+dFLXu6PLZZQVW5qJrW4VdVurS6A=;
	b=oxeeR58i97heGcVCJSXRS5kIf0ZoWpaKVFuA1xKOPE+tM0xYffXEnHqt78071Q38yjPNko
	Y4QRgF2X96dBafUfFZFFomZzR2RN8iTojzn16xNJ2BGFlpZdo3QQlSlTAnAQukTkr/bWSZ
	vBhyC3OI7QXek+HvuxOrQSuPL9B5Xfo=
Date: Wed, 9 Jul 2025 14:33:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 7/7] net: dsa: microchip: Disable PTP function
 of KSZ8463
To: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250709003234.50088-1-Tristram.Ha@microchip.com>
 <20250709003234.50088-8-Tristram.Ha@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250709003234.50088-8-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/07/2025 01:32, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The PTP function of KSZ8463 is on by default.  However, its proprietary
> way of storing timestamp directly in a reserved field inside the PTP
> message header is not suitable for use with the current Linux PTP stack
> implementation.  It is necessary to disable the PTP function to not
> interfere the normal operation of the MAC.

Could you please explain the "proprietary way of storing timestamps"?
Maybe you can provide some examples of headers with timestamps?

