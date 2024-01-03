Return-Path: <netdev+bounces-61111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94FD822826
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 07:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADAA1C22DED
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 06:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2117748;
	Wed,  3 Jan 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP1eTcNJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D817981
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 06:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BA4C433C8;
	Wed,  3 Jan 2024 06:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704261638;
	bh=xwuNN4GtyTgIPgIncwa6guFhminXMOrC5i7J2bn+ra4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MP1eTcNJjmXpt2o+n01u6gqlWQqWafE0KfJ0F8bG/NLNOI+SIDA0zf+PlnRswZrCW
	 ahyh36x+B8S/G12ur9N8yb2gnc3O1AiPkA2/G92I2fb80BQWitdpH2ixYyaU1xkf1j
	 TFXi80oW2zDD9scktT53Lr+uyxVdJxx8kblhMOst3j/vN5JSNJqBhOmBnbKi55Ln1E
	 1rVZV5I7CK5wkGhzQT6Oi/zsPcCdOhTKZWs8bkxddjItnA1D/pvkeN84OpzrfkW6LR
	 /BC9REEavkqDiu5gKXoeghVXq2WvdvXejquajG45Sz5X64+3VjaiVv8TXjgqk6536g
	 WpIGlvcm1OmuA==
Date: Wed, 3 Jan 2024 08:00:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Shachar Kagan <skagan@nvidia.com>,
	netdev@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
Message-ID: <20240103060033.GD5160@unreal>
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
 <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>
 <20240102140232.77915fc3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102140232.77915fc3@kernel.org>

On Tue, Jan 02, 2024 at 02:02:32PM -0800, Jakub Kicinski wrote:
> On Tue, 2 Jan 2024 10:46:13 +0100 Eric Dumazet wrote:
> > > The issue appears while using Vagrant to manage nested VMs.
> > > The steps are:
> > > * create vagrant file
> > > * vagrant up
> > > * vagrant halt (VM is created but shut down)
> > > * vagrant up - fail
> > 
> > I would rather have an explanation, instead of reverting a valid patch.
> 
> +1 obviously. Your refusal to debug this any further does not put 
> nVidia's TCP / NVMe offload in a good light. On one hand you
> claim to have TCP experts in house and are pushing TCP offloads and
> on the other you can't debug a TCP issue for which you reportedly 
> have an easy repro? Does not add up.

Did I claim about TCP experts? No.
Did we cause to Vagrant to stop working? No.
Did we write problematic patch? No.

So let's not ask from the people who by chance tested the code to debug it.

Thanks

