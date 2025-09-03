Return-Path: <netdev+bounces-219400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DA0B411BC
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84EE1B27242
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07DB1311AC;
	Wed,  3 Sep 2025 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceQZPDYQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091132F77B;
	Wed,  3 Sep 2025 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862144; cv=none; b=gWHTCTdCQI1PlTOVg6kt8RvhrUd1aWixdT64TLUolFs1hRelG5rXMD1qGe1yKFbUzBdNvp8vB5LqGj3QddxnLi993BWUP5oOGhJ6T4wvyuZAOdynIx3GZWFCb0qJvNu4zcKCB2oBBhWXd+jCo48i+6MQBBT+4XwauPf4qGIWmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862144; c=relaxed/simple;
	bh=ZpfymFp0LbzfFuRzfVKm33O6kOUhmfqrYRp51EQ+AUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUXJtOYJcgvJCgGDm1wwt2jOAFA/tJGAv+xu+e61bYc6SQ7hl5ozdGuYj+dHH5Edv4cHDI5k/mZHCkFGWvHTBwPFteWDzMDKk3UR2d7U+dLN/npsc3Jc4lUuaWvxbPMnxhsfDUy03RHwURLVgsc8fDn+N3LR3PkIaKk475Hyxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceQZPDYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2342DC4CEED;
	Wed,  3 Sep 2025 01:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756862144;
	bh=ZpfymFp0LbzfFuRzfVKm33O6kOUhmfqrYRp51EQ+AUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ceQZPDYQwkIaLVMJpz4yK4o9czagFZGCdnHDxpQMrWXwFmdtnMOfkdBsR503+Sy56
	 AWlOBM7ME6JLXAaNphCOoXjdKYxQZP1DvkhsSLRame3hnyegfgjUsVT0Uk3wi4AkvH
	 128BgUCZRx5FsXbspfQyvwCBrppLpaKG5bFH08sxesgzHtPVJK96TMTKOGBhXLL3Hf
	 D6nKo44QxwHfvITM9RHpf5pw5PHwAJUAeQscdFCIRyNNhZpftXQ28LtA0AGq0uneqA
	 aiooNAw8XhhgNSr6cUx16ww9ZJZkROBxEdY645JHB73lsoH9pe6rz8gHjZDamepCYe
	 3y24Mdla1cbEA==
Date: Tue, 2 Sep 2025 18:15:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
 <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
 <mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v03 05/14] hinic3: Command Queue flush
 interfaces
Message-ID: <20250902181542.13fc234b@kernel.org>
In-Reply-To: <a82cf0c769d351a3245343bc1b1de93927d694c6.1756524443.git.zhuyikai1@h-partners.com>
References: <cover.1756524443.git.zhuyikai1@h-partners.com>
	<a82cf0c769d351a3245343bc1b1de93927d694c6.1756524443.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 16:08:44 +0800 Fan Gong wrote:
> +	/* wait for chip to stop I/O */
> +	msleep(100);

This is a bit questionable. Is there no way to find out if the
transactions for a given queues are still in flight?

