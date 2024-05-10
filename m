Return-Path: <netdev+bounces-95535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A438C2869
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3885E1F219CF
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AF3171647;
	Fri, 10 May 2024 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU0qwAeQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109813C3C8
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357018; cv=none; b=YTDweMYl1MxthioHB4MCKJ7F4eYtnsLWEGoOp2nG0ckPoCzzb+YcITSdCe4NserbV1B79LnQBE/crag70cdi5zQ1gXt1DyGOUYJoodj4o+ykAL3y5Qz6Iy5kV6JdXDMUTBK8NRvVnMtM0RIPpwCs0Qsx2HuESY8AtBRfk3c2Adg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357018; c=relaxed/simple;
	bh=XBwKyvNE1vaxRaUJ17FMAGttIl9BG5Od7i387c651bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4zT3+c/+r9/kbMQrZX4J6PBmHZccNZ7axB56F2FXbUIUgBpNpcqBMkxBV722wbkNClLEn3r3ffp/3NvhOJC1jBJgw31fTeXh1oI4+2ua/d4FonY45bcyrm2T5evwNhLH0287DrWHJf5wxHPmIpEXbXlBBxtyzzrA8ThMMYtiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU0qwAeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7933C2BBFC;
	Fri, 10 May 2024 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715357018;
	bh=XBwKyvNE1vaxRaUJ17FMAGttIl9BG5Od7i387c651bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CU0qwAeQbfNKGg/3xwgTiEECuIqu9C0t01C4yiP+jXslvrerU8CtwlzKQ5D7DppiB
	 k3d+OsxKy2+bCrhzfuYlQmQjExa1C1wMLnJC0RfF/19/GYGALN0hDv3/9kIT1vC6qN
	 Ap0vKuboQd8afNb496NX9rmtKnRYuq6RG14xtuQuKJAvy/vJlZIKaOegZYQFuKDFf+
	 AjhAhznfWMuU5qRxL10F5BILjMQPBREh3Tnuume6SgAC2JyTnGprAlDlJHbaDMaYjc
	 jPuJC1w40ORQZKQFI8w8x+LuLlHpBu5OpC2bS5P5F7tZD08XiR85xpW0ydawFens3+
	 dAyTYOuESKQbw==
Date: Fri, 10 May 2024 09:03:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Jaehee Park <jhpark1013@gmail.com>, Petr Machata <petrm@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, Davide Caratti <dcaratti@redhat.com>, Matthieu Baerts
 <matttbe@kernel.org>, netdev@vger.kernel.org
Subject: Re: [TEST] Flake report
Message-ID: <20240510090336.54180074@kernel.org>
In-Reply-To: <20240510074716.1bbb8de8@kernel.org>
References: <20240509160958.2987ef50@kernel.org>
	<20240510083551.GB16079@breakpoint.cc>
	<20240510074716.1bbb8de8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 07:47:16 -0700 Jakub Kicinski wrote:
> On Fri, 10 May 2024 10:35:51 +0200 Florian Westphal wrote:
> > Jakub Kicinski <kuba@kernel.org> wrote:  
> > > To: Florian Westphal <fw@strlen.de>
> > > 
> > > These are skipped because of some compatibility issues:
> > > 
> > >  nft-flowtable-sh, bridge-brouter-sh, nft-audit-sh
> > > 
> > > Please LMK if I need to update the CLI tooling. 
> > > Or is this missing kernel config?    
> > 
> > No, its related to the userspace tooling.
> > This should start to work once amazon linux updates nftables.
> > 
> > bridge-brouter-sh would work with the old ebtables-legacy instead
> > of ebtables-nft, or a more recent version of ebtables-nft.
> > 
> > ATM it uses a version of ebtables-nft that lacks "broute" table emulation.  
> 
> Amazon Linux is more of a base OS for loading containers it seems.
> I build pretty much all the tools from source.
> 
> So I just built nft too.. Whether it will actually work we'll find
> out in about 15 min :)

M. Looks like that didn't do anything.

I tried to investigate nft_audit.sh

https://netdev-3.bots.linux.dev/vmksft-nf/results/589221/22-nft-audit-sh/stdout

  # selftests: net/netfilter: nft_audit.sh
  # SKIP: nft reset feature test failed: nftables v1.0.9 (Old Doc Yak #3)
  ok 1 selftests: net/netfilter: nft_audit.sh # SKIP

This is what it hits:

  bash-5.2# nft -v
  nftables v1.0.9 (Old Doc Yak #3)
  bash-5.2# nft --check -f /dev/stdin <<EOF
  add table t
  add chain t c
  reset rules t c
  EOF
  /dev/stdin:3:7-11: Error: syntax error, unexpected string, expecting counter or counters or quotas or quota
  reset rules t c
        ^^^^^

What does that mean in lay terms? 

Question #2, for the ebtables test - do I need to build iptables?
I built nft with
	./configure --with-json --with-xtables 
but no xtables-nft-multi popped out.

