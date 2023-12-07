Return-Path: <netdev+bounces-55013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257548092E4
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C370A1F2104D
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516DB4F8A8;
	Thu,  7 Dec 2023 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz4AONX6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B44EB5F
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 21:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F314C433C8;
	Thu,  7 Dec 2023 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701982818;
	bh=vTSkZgS3yRD2B1yLv9apzX2F+dkr3FwdeF7xflMrCtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iz4AONX6X/BtzXj999nUwnLWii2CiuNnS+4Qcm+50kzXhF/tIN6fot6pwkeEMQUBv
	 +TYGtYN3FI7qNLdTSf91xBR6I+lVSv3HwyAShywxxCPTzvxeiUP+Bquag0SrXtG3YG
	 ukBXpE/6NOa34TzYj/lIWj9owauUeonNh3S5RPlODqDYYCoqO1yqA0063PT/VXhJoR
	 uZb7kQQnDqoKIf2r8m3n1yQKF33bHPUWnLoHZvVeirxlNHt4GwJfUCSvWgK5nTIRxb
	 H+KbUCg6rSgeuvaoPOa/4z3CVTYBKm1oZaOtIIrKp8SOO2NMHjPZG/f8aOzYVGhEkb
	 vw1bgcqU+UOaQ==
Date: Thu, 7 Dec 2023 21:00:13 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us,
	marcelo.leitner@gmail.com, vladbu@nvidia.com,
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 2/5] rtnl: add helper to check if a
 notification is needed
Message-ID: <20231207210013.GK50400@kernel.org>
References: <20231206164416.543503-1-pctammela@mojatatu.com>
 <20231206164416.543503-3-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206164416.543503-3-pctammela@mojatatu.com>

On Wed, Dec 06, 2023 at 01:44:13PM -0300, Pedro Tammela wrote:
> From: Victor Nogueira <victor@mojatatu.com>
> 
> Building on the rtnl_has_listeners helper, add the rtnl_notify_needed
> helper to check if we can bail out early in the notification routines.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


