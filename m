Return-Path: <netdev+bounces-124638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B747196A496
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7430B284029
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3475018C33F;
	Tue,  3 Sep 2024 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p70lXE8f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DD18C337
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381354; cv=none; b=ApLX5mo5vtFGfppSqkJ/ZgERTzuo28vaxUVasPkZU0zdv2UptyGkCTw48YENx5ReruD35j0MAK31k6SbvYOxQOrv7cfdUjNz6TAYCXBwB6XdmIEhyzudS9ODjsB/6kL/k9YLEUnoCxxbBzlwybu6v8Dg2Ucl6C69M6xsD5/aJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381354; c=relaxed/simple;
	bh=ftFfTxbkCKTPy2pkqdUT9C1H222PV8FiKBOqH3DbDW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG3XJUfSOgLa9VdEJngbOxB7CZOGYnmHTzPswr71qnG/+kQlNjU6+Z2SYNHDL/G2FVSWCtbSkslNxjIXdRhFQWc1zW+Rmqhx1OnuXlt5nlpwx2IQzMlQYONxbKUmb8wyg52LzPKjfNeSYam+5lserLjRc92PW4YQnWm8FHyOjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p70lXE8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F229C4CEC4;
	Tue,  3 Sep 2024 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381353;
	bh=ftFfTxbkCKTPy2pkqdUT9C1H222PV8FiKBOqH3DbDW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p70lXE8foYkXzI9EqkXX2hIqg0Lvrtj0uMZZ9dF7/ta39G8mlx+XB2ljEjZ1/fZxn
	 qNaEmuTZAXeBFEHQ8f9N7ypNWbE5OHQaR4IS+xNLyePO0PIvBuHRGzfcul4Heb5x4E
	 E+mKi2Km+jYErWePUfc48L0kl9oVDmxwiChdCi6h6UYV58DvS9/wTnOO9ntxtYdOox
	 lkwdbpykWU22UsvKoxLgCWOQk1qlEHyGHP9K2GE/sbGyXt3V8eBpSwkTq+CQRew0vg
	 T7sI8bNgoA+xJlEHYGT7vLrGaxfj6d8wcz5/ZyyPJexQb3A1ekmKHZyZj0TAB1GjQj
	 E9oB++G2W3g6w==
Date: Tue, 3 Sep 2024 17:35:49 +0100
From: Simon Horman <horms@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tom Parkin <tparkin@katalix.com>
Subject: Re: [PATCH net-next v2] l2tp: remove unneeded null check in
 l2tp_v2_session_get_next
Message-ID: <20240903163549.GF4792@kernel.org>
References: <20240903113547.1261048-1-jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903113547.1261048-1-jchapman@katalix.com>

On Tue, Sep 03, 2024 at 12:35:47PM +0100, James Chapman wrote:
> Commit aa92c1cec92b ("l2tp: add tunnel/session get_next helpers") uses
> idr_get_next APIs to iterate over l2tp session IDR lists.  Sessions in
> l2tp_v2_session_idr always have a non-null session->tunnel pointer
> since l2tp_session_register sets it before inserting the session into
> the IDR. Therefore the null check on session->tunnel in
> l2tp_v2_session_get_next is redundant and can be removed. Removing the
> check avoids a warning from lkp.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202408111407.HtON8jqa-lkp@intel.com/
> CC: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: James Chapman <jchapman@katalix.com>
> Acked-by: Tom Parkin <tparkin@katalix.com>
> ---
> 
>  v2: improve commit log and use acked-by tag
>  v1: https://lore.kernel.org/netdev/20240902142953.926891-1-jchapman@katalix.com/
> 

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


