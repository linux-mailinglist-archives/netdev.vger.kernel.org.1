Return-Path: <netdev+bounces-200799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D341FAE6EEF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BEB7A3C72
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6962DAFCB;
	Tue, 24 Jun 2025 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursu.me header.i=@ursu.me header.b="kf982Q6P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BtJZfkQb"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FD1BEF7E;
	Tue, 24 Jun 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791266; cv=none; b=SIVhNwQgaKbUzSk/NxtMT+9qASfyud7LtVykJ/6w1oH9NADydPysc8CJeno2MiGAaXHuLdU3DUx47NGZrab2fbuWj1YunnIc/3iprKQMWNZmp4DyFJRX+MECmlIdQDdYJjJ4WqCt4k9crID+sgAi45n0XAVvI/DFYNVvauwoc6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791266; c=relaxed/simple;
	bh=NCb22LhO5XC64kFAzLnTRrocrXYfGuHb0ZMV8tHjSXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph6rThhWEp2G/HzLsoep+t7BOvn4YBiN3tWC3I63PRZpMyOm9RFg6ONTGoZkj+6RtkGqNCQtRg2s19BZcvRqOcA5PAJvyJJE63a5vedlisMalAw4+glDq5ZvDZ4Yk8ZYeFfcU35Ew+D4exQeKJ2jlxvaATMP1wDnHytQbU5Yj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursu.me; spf=pass smtp.mailfrom=ursu.me; dkim=pass (2048-bit key) header.d=ursu.me header.i=@ursu.me header.b=kf982Q6P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BtJZfkQb; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursu.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursu.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B06F57A0170;
	Tue, 24 Jun 2025 14:54:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 14:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ursu.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750791263;
	 x=1750877663; bh=r4ovMX0anPN+WiNz0S85LAe+51KjLkJjPDDy5vLdsmY=; b=
	kf982Q6PME2m9SzGt1Rx8SMrIS3BlRmSpFJsIYda7lu7mgUJsRZpdHC4PIM2oCnd
	r9stmmCo9ur4VJC99O8ZATZSjjUGwIDDZpyar+GsabCk208EgkwwRltBhWhxXxfp
	VveHJWRMG/X6H5/RFAwfynl2585OAt3jZ0gaoYKdjg9vc7SJ7tFxRX4rbowZ/Uyy
	rlerk2NEO14IYPjTsa4lKgvQgpoG02vTRHdphbTUQo9uguDeb7XwWOJsvG+wFLYM
	QD/h9/k8mEVRmJAYyUyArT/bEJcjFmskK2HJrrGv6AwDyeRp1GaVNHojAikENQCD
	yl+jJnptcoK77Aff2aMveQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750791263; x=
	1750877663; bh=r4ovMX0anPN+WiNz0S85LAe+51KjLkJjPDDy5vLdsmY=; b=B
	tJZfkQbNerPtueO5Yp+NvVTLhyqOLr9oU6CkrEMuDjeZQi9W4FZkVbONP84I0lzt
	YquDqmpkmcm/NkcDm/6xdoyljqCW3KXlkNKJzNXYMryMOgNMnaWfPjCJUo30MbAs
	29Uy3Uxq+fGMHqs5elIBx1BfYqo5d86ah57g91WVSpOCZ3iaNxnJjJAYPTulfa64
	O9UWLFHQQu80k0/48BTNbmg1MH6hgnmiVdi7NMtTxF8T7f99/1UhntXf/r6hMSFV
	VUDvu1Bcvp8AcMVjEX3RrTsVyuj+T9JMaZ49byngu+lUU9x9J/vLjPyZY6fs+vq6
	dGKtvJ10n0w3mbS+4082Q==
X-ME-Sender: <xms:XvRaaBZGC5nE5Qc_REb8OYYa0-quUOUUWeP8LKO3OKJLULpONqNYJQ>
    <xme:XvRaaIa3AkP0DW0mp7kjhwadKCpG7X6xlTla1JXbe4ct8zO6cyxGzWaowoHKjPsoC
    GXwGy3M5RjNdB0-EEE>
X-ME-Received: <xmr:XvRaaD_g8lMY1TLaLj3-BI0cPApDoF_imlJmFNfN1cUsFKupJw-fxLUUf0bz9AVdoi4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepgghlrgguucgf
    tffufgcuoehvlhgrugesuhhrshhurdhmvgeqnecuggftrfgrthhtvghrnhepteehfeduge
    elleffgfduffevffdvhfevteevleefteetjedtiedvudevheduheffnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvhhlrggusehurhhsuhdrmh
    gvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jhgrtggvkhesjhgrtggvkhhkrdhinhhfohdprhgtphhtthhopegrnhhthhhonhihrdhlrd
    hnghhuhigvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehprhiivghmhihslhgrfidr
    khhithhsiigvlhesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvth
    guvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepihhnthgvlhdqfihirhgvugdqlhgrnheslhhish
    htshdrohhsuhhoshhlrdhorhhg
X-ME-Proxy: <xmx:XvRaaPqA2ZR_wKuYWUc9L_fvLGIWIJ1uQBaOgFmZVaVi4pCXysAYpw>
    <xmx:XvRaaMpKOLldltRfgeqxmNAZ8nXCHmo6Lj8mu4ny1j6osOik8my6Cg>
    <xmx:XvRaaFTwRw8HINhciiTvAupDKDUV33dUbR0Y208pDgMiTwprmZfqDg>
    <xmx:XvRaaEpdmvsS9sqc74zIPWbD7Lq2Va3jOXDt4DYN3vGBVcZjRbAASA>
    <xmx:X_RaaCfLsZ5JyT2WTI2sM4JS9kdhf_7RPZlpb-UYc3ILMC33BecwsQdk>
Feedback-ID: i9ff147ff:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 14:54:20 -0400 (EDT)
Message-ID: <5dbd4c98-f161-4f91-aacd-08ab2b7f155c@ursu.me>
Date: Tue, 24 Jun 2025 21:54:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
To: Jacek Kowalski <jacek@jacekk.info>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
 <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>
 <8538df94-8ce3-422d-a360-dd917c7e153a@jacekk.info>
 <431c1aaa-304d-4291-97f8-c092a6bee884@ursu.me>
 <e4903c9f-6b84-4831-8530-40ff6e27a367@jacekk.info>
Content-Language: en-US
From: Vlad URSU <vlad@ursu.me>
In-Reply-To: <e4903c9f-6b84-4831-8530-40ff6e27a367@jacekk.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.06.2025 21:34, Jacek Kowalski wrote:

> You are right that I'm comparing the wrong value. But it is only a 
> matter of variable name:

Ah, yes, you're right. I missed the fact that nvm_data will hold the 
checksum word at the end of the for loop.

> -    if (hw->mac.type == e1000_pch_tgp && checksum ==
> (u16)NVM_SUM_FACTORY_DEFAULT) {
> +    if (hw->mac.type == e1000_pch_tgp && nvm_data ==
> (u16)NVM_SUM_FACTORY_DEFAULT) {
> 
> Could you check my change with this modification?

It works with this change.

