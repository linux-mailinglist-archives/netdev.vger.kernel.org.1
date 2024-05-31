Return-Path: <netdev+bounces-99801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47D8D68CC
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877C5289CC0
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418897CF25;
	Fri, 31 May 2024 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODUiJLiU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF59224EF
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179343; cv=none; b=aKjweTwDHF4LS162nPwSpqjSlTMe67SlNf/ipZLzN5JEB38lwVNqMhbvAon4qVIJ1MxYZscHXARc0Jqdkdpa4FJnbTqnKc9FeaNwl17Vd+iO2KjWugKEUQUZGZLZ4RElnABIa6fqjWzfAwMltL3Itj1mZBNC1GrSTwES1G7aj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179343; c=relaxed/simple;
	bh=ojbqQ4rQj8Z2yW3x5JqcO+0NbTOfLU9wZRZbY34oNd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8TnKd0J4YARdGa1gLiI45f6YCslDWDxV/U87J0tpuLzXoJk0Le91D3keU6spY1vqSfM3s5XkmnGYBgY7Z1prUvd1H5FzecwWkS9UneHwAwwmCYMgMry/zBzpKFU/Esdbvn9iUBO9UA8vCX0CS7kjaYtBhbFJUL5/CI5VJTNftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODUiJLiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1FFC116B1;
	Fri, 31 May 2024 18:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179342;
	bh=ojbqQ4rQj8Z2yW3x5JqcO+0NbTOfLU9wZRZbY34oNd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODUiJLiUWJDMZ3zU457/PkLvLlTaEL5yeL/sjc6NSNx24gmI55S+ZFkHoE7iqO4AN
	 YucnV2o0gTkaWAcH5iZbmlhW+8Q8ZqxxPi1r7uMG2qTQrjPuMU+gOvZ0XDbuXAFI+d
	 jBOGy7dt3DZuO//KdS7G4eRufwYV5OkjYsi0VVtECQuT/O8D2/xuCElR4LaeqEX+/Y
	 jx7yIPlpfrjnQEF2Mpj3RD5UZ020uU6zEj92mFCqOvsGLxMf8bPUWb/MfkEdSpaIEq
	 qMtJ0ZZhao97svp9JGmJSSy61+cgTP+I/gx2yFdEoJRQv3V90nK3E2AiDzF6AKDYbt
	 b5qmBRZT2Cw6g==
Date: Fri, 31 May 2024 19:15:37 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 06/15] ice: base subfunction aux driver
Message-ID: <20240531181537.GI491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-7-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-7-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:04AM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Implement subfunction driver. It is probe when subfunction port is
> activated.
> 
> VSI is already created. During the probe VSI is being configured.
> MAC unicast and broadcast filter is added to allow traffic to pass.
> 
> Store subfunction pointer in VSI struct. The same is done for VF
> pointer. Make union of subfunction and VF pointer as only one of them
> can be set with one VSI.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


