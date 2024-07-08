Return-Path: <netdev+bounces-109913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F9392A423
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793391C211D0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9413A3FF;
	Mon,  8 Jul 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIHpFdgQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55207F490
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446933; cv=none; b=iz3Mf/0BZnHk59N9ydCDXfkYvw8xy5CCVtlcMEr4xLKYk1U3g6PuwGStSycb66a4YcH1HUK/OZcp4QRchscc/fFwxTtziAeC3LVVhhZKIZ0dmSePB6KQ/p4Sla4ofCpa7P9ZfLa8O8wbcEf9wvexJn1vc/2OwYjgG3Nf5+WIJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446933; c=relaxed/simple;
	bh=os3BeGXRPspxFXn3m4faOMU69cBInTEvRSHgs+1ecoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PW/xnnPtTwy5ez3YcFL8njacg/IM68pZST7bBynbmhS7XACJjD5VTnPLs4j17u1Rp7RCGRkv6AEZ1umweXv8lGigWCUNT6pE7mgx5RzSb/SdXB+v7zHgFYSWxePq8kvKcd1KG2N2o+HMk7FC71+YutTqfvDDClKe4vdYd8yFJSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIHpFdgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921D9C116B1;
	Mon,  8 Jul 2024 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446932;
	bh=os3BeGXRPspxFXn3m4faOMU69cBInTEvRSHgs+1ecoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIHpFdgQSiWMM0oTbm6Z9TYcbE3hTsm0MzdzBuMb1yH53OLsNpV0dO+TMk/xgVpdv
	 H/DVwDAoVvUIlfxYSasXsF1vusoorJHGFeI3Uo4OwvAH3v9ESzYCmU6ldYq32HgQF9
	 JDP5vm1TIdoZAhP+OyplorLBhO+gy7PJMzKfKgpow9O1nDFsMFhmQ8MESbHtHVlit1
	 Bj4zmwNWcAEw8h+XGgLBl8CKalpK7ZNmc3z928kd339ZtvgrBEES7/vVMnjC+7ZoKv
	 OyAT4xDhchiGGrg5v7anCOFra0KVKtNHZNULtfjDxutMoNnZrfKW6DWfi5+vto+iuW
	 QsAyLgw1TiQLg==
Date: Mon, 8 Jul 2024 14:55:29 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v8 5/7] ixgbe: Add ixgbe_x540 multiple header
 inclusion protection
Message-ID: <20240708135529.GW1481495@kernel.org>
References: <20240704122655.39671-1-piotr.kwapulinski@intel.com>
 <20240704122655.39671-6-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704122655.39671-6-piotr.kwapulinski@intel.com>

On Thu, Jul 04, 2024 at 02:26:53PM +0200, Piotr Kwapulinski wrote:
> Required to adopt x540 specific functions by E610 device.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


