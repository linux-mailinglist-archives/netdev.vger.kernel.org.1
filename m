Return-Path: <netdev+bounces-101040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF758FD0CB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60009B34F3F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60015666F;
	Wed,  5 Jun 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+fI4J2Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804632AF16;
	Wed,  5 Jun 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595547; cv=none; b=oqpOBs6pyocNncnrb2hgJKSLwWgYSz7SWfPMou6amRz5KWhp/ZR7I1M3i2NLgb8LE+6P5UsmNRl8M/bNmiJ7/6SqF1HTjavIV515IzBzvRHDwPFX+E7z9JyMRiKXTxcW3AnaNhkZNlU6EtArWCDFYt7iymZuhkP+AlqjTI4LqR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595547; c=relaxed/simple;
	bh=8x9iDZERTK8vzBb3Ome39PQS/ltOkJyTvJ1ASYXmjVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAtwONpnp14gYHaT7zbYk7aChKBx71Z6qh/eSfJkVYtPO31x3vqmmWfUxk3riY/o7t4NsfJE9Ki8SNbXxw5P31CNaNUVOz/C1PusWqkCCvo661qJiJ6ZSQi7kbXQVIiEruFNlHtOi2zkl799eVV/Efvof0h3wNEQ7mJA+5E9pOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+fI4J2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A664C2BD11;
	Wed,  5 Jun 2024 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717595547;
	bh=8x9iDZERTK8vzBb3Ome39PQS/ltOkJyTvJ1ASYXmjVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+fI4J2Yu6H8Ik5R4MtsAXl7+fqCTs9jAEmiN7Mb5c2DtvEJ36RWuH3E0Ue41k0E7
	 fFxBECJKhSd7FxlH+HVMMOLXTbY3PJqOUYscHXlbFvrYtAJVIEzW/hziWSpDzkaSOk
	 SmuX0D0jOTYT7eRqLNJ8vQ+STX/pulmGNXRJ/6xyKAWxWlZT9cO+3e5rhJZanmmu3w
	 +D+vOMXqRUeW1uoLl6SoLxa5U+CkvGWdlE1c+H8g4osKZ1JEyLLd8+LpaRT1f60V9V
	 Q0M9sT+i1ExZVhk3DRaTpyvzzIwE17CrUUbBkSxsuEXlmavdYWG8ijSKDHbjR+z2D6
	 Whhwy+z+48p+Q==
Date: Wed, 5 Jun 2024 14:52:22 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 3/4] vmxnet3: add command to allow disabling
 of offloads
Message-ID: <20240605135222.GN791188@kernel.org>
References: <20240531193050.4132-1-ronak.doshi@broadcom.com>
 <20240531193050.4132-4-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531193050.4132-4-ronak.doshi@broadcom.com>

On Fri, May 31, 2024 at 12:30:48PM -0700, Ronak Doshi wrote:
> This patch adds a new command to disable certain offloads. This
> allows user to specify, using VM configuration, if certain offloads
> need to be disabled.
> 
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Guolin Yang <guolin.yang@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


