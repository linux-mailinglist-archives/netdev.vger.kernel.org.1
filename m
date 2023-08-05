Return-Path: <netdev+bounces-24637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BFE770E6A
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E9628260F
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438CE5671;
	Sat,  5 Aug 2023 07:25:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F11FDD
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE06C433C7;
	Sat,  5 Aug 2023 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691220311;
	bh=E0NfDEjMRsPv+gyd0sYbOv3jaYygSJdML+8/lrfvaZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TcJxFuZpzKlaJkrQvJZDi9gVUkT78wSfiROjYvecJdiZFksuMjhBPC8KMW/D36xmK
	 ccBO/kan0pZuqjLYTSaIaaohR+o5ZAW7h2V/o0vJj6wKmRx0Z6ZoqBJADIS68o0YUt
	 DVBDOyT7eioUtiH53UM0tmiDOUOr3rYR26d2RlS2sgUfkYCBiiHQuK5XhsPrLrAZkb
	 S/GgklMtQu+vSG0VYa7B02wyvVS3txDCVuqAT1NyT9NkXEe56P5FLJJeEwQTp52Z1Y
	 xJIngeKVuFmjyIYc0+NxyH9OKWaOeFvxtLK0ZnqoRYBNPHMNnymu96K8I+YS2BH9yV
	 I9fGVFuK6Y71Q==
Date: Sat, 5 Aug 2023 09:25:06 +0200
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, simon.horman@corigine.com,
	jesse.brandeburg@intel.com
Subject: Re: [net-next PATCH V5 0/2] octeontx2-af: TC flower offload changes
Message-ID: <ZM35UguoE2KrX7JF@vergenet.net>
References: <20230804045935.3010554-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804045935.3010554-1-sumang@marvell.com>

On Fri, Aug 04, 2023 at 10:29:33AM +0530, Suman Ghosh wrote:
> This patchset includes minor code restructuring related to TC
> flower offload for outer vlan and adding support for TC inner
> vlan offload.
> 
> Patch #1 Code restructure to handle TC flower outer vlan offload
> 
> Patch #2 Add TC flower offload support for inner vlan
> 
> Suman Ghosh (2):
>   octeontx2-af: Code restructure to handle TC outer VLAN offload
>   octeontx2-af: TC flower offload support for inner VLAN
> 
> v5 changes:
> 	Resolved conflicts with 'main' branch
> 
> v4 changes:
> 	Resolved conflicts with 'main' branch
> 
> v3 changes:
> 	1. Fixed warning in file
> 	drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> 	2. Updated commit description for patch #2
> 
> v2 changes:
> 	1. Fixed checkpatch errors in file
> 	drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> 	2. Updated cover letter subject

Hi Suman,

Thanks for your patience with the minor fixes and rebases.

Reviewed-by: Simon Horman <horms@kernel.org>


