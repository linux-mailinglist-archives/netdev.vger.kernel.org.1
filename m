Return-Path: <netdev+bounces-220538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4131BB4680E
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED001B22EDC
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB612CDA5;
	Sat,  6 Sep 2025 01:47:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5BB1DA23;
	Sat,  6 Sep 2025 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123227; cv=none; b=Puefzu92+6fgCTjTGAn3sctU35abTWwauWNVg0UKfuY6D6u2IMOcvrGKLYUQ4p6ziaykKbwyJ4GFYqFhbDpsYJ9fK3eK4rSIszLKtMoxxQuffmLSto187DYDGTEFLzUy9XmzTQuAwYvzD6bFhTlBEAQFs2cissHCE+nSrZnl3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123227; c=relaxed/simple;
	bh=jqOyWvf19hwcssGfnEv2R3bI3eGkV4DbfS3igJePDmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxpUDKogcrQO41zctnOpBcoRmucWPIt0K1SiTk46ej9ywffpS1b7osfIDur7LtP26T5QuHL2I75o5QAYPpsGkHzR4QgV82CcWjurZmKunoLj5/QFVwfj16mYMgz80sltCLvaAVGP3X2GadQEt9H5HNZztJHq9PAXPLtEWHZScuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowAC3B4J2krtoUhLyAA--.63050S2;
	Sat, 06 Sep 2025 09:46:31 +0800 (CST)
Message-ID: <19279021-e89e-458a-8bf1-62ad2f76a0ba@iscas.ac.cn>
Date: Sat, 6 Sep 2025 09:46:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/5] net: spacemit: Add K1 Ethernet MAC
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, Vivian Wang <uwu@dram.page>
References: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
 <20250905-net-k1-emac-v9-2-f1649b98a19c@iscas.ac.cn>
 <20250905153500.GH553991@horms.kernel.org>
 <0605f176-5cdb-4f5b-9a6b-afa139c96732@iscas.ac.cn>
 <20250905160158.GI553991@horms.kernel.org>
 <45053235-3b01-42d8-98aa-042681104d11@iscas.ac.cn>
 <20250905165908.69548ce0@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250905165908.69548ce0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowAC3B4J2krtoUhLyAA--.63050S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyDKF1DKr48Kr1UJF17trb_yoW3WFXEgr
	Wq9Fs2krs8WF1qga13Ja1Ygr4DAa42gFyUXryS9w1qv3sxXFyFgF4DWr4qvw18W3yagrnI
	qr4rZrn7u34jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUn1v3UUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 9/6/25 07:59, Jakub Kicinski wrote:
> On Sat, 6 Sep 2025 00:35:37 +0800 Vivian Wang wrote:
>>>> On a closer look, these counters in ndev->stats seems to be redundant
>>>> with the hardware-tracked statistics, so maybe I should just not bother
>>>> with updating ndev->stats. Does that make sense?  
>>> For rx/tx packets/bytes I think that makes sense.
>>> But what about rx/tx drops?  
>> Right... but tstats doesn't have *_dropped. It seems that tx_dropped and
>> rx_dropped are considered "slow path" for real devices. It makes sense
>> to me that those should be very rare.
> Pretty sure Simon meant the per-cpu netdev stats in general.
> There are three types of them, if you need drops I think you
> probably want dstats. Take a look.

Thank you, I will look into this.


