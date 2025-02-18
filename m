Return-Path: <netdev+bounces-167401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 510C0A3A270
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781587A1637
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3214A1C3054;
	Tue, 18 Feb 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/1xu/wM"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A0C158A13
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895500; cv=none; b=TsHniOYM7riVfgnTa8H2EPrhzKxViXpcsCAcDjzRM7x0fSu/vDuO+3d3Vv9wWX2m9mxLjiataf2+6MBkdLLy5jAg8XfLt2CiNibCOgQJG4017y6NyZlQPanyngCH+h2J8ZoNOruppOKwt1AmgQz85k/Un1JduRI6QTjrYRtygyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895500; c=relaxed/simple;
	bh=Z7xCo6Os7CElV3/n1hsqRxtfI6J2UdkQe0H9AW2yIH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3I+oSRzn3nMVPv6wzbkjN+tF1OWiFA+eBUiFhT/gfUJMv57Zzm1dyLzKzaftR5sriQWWy0oNMP5MiLoUGb7QLcWKTXxgPUFg2/JF0uq6Bi9yYo1cTHd/btdiz90RGvxTA+3h2aEkpnX70B5klsgDajgoTHEHr4+GpL45WO2ZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/1xu/wM; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7446c987-3286-4b8a-a105-96443275d4d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739895496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwx1IfTKh1rDEZJZPwub8nyeYTYzilJEqxSN8ou+0bA=;
	b=E/1xu/wM2vYeLhBelvWB1ep+Erfy5NmqLoD18c34a+RTGqEMMLuJWDWww4FNlWeRqTnMvU
	FBrQAhQ35VNhqWo0A23fqx9r3saaVlbNJW68Y2I2ltIg0PFt4FQd1IhHYebD1qpHbXo9FX
	I/qF3/bQpYDcElBYNYFJpRqvhtYWFmc=
Date: Tue, 18 Feb 2025 11:18:12 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: xilinx: axienet: Implement BQL
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250214211252.2615573-1-sean.anderson@linux.dev>
 <BL3PR12MB6571A18DA9E284A301FF70FAC9F92@BL3PR12MB6571.namprd12.prod.outlook.com>
 <aa58373c-a4ac-4994-821b-40574e19be3d@linux.dev>
 <da67b82c-1068-41c8-93d6-df0e7b009e4a@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <da67b82c-1068-41c8-93d6-df0e7b009e4a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/18/25 11:16, Andrew Lunn wrote:
>> > Could you please check if BQL can be implemented for DMAengine flow?
>> 
>> I can have a look, but TBH I do not test the dma engine configuration since it is
>> so much slower.
> 
> It might actually benefit more from BQL if it is slower?

Actually, it will benefit less. The hardware is the same, so the
slowdown is entirely due to extra CPU overhead. From the CPU's
perspective, the queues actually drain faster than normal.

--Sean

