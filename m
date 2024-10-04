Return-Path: <netdev+bounces-132199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F6E990F57
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CF91F2041C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FE61F12EF;
	Fri,  4 Oct 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB3h5YCY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0861B4F01;
	Fri,  4 Oct 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067808; cv=none; b=onN32hshsRjAIoct/7be5whg/sBVEEpUAQ1gmR1rTptDa3VfIgYvkzpZWuOeOrSaIQFdLwLQUmBVDc5KDsog4zyeHrQj3kZfwwE160zrq5KhD6woawm+ZHXuo4Wqntn0cyEw3Rn5/qdxAZyAXeWN7B7A0A+lACoFZc8vrOnbJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067808; c=relaxed/simple;
	bh=pQXvHBk79PFMnwPgLPjz5lxr0ATrcQdMzpCo6/c830A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwGOtp9LVMlU1FY3liv7KchbQ5paBKHCkvFGkw8znjLrtxDGbaVPuqwQyv3qVtxPpdCVttcs52kkz4TOmJUhqWqCm2ZVLzYZyFowGHjgW7qJEK9IiSPn8oEXcBUXQy1rRW1BNBir+yTcDyLKPiOiNYYxD8t7cgpkGn3i0i41mPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB3h5YCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9784FC4CEC6;
	Fri,  4 Oct 2024 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728067808;
	bh=pQXvHBk79PFMnwPgLPjz5lxr0ATrcQdMzpCo6/c830A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LB3h5YCYxsrhdnwQx06B/2bf73BxW7CvdQ9/JSycq+2gAlfYwyiMWtm3fc1yTyINd
	 j8xoK0O4UP/PDiavo806+FgvASW7ri4iFNEtN+JDutH9h+sJgjLDkfcuLXfBBIinfQ
	 Uday7JjQi7WBi2yHnkbpQKM5HZg8O8Wi4BL3T1U4ZqeUkGyLlAXX+kR1Tt6ahl9+Ln
	 FzO21RgfktoyPzPOH15+cyDay7NN29PnRwIPybssXIhUUrUA9VUOc0Mq1Q9M9+fihL
	 oPfvMsTZhmL3kQ0ypZqwaiStgcpONzZyFbrTocW4Qz2A3RVwnMzF0apVLmJMTanVP8
	 8fVzI9jMeNeNQ==
Date: Fri, 4 Oct 2024 11:50:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <ramon.nordin.rodriguez@ferroamp.se>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
 <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v3 2/7] net: phy: microchip_t1s: update new
 initial settings for LAN865X Rev.B0
Message-ID: <20241004115006.4876eed1@kernel.org>
In-Reply-To: <20241001123734.1667581-3-parthiban.veerasooran@microchip.com>
References: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
	<20241001123734.1667581-3-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 18:07:29 +0530 Parthiban Veerasooran wrote:
> +	cfg_results[0] = FIELD_PREP(GENMASK(15, 10), (9 + offsets[0]) & 0x3F) |
> +			 FIELD_PREP(GENMASK(15, 4), (14 + offsets[0]) & 0x3F) |
> +			 0x03;
> +	cfg_results[1] = FIELD_PREP(GENMASK(15, 10), (40 + offsets[1]) & 0x3F);

It's really strange to OR together FIELD_PREP()s with overlapping
fields. What's going on here? 15:10 and 15:4 ranges overlap, then
there is 0x3 hardcoded, with no fields size definition.
Could you clarify and preferably name as many of the constants 
as possible?

Also why are you masking the result of the sum with 0x3f?
Can the result not fit? Is that safe or should we error out?

> +		ret &= GENMASK(4, 0);
? 		if (ret & BIT(4))

GENMASK() is nice but naming the fields would be even nicer..
What's 3:0, what's 4:4 ?
-- 
pw-bot: cr

