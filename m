Return-Path: <netdev+bounces-219397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE6BB411AD
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7148A5E846D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22881C8626;
	Wed,  3 Sep 2025 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXQfTOMc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8665B8F40;
	Wed,  3 Sep 2025 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861779; cv=none; b=MRvHuw+WzJ5R7fdgdQZWFHvLOxYd7d5g8koVTSxDOte4yXzb+h1NPsAkNUP5V2++/1zDm4dI23AQmC/USdRut0G8Otnk1wjjavX+2fHdpHgDi3bNp9QZtcekpRh1Ee9rxI3s3bDa1mZAgiOrDojabKVifi6T/0Gx6xCnHllwAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861779; c=relaxed/simple;
	bh=zkp4q4vpL4Adj+QEd8KAgIulqnR2SfQyjtB0YsIJotA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHBlekyQyPRO5G3X5S1RxvT1ykMh9iULqUC631NoK/TBrdlhrTkPHdTn94jHLfzZ8AMSKvDhbctomlfKJqaLprYBOxuV1rkyNpBQA4fecxJJzCiCYJ9MgX4xt34r7dWBW6Ybo4hJtnd+rmT4QK39M5nM0y5bzarrVWC5MNiT2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXQfTOMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128D8C4CEED;
	Wed,  3 Sep 2025 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756861779;
	bh=zkp4q4vpL4Adj+QEd8KAgIulqnR2SfQyjtB0YsIJotA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KXQfTOMcGj/u4j/lzRnkK4vYBBlZ7x4kVuxR7qAIEkOFi5T5rPZKC04sby3DOACvF
	 WGrd1Or79Cd4VzyvFWu+LzqFbSQKfL6E3+rTus7JqkqlQNfOEgqGrW8bN3gyyOVcJ7
	 YzvTohaXWcHjfsp+LI1SHbRjdAQyaLO7Zd3auONuNSnZtKs6I9uNinxbPFhaBKZArr
	 yXEbJshTWduQao2OP9NSaqn3tUF0x8CiLBqkzZh8obaMfyI7wZSX2Jgtg2mm5qkWMP
	 On9mtuUhwWXV62bfyZH9k2Rj0CDDNVmJCljo19DlKSlLMvxR5m2mW1a8BgdqcOCX/a
	 DZWjN4Dh5ntjQ==
Date: Tue, 2 Sep 2025 18:09:37 -0700
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
Subject: Re: [PATCH net-next v03 02/14] hinic3: HW management interfaces
Message-ID: <20250902180937.4c8d9eb3@kernel.org>
In-Reply-To: <07e099c1395b725d880900550eaceb44a189d901.1756524443.git.zhuyikai1@h-partners.com>
References: <cover.1756524443.git.zhuyikai1@h-partners.com>
	<07e099c1395b725d880900550eaceb44a189d901.1756524443.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 16:08:41 +0800 Fan Gong wrote:
> +err_destroy_workqueue:
> +	destroy_workqueue(hwdev->workq);
> +
>  err_free_hwif:
>  	hinic3_free_hwif(hwdev);
>  

nit: it's more idiomatic not to add empty lines between the actions on
the error handling path

