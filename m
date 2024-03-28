Return-Path: <netdev+bounces-82821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B688FDEC
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A491C23BB5
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6C7D071;
	Thu, 28 Mar 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvo42Vtr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4A59B73
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624805; cv=none; b=Hu69rPfWJgKFEonO5z7UAMFx6Y6ylW5gIjYY7o4Pe0uAGjUSXnz6tThAWy4JGrGnQ1UXgEbDAcQCY/dhYhcjDGwD8FSEg0jlyGUudfkHV1IkaDDUioLFRw46Lm5ulLrT2Z+lH5Wev6iRfK4OqZ0t3KcZAlhhQoMD3fwsVTkPSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624805; c=relaxed/simple;
	bh=u+gJTOKec+cV/0L+8JlG5964eIt9r7luiwAtimaTeNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOJRbuL043Qkb7pR+9wtde02shhBh7A07rTyHyZWfChCLDDU6FtEu99Up33NPMhev9VLPh25tKR76xXotkS5TRwvOhQj9YE96z6qf1PS7KpKfjs6bp24NtzUSGBI6JvxJT+VZ8jxvVM7IQKwb/k2ojokwFJsVx6JMLHebOdsyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bvo42Vtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4968C433C7;
	Thu, 28 Mar 2024 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711624804;
	bh=u+gJTOKec+cV/0L+8JlG5964eIt9r7luiwAtimaTeNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bvo42Vtrk2wwoUwbhHGgXwPMxvGEwVdts4Kr0USyTYSIVcAfwSHpUIBHtbaX73Znk
	 uw3702QGueklb48TCYP48PM6HGU1WnirvDsNcIcC3j90ncqL3BQJ7d3bSRQG04PAOk
	 nQXsXcqbwPSYIu9j7QrXiqY6ypKiSqfdZH2kSHKXtlDnmZVDWNpvGKb0nWpNLG1Acn
	 0VjZXuclAEIhzX8xdtRcYEDV0djmib0TIaKXBCUXC+p31K9zS7+SMvx/y2CreupUO5
	 UUFpsjBm+uB0kKykAgeKaikgGeDaniGJj6Aj5CaDE4AkOkRZSwooF6YT8TDd3qc1gB
	 aeAqGgfGpnJqg==
Date: Thu, 28 Mar 2024 11:20:00 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 3/8] net/mlx5e: Use ethtool_sprintf/puts() to
 fill stats strings
Message-ID: <20240328112000.GD403975@kernel.org>
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240326222022.27926-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222022.27926-4-tariqt@nvidia.com>

On Wed, Mar 27, 2024 at 12:20:17AM +0200, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> Use ethtool_sprintf/puts() helper functions which handle the common
> pattern of printing a string into the ethtool strings interface and
> incrementing the string pointer by ETH_GSTRING_LEN.
> 
> Change the fill_strings callback to accept a **data pointer, and remove
> the index and return value.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


