Return-Path: <netdev+bounces-82683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3088F1F9
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 23:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1893DB20D23
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 22:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020371534E8;
	Wed, 27 Mar 2024 22:46:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A8339A0
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579566; cv=none; b=OEthYaxk6bCxe0IdCuciIDKoMvlRSL2m2OkulAdrR+FwHqn/t+Pe5EI7GzWLmR1hcZjEhswXlODOkRPD/FsmJyhqXaRsca47yO4LCKnF6+r+Q1qroVmmEyZVCnHBnHdkpBkQKcp61zoHWI30uArgC4p8ONeOrf+cjBXtJHULRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579566; c=relaxed/simple;
	bh=VyIwCeCVXiRzfot5tjum0+bRkR5OosEV2008kl3RaGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qyvg5idLbMibZc6NOejSjwq/T+fVIhTQh6u6Lxpf7vPLOIz5wGv9mx9MudrcKtTm6j0k8H0zCmZssSoYb5ZKvvON095s3Cwkc+4owHAeQcaG03G6wp+hAuGkIXtiXrGN8IsBz8mRRdJTQA/ByUHAuJ+oDCgh6U6SVXhNZQ1IdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Wed, 27 Mar 2024 23:45:57 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 0/2] netlink: Add nftables spec w/ multi
 messages
Message-ID: <ZgShpYf158Yc7ivH@calendula>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240327181700.77940-1-donald.hunter@gmail.com>

Please, Cc netfilter-devel@vger.kernel.org for netfilter related stuff.

On Wed, Mar 27, 2024 at 06:16:58PM +0000, Donald Hunter wrote:
> This series adds a ynl spec for nftables and extends ynl with a --multi
> command line option that makes it possible to send transactional batches
> for nftables.
> 
> An example of usage is:
> 
> ./tools/net/ynl/cli.py \
>  --spec Documentation/netlink/specs/nftables.yaml \
>  --multi batch-begin '{"res-id": 10}' \
>  --multi newtable '{"name": "test", "nfgen-family": 1}' \
>  --multi newchain '{"name": "chain", "table": "test", "nfgen-family": 1}' \
>  --multi batch-end '{"res-id": 10}'
> 
> Donald Hunter (2):
>   doc/netlink/specs: Add draft nftables spec
>   tools/net/ynl: Add multi message support to ynl
> 
>  Documentation/netlink/specs/nftables.yaml | 1264 +++++++++++++++++++++
>  tools/net/ynl/cli.py                      |   22 +-
>  tools/net/ynl/lib/ynl.py                  |   47 +-
>  3 files changed, 1315 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/netlink/specs/nftables.yaml
> 
> -- 
> 2.44.0
> 
> 

