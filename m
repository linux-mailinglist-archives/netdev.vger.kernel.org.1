Return-Path: <netdev+bounces-99770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366688D64F8
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7C11C20CD5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45B858ABF;
	Fri, 31 May 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeRPqkSF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C457CAC
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167361; cv=none; b=RZDG1o8FADMC2cklqgblC7Pk7mrZJQS9be6Ax0r+VK0gVqUqY8wmESFtzKQQLfRl76O2Ar7WtrpiK2BbjEKPbW1MJ/sTwBjoD6bPAYeAbwzascHBfevY3YCPo6PRjtgwf1zwiJC1AmHmqardEM/5wj1EuhyXVJ2vsDWRIOkiXKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167361; c=relaxed/simple;
	bh=Q65pr34IRb5qsqtEq4pcYmrmq9rUc1aeuM031NMmJx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhEa7LiwFekxG/xR3KOioY2wPvncxM2S9N8NTOXQKoSOlK9owxWoIzXyB6ueIghh8WOMcpk27wqGgS4asGXBDGKunLRmMDNOKTmBKl2cKPhhYnMoTA/7Otk8gX/oqZaExRBA2N8CkOrMfGvjwov/r0vGogTosCXpaB1izkbq5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeRPqkSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D42AC116B1;
	Fri, 31 May 2024 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167361;
	bh=Q65pr34IRb5qsqtEq4pcYmrmq9rUc1aeuM031NMmJx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeRPqkSFyrG3t+wNBoVMTF1DwaLs08TRTIzw4YPwFPsYnJteHTfKXMNH9IB7vU+F/
	 Y/3Ox0B9IdH/Kg1wMiS/OX75jVuIYX4A1T93b2LvzZhfpAdnhEAEw40M+gZ6A7zsO9
	 Kxf52PMN+8+HmPE1qrc+hAPTQxs/EHv8Higy3MWi65vusQNJUHul1I9zjGgsqHEb69
	 CIyhnHfEy1AAsX8GeU23RdX4YlLTOGrC8ikVCXlNXdeyWGi4StjVc0vpr4PjaCkppi
	 bJJX3Xs4Da5L+Mny484o+qVjeYgp6i6+dEMHMZ6ixpJZaGvyLcuZoy4Qe0uf9KDF7I
	 ZSWPIcoHPD4vA==
Date: Fri, 31 May 2024 15:55:58 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com
Subject: Re: [PATCH iwl-next v7 6/7] ixgbe: Clean up the E610 link management
 related code
Message-ID: <20240531145558.GM123401@kernel.org>
References: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
 <20240527151023.3634-7-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527151023.3634-7-piotr.kwapulinski@intel.com>

On Mon, May 27, 2024 at 05:10:22PM +0200, Piotr Kwapulinski wrote:
> Required for enabling the link management in E610 device.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


