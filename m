Return-Path: <netdev+bounces-233621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABB8C16698
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAF93B06C7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DDD34F47A;
	Tue, 28 Oct 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtAT6LVf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4134F474
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675153; cv=none; b=Swr4Z+ycTGi7XxXIA7fO8qN6x4MCwkGe5P3zXvJJ3Jyb8UcWsKWud7Bw6IjV86RkcCoDmevOFYaEdudsds+GyBw1iBczv2MhRTnc/AXXfX/lfH07N064yeGiw2gpKJQErSOZDBMERgegHd5BuuP4Sw17dZyugPKTOGYmAJDqnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675153; c=relaxed/simple;
	bh=FdgKUel8Rdr8U3hgYEJeelUVjbNqlBCIt46+j3nPvzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSLprOUyk7SbnuMp188xjmrA2oNN4m21SI7+ivSEU0I/FOhzaBI01KlXw0M4wV4W3HICRWz2S6cvDymbr7Q99dCMPnu+XoHz75oiKbX461C0gcR38IFuPJ0oj1nZlz3ppS0JPeQzRO527hburgkn9q1kJWvYJ45UxVWl57G+1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtAT6LVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B77DC4CEFF;
	Tue, 28 Oct 2025 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761675153;
	bh=FdgKUel8Rdr8U3hgYEJeelUVjbNqlBCIt46+j3nPvzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RtAT6LVfZItjKcfIY/5taKbAHk080g5kjCLFKYxv2hW/Jt3afLpLS0iwRvUC4V1QO
	 WM/yAZSa7nbD8Er0jKGskLm/hsMtqei/zgoRwQ5kyJpQu49/vWzPoL0VuwiG2b8NQD
	 7aYjYKfhGX8vbhv60JCNcPc0xUCjyr6KfzYjP25vHslFdjRz7I/1e0K6ElkgfJAbz4
	 l64g/5aevgb6CBtZ05w+w3OjMPN/MId3bW7rdh6fCdp6HR/kiV8NlrPYgaRr1bfsWh
	 Czn+b7R/tml6nUurqmYx8/fhTqqKO09fzOGd/aSTIXIlXUv0/HsbsRBmEPqyVessLJ
	 0aw+gs4Uebibg==
Date: Tue, 28 Oct 2025 18:12:28 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kohei.enju@gmail.com
Subject: Re: [PATCH iwl-next v1 2/3] igc: expose RSS key via ethtool get_rxfh
Message-ID: <aQEHjPudkOSpk248@horms.kernel.org>
References: <20251025150136.47618-1-enjuk@amazon.com>
 <20251025150136.47618-3-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025150136.47618-3-enjuk@amazon.com>

On Sun, Oct 26, 2025 at 12:01:31AM +0900, Kohei Enju wrote:
> Implement igc_ethtool_get_rxfh_key_size() and extend
> igc_ethtool_get_rxfh() to return the RSS key to userspace.
> 
> This can be tested using `ethtool -x <dev>`.
> 
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


