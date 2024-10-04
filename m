Return-Path: <netdev+bounces-131854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B16698FBA1
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED51A2837F4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37941D5AC0;
	Fri,  4 Oct 2024 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlP9PGaP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3817FE
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002370; cv=none; b=ELhKq6n+8nvTXiho4cAOASA81drzLwkaaNREY8FUOaxJX+RpErideE371sp0kS1mLkJRjpjyGfJkPObS3DiIU8SyQOiin5AHNgyeL4fehceQ5AkoimtmrfuIH9iyBQiHDaDitDLTvcQcRMRXpfCdME7iFgnuSR5VZ1Ms2RKRS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002370; c=relaxed/simple;
	bh=/QCdDuTjAcdtQ59f0q8/wzaabfLjBiWyX9Ufs/A2oYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rx1hzKTjdZgq3EK1bCnxHzE/ci9/rRjCtnkIEXzWf2+ABGT5MmasDmJ4vEsofNw0lGHlQaXKAFVlavMTS3DH06zYhEAT0akSNYrbAkvfNVU6weF9616B1IZ4f5XoZzEDg+hlGRXhngpzPQ1/Z9fDpGHnNYKsicMiGb6VMLmtvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlP9PGaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E5BC4CEC5;
	Fri,  4 Oct 2024 00:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728002370;
	bh=/QCdDuTjAcdtQ59f0q8/wzaabfLjBiWyX9Ufs/A2oYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SlP9PGaPI/UU51x6HiSaqkkC5lvnaxT/pW6n1bp9y/l9Di+c0Ya2T3Mq5Hfo1FI6H
	 kP3K7iwMJM57qOsuIknDkuygwmuIX870ZseaVdQof9/oIJAAhQdWwLlmcNz218ADsx
	 VVwE/5Tdu7LdCSluVizg1lOr6GCdAJvmklUjZ4YC07Gle/zyIFWWZwNmE651GA/YXU
	 eRdJCZr4EEUBztj7BwRZRhwrL/gkPYyWf2qIK3hxVfFSrJKe3welZ51MQ6wF1DxTlh
	 kXyCiqwV/oND2EJ6naRPPIZakNZBd4rHYg4fKE5vDZCOu5rxxwY2GhRIVpy01vpeLw
	 mq48hgkMXPoow==
Date: Thu, 3 Oct 2024 17:39:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>, Jeremy Kerr
 <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>
Subject: Re: [PATCH v1 net 4/6] mctp: Handle error of
 rtnl_register_module().
Message-ID: <20241003173928.55b74641@kernel.org>
In-Reply-To: <20241003205725.5612-5-kuniyu@amazon.com>
References: <20241003205725.5612-1-kuniyu@amazon.com>
	<20241003205725.5612-5-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 13:57:23 -0700 Kuniyuki Iwashima wrote:
> Since introduced, mctp has been ignoring the returned value
> of rtnl_register_module(), which could fail.
> 
> Let's handle the errors by rtnl_register_module_many().
> 
> Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
> Fixes: 831119f88781 ("mctp: Add neighbour netlink interface")
> Fixes: 06d2f4c583a7 ("mctp: Add netlink route management")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Build's unhappy about the section markings:

WARNING: modpost: vmlinux: section mismatch in reference: mctp_init+0xb7 (section: .init.text) -> mctp_neigh_exit (section: .exit.text)
-- 
pw-bot: cr

