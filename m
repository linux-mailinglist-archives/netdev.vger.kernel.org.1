Return-Path: <netdev+bounces-209296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D697EB0EF32
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B104218915C6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B7288524;
	Wed, 23 Jul 2025 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lunBdKsg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE4283FF7;
	Wed, 23 Jul 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265040; cv=none; b=BUWw/6GCE1Y6Zg391U7BPjt34uQUnnDiTknLFd8e1LpabZWVdKJ3xoBwMwEdPnXnGttp6zhmICsUF0AKrt8dPt3eWJCdxtJu/RSEKfGZYtZK5wBg6rjjegFxmoJecaRE9Galp1zV1OeVPM+wEJ9eU5Mc48mO/H+tiPXQjfFOfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265040; c=relaxed/simple;
	bh=1gm5UbqhAXgE7lNc69Zqc7sMDOmm6TonOtX7iaf8rUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q156tCTAKncQtQdkoba4PfCrpsVf8PSm0GNigfYbkLdSSYFjvwndhmC+i5HkoM/NSSvWlnqcwV3ajWrNUDqF4s55Sqae54E4megnJOIQEt1tDalhZuaDQ/ILq4q3kYjxfaY9rMLIUdYELxqWbJVESolr4WVn2+0zZ2HF2TxiQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lunBdKsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD30CC4CEE7;
	Wed, 23 Jul 2025 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753265039;
	bh=1gm5UbqhAXgE7lNc69Zqc7sMDOmm6TonOtX7iaf8rUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lunBdKsg25fUuAQ27teQp3vNC6VfZYH2qNGWMGsO8SeohsylvRim73lrFr6Lhl2dj
	 v5cQgz6labiJy3Xucqr/jPmCNhoPuN9ki5LELFuGERCzBK4g05tlxxFbybwdAS1GDF
	 w5PDQ+zkCR4RaYTmxY3y6R6v+JvwTzIgVzCIXGD6j3j6O9ha4a0j03ef9K/7/sWmO9
	 /Ae/fld+ebZFBP6Uj0jiEs822qrt3V8GCfuWEqD8herQOQ24izWeuY5PlngX1bipFY
	 4AKDOSc+b2E6XNF3sL53CWTkYs1B7hthabIkCh4pGeYHqH7hsLUf+kJvvyXvMATgMx
	 aCRRi167l2MYA==
Date: Wed, 23 Jul 2025 11:03:52 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Fu Guiming <fuguiming@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v10 2/8] hinic3: Complete Event Queue interfaces
Message-ID: <20250723100352.GX2459@horms.kernel.org>
References: <cover.1753152592.git.zhuyikai1@h-partners.com>
 <5dc43637cc54d5f3edfa323ef9021cfe095588c7.1753152592.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc43637cc54d5f3edfa323ef9021cfe095588c7.1753152592.git.zhuyikai1@h-partners.com>

On Tue, Jul 22, 2025 at 03:18:41PM +0800, Fan Gong wrote:

...

> +void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base)
> +{
> +	struct hinic3_hwif *hwif;
> +	uintptr_t distance;
> +	u32 idx;
> +
> +	hwif = hwdev->hwif;
> +	distance = (const char __iomem *)db_base -
> +		   (const char __iomem *)hwif->db_base;

nit: These casts seem unnecessary.

> +	idx = distance / HINIC3_DB_PAGE_SIZE;
> +
> +	free_db_idx(hwif, idx);
> +}

...

