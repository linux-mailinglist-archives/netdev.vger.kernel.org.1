Return-Path: <netdev+bounces-103559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 480D3908A45
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483B91C24E59
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3961946B1;
	Fri, 14 Jun 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxZ6zplC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20906193091;
	Fri, 14 Jun 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361627; cv=none; b=g/fIJ7BXrRwRVMyEoI0WlYaRWUAaVlRFKJvxAO/dc/2kIXvXuo6bBm8xhMORjPZRUlxW0SXvSfvrIYI6E3DrjiX4U4yAv4dpyfnCN/Tq+SOjGcwOWqMbFFU+8krGfluVhVPFcMa4KBWPcXLUQ9OJgFElJvxsUDjOzXVbF0Ad2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361627; c=relaxed/simple;
	bh=ideFO4/M7kKA58e4ofze6hWyuI7bXN54Y2r8g2Zu/AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+IZneVzvft2TjJOPbCPcmPl6mFRbz8nk86q+wgSRpMMapo3tqK+ZT/45jfFiZJnUgzREpSPP1kCsXKLBdbr8TtF/W+MWXx4uNT3cQbzT3LsXKjjakoL0Rvvau8vUQHqottlXQyOL0CLG/QoMnRP5q0KY+j816peLMmMrIVGZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxZ6zplC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014A3C4AF1D;
	Fri, 14 Jun 2024 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718361626;
	bh=ideFO4/M7kKA58e4ofze6hWyuI7bXN54Y2r8g2Zu/AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxZ6zplCMdcJbuXAOPl614YWUninQEg9D96edlRimoWyN9fabjO5JdlPQwr91Vw9b
	 B4zDH+PxogQLBZHvMT65Ww1rx+pZIG5900X48spIYQqi2jiJGmggUaJrhlhFGJ9GtO
	 PzZNeLhzHYZsMLtWm5Pq1RMS8K6a4MTOYIbeWgwjp+0sInNCPASr5pxD3F8vjxyU52
	 X67r8ouI1k4WXEAXo9QfcPLtAzxFJWhyPIgwatcpgndmkijMrKXFZs5FgrT+UJd7TC
	 VNvqq3XPuLPGM/V9ykrLqGZcAncwpxYMFEFKUFOCvbL+tTQW2hIixn2/IcPIxyMurR
	 +oRuD7L9u+3Lg==
Date: Fri, 14 Jun 2024 11:40:22 +0100
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH iwl-next v2 1/5] net: docs: add missing features that can
 have stats
Message-ID: <20240614104022.GD8447@kernel.org>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
 <20240606224701.359706-2-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606224701.359706-2-jesse.brandeburg@intel.com>

On Thu, Jun 06, 2024 at 03:46:55PM -0700, Jesse Brandeburg wrote:
> While trying to figure out ethtool -I | --include-statistics, I noticed
> some docs got missed when implementing commit 0e9c127729be ("ethtool:
> add interface to read Tx hardware timestamping statistics").
> 
> Fix up the docs to match the kernel code, and while there, sort them in
> alphabetical order.
> 
> Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


