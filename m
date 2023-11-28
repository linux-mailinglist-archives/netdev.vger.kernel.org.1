Return-Path: <netdev+bounces-51729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A52A7FBE1B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899D128233B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3C5D4B2;
	Tue, 28 Nov 2023 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJmwSBZj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61675381C
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151C4C433C9;
	Tue, 28 Nov 2023 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701185460;
	bh=GIK1xX/svESsdE1gk/lDqN9EU1IypcEMsMYNvfhVjg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AJmwSBZjhwmQUYqpcGYoVF+xf77bw30XfKnyht8HtFuD0YVeDvSj8p/QHI5qYRhgZ
	 R2oGmwkQg3Z1tZXN+f5D0gO7FEFtqQtc7XQZZhILz75U5QFp79Tw96gmlBYQVaADr4
	 +jgWtPeIz5HKXsGimEvgE9ONRXqf5AJ1Qgz71aSO5qVk3LGU7O8pYzbC5e/etvAsim
	 Qbt7M3Q0WHk6i79aY/hvIPJvQCjw5XKtGZ/t/13HnZKga8eP6IfoPgrsbgTaiae6cN
	 ijuXLbUdVY+PimZ4nLDe1WXF/UBAfOr801M42GxwCmGWPCcGhZAKvvvtboH8kaZhgw
	 1ysxhZk7e3awQ==
Date: Tue, 28 Nov 2023 07:30:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, corbet@lwn.net
Subject: Re: [patch net-next] docs: netlink: add NLMSG_DONE message format
 for doit actions
Message-ID: <20231128073059.314ed76b@kernel.org>
In-Reply-To: <20231128151916.780588-1-jiri@resnulli.us>
References: <20231128151916.780588-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 16:19:16 +0100 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In case NLMSG_DONE message is sent as a reply to doit action, multiple
> kernel implementation do not send anything else than struct nlmsghdr.
> Add this note to the Netlink intro documentation.

You mean when the reply has F_MULTI set, correct?

