Return-Path: <netdev+bounces-23850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2878776DDD1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89DB281491
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473841FBC;
	Thu,  3 Aug 2023 02:04:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718237F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889CDC433C8;
	Thu,  3 Aug 2023 02:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691028288;
	bh=VoYMZ75XpSCUXjKThqqSy90wfansrm2lti0KuWyf8OI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZzsI2lBxkv8YiQcUF0s0YfxiHCC6Xm9S6EqVCtef5tyzFc+c/+7LxWggsjtHDfxzJ
	 DdFPuFfwhXSas5zY5HPCUMK4//jXXSJyrq1zLNbZY/uwSX3+y6V/NAKGw/ZJ2n2qsD
	 GI6y0/+fd7jOrKELdt+j74zGzUsWUvZPcEPOx4vcDP/QshDIkhpRkCK8UQF/pzAIc9
	 ZkKyxNhHIStxx97Ok/hnu4jJi9eWqzuKevQfzlJ5m67SZlAUaXevTiunKQfg8IMrUN
	 6EKe2ip3kFK2zEz7/82IvPu+6YZYtmeVMoJKPUGCUaSIWiEdG0RBZVgZKGeHpvLMzu
	 W4fJ3ktc84iXg==
Date: Wed, 2 Aug 2023 19:04:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 10/11] devlink: introduce couple of dumpit
 callbacks for split ops
Message-ID: <20230802190446.32431c50@kernel.org>
In-Reply-To: <20230802152023.941837-11-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
	<20230802152023.941837-11-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Aug 2023 17:20:22 +0200 Jiri Pirko wrote:
> +int devlink_nl_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
> +{
> +	return devlink_nl_dumpit(msg, cb, devlink_nl_get_dump_one);
> +}
> +
>  
>  static void devlink_reload_failed_set(struct devlink *devlink,

nit double new line

