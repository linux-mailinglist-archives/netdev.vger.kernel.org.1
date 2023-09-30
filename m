Return-Path: <netdev+bounces-37189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0267B420D
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 18:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5A26128266E
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CE41799A;
	Sat, 30 Sep 2023 16:17:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F09CA6B
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 16:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E53C433C7;
	Sat, 30 Sep 2023 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696090672;
	bh=G8gJlihvipQwNDatoTzGrXw1pQtQJJLuIFbWWRkWTR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i109Ka1k9hNFTZwtAreSIxEbGGKNtAvtuVcDnKvQlZ+cvgSkF1p+Wm+OTSBWLaXJA
	 JGGYpNrLcDGQhbV4zSnNzQOjM3Ont/1VNAyBlNLOiotwitWEd3p73ttQQZKzM84hXF
	 foVHqaFw1srxcrxGl1o2SDuNwyUTgRA3+pp9Spr1GHYZGGssYew4uB38J1bRGCLOU2
	 +p5lOt9NEG1Oxov+CHxAjN4NJlec6kiq4ok9W+RA0c1X9wzBTZ+Tdye7ePTeH9Ab37
	 xafXoKEQ8eXjEnJHYCqmvo3YumPgseLcaqcuAEQvRjAXuA8yjH0Ln1yX1eMio6gO4y
	 NjVtlXvJKlTsg==
Date: Sat, 30 Sep 2023 18:17:48 +0200
From: Simon Horman <horms@kernel.org>
To: Prasad Koya <prasad@arista.com>
Cc: intel-wired-lan@lists.osuosl.org, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, dumazet@google.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	sasha.neftin@intel.com
Subject: Re: [PATCH] [iwl-net] Revert "igc: set TP bit in 'supported' and
 'advertising' fields of ethtool_link_ksettings"
Message-ID: <20230930161748.GD92317@kernel.org>
References: <20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com>

On Fri, Sep 22, 2023 at 09:38:04AM -0700, Prasad Koya wrote:
> This reverts commit 9ac3fc2f42e5ffa1e927dcbffb71b15fa81459e2.
> 
> After the command "ethtool -s enps0 speed 100 duplex full autoneg on",
> i.e., advertise only 100Mbps speed to the peer, "ethtool enps0" shows
> advertised speeds as 100Mbps and 2500Mbps. Same behavior is seen
> when changing the speed to 10Mbps or 1000Mbps.
> 
> This applies to I225/226 parts, which only supports copper mode.
> Reverting to original till the ambiguity is resolved.
> 
> Fixes: 9ac3fc2f42e5 ("igc: set TP bit in 'supported' and 
> 'advertising' fields of ethtool_link_ksettings")

nit: I don't think it is correct to linewrap Fixes tags.

> Signed-off-by: Prasad Koya <prasad@arista.com>

...

