Return-Path: <netdev+bounces-44208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433247D7171
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83AE281C72
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53962E63D;
	Wed, 25 Oct 2023 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhe4jh7N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D211DA5B
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0623C433C7;
	Wed, 25 Oct 2023 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698250106;
	bh=qujSkRF7+AONGoOyzL5iEs4HyhHB1A7/KwcVxpI/2zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hhe4jh7N3pSu+gEqdcyo7MNZVayhegtdhvTp999RtA/HrfW08chTo4Jn4dOi2LsGE
	 V6BeYiJ12107KrejTtMO4sqS+Ggb+/Mv3Cqs2bKxy4JUDJ7/RHXr1xFsMKHd+cuOKN
	 JEbdfCMnY+ipAb6YmSB9DIA+5NTYXYE4ho6tXpX4wRm2LaoUqCdBrX8SuyMmWslUqV
	 cM2NX5WohOLtXxOVHn4uOrbHOl/zIUasH2D1G4libVed1KbRiFdRv7Wkr5BlTfTjLg
	 cpGWVBwkPc/NczjX/MQ+xHLReVfTXxZeib+Klzj1PqYBrnrIqs9ob7sKG2pzZaqOti
	 2nva9RTu3q+qg==
Date: Wed, 25 Oct 2023 17:08:18 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Catherine Sullivan <catherine.sullivan@intel.com>,
	Anjali Singhai Jain <anjali.singhai@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR
Message-ID: <20231025160818.GJ57304@kernel.org>
References: <20231019135342.1209152-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019135342.1209152-1-ivecera@redhat.com>

On Thu, Oct 19, 2023 at 03:53:42PM +0200, Ivan Vecera wrote:
> The I40E_TXR_FLAGS_WB_ON_ITR is i40e_ring flag and not i40e_pf one.
> 
> Fixes: 8e0764b4d6be42 ("i40e/i40evf: Add support for writeback on ITR feature for X722")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks,

I agree that I40E_TXR_FLAGS_WB_ON_ITR is consistently used
as a i40e_ring flag, other than the case that is corrected by this patch.

I also agree that the problem was introduced by the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

