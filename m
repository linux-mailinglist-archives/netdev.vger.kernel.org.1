Return-Path: <netdev+bounces-101493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AC48FF0FB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C827828DD6A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B11197533;
	Thu,  6 Jun 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="j+2+QVzm"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2319750F
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688639; cv=none; b=Prt3vosJUCGOIhVbwFPK8EayHhzCqz0xqicaAy+BzKQgwOa2yZIZo5jjZ7VWI4AcAkvrdnKeta14S054mFbLWC0pIG1di8vTehVK2dpnykQ3e1DmlNZAy/kmvN/XS20USnI9LiSr/ewZZvbfD5ZLvVtriwS+rslmiWr4nHM3Pv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688639; c=relaxed/simple;
	bh=g0ka9Yi/6e35bQZKWyOqyvyBXHQ2ygEVahWRGWso0iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTacPQpN3Iw+RfiikDnVk3csl9I3iGBJOG7SIMl97ymDpwox54P2mvp8vPmBO9MzQF9N7tkf4OThdrTvLAf3RwGBRx+O3+6AzAKfJDnkzFKvZq8BigVUaHml7M1mpmHRUxS5h+fOvt3TDx4W7+kMMHDq2gwA4GZKfT43KBFhbKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=j+2+QVzm; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240606154348905c7a29ceacaf895a
        for <netdev@vger.kernel.org>;
        Thu, 06 Jun 2024 17:43:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XbyzhJfWKUAGEPA2NhfvVHDBuogfHdsp7Gu4BWpi/40=;
 b=j+2+QVzm+DUQAZjogAWHPmpQJ35666hy5aZvOS81p+XlGSKsKVHWqUzLPctRbPsIO7gu9b
 pTlpOFV5CHZIOsF9ujIu2k3nHGbo/n/91brnCBbT4fM9/pnXhpwN+2vmoK+FguvlN2n5opyH
 3r6LVsXKFRuyllnM/9M0hdNhoZLJg=;
Message-ID: <852e7697-449c-49ea-9d83-d166fd235ff1@siemens.com>
Date: Thu, 6 Jun 2024 16:43:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/3] net: ti: icss-iep: Enable compare events
To: Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>,
 Roger Quadros <rogerq@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
 <20240604-iep-v2-2-ea8e1c0a5686@siemens.com>
 <c518f6dd6cf9e92469d37a7317a6881ebed6a8c1.camel@redhat.com>
 <a08ff9c7-eac7-409e-8f22-5ad1fa0cf212@siemens.com>
 <c0de46a0bd15350620d5d611f07cf87b2a223d27.camel@redhat.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <c0de46a0bd15350620d5d611f07cf87b2a223d27.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

On 6/6/24 2:49 PM, Paolo Abeni wrote:
> On Thu, 2024-06-06 at 14:28 +0100, Diogo Ivo wrote:
>> With this said it should be possible to change this spinlock to a mutex as
>> well, since all the possibilities for concurrency happen outside of
>> interrupt context. I can add a patch to this series doing that if you
>> agree with my reasoning above and find it beneficial. For this some
>> comments from TI would also be good to have in case I missed something
>> or there is some other factor that I am not aware of.
> 
> It looks like that most critical section protected by iep->irq_lock are
> already under ptp_clk_mutex protection. AFAICS all except the one
> introduced by this patch.
> 
> If so, you could acquire such mutex even in icss_iep_cap_cmp_work() and
> completely remove iep->irq_lock.

That is a much better approach, I'll do that and post v3.

Best regards,
Diogo

