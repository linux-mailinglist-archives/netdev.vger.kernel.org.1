Return-Path: <netdev+bounces-69009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2888491FD
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 01:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E8E1F219A2
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 00:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA707F;
	Mon,  5 Feb 2024 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kfw724OM"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25F623
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707091721; cv=none; b=QaT1U+BIOD1JobAognchTNxgTpqBmc1IfGByFSbi8bHHiWxqo/WVfnMsOvuLH1Og1DPTPaXMXOPYQsdluNP+2rrFCKoJCDktCuJpqojgxYqJVU0FxHedA+gjUjQmFSfCrvrcKFBGpjzD790LefziRCXC9+nXYEV53u2jY28JXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707091721; c=relaxed/simple;
	bh=kKF1Y8EZL+egsSbRmRpOHExkAlTFonkwwk+I3HcnMFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TEMYO3lfLtJGjYTYW6oNITk5uYS30ua4qIHjQiTZop0BItaKd7jbY4WFHrv1Ba6oSlPJgA5r6BKF8jouMAgkQKWH0t7GR4NLhSa5OKqUa26pzB3QdPeEBjJh7eYmstSztdK7zNx5UyhgAPpbCm6Owe7A7uHw9+fF1oOPRi5Fl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kfw724OM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=G//NWa802q3a6BTcq3lzQ7q7yHHK/IA7lueu2VXK8SE=; b=Kfw724OMxbUu1IpZ2jUetc0TeD
	sbmvemjtL8oMzoL+xlCT5HhoIsXHS5iU0KMiN1DY5t+7EOX3jr/3aVA1aEcoS30V8pgZ/9kaPPFlD
	CQ/suxJmBzgDJp60RerzdBAv4hQlfqFusnSIjvZbTMgBu0iF/G7pjJvXGP+ZP9CKtGSGFzJl9aZRR
	w/bRxqao+ZzifB0BcYEZla5e4ywDASiiGmrDCTv12WQFdrVuz4Wzt0gUfNEX508Hcx4v/BNAY1Akr
	oXJLgwAkg/eMrkok/NFjfMdZF/W1t4mHQxDffoPZ61ZoTBZaSZLNodrwurQKIBkmWXhsYKh7+XBle
	3MVAt9BQ==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.6])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWmXI-00000007uu9-1LeH;
	Mon, 05 Feb 2024 00:08:34 +0000
Message-ID: <0c581c16-85c5-40c9-9f44-5fa7c39ceeed@infradead.org>
Date: Mon, 5 Feb 2024 09:08:29 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ps3/gelic: Fix SKB allocation
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, sambat goson <sombat3960@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <1f5ffc7d-4b2e-4f07-bc7e-97d49ccff28c@infradead.org>
 <757018c2d9bd235cd2dad4363fb9a54354c9a372.camel@redhat.com>
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <757018c2d9bd235cd2dad4363fb9a54354c9a372.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 1/30/24 21:37, Paolo Abeni wrote:
> Hi,
> 
> On Fri, 2024-01-26 at 18:25 +0900, Geoff Levand wrote:
>> Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
>> of 6.8-rc1 did not set up the ps3 gelic network SKB's correctly,
>> resulting in a kernel panic.
>>     
>> This fix changes the way the napi buffer and corresponding SKB are
>> allocated and managed.
>>     
>> Reported-by: sambat goson <sombat3960@gmail.com>
>> Fixes: 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
>> Signed-off-by: Geoff Levand <geoff@infradead.org>
> 
> The patch overall looks correct to me, but there are a few formal
> issues worthy to be addressed, see below.

Thanks for the review.  I'll send out an updated patch sometime soon.

-Geoff



