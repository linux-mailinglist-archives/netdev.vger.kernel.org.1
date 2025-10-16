Return-Path: <netdev+bounces-229884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8BBE1C2F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52DEA4F98EC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 06:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8192E11DD;
	Thu, 16 Oct 2025 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uh0P1Cr/"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F164F2DF131
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596448; cv=none; b=LuTob7YtembD37uV/emIPl8Vxw2aZ8cCwphTpsFOMeiS3m37mWKpoZPYwY7HtqGRssANtqDxSGlDiSTypYwjE/bo9k5bfZlVbG+sH80pAoZzxuDRIdj+2Zv3omP7ixipVPQs96dAWWBMOyNT3e22Q3OC56oLsZAKkgKMTUDXesE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596448; c=relaxed/simple;
	bh=VEy4lKjwzIklg0qO6uNzy16XTRzQMSVrKqJuhusF6jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMbqnlyy80c91sAeS97xpUu0dDT0Biyp4ASYEA7O+CCZjWcK7D+Z3zJkXueIadDZAe9jQlOamFH+XGP9bbNAzyMwLICMaqZqvdDiIE5R4T4Kw0pfmBjV8dJT4/mAp/kTJh33xnZdlxjJ8jTX22gaXP6ULRMyncJMtelRwboC29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uh0P1Cr/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 8ACD521244DF; Wed, 15 Oct 2025 23:34:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8ACD521244DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760596446;
	bh=fzHMrBYmZnPHoKv8/rgGHN9a8qxUkkSk3cn/JACTU78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uh0P1Cr/vCUEZW42UCCGfG8KOHxfXEXoIEC7IlQ9jfGJCSFwBj0Fk0hs2vKoDVrV8
	 pVRCJT67vq08DLCqrWLlPBeMFib1Hd0iB7AFpNrfEl5p7jZeh4ScPmVEaSSurxvL/Z
	 1Gg2IdqS4ScOlNXuFxi8XFXkMtI0rSJrbCUhTsuc=
Date: Wed, 15 Oct 2025 23:34:06 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: stephen@networkplumber.org, dsahern@gmail.com, netdev@vger.kernel.org
Cc: haiyangz@microsoft.com, shradhagupta@linux.microsoft.com,
	ssengar@microsoft.com, dipayanroy@microsoft.com,
	ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v4] netshaper: Add netshaper command
Message-ID: <20251016063406.GA17762@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1759835174-5981-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1759835174-5981-1-git-send-email-ernis@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Oct 07, 2025 at 04:06:14AM -0700, Erni Sri Satya Vennela wrote:
> Add support for the netshaper Generic Netlink family to
> iproute2. Introduce a new command for configuring netshaper
> parameters directly from userspace.
> 
> This interface allows users to set shaping attributes which
> are passed to the kernel to perform the corresponding netshaper
> operation.
> 
> Example usage:
> $netshaper { set | show | delete } dev DEV \
>            handle scope SCOPE [id ID] \
>            [ bw-max BW_MAX ]
> 
> Internally, this triggers a kernel call to apply the shaping
> configuration to the specified network device.
> 
> Currently, the tool supports the following functionalities:
> - Setting bandwidth in Mbps, enabling bandwidth clamping for
>   a network device that support netshaper operations.
> - Deleting the current configuration.
> - Querying the existing configuration.
> 
> Additional netshaper operations will be integrated into the tool
> as per requirement.
> 
> This change enables easy and scriptable configuration of bandwidth
> shaping for devices that use the netshaper Netlink family.
> 
> Corresponding net-next patches:
> 1) https://lore.kernel.org/all/cover.1728460186.git.pabeni@redhat.com/
> 2) https://lore.kernel.org/lkml/1750144656-2021-1-git-send-email-ernis@linux.microsoft.com/
> 
> Install pkg-config and libmnl* packages to print kernel extack
> errors to stdout.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Hi,

Just following up on the patch I sent last week. I wanted to check
if you have had a chance to look at it. Please let me know if any
changes are needed or if I should resend it. I appreciate your time and
feedback.

Thanks,
Vennela

