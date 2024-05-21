Return-Path: <netdev+bounces-97376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8728CB258
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 18:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF73D1F215BC
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2A7EF02;
	Tue, 21 May 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU/TxTcb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931171CA80
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309707; cv=none; b=uYa1ZIsh6N3DXnG5Lu1LzrYtiLiFu6sMadyjhLnAYdTAWhDMBOuXhMhpwzpabx8dxe48zRHX+TZ5nGgb35KjIuNgAtSKOspQVv/ig1ykU+H2tuapbkg3cZ77QM41/gXhcZkgYTr29ZWTQlETfpXbIDOqWhGermZ3hPoWtdF6hJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309707; c=relaxed/simple;
	bh=YIxyHeECifhlEG+9LXXBkNZNwWpXDA/Zfw8twrPLOOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYIf6ZQCXITLU4JndWcrd+zS5gnFzFSIzlZS03VSJUYLTGhuLOoGrMREevzosonVSp+EnJnXxEVor63a3Co49eNnrRRAKHHE+lh65RUcIa4SogpTB7bshRD/wggQUnm4TZze5arXq+wK+4pwAUsxQaSWLULEsXQvPE04xogHpm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU/TxTcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC0EC2BD11;
	Tue, 21 May 2024 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716309707;
	bh=YIxyHeECifhlEG+9LXXBkNZNwWpXDA/Zfw8twrPLOOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OU/TxTcbifUxXpluyyuVf8BdyeHwicsaowkiOfuyuNqP7t4u+5KV6/71WQL4Z4qlc
	 I9+vJnUfrShX0VGtCmz1JoAH/i6TLvQUpRoiKUKZ7sjIW5qmI7iMPryHbbo3Mmpft7
	 TvK67JV5R7LvLGQJCu1NqBNRskMt+/vSCNf70UEXnk7ZIiPlMalx2micAEk/wnyL82
	 cvQ7PQbUg/VbT9C7qATta1akCVq1hChaNXu+JQ/scef/CT+7ptLHW0wNbXHWFW4Up5
	 wtxJfgUXKmgRRqMCsdI7rAFRovYRgNjPcnVolXXjN1JIkLs3jiJTesKzV+RFJzkfT3
	 xiB83n/+FVgGw==
Date: Tue, 21 May 2024 17:41:43 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, Jeff Daly <jeffd@silicom-usa.com>,
	kernel.org-fo5k2w@ycharbi.fr
Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
Message-ID: <20240521164143.GC839490@kernel.org>
References: <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>

On Mon, May 20, 2024 at 05:21:27PM -0700, Jacob Keller wrote:
> This reverts commit 565736048bd5f9888990569993c6b6bfdf6dcb6d.
> 
> According to the commit, it implements a manual AN-37 for some
> "troublesome" Juniper MX5 switches. This appears to be a workaround for a
> particular switch.
> 
> It has been reported that this causes a severe breakage for other switches,
> including a Cisco 3560CX-12PD-S.
> 
> The code appears to be a workaround for a specific switch which fails to
> link in SFI mode. It expects to see AN-37 auto negotiation in order to
> link. The Cisco switch is not expecting AN-37 auto negotiation. When the
> device starts the manual AN-37, the Cisco switch decides that the port is
> confused and stops attempting to link with it. This persists until a power
> cycle. A simple driver unload and reload does not resolve the issue, even
> if loading with a version of the driver which lacks this workaround.
> 
> The authors of the workaround commit have not responded with
> clarifications, and the result of the workaround is complete failure to
> connect with other switches.
> 
> This appears to be a case where the driver can either "correctly" link with
> the Juniper MX5 switch, at the cost of bricking the link with the Cisco
> switch, or it can behave properly for the Cisco switch, but fail to link
> with the Junipir MX5 switch. I do not know enough about the standards
> involved to clearly determine whether either switch is at fault or behaving
> incorrectly. Nor do I know whether there exists some alternative fix which
> corrects behavior with both switches.
> 
> Revert the workaround for the Juniper switch.
> 
> Fixes: 565736048bd5 ("ixgbe: Manual AN-37 for troublesome link partners for X550 SFI")
> Link: https://lore.kernel.org/netdev/cbe874db-9ac9-42b8-afa0-88ea910e1e99@intel.com/T/
> Link: https://forum.proxmox.com/threads/intel-x553-sfp-ixgbe-no-go-on-pve8.135129/#post-612291
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Jeff Daly <jeffd@silicom-usa.com>
> Cc: kernel.org-fo5k2w@ycharbi.fr

One of those awkward situations where the only known (in this case to Jacob
and me) resolution to a regression is itself a regression (for a different
setup).

I think that in these kind of situations it's best to go back to how things
were.

Reviewed-by: Simon Horman <horms@kernel.org>

