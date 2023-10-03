Return-Path: <netdev+bounces-37604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736037B650A
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2DEFD2815E8
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D26DDD3;
	Tue,  3 Oct 2023 09:11:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B1DDBB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17873C433C7;
	Tue,  3 Oct 2023 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696324289;
	bh=sUJeEe48D2XXjuCwdcPCyeYpUaPxkhef6oUgEsrjnUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2/1w0T7XY8ZeFQxqUXzMusBMj6CEwpJae3BrWanTJdmQfo2nQKg51bDvYYCc24xJ
	 yqVjf5AO0MjK5P16yNcWCd0gp2jOTZOsWm88D6rrXUPfi987F7QUUQY6nNsDEYhxRA
	 S75HfZTfRcWcUu2VjTz9CnFvDD22dovEuDSwfM/GNTBGHs07J0uL7QNZi0bnxNc2I5
	 WX/VzjNNcbGAxHVtVc3SPj4fQxWt3DRcTkESIFlsHCYXyrQPKXcUb1L4XbQvfHSWm3
	 592//+vfZklXle7KeFB5J1H4mdQVfB8VB4V3C7xqrdDnNGocEODVm3xuU+xWZuIaVK
	 Xy1uDX9j5ivtQ==
Date: Tue, 3 Oct 2023 11:11:25 +0200
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com
Subject: Re: [PATCH net-next v2 0/9] bnxt_en: hwmon and SRIOV updates
Message-ID: <ZRvavSBq/1WS1bcs@kernel.org>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927035734.42816-1-michael.chan@broadcom.com>

On Tue, Sep 26, 2023 at 08:57:25PM -0700, Michael Chan wrote:
> The first 7 patches are v2 of the hwmon patches posted about 6 weeks ago
> on Aug 14.  The last 2 patches are SRIOV related updates.
> 
> Link to v1 hwmon patches:
> https://lore.kernel.org/netdev/20230815045658.80494-11-michael.chan@broadcom.com/
> 
> Kalesh AP (6):
>   bnxt_en: Enhance hwmon temperature reporting
>   bnxt_en: Move hwmon functions into a dedicated file
>   bnxt_en: Modify the driver to use hwmon_device_register_with_info
>   bnxt_en: Expose threshold temperatures through hwmon
>   bnxt_en: Use non-standard attribute to expose shutdown temperature
>   bnxt_en: Event handler for Thermal event
> 
> Michael Chan (1):
>   bnxt_en: Update firmware interface to 1.10.2.171
> 
> Sreekanth Reddy (1):
>   bnxt_en: Support QOS and TPID settings for the SRIOV VLAN
> 
> Vikas Gupta (1):
>   bnxt_en: Update VNIC resource calculation for VFs

For series,

Reviewed-by: Simon Horman <horms@kernel.org>



