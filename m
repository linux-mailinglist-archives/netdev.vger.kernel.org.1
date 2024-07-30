Return-Path: <netdev+bounces-114104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BA8940F73
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847D61C226D1
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71271A00C6;
	Tue, 30 Jul 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyj+z7OT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D31A00C4
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335320; cv=none; b=ESNqZ6FlSGvhVoXe/X7T65wPxSNwMngTBfiKZHnoy+etTy1KjpVHJHytzMojpb552VcuQoxUGk8E3r4V6MAMYBRzOWhF8WaqAZbnNj/TXqvmMUZrjTgIjxQ5S0Ypplw9B5hpKJhdv9ELTIUri5ZcAbSKCJPiXKC9oja/i1mFw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335320; c=relaxed/simple;
	bh=SZ4c15f7l1jB8rzYdsQuU2R5Kome+64Aq5Sa2WoTqmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5iR4bT5Qya6Gb9NQsOmo9x8KS+c98howfH+Rz3FR5CHQK5Qftd/YJs3+/oCDWrgaV0EE75Y3eDAAFbg+MuX2NwJgmbJKhRHYZ2MUIkTJqRBF7gPckA62Eg4M6ATgxYD39e0MlIE1nEGIYC3liO1caKhtRi7CePF+XsfojfmT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyj+z7OT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B68C32782;
	Tue, 30 Jul 2024 10:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335320;
	bh=SZ4c15f7l1jB8rzYdsQuU2R5Kome+64Aq5Sa2WoTqmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyj+z7OTSqx00XpnL7l3F6uy1U1NdX/OPvPq+WAGw4TFek5aOw78lRfNei4PjiJmt
	 idr07II31dRY0TAElAAQf9mwsFQTkTb4JJFFmjBqejJWwaeXgM+4jKkP4vD5+SGlUn
	 /F+dK5GMzD8gu3ttC5aFh850lgJlW3XpP1EpgKucNo1Qk14EsIdEQDRxQmeMo2XzLL
	 meDFYHqSWy/oQXy4GSZuZZrDNB8WD2YXdUcthgsZgzcav/c4CHWfh3chxsH5nouxkO
	 jLyEPZEUZrDVXEk42n6TE2nDiwUocYRv0C/nT11p+x9FwrYkYrt3maHB3IrkMESrCI
	 vNvyRAqNSTRbQ==
Date: Tue, 30 Jul 2024 11:28:36 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	hkelam@marvell.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH iwl-next v5 11/13] ice: enable FDIR filters from raw
 binary patterns for VFs
Message-ID: <20240730102836.GX97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-12-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-12-ahmed.zaki@intel.com>

On Thu, Jul 25, 2024 at 04:08:07PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Enable VFs to create FDIR filters from raw binary patterns.
> The corresponding processes for raw flow are added in the
> Parse / Create / Destroy stages.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


