Return-Path: <netdev+bounces-26445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F6777CAC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01041C21634
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85620CA9;
	Thu, 10 Aug 2023 15:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789E20C94
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA2DC433C7;
	Thu, 10 Aug 2023 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691682629;
	bh=bi6iuuz4udlyNoNOwWTPpyOVa05eVKEUiERGQ7pbbhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRZ4sQ6/ISASFM6gX+XLETOOszRzyqOSs0NWw21bfOIyDxYtXtPPC99wY5NNwVwZM
	 pNxe9HT5uMClfMtNH+1hHSgWPU7mPdLiy3d+epaB4kcDQNhykUUCbfezH61yzr3o23
	 rNYvzLWA3dlK+tXi4hjcdFCt0599L7sRoUT8KNZE0pilip5XFBNOL2MmhvMf3XvwsN
	 olj2J+oHxZW8RTq123ZvPhx7m+KpwS8YD1aP97TkG0S8zi7n65rJdiUHBrH8cBoB0y
	 wyFRNnlCGgkBYtKvlTrjb+SFETPFNmh1ECyqkvvHT9T1hp1PMu92uIQMHKpC88Q8+B
	 rxQtnIeT78XfA==
Date: Thu, 10 Aug 2023 17:50:24 +0200
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>
Subject: Re: [PATCH net 1/4] octeon_ep: fix timeout value for waiting on mbox
 response
Message-ID: <ZNUHQH2rA6pWhXvb@vergenet.net>
References: <20230810150114.107765-1-mschmidt@redhat.com>
 <20230810150114.107765-2-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810150114.107765-2-mschmidt@redhat.com>

On Thu, Aug 10, 2023 at 05:01:11PM +0200, Michal Schmidt wrote:
> The intention was to wait up to 500 ms for the mbox response.
> The third argument to wait_event_interruptible_timeout() is supposed to
> be the timeout duration. The driver mistakenly passed absolute time
> instead.
> 
> Fixes: 577f0d1b1c5f ("octeon_ep: add separate mailbox command and response queues")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

