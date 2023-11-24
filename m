Return-Path: <netdev+bounces-50783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54C07F7233
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69240B212BA
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11E199B7;
	Fri, 24 Nov 2023 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPyI3ulw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13C61A726
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 10:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624EFC433C7;
	Fri, 24 Nov 2023 10:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700823565;
	bh=EOZkNxRfA9Kl8PAL0nuQ12sqXCLbdky3xV1Jm+uFK78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPyI3ulwG1+FFG9WtTaXBUAxJKkTxQRoAHT2ldefgsIU7gLM+/LnTDNtqARlyzNzb
	 fLGIUIlqbyJ46myP54n5L4Utk+JPsUNfuNVDasWQgbmhWCkkoNkClSyrv1D1IGCziw
	 2ayPNlScgRkSURN3sJpmeDsQyNLbqq/vmOEmZHwgSmFixVmFa5oGelfnu6zMecQNpB
	 YaWjmk5tYESzPLvmVZOVDJeXQncVfNiGubRWKG9/askodtUP11o4C8ypaq+67dq6/a
	 3cRLOvwpCKyVONk4hzhLbXVf1GdW7ScgC2HVVW/xQRlVAHU3eOeGN6Fpq+HF2UeYPa
	 v8Xff9djaxz4w==
Date: Fri, 24 Nov 2023 10:59:21 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v1 01/13] e1000e: make lost bits explicit
Message-ID: <20231124105921.GA50352@kernel.org>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-2-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121211921.19834-2-jesse.brandeburg@intel.com>

On Tue, Nov 21, 2023 at 01:19:09PM -0800, Jesse Brandeburg wrote:
> For more than 15 years this code has passed in a request for a page and
> masked off that page when read/writing. This code has been here forever,
> but FIELD_PREP finds the bug when converted to use it. Change the code
> to do exactly the same thing but allow the conversion to FIELD_PREP in a
> later patch. To make it clear what we lost when making this change I
> left a comment, but there is no point to change the code to generate a
> correct sequence at this point.

:)

> This is not a Fixes tagged patch on purpose because it doesn't change
> the binary output.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


