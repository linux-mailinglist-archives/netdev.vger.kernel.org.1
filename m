Return-Path: <netdev+bounces-29832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F9784DE2
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49751C20BDD
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606E0EBE;
	Wed, 23 Aug 2023 00:39:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5357E2
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36786C433C8;
	Wed, 23 Aug 2023 00:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692751179;
	bh=rvM9bABqIjPxDAOcSHpte0mdVS/ms2d4a3HN0F4owaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IT9Orx16op41AyusO/3AUDrFbiJg6vpQIQl5URfe2AeZuJc0RnjeK2mMk+XNMPteY
	 2nBKRJKvJEpzX9XBK/0av7Wm3ldvctvN+oWJjjHseRv2Y+BVVlT9CGfHefa04qOkNE
	 WEdAAoT+CRMnk33BMgW+MfbloC4JkkxZowu6pQv3KZos6OLB4eJAa2CUYUcF6ouvrQ
	 7buA8pzhGb2r4O3FHP7FhOF1+B6IS9Dxqx0VrPq+tAg56mytL0ibRagynwPAXNLISH
	 rVygK48hDCBXmn1Y6IF3ukGcA7LR/b4m4JXQL2DP5vZxxYJTWqfGZ9xrpoEIAX+Gv5
	 xyRPVYY9eNM7g==
Date: Tue, 22 Aug 2023 17:39:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v2 3/9] netdev-genl: spec: Extend netdev
 netlink spec in YAML for NAPI
Message-ID: <20230822173938.67cb148f@kernel.org>
In-Reply-To: <169266032552.10199.11622842596696957776.stgit@anambiarhost.jf.intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
	<169266032552.10199.11622842596696957776.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 16:25:25 -0700 Amritha Nambiar wrote:
> +      -
> +        name: rx-queues
> +        doc: list of rx queues associated with a napi
> +        type: u32
> +        multi-attr: true
> +      -
> +        name: tx-queues
> +        doc: list of tx queues associated with a napi
> +        type: u32
> +        multi-attr: true

Queues should be separate objects, with NAPI ID as their attr.
That's much simpler - since the relation is 1:n it's easier 
to store it on the side of the "1".

