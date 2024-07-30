Return-Path: <netdev+bounces-114100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337E3940EEB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645AA1C20FD8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CDA195997;
	Tue, 30 Jul 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBw7NgVm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB2208DA
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335008; cv=none; b=Kmc3IZ+YUvt+1Kh+Wp70j2V500nOv+Qk9SlsBuFtZKckCDHGzEDOrVmC6i/2HudFdvf21LNvjZSZWliL94pZJggj/uMZZAzCfer6TUORgdFMtPiBdUMX0h8VGzuxRptWrPH3YZHXMSP6O6bbdDSZM+wUBHOCGhBzl+qmLADLC0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335008; c=relaxed/simple;
	bh=67OMBK5OtSZOYrk1GahfzAECnxtvjYjzquPXPhvYx9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOJu6lcDBEnBe3ExiaHkfq1ZArL0p2tR1dJxQaMuuHEFRCH9TtLIROWE0cw72Nf2hlfNqju5dd3VJEXah0mCvz5S4+U45TSEp5oQ889ZOzc7qnsSYBGoYIuX1S+RBjLf+a+lahlNKbv/Z22MGbWU8UyyFOH1U3qnnpm3GqwHfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBw7NgVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A49C32782;
	Tue, 30 Jul 2024 10:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335008;
	bh=67OMBK5OtSZOYrk1GahfzAECnxtvjYjzquPXPhvYx9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBw7NgVmfbyzy5zeYfkUEIHrmYKXj+cPWZDO3n8zT06utrQ679WotbNysX4ER7o1K
	 CB92qVxh+bd2xajwTHXBiqwpGmSgDLN04ASir7niP7SEoFII+L6gXxBxAbJ0275Je/
	 AKuA4WDKMKpxAWRHpZmrgnwXlsEn8m9X0qEPxgyIaOs22x/FLSKCkJBWxI+1mc0Tgd
	 7V55sHcb2NiuOXJ5CZgQz4Hs5SSFNYVnCQsJMy49ETqRMlUKmWGufHzPH3CqC1pamu
	 CxavP4ikuGZyIGnf8wT7jKVByfknfMekW+3u1t3nECbbyVZLg8Z7VWLRKmmGYMmznR
	 6hB85f7ZCkm+A==
Date: Tue, 30 Jul 2024 11:23:24 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	hkelam@marvell.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH iwl-next v5 08/13] ice: add API for parser profile
 initialization
Message-ID: <20240730102324.GV97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-9-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-9-ahmed.zaki@intel.com>

On Thu, Jul 25, 2024 at 04:08:04PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add API ice_parser_profile_init() to init a parser profile based on
> a parser result and a mask buffer. The ice_parser_profile struct is used
> by the low level FXP engine to create HW profile/field vectors.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


