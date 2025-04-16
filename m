Return-Path: <netdev+bounces-183136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD9EA8B11A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761547AB437
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 06:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E11DDC1B;
	Wed, 16 Apr 2025 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jG+97HRD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F161DC9A8
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786281; cv=none; b=J/NZo3M7SOpr2Jgc8Xq9kPwfaj1pv5c+m6Uov8kxDiQvrlhOu0tHuXYJzA6sWClAkMSULibOaPVK7AvJjH/6tfjX1lWma1fzSMSAeUtgvmAdfHYLqMxPe7qK0bsGFb9s3Ob0dfdlDkcq6f3qxaai5ojrPCu6uhyghWd73R1sLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786281; c=relaxed/simple;
	bh=GPE42JNp3K3kOZzoJrYnhUZFcengTqlDpPxKgKlLC6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1wforkBqQbJW1rdQAH63JQrXxLl4I7jtCfixOWK5gINUhSmmVdHSG/nVpZzyUSMH9gp0NlUGpJT3VhTZM76ezh5+tv0Nja98rw0UYNFrcZqRXKuf/dc4lT2x6UhvoIRTYcFa+QcYukkvIHMep7TW/E7yQMki4mvD7LPFJoYGqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jG+97HRD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744786280; x=1776322280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GPE42JNp3K3kOZzoJrYnhUZFcengTqlDpPxKgKlLC6E=;
  b=jG+97HRDP8FklAsMpipb7/65XP8yQoYTo7WzxZqIAQJmwdv0l7vgg8pW
   0CTrDuWopqjm1AAlg7IqCPe2f8sX2J3/Mo0NcfppwdD0bW1+lwUaYS06r
   9D188uA1CboAMdujoHCZyc5RtnsEW3mok7MAuHPkZaxSrmLTrbF2cXp20
   FNMdB3ZkrUrpymxfJsTVk2srsqEPo8OwBlqYpe/+eZW9qVxmwRyY+1tbi
   Ev0ZVLGncePOyD6w33y1EJYHbAe83iNdr1auhuJVStGRQUxk2OPi8BGp/
   SVcMN31RnMezUfPGq5Hycd+xFSPiEU4FbZLkAAVBPVYKgb7Vb/A+QBHPD
   Q==;
X-CSE-ConnectionGUID: 3QSNdSCuTNmP/L6yVs1l4w==
X-CSE-MsgGUID: 9Em3VBCaQBq2Rg8oP0XkvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="71712170"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="71712170"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:51:19 -0700
X-CSE-ConnectionGUID: iAN+TeqpTBCxgAx+7dihvg==
X-CSE-MsgGUID: a+9sM5mHQAev0ZiuLaYwpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130887390"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:51:17 -0700
Date: Wed, 16 Apr 2025 08:50:58 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: refactor chip version detection
Message-ID: <Z/9TUjJwBZtBRfs5@mev-dev.igk.intel.com>
References: <1fea533a-dd5a-4198-a9e2-895e11083947@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fea533a-dd5a-4198-a9e2-895e11083947@gmail.com>

On Tue, Apr 15, 2025 at 09:29:34PM +0200, Heiner Kallweit wrote:
> Refactor chip version detection and merge both configuration tables.
> Apart from reducing the code by a third, this paves the way for
> merging chip version handling if only difference is the firmware.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 325 +++++++++-------------
>  1 file changed, 128 insertions(+), 197 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 8e62b1095..b55a691c5 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

Nice simplification, thanks
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

[...]

