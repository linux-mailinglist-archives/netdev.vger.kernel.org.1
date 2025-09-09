Return-Path: <netdev+bounces-221471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384A2B50942
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD55C3A6586
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B27285C97;
	Tue,  9 Sep 2025 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZH3Qwg/"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76542B9B9
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460774; cv=none; b=YZseif6dcxn15OGd9xn01f5qDPhS4mr8uYuDUUhNkrm+1GfUbvDikpJe9i0fu+SHEDrwcnKBiQi4+C0nHaiCXD4IrhVlo/Yr849rNKlta88k61RaRrXJblN5DXYio3Y7xP8XBMQ0TjRSYPYB6matEfV+ByC3yaPV2WwebMs9758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460774; c=relaxed/simple;
	bh=odeOkuCy1KxV6mYOoSEY9TUR80sCkmV8XqnOaVz5Njs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZChmeviYI2TFkaBfN3Aq30hQlodGQ62DAoSJCg+Vlo0M3L3853IPrJ9E0K6xdXOWcnoYoUUcbk5jF7u1+M7zmuzb4YF6+68xTOkjHVV8Jg4AUaTXvrVlkj1jq+6A2C0cSdtB1XPFJnINS026vxHgZe98gHGYY++qTWoo62sxehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZH3Qwg/; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <77c56b22-b1dd-4a54-8e8a-bd6f91fa7820@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757460770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41ei3B/NYirFEJgfOfrPBVj1WwF64WgjeU+Texq4EwA=;
	b=hZH3Qwg/ceI0fv5K9LozlidClZbWcaj5umlv80M3Pf9suGlkIFo5KEDDICYFUqGAK8bGiF
	RsrtP+DQPHIJ1abH7oT9rhnz2aEvGhUYLdTd8021x99wFHBziumLQl2K45VLiph6MZv+i9
	NdgDdZLPYt7i5t51tqQXhmPK9W6FNZw=
Date: Wed, 10 Sep 2025 00:32:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/4] net: dsa: mv88e6xxx: remove
 chip->trig_config
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
References: <aMBLorDdDmIn1gDP@shell.armlinux.org.uk>
 <E1uw0Xf-00000004IO6-0l5Y@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <E1uw0Xf-00000004IO6-0l5Y@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/09/2025 16:45, Russell King (Oracle) wrote:
> chip->trig_config is never written, and thus takes the value zero.
> Remove this struct member and its single reader.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

