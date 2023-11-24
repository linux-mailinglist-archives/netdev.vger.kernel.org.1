Return-Path: <netdev+bounces-50688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC617F6B2B
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 05:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D0D28168B
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 04:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9D138C;
	Fri, 24 Nov 2023 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFdG6NNO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60D15CC
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBC8C433CC;
	Fri, 24 Nov 2023 04:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700799200;
	bh=dp7kHQ3+JMKr6NRkdhsnqfV3qz2OpFPkbQP15wBMHaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HFdG6NNOvf/R4rw1sqTuW/kyke8Tn+BkggiZxgrGGwIeNWv9GkS1Z/79R2EX9gWgm
	 UxnH7+t2CTbRokhW6OFk2MqLNafCJ5dFzbqk/kQW5JcRcMAkGTS898bBsxRgtxQW/t
	 aWHFOo5iKpEg5NJmOqn5lwCGAsxf79rFTxJQRsKZW87lSA0dTd+L+bt0x/kXik9I5v
	 MXyxQSxTXJQ52PBMdk8E58hcCeYENjGjoCngVz87tDDu0qwxcNSqmFPL4L0551rtlS
	 IyqDGeKWPdFed2rm9ZrRapbOYLuTLZNBg/8Dj8L+PlHs3bKftbctHPcPWc/6/Z9vTp
	 rTiWsueonrzmA==
Message-ID: <0b00c969-8cbd-4ad3-a7c0-f5e30a70bcd4@kernel.org>
Date: Fri, 24 Nov 2023 14:13:15 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: dsa: mv88e6xxx: fix marvell 6350 switch probing
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: rmk+kernel@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20231122131944.2180408-1-gerg@kernel.org>
 <4d9ac446-5a01-4c97-bc1d-41feb2359cad@lunn.ch>
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <4d9ac446-5a01-4c97-bc1d-41feb2359cad@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/11/23 05:34, Andrew Lunn wrote:
>> The Marvell 88e6351 switch is a slightly improved version of the 6350,
>> but is mostly identical. It will also need the dedicated 6350 function,
>> so update its phylink_get_caps as well.
> 
> In chip.h we have:
> 
>          MV88E6XXX_FAMILY_6351,  /* 6171 6175 6350 6351 */
> 
> So please make the same change to the 6171 and 6175.

Will do. Given the family name is 6351 with this define I'll
make that the basename of the new get_caps that function too.

Regards
Greg


> This otherwise looks O.K.
> 
>      Andrew
> 
> ---
> pw-bot: cr

