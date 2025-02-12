Return-Path: <netdev+bounces-165615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA38AA32C31
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98F4163FF0
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A30A20CCD0;
	Wed, 12 Feb 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha9pEgrk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F71DEFDD
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378747; cv=none; b=u8FsyYBw9+p67W6Nc50o7tqdMKhpIqaLZE/TVQ52FAlhDQRkJ2jW6VXSL1CuCPgGDgq31kFG+EsBGgQZ/qVGnXn1Az02p1hmL90X6i76/LQw5zlm7nCWUUr0GWsEog6oDlNjuQJtruS2VCsnZEUL5AAZI77nQKGz2TjcubzBX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378747; c=relaxed/simple;
	bh=z8T5CxVdq/ea4gXk5vPKbl+AIX5mvg5mtkpJrF1Us9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWQKuOCbGQFN9uRI6VpEJ36HE/p4nJuMoOgF3vu130AeQNa1USU3Zntp6NKxXgwrXOzkuCNq59U234lpbq+QG8kR7NHqZRYuJ5dIRlfqXJKTSjVPgPte5JmsWu2AgQt8iGw+ZLFq2FC4RVq47c8r+C8uRbetAdYAN81oNZZgT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha9pEgrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F88C4CEDF;
	Wed, 12 Feb 2025 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739378746;
	bh=z8T5CxVdq/ea4gXk5vPKbl+AIX5mvg5mtkpJrF1Us9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ha9pEgrk8A4x7k2sp+T3bkmSLKGYnnuj06DAr7ampq233CdvfauacJ6soCMNC5nhW
	 QiWblOlxucPkVzX+++by93AuwAeBuTXNC9BJYxH801HKDatvRojkHXxy39N4P2V0jo
	 8/NK28zG8VlOaGGJ5VHJoqnMrj21ojnJeTOhrLXlKBW+HiODbATdeVKfnwDekrrn52
	 Xv3G5JToNZNg4oF64cGXwiZW3LaSUoCMj0H/P3LAbmc6/+LmPm2WS/54i7E7rl7vig
	 nWO5OjnULh4xV8JHgUQjthnqloT2TIJUUtmSDlKY0eW/SgRTg6ONiHlWjPPP1RvCT4
	 GaHOYa/FR+MZA==
Date: Wed, 12 Feb 2025 16:45:43 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH iwl-next v2 1/3] ice: rename ice_ptp_init_phc_eth56g
 function
Message-ID: <20250212164543.GD1615191@kernel.org>
References: <20250210141112.3445723-1-grzegorz.nitka@intel.com>
 <20250210141112.3445723-2-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210141112.3445723-2-grzegorz.nitka@intel.com>

On Mon, Feb 10, 2025 at 03:11:10PM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Refactor the code by changing ice_ptp_init_phc_eth56g function
> name to ice_ptp_init_phc_e825, to be consistent with the naming pattern
> for other devices.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


