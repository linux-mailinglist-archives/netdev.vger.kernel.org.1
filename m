Return-Path: <netdev+bounces-95717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4588C329E
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 18:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06A9B20F91
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123341AAD7;
	Sat, 11 May 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhypjOKW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177B7F
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715446661; cv=none; b=iR9VZoZbNX07uRgTtnTdSFfIz8ituIHdmrZicZ77S3/BTl4ltqvfURnu1wDKDRLCTxSjc41xNS/v8tISeYn82Zkpo14+e1gxpPMPtAZyz1Tp5DeLKykrjwjYorwYHHz+tqbzFY+Y0S6hK9JEkWQTCsvDezHgl08PK3pRZB0Wg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715446661; c=relaxed/simple;
	bh=3p5nlUzEMoiqoU0Mt3ee/Sib4kleFAGWsYahQzTm58w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUSB6kZ+eZGfSu7u90jV7rtw1SWADcaLsM15zymnhPZyG8sazu6YdwM9tQpJ5n6CNa2Fz8hrCf5Au2Vwb2bukW9i8T6fH0OPOirO9FyHFHRUC2Bn4t/WXmuLSiv0Bsw8k6Rkf+EzoeCJ96Tg8LyHsObptMU9i2rJQxCF/G0ca4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhypjOKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A400C2BBFC;
	Sat, 11 May 2024 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715446660;
	bh=3p5nlUzEMoiqoU0Mt3ee/Sib4kleFAGWsYahQzTm58w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhypjOKWHAoS02KiabCCFkd7vxJwf73D3xeRVylnNWN02MGM5iSoZr4ABdanFrTuh
	 hrlCAda8lFQ8RostgF4GV5kD1dj9eXm1bY1Mq9TyIXjKTsW9ZXvQQHTLY1VrlKmXA0
	 ojWzpZJEu7eYiMSFosvrZWG1V5XWqrQqmT/BtMAbfR3jzV2VKEtIbg6GD5eYLRBdEG
	 Ql8aG4AbQIA0eQr5u2sVXrDjksPbQmmo45EA9ZdwKMM5Iv0sBd2YF/roJUtTtD9s9D
	 t8ErLSRtGku0A99oYOVRjm9nqW/T/Fm+OVxLZZdbbZPZABu10V0L/OL3ydjWvPlq2t
	 vzxEb6f2en++Q==
Date: Sat, 11 May 2024 17:57:35 +0100
From: Simon Horman <horms@kernel.org>
To: Anil Samal <anil.samal@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	leszek.pepiak@intel.com, przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	Anthony L Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-next v2 1/3] ice: Extend Sideband Queue command to
 support dynamic flag
Message-ID: <20240511165735.GQ2347895@kernel.org>
References: <20240510065243.906877-1-anil.samal@intel.com>
 <20240510065243.906877-2-anil.samal@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510065243.906877-2-anil.samal@intel.com>

[ Fixed CC list by dropping '--cc=' from start of addresses. ]

On Thu, May 09, 2024 at 11:50:40PM -0700, Anil Samal wrote:
> Current driver implementation for Sideband Queue supports a
> fixed flag (ICE_AQ_FLAG_RD). To retrieve FEC statistics from
> firmware, Sideband Queue command is used with a different flag.
> 
> Extend API for Sideband Queue command to use 'flag' as input
> argument.
> 
> Reviewed-by: Anthony L Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anil Samal <anil.samal@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


