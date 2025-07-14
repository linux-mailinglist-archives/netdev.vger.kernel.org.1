Return-Path: <netdev+bounces-206776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68542B0457F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B162F188EABE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027F260582;
	Mon, 14 Jul 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSEcZaJT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261901D5CE5;
	Mon, 14 Jul 2025 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510717; cv=none; b=d7UbLmEOl6wvS4J9kn8uiO13+izsc4S5fnGABZMO4E+GV3dbVAvXYg/vuXH+KexBW+KC2jJlOLhoSynRLM5z8pqCGuoQKcz4wDMNSZeK9mIiYYmzvecB6dui6c0Zja7obNmIR9xRo3HCaNWW4/1o++kZyp2QxiDQevb3IJ7mEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510717; c=relaxed/simple;
	bh=vejXSpkDXi2CRJw5A12Vz3zkbc+lLT/K0N+b130MARE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOPQyPWITmPrLY7xbThRjZ4NHZ2i0C6vnjMxLV16YfNMLFg1Bsd5pXR8/fnWKw92auqKvC7mVTAnOkBuNxLjLgk3Z9m7Z8wCtZ2TgRbuwzgfo694RYnYAFR5DU6g4JHRHJvCulbF5NqQYTVAAp+P5c3kix2nf89PJk56FUELACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSEcZaJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBE9C4CEED;
	Mon, 14 Jul 2025 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752510716;
	bh=vejXSpkDXi2CRJw5A12Vz3zkbc+lLT/K0N+b130MARE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSEcZaJTa8+jkJIVrtp29GCnecVXC0zKAoGiBdW5ubGRpnO9qt5DggmlEmM61R+X0
	 UDubWS2K/MKFK9POf8bhZjqt4uf4jShfszeDv34HERl0XVX8piWi0HsHyRj9D71/Pi
	 Qg5uB8/i70n45GySJrHPODPvAQcmJRYa8KaehiNwMFFXHRGlKamcRDcCpbeVmgDU7/
	 2gV6KPqeZk+vOaKyB1C5WbLvqVcBImDPpw7NCLGdy7LAtuRzsu+xMrz80AKmco7meO
	 3P/7QW684VzSMEHvTSggG/IGHIvD1qZr4DE5OCS4X202yr8miEGYg0FyKB0l9ER7z/
	 pGY4nrGJmEqzA==
Date: Mon, 14 Jul 2025 17:31:53 +0100
From: Simon Horman <horms@kernel.org>
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	edumazet@google.com, kuba@kernel.org,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next] igc: demote register and ring dumps to debug
Message-ID: <20250714163153.GQ721198@horms.kernel.org>
References: <20250707092531.365663-1-rsalvaterra@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707092531.365663-1-rsalvaterra@gmail.com>

On Mon, Jul 07, 2025 at 10:17:10AM +0100, Rui Salvaterra wrote:
> This is debug information, upon which the user is not expected to act. Output as
> such. This avoids polluting the dmesg with full register dumps at every link
> down.
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
> 
> This file hasn't been touched in over four years, it's probably from a time when
> the driver was under heavy development (started in 2018). Nevertheless, the
> status quo is positively annoying. :)

Reviewed-by: Simon Horman <horms@kernel.org>


