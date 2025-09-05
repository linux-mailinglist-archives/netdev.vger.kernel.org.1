Return-Path: <netdev+bounces-220340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F48B4579D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF2F188FD8E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35011FE444;
	Fri,  5 Sep 2025 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyEWSaDE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9AF34DCD4
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074962; cv=none; b=MlrhtionNmdjMYsrsdieCPPsFHbfL7V791ZBEMmPSeCZoF+O78tYIw1yV4S0c5A7h7RabHnooOz0bFQYOoypc4YdgtQ1mRRjXeYWtqfxNs4x+3YNXCRttvTHpP1NcEAjo2/mlkJG21AyvMPxS+fOUdgSlGuHSZGkPYxhxq6Mq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074962; c=relaxed/simple;
	bh=/mm/vrMlSexYGeq/0pE3zP6vvAMX18pTZ5LKa/xIF1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGqKp4viZUjjlmWvqDWBnVy1jc18iFmYRZ3ppEyIACbOYfumNvT4zec99aYqLeJUI3GklEaR8sdPPl1Y/DCqlgUdfl0n6/mOKq4sOsB7THANW2x0v2XyR9AvIh9XRmYsSvL62J3GIaDcPhGwvmymO+9TKVJsjFGieT0ic/RkKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyEWSaDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C858C4CEF1;
	Fri,  5 Sep 2025 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757074962;
	bh=/mm/vrMlSexYGeq/0pE3zP6vvAMX18pTZ5LKa/xIF1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyEWSaDEluAd4Ot+nHPqlV2zu8xDWh1Inrht4eb2A1cQs7ff5Cd/sO+fdEuX8pPWx
	 BAnJuYEHv+rncK7YEwsbAEsCSZ8cenb/lxgEJHzpKKgIAqVj2wNvbkwMxcjdvBm5Ob
	 B7JvnI+cTrr6ScmCjF8ZGqeFurOzIoBnu6AlfXy9deE99uVBjto3leUg38wu2ZiSBl
	 74mB10R9rrjmrnJ8OZdVvLctDLjfs+8k2IVmYM0Vt64YuCdhaGC0gAm7wmvYn+eV32
	 ZeULtUqllzNrXnLXElWVloCuz/KK/WUgHysE6cebgKiJn6dqWh7wHVDG1n/x4+pb0t
	 aCtMEdZ9nobaw==
Date: Fri, 5 Sep 2025 13:22:38 +0100
From: Simon Horman <horms@kernel.org>
To: mheib@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, przemyslawx.patynowski@intel.com,
	jiri@resnulli.us, netdev@vger.kernel.org, jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next,v3,1/2] devlink: Add new "max_mac_per_vf"
 generic device param
Message-ID: <20250905122238.GA553991@horms.kernel.org>
References: <20250903214305.57724-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903214305.57724-1-mheib@redhat.com>

On Thu, Sep 04, 2025 at 12:43:04AM +0300, mheib@redhat.com wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> Add a new device generic parameter to controls the maximum
> number of MAC filters allowed per VF.
> 
> For example, to limit a VF to 3 MAC addresses:
>  $ devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
>         value 3 \
>         cmode runtime
> 
> Signed-off-by: Mohammad Heib <mheib@redhat.com>

Overall this looks good to me, thanks.

Reviewed-by: Simon Horman <horms@kernel.org>

One point: This patch-set applies cleanly to iwl but not net-next.
If it is to be picked up by Tony and go via the iwl tree, then all good
on my side. But if it is targeted at net-next then you'll need to
rebase and repost.

...

