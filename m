Return-Path: <netdev+bounces-104977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC9C90F5A4
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F441C22257
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98058156F3F;
	Wed, 19 Jun 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMjhRyHV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032A156F39;
	Wed, 19 Jun 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820069; cv=none; b=F8kMh+lcj35JFj3kkpTUsKq0C5P/rI9RmIIN/me5j37jrqUHI3Mphrl3y2MlF1FwQCk+drG8bXIl0zjJ1GgxIk+ZnLc+xqIeiSpZzzk5REVuzeLV2zQndADKh5pRZLw5N3wFgpp7mOsQs2X69Xx31zcZaXWBFEXGJ7Z9YmfEiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820069; c=relaxed/simple;
	bh=uITDU8OUMOFdjwN5WORQNNPD6cqkrg1B9GP3QYKu7BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmEbJBL/GPnymXByL2gJhajZs3kvs4Kj6FFthuuHRM5mkn3H8JRDnSe3mjLiryFV+d97EU+GKatej/Qg1AK8t3uKCMihPpCeA868KKs9oRcqAYBFswhDl+jirLO3EXmk0HlcGZ4E3vK520umKXsp93vGw01Aox75zUkbRAXhcbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMjhRyHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12998C2BBFC;
	Wed, 19 Jun 2024 18:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718820069;
	bh=uITDU8OUMOFdjwN5WORQNNPD6cqkrg1B9GP3QYKu7BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMjhRyHVgK2YA6pH0dsq4NdSIO6P5iGbxq467fqiB9D5SmM0fKvMf2zFmLeZhniOR
	 vsapvH6MrzZio3ZLeEg3eohfCCqs4jDM5Rw0XncGz0mAjisR2qPxuQRWTh59hDVMCl
	 xB6QPFJOcTZO17vL7nOg0ukJdTtsP1BECyaQc7sh/3o1ret/Y/TFD2pOF0QDlScBUp
	 om93rpsiJ9VZ3DLDSHeywfSSVmcOma/sOmD+NCKESB6wN+Am3AsBexjjcE2RBwbxbm
	 ihxWFnVXfw5Xm0XEkyGd07Avt4aubN4qZLMU+0HbUVlW27I1YF564Igx8ykd7+5lg3
	 CQcBJ/zX3rMgQ==
Date: Wed, 19 Jun 2024 19:01:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] enic: add ethtool get_channel support
Message-ID: <20240619180105.GR690967@kernel.org>
References: <20240618160146.3900470-1-jon@nutanix.com>
 <20240619175915.GQ690967@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619175915.GQ690967@kernel.org>

On Wed, Jun 19, 2024 at 06:59:15PM +0100, Simon Horman wrote:
> On Tue, Jun 18, 2024 at 09:01:46AM -0700, Jon Kohler wrote:
> > Add .get_channel to enic_ethtool_ops to enable basic ethtool -l
> > support to get the current channel configuration.
> 
> This is nice :)
> 
> > Note that the driver does not support dynamically changing queue
> > configuration, so .set_channel is intentionally unused. Instead, users
> > should use Cisco's hardware management tools (UCSM/IMC) to modify
> > virtual interface card configuration out of band.
> 
> That is a shame :(
> 
> > Signed-off-by: Jon Kohler <jon@nutanix.com>
> 
> Sad face aside, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Oops, I failed to notice that Przemek Kitszel has some questions about this
regarding issues that I overlooked. So I'll have to take my tag back for now.

Sorry for the noise.

