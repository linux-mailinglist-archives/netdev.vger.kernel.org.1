Return-Path: <netdev+bounces-61731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC16E824C0C
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 01:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C042B212A0
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 00:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCCA810;
	Fri,  5 Jan 2024 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjdBvfnU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F77F4
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 00:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15D2C433C7;
	Fri,  5 Jan 2024 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704413362;
	bh=zEvRjWyA7SkfXmH3Uhivpgqdxd7giSbWmbOtUPa4SvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OjdBvfnUbBBPZ1/RFnlF/ZBKlUkWXlrnT145XpuOErYOAp/8iqypNNh9fJrdENfEU
	 8HoeYQ/umAtoz0T2BwV6ZbJpFrz1QhZNogmhp2wyRlEF/FlltVNoh0U7eX7KEWstZN
	 oNF4+UQgAco0UhOJU+3OdWzt/f/bd8AzshtvIS70UEf+ZO+qiQVh8XsK1C4NxpBOaf
	 Ak44ug8gH3yLDYGMJP3MLU9k3Ciimah4tEdL2N1YGDKp+prah+VQwM46dhMNjsk4Qt
	 6almU3gOHserPq0kItv6DXRoPc7lauPNOz2K2ZRsh57RAHPeBk6Xv8IqUaeiclP804
	 VlAnnrULB2Z4Q==
Date: Thu, 4 Jan 2024 16:09:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
 michal.michalik@intel.com, rrameshbabu@nvidia.com
Subject: Re: [patch net-next 0/3] dpll: expose fractional frequency offset
 value to user
Message-ID: <20240104160920.4c9855fd@kernel.org>
In-Reply-To: <20240103132838.1501801-1-jiri@resnulli.us>
References: <20240103132838.1501801-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jan 2024 14:28:35 +0100 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Allow to expose pin fractional frequency offset value over new DPLL
> generic netlink attribute. Add an op to get the value from the driver.
> Implement this new op in mlx5 driver.

Arkadiusz, Vadim, acks?
-- 
pw-bot: needs-ack

