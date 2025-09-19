Return-Path: <netdev+bounces-224756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F3B89470
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 13:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C23587F8A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38F2D94BD;
	Fri, 19 Sep 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AQaqFMRp"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FB2264D5
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281389; cv=none; b=eXmfn0Xo+5pQMx1MMYucZt85L94chtwj7m+UkSJ4gfbsdaH7KAh4z8AKYeG5oySu3mvKV5RGckmBRSA1WzffklUArasaFn6sRlCqD/ejhtOYCvfIX2c+ZG/GJ7430RiuDrafwSPkPKkW6wkTtkgQD0xawfNgrvis/aPB/J2/Ihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281389; c=relaxed/simple;
	bh=RbLyeXp4tCg2b+21ZTvoUe7KGecGgi9aM3+Ar0F19iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3TNncEY68x120USeCGjPBYfKawRUJucilF0JCJVUbwiY3xKpaMEj8eLP+hSa1w9/r6wZ41QnG7TBmIuzw42E82y0dmGgW5hT3vBUf8hQwhbRmBhmpczAQIuChTTqw3rimjjDa36vmz1ZeE1M/MOVkzKaXn6J7WlkkaYC6nB5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AQaqFMRp; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a3c0715-73be-472c-8a6a-1940c75f9d53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758281385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbLyeXp4tCg2b+21ZTvoUe7KGecGgi9aM3+Ar0F19iA=;
	b=AQaqFMRppprXMXolPq8A+SO9bYn/GxpokfGw6zS0yX5O2ATwTkat2ncSAc1gdkv64GZG0E
	EioVP9cPrtSiBVykcvBdkqOdv0wOVO6t8I9pNJ5T3ortCgp0Enc9z5C8KYP8tYwoAW7Qsa
	JjwpFIzxsv/qsnCArOrT3Kx52UdP2pg=
Date: Fri, 19 Sep 2025 12:29:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC net-next 10/20] net: dsa: mv88e6xxx: only support
 EXTTS for pins
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIbf-00000006n00-06XG@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <E1uzIbf-00000006n00-06XG@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/09/2025 18:39, Russell King (Oracle) wrote:
> The sole implementation for the PTP verify/enable methods only supports
> the EXTTS function. Move these checks into mv88e6xxx_ptp_verify() and
> mv88e6xxx_ptp_enable(), renaming the ptp_enable() method to
> ptp_enable_extts().

It would be great to add .supported_extts_flags as well to allow
PTP_EXTTS_REQUEST2, take a look at changes in:
https://lore.kernel.org/netdev/20250919103928.3ab57aa2@kmaincent-XPS-13-7390/T/#m579d718f36b2368e476eb400e235fe28f0bd03ff

