Return-Path: <netdev+bounces-44345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2856E7D79C0
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB985B20FE8
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE6415A5;
	Thu, 26 Oct 2023 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3Ul70N7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404717CB
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2301BC433C8;
	Thu, 26 Oct 2023 00:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698281035;
	bh=5VraMtcN0ow/OlHosoOeHAGAK09RIwuNeQHyj8A+b/A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=a3Ul70N7RumVZvr8scEeS+gtxSQSX6JK+7mJ4qE60EnfTvsTFEpShoCEthPKpNLpH
	 kJW640I4inqzgieSNolCsNA7bXTzEbY+Ga3OIugkZkIb9lLxXeRf8qBJ21OdMRbzp8
	 YzXcK6cmJcO1SdQRi2iGgublgDRoaYsidiSxtA90nHGi/VH6zMf2bt+6IllPZAudeR
	 45e1a2RwbyRSG4BVTBXdDdvuN9swjx82XtxS8KR++Qax0kKJ8eO30OwHPqPqcdxsFi
	 +EXQeXFEmrju4FZF114SFyoWbAx/3FeTtn0heQOXI5y7htK8qeC8mBklZqYZRcJXPY
	 7jq+W5g6iKNLQ==
Message-ID: <73dd2956-84b8-4356-87b6-77c5fe303c26@kernel.org>
Date: Wed, 25 Oct 2023 18:43:54 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] Documentation: networking: explain what
 happens if temp_valid_lft is too small
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 jbohac@suse.cz, benoit.boissinot@ens-lyon.org, davem@davemloft.net,
 hideaki.yoshifuji@miraclelinux.com, pabeni@redhat.com, kuba@kernel.org
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
 <20231024212312.299370-4-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231024212312.299370-4-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 3:23 PM, Alex Henrie wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



