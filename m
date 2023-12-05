Return-Path: <netdev+bounces-54084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AEE805FB6
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94EE8B20FDC
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BBC6A01A;
	Tue,  5 Dec 2023 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4wAHStv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC16DD1B
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 20:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83137C433C7;
	Tue,  5 Dec 2023 20:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701809342;
	bh=fed1Khe3LcDNw8l1xszLr/0ELbkoHU+0quBAU6lvWFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4wAHStvUOAeCeta1YoWNlWxK5F+9eKD9UjWj2vao2iGNiI2rq+ii1dbijNu8FVXD
	 /ElX0695XmWiW2gKNDytWMDyF1gcWq1MnwuIiZallMJAbMhAZdcV8BywQshbFveNgg
	 OjMWttWxesqigO7tQqKMKI+83MxJKY/VQrROV42lhW0vQ9lkCZVKDyA9Zl5yCibn54
	 OGK7qPLs/CSP08WwFLJb2X3QEESeNNoXe8RywB6U3kqjAUhbC3tiWk3syeUlK7lxc0
	 HfSRl6YNyBlCRMqgkg383gGVjT/vMpZqNmvS6TUk6oCRBxSSyYRv/EvjheM/HW+Cio
	 Wry5devnCRNDw==
Date: Tue, 5 Dec 2023 20:48:58 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net] i40e: Fix wrong mask used during DCB config
Message-ID: <20231205204858.GY50400@kernel.org>
References: <20231130193135.1580284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130193135.1580284-1-ivecera@redhat.com>

On Thu, Nov 30, 2023 at 08:31:34PM +0100, Ivan Vecera wrote:
> Mask used for clearing PRTDCB_RETSTCC register in function
> i40e_dcb_hw_rx_ets_bw_config() is incorrect as there is used
> define I40E_PRTDCB_RETSTCC_ETSTC_SHIFT instead of define
> I40E_PRTDCB_RETSTCC_ETSTC_MASK.
> 
> The PRTDCB_RETSTCC register is used to configure whether ETS
> or strict priority is used as TSA in Rx for particular TC.
> 
> In practice it means that once the register is set to use ETS
> as TSA then it is not possible to switch back to strict priority
> without CoreR reset.
> 
> Fix the value in the clearing mask.
> 
> Fixes: 90bc8e003be2 ("i40e: Add hardware configuration for software based DCB")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

