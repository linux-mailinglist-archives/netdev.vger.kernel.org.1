Return-Path: <netdev+bounces-217389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B303EB3881B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38F91C20C1E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDFC2E5D32;
	Wed, 27 Aug 2025 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpWLWbT9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830D2C2376
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313836; cv=none; b=reEA3E+us3+VbPlcU91LzZwONMW84H0HM3g4v2l5N6XPHhSMDIRdMeDt8Zq/tbQC3MIymtov6xy7nPTO4wZVZxYP4pu6XcF613QwBPcBv7k7vBFCNpZKtfsa5Dl0R/M8xRDQNZJOhI4+SVzBxfzaa2/LkPiw87sbPbxbwmuAK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313836; c=relaxed/simple;
	bh=wwjac5wkYeB13ceGZZ7SwDEIx4zx5oGlv42pXOiDK20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOoarh8rnwNmR01r+xKmZsbq16yNu99S9E149odktWsKDllh2QkX4qF/OcmE4uyN7JOSUHt1zzdAslmjV+E99jVQDat28XmrcPuRpNV3SkyKZoiAPPDf/TYKgrUMI3qE7D4krWSeMc6kM4DnXtZAm0TZb9nNgNjc+y+Y3oAjvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpWLWbT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75C3C4CEEB;
	Wed, 27 Aug 2025 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313836;
	bh=wwjac5wkYeB13ceGZZ7SwDEIx4zx5oGlv42pXOiDK20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpWLWbT93FvJM8nacdniPJBVBKzU8QPzhg3e6lo5Ag9X8VLUzLA3uT4a0kiUBs9dx
	 zfOaT+bzT9V9fDYU8+AP7VsNtrtRgkOOzJK+w2f05gEFr6ZHEdbfaTtJsqNRI8dNvM
	 B+DT3gPD+VDRmNmahq+ebqlsIEvFy9+ONCfyWlaWuez1QlkQOfEEegek2zv1ur2QRo
	 MK5MRR2wB3BFzgoYND5sSSxG2OX2Eb23cIdvCSBO5+9eUA14ep2AsBIhsBmzXOdkau
	 iF1g469Pvac4NPIRNlI5XH6MlOWEPIAazRsHL9sHfWhOxoqz46l7rcr6zPCd96nutA
	 0mrJ/B3DhYxuA==
Date: Wed, 27 Aug 2025 17:57:13 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/13] macsec: replace custom checks for
 IFLA_MACSEC_* flags with NLA_POLICY_MAX
Message-ID: <20250827165713.GN10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <95707fb36adc1904fa327bc8f4eb055895aa6eff.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95707fb36adc1904fa327bc8f4eb055895aa6eff.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:30PM +0200, Sabrina Dubroca wrote:
> Those are all off/on flags.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


