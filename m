Return-Path: <netdev+bounces-227961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3815BBE199
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6AF34E447A
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B5E1EC01B;
	Mon,  6 Oct 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjAcDW8X"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3D199237
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755335; cv=none; b=YiZ2AMHBjEp6ej1bDhmF4nhWgkorqGGb84iaeQhkt9gbh6LuZmA71xunbEOsTwgQPjeNQIbRHy4R8l7iMDXM/9ZGVlQGvPw0p1HAqrRa4sY3eOWP+PkQyJspJN9NOcjrgB1ctY6nntP3iwGWlbYnZOu5/RR0BUgB7k/CYkfKjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755335; c=relaxed/simple;
	bh=K+DTEbaga8u67QDTCN1KtKkJg4l3lW06F/m1RcQHKV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjXDKZPiWGPpQl65OGxR5Ekv4PoGFZ4qYCmHanjIT7L4BFujiDnF3T2VlnVH1o65rfCpxeJ+o0Pxxc79a87igEyaWilmX8k5bF3s45R/QHEmqWKKJIzoeEYqbvD9mMSNW2bW8nWVBu8C4w1lLrKRoOykdrwXByBOOt9yKHS8KW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kjAcDW8X; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea0c839e-d0a7-450d-abd7-0a787804b415@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759755330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOT2f+EOgnxJglkhi0yG44lmilb8ArnG4GdJrsCBkGM=;
	b=kjAcDW8Xrf7XfBc9w2/U+YgBkeYoI+EqQ0b/IZL6p1WE3RCRDyJZTVa4LwUfO0tg+W+0Sp
	z36skjmvquJG/YtsLoSY5KOSH/LBB+/g4ame0vzWVJbN7uJ6jONpgOimpH0sSyDH8VK8Mn
	MLQGlmJpZYdNQmAXMnBFpk5U0Ry9fg4=
Date: Mon, 6 Oct 2025 13:55:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: mkubecek@suse.cz, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
 <20251006144512.003d4d13@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251006144512.003d4d13@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/10/2025 13:45, Kory Maincent wrote:
> On Sat,  4 Oct 2025 20:27:15 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
>> The kernel supports configuring HW time stamping modes via netlink
>> messages, but previous implementation added support for HW time stamping
>> source configuration. Add support to configure TX/RX time stamping.
> 
> For the information, I didn't add this support because it kind of conflict with
> ptp4l which is already configuring this. So if you set it with ethtool, running
> ptp4l will change it. I am not really a PTP user so maybe I missed cases where
> we need these hwtstamp config change without using ptp4l.

Well, it's more about ability to configure HW time stamping by users.
Running software will potentially change the configuration anyways, but
it maybe helpful to test different HW configurations without changing
the software itself.



