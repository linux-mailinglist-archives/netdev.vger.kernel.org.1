Return-Path: <netdev+bounces-95507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EDF8C271C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873392814A4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B86168AFC;
	Fri, 10 May 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfzpDqZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC314B08C
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352437; cv=none; b=KM89TGbkmWkTa/DnrEZdvRFSm49z+G7YAEr6Mbd/LieOUXWhG4yxF4iwKL3qzHk/NXiYJbZhMaWVMWnqgwri46+CwQVGNdepBQs7WN4ieWlbhYcKcZdJ0BYvvwxxjg+8KcCZkuZTIWGA5IqOgYuKbLt/+RTnn52Dnt3Y0TZ6dsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352437; c=relaxed/simple;
	bh=EYyOeoQBRO3RYS46og8PEBwdLs6MxQ3CUiTEv/EfvCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekmkGuJUYI25KcQE5z9/o9QRNVmZJXpy3zWVu5foriLMLTT8zzzG7QVYs4qJgMfdBQYkXnIKSh+bxj7wnNULseZJea+aoyVFjRe96E0OaQHuNszytiDR+ge9J30y071ZSFOlRyurLbVdgDxlzVSAJzxWyoEh7g1/7utQE5eVLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfzpDqZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541C5C113CC;
	Fri, 10 May 2024 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715352437;
	bh=EYyOeoQBRO3RYS46og8PEBwdLs6MxQ3CUiTEv/EfvCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cfzpDqZYXgK18IJahMJtGTfV5ajh5nWahv835zzhSkoBQFjY42be62eJ4gnVIJvPv
	 ap+Fz2x/Yr9frBQZRrXl479yhrzrhZhyNZ9eRoUpXumo/Bhb6AQtUweqvglR0tcxNA
	 jU+q8K0FiL8OyEvjUdDDTplW11UGweii4tY0yMjEKNSLoDqbjmivq2EJgxkjOCeTBM
	 lDCwhW4DwF8YLkNKdU05YHT2tPrDXefdXZrv1IlxxVnA0ZTLz0yrBFtgqgYlnJjdgS
	 +tQ5/9A2p/U+VcN8WzGWqQGXUdjiIUe0w7axfojlCtAlW+eJwS+EBZIGSNdBscX9ZM
	 tOwBi3HkXpeqw==
Date: Fri, 10 May 2024 07:47:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Jaehee Park <jhpark1013@gmail.com>, Petr Machata <petrm@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, Davide Caratti <dcaratti@redhat.com>, Matthieu Baerts
 <matttbe@kernel.org>, netdev@vger.kernel.org
Subject: Re: [TEST] Flake report
Message-ID: <20240510074716.1bbb8de8@kernel.org>
In-Reply-To: <20240510083551.GB16079@breakpoint.cc>
References: <20240509160958.2987ef50@kernel.org>
	<20240510083551.GB16079@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 10:35:51 +0200 Florian Westphal wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> > To: Florian Westphal <fw@strlen.de>
> > 
> > These are skipped because of some compatibility issues:
> > 
> >  nft-flowtable-sh, bridge-brouter-sh, nft-audit-sh
> > 
> > Please LMK if I need to update the CLI tooling. 
> > Or is this missing kernel config?  
> 
> No, its related to the userspace tooling.
> This should start to work once amazon linux updates nftables.
> 
> bridge-brouter-sh would work with the old ebtables-legacy instead
> of ebtables-nft, or a more recent version of ebtables-nft.
> 
> ATM it uses a version of ebtables-nft that lacks "broute" table emulation.

Amazon Linux is more of a base OS for loading containers it seems.
I build pretty much all the tools from source.

So I just built nft too.. Whether it will actually work we'll find
out in about 15 min :)

