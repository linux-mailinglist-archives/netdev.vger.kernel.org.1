Return-Path: <netdev+bounces-219394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2344B4119B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C317A7C7A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645161B983F;
	Wed,  3 Sep 2025 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qsxov4Hm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC8B1B043A;
	Wed,  3 Sep 2025 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861564; cv=none; b=eDfYxefgPExjixL1Kp4ZxlQy5tOnzSG47T1iLvgYJZ+DyWMgFZs9FlruYNGHeXSfLFyonXE8e7QKtfs6y+ptl0Z9SgCSKJYVe4Yi9uYbyNszWfFu7xuH9s1HkEuq8+kDW2bio4uuzwwLpHMisRSFdByh3tkW5sqaRMty8d/Sxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861564; c=relaxed/simple;
	bh=dDgZLooUi/gjW29UtJ0HiaCqoQdO1rRVSh+boXL5z/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egn6VvxbV5na5xNNXV6KeAdw0TLUxzIrou/UPjyEjG5/IS4GxtzcfAv02oxrRK09L7UWuXNAfzavIRwDv6Sb55YNaIeJUK0tvxdLOtDGZR12vztE+k9Hq4o5f/XfD5qKTZ5FrDmX4lIJXv4Pj7CojtipZC8n1yjb5+COY2wdas0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qsxov4Hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762EAC4CEF5;
	Wed,  3 Sep 2025 01:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756861563;
	bh=dDgZLooUi/gjW29UtJ0HiaCqoQdO1rRVSh+boXL5z/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qsxov4Hmzpc0Crn6zikSRZgHtUfPb/gv0uEDaOfmE3KV5WVpyBpAB2qwftCQ39Xb1
	 m1VyteqFUy3gEhcw78C16eD9phVerNaXUtDmTUOdzG+ZIYfURb6FRgTEhTHVqX7Lyj
	 zlTPwZ5TobHewJNU3MNfNG6qWdFQ04hLLZYx4ZQeF1k1LSbraXE72PjUKgCJQNxHRN
	 uzJp2BMNAUBHgrYUahWYJ2RXURSdTkZUcbX5N/QOdb4j811IjatbREsu+0HLbelHkB
	 JSTvqpk4YjtZBunXCAx2hj7WLzUogyQ2KD6gQtVnnLKuVJsNtXcfq6nLlPw0AR8hwY
	 NGycX30ez0sOA==
Date: Tue, 2 Sep 2025 18:06:01 -0700
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
Subject: Re: [PATCH net-next v03 01/14] hinic3: HW initialization
Message-ID: <20250902180601.562d2158@kernel.org>
In-Reply-To: <d8397bd5a8f7d77f3ef70c555f2423423198d0b0.1756524443.git.zhuyikai1@h-partners.com>
References: <cover.1756524443.git.zhuyikai1@h-partners.com>
	<d8397bd5a8f7d77f3ef70c555f2423423198d0b0.1756524443.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 16:08:40 +0800 Fan Gong wrote:
> +	attr0  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR0_ADDR);

nit: double space before =

