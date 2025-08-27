Return-Path: <netdev+bounces-217385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D33B38814
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD381895F95
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305102C3770;
	Wed, 27 Aug 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXgyX+Gr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9EB22E004
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313723; cv=none; b=H9gSbDuVjmKtEdP3YHD4g0zYjVZFFgJqGQKUMZiUuA1nkUAwANrybq9LDixwHaK4Uo1AvFZ+tG/4aihLKKTCyN+6BV3JPoV/W7/UMpLY4cZ7QDoDzLbr5t88VaVDIQrkktWoRODwRt7bHPGsRjSAcqi4BWvd0qgCkC6YC9Mr+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313723; c=relaxed/simple;
	bh=87Pa2EsvRjglAOK8aVJ2IbjE5VhUQIJHGGVso1Q08pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISsk1ZBI3TcLY/3l14EO6WEgnjQ09xPmrgGaNFi+Xq5uklD4siIsnz8yb3XYd6JAS/GZSaoPCSPUoqPgTcxMgvxjk1smP35O2wrQ8niFhpz9CLRLNI/OP11+lTF52xraUq35/s7WAqjQM18e043qbSz/ddq54izX95L7FBH2Eis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXgyX+Gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EB1C4CEEB;
	Wed, 27 Aug 2025 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313721;
	bh=87Pa2EsvRjglAOK8aVJ2IbjE5VhUQIJHGGVso1Q08pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXgyX+GrKyGi5/mkH/+PjjJHlxjlUJ9DvSRZHduGA+cIvO7HfDoCg7mq4QwITpTm/
	 AFNxSC+ErczfPWybnttOYoU/eb3E4pPSJZ/dvLjItBrNxRK91VuZPNOV6hduk2LiqA
	 uKrk2p7s3bdAXJZ1jerwvUs+CAcLPB12+30fYDIAwpA5RPR1W535zqCJZoN8STpETM
	 9/DeCDkspWFFI0scpoqEfcOwYXhb3ddjUWhz74y3lnQbmQH7weJvOcPfSrzlQvHY6X
	 YPWH5uKlPeIUlpz49mmOtoU1Hw8CRF/d/QP2desv0gUpoJJXNnvfoQFGfTOgpBVWeB
	 uCSAhPTG9ewHw==
Date: Wed, 27 Aug 2025 17:55:18 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/13] macsec: add NLA_POLICY_MAX for
 MACSEC_OFFLOAD_ATTR_TYPE and IFLA_MACSEC_OFFLOAD
Message-ID: <20250827165518.GJ10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <37e1f1716f1d1d46d3d06c52317564b393fe60e6.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37e1f1716f1d1d46d3d06c52317564b393fe60e6.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:26PM +0200, Sabrina Dubroca wrote:
> This is equivalent to the existing checks allowing either
> MACSEC_OFFLOAD_OFF or calling macsec_check_offload.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


