Return-Path: <netdev+bounces-80471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B0E87EF50
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 18:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B06281DA0
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906055C2B;
	Mon, 18 Mar 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lynne.ee header.i=@lynne.ee header.b="JUBwSPJs"
X-Original-To: netdev@vger.kernel.org
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019F55C07
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.3.6.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784698; cv=none; b=Z9epKYFxdWAcj85cN803RQKvXXUSBhq35hQpz8hmUwCOcywPhvAZtFiTq0qElYuv9JIfA7vp6ACAoI9Goa/tDHUKGv70egbUv79FPNfvjUl2/YHr7SfuPTDsH92JNIjH43F52kTV/DYcp+oaz8UwTIj0YbW07VQEOYeXzcVE/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784698; c=relaxed/simple;
	bh=BozJnYrBkjqHICJFMZVYfh7cFw/AHonryra8lQWiM3s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QOtFIwF3J7uHuQrpXzNF6fG348EA7bBe5PX0KFmwGGfo2svMYdwOUhEZi/viLJCJCXBB+wxudmKtw7FIDbMHxLXKeJG33Fe269h/HqdedJ2CPiN4JgRWIIb4q/dWmD+ZF9pQnyEM++32pjwtxOyeZrG9mULbiwBcb0e6BqV91Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lynne.ee; spf=pass smtp.mailfrom=lynne.ee; dkim=pass (2048-bit key) header.d=lynne.ee header.i=@lynne.ee header.b=JUBwSPJs; arc=none smtp.client-ip=81.3.6.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lynne.ee
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lynne.ee
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id C867710602E7;
	Mon, 18 Mar 2024 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1710784690;
	s=s1; d=lynne.ee;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=BozJnYrBkjqHICJFMZVYfh7cFw/AHonryra8lQWiM3s=;
	b=JUBwSPJsxT86n0OhW4NjRg3SrrDA/hu0vgZrx4TlREJukHlF9FhGICgfirvOIP8b
	DZFNBGaR91y2qedmCLDjWw4QBhUmJsclwKlHnXLUyJAQ3hYOkFjDYQ4OrhkUSw2HE31
	vyKKj2lDLXkND97bRXkxN1g2wNn48twHjY0p9dApzg6aJ/mYXjNz1dPNcIcdh0CuG0I
	vFYRM6Bhpk6P2N8JxRsEVzsnjh7EJdLA7lm/tXgkGTrFRR7KFUQ52q8okEEDy1k9d1L
	oc+3UrwFiuFGMqmHMOrNLWV3/2SM4EzrxTtw+PKWF8jpyAZDRMoHuMJtzBy5Nucuf6B
	WmHvOMymhQ==
Date: Mon, 18 Mar 2024 18:58:10 +0100 (CET)
From: Lynne <dev@lynne.ee>
To: Florian Westphal <fw@strlen.de>
Cc: Netdev <netdev@vger.kernel.org>, Kuniyu <kuniyu@amazon.com>,
	Willemdebruijn Kernel <willemdebruijn.kernel@gmail.com>
Message-ID: <NtHhf_6--3-9@lynne.ee>
In-Reply-To: <ZfhLUb_b_szay3GG@strlen.de>
References: <Nt8pHPQ--B-9@lynne.ee> <ZfhLUb_b_szay3GG@strlen.de>
Subject: Re: Regarding UDP-Lite deprecation and removal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Mar 18, 2024, 14:18 by fw@strlen.de:

> Lynne <dev@lynne.ee> wrote:
>
>> UDP-Lite was scheduled to be removed in 2025 in commit
>> be28c14ac8bbe1ff due to a lack of real-world users, and
>> a long-outstanding security bug being left undiscovered.
>>
>> I would like to open a discussion to perhaps either avoid this,
>> or delay it, conditionally.
>>
>
> Is there any evidence UDP-Lite works in practice?
>
> I am not aware of any HW that will peek into L3/L4 payload to figure out
> that the 'udplite' payload should be passed up even though it has bad csum.
>
> So, AFAIU L2 FCS/CRC essentially renders entire 'partial csum' premise moot,
> stack will never receive udplite frames that are damaged.
>
> Did things change?
>

I do somehow get CRC errors past the Ethernet layer on consumer rtl cards,
by default, with no ethtool changes, so maybe things did change.

I haven't sacrificed a good cable yet to get a definitive proof.
The cargo-culted way to be sure is to enable rx-all.

