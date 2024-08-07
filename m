Return-Path: <netdev+bounces-116557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E994AE53
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED58283934
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00799139D07;
	Wed,  7 Aug 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0Mb6IVZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670678C9A;
	Wed,  7 Aug 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049083; cv=none; b=rw09ij1nDq/xZ7TE8vVvqZb/GEBnoHh40pEvTTOVEKiJTDNRrD6fEJt+JZ+loi1rSCZzPWOJzZjG9wcsCFanvlaREot/YjSK3jkcQ3y+OmcpftuttEDCSQAKOQwlIDXRG5kAZ74PTyGc6McNT71lvtqGPWONZzKBU3aZlqoB7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049083; c=relaxed/simple;
	bh=cC44WqnolE5AwP6XHBememnp0c8vgWkKs0T5Id9Z+nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrkP0umnPEwCJFFJrR4DhX16HiICiOdooWR9q8LARhO+kyCVMRyHUti83UYMOX1epa30fTPPwd7raAy9ji8Wo29UdlU5KFqzXGKW2coozl5jETC2Gbg3BbELXCIsviIkZlQ4+KsNkdQMhys+f+6Q7jES/Uz+rnIWMtMCe11N4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0Mb6IVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938FBC32781;
	Wed,  7 Aug 2024 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723049083;
	bh=cC44WqnolE5AwP6XHBememnp0c8vgWkKs0T5Id9Z+nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0Mb6IVZ2WtcRUpXYb5Nb4sGxE2TPIiKzp469wnfbTVFDLSDOxwsW126yCBGZyAh1
	 OmufOVI4GzY03QiY2nmhfHApv4ZCuMoAt97ZpRo/2wVA2VlgP288fkVnLlw82R/qf9
	 tifY6+qGvXyo8Uh5kcnYj3kbizxS6z//Pl5beBUKIXocBV1T9iNP+HrGWou/UzwXu2
	 Agl1rzvCTaaHt3aegxP0nrcvuzwPWtBmmaHuH/8HjCvyZm6UfMAI7U/SbNdTOpkCfU
	 AABUGdhhOZ/qSs/vB0fx+5g5dwk44HFV6zPvVYKTJnugRAKQB9g20FQNAPHCpVJNxP
	 fp33vU0mnasyw==
Date: Wed, 7 Aug 2024 17:44:39 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ethtool: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20240807164439.GC3006561@kernel.org>
References: <ZrDx4Jii7XfuOPfC@cute>
 <20240807162602.GB3006561@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807162602.GB3006561@kernel.org>

On Wed, Aug 07, 2024 at 05:26:02PM +0100, Simon Horman wrote:
> On Mon, Aug 05, 2024 at 09:38:08AM -0600, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> > 
> > Move the conflicting declaration to the end of the structure. Notice
> > that `struct ethtool_dump` is a flexible structure --a structure that
> > contains a flexible-array member.
> > 
> > Fix the following warning:
> > ./drivers/net/ethernet/chelsio/cxgb4/cxgb4.h:1215:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry, one minor nit, after the fact.

cxgb4 would probably be a better prefix than ethtool for this patch.
But then it would conflict, by name, with

- [PATCH] cxgb4: Avoid -Wflex-array-member-not-at-end warning
  https://lore.kernel.org/all/ZrD8vpfiYugd0cPQ@cute/

