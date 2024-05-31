Return-Path: <netdev+bounces-99808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF08D68E5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B23A28941D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BA17D379;
	Fri, 31 May 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3KFMW2I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0677F0B
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179511; cv=none; b=lsokNPOjFm3qdSbIGVJzpEeWGjqk0H6UAuv9hU6PiGfT2gqC6O5ewMZOVJrmetQKCqfkIzDGnZpGSznrs4nBU2wKKpFkVBbtB+4s2SBEsZ6xgra/Oiusflfigfz2gdpJy92RwekRT4HBRA0ZPEcGOixRnzFxgioX5ghE1gfZ+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179511; c=relaxed/simple;
	bh=jL3OHJfz9VQuTuxrqsufgzCfc+flA/n/Pq7F1usTcUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0iuuCqnnUlo2fDIWXpQ3tKVuPxkdjk4bKtKPPyi2XyOT8Zm66MU31hUQy/BFYwlNEBIpHqjdzZmgTbRy87ZD+8/kyUmnPcaL4V2yBsMsTEsHiNWHWdAPJHba2JfUx18QligNPCud/UeCv3eDlfNrr18jPIobymdsfIGQjjbg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3KFMW2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9138C116B1;
	Fri, 31 May 2024 18:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179510;
	bh=jL3OHJfz9VQuTuxrqsufgzCfc+flA/n/Pq7F1usTcUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3KFMW2IShZGgcNRztib1wjGTsS2vc3rASPn+Etx2duuLGenICUqgB0i9zBb5Aolc
	 Rl7DtAOsTfzsKrhm5OZIm8Fkyh3aKHqrpOtxhu6L0HWC13vTkrU+Einbz08L8/RtSa
	 zWBMGDRZ+A1V9L5Kv0NfcJUiTNgH2Nv9RCXKcKl57ZGjAASllOtL8HoeyqUSe4Soti
	 8vi7EGZhI4udwmTvci2cLp/NCdK45RltsSdI1/ZauOXWyI0FB+07dWAM+6VLmZaiLv
	 9EwoJEcjLmlxnH2Sa/xO9R8Kz4Nq8PU2Tr4WY52KpCvsPK67N1BqV5sPWqjnySpZIF
	 fYwz9AJSFtF5Q==
Date: Fri, 31 May 2024 19:18:25 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 14/15] ice: basic support for VLAN in subfunctions
Message-ID: <20240531181825.GP491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-15-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-15-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:12AM +0200, Michal Swiatkowski wrote:
> Implement add / delete vlan for subfunction type VSI.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


