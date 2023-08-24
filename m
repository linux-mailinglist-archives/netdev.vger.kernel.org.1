Return-Path: <netdev+bounces-30177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58689786497
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 03:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F060428115A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 01:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616E15D1;
	Thu, 24 Aug 2023 01:34:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52907F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F616C433C7;
	Thu, 24 Aug 2023 01:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692840877;
	bh=PQrwDigNjMv7cW0P8U7Uw4s2N6O9NLJUackKIozT5Mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SZB0F2o3Fs5iTOxdOuFyDoqKQTRccqeIBagyDnaZ92NOZM7Foh4kGsGLVHElhs+g+
	 jurfuLpOR1ifSkNXg+BjW3o5xSDgLvywsbBiQR/CfZoxCEC5EEmvzCuZLexCEBEEp3
	 +VUlSyiHadDO7YY5ggiATagEz+uuDnCfEKxGe1cHDXv9+mHtidkOfKQB0gM4ZEYE0L
	 1bOa6sN9IsqC5MXrT5Itdo0ZxwHKQAO9VAzhamh5rcz2Sbj69FKzJzS5ioLhjCnFYu
	 NKraLP0tqSLu0zhFw1YOdBWqgfSYhCAzB+LgxyPBHawPQoVKdRazITVbyDvHI4jaWi
	 1inc1/DZ0OZhQ==
Date: Wed, 23 Aug 2023 18:34:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v2 3/9] netdev-genl: spec: Extend netdev
 netlink spec in YAML for NAPI
Message-ID: <20230823183436.0ebc5a87@kernel.org>
In-Reply-To: <d4957350-bdca-4290-819a-aa00434aa814@intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
	<169266032552.10199.11622842596696957776.stgit@anambiarhost.jf.intel.com>
	<20230822173938.67cb148f@kernel.org>
	<d4957350-bdca-4290-819a-aa00434aa814@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Aug 2023 17:46:20 -0700 Nambiar, Amritha wrote:
> Can we have both: "queue-get" (queue object with with NAPI-ID attr) and 
> "napi-get" (NAPI object with "set of queue IDs" as an attribute), 
> something like below (rx-queue is the queue object. rx-queues is the 
> list attr within the NAPI object):

I think just queue-get is better, the IDs of queues are not unique.
It's more of an index within a group than and identifier. 
Displaying information about e.g. XDP TX queues within would get messy.

