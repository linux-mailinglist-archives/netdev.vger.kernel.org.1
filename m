Return-Path: <netdev+bounces-57751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084981406D
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EF41F21392
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E0C4693;
	Fri, 15 Dec 2023 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLOlfoKK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089AE746B
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02E1C433C7;
	Fri, 15 Dec 2023 03:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702609690;
	bh=lrRlmSqI+5FGfAK9NUUEQWrWXlyRYvMtLKbIFMovAOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OLOlfoKKeb0OKPXa6kD9H3u7U1vLXI0cfiOhz/mV5V5P0R/l/wNP2Aimh5Qlp418S
	 8zjk5752Tjc5pCzrZXuUeTqhWgEKu0IaVUt0UQ4ARqW/emMlagqYlqxtsbZunZz9ZY
	 VZxc4McuMqJWv54iTB3KnUCu/CmHWAeDmE6ifVmmyXU//Jq4SQGweHqYjf+YZPww3J
	 qc59FzJ9fLWav38CaOsUtfWW8XWEWK9F3xNTTtD6xEZg46gRQSbDhN59SO5DX3Dqeg
	 x79bW7GgohiqTh91g/OPW7lHX+jt3Q16aAdo8EAG2X3KzHVHsUvNwNu3yLpHUvDazn
	 5Bj2o7A4RlyUw==
Date: Thu, 14 Dec 2023 19:08:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, linyunsheng@huawei.com,
 netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com,
 almasrymina@google.com, Mina Almasry <almarsymina@google.com>
Subject: Re: [PATCH net-next v10 2/4] page_pool: halve BIAS_MAX for multiple
 user references of a fragment
Message-ID: <20231214190808.54a258df@kernel.org>
In-Reply-To: <20231214042833.21316-2-liangchen.linux@gmail.com>
References: <20231214042833.21316-1-liangchen.linux@gmail.com>
	<20231214042833.21316-2-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 12:28:31 +0800 Liang Chen wrote:
> Subject: [PATCH net-next v10 2/4] page_pool: halve BIAS_MAX for multiple user references of a fragment

You do have to re-generate / re-number the patches to 1/3, 2/3, 3/3,
otherwise patchwork thinks that there's patch 1/4 missing and doesn't
kick off automation :)
-- 
pw-bot: cr

