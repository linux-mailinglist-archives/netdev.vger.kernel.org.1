Return-Path: <netdev+bounces-199968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83EAE2960
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 16:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC00188F773
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609312D7BF;
	Sat, 21 Jun 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asvw3BZ4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB5EAC6;
	Sat, 21 Jun 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750514445; cv=none; b=oVDAcmnhTgtfInSaAyo4My+o6Nl4vQO20d84MPjgwSPj11xal3LhhgfCGV/yNYHSkDa608wVCQsTlJnruz1Mvg61btx/zWmujewpBIdpw3+krN01+MCz9pkTTZk3AYxUGTDN/MQYZIOVYdTuKJ39I05FkMCpjY63p1eEf9B96vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750514445; c=relaxed/simple;
	bh=iWwPWigBSD6SY/lPTD3aG7MYAMwd0R9tXnWiBx8/wHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V52yLHPGAkkbx6JJOkM9cfc2qMwNUZdQV6yE9pxJ490T/p7ROWsyUCaNahc38dIKsSw3q86K6whQDgyxYtD7xwvloLfH8l7NON+Qgm5Enx7Vcdw8OrygnSGEBpPMEjjRrn5Ux2XdctptaI5DkfhzL5OeE/g+iu/isxyRPqj3+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asvw3BZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F615C4CEE7;
	Sat, 21 Jun 2025 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750514444;
	bh=iWwPWigBSD6SY/lPTD3aG7MYAMwd0R9tXnWiBx8/wHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Asvw3BZ4fp7iC6bNQ8vSLnnOSbsKiMkG9c1BCmxy4Mp5Rg3OdoiSuLc151Y/vbI8d
	 7Z5qP4+RixQnJDch8O+WIe1tNu8G9C4paPfj1rVU0RmVVotWYlrHCdRP4RjFbxnjiE
	 QubF/JiqcJnbtiLyuaOMc5iGf6tQ2zCa7n3tpyBFV3LDiJ6dTII9qPvk9oeGTRZWex
	 tWut7p8nHaaDDmcS3mxMLnBMaPGE8cBDwA0MPNILbepWcS5s8YMWzbdJt59JWYOWhj
	 8Y5uhfpd90OqKPnbhgqkMRdpge3TXMzDZGQC9tfH5eZ5u92eexshnQzONSzkLfxJmd
	 NC2SIV23+BeSw==
Date: Sat, 21 Jun 2025 07:00:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 thomas.petazzoni@bootlin.com, Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ethtool: pse-pd: Add missing linux/export.h
 include
Message-ID: <20250621070043.21e1c852@kernel.org>
In-Reply-To: <20250620101452.GE194429@horms.kernel.org>
References: <20250619162547.1989468-1-kory.maincent@bootlin.com>
	<20250620101452.GE194429@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 11:14:52 +0100 Simon Horman wrote:
> On Thu, Jun 19, 2025 at 06:25:47PM +0200, Kory Maincent wrote:
> > Fix missing linux/export.h header include in net/ethtool/pse-pd.c to resolve
> > build warning reported by the kernel test robot.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202506200024.T3O0FWeR-lkp@intel.com/
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
> 
> The change that introduced this warning introduced a log of such warnings.
> Including a lot in the Networking subsystem. (I did not count them.)
> 
> So I agree with the point from Sean Christopherson [*] is that if the patch
> that introduced the warnings isn't reverted

It was reverted, thankfully. So I assume we treat this patch as 
a normal "include what you need" case and therefore apply.. ?

> then a more comprehensive approach is needed to address these warnings.
> 
> [*] Re: [PATCH 3/6] KVM: x86: hyper-v: Fix warnings for missing export.h header inclusion
>     https://lore.kernel.org/netdev/aEl9kO81-kp0hhw0@google.com/


