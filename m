Return-Path: <netdev+bounces-189855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A89AB3EF7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EC686423F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D914E296D1A;
	Mon, 12 May 2025 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursu.me header.i=@ursu.me header.b="0iWEBcuI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tXI+SdUX"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8D248F49;
	Mon, 12 May 2025 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070736; cv=none; b=M0s8D594KctUUY1WcuzYX4ITo51Ed0y2MS4LR8fb1UyYrHAGDSPdidP9dtX4liSjAySdhGEItT/xNy0xJDFlQvJS8zY3iElCosAXAyaYXS2qs4WKw8b1Y0Ewq4gk9P+r3dhEyg6zbVk15r17O0pBBuqjx6DfGdmtQK2mniui0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070736; c=relaxed/simple;
	bh=TU3XShWd/3DQZ5w580PPlAAMZ0859W3f2Np5t6/nZWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieYJPlpfuKbbRFUOfpu0f5DPA8ttjfpKVM2AsokOZ7XcYE1TkvCK4lT+HQLqztvT8FFbVateppQfADO7SNRbOJF2yvC9fKAzckHSIqniPJX4Egj7+6jqEQV5SQyiSZedsiCBbWz2rWmmb2yYfxmxpH4dX3H1qS6t+hqCtamYbRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursu.me; spf=pass smtp.mailfrom=ursu.me; dkim=pass (2048-bit key) header.d=ursu.me header.i=@ursu.me header.b=0iWEBcuI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tXI+SdUX; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursu.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursu.me
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D47C114018A;
	Mon, 12 May 2025 13:25:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 12 May 2025 13:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ursu.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747070732;
	 x=1747157132; bh=QLAq7amBMiIEJFluFSAOTD34OZxX4AinB+6TsgCfDxs=; b=
	0iWEBcuIlBUVvcHVKw90RjcfFBz94oAukfZ57Et7Nlmcbw2WJCPVtpaDJmk8+jQE
	8Z01PMFvFP4DpNMjOIsjS+NHUAY63DxcFVl/jV05XDcvgM/DXPB6OuRUpwev+ky3
	cqYgdKyuKUZEK49T3e2dAyvX1jLMSf2yiZBswI+IlQaJU+akKkXJvwDMjGyvxvmU
	aTZd3w2o5AuD7uXmG55R87WI8fYl9Gbv1ZYxMcf7TBV4QsoYvmkkm7m5TliK2hHv
	i4X44Yl3f3ZttTGYEdSZAQezSVTaM3slkUntBvhAvsosYFHydCUpPKHhrqfKxSF2
	0otZyjyHAPMyfK4fGn55eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747070732; x=
	1747157132; bh=QLAq7amBMiIEJFluFSAOTD34OZxX4AinB+6TsgCfDxs=; b=t
	XI+SdUXIIg5ZrZNwkarOk1C+JeriTIfTe3oOUhpogHKUf39saWiF33xYD9zLpirx
	Z+OYtKaaRa9uZhOAIJsWYtWfGlbYQCPh/bk4JKzsgh/+ZAL0zJNRl5Ldgwk7/rvz
	fZ4jlOweURIXXY4a8280lGp61O2OF4QncdJAOe763PAp6/mlE3qLQ8NLPhcro4Ca
	KO0+/Xb+OULk4ALxZfIrStqq9z0VkKL1AI81P91mYLc4gPY5E+ZsXJd6uWe/dvC9
	ZSEqWylIrx1dShJ+f4NCJBhfRQCvp3TnV6QNJAAaxrRG8c/iZ6UWSoyniOPdjbpe
	bPk5k1XkYbbpFz7kVzq7g==
X-ME-Sender: <xms:DC8iaGcJ2-JCC-arFCKP5MFPHK_QqT94Q2Vcr4TalyHpXHGv0jYiUQ>
    <xme:DC8iaAOnn6bYWw9vIirHJG1inlYPO9y3ODyOVRcJR6BQ1jpFTTvyIQmOHTZ_GQTlY
    aXI1tHg2JPdqdOeHI8>
X-ME-Received: <xmr:DC8iaHgmK-qqWR1a2Epeac2Y6wLZN0zHMoDwOYANV-yA5lL7BJVnVwellMD3YmQ3WPOu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpegglhgrugcufgftufgfuceovhhlrggusehurhhsuhdrmhgvqeenuc
    ggtffrrghtthgvrhhnpefgudevueefveevleduvddvffeiheekkeffjefgveduudehjeet
    gfekhffhgffhhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvhhlrggusehurhhsuhdrmhgv
    pdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    grtggvkhesjhgrtggvkhhkrdhinhhfohdprhgtphhtthhopegrnhhthhhonhihrdhlrdhn
    ghhuhigvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehprhiivghmhihslhgrfidrkh
    hithhsiigvlhesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthgu
    vghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
    gvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepihhnthgvlhdqfihirhgvugdqlhgrnheslhhishht
    shdrohhsuhhoshhlrdhorhhg
X-ME-Proxy: <xmx:DC8iaD-dckSOs7O1aI732q0sIGe917V5FqGd-JQ6KDNU1ukGddcZAA>
    <xmx:DC8iaCtSa_LS5VlN7llDkqus8s4imA1tTMk-pDGOTWv4C9fwo60AEw>
    <xmx:DC8iaKE6Dy7DpEUpgXhbtFMEbsQMl-U_K1FGaLRSsuCwetFBwPvKwQ>
    <xmx:DC8iaBMuMmiONIg7I9mvtDBloVUo-Sp67VJFFQlpZj4El9tY9JwSRg>
    <xmx:DC8iaExoz0glxMkW1arWs-73jVb1kCkvpsb3z0tqLwaS6Dr_iJzHkhmJ>
Feedback-ID: i9ff147ff:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 13:25:29 -0400 (EDT)
Message-ID: <23bb365c-9d96-487f-84cc-2ca1235a97bb@ursu.me>
Date: Mon, 12 May 2025 20:25:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: disregard NVM checksum on tgp when valid checksum
 mask is not set
To: Jacek Kowalski <jacek@jacekk.info>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
Content-Language: en-US
From: Vlad URSU <vlad@ursu.me>
In-Reply-To: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.04.2025 10:43, Jacek Kowalski wrote:
> Some Dell Tiger Lake systems have incorrect NVM checksum. These also
> have a bitmask that indicates correct checksum set to "invalid".
> 
> Because it is impossible to determine whether the NVM write would finish
> correctly or hang (see https://bugzilla.kernel.org/show_bug.cgi?id=213667)
> it makes sense to skip the validation completely under these conditions.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM 
> checksum")
> Cc: stable@vger.kernel.org
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c 
> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 364378133526..df4e7d781cb1 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -4274,6 +4274,8 @@ static s32 
> e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
>               ret_val = e1000e_update_nvm_checksum(hw);
>               if (ret_val)
>                   return ret_val;
> +        } else if (hw->mac.type == e1000_pch_tgp) {
> +            return 0;
>           }
>       }
> 

This patch doesn't work for me on an Optiplex 5090 Micro (i5-10500T). I 
did some debugging and the platform is recognized as Tiger Lake, by the 
driver, but the checksum valid bit is set even though the checksum is 
not valid.

The network controller works fine if I patch out the validation in 
netdev.c. The checksum word at address 0x7e read using ethtool is 0xffff.

I'm also a bit confused about why the driver reports the mac type as 
e1000_pch_tgp even though i5-10500T should be Comet Lake?

