Return-Path: <netdev+bounces-46481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FED7E4794
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 18:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DF31F21381
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E9A347D6;
	Tue,  7 Nov 2023 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL+hHwYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA626321B3
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 17:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D843C433C8;
	Tue,  7 Nov 2023 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699379400;
	bh=gEj4r5oaWUnXDzJh0xj5xkQh1EcU6cfqYKH7GdmGCH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nL+hHwYYCCuDGj2kuptuQh2rxLddC/24zCf/+m5vNKuPBtEzjInrtxrptUdB4CzpQ
	 OkvGkjpd6hyNQ5ah0aWs5x8CcOtbDhDMKYAk7UsH3jL/Vm2u6n72+wPRsq7yt/4bZx
	 Ah5+2uSvV3oQqtJZnmnY8vZSUQSPA5+fKuQ1jybL1gFEq7HEjIIkR4AUM6kczdAVpO
	 NKJ65Q8+SWRvI71VaqifJR12uhHCqy/waLKO+Sh6wTp12reradkEzPgkXIoa/YnzXv
	 kqP3jI1OTjMQ6uncDLryWRZ98pj9R3Ax6Gl4SihhY4ff7YgxLcYwhX0yx+QlpMargM
	 KD9oHBWFHXuGw==
Date: Tue, 7 Nov 2023 09:49:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net v2] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
Message-ID: <20231107094959.556ffe53@kernel.org>
In-Reply-To: <20231107123825.61051-1-linyunsheng@huawei.com>
References: <20231107123825.61051-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Nov 2023 20:38:24 +0800 Yunsheng Lin wrote:
> I have added frag support for page pool, made some improvement
> for it recently, and reviewed some related patches too.
> 
> So add myself as reviewer so that future patch will be cc'ed
> to my email.

Not sure what to do about this, it feels somewhat wrong to add
as a reviewer someone who seem to not follow our basic process
requirements:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

:(

