Return-Path: <netdev+bounces-62181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EED82612D
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 20:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647631C21201
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1BDDCE;
	Sat,  6 Jan 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMTxhAP4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDC8E54E;
	Sat,  6 Jan 2024 19:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CDEC433C8;
	Sat,  6 Jan 2024 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704567815;
	bh=bRD/aygV8YP62Vz+smxGR1HhyVBL/a1oriAC4WeJvc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMTxhAP4/B6LnKI1TA9fcYq3Q3ApW4EBzunT5LmUZdkFSi+QPpjO9hhkW5LpSee4D
	 VxsOoNNsd5N1hOht9TqJVcQiDdDd0jLninbJOLKgM3qRYKTW0H5C9OTJ05HcXYqgqM
	 jLegNqI/kWw2CUJZOl7MgMPyScmjBfGIbMALrrEzVFfZzatKdIaSZr+mNy/CBWd7hI
	 pLiRRb1udwFwEX4bjnOuRj8PELjcODmvFFziOamQxEztn7+uEx3rUnhLgM687Rn8eZ
	 +JD92ZHHSNFMuZCMby2P3YgunzyRMKrH5hkMw9W0JaLjgEV3Ng/VensBKsu7yIK2ep
	 E4WGutAle6vcA==
Date: Sat, 6 Jan 2024 19:03:29 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	alexis.lothore@bootlin.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, oss-drivers@corigine.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] nfp: flower: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20240106190329.GE31813@kernel.org>
References: <de9e2b0be80f92dead2c8c66584bb34b9c95aab0.1704445716.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de9e2b0be80f92dead2c8c66584bb34b9c95aab0.1704445716.git.christophe.jaillet@wanadoo.fr>

On Fri, Jan 05, 2024 at 10:10:37AM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Note that the upper bound of ida_alloc_range() is inclusive while the one
> of ida_simple_get() was exclusive.
> So NFP_FL_LAG_GROUP_MAX has been decreased by 1. It now better watch the
> comment stating that "1 to 31 are valid".
> 
> The only other user of NFP_FL_LAG_GROUP_MAX has been updated accordingly in
> nfp_fl_lag_put_unprocessed().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


