Return-Path: <netdev+bounces-65153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63B8395EB
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12D61C26B08
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027917FBD0;
	Tue, 23 Jan 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ7DvcCj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38547F7E2
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029607; cv=none; b=a5iMPrISHqHSvqFqoLqPZ34+vV5gkwxw17FJbmjKTfwKgIGkZf7+T3lkIRxVUMCQU2h3+pkqwnG9adxy/S4GgplrBybXKWmjErkukV962Q6Wmb+vsk0A3rdRzg2nmbPleFWDekAkT2YJDOlCaeW/tmqlKNXK4s4reGNo+4LqI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029607; c=relaxed/simple;
	bh=Erfop9FrXjhItjBn5wwdGb8kCczIpV3oW69Bm/Hf82Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bltlf05bhParrDKK7zW9jZaZDS7OhUbPWOsPcTDSUov7ghcBXB0gJB0GGp9/ee5PdRnbQfMYwlP2/umPvSr7xky/lFWbp+PZlRog8QEsx2VNSJEsY3pqgwnuXOt9FpklVosPmBD2cs129Fc+Xu3lxe4NyWgJz1YcihdIvgjIRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ7DvcCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C6AC433F1;
	Tue, 23 Jan 2024 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706029607;
	bh=Erfop9FrXjhItjBn5wwdGb8kCczIpV3oW69Bm/Hf82Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJ7DvcCjdpteMgYgXZmEYHaAnuweBOZMjMOyY/DrbiupdYVawY+x+IuQLM2VASF14
	 YQe8jFF/PBJ/aZfMy4b4UK++/fgTuVn3YvmKZRKQn7/zRD3584Icq3294SGwCxQOLI
	 ir9yBb+QJ+2r5Vdn8m/moDdnU+rOMwZPz5p2fPiXQtjBP/QstnRrODTJx7CFO/lBOs
	 6s1+iaz7yKPri71KeInsaOxoWBqhBsKsMBo4PmIuFsnjIcZ5+IMWxYcxoHNErYxPnE
	 3+EhhuX1uMAc+8US8xqFTFcmfPTXBH4NJqlGazGyhY5Qj8zbS2Bba3FDujwJtF68Is
	 rgBJCQt1q0isw==
Date: Tue, 23 Jan 2024 17:06:43 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v7 iwl-next 5/7] ice: rename ice_ptp_tx_cfg_intr
Message-ID: <20240123170643.GK254773@kernel.org>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-6-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105131.2842935-6-karol.kolacinski@intel.com>

On Tue, Jan 23, 2024 at 11:51:29AM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_tx_cfg_intr() function sends a control queue message to
> configure the PHY timestamp interrupt block. This is a very similar name
> to a function which is used to configure the MAC Other Interrupt Cause
> Enable register.
> 
> Rename this function to ice_ptp_cfg_phy_interrupt in order to make it
> more obvious to the reader what action it performs, and distinguish it
> from other similarly named functions.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


