Return-Path: <netdev+bounces-221004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2CB49E0D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF243B017A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6741F5413;
	Tue,  9 Sep 2025 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhlXHeuQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D81F12E0;
	Tue,  9 Sep 2025 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378047; cv=none; b=gmf0kJJrwI03r74vpjvxcQSyexVIGosLIPmFDGe1iWYZAMzNjxeMgIwV2ErhXhSF33rS8L5pIPCbWrroymO4xHIW9BO4D4JkX5yj7DEtQP+L8EiIx80mWfN9tUOr12Vv71Zdsdv0huz9EwgQvANIrVDX/zhrhuDwd8eURpr6eWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378047; c=relaxed/simple;
	bh=kIlv7QbzYjMgSwCBteRli8sNX4QzCCtBptBcgT5oOPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo3SzonhBQdLmRcWlgrFK2hpSHYF9SYeqWGMdeyRI3hqWbqAIyXvowLY1XwqBAZdA5vAAbWnszr7JeuDkHn18OTqLLdMfwe080ANADVdYMkiyQzlaW95N+/1LTEIcXGyOoYSQTBv7UQXXcUB3OSdNPlO7ELkqwhWshxBiHSZcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhlXHeuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D48C4CEF1;
	Tue,  9 Sep 2025 00:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757378047;
	bh=kIlv7QbzYjMgSwCBteRli8sNX4QzCCtBptBcgT5oOPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OhlXHeuQg/FbLmSazvb/q+WT5wZq0bM/SbOFD0i9lLCn5AjwlpMg4hSG57YM1QTpE
	 EDNivgEg9GxQNuAae4aNPp/l2oI5inaOXK3c7ktYmAeYQaweAvTxtPcHNnGWi/BtWL
	 4a68szBvMjRlKjemWt4JONgSNgSf62Z8SQvrl/YTKourv7S3ryguvWISptRNrfLq6U
	 YW0ZUYif/g+X2Ltxx4F8RxgjBSwujkjhwIemWoLxh8lLPvE3upk5ylgc3IBzk1nLqm
	 4fMFRh2STmgQZppQOhCcI4EMvvDXrufDso0gKJ4IuNtoKZTFhZlO8+t/NmUObEsi8s
	 2gIuU7LYZlV5A==
Date: Mon, 8 Sep 2025 17:34:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Junhui Liu
 <junhui.liu@pigmoral.tech>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, Vivian Wang <uwu@dram.page>
Subject: Re: [PATCH net-next v9 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <20250908173405.08aec56d@kernel.org>
In-Reply-To: <fbcc1ec3-7ff6-4891-97e3-9763355326f7@iscas.ac.cn>
References: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
	<20250905-net-k1-emac-v9-2-f1649b98a19c@iscas.ac.cn>
	<20250905153500.GH553991@horms.kernel.org>
	<0605f176-5cdb-4f5b-9a6b-afa139c96732@iscas.ac.cn>
	<20250905160158.GI553991@horms.kernel.org>
	<45053235-3b01-42d8-98aa-042681104d11@iscas.ac.cn>
	<20250905165908.69548ce0@kernel.org>
	<fbcc1ec3-7ff6-4891-97e3-9763355326f7@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Sep 2025 16:22:44 +0800 Vivian Wang wrote:
> "dstats" is meant for tunnels. This doesn't look like the right thing to
> use, and no other pcpu_stat_type gives me tx_dropped. Do you think I
> should use dstats anyway?

You can use dstats

