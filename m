Return-Path: <netdev+bounces-45634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566E7DEBEE
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A922819D8
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 04:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9177710EF;
	Thu,  2 Nov 2023 04:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnTtKefv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8BEA1
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6344BC433C8;
	Thu,  2 Nov 2023 04:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698899913;
	bh=0AuTmcgzxAIiWFtDkxCVvVBcBp3v8F+NagoSXD+wt40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pnTtKefvBCEJADqaRG5dPwiI+9is4rwcSTWQ4e8sBa21wJFhHccesWg8NlIankZnW
	 AZui+UwDszoQCXzOEL7p+6mdvSoD6Q4TqmnZUNe+Hi9R+reVcdxjzRPGxy8K/5SAXU
	 xVrKfDtv/WsWjXpimRPvrFl/vn5xa8Ua32ipv9gdCKgXqqTmAYua8Nn4/t2K6AzxjI
	 9h2lRptq37Y4yifH1vnZ7GpJYBf+hW6+nc09oxM0RyOrLnfYKCoufqzg9h1EDJ8DJt
	 57SOAbIidmwFU2VwLAUsJ8BaBQI5ZxaRA/rKJmRv4fYwjoVDFw3lPlGBK4VrBQETBz
	 bf9QCnJdc96Xg==
Date: Wed, 1 Nov 2023 21:38:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Mingshuai <renmingshuai@huawei.com>
Cc: <caowangbao@huawei.com>, <davem@davemloft.net>, <khlebnikov@openvz.org>,
 <liaichun@huawei.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <oneukum@suse.com>, <yanan@huawei.com>
Subject: Re: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Message-ID: <20231101213832.77bd657b@kernel.org>
In-Reply-To: <20231101125511.222629-1-renmingshuai@huawei.com>
References: <20231101123559.210756-1-renmingshuai@huawei.com>
	<20231101125511.222629-1-renmingshuai@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Nov 2023 20:55:11 +0800 Ren Mingshuai wrote:
> >23ba07991dad said SKB can be NULL without describing the triggering
> >scenario. Always Check it before dereference to void potential NULL
> >pointer dereference.  
> I've tried to find out the scenarios where SKB is NULL, but failed.
> It seems impossible for SKB to be NULL. If SKB can be NULL, please tell
> me the reason and I'd be very grateful.

What do you mean? Grepping the function name shows call sites with NULL
getting passed as skb.

