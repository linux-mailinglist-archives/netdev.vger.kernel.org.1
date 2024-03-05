Return-Path: <netdev+bounces-77494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78D5871F0A
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869E71F257F1
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B15C5A4D3;
	Tue,  5 Mar 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZuSRKli"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9545A4C8
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641320; cv=none; b=EhFz2uodANfKEnilj1wVzuMfITGaf0q4loUWfdL/8XodmGX+Dr992oHMbG+s2erXDPwXR+BLzORWcEKS1HmeP835HR6PARaTeZr3KRH+Z8spTe722GuUbJvfALr+LQPtH8ISZwKRDV847V3ArO5lTf59OicHOvf30z5AOiShlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641320; c=relaxed/simple;
	bh=aa0SxF67ImBmy+ijMpNxNU0wTZQIXYeC2cXFMKEsvpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQMwICIE2M8Pgsr3wfeMrBLRm2o1D4wICP4XjoFCVkauuIciRIDTc+O+5Esg4mZVsxrgerqt3VKc+dKZmuhC7us7dabDFQnxmM5acngArozDVOpp5gABWqxaGGrEFH7jer0teMARLMvUuKEywASeD22qUUvYSmdHwh3MOnwsrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZuSRKli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A14C433F1;
	Tue,  5 Mar 2024 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709641320;
	bh=aa0SxF67ImBmy+ijMpNxNU0wTZQIXYeC2cXFMKEsvpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZuSRKlid/14Yqas42xwkY+jW/96tCopGEdtDafzxnvaigMG9QFe2IjFucfCHUDrY
	 xUPekYls0EiF68RFXQp9pVlwdlAmRTQdxDFIjTFUICmjeLya2Dvq+OZB97AjODtNom
	 iLy6Ncj5F3mr6YOELFKSCBEe3bSSrun+mR5QEdHv4bLAjtIxiKHd9DFbZxrE3ZzyKE
	 VW24qgHDKwwdfUINtrsH+crS2So50Znj3eG7k7i+l6eFIAq+SN/Pf8o7KtTDq4yalp
	 5bQkxm/51044Go0N1Ad1svxIsOYLd/THEcrA52UKaAG1PcMYFCLjNCNCAPHqEjN7c4
	 j6R4MaNe1UxZw==
Date: Tue, 5 Mar 2024 12:21:56 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-net v1] ice: fix typo in assignment
Message-ID: <20240305122156.GC2357@kernel.org>
References: <20240305003707.55507-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305003707.55507-1-jesse.brandeburg@intel.com>

On Mon, Mar 04, 2024 at 04:37:07PM -0800, Jesse Brandeburg wrote:
> Fix an obviously incorrect assignment, created with a typo or cut-n-paste
> error.
> 
> Fixes: 5995ef88e3a8 ("ice: realloc VSI stats arrays")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


