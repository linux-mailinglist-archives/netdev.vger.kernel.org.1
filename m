Return-Path: <netdev+bounces-53306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE44802339
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 12:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D42E1F2109F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 11:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E95BE4A;
	Sun,  3 Dec 2023 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFFBrH4S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9B28F0
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 11:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61E1C433CA;
	Sun,  3 Dec 2023 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701603672;
	bh=OtdrrUcI446zB3hxjmwSCcBAkj90yqeSrqfZyF8qy48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFFBrH4SEi0MldZ/NirkRDs9gdP61dFBFMSHJrl24HO7MpEZ5hYwfNYSYgxvDUYJv
	 lfEPwAWMzLKrWQ9NmiPy6zbjhcclRi8X5r9Wf3Ezu6f+eLazpk7xuHqwNFTkHRJVhw
	 ZtdwoW4BzUA4rAk8USaAeg+g8EPxdrVcK2NACkmioYme+KUp1GpepZkFNYjfExe3iF
	 o0AM/RIEpu1yUcGsDOAcPSUDC2bpSseQRSU3GBd/Sjp1YR+WzeDRo5IMhfLO52gbVE
	 Jlew+uy0TaY6QVe/leeqOB2wuqpFvxO0K4C9NxTjRzTF8SsA/+QvbaKZuFQ+TZMG2j
	 amGSUhiRftWRA==
Date: Sun, 3 Dec 2023 11:41:06 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, mschmidt@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 1/5] i40e: Use existing helper to find flow director
 VSI
Message-ID: <20231203114106.GF50400@kernel.org>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124150343.81520-2-ivecera@redhat.com>

On Fri, Nov 24, 2023 at 04:03:39PM +0100, Ivan Vecera wrote:
> Use existing i40e_find_vsi_by_type() to find a VSI
> associated with flow director.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


