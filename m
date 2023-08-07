Return-Path: <netdev+bounces-24731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79AD7717A8
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 03:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F5C2810E4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 01:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401C392;
	Mon,  7 Aug 2023 01:07:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACC19D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 01:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32572C433C8;
	Mon,  7 Aug 2023 01:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691370425;
	bh=eesiXLhgDM96BocvOxpMhwv3jzHwbHMrWMf/DGlsqlo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rVClsLIUEL5asNNDzAevWS2y7DqwAtdQ1X+/IEL3FmY6P43GldcQD0o2QCXloT8z+
	 UAzD5bXtKIXDQIRU8a7wgVDOcVyoXkOIeTKgJYzKGHw0JkWHDSJx4D1NSI6O3rPDkf
	 4m+OAiHAqnebCjjvoXHvizfQEPu31V1FlgXn1/GXKbxTjwtWomc0wNo7SuuxmN5J2J
	 UaauM2TKQ2f6STpbHfmtq2YPuQ9ZL632Krx1fzb/h2XuGwjKpz9lZceqqKgrRVim1F
	 PVKVjktoyvkqnKWtNZ4KyrNduWZ3lwOqTTDzCCRnvdjF8iFFd25dSHwIYdu5MyFrlQ
	 M/qXz6wGdG2UQ==
Message-ID: <94e7b8c0-afe4-6078-a11d-b533aa0a84cf@kernel.org>
Date: Sun, 6 Aug 2023 19:07:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] ndisc: Remove unused
 ndisc_ifinfo_sysctl_strategy() declaration
Content-Language: en-US
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20230805105354.35008-1-yuehaibing@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230805105354.35008-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/23 4:53 AM, Yue Haibing wrote:
> Commit f8572d8f2a2b ("sysctl net: Remove unused binary sysctl code")
> left behind this declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/ndisc.h | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


