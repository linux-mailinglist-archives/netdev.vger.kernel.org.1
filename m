Return-Path: <netdev+bounces-99802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895D08D68CE
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C821B209DB
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19B77CF25;
	Fri, 31 May 2024 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHGj21nE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86B2E3F2
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179402; cv=none; b=RBoduFqEHA6pCfASr5LoBRsmIrSx4/U8fByb1sClhQsWGz6HoOEtxt1BkBNISY0TyAAVDI7kmEm5OsofLJxz7vduOmCTcKNQlyQCVq2k5xcci+D9Dy1MCIrqtbivhRae4Ci+gC8sj99gdXr+AO8YyjgPHRCL3kDk79gf9jMJcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179402; c=relaxed/simple;
	bh=c2AhUU9SBSyXJlvKJgqsryat+Qx3wrELjVaj15yK1E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYrjKF+m04uDuiGVb1YAX2E8yjMpH9R2zyk0ifGI8ijS19DtzrBIvq/e5/VeQ6+HHjNH7/yWK7nOyGY+IlUGoKyfDqLNARgtriw1vqnOvo+M5MffBZYkBGb01zdZ35/Gp0BVZtJWY7yZ1S61767or9sW8NWclt6g6mDnkDmEfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHGj21nE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFD6C116B1;
	Fri, 31 May 2024 18:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179402;
	bh=c2AhUU9SBSyXJlvKJgqsryat+Qx3wrELjVaj15yK1E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHGj21nE+zlXJptMysLaRE+UNnSkYVMg+J4JtiWMbY5Mthp/Ugd6PdEEA5DYzfh0E
	 OEmgg0uLlP7wAyup2wNyiiwxFLUeVlGwQ3bqVnXn2Q/wMlCH8LDG2HGIIFeSHCOEo/
	 AAcPJE6C81dWzyxjplre9T+TAYmUESuugfT/hlojXC2IQOWBNtHp7Iv+H2UCkT48aV
	 CcQjfZ1ZkMM+Os/Z6MzGAP/dDKUe8+1sFSEm5N3tYBvoN6opSrnjbx0HQQJPt42a8X
	 3gKRHTEnmYdCCUaFTfJKxjVl/iTm/a4YUNqyqL8hegtIeHQfAHeLMfOtljOAO9FKyE
	 WjyEGLUtmUNOg==
Date: Fri, 31 May 2024 19:16:37 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 07/15] ice: implement netdev for subfunction
Message-ID: <20240531181637.GJ491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-8-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-8-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:05AM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Configure netdevice for subfunction usecase. Mostly it is reusing ops
> from the PF netdevice.
> 
> SF netdev is linked to devlink port registered after SF activation.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


