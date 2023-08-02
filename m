Return-Path: <netdev+bounces-23720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC776D50F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5943281E39
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15355F9F1;
	Wed,  2 Aug 2023 17:24:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4938DF41
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0EDC433C8;
	Wed,  2 Aug 2023 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690997092;
	bh=RCTt4dihwXo5XlZYJ+1F+x6J9AFMfpqOwEn3Ton40r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyyWqGPyjWoFxSxDfmdld3ZJ+bRCU2WU03uXdGXR+QMgckEf3mZXTDFs+eYEZxCta
	 elNXHRamo9Ygfmic9Y/fEkdxyxoEq475GGg61Mg2OnY2dmjTSLbXTWi0bRZut/mZEk
	 vfWQ0YzsHTSiMXSAbQaYXXLyEkgsaJUS+SnIItdbnrciQZaBSBzaQFlpNBve4RJwNu
	 kyFd0h+TAK/p5rhOcCZoRChCYtDHfqdHLWV3Hrn68T9XCl2mR+bCofC5ZgYrsIfvAt
	 g19+yvSlo5sYkhd4eug4cjjDR6T8FWhdHN1Ln2f8K7ZhB1i0SAAtO55d0x14k3+/XE
	 zRwGKH4HOAtbg==
Date: Wed, 2 Aug 2023 19:24:47 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lucien.xin@gmail.com,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] netfilter: helper: Remove unused function
 declarations
Message-ID: <ZMqRX6PK9A9Vk5Mh@kernel.org>
References: <20230802131549.332-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802131549.332-1-yuehaibing@huawei.com>

On Wed, Aug 02, 2023 at 09:15:49PM +0800, Yue Haibing wrote:
> Commit b118509076b3 ("netfilter: remove nf_conntrack_helper sysctl and modparam toggles")
> leave these unused declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


