Return-Path: <netdev+bounces-136482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442279A1EC8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6B71C24947
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197781D9586;
	Thu, 17 Oct 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQreREBH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF61D9329
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158430; cv=none; b=RFgI+xfoB0KJWyW11pFEFaFrP17/BvEgYhBOmEy6PoIRIds7UGn6nRfNIlvwOKvFpqk8sl+T1L/ZGjDRMuSh/AtycQ2SMotkV+KnZZN5k5RQxWcnGmqTU5XVhxWqp1htXnFoVpp1YRUj4lVhBN6rXWdouBcvKGHMnpRcey+3COA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158430; c=relaxed/simple;
	bh=MiPUNWCleeiUeLWg7A/InmEPhEz/OV1p/R+auYubiso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGhAoOcZ8F4XR7W3J5F9a0OGhGC8iODU247wU/4VaWYuCVGuup/7g2L/mldkT7ipT2VEGuNCUH0jaM0AztFMuw6CayX4K0DtBcd2+CHy1HiyCyWgKgBiU3j6Q/X2TPxeJ4pwn8qjh3IlkpYDCa9m0f21xoqRy7XoIYaZJ/0Vj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQreREBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4222C4CEC3;
	Thu, 17 Oct 2024 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729158429;
	bh=MiPUNWCleeiUeLWg7A/InmEPhEz/OV1p/R+auYubiso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQreREBH47sjAdgaljKiVE2KlTqCEd2rMHl4+WfYBCeLHFUAqUomnIr6CTm9CLVek
	 k65w9TZEEJkV5D+xcc5VgRB2OwaNXDDheevt2tJGW8RlLAqBXarvmRe7NsRlKeshS4
	 5HoPAuWJBzFXXK6Web01MqcY9/EF6kXSA5Tdqp9Kz0K9jgzSCPUv2cDO/3YlwFU+hu
	 pN7oqrHps21CVFklH02NS4HNPt3Gss+Basus9tiPO8AyNNTKj1Br8/ZxGSTvuXjDSg
	 DUp9aOl14SB2Q7CPBBGf5K2lexizHOmGDy9k5PIfgSwTT9i+5fg/2GVJ3Oo0YgPjKz
	 qq+p2dBjd5UZA==
Date: Thu, 17 Oct 2024 10:47:06 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v9 5/7] ixgbe: Add ixgbe_x540 multiple header
 inclusion protection
Message-ID: <20241017094706.GC1697@kernel.org>
References: <20241003141650.16524-1-piotr.kwapulinski@intel.com>
 <20241003141650.16524-6-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003141650.16524-6-piotr.kwapulinski@intel.com>

On Thu, Oct 03, 2024 at 04:16:48PM +0200, Piotr Kwapulinski wrote:
> Required to adopt x540 specific functions by E610 device.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


