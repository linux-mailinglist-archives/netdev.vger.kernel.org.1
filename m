Return-Path: <netdev+bounces-28324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9CC77F0DD
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A00281D9C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5536138A;
	Thu, 17 Aug 2023 07:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0EECA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D054FC433C7;
	Thu, 17 Aug 2023 07:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692255871;
	bh=rdV06VU8Vr9G0/SeQ08wsyL69eqgFAOeDTJpLasfTMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5AgubNrrsicMaOjQfN8AoEZeE68HiAbeMYefAnNsH5Qs2U95/HSlND/wV+S/htmU
	 dCMRj6TCeEKxH8E6aGoSHvxDXlMlL2DweUNEWhQgfJNWYWXJo5kUrHeMeDLQwleodL
	 kTtXa+5oqzK15BoCl8+sHSK5Y8eEQUH+DNSOpGG+/5OJHqElrwxeRj10kunYu+NFof
	 WOpAxVUJUFL8XionwekV2TRSfP7ujZtKoVeeHUb7wDxsa/rE53Jt15Une4qiygG+h6
	 zzc18gE859JB7rriblqn6jELSrS2w4BXZcTmaWBLgkbLkin5rhwFkjFjcS/0Uwi561
	 flSqkbknW+JQQ==
Date: Thu, 17 Aug 2023 09:04:26 +0200
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>, leon@kernel.org,
	jiri@resnulli.us, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net] ice: Block switchdev mode when ADQ is active and
 vice versa
Message-ID: <ZN3GegKGyZQSAxYA@vergenet.net>
References: <20230816193405.1307580-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816193405.1307580-1-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 12:34:05PM -0700, Tony Nguyen wrote:
> From: Marcin Szycik <marcin.szycik@linux.intel.com>
> 
> ADQ and switchdev are not supported simultaneously. Enabling both at the
> same time can result in nullptr dereference.
> 
> To prevent this, check if ADQ is active when changing devlink mode to
> switchdev mode, and check if switchdev is active when enabling ADQ.
> 
> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


