Return-Path: <netdev+bounces-30636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD76B7884E8
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E519B1C20FA7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43916CA4E;
	Fri, 25 Aug 2023 10:27:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39BC2EB
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 10:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD5CC433C8;
	Fri, 25 Aug 2023 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692959269;
	bh=GlJZbxfQumjViabwo6wt/Qqv7WqGJLi1zT1LW0QeH80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnq17neH4lF+1S9Xu8wFeZr/UspYVbscc+PvZbPR3d5KmRU3hIfy0zGBqUUJJuR+V
	 Qhwc78bih1X9RgTp0jt+8x26jKgALdyrT9lT2OJCN7nexE5j0fugXKDcmUIEjpvZ+J
	 mmAAIx67rZvImCCZUNxdrcPiRetGnoyE8pwHoFul8/Htu/ylGJgS+x1yBvpqXtEe6n
	 4TwG/BpyB6klN7Vd1FwtvrNtX5CZs/P4EEz/PBPju4ZAg7FcJK9oty35CznfF8g+c9
	 81HxTgPw5xlu0Bd4J51qvt9MYBKhvl5KgjY35FxTJpIesa2yx5fQ6MG+6OUJuMSQss
	 grZhfIlLqSIUg==
Date: Fri, 25 Aug 2023 12:27:42 +0200
From: Simon Horman <horms@kernel.org>
To: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 0/6] sfc: introduce eth, ipv4 and ipv6 pedit
 offloads
Message-ID: <20230825102742.GM3523530@kernel.org>
References: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>

On Thu, Aug 24, 2023 at 12:28:36PM +0100, Pieter Jansen van Vuuren wrote:
> This set introduces mac source and destination pedit set action offloads.
> It also adds offload for ipv4 ttl and ipv6 hop limit pedit set action as
> well pedit add actions that would result in the same semantics as
> decrementing the ttl and hop limit.
> 
> v2:
> - fix 'efx_tc_mangle' kdoc which was orphaned when adding 'efx_tc_pedit_add'.
> - add description of 'match' in 'efx_tc_mangle' kdoc.
> - correct some inconsistent kdoc indentation. 
> 
> v1: https://lore.kernel.org/netdev/20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com/
> 
> Pieter Jansen van Vuuren (6):
>   sfc: introduce ethernet pedit set action infrastructure
>   sfc: add mac source and destination pedit action offload
>   sfc: add decrement ttl by offloading set ipv4 ttl actions
>   sfc: add decrement ipv6 hop limit by offloading set hop limit actions
>   sfc: introduce pedit add actions on the ipv4 ttl field
>   sfc: extend pedit add action to handle decrement ipv6 hop limit

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


