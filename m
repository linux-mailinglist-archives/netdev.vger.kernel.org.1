Return-Path: <netdev+bounces-42538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29EA7CF3B9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02861C20954
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 09:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FE1171B3;
	Thu, 19 Oct 2023 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDw9mOxa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCA101DA
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 09:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1780C433C9;
	Thu, 19 Oct 2023 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697706921;
	bh=2akR1+SpClZT3e4hW3GUBKo4hbbNfLPH+FJFcgjS+bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDw9mOxaxTwpIG2OLQXoJ0CTEuTsLDqvqLHgBr9mmasIrMuTajY6NHR2Lyp8kgko6
	 d4U8sANg22+MMNy2oqQ2OSdIgdmMJamlgzMkYRMyp1LiPWEsQFCCXrYG+KB9s9ROA6
	 xrGm9sIN/VYicmTIOc2PRrZHF0zprsL+JeaHthvLwlsKzaB7CqNBLgHapoVQ0xfmNS
	 fEpb0MVH2Rxi8hOXbP4pIFEwrbKXxQorzEod3798LFEhxycRFVGFPYJO2X/E3npYjx
	 /veSJeNpceDqBEWxRwbj3qneTmQEmzUOwpDBaggyRdFFT7LeLAZjB0uzOvwZ8xtJ3D
	 LHb3jjr7cIK7g==
Date: Thu, 19 Oct 2023 11:15:17 +0200
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
Message-ID: <20231019091408.GA2100445@kernel.org>
References: <20231018112621.463893-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018112621.463893-1-ivecera@redhat.com>

On Wed, Oct 18, 2023 at 01:26:20PM +0200, Ivan Vecera wrote:
> Commit c87c938f62d8f1 ("i40e: Add VF VLAN pruning") added new
> PF flag I40E_FLAG_VF_VLAN_PRUNING but its value collides with
> existing I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED flag.
> 
> Move the affected flag at the end of the flags and fix its value.
> 
> Cc: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Hi Ivan,

I agree with the correctness of this patch and that it was
introduced by the cited commit.

However, I do wonder if, as a fix for 'net':

1) The patch description could include some discussion of
   what problem is resolved, and, ideally, how I user might
   get into such a situation.

2) The following fixes tag is appropriate.

Fixes: c87c938f62d8 ("i40e: Add VF VLAN pruning")

...

