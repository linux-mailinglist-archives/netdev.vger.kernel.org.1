Return-Path: <netdev+bounces-196661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C165AD5C6C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297A31BC47B8
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5788820F078;
	Wed, 11 Jun 2025 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="waUTjhqM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1WapofN"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85021018F;
	Wed, 11 Jun 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659802; cv=none; b=fG/4P29r0cTEsIeJl6qcPgsGAnOu6dERHOSQJXpmCMkCMfBcZCY08v+fZbTdekVLd0wk/eSIwXzU89Qz2zRy6SZplDUknxpTIn2kNwYhgFuBPgj/pSvtX2pllPmvRjl+B8nnMNqp7QHvlkvDiO92W/hEa4bOHrr9RZZbH32qWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659802; c=relaxed/simple;
	bh=OKyY1Suf9wd0Roqmv3s7f7pR23uXYiojLlo7XhjLd8U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iZYScux7v1CicdqbEFTf+NMTq45neZNOrfYdc9hpXMYTzbDwCQLRg3muAuQ3W+CBRk3XZZc1ks85WgSQ0XiIUhh1AYV0W2LGw7KEomzv0UyY+ghQBo1uHqlblbHxh6n+yhXE8iHq3SdzEw/q6qpSDWSGUItZZvf4crhbDt0iZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=waUTjhqM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N1WapofN; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F80A11400AC;
	Wed, 11 Jun 2025 12:36:37 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 11 Jun 2025 12:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749659797;
	 x=1749746197; bh=9FCUNYIvHK4qsxp0p8mUgko4Fhuy42loTyUOdB71d6s=; b=
	waUTjhqMbiVv6HEcx7WkyUTfia2KbYPCy14Z88rSp5+1PEeWza1LNpcD0K6QXunK
	34P5Q0EpGwYz1wFgNh4js30xaEk+7QJcZxnTzGtYqX6MRuDH9vPMcawPnNR1t4eB
	kx2tTiY68TpGJhoFUbELONB+o2Adu0u3mmUfKwoZVKW1GiG3aLL+HU2rPVZX5g2U
	l7koqIp9k4UoPa/IlUQyvob7MHRXSH1O3eUuvpWCkyfoLrJE220xELgl7rGYbQl0
	uJhzpYuAsHTnOmmnGPQa49fRGjxHmgQIvkeCdrGl8yO5lG1dow8IonD9/WwQnfYN
	PCFnQoTibAjeH17MU7Qcng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749659797; x=
	1749746197; bh=9FCUNYIvHK4qsxp0p8mUgko4Fhuy42loTyUOdB71d6s=; b=N
	1WapofNhfWAxuNbSX0ot3rEtdNVkbk9qemZhTA2X6dNi4HdZYQmQUsp0S5PN5vK5
	gLhV+zE/ue6Lr/shSfPWXXO2qQSevDUsUC5fCm2tKqF2izZCS4kk3184NIfZAR/Q
	kkHFCZvLejwkRYMJwbkDnCW3i8RNe7+iTnPGySpGRyqd0LknjsxpX0nzn67ivKcj
	afN7KLa1R17SLaz+QPOEpmiD05wi9U7uWNqIuCwVcg+n0pnpDsxbJyTQgQDdmDXW
	cH4FlmPJZPTiGih1KhExmYG8LybQkBiyR4JPpMnTVmX+R0S74BNLODpIW9JrBjv2
	dHCA7qTh42yw+pqGigiog==
X-ME-Sender: <xms:k7BJaJgvBjksxBXjAydFB_w4cVTW6pibBQB0wJIcwzk0Zoz5nY0Q6Q>
    <xme:k7BJaODves4hQIiFhIgFDif9pgToNY0gfh1XgdycsO6hiX7RU2KtX67zl_lThrNNY
    wlCNDb_5K4noss4MZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopehnihgtkhdruggvshgruhhlnhhivghrshdolhhkmhhl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopehlrghnhhgroh
    eshhhurgifvghirdgtohhmpdhrtghpthhtohepshgrlhhilhdrmhgvhhhtrgeshhhurgif
    vghirdgtohhmpdhrtghpthhtohepshhhrghojhhijhhivgeshhhurgifvghirdgtohhmpd
    hrtghpthhtohepshhhvghnjhhirghnudehsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:k7BJaJG6u7ca1fY94-WLXP18oePvV6ugFR312poY3ovkFOgngNVfxA>
    <xmx:k7BJaOQhHOUpAkB1ljKfgHmIxTRej67mARUCSa-9maOM6g6t9NllXw>
    <xmx:k7BJaGwK4QWLV2QCgiqlyrH7z9xYn_tzkrMlcCakygC7Zdb3yZpU0w>
    <xmx:k7BJaE4UpXRYljFlV9eCGDVpcOJmB5c2gS1WanWP2YKCDrha0vdA9Q>
    <xmx:lbBJaBtyBs-cO06obO03QmClHijB1-DOZl3MPbuwpk-HYCzwl9MUfBNN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D0D39700062; Wed, 11 Jun 2025 12:36:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0988381ff57d4bb7
Date: Wed, 11 Jun 2025 18:36:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jijie Shao" <shaojijie@huawei.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Jian Shen" <shenjian15@huawei.com>, "Salil Mehta" <salil.mehta@huawei.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Hao Lan" <lanhao@huawei.com>, "Guangwei Zhang" <zhangwangwei6@huawei.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
In-Reply-To: <41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
References: <20250610092113.2639248-1-arnd@kernel.org>
 <41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
Subject: Re: [PATCH] hns3: work around stack size warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 11, 2025, at 04:10, Jijie Shao wrote:
> on 2025/6/10 17:21, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>> Annotate hns3_dbg_tx_spare_info() as noinline_for_stack to force the
>> behavior that gcc has, regardless of the compiler.
>>
>> Ideally all the functions in here would be changed to avoid on-stack
>> output buffers.
>
> Would you please help test whether the following changes have solved 
> your problem,
> And I'm not sure if this patch should be sent to net or net-next...

Your patch arrived with whitespace corruption here, so I could not
try it, but I'm sure it would help avoid the warning.

However, this is not what meant with my suggestion: you already
allocate a temporary buffer in hns3_dbg_open() and I would
expect it to be possible to read into that buffer directly
without a second temporary buffer (on stack or kmalloc).

The normal way of doing this would be to use the infrastructure
from seq_file and then seq_printf() and not have any extra buffers
on top of that.

      Arnd

