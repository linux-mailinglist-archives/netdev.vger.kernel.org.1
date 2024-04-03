Return-Path: <netdev+bounces-84442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62F896F04
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC4B1C23FCA
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7676C44C86;
	Wed,  3 Apr 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABWXuAl1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52489B66E
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148032; cv=none; b=gwaAuR31FCNQkLqVzcsTa3dw6us3i/l71CPfA6+y24vjf9J3Wc4kMQNH+cbXpJEzxp3bXCPGKRKiTCqWhHG+kEL1X+2zpr3Q4ZH7Zf1Re5Owfg+XiW8KmEMrkRf3EYsZbgvi1HwMtIoP/UWXtNSTS9DsZqwq0DNCdziVu78A0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148032; c=relaxed/simple;
	bh=IUiUdanTShcpTiUR0v1C158yt/mi1Cs6TuTIXCm3pEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt8XNQVwq3Wnv8CAYDtfSLDEQE9Y8vsActAjE279ewxq6ltRLB/pjNLMWA/+7/0R0Xi0wUBnB5nmyKO24ELqujrwVL71ea2kFuglyOxaCt3VOkREzS8ALlJ4Fu5cmWKp48P44eG+Ar9+Rvb+e1O/s/1xyZj7cZEx99SjcmsdypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABWXuAl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6FBC433C7;
	Wed,  3 Apr 2024 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712148030;
	bh=IUiUdanTShcpTiUR0v1C158yt/mi1Cs6TuTIXCm3pEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABWXuAl1WJzsZb1WGaGOMuZrhR5NSRY9ewmTIMfhCqdo1H8Dcnclpj+4mFDY3xUb3
	 mVUdDaUjjJk6f4Z2d7LkuyZLAFLkG170n57g9S6PUUKuoqCumJEC6TUGgwgnFb8U01
	 UXIJvlBNUFnNE9Rdr07zoAhXCT8jIsC9T7/eYhsYFli4pMzokke1uy7I+8DvUn+VMg
	 t3uKeaoYqv5e8ixUW4tkoQpJpkQMkugnLZht6VryZfv6ZOyCV2RXokdF8odt5kNz77
	 Z8Nv1dquODveJPOtR2auTnhlsRnimkbXRzqfkq3imQxszOHKXPyVMt42imNqwSz/ev
	 akABso+57aITA==
Date: Wed, 3 Apr 2024 13:40:26 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 13/15] mlxsw: pci: Remove mlxsw_pci_sdq_count()
Message-ID: <20240403124026.GI26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <0c8788506d9af35d589dbf64be35a508fd63d681.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c8788506d9af35d589dbf64be35a508fd63d681.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:26PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> The number of SDQs is stored as part of 'mlxsw_pci' structure. In some
> cases, the driver uses this value and in some cases it calls
> mlxsw_pci_sdq_count() to get the value. Align the code to use the
> stored value. This simplifies the code and makes it clearer that the
> value is always the same. Rename 'mlxsw_pci->num_sdq_cqs' to
> 'mlxsw_pci->num_sdqs' as now it is used not only in CQ context.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


