Return-Path: <netdev+bounces-205113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BEAFD6DE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960891AA823D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE32E54D5;
	Tue,  8 Jul 2025 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbXkKp5p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29762E54A4
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001673; cv=none; b=qKAGFg18b7zLiWafe4/UIshSqrxRVu6LyYChYyiTNO2Yn1zV7ZhTKVBXwRjlQqawqFXG8ExHYebOy4/6mC5KshMUHc8T0zGdaqM3mGXMAOmeRK43iJdDSUPoBrXaS3TrnmbHjptQoqhPlC50QIs9rVaOHvLvSWs4YuoE8KoHVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001673; c=relaxed/simple;
	bh=Tpyz8BtnWMzPCZbAOTcxnIljuuU61L/3QdpNiHzCTPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4s3LEhwf3FXqIC/5MFt/v99QGrYE5okM/biraPqknVEOEkSFOQGb5BgxWV5uqOiBHcZaBxTElpmmZhILlfQPb1nD+jq/IP7F6qtITCSC38Fto73tmW63633VtqCbPycx8sdg9cumeFkXK5lbk58Aing1UWbkNGhdtm4u1pJr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbXkKp5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188B3C4CEED;
	Tue,  8 Jul 2025 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752001672;
	bh=Tpyz8BtnWMzPCZbAOTcxnIljuuU61L/3QdpNiHzCTPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbXkKp5pzj3R9nFxo2bDaYimLL6n8hLZ9g6dS+IXbKPnzwEhZF2x2FqbcQE5GyD81
	 gQZ3z1yaM7ya+TdRmteHH27wIoPjH0+lZnHRZ3zNsbzBovaUn6oclqmm0fHyXyHqk3
	 DLcGZYqDyUDhHJxBjNXuV/VkKKmgzyROiHY7xcrtCuMxY9KqPXL6bWckgvcnSGycMA
	 a7DtIlopbvjiSQTpaneNP0fi1ttOr2ZdOy3k3QFsbjQS3IqbVURMez/sv4vQ+YbB9y
	 JKguQzHZ4w/LpquqQK/DYcwbP0U3hh3aWiZDfEXRbdYIjES6pweSJwB3aqRUH7z5En
	 LyBB6k7ORCeYg==
Date: Tue, 8 Jul 2025 20:07:48 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 2/5] e1000e: drop unnecessary constant casts
 to u16
Message-ID: <20250708190748.GX452973@horms.kernel.org>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
 <faa67583-4981-4c99-8eed-56e60140c28f@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa67583-4981-4c99-8eed-56e60140c28f@jacekk.info>

On Tue, Jul 08, 2025 at 10:17:22AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> Let the C type system do it's job.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

The nit below not withstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
>  drivers/net/ethernet/intel/e1000e/nvm.c     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index c0bbb12eed2e..5d8c66253779 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -959,7 +959,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
>  	}
>  
>  	/* If Checksum is not Correct return error else test passed */
> -	if ((checksum != (u16)NVM_SUM) && !(*data))
> +	if ((checksum != NVM_SUM) && !(*data))

Unnecessary inner parentheses here too.

...


