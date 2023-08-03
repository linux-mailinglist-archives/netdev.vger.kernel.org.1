Return-Path: <netdev+bounces-24027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C436A76E803
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C341C214F5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1D1ED32;
	Thu,  3 Aug 2023 12:14:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3F1EA8A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 12:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C6CC433C8;
	Thu,  3 Aug 2023 12:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691064846;
	bh=8Va26m7fbnJ/ST39Sj+/utRZQ0R99ngg6Awok+mes2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dA/MX1ZxNEyGdlcc9k40RYQ90f6hRY7tsIc4PDMYzYfOdXGBQ7t4kja5gLrs/KxgN
	 BjSZ1pZ2K9yTIqMM0YloCimfpjNZkAyg0DrJ5ULSojw1jtkFsaaRMhtBam4/tjd56O
	 C6F9KfiUhbLOvgXps2/R31w7RifUWbJdG2+qlwJ+vvrbq4YGAgsOV7XQ7e7h31MDhN
	 VXreudJ8GRNDgCMn9AqspkFCOAHb/yiHb8qbEaIaKsfWY3aN8m8t2GZYiLXA9XS36X
	 zffWN90Vjhf6iw5rcVcb2aZZ2Sx/MR2ZO/LvUzGSu7MuE/ZzV9gzohy2qz+lzcloF6
	 SNgk4H9c2AZLA==
Date: Thu, 3 Aug 2023 14:14:01 +0200
From: Simon Horman <horms@kernel.org>
To: Sonia Sharma <sosha@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
	mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v3 net] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Message-ID: <ZMuaCetqzgRsMDvd@kernel.org>
References: <1691023528-5270-1-git-send-email-sosha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691023528-5270-1-git-send-email-sosha@linux.microsoft.com>

On Wed, Aug 02, 2023 at 05:45:28PM -0700, Sonia Sharma wrote:
> From: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> The switch statement in netvsc_send_completion() is incorrectly validating
> the length of incoming network packets by falling through to the next case.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> 
> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>

Hi Sonia,

if this is a bug-fix, which seems to be the case, then it probably warrants
a Fixes tag.

