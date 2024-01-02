Return-Path: <netdev+bounces-60816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F2082194E
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CE3B209BF
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3BCA62;
	Tue,  2 Jan 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPs5PDTk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F7D52C
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 09:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177E0C433C7;
	Tue,  2 Jan 2024 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704189519;
	bh=vip64XtW4PEdClEjGxO2eiY1n6yTgIVmTdgk8MEtMYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPs5PDTkWrjT16Z17aMlPDKUlBBSjT+Vuu3SRn5Iyiepk8c4xazgR8lu1ODRxdwX8
	 yKCgn+ckuAKQVCHkyMKET/5N1S4tQZG/qXlTlvv8F67wyh51hdGXERDwTdhCPAdPex
	 Sz60q+Ez/eEg+8RP80vMaJfcuf/ee/T1xMvVIkxK9yXUihpDUGN5ACGiRn0q4gpiCB
	 CtQ0WD6MFcUhkE2ptjKspzPb9iEIkDxCPYVpwTcpxiT2bXPbP/ofu953ECg/NVv87f
	 CtiDnZfV2sH34bHR7fbs98Ft68COFGGbHdYXA6/LUqKCwBlnk5LX2sWhVGvJK8H/32
	 f+cA16PglgEww==
Date: Tue, 2 Jan 2024 11:58:35 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shachar Kagan <skagan@nvidia.com>, netdev@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
Message-ID: <20240102095835.GF6361@unreal>
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
 <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>

On Tue, Jan 02, 2024 at 10:46:13AM +0100, Eric Dumazet wrote:
> On Tue, Jan 2, 2024 at 10:01 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Shachar Kagan <skagan@nvidia.com>
> >
> > This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
> >
> > Shachar reported that Vagrant (https://www.vagrantup.com/), which is
> > very popular tool to manage fleet of VMs stopped to work after commit
> > citied in Fixes line.
> >
> > The issue appears while using Vagrant to manage nested VMs.
> > The steps are:
> > * create vagrant file
> > * vagrant up
> > * vagrant halt (VM is created but shut down)
> > * vagrant up - fail
> >
> 
> I would rather have an explanation, instead of reverting a valid patch.
> 
> I have been on vacation for some time. I may have missed a detailed
> explanation, please repost if needed.

Our detailed explanation that revert worked. You provided the patch that
broke, so please let's not require from users to debug it.

If you need a help to reproduce and/or test some hypothesis, Shachar
will be happy to help you, just ask.

Thanks

