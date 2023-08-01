Return-Path: <netdev+bounces-23117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC576B00A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C5F281774
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF1C200AA;
	Tue,  1 Aug 2023 09:57:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF87200A8
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9DCC433C7;
	Tue,  1 Aug 2023 09:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690883825;
	bh=9FY6QFn/zgOA97cCVuiCWjqBomFGV5Q4vBQBuoSs3mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMe2ZQEdBvjFlnAwHkLLGPKi3ZBSRU10BB+lfHVrEbf6OO2e4c0X+djp/lunrENJN
	 wwgxlQ8gjlJbK8++ppgrjenkdF6MnPFV9usWQ94YwfYlACfHcI5jieQkSTuzizKkX1
	 Io+4FS2JplLvqGIXUu3uacYyzcOg8+w6yBHc2hguS7oW+WaqMkQmsco5yYSMJdszMo
	 nnGQS9hEo6H9wbhhbxPSY+jpGYfKv/IqqvRJNZkFEspjETPYH7gDzkI71aGSa60dMM
	 lMd7e/L4XLsU107XLb/2b4KJkhkbKPSV9gEAX4k0d7qJpyW8CAoWD+l5qfWKSvvsui
	 fvfgm0viIFtug==
Date: Tue, 1 Aug 2023 11:57:01 +0200
From: Simon Horman <horms@kernel.org>
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc: intel-wired-lan@osuosl.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
	naamax.meir@linux.intel.com, anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-net v3 0/2] Enhance the tx-usecs coalesce setting
 implementation
Message-ID: <ZMjW7XeEqpoHhQFd@kernel.org>
References: <20230801011518.25370-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801011518.25370-1-muhammad.husaini.zulkifli@intel.com>

On Tue, Aug 01, 2023 at 09:15:16AM +0800, Muhammad Husaini Zulkifli wrote:
> The current tx-usecs coalesce setting implementation in the driver code is
> improved by this patch series. The implementation of the current driver
> code may have previously been a copy of the legacy code i210.
> 
> Patch 1:
> Allow the user to see the tx-usecs colease setting's current value when
> using the ethtool command. The previous value was 0.
> 
> Patch 2:
> Give the user the ability to modify the tx-usecs colease setting's value.
> Previously, it was restricted to rx-usecs.
> 
> V2 -> V3:
> - Refactor the code, as Simon suggested, to make it more readable.
> 
> V1 -> V2:
> - Split the patch file into two, like Anthony suggested.

Thanks for the refactoring.

Reviewed-by: Simon Horman <horms@kernel.org>


