Return-Path: <netdev+bounces-23129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E89E76B096
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60204281470
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03E120F85;
	Tue,  1 Aug 2023 10:13:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDDF1DDFF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194F3C433C8;
	Tue,  1 Aug 2023 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690884791;
	bh=xWca8/ZDCMl2V9YZDxFKIMcLx/VDVMbkIg8pozefa/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HELxYlTmXFgNRdlMCXAvsW3Zp50iZoApeiTJgeUF17NXynBL82K+oCPIK2tXzw24R
	 gJ1JK3thftEpXqzaJIoc0sbEmz3FXIm2Urud8diSNIgXHj8/y+ANAX+GJHgnIUfu/W
	 99hhBv1w1/DjUQOltckn+Ts4KEX3A60fZijAXvACme8fbFBH8aXGmPBlgqxC9dGLW6
	 4hm7ygJAhaUC07et11jRVVh1IrJFxG5yM6bnsnBxCgcS0UiToSwbVXXKPwPk44pxDy
	 pxpv/QUMDt++HXyfPoQ2W6h9Jqay4/OX1tDh0Bsuk1MzEoKY7xXQ33EWVpJ1Px82a4
	 CaO4LcqOZIVDg==
Date: Tue, 1 Aug 2023 12:13:07 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: aelior@marvell.com, skalluru@marvell.com, manishc@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH -next] bnx2x: Remove unnecessary ternary operators
Message-ID: <ZMjas31vx/uiZzLV@kernel.org>
References: <20230801020240.3342014-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801020240.3342014-1-ruanjinjie@huawei.com>

On Tue, Aug 01, 2023 at 10:02:40AM +0800, Ruan Jinjie wrote:
> Ther are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

For non-bugfix Networking patches, it is appropriate to
designate the target tree as 'net-next' rather than '-next'.
(For bug fixes 'net' is appropriate).

Link: https://docs.kernel.org/process/maintainer-netdev.html

Otherwise, this looks fine to me.

Reviewed-by: Simon Horman <horms@kernel.org>


