Return-Path: <netdev+bounces-81994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF37D88C076
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDF4B252BB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715D38FB9;
	Tue, 26 Mar 2024 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6KwdY2/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B35676E
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451972; cv=none; b=T776G9tnrxKPaKwL1TnsH02gxigc3EvBBQ7p7Wshat4H2YUxkFoUWCCSyB/s52bWx9zX2r5ikEOVkdn7IuP/8nHHtbn+8ofip+LGmaaD3e4+YfFUr4BsGoYS+lZzrZe2NxdUsZo3ehySRCS+CKBvYUq8fGw2nWSh5R3uOQhKVJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451972; c=relaxed/simple;
	bh=bNHwSFK5J5KJCN6ynz/h2BWMHs0N01XYMQZfrfLHog0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE8OAkIlkQRcNoBWQbNza+0Gycxj8DnPfZD4Ws8p9jSSbeMmwXGz1cTCD1XByhYvBQ54RNEW/G5B1JAZeO/LGPvqhBjtZua7TWHnnaF1py06JU1H2bjLKt+rQsnkXC8kmCSTBQMf6UZXtSqwV0sjvK7mfOq1mtHGP1rLma5aeWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6KwdY2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253FBC433C7;
	Tue, 26 Mar 2024 11:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711451972;
	bh=bNHwSFK5J5KJCN6ynz/h2BWMHs0N01XYMQZfrfLHog0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6KwdY2/03TrnMP9jFHPP5ZYPV6U8jC9oLs+/9i1cKgocZg0Y5GXLcjXyTioS4xmw
	 spjyfXbuYgvI3aUkTKFC5WkyEQvHFgFTbqlxmX4ETUHbGXRtCsOMSjmse31FpKXp3q
	 +Sot5nU9xL+vDO6tbimRYzRk/7dOaso/f/tqa3kP46nICIWEYqj02n4tHiq1aPRygz
	 AHKSCRi0ns+rECdhrzz8E92LirQxFbu129blxj+9JT3tdv2vw2uhACEI9q2BCqtHHa
	 zg/xlAAOjOgJPqkxOEqNqjG0jt2O0ufO6FKBRZY4sHLCPmxtcZ4Ri3oWq039j+uxUi
	 okt9uYRdOpD4A==
Date: Tue, 26 Mar 2024 11:19:28 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [iwl-next v1 1/3] ice: move ice_devlink.[ch] to devlink folder
Message-ID: <20240326111928.GJ403975@kernel.org>
References: <20240325213433.829161-1-michal.swiatkowski@linux.intel.com>
 <20240325213433.829161-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325213433.829161-2-michal.swiatkowski@linux.intel.com>

On Mon, Mar 25, 2024 at 10:34:31PM +0100, Michal Swiatkowski wrote:
> Only moving whole files, fixing Makefile and bunch of includes.
> 
> Some changes to ice_devlink file was done even in representor part (Tx
> topology), so keep it as final patch to not mess up with rebasing.
> 
> After moving to devlink folder there is no need to have such long name
> for these files. Rename them to simple devlink.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


