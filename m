Return-Path: <netdev+bounces-182944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2174A8A692
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058B917DABC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317D188A0C;
	Tue, 15 Apr 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uScy2vps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1E8BE5;
	Tue, 15 Apr 2025 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741031; cv=none; b=Bhte9ml+Lbd4abr9+4M9EUMRWEWybQeU+tGmZivRqzyS+KRaON/mx/JWfCFoRrztO2LjEZ25kwzKt21V2+h0Q2jxDm3xoOeJQ5zoc/wxURsiXNqRNujaXKTf+MPC/0C4qqoxKlyYIQTy4o12zKuB2OMo45TvTHmjblZ/+DwaFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741031; c=relaxed/simple;
	bh=+S1RkefxSLu0BLjsBF+uTMCQPDl4MeKRRYq4gcDITOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUGlf7jvK6ISdoA5o6+a1WAhA3rX4wejqSLUxi0VC4z/A8bHZ+a5yV4aDq0OcC1hG1fsa8TYDVtv2ctY7sypdJ2eoKUhNhZ+Qj8IazAjIYUkBFSpL3nqQddWaSGLyWooW3+T3hX9kb7DVvajrh2xSOKeL+aqCQiEtsumRDL0MGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uScy2vps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC09DC4CEE9;
	Tue, 15 Apr 2025 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744741029;
	bh=+S1RkefxSLu0BLjsBF+uTMCQPDl4MeKRRYq4gcDITOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uScy2vpsAkathJDSh7Vw2l00N5YC2v2ZPdb7xiQSdSneFfPfgzyOKRaV47UW2B865
	 U4quEq7VvYyTJ0gYWfP2fZmWya3E9NXRjlJHgmSzAesBXSrN31hX3sk74KWhUyuNCU
	 kH6q153ptEpFjST6C3l/1UWAfmZPWKgq5/jlA9RCsmYx7Rq09b5dZK6bhStX9kx/1D
	 yByriTnO9NfFXHJD4eqYb3HsOTNACNwG583t6zfnfH4zRQ8/rYyIT5cgTEkL5T//x6
	 Iqs8w+agDdkk7cn1htMj4LfxakgsA+ggkwrvTTCimqd0Oi/mKsFhG65Vq1pCKiwLNb
	 9Sjaibl3wjaeg==
Date: Tue, 15 Apr 2025 19:17:05 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v3] rtase: Add ndo_setup_tc support for CBS
 offload in traffic control setup
Message-ID: <20250415181705.GC395307@horms.kernel.org>
References: <20250414034202.7261-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414034202.7261-1-justinlai0215@realtek.com>

On Mon, Apr 14, 2025 at 11:42:02AM +0800, Justin Lai wrote:
> Add support for ndo_setup_tc to enable CBS offload functionality as
> part of traffic control configuration for network devices.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
> v1 -> v2:
> - Add a check to ensure that qopt->queue is within the specified range.
> - Add a check for qopt->enable and handle it appropriately.
> 
> v2 -> v3:
> - Nothing has changed, and it is simply being posted again now that
> net-next has reopened.

Reviewed-by: Simon Horman <horms@kernel.org>


