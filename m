Return-Path: <netdev+bounces-41781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2007CBE32
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6642813E3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A983CD15;
	Tue, 17 Oct 2023 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6Ohdjyb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564F3CD01
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EE7C433C7;
	Tue, 17 Oct 2023 08:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697532811;
	bh=XSDli1Ya/+IIuI4nruVZUOov80XjZyYHjskLdegD3ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6OhdjybliMqDLIvBazwJf2rTAWWH6qnuDTu8z4GdJCHpfxCZIO6ZU+89FtZcQtK6
	 Khoghc2EfxxrUNlx/2kB3efytUrCtUaBXIVvtYvxTfEnABcWBIPSpKkSeOmn+qUhyM
	 mYYI19v1u6dI2i+lNQpfsTH0ND/EHP8c9/klYt1h01DnT4RMiAgzhT5X4pMrYa7IJK
	 Zg7S2lPkfbHnrs0Ns11XX/0nSbGK3B9HdYFDu7GKy57uB76Y5PgEY0Yy+bdoQrNg9M
	 ztqCzBcDpF9ebgLOX9iA/nbHaV+MJxrPmNGL+My6XWeOdjaI0mN7ZQiqghifmNl8sX
	 kk6EaDjYYzuAg==
Date: Tue, 17 Oct 2023 10:53:28 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next v3 7/7] devlink: document
 devlink_rel_nested_in_notify() function
Message-ID: <20231017085328.GO1751252@kernel.org>
References: <20231013121029.353351-1-jiri@resnulli.us>
 <20231013121029.353351-8-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013121029.353351-8-jiri@resnulli.us>

On Fri, Oct 13, 2023 at 02:10:29PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add a documentation for devlink_rel_nested_in_notify() describing the
> devlink instance locking consequences.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


