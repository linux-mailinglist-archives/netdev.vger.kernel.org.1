Return-Path: <netdev+bounces-99803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB4F8D68D1
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE561F23342
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692F158204;
	Fri, 31 May 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY9z2Yii"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B72E3F2
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179420; cv=none; b=SmK7Z3gC0hbfPbRrAkVtuDxdIYaENpkn5TLCvd/zbHiUQBrjTk/3rrZ3+GAMiEVonsPiUvCZETDet2+raGL7QhqB7Bd3x7pG/RPNn7NZToYWk0Y1HkwiW1JwSZn6Wr5Lg59ayskUZ7xArPzickzWqKT18KFqxgOafzukac9n2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179420; c=relaxed/simple;
	bh=KOgNjrMn9knsj/gt9uAmGZH0ZGkZNuqnBZRpvXpDHS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWOE2of/hsDYIrSLeIhhWaiw0QX9pma7POmBQUTPsV11v4iwVpbaLaDMQLhsTsvLYC5He7OzO+VWNB/5lciPPacdGL+v2o7BbPetZ2XKObWSWaWnaqpCWRYVP4aLxSyxF6rUL8LOg0fMuob8rxH0nem+xiQkjeCtKLtrbivwT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY9z2Yii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A62EC116B1;
	Fri, 31 May 2024 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179419;
	bh=KOgNjrMn9knsj/gt9uAmGZH0ZGkZNuqnBZRpvXpDHS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HY9z2YiiZb7/DB5vqPY/rjeGaqIEGJhqtwVHlg7JASckBeFdSd+KupN2geekBaTQ7
	 lothdNh/KVGLX7/xoBWaK4aQ8xisKSGdjuHUi+kHQZWziDCC3T7AdhAYQniAJMncas
	 cZN1KaMCiWMVXnY+RqUpUQfj0UCNYmMvAy9wgeY6Z9jWwL1GfHovInqarWhw4BTeK6
	 38VMlFVQTxetRUYXlHoDH3ybmhjFgO/hQAE2YVtb2DpRd8wxvKZ1Szow5SYNbWzdsH
	 LuydcFkcnAX+rq7ReiVkM/CaOXhq3qCZeYqSX0jBrgwHR61mzz9FWhq5FdaGXN01GH
	 BCQL97uvR5fhg==
Date: Fri, 31 May 2024 19:16:54 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 08/15] ice: make representor code generic
Message-ID: <20240531181654.GK491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-9-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-9-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:06AM +0200, Michal Swiatkowski wrote:
> Keep the same flow of port representor creation, but instead of general
> attach function create helpers for specific representor type.
> 
> Store function pointer for add and remove representor.
> 
> Type of port representor can be also known based on VSI type, but it
> is more clean to have it directly saved in port representor structure.
> 
> Add devlink lock for whole port representor creation and destruction.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


