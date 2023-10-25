Return-Path: <netdev+bounces-44187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4C67D6DB8
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 15:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A56E1C20DB6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC9028DC7;
	Wed, 25 Oct 2023 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA86cTSl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6B286BF;
	Wed, 25 Oct 2023 13:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BF9C433C7;
	Wed, 25 Oct 2023 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698242006;
	bh=BzZxXKB6ND83t8LaI75wzt2O+Kn3r/8Nnd8i6hbOp7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FA86cTSl7HGBPSaxtca2j/4QVfhVL87NefwHvRZ1tqGutszG9JM+EIB5aLsHYZQVH
	 NzP/p7aTtBX7rIpIBD5PybwU66cIWh2a5YtryIGH7WfyvqJeq0fVn/ZKZhu/XNjz2y
	 a6MP0tupxsUOiuwyreB+DFPK3I//IOWNGDXzS1M/vpxZJw3GTphh7sd7zPRv+lnDr9
	 j2O8AFD0zsgTFa+uf3ecKLH339nVMlpX/jKwDukvGTcxyFMb2kJ3mUoHnQzy+dSbxw
	 m000w2yVasMt2gzrYaPtDcWOCKHvTVScHLddfqIDt3FlbhcmtumaO7kNKkUDuAA1Ax
	 4tfCeobxnpQ2A==
Date: Wed, 25 Oct 2023 06:53:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Ido Schimmel <idosch@idosch.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, victor@mojatatu.com,
 martin.lau@linux.dev, dxu@dxuuu.xyz, xiyou.wangcong@gmail.com
Subject: Re: [PATCH net-next v2 1/2] net, sched: Make tc-related drop reason
 more flexible
Message-ID: <20231025065324.55fcd89e@kernel.org>
In-Reply-To: <87dfbac5-695c-7582-cbb5-4d71b6698ab1@iogearbox.net>
References: <20231009092655.22025-1-daniel@iogearbox.net>
	<ZTjY959R+AFXf3Xy@shredder>
	<726368f0-bbe9-6aeb-7007-6f974ed075f2@iogearbox.net>
	<CAM0EoM=L3ft1zuXhMsKq=Z+u7asbvpBL-KJBXLCmHBg=6BLHzQ@mail.gmail.com>
	<87dfbac5-695c-7582-cbb5-4d71b6698ab1@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 13:52:43 +0200 Daniel Borkmann wrote:
> Ido, Jamal, wdyt about this alternative approach - these were the locations I could
> find from an initial glance (compile-tested) :

If we were to vote on which is better, I vote for this approach.

