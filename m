Return-Path: <netdev+bounces-227217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8797BAA655
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 20:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F7192062E
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A2221F39;
	Mon, 29 Sep 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8+JzZAH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED344273F9
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172373; cv=none; b=O1aug7OQfspH30X8d4HpjJHkffyWZGZyOgSxt8aCMNHu2ukiVXRown+3LJgVz5aAjYL/WvKeFae8N9UFFHgUJpjZXEMQji/1Z+kY8lSABkka/z05qDTv0cHWvqq0p4v3mmKbV/QFj1EknKW0Wl1JSdRz9AF0Rrs6vtGgcL/lGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172373; c=relaxed/simple;
	bh=Ik7paXHQoL8nXJ243MBED5YSnAKgJqIx9caZBVg4mwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h366mLHUEmiNrnm1kbQKPqgY/51NvYlU50Hpjg9rY1xXxqNsKgyJqC1EhJVi+iXw7OkYTvPD0L5GuW4K4ez6xDOqnixtORBZ43CoKCf8BpppHpT2iULRVvtO33TbOqKaWN6WI9zlC2zO645SyJzTvypbS868cPgd9WMtLICHD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8+JzZAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E91AC4CEF4;
	Mon, 29 Sep 2025 18:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759172372;
	bh=Ik7paXHQoL8nXJ243MBED5YSnAKgJqIx9caZBVg4mwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B8+JzZAH+FQG2ZexkE1rR0q2qe4EeUW7/mUQqbkQQIE19q7bUVNsLzbe3NQ/Iaf0Q
	 v8DgvBVZFR81kIqyt4C80b+kJuJpxYogab88zaAYQ89VF4nd8qKiiWYssYq5m/brV6
	 vgnIvcL60ne2Ax/KWJIVy3c5CUQzOs0y2+KeBSGfoQNNh0DRUcwicpqPvwTrGEHNtT
	 zmnkRIe9UrQ9NxZtTtLMlWnYBhzDficlN6pJvn0/pf6GhRJZVG5bZYYSyLO3ulyJFu
	 RGOISBqLvBlBVsKP6dtdximXEw8e1HA3huznoXl86IMSg5tFth6MTGr6AvOYzhaUOr
	 aGX77MMhK/Y7A==
Date: Mon, 29 Sep 2025 11:59:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next] ixgbe: fix typos and docstring inconsistencies
Message-ID: <20250929115931.1d01a48b@kernel.org>
In-Reply-To: <20250929124427.79219-1-alok.a.tiwari@oracle.com>
References: <20250929124427.79219-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 05:44:01 -0700 Alok Tiwari wrote:
> Corrected function and variable name typos in comments and docstrings:
>  ixgbe_write_ee_hostif_X550 -> ixgbe_write_ee_hostif_data_X550
>  ixgbe_get_lcd_x550em -> ixgbe_get_lcd_t_x550em
>  "Determime" -> "Determine"
>  "point to hardware structure" -> "pointer to hardware structure"
>  "To turn on the LED" -> "To turn off the LED"

Hi Jake, looks trivial. Ack for us to take it directly to net-next now?

