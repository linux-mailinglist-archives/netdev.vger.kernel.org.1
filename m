Return-Path: <netdev+bounces-58016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55CA814D7B
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 17:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112B9B20DE4
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F803DB90;
	Fri, 15 Dec 2023 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQkDdn87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F763C48A
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 16:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0517C433C7;
	Fri, 15 Dec 2023 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702658966;
	bh=5PHuAaFaCYATOtsy7iWNG+199rmb+dNu49WRu/iAdQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pQkDdn87YTPWYCQ/njtT2ma80iQYV9Id5HGXdWE7+Cqn+zQ+/qB//f1TRNgOIsvFt
	 pfz7zwFPoRwSzc6QH1wOJWw8Z1Znl2ZXCrVKCGE0hbyx1MRtjqFa38BJMxt8uW0Bm/
	 3Va4Sb9724teO9KOEibnh/+P15a3cpREvF0c4R+66liJoK/SnuEdzVE1D8F0HR8/OV
	 /GYILjEV8V/ioVVWhk2vIPgzyID6OwfIFWO8dJXwkIUCMW6OMcgYgYsBXaYBrwDOTY
	 y7qkKsuhfQHJBSH21o75JYRHzkv2uqiWwA1KBUa/Ga+F40oS+hJ/6eOp13jp+b2B8H
	 QgRDF6QCoa8Ag==
Date: Fri, 15 Dec 2023 08:49:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 <pabeni@redhat.com>, Marcin Szycik <marcin.szycik@linux.intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, <michal.swiatkowski@linux.intel.com>,
 <wojciech.drewek@intel.com>, <idosch@nvidia.com>,
 <jesse.brandeburg@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <jiri@resnulli.us>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/7] Add PFCP filter
 support
Message-ID: <20231215084924.40b47a7e@kernel.org>
In-Reply-To: <67e287f5-b126-4049-9f3b-f05bf216c8b9@intel.com>
References: <20231207164911.14330-1-marcin.szycik@linux.intel.com>
	<b3e5ec09-d01b-0cea-69ea-c7406ea3f8b5@intel.com>
	<13f7d3b4-214c-4987-9adc-1c14ae686946@intel.com>
	<aeb76f91-ab1d-b951-f895-d618622b137b@intel.com>
	<539ae7a3-c769-4cf6-b82f-74e05b01f619@linux.intel.com>
	<67e287f5-b126-4049-9f3b-f05bf216c8b9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 11:11:23 +0100 Alexander Lobakin wrote:
> Ping? :s
> Or should we resubmit?

Can you wait for next merge window instead?
We're getting flooded with patches as everyone seemingly tries to get
their own (i.e. the most important!) work merged before the end of 
the year. The set of PRs from the bitmap tree which Linus decided
not to pull is not empty. So we'd have to go figure out what's exactly
is in that branch we're supposed to pull, and whether it's fine.
It probably is, but you see, this is a problem which can be solved by
waiting, and letting Linus pull it himself. While the 150 patches we're
getting a day now have to be looked at.

