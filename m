Return-Path: <netdev+bounces-103568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C328908A9C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231221C22AE1
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28DB149C4A;
	Fri, 14 Jun 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phFDTQRy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD314830B
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718362931; cv=none; b=sTJDRkdd5X+3Q8AOvNQRFYOUH+9idH+KOFoerZ1nk9AAhg5ciFeTyrM5IVqjrWauukytJB2WLetLHMFOK3JWJhkHF+YQsW4V0OQ1nfL/Q3LzI6s0vEXW17mgkyC68hafjk57/WMfpr5psPsVdcuzvFs5g9e9HbrxP98cNC0NOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718362931; c=relaxed/simple;
	bh=RnJBPr5Fe2ENgVCaqQycBFTmEBwFHu1NkFDThcsN9nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO0TglNHfVi8/4OAFvrxHKpresLGUGUIgBm6uv6lSSDdRWZP+ig1T5FVYxZBKYjE0DvmFriBt7VHgTbXXIs9/l3LV4MLFyPMxnIT9wPASmLHaKqf0RN5baH+dcCDNcyYIz1bLhLzWfhavVRFOiAbbT1hrUKAklEHzTThr9V7sqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phFDTQRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABBDC2BD10;
	Fri, 14 Jun 2024 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718362931;
	bh=RnJBPr5Fe2ENgVCaqQycBFTmEBwFHu1NkFDThcsN9nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phFDTQRyhoqYp7wMW8aLdTrfyHDXrIxBJHRBtq5fJEC6EePWYSzAyc9+yclnmY4KX
	 eSLclF1HVhCASraxKrNIofnFUg0qeBU6luy9Z3+gLFzyZZ9VDEJ+j/ExT2xLV2oyb1
	 aXxesp/i9FZ51iiV1tVEP9cLHFmwWMu/PBCgo77vmWcdPMntNtNURrhi7ewCWPxVLH
	 xRAe2H7nB+4iPGly+ukMzFmcheWPkfeR9o2Jfp33iEXYAMN6ZUCLu8J+pphq4kmxHY
	 cEemzuvTA1zej8sxBH3KPTTSBqjKm5CEmEoI/msFZHba9tU/d4QZSszX9W2z4ZpON5
	 Cg3/WEkVB8J+g==
Date: Fri, 14 Jun 2024 12:02:06 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v5 12/15] ice: implement netdevice ops for SF
 representor
Message-ID: <20240614110206.GH8447@kernel.org>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-13-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606112503.1939759-13-michal.swiatkowski@linux.intel.com>

On Thu, Jun 06, 2024 at 01:25:00PM +0200, Michal Swiatkowski wrote:
> Subfunction port representor needs the basic netdevice ops to work
> correctly. Create them.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


