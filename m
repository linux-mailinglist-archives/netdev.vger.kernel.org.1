Return-Path: <netdev+bounces-112075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F24934D8B
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C049CB20EAF
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB5A13C801;
	Thu, 18 Jul 2024 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IswNt0xq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812113C699
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307419; cv=none; b=W2FjGScWr798grwr/uLypuNrx/GQW7BzeIDsY5dUfGiHmTy9ocqNmiEIzTKakxgRuBQAimqxmlJuPGsaE226nDU9vt4JP6TL6sC1D2gs11r9d4DeCU3PUCAE7N78wheCZGSv7RBgsFeIleA6V0VrYJJUu8QUOFaRH5WASdg5I6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307419; c=relaxed/simple;
	bh=nY89lkEzEoloJFoeBW/QlRZkdyq6KK8D/Em8VuTIUKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY5OJlqh0Iz8+yrRn+i3V0KFzXmWgXrqBtCKRrAj4yAW68Mpper3ra/B4ytRRAHOY0ixdGQDT2wQaPNYmVLuPeFoTeUvnkBDJfTdw2vIQYHP8vZMT4piNtA0WU7lbiD503WRu5OrU8IAIriggcMErDd89dBp1qCaHZ3FLPyUb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IswNt0xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B4FC116B1;
	Thu, 18 Jul 2024 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721307418;
	bh=nY89lkEzEoloJFoeBW/QlRZkdyq6KK8D/Em8VuTIUKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IswNt0xqn9vwPQ7HG0kSSTFoZtkuVjRQ9QcplDMjOqsBefce/8Pq4wE039bUU22Js
	 6cOLBl/MPuU3i+srDCxfHgVuEgp+C3ysKpCWsWHjAn8bGnKXaiVK8eUjcCej6sYyKe
	 UXsLLprIYLQ8bxMl8OATIr8jeYX2AEPE4vDLFMeRxZZmsSPFycchUVtQhRf16w1Spo
	 Se5tjtlOAP2o4/TvctjyQFpTK7jU35o316xpPflVVvNlTE1mvMfNgl+yQebDnaEVhK
	 MtagmNWMHLoDKPhQLQlaGn/aMNcYJ7o5M88LJsm4p2Qi6dcrexeG4OyUv7BinOhbSP
	 cEshLzNTo9YbQ==
Date: Thu, 18 Jul 2024 13:56:55 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 3/5] ice: Initial support for E825C hardware
 in ice_adapter
Message-ID: <20240718125655.GA616453@kernel.org>
References: <20240718105253.72997-1-sergey.temerkhanov@intel.com>
 <20240718105253.72997-4-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718105253.72997-4-sergey.temerkhanov@intel.com>

On Thu, Jul 18, 2024 at 12:52:51PM +0200, Sergey Temerkhanov wrote:
> Address E825C devices by PCI ID since dual IP core configurations
> need 1 ice_adapter for both devices.
> 
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


