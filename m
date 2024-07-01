Return-Path: <netdev+bounces-108082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1288991DD07
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0BBCB2184C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCF512C486;
	Mon,  1 Jul 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDoiTZcS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469E84E1E;
	Mon,  1 Jul 2024 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831001; cv=none; b=WawJh1i3N5NQcxypZcoWiSUpKNhjH32R2Ucczd44bG/a3SKgsxYMlESDiS0I9bs7kQQN8Ex/hVp18ACBSh8fKTiaCJAWe3nvgW7x7qtiaaHqor3yGSHmyBHK9lCAKf2NwY3XmUMfdlPuhwNFtheMwdX6fvg6M9R0m6UJPcyavLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831001; c=relaxed/simple;
	bh=TAXrBzv9kQ9VuawTuZK62fZqZYtqXyrNF9bSiECDrLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad85Ox9H/TZa9taxaPeSHA6i2ESGT9i7cIdHeYcjjCEFzgxgMD2t1qUqOoq3LpmmvNmH3V0hDfra7xhqDzFeoHKbJzvszUolwiFQJ7rJ/VqdegZ1x+osvwn9oU5AoTjFFX+5ufcjWUZ6+WQEedIxzvnseCCAyvhmruABUuqt+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDoiTZcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F32C116B1;
	Mon,  1 Jul 2024 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719831000;
	bh=TAXrBzv9kQ9VuawTuZK62fZqZYtqXyrNF9bSiECDrLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDoiTZcSGubF6nT0bHKLz2kPKlCLMxqQ2F5pv3SEoh8SSx8DZvrPTnStnuNW53lNx
	 QZ6eatuzXirbmq1WMjjt1nE0WdJq5BupdihpI7xprM5Ma1PpsttZB2JGOK9SzIjtGL
	 4DY+//hC3OlpNTGYrneao2fLIwOS9TcnXmJRUybwuQswc/oimxPNY7VHB2mk6fYsIA
	 F85j5X2GUhz7ccA9qBMrogZzMdu0ijao1xklt440sz6Bp/8e1qRxsiD2R+UzvCGhSz
	 oEZ5R2YORlFrSAUyVhYeOq/F78wW3l7Y/kdHs0v7TeXK7Yby8O2VEiyaMsPQ2w0GQ2
	 v4XJA+oIHMznQ==
Date: Mon, 1 Jul 2024 11:49:56 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v7 02/10] octeontx2-pf: RVU representor driver
Message-ID: <20240701104956.GQ17134@kernel.org>
References: <20240628133517.8591-1-gakula@marvell.com>
 <20240628133517.8591-3-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628133517.8591-3-gakula@marvell.com>

On Fri, Jun 28, 2024 at 07:05:09PM +0530, Geetha sowjanya wrote:
> Adds basic driver for the RVU representor.
> 
> Driver on probe does pci specific initialization and
> does hw resources configuration. Introduces RVU_ESWITCH
> kernel config to enable/disable the driver. Representor
> and NIC shares the code but representors netdev support
> subset of NIC functionality. Hence "otx2_rep_dev" API
> helps to skip the features initialization that are not
> supported by the representors.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


