Return-Path: <netdev+bounces-234062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939EC1C00F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7734E189CDB8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA2F2D6E7D;
	Wed, 29 Oct 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOCNsD9a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4508121A444
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754469; cv=none; b=CF6cPrp4EzhK2zgLRXpvMJZrlmQRTBl5RpXCXqb/ZQ9/JmdwZEyAsl2Pqe7/nfWyfINaSYzGNGAf6WL/7XUlcVeAZBty049VeM0sxvm3t/WGHMRXi9AtAOsUI+MeVvjpuOBlleGzY7/XeDN4v9fKqwzIqzzFBojIaVLOSISVvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754469; c=relaxed/simple;
	bh=hxAudg8qjUPstY8G5aYmKIZbKtSLaK1XLH0sWeqpvYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJqeIHM55rriUh5rkY94nYss/u2gj0OkGKRthpw+nq5gyzco2n0UN3iZZwCqvoyNgu4ElOurzGuiPGFZ3tiRQ3zDiiRxfPFXFlxrVj7UMogZsTG3WV/jrv3I15VmoGUnMDG5y82T3JTgRYNH52qZENnEg5Xp6s7iuaBYf6YBesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOCNsD9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D7CC4CEF7;
	Wed, 29 Oct 2025 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754468;
	bh=hxAudg8qjUPstY8G5aYmKIZbKtSLaK1XLH0sWeqpvYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOCNsD9aBJ1FpSRZp9e6tBXS0Hy38wII/S/wFdlfKIJ/aWT2x1EbOcSCF09JTpe87
	 9IHAwPC989b9OFL8EEErz6kENiT9vCrZnb0bnhhqXsUW1PquRNPhiDai2WILhmjFWl
	 ws86py7CX7wvj3WIu4SUdnqROYXomiiVuaf7IjguZoVM5T8azHE1Mnd9iYiNkSjkVE
	 gyuu4Iex6KCANGaGTP62h30g6sUX3aJh+CGMwpJNnhFBFOQMLC5LceBwttFhfeXj5U
	 zpGB0S6nbe3k0t6Jasg/kOc7QaToMYseMrqxrnVlaykqBaCwA2ZPaNL/766cp3iyVp
	 8L6JBete0KbYA==
Date: Wed, 29 Oct 2025 16:14:24 +0000
From: Simon Horman <horms@kernel.org>
To: "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, maxime.chevallier@bootlin.com,
	Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net-next v4 5/5] amd-xgbe: add ethtool jumbo frame
 selftest
Message-ID: <aQI9YANbRWL3LFvf@horms.kernel.org>
References: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
 <20251028084923.1047010-4-Raju.Rangoju@amd.com>
 <20251028191416.78de3614@kernel.org>
 <56a8ffbf-7e4a-46fd-9c7a-ad3c32c5eb0a@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a8ffbf-7e4a-46fd-9c7a-ad3c32c5eb0a@amd.com>

On Wed, Oct 29, 2025 at 10:25:03AM +0530, Rangoju, Raju wrote:
> 
> 
> On 10/29/2025 7:44 AM, Jakub Kicinski wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Tue, 28 Oct 2025 14:19:23 +0530 Raju Rangoju wrote:
> > >        skb = skb_unshare(skb, GFP_ATOMIC);
> > >        if (!skb)
> > > -             goto out;
> > > +             goto out;;
> > 
> > double semicolon
> 
> Thanks Jakub, Please let me know if re-spinning the series is needed.
> 
> > --
> > pw-bot: cr

Hi Raju,

The annotation from Jakub above would have marked the series
as Changes Requested in patchwork.

So I think that, yes, a re-spin is being requested.

