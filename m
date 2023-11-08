Return-Path: <netdev+bounces-46676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BFA7E5BB1
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 17:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66C8B20D3D
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479AD50E;
	Wed,  8 Nov 2023 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrWC5bCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0758D1944B
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 16:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB75C433C7;
	Wed,  8 Nov 2023 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699462060;
	bh=2YJ/6GS0bW+n/ACRUP2CWd9dxYR3V9iS4ICGfAuIvOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RrWC5bCxfSN+g1j47gq7+CkyDhLTtMrljPY30x2qgCDgJr1Tn1LpksM/slKoKEm6x
	 5DpVU/7/o1xkbJCMrfqdKyjT3GKJSN2Qh3eHvIlRSORc8OxJpgWN0ERns6MK4ewyXo
	 4LfV97F6PSz5Fg8R7OEsqy92mNJqasFcBbA4Rd8Pfk94fVTwWdSQrJ/ehTPyhFmXbW
	 SfubHLZkQBZoftON6dKHARDBpuOmCuvhwAwy8FRBLoHlhtQqwKZpf+HAGKbAOzg8AM
	 LfVR+ML1fwR+DDVEKGs/IJNtkQntcXj2xS0xD6fXF/p2YIrXUCX50DUxraUxZkNuE9
	 XyDi/uE/oBMEw==
Date: Wed, 8 Nov 2023 08:47:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net v2] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
Message-ID: <20231108084739.59adead6@kernel.org>
In-Reply-To: <0098508e-59ab-5633-3725-86f1febc1480@huawei.com>
References: <20231107123825.61051-1-linyunsheng@huawei.com>
	<20231107094959.556ffe53@kernel.org>
	<0098508e-59ab-5633-3725-86f1febc1480@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2023 11:31:45 +0800 Yunsheng Lin wrote:
> For 2, yes, maybe I should stick to the rule even if it is a simple
> patch and obivous format error.

Yes, maybe you should.

