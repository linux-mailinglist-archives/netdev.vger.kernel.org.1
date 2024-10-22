Return-Path: <netdev+bounces-137962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3358A9AB425
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E831F284488
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600031BC076;
	Tue, 22 Oct 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT3b0K/Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901F1BBBEE
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614979; cv=none; b=F24YOS6MKEWsrgV7TP9DLdbi1m0qMQLKdmV36kHIL2TZ5KaJkCZKpiPn62VP+a4QYaNbXQWoWRsAmBMUkA2oE0kN5BQh8YUIxJEnMAnJ0hQ/rFFs1tknoxEnF0Sd31DD1anJ+cMfqxdsg0WkIjgsAaEH4eiI22C9TgA7zGtDOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614979; c=relaxed/simple;
	bh=rGf2iggLg7Xi4k6jKAC8BVkEwxjHMEdINrhvQWuU1m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meQuVh4dpH7L0vkHRIJK59Wx6qLstnPiLzbOQWhP1QdGDZLGAPJ0RTWAj0uRzghIEYgC7c4+HGYeEJaUn1FafkedodslodzEi86Zqcfx1BOXDILskIh3KpRNopOZ7Auc7espdF8MXFsZ0OGHrcndYdZXLqhZOzpv1T2H8/B2E3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT3b0K/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7B6C4CEC3;
	Tue, 22 Oct 2024 16:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729614979;
	bh=rGf2iggLg7Xi4k6jKAC8BVkEwxjHMEdINrhvQWuU1m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZT3b0K/Q3rVeerFzrx9aNcdB2+PyxTwYVZxFU2PgguZ2Sow695ZqiMoM1aLJ/FGsd
	 FjBxV0HFFkHeu/Vw43ovxzeATC8lVeYE1r0vyILabJxZOmb3RhnKjTgR6KP1eM9aRm
	 RpW2FjFU7aMQ9fL4haJfYeNYHkrr5E4GZ/lFuWd0kHId4fmZbHFuTOnyvfQxO6kxgK
	 zIQygr8qJ5uRdpZlAo290Q36hWD7KbnUvj4UKXR73a+ivPKxe1yQ9eCUce7oLP752R
	 ig+1ZtNSMvUtUHi5+nUOG8aduOjWtxgWJtA5kkpHO1GaJ9rSMocNcVxslBejchsfa8
	 R3vSpV3DzmQ5Q==
Date: Tue, 22 Oct 2024 17:36:15 +0100
From: Simon Horman <horms@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: netdev@vger.kernel.org, satishkh@cisco.com, johndale@cisco.com
Subject: Re: [Patch net-next 3/5] enic: Save resource counts we read from HW
Message-ID: <20241022163615.GF402847@kernel.org>
References: <20241022041707.27402-1-neescoba@cisco.com>
 <20241022041707.27402-4-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022041707.27402-4-neescoba@cisco.com>

On Mon, Oct 21, 2024 at 09:17:05PM -0700, Nelson Escobar wrote:
> Save the resources counts for wq,rq,cq, and interrupts in *_avail variables
> so that we don't lose the information when adjusting the counts we are
> actually using.
> 
> Report the wq_avail and rq_avail as the channel maximums in 'ethtool -l'
> output.
> 
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

Reviewed-by: Simon Horman <horms@kernel.org>


