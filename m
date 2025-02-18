Return-Path: <netdev+bounces-167321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD9A39C16
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22257A48AF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE81243368;
	Tue, 18 Feb 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="LYnOnoVz"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DAB2417F5
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881513; cv=none; b=knwU+WBNFTmzqW+UzOio1PEEoQ0DeqaI3FwrRbLl8XNwf9tIP2TsDpTE9fWHZY+B4coKSr8amZ50C0QSKDKBrqnqKtJbBOl9UwGr79JbLDbJqyYDFTpo0ClzV3dsskNPagTSTD1v+CoCNdzjEWObijURJE8cRfO/KCU/3niswa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881513; c=relaxed/simple;
	bh=YhCOzDgUX6Ndgo3HStvHEdN3KMsN1P0sllHKIUBhUIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4c8aiGdXtcDwan3eG7at1S06aPltOrLVsYqCJ79VprvcG6lzzwgVdJPomM8g8j1iQkT1JDhUdFjVmwXprfuREtCH8ha1UmjjUyWuT+Yk+PZzyzAHiq266eGknQk5R7IGxvbIx8t4zMQnJEPIjjS2Rh8F0v8rNVg6VbKbTZl1U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=LYnOnoVz; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202502181225034c22b9853c063b3d94
        for <netdev@vger.kernel.org>;
        Tue, 18 Feb 2025 13:25:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=G2Mmqb1Mk7iE4u/cA5jv4vjZ4vx0m26FAwwSyjZdlAQ=;
 b=LYnOnoVzgyvt12BzEBe4VCAtllZyzgApaONlStzl87LQ29SrPPal3so2Kv7HmCgq4Ld9S7
 4JEn/o4WmOcWz+1JMdwklNEOfmMGoLAEo0dAXatefHPXGhGsjnkKkJwuGIsgGd55oQKOGXRC
 RQm6nZI5WWfQBog8RYiB8xQ8xaXWnR1aNkCA/4UKRLB7xWOVrYVerS8q3NSW93NU2X97sB9+
 mcf1JZorJoE2dRh9W2+YgEea0iz23kjFC4C/IuOyhvRyKzjQxNQ8UBlqQDSaSBuVP+umSias
 BDTLqrMQfDqhz26QVFYf9tFU4sJqmeozUU5VMjiYWgCqPol3D0wtN8Kg==;
Message-ID: <c8bdd93d-5690-4b8a-819f-853756b57a71@siemens.com>
Date: Tue, 18 Feb 2025 12:24:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/3] net: ti: icssg-prueth: Use page_pool API
 for RX buffer allocation
To: "Malladi, Meghana" <m-malladi@ti.com>, Roger Quadros <rogerq@kernel.org>,
 danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 u.kleine-koenig@baylibre.com, krzysztof.kozlowski@linaro.org,
 dan.carpenter@linaro.org, schnelle@linux.ibm.com, glaroque@baylibre.com,
 rdunlap@infradead.org, jan.kiszka@siemens.com, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, diogo.ivo@siemens.com
References: <20250210103352.541052-1-m-malladi@ti.com>
 <20250210103352.541052-2-m-malladi@ti.com>
 <152b032e-fcd9-4d49-8154-92a475c0670c@kernel.org>
 <615a2e1f-5ee5-4d80-a499-8ff06596a2fc@ti.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <615a2e1f-5ee5-4d80-a499-8ff06596a2fc@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Hi Meghana,

On 2/18/25 10:10 AM, Malladi, Meghana wrote:
> On 2/12/2025 7:26 PM, Roger Quadros wrote:
>> Can we get rid of SKB entirely from the management channel code?
>> The packet received on this channel is never passed to user space so
>> I don't see why SKB is required.
>>
> 
> Yes I do agree with you on the fact the SKB here is not passed to the 
> network stack, hence this is redundant. But honestly I am not sure how 
> that can be done, because the callers of this function access skb->data
> from the skb which is returned and the same can't be done with page (how 
> to pass the same data using page?)
> Also as you are aware we are not currently supporting SR1 devices 
> anymore, hence I don't have any SR1 devices handy to test these changes 
> and ensure nothing is broken if I remove SKB entirely.

I have some SR1 devices available and would be happy to test these
proposed changes in case they are feasible.

Best regards,
Diogo

