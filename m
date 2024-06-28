Return-Path: <netdev+bounces-107681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9963691BEC4
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C98282B55
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E21586FE;
	Fri, 28 Jun 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh10G45h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539C1586D3
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578477; cv=none; b=gSDP9fx28bMUA24zCZgMXkk2O0yb/X6G8gTFQceQhep6NqESgIT8+db4iYZb0BtlUm4kIEB5DrwPVweefF/z28qJREGaz1KAxN/mqz0gRRW5rozed9Uo2SUuBmI1utr1S/8rijf16cuUCEX28Jig0WXu4V33i8IhDigMyjc2bxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578477; c=relaxed/simple;
	bh=a6Qym+vvVigvz9wSCKdjQVjJh+CINPYOgGV9UfvA0zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkGgH+/gFUU5TYHBw6UarVqS3hLJ+FfNQNagtQ3xvkeZH9KWQC3S+o5XAERRLuxCYU1wZKjX7WK4Z0EE0uFs2jgT8tig3RfPw9kUCieGm5cR9mUKtsVqiyIEqB6CVE6cZE1jNLyiFoaFCLaQApzPG+QFoeZ4cJ7Of5/mR1zH/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh10G45h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB53C32781;
	Fri, 28 Jun 2024 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719578477;
	bh=a6Qym+vvVigvz9wSCKdjQVjJh+CINPYOgGV9UfvA0zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uh10G45hZiThZvzPGOU88G5I/B5W8k633WgvCJVczL9PP/6JcPzGbjhNSXxAihSdr
	 lWeiFIkd6Zk8/3IGCI++D864Rv+/EUptutOKoBEjrnf19EA4FxTo5rmG5t+R3N3rR6
	 6AfhW3xh4PPZi065JQ2tjZbjV76dbkUIJhiczK9OHofuoZ51ZDPd7/aY2IkFHty/ok
	 GjohtU8+yShZ6cAj/rINxeEU7lA80b+H+65m7GsWFHd3bflB9cAbip4mqZsiNNaK3u
	 zcPZ8d0GIbEbmR29cfw6KZhwltc9bAqiaWHjvm2zPnqKeTA/7aQyqXCsTYok3INF+t
	 qlLEQzjc5fbCQ==
Date: Fri, 28 Jun 2024 13:41:14 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next 2/6] ice: Remove reading all recipes before
 adding a new one
Message-ID: <20240628124114.GB783093@kernel.org>
References: <20240618141157.1881093-1-marcin.szycik@linux.intel.com>
 <20240618141157.1881093-3-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618141157.1881093-3-marcin.szycik@linux.intel.com>

On Tue, Jun 18, 2024 at 04:11:53PM +0200, Marcin Szycik wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> The content of the first read recipe is used as a template when adding a
> recipe. It isn't needed - only prune index is directly set from there. Set
> it in the code instead. Also, now there's no need to set rid and lookup
> indexes to 0, as the whole recipe buffer is initialized to 0.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


