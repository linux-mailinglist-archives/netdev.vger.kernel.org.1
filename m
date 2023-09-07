Return-Path: <netdev+bounces-32482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDC6797CDA
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 21:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB8228179C
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C8E14016;
	Thu,  7 Sep 2023 19:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66114013
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 19:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28808C433C7;
	Thu,  7 Sep 2023 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694115520;
	bh=qfQOR+G9SmAgbHYTVBt3SdKA3Duz9kjlW64D77WR2YI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MBnpO7gNmF5DePYLCPnbrnfpKJhUTaXFKG9LDRyVo0ikbZJxR3n6BZa1OpWucxEWn
	 3kG9pKQ0WDUiAFuOVG9DP47lBWjFDpOrrSeZ0Not0BB2uCwCUxXxP59rSP9I0IOZe0
	 4Mlo7orUgTmrpIgLreqtw7iX9v6eX3LpOpl0+RhrakVGYS5GsW2yYP+OhYmHMQ8b5A
	 ++I0QOCiCJxRcf4zEuK94hDDh1FqK/xXvoXZK+n+blthsRbFuQkCfey2QXNcIWUw8p
	 90DB5ruR4ULU6AT6MG7bK5eFBkRhmSCvPivcPsHJMC2t/bFVJ6tPprjuhMGC+GO761
	 yg+Px5hrxy4hA==
Date: Thu, 7 Sep 2023 12:38:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Junfeng Guo <junfeng.guo@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
 <jesse.brandeburg@intel.com>, <qi.z.zhang@intel.com>, <ivecera@redhat.com>,
 <horms@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>
Subject: Re: [PATCH iwl-next v9 00/15] Introduce the Parser Library
Message-ID: <20230907123839.59a10f23@kernel.org>
In-Reply-To: <9d236687-6161-3e1b-f73f-ed9358e47577@intel.com>
References: <20230904021455.3944605-1-junfeng.guo@intel.com>
	<20230905153734.18b9bc84@kernel.org>
	<9d236687-6161-3e1b-f73f-ed9358e47577@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Sep 2023 14:08:15 -0500 Samudrala, Sridhar wrote:
> >> This patch set provides a way for applications to send down training
> >> packets & masks (in binary) to the driver. Then these binary data
> >> would be used by the driver to generate certain data that are needed
> >> to create a filter rule in the filtering stage of switch/RSS/FDIR.  
> > 
> > What's the API for the user? I see a whole bunch of functions added here
> > which never get called.  
> 
> This link shows an early version of a user of this patch series
> 	https://lore.kernel.org/intel-wired-lan/20230818064703.154183-1-junfeng.guo@intel.com/
> 
> This API is planned to be exposed to VF drivers via virtchnl interface 
> to pass raw training packets and masks. The VF using this API can only 
> steer RX traffic directed that VF to its own queues.

FWIW I have no idea what a "training packet and mask" is either.
Hopefully next version will come with a _much_ clearer high
level explanation.

