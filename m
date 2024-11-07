Return-Path: <netdev+bounces-143018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C2A9C0EB4
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CD71C2580E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D73217F3A;
	Thu,  7 Nov 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzEsujxi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0FC217F28;
	Thu,  7 Nov 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006944; cv=none; b=kxCmuyoF1KFd6Y7LDu1Jl0wy8UoDLzL0K9RqlwdPAQyTvm9R6JMN32DJF7Dfvt4ZUJqVu1Vdc6tFdFYbd4yk/txQS7UzCrwAYG7+xwxtqOADgkMZ0wdeQLACxT6CNtAEFvopEGNUjEsmGvBEg/I5t28aRd0zTivphvOhWF8C/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006944; c=relaxed/simple;
	bh=AXeeQfete81ISpYgNwsN8kdIw/YYe8eDWp3sCIfbE68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+YmXh/eX2YOAT3vi3nt9pWpz16OpFZ3ZrrQFRomuJ2ShsITkGIJoVshRwVQ2inxvYzLY7Zcp6SiJc0pqhh0fKuyeQ9wsSv8Iet+OXnCwpl+unBXwypml7jPblvuCxaDcj9J38gl0/j75hfw+bv8TAU59kOBM8dPzJXmnPXNUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzEsujxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B5DC4CECC;
	Thu,  7 Nov 2024 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731006944;
	bh=AXeeQfete81ISpYgNwsN8kdIw/YYe8eDWp3sCIfbE68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dzEsujxiLm9jgs5KenIALt1j57ZJaqU3WMguX/GXwrFC6V8Uw/IDuxM00h+yqs5zR
	 Xk94+DsceskjHyO5WXJ6txnG5arhKh++b2ECRq1E62cDHuUwC7orSgrlfkCvUFkwXI
	 ofEiio+pzHdsrLZwzDqO9vWn6gF2HhGk1pdWtSOqtnqe8bxAws+N9EFYGhr5lVmQIi
	 TTwaEu2iQ2ZIdAmQtOemfZx+vNEO55Za+tVBxNGaD5sr614m9bIjnI+sZnR/jQyNHn
	 tjMIalXYaORr4KumgXAcbTXMiFbMHkZILqxgiAuSA+Mf+kq1dm21ueOsFARt/jDP+n
	 heKuYvUZLmaZw==
Date: Thu, 7 Nov 2024 11:15:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <vigneshr@ti.com>, <horms@kernel.org>, <jan.kiszka@siemens.com>,
 <diogo.ivo@siemens.com>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Roger Quadros
 <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net v4] net: ti: icssg-prueth: Fix 1 PPS sync
Message-ID: <20241107111542.19dc55e2@kernel.org>
In-Reply-To: <20241106072314.3361048-1-m-malladi@ti.com>
References: <20241106072314.3361048-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 12:53:14 +0530 Meghana Malladi wrote:
> +static inline __u64 icssg_readq(const void __iomem *addr)

two nit picks:
 - since the function is now fairly special purpose I think a name less
   generic than readq would be appropriate. Maybe icssg_read_time() ?
 - __u64 is for uAPI, to avoid type name conflicts, in the kernel
   please use u64 without the underscores
-- 
pw-bot: cr

