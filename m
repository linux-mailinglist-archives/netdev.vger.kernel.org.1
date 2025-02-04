Return-Path: <netdev+bounces-162511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0C2A2725B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE77188335E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B021127D;
	Tue,  4 Feb 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8BDiDGT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF802101B5
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673318; cv=none; b=F0A4PofnSMR6LjUR9G2jKM3WfNy1jpgsJPwqywZI73/33QATFiAsG1on+zM4n3xVOReecwGN9IUwhDVptuXeRza6Vqh0ZQsHzOQmiukhkErNHHgYzcr3tX8CfGyXygsuS0hgfDNhSTzDHHQQwj22AX+40KoIc0EJq5/CwmtrFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673318; c=relaxed/simple;
	bh=oIZXyefiLT22nrh3v+ZzwSSbeZsJgoBo3IDk9WmJB7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAuNGL73W1nLZljnIDKY/fGPrpcV593ck/baBlKJKlAwWHaQUmOqakFpbPr17xL2EPNBzEu5WDHOPTdX9pm/T9x+D7Ow0YYXfT+oRPlFgZ3AFvzw3wtOtGfJRm1IquANthop+JOmZjR8Nt/csgqRkBWDDTXYBRVpfAI4WKMSYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8BDiDGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2720C4CEDF;
	Tue,  4 Feb 2025 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738673317;
	bh=oIZXyefiLT22nrh3v+ZzwSSbeZsJgoBo3IDk9WmJB7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8BDiDGT+0m9KDYK+cjXe/Ad0HclLY/aEtw4IR/5o1RYxFBQ4fKimapwS1xgb4QGp
	 rI5YHcH2ZNJ9oJvZ5jEIpIhM5AbYh/N/r9vEoNvynMSMEd0jp+6f4HJa3p5IsCmovw
	 YB2xVNTa/6jZ8apG+cVrCsfdy79XpYkN33KQIQ367A8y7fRIwP4/Bc7C3QN1xyzaSd
	 ShUGZaD07HJyO92Za59e05LTFyKnlbLm/ndj3aDo+91qyFhpyg9RtrH0lA2SH9qhKP
	 GRfA/gZrZBEgI2UX9OD8h4SgfyoOG0Kx1T7Y+etRFmFEPjzx+JRiX45MKaxB4gm9/N
	 0r4xTEVPEGcCQ==
Date: Tue, 4 Feb 2025 12:48:33 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	Alexander Duyck <alexanderduyck@meta.com>
Subject: Re: [PATCH net-next 1/2] eth: fbnic: add MAC address TCAM to debugfs
Message-ID: <20250204124833.GZ234677@kernel.org>
References: <20250204010038.1404268-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204010038.1404268-1-kuba@kernel.org>

On Mon, Feb 03, 2025 at 05:00:37PM -0800, Jakub Kicinski wrote:
> From: Alexander Duyck <alexanderduyck@meta.com>
> 
> Add read only access to the 32-entry MAC address TCAM via debugfs.
> BMC filtering shares the same table so this is quite useful
> to access during debug. See next commit for an example output.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


