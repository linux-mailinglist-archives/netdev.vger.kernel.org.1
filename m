Return-Path: <netdev+bounces-22529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A8E767EA1
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54381C20AAB
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F214A9C;
	Sat, 29 Jul 2023 11:23:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718843C2A
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 11:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ADDC433C8;
	Sat, 29 Jul 2023 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690629805;
	bh=CPTJ5Z6WlgW7UB/hlIq12BfQzW1KcHNN+l8dUL6xhNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efKJGx/rnSXr3xerEH42OfktHJyWwDhArspS+XP4lvt0nB5a2wM2+hnYoAIShLJ8V
	 44PR1dwSO5XkBo55po1vO6BA1G3PQdw82Sq9CzUJkd5M2asySWO/Uqpwh9ewuGsWMg
	 XPuET9u4hs6wmf/Me5J9XjkWdupvbWSAxJRyO0QgdLBQNbdb96miiXiCXLgjrbuO7w
	 efE4dFbJ4TfFYiVr90Jbx/jXpGIRd4YzUSJpBpAYQuzY79gy+OH4PAW+b5cuLQCkAo
	 uDMe0YdozNBbScWp50u6l1WGRu5IkbjZyqLtyiSHB9D/4QzQQCFjnmPpDMkswIpbhf
	 gR5LeyAPdDP+Q==
Date: Sat, 29 Jul 2023 13:23:22 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: Remove unused extern declaration
 devlink_port_region_destroy()
Message-ID: <ZMT2qukr6KbfZvKT@kernel.org>
References: <20230728132113.32888-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728132113.32888-1-yuehaibing@huawei.com>

On Fri, Jul 28, 2023 at 09:21:13PM +0800, Yue Haibing wrote:
> devlink_port_region_destroy() is never implemented since
> commit 544e7c33ec2f ("net: devlink: Add support for port regions").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

