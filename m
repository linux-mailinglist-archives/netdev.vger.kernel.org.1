Return-Path: <netdev+bounces-114099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2158F940EE9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BD91F20984
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60D195997;
	Tue, 30 Jul 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fktfH51W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E5F1957E7
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334994; cv=none; b=i6/JUyKB5WPzZQrMit4D+zzo/lNH0yk9iskU/yiQtuY2CkqIzg/zWLsAbdEMTLGuzI2L0wSdzIyuQ+MD1ArLcHfTULyw3uzdsz6J/wxB14njtYs2LrIgvTa4BveE9iUIFqseZ8B+WNw+gzNolq2gHs9/Ng3r8B503+Mo6thrCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334994; c=relaxed/simple;
	bh=pT4+ay8DDR3nEJS/rR28xaqLvwI5HQMmBzAJq6x0P/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dps8Z08NcM6cOBTOUu1wpB2SRISXNVu0CfrOAoW3ERSQDbk8ImsEbk/k8UrytZ0YYfj84LFIX3nNw+c+eHkixd7onYfBR9LFUCMCKgB4AY9+KB7sWszXK9eqMoQjXhdxJzBv7h0ItbB/+Rk5uWA0ZaLm4JENh/8/Ot+ckR7c1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fktfH51W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1FCC4AF0B;
	Tue, 30 Jul 2024 10:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722334993;
	bh=pT4+ay8DDR3nEJS/rR28xaqLvwI5HQMmBzAJq6x0P/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fktfH51WjzVxXOBHOw7WTdoaO8w/oJH8nQ309C+x2go71v6SfsR1Zsbq0VUuhZjEU
	 JY2mqB/m5vXYtGG4mEC0+RL1GdTK6729SOJWF5uRd9oq+db92/rRY9Ptr46JjAcwEA
	 E7cWI96cr7Z7Ncedg/LNa4eNkEMk5nSVD1MY3Z0fSHroq0FoZ6rbwA6pZ3Nm8jZ2VE
	 V4uU6U/66uo7MTHJ/LxqzD9cOTCyMtzc47+XY2Cjs5B1aaD4uOozcs6UTlq26CPnwe
	 nBpLTTjRKb+WRLvmyReoJmmaq+WeNDUVQco64elvflLsdYnB/f/stKhOP6f8K2il4S
	 opZteaYHyGckg==
Date: Tue, 30 Jul 2024 11:23:10 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	hkelam@marvell.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH iwl-next v5 06/13] ice: support turning on/off the
 parser's double vlan mode
Message-ID: <20240730102310.GU97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-7-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-7-ahmed.zaki@intel.com>

On Thu, Jul 25, 2024 at 04:08:02PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add API ice_parser_dvm_set() to support turning on/off the parser's double
> vlan mode.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


