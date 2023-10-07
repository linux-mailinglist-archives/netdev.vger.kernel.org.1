Return-Path: <netdev+bounces-38793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCED7BC86C
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 16:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B2B281D8E
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8106F28E06;
	Sat,  7 Oct 2023 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npVi0yxa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D11D6AF
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 14:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F05C433C7;
	Sat,  7 Oct 2023 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696690045;
	bh=toBbiQLzqioyx3ESZzgeMUmDaIvxlXr2inUPTTVY7VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npVi0yxa2LNPlvtS1ysPrOCYdtE8fIhgoJ1yeYf9EZqv87t95Uk6c7uVO0YCLLM4B
	 NNceouB6JIkkKaVmqZIWZ5bdgO+zJTc4TMX5IYVZUMhY8xrq/oDsqFad6NUe5LKm1V
	 Ft8uERIUV5vLe6PH9QdUsaroLDYzgBlVw0nUcxGdyVnMUZpdAcX0nbqq9bA8UAaiUc
	 7zVBvT56NAd2dWgjdq7dCxlVJpMb09dP5S2gUIutPOg1PVVEE9q35AX2m2kLyYSMnN
	 xP62TxCInwwMqnhWqgQqmDjBFtX+HBCmQt/EG5PBJDiQGl7iJTHD6vDiT0tXTiTxJo
	 hIxJAfTM9/a0g==
Date: Sat, 7 Oct 2023 16:47:20 +0200
From: Simon Horman <horms@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCHv2 nf 0/2] netfilter: handle the sctp collision properly
 and add selftest
Message-ID: <20231007144720.GA831234@kernel.org>
References: <cover.1696353375.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696353375.git.lucien.xin@gmail.com>

On Tue, Oct 03, 2023 at 01:17:52PM -0400, Xin Long wrote:
> Patch 1/2 is to fix the insufficient processing for sctp collision in netfilter
> nf_conntrack, and Patch 2/2 is to add a selftest for it, as Florian suggested.
> 
> Xin Long (2):
>   netfilter: handle the connecting collision properly in
>     nf_conntrack_proto_sctp
>   selftests: netfilter: test for sctp collision processing in
>     nf_conntrack

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


