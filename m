Return-Path: <netdev+bounces-95365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAC88C1FD4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC37C1C20F38
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916A54663;
	Fri, 10 May 2024 08:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538D4C8E
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330164; cv=none; b=SWRf1GherAbXCBHNHnCjpm8NQz4BqQBaRxrqjE4ApJjdSF3ua6qtfAGGXTkN91aZQhcRJXnlL41h1mAy/t2QVbk6uK1lf9Y55xKG/Ktx7ROIBE71C4vbdVM+UtlxH1eff6u7duPgcUnzE+GuFyZl9DRkTGPAs1TPBJegrDrnwos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330164; c=relaxed/simple;
	bh=2W0Uqj+C5wHl8Usg4KmwX4obu/eucQM3UBJi/ccuyAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqHeQ68rZ45e8iCB1bb/fRBUBTw2gGcZ/Kg5PzBnA7veWlgphYB6KxuZaQeKtKqzXrLKLS+U61ge1MPZmCV0MkKs4pYT3enYw5MQT0MhCRpzNR9rQralY3yqacwXnPSoHkFlHUApaVGiHxp4fMS86G0Zh1OOHqXokjlCLsESDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1s5LjL-0005Q2-To; Fri, 10 May 2024 10:35:51 +0200
Date: Fri, 10 May 2024 10:35:51 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org
Subject: Re: [TEST] Flake report
Message-ID: <20240510083551.GB16079@breakpoint.cc>
References: <20240509160958.2987ef50@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509160958.2987ef50@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jakub Kicinski <kuba@kernel.org> wrote:
> To: Florian Westphal <fw@strlen.de>
> 
> These are skipped because of some compatibility issues:
> 
>  nft-flowtable-sh, bridge-brouter-sh, nft-audit-sh
> 
> Please LMK if I need to update the CLI tooling. 
> Or is this missing kernel config?

No, its related to the userspace tooling.
This should start to work once amazon linux updates nftables.

bridge-brouter-sh would work with the old ebtables-legacy instead
of ebtables-nft, or a more recent version of ebtables-nft.

ATM it uses a version of ebtables-nft that lacks "broute" table emulation.

