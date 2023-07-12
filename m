Return-Path: <netdev+bounces-17128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B488750743
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5352816C7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0D27722;
	Wed, 12 Jul 2023 11:56:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C5200D1
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021AEC433C8;
	Wed, 12 Jul 2023 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689163000;
	bh=1gqCSp35DYsFbYRaR4GC+IpYCqYnDKwwtWr0wadc9qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2+Ga73uPMzz0p45+jAbQpBnUGy9RL7GbDPlBinbYEElVDETeELc079NJvVXBNG1X
	 YF6quaLej0Q/u9RNku8A281OttS+EX/66MJ3QO4kP/69oz/gb51sxXGfYDy5QmhBWo
	 wSFOFkXhNTsdiOVJ8/VXSTukxhEYbwE7rHwOTiYEWYbcdqTyPHvH/5geNshjRNOQfu
	 e8ITiJqWgTfRW2mYd018ZTCiCBMcv5ku64F5sxUAQ+3/PmPfv2bI2AhG9eQ9Qv7IyW
	 GEUK9dvaMz/co1lzPi6ILGcRvnt1T9ojtHiLZcjZut3/MkcQOJWQhgikKPTTorx6dA
	 PwoWrHZwQqC6A==
Date: Wed, 12 Jul 2023 12:56:33 +0100
From: Lee Jones <lee@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: s.shtylyov@omp.ru, Zheng Wang <zyytlz.wz@163.com>, davem@davemloft.net,
	linyunsheng@huawei.com, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
	alex000young@gmail.com
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230712115633.GB10768@google.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
 <20230710114253.GA132195@google.com>
 <20230710091545.5df553fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710091545.5df553fc@kernel.org>

On Mon, 10 Jul 2023, Jakub Kicinski wrote:

> On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> > For better or worse, it looks like this issue was assigned a CVE.
> 
> Ugh, what a joke. 

I think that's putting it politely. :)

-- 
Lee Jones [李琼斯]

