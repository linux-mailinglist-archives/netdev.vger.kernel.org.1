Return-Path: <netdev+bounces-189768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB8AB39CE
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C284D189C388
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082021DF974;
	Mon, 12 May 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwiSAZsW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D01DF754;
	Mon, 12 May 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058207; cv=none; b=RfTjisOr4w8URrFYsq/W43as0ukjqBbcxH22g3sJ78EkzhZXaOwNot5U1hliApcdP1d0bllGKIak+VHLL1O+YCEMUjinonbegDP9JwRg24WxKenVKP7J38qQ2lchCCTsDSMyzVqMuPUb2lClFKChrffmfFMSZyovl20Rv/UDjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058207; c=relaxed/simple;
	bh=+1fEo5xR8+dGnNEy3sC9IEHkaa5Uo2fyNqqEieLTutk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcDjh49P0T0EEeAFacvPeCTI3Lxs5y8ReJ3igKgb6dwV+JFeLvcrGhV/RPlUnfRQuKzMd326aacKvwCQLE4uwJ7C4e2bwZNSqLfpy39tObOYRM8a0s7oMDeRkFnaa3/dDxnSMw6XP/lOcdbtmPzqrVPMlqMbihHPe11j54Qq4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwiSAZsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37DEC4CEE7;
	Mon, 12 May 2025 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747058207;
	bh=+1fEo5xR8+dGnNEy3sC9IEHkaa5Uo2fyNqqEieLTutk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwiSAZsW+JI93Lyd78vrZ9sijkByMgmUcjeG/T4NQPRAGC52+LwyPzDYb6g5RDRg5
	 lHaS9Q1GZctzunCKPLmkQ0OU+J+rMMwMkRvZ+GJLWSqBoaQfi7HZy4vvxVXzOwipmZ
	 ygcKPB0kcwRlFZGti+FHvaHdC0SBHZKkAF5mM/P2xoTBnIcDRGvHVH9czO37GxGtjN
	 Qb4uqkr17Wljz+kYaGS3CP7e+FRwEsjfEMkwyf7arOoDQmEGS0KujCyg+fa3Nkh/Z3
	 apFk+5rIukd+YJ1NGr86SX6fnYFlIX87OhcMxfDS1iaoMNbJXWN++b7aFfjjq5x1q2
	 M6PGC/IF9ESMw==
Date: Mon, 12 May 2025 14:56:43 +0100
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net-next v3 4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3
 support to xgbe_pci_probe()
Message-ID: <20250512135643.GG3339421@horms.kernel.org>
References: <20250509155325.720499-1-Raju.Rangoju@amd.com>
 <20250509155325.720499-5-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509155325.720499-5-Raju.Rangoju@amd.com>

On Fri, May 09, 2025 at 09:23:24PM +0530, Raju Rangoju wrote:
> A new version of XPCS access routines have been introduced, add the
> support to xgbe_pci_probe() to use these routines.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


