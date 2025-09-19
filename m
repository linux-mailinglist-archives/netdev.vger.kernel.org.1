Return-Path: <netdev+bounces-224806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D111B8AB4E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7082917F3C4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF633218B8;
	Fri, 19 Sep 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmvaQ+wU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED09320A29
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301859; cv=none; b=RlweC61lGqU5rNsFYC2RSGEDW1UZa7+KDLPb89M2ot2uPjifcdzzDoR8gF0p57xga10AmhUiQVzIU7d3WkgzAPZrhDgaMzzkLBDGPHrSitK5IdtpD7HYJpFjzIRZVuR15m/D678lVyEYmA/6j9U/VPBiblwW9Jhp60iEuRd9Ysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301859; c=relaxed/simple;
	bh=uKo7KcZTjLb+ryjxArtdV/JFLS8ReV1ATabcAA0zYrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne42FWqn/zeq1rB2JgG0Y+yrsPA27LatlvBaFFp6SyNmmcFNaDjpDft/PhypjrAyPRl94KrFXyxveejMMuha+lcqmi/b39S7+Vq1bu7BO1XIfxZlsZiKxejLDYPP2wF23MWTKwFLKMaHTCEcKGC6z07ZtCvNieE8kYjPHBLpljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmvaQ+wU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D13C4CEF0;
	Fri, 19 Sep 2025 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758301858;
	bh=uKo7KcZTjLb+ryjxArtdV/JFLS8ReV1ATabcAA0zYrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmvaQ+wUQ0r+req6GVr6bwZe6dtoBQMiT7PYiewDPAVDQn04wTIxn+FukY9TqtDGc
	 t3dUD+/7k+BtTp9miIP30pDo0dRMUNBd2u+qVjGD4UJXjKQGRdw2Aj4TPJZyRYnJNH
	 xawVpb/XrzR+1EfLMxj/D6JBmwEy+RftwrX25ySYVYmKvWiLlwpg4B4Uty1PdAX5gK
	 vSmfOZZbjYaC9UicTDlyshKqkuLRsyMXZ6KrfK+/XLgYS/XiRpmcWq8ZZw3+Sa189k
	 U9SP9JrA5svB5nNeV0qYK2mTrSSVW5iVUjFqHWdn6cltp9sB9V/lh+dd0RFk1+Lr+e
	 /BKaO0eniGXQA==
Date: Fri, 19 Sep 2025 18:10:54 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Malat <oss@malat.biz>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, sbhatta@marvell.com
Subject: Re: [PATCH net v2] ethernet: rvu-af: Remove slash from the driver
 name
Message-ID: <20250919171054.GD589507@horms.kernel.org>
References: <20250917113710.75b5f9db@hermes.local>
 <20250918152106.1798299-1-oss@malat.biz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918152106.1798299-1-oss@malat.biz>

On Thu, Sep 18, 2025 at 05:21:07PM +0200, Petr Malat wrote:
> Having a slash in the driver name leads to EIO being returned while
> reading /sys/module/rvu_af/drivers content.
> 
> Remove DRV_STRING as it's not used anywhere.
> 
> Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")
> Signed-off-by: Petr Malat <oss@malat.biz>

Reviewed-by: Simon Horman <horms@kernel.org>

