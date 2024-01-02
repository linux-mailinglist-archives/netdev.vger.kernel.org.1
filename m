Return-Path: <netdev+bounces-61026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4842582247C
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACDA1C22B6D
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80609171B7;
	Tue,  2 Jan 2024 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FryaLKuk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED21A734
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2630AC433C8;
	Tue,  2 Jan 2024 22:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704232954;
	bh=EbY85eJKonMkWrOzkVQ2y8+vEbfHIAu/nyHcd2U0JRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FryaLKukFnVbvH9IPMCsQeLqI1JszQ77PNBhLol2J4mmXly9+ZUf0tVsP1A4IbWGX
	 jIo9xkOxfG3FEvwIkznI4bdcpElOnsRQEgoeqjwivkh7+RobvNXy4g9WppnvwiZOfn
	 RW083IR+0jVL2lKzGZdxos+y/4PL/LBvd+2cpqI1q66r23Pg7jO+h57LVzkvjgCeaL
	 njTGsisPowZCMjJWS4dMVI1VfIbc0cIA46YYIJmzcTu9vKYS0LtZpS0X2Oaavrv5Bl
	 MBn0UmIGDB3IS/LLZsqvoheo4DyET1VTK/7zGd568dVDGzph54Rz7kCf04WjS3B61M
	 EbcgRKGlMYayg==
Date: Tue, 2 Jan 2024 14:02:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Shachar Kagan <skagan@nvidia.com>, netdev@vger.kernel.org, Bagas Sanjaya
 <bagasdotme@gmail.com>, "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
Message-ID: <20240102140232.77915fc3@kernel.org>
In-Reply-To: <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
	<CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jan 2024 10:46:13 +0100 Eric Dumazet wrote:
> > The issue appears while using Vagrant to manage nested VMs.
> > The steps are:
> > * create vagrant file
> > * vagrant up
> > * vagrant halt (VM is created but shut down)
> > * vagrant up - fail
> 
> I would rather have an explanation, instead of reverting a valid patch.

+1 obviously. Your refusal to debug this any further does not put 
nVidia's TCP / NVMe offload in a good light. On one hand you
claim to have TCP experts in house and are pushing TCP offloads and
on the other you can't debug a TCP issue for which you reportedly 
have an easy repro? Does not add up.

