Return-Path: <netdev+bounces-194646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471BAACBB2D
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC804173449
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 18:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66514218EA2;
	Mon,  2 Jun 2025 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursu.me header.i=@ursu.me header.b="yW7n0enE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L3YVRy6/"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8833F7;
	Mon,  2 Jun 2025 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748889859; cv=none; b=UPGBqT4u26PxvPVlQI7PILVL1PUSXvA2yx4B2/d1JsB2yd3FFfmXI2+4xE+vmZ3OvTQClU/oi8Bg8v6gPHsUHxlxXSaySqPFd+elUptwQo6PjNxCMt8eqlznL6raHvYK/UdLtOGQShnNaUp8zCb01Sb1U/4vZtfbgbenCrEFic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748889859; c=relaxed/simple;
	bh=0/fOG8pYA02bHRc/ONtUI24TUIqdK818gSERz5gGdlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaMChUuu9eHHnx1sDkHWqw4hCJjdZgJJf5M+ftggZ0bk6u6J3o3Jj+adCiYl2WPv3CyiX3YMhNywfnaxSuCwCNWrw6YPSQ3stEt2T+neij0pnuVjkcvQVQlWMQwoXlTAqelJKV61ToR0bWmFA34cZrVb/2czrxNVvV/rLI2HkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursu.me; spf=pass smtp.mailfrom=ursu.me; dkim=pass (2048-bit key) header.d=ursu.me header.i=@ursu.me header.b=yW7n0enE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L3YVRy6/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursu.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursu.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1686F138034F;
	Mon,  2 Jun 2025 14:44:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Jun 2025 14:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ursu.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748889855;
	 x=1748976255; bh=B9nR3mXG/IvR4Y4wwhnqlP1ObVOVBHTQ+M/bA4GnImM=; b=
	yW7n0enEapi9VZE/EMHVzlcUeori2T2yv6ybZHvbjD5Xmhyr3O5Qk7SInVO5lSVH
	ZxfHuSKdU+BogV6S2GBDVhbe2bldE+jceonm8eU6p3NStJqAQ1MAtMdszJRq7E/T
	JCq9kmcRxPUVVSm8hJCRvBrEDfX+fg3XYg2rbgCWkbHqyD05jVlgRDqb4j0uSSPw
	6GQEgqHev4ricoTBlMVuzN9tP9QZvXlOsfbvOu8p/bEXKAO9w/qxMpsPPHwIN+j4
	3iZs6uYJb1mI4cUuFEjoHpqJQJrpMgBWoieyoX/nLXbrEdnOZOex2J3W6r2o1lS1
	Ac1OvyvctnQdCw0BZuzlfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748889855; x=
	1748976255; bh=B9nR3mXG/IvR4Y4wwhnqlP1ObVOVBHTQ+M/bA4GnImM=; b=L
	3YVRy6/dzihm5dVxHEIS1yY6MiPb5r5l0CFKdAnA+Ye58i1TNeBtYVm0thHiFoOF
	lmMX9m4DlLwUW7m+dHxZdE7YmZlC5O5INO2gfYkr/GvD34LBb8Oic6bjsUeyW9WA
	SW5h0ZN8KRAs14MDr1MeRXCCnc1uNIOYecore6XLoTB4MkIXydsCXz7cGzrjCw2Y
	AOhBVuWDXPktnYJj6C/zGrswo48APjwWZJ9j3hB3K6w/ftcm3HZe4D3FngDycpG6
	+cZLkglMNqxhBNMt94KLCNNOrj2yy7b3ltaMdYrT69IoD9T8oykFNRkLOz47pF5g
	56qXt4FchzeNpSvl8d3YQ==
X-ME-Sender: <xms:_vA9aNtR3QHZavZvIucruwHaFv9jWfkH4LjapkNrhDSn7qsGsLq7JA>
    <xme:_vA9aGe4oEqtsqA_KTNpDv8pb1K10sXgM4c5WkK-nq4c6p13yrRoSiC5KJioa5Bwa
    oS72iOfm9SFVRn7r0g>
X-ME-Received: <xmr:_vA9aAxmb3RSi31JfWP_kJ4j2gSTlc69iPjD-sYcVFjD5g4lCc7t3iO5_MrRHFMhwNp_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkeegfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfev
    fhfhjggtgfesthekredttddvjeenucfhrhhomhepgghlrgguucgftffufgcuoehvlhgrug
    esuhhrshhurdhmvgeqnecuggftrfgrthhtvghrnhepteehfedugeelleffgfduffevffdv
    hfevteevleefteetjedtiedvudevheduheffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepvhhlrggusehurhhsuhdrmhgvpdhnsggprhgtphht
    thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhithgrlhihrdhlih
    hfshhhihhtshesihhnthgvlhdrtghomhdprhgtphhtthhopehjrggtvghksehjrggtvghk
    khdrihhnfhhopdhrtghpthhtoheprghnthhhohhnhidrlhdrnhhguhihvghnsehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepphhriigvmhihshhlrgifrdhkihhtshiivghlsehinhht
    vghlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
    dprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:_vA9aEOnEGnOZRJJzxmQZ4CXXOutUrC9-wxaFsGFpVOO9ML--ZAxoA>
    <xmx:_vA9aN8tZTqPUTpmSrJ-j7EI3RbgFf9ljkMgV4sfKimlgwN2TFfGbg>
    <xmx:_vA9aEV-xfCeg0DM8jsAJiwMk8WMghS25XUdhHOwZtIXMAQDsqmXfQ>
    <xmx:_vA9aOdSwqMkVd_CSnVgpBFlLiFgav3WmNCYIO7fN8VvuehsDo898Q>
    <xmx:__A9aG99ww3Jd7rvJLvGpm586yAr-KGzcUr4rsXFewlPDK3FTamLsmMp>
Feedback-ID: i9ff147ff:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 14:44:11 -0400 (EDT)
Message-ID: <20f39efe-ba5b-44b2-bfe6-b4ca17d6b0c1@ursu.me>
Date: Mon, 2 Jun 2025 21:44:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: disregard NVM checksum on tgp
 when valid checksum mask is not set
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
 Jacek Kowalski <jacek@jacekk.info>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
 <23bb365c-9d96-487f-84cc-2ca1235a97bb@ursu.me>
 <03216908-6675-4487-a7e1-4a42d169c401@intel.com>
 <47b2fe98-da85-4cef-9668-51c36ac66ce5@ursu.me>
 <8adbc5a0-782d-4a07-93d7-c64ae0e3d805@intel.com>
Content-Language: en-US
From: Vlad URSU <vlad@ursu.me>
In-Reply-To: <8adbc5a0-782d-4a07-93d7-c64ae0e3d805@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.06.2025 13:19, Lifshits, Vitaly wrote:
> 
> 
> On 5/15/2025 10:07 PM, Vlad URSU wrote:
>> On 15.05.2025 07:39, Lifshits, Vitaly wrote:
>>> Since the checksum word is 0xFFFF which is peculiar, can you dump the 
>>> whole NVM and share with us?
>>
>> Sure, here's a dump of my NVM
>>
>> Offset        Values
>> ------        ------
>> 0x0000:        d0 8e 79 07 78 c8 01 08 ff ff 44 00 01 00 6c 00
>> 0x0010:        ff ff ff ff c9 10 54 0a 28 10 f9 15 00 00 00 00
>> 0x0020:        00 00 00 00 00 80 05 a7 30 30 00 16 00 00 00 0c
>> 0x0030:        f3 08 00 0a 43 08 13 01 f9 15 ad ba f9 15 fa 15
>> 0x0040:        ad ba f9 15 ad ba f9 15 00 00 80 80 00 4e 86 08
> 
> You're right — I see that the SW compatibility bit is set and the 
> checksum appears to be incorrect.
> 
> Since the NVM is part of the system firmware and typically managed by 
> the system manufacturer, I recommend checking whether a firmware update 
> is available for your system as a first step.
> 
> If no update is available, perhaps we can consider ignoring the checksum 
> on TGP systems if one of the following conditions is met:
> 1. SW compatibility bit is not set (current Jacek's approach)
> 2. The checksum word at offset 0x3F retains its factory default value of 
> 0xFFFF.

I am already on the latest firmware. I have also tried downgrading to 
earlier versions and they have the same problem.

