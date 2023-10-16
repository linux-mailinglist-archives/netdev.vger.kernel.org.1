Return-Path: <netdev+bounces-41601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C5D7CB69D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D581C20AEF
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B6E374D2;
	Mon, 16 Oct 2023 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSKVEQoD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228873AC02
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 22:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A56C433C8;
	Mon, 16 Oct 2023 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697495750;
	bh=+NatZTy8kx5lZ6MZqiSQUNUOA8ElWWl8i6aIudsZPWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XSKVEQoDRMmfcxTS14nJz6vKvLQOPdxGuvKs+E/rhMVUeRoO4ZSlkTTH8YkuBZWtM
	 B7TYoYaqIzcfUu2Y685j06IpW5B1Og0E2lVrba6/7YtOKoHgqBKBYjcprtBhCd3zrG
	 e3GNRv4QoqEaalDtonKddFHTqzg2vIVo/fUCYWsO7yRdm3R2LF4NrGrRj9ny0xW6Hn
	 tXnIkMw9cmvl8F4op7AnOh+LhKDvGervVqjHgd5iP5FWV7pxChTJqqdrsqzmw7WaJx
	 3hDFdR0mPc4GHcYWyU6B5q6BbBodspRVNo/ryQDSOStyb/jqrACBzAAa0XHTSsy6dZ
	 PrsO9fBVrh4eg==
Date: Mon, 16 Oct 2023 15:35:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, anjali.singhai@intel.com,
 namrata.limaye@intel.com, deb.chatterjee@intel.com,
 john.andy.fingerhut@intel.com, dan.daly@intel.com, Vipin.Jain@amd.com,
 tom@sipanda.io, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com,
 mattyk@nvidia.com
Subject: Re: [PATCH v7 net-next 00/18] Introducing P4TC
Message-ID: <20231016153548.1c050ea3@kernel.org>
In-Reply-To: <CAM0EoMmA3_9XmTFk5H-0oR5qfEYtxq_1Vc2zRVKfA_vtVTmafg@mail.gmail.com>
References: <20231016093549.181952-1-jhs@mojatatu.com>
	<20231016131506.71ad76f5@kernel.org>
	<CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
	<CAM0EoM=ZGLifh4yWXWO5WtZzwe1-bFsi-fnef+-FRS81MqYDMA@mail.gmail.com>
	<CAM0EoMmA3_9XmTFk5H-0oR5qfEYtxq_1Vc2zRVKfA_vtVTmafg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 17:44:20 -0400 Jamal Hadi Salim wrote:
> > Verified from downloading mbox.gz from lore that the tarball was
> > reordered. Dont know if it contributed - but now compiling patch by
> > patch on the latest net-next tip.  
> 
> Never mind - someone pointed me to patch work and i can see some
> warnings there. Looks like we need more build types and compiler
> options to catch some of these issues.
> We'll look into it and we will replicate in our cicd.

patch-by-patch W=1 C=1 should be good enough to catch the problems.

