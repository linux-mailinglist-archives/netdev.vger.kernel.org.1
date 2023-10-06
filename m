Return-Path: <netdev+bounces-38541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACBB7BB5CB
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9FC1C20995
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728321A5A0;
	Fri,  6 Oct 2023 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSNEFjFz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573ED18638
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70F1C433C9;
	Fri,  6 Oct 2023 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696590140;
	bh=/AiQt6xMjQANDqSARgcjTT9Ch/cygsDodcoeNEI6Xwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSNEFjFzdW6EBQL82gMD/I7Jpg2e7oQ99qC2QywkQYlwjg3PZYJ05tRALVIZCf8Zd
	 E2T91sCED6eOug8LJTBF8Y0p1dZ0hLBcG6uHcU9EuRYfoqgoaP8Oh8V6+XqLG7HfVu
	 zLh3oIhC5VhoW/t9PE6v87UhXiyPxfId/m2rmHmd5y3Iw1PICx520qUoKBVbmf9TfP
	 4cjHxQpfpKgG0mLhRq2LUlkdBiX7N1GNXAj8jluKhb03PzlSH/3dWBkFhKbt30crJ0
	 4wjPvPambwZjMULzYXyvP2AmxxJ9bN8akVomRgT402DZRYjAZlKjVY3DwW3q7WDUf+
	 p+lVll9TJADiA==
Date: Fri, 6 Oct 2023 13:02:15 +0200
From: Simon Horman <horms@kernel.org>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, tglx@linutronix.de,
	jstultz@google.com, chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com, ntp-lists@mattcorallo.com,
	vinicius.gomes@intel.com, alex.maftei@amd.com, davem@davemloft.net,
	rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v4 1/6] posix-clock: introduce
 posix_clock_context concept
Message-ID: <ZR/pN0Ll5VVNpL4m@kernel.org>
References: <cover.1696511486.git.reibax@gmail.com>
 <35e1e4f96e8ad58b4ee6a7fd46424f4cd6294353.1696511486.git.reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e1e4f96e8ad58b4ee6a7fd46424f4cd6294353.1696511486.git.reibax@gmail.com>

On Thu, Oct 05, 2023 at 03:53:11PM +0200, Xabier Marquiegui wrote:
> Add the necessary structure to support custom private-data per
> posix-clock user.
> 
> The previous implementation of posix-clock assumed all file open
> instances need access to the same clock structure on private_data.
> 
> The need for individual data structures per file open instance has been
> identified when developing support for multiple timestamp event queue
> users for ptp_clock.
> 
> This patch introduces a generic posix_clock_context data structure as a
> solution to that, and simmilar problems.

nit: similar

