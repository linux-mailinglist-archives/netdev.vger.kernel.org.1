Return-Path: <netdev+bounces-162478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316A9A27025
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158631885705
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8873D2063F1;
	Tue,  4 Feb 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fep+tbnb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D1202C44
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668126; cv=none; b=cg+OS0HjFOrM4GSUyh4HS3nw/cgZp1kFlP/48vdmPhHvfSUhagSTHRPdlUXU1EM/9fYHKlW3Bng+df+c8K68w9q8IqPT25EAZpOrj7VLC+WPvM/r+n9B+DW5oMvB0q5Io2lh7xZq6f/atGIs9wsR/pV8fTSmbpYY2o5edQ0ZUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668126; c=relaxed/simple;
	bh=uvvVOnnhxBS6EDVHmsff2rZzyRH3QDgRab78aZma4S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSoLO0S/PWZukAfYilgVUslUGmcXlnYDDVkRAuE7NQa19k457SW+bP58zxoHa7RwLv4yxBGa/JYZWFd6sT1mCvQVFrQEDazJV3y9Ec/RhAiwdMOvG06VDpHLz999wfZyQKkXI6AN9qwBXhujcTGaq8oUP1Aklf5peztX1uCU0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fep+tbnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0B4C4CEDF;
	Tue,  4 Feb 2025 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668125;
	bh=uvvVOnnhxBS6EDVHmsff2rZzyRH3QDgRab78aZma4S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fep+tbnbZoNJwlqs6TWXzbf79NhU+8lP8V6fgb3tv3MrbmozcsuWKPSnuKxaOAt3b
	 Sf3TmWBgZjlzn6X23k8vD1z6C+GeHZpUorS5vGjtm8XBZLlpp6UootUFLm3zzn/iLe
	 71CAzQjYLlJ/hEw6x5cyasC0Mobue969Ql0EW7Ov88K+RM8QCJzJ4y9tURYoLYCgyD
	 yFQqPbD+SB5f32JRNU8zfLKFS5qm5stdUti5MowJ2Jh6MsIZa/9U4muDncyuhQlmQ2
	 dYUvqfNTo21B5ASuxeAsLhdiJPL3TcZ74bf1RAC1tzMSQQ/Sm1Xcei9xJbk4vSEYoY
	 a3gUQ7OnwRT1w==
Date: Tue, 4 Feb 2025 11:22:02 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: realtek: use string choices helpers
Message-ID: <20250204112202.GT234677@kernel.org>
References: <d01c4b60-7218-4c40-875e-c0cace910943@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01c4b60-7218-4c40-875e-c0cace910943@gmail.com>

On Mon, Feb 03, 2025 at 09:41:36PM +0100, Heiner Kallweit wrote:
> Use string choices helpers to simplify the code.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501190707.qQS8PGHW-lkp@intel.com/
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


