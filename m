Return-Path: <netdev+bounces-30272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9285A786ACD
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470372814E0
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7970AD2FC;
	Thu, 24 Aug 2023 08:56:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9BCA73
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50ADC433C8;
	Thu, 24 Aug 2023 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692867397;
	bh=ZUWm0K2MnPGB1veeUpEF6L7XCdzCb5blF6b1tMMnKdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiCIGj1KmkZdDtpFaVxQRxlUcZfGjVeK74943F8wDmneiMHv0aZesvMI/VRc6zid/
	 XTxa811vUC8so1lpn8fCR9CHw7LGGG75pWM8LT4OXuQViiWuCI909tLuDpKQJNDpCr
	 DqjWPTuAl3hIZypXo/88wkTWpcw6FxTmrakZKJOxEY8jwctUyclK4yI+6pYNBAl2u4
	 IhKb7wkKX4dTVGQ6ZicAsPmVJuhs8ao4MnUhl+0dt1+4I/uFDnvIinWrTKoc9vVu78
	 iiOwqFdqGdRex54Ana8I0g0CW8/ZWKnfhQaoOU5B8pWQbdELJ/fRl3s/C2NrTikAUR
	 sD1x1wz2eg0zQ==
Date: Thu, 24 Aug 2023 10:56:24 +0200
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	david.m.ertman@intel.com, wojciech.drewek@intel.com,
	Marcin Szycik <marcin.szycik@intel.com>
Subject: Re: [PATCH iwl-next v1] ice: add drop rule matching on not active
 lport
Message-ID: <20230824085624.GF3523530@kernel.org>
References: <20230823035755.777005-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823035755.777005-1-michal.swiatkowski@linux.intel.com>

On Wed, Aug 23, 2023 at 05:57:55AM +0200, Michal Swiatkowski wrote:
> Inactive LAG port should not receive any packets, as it can cause adding
> invalid FDBs (bridge offload). Add a drop rule matching on inactive lport
> in LAG.
> 
> Co-developed-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


