Return-Path: <netdev+bounces-124410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDD196953F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5A81C20E06
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A021D54F2;
	Tue,  3 Sep 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRHi4SN5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D538F1AB6F9
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348262; cv=none; b=bvWBXJihZgnLWwtqNxClBN3e4sV8+rieBtoPoaSVS+YtT7JwIs/x1km40F2TxTkRpcrP+ESaL4sbkyb1hX9HNVDpUHARiktJJgEzT726dh2vC56+Sln7otRmwDn8rjJ4AE/URPxRpvIVUgqB/p7Fmmf4T8mmZv2H9uVm4/QPM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348262; c=relaxed/simple;
	bh=nZ+27ourZy37TCm6x9iOX3KXuWtANRX4QfrBuxnZY7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3CixRAvgeZi0cctP7wKGyyHYu7g3vgKbus5X+pxCPYdgw6TS4wwhVEgB8g39x0J7CpowqCMe398GWuBL/sdFRaNC9g0vufUIKbmUW8OqCP+nRXlpJ5z8h4fvGU65w4fN7bFsgnZFpIsYo6hEmYLa/SJZ69DAwrnNZRY581dQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRHi4SN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D23C4CEC5;
	Tue,  3 Sep 2024 07:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725348262;
	bh=nZ+27ourZy37TCm6x9iOX3KXuWtANRX4QfrBuxnZY7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRHi4SN59D2hZQTbVASSQu8KqI1jcvfV+hI2He4QDcIRy2kDVvhj0NiBglUiGxluW
	 HtJB3HIsiLvfc/kNrec7NXpL/TFnImnti3LzY1uJlzSp0pbnNB0pncd3EVF1OnWPAY
	 M1fQzOhFCukr1K6KzX91Qj//AH+znzPEKR2gQl79QbawphODsCPI7ahpP57V14MSK5
	 VjHOcbEoXsm+fJ4sOkUe150wqjOAofMqL7LrcMGZMQjIoIvfrmZwLIdNaDGDGbC/f/
	 XonKgyMzEDc5XEAC5GG0J7l/FCnsX/i4UT3zeYic3kR+Q/+O0g7OSvADpbC/xHlsQp
	 JLGNY+5PtznAw==
Date: Tue, 3 Sep 2024 08:24:17 +0100
From: Simon Horman <horms@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com, kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next] l2tp: remove unneeded null check in
 l2tp_v2_session_get_next
Message-ID: <20240903072417.GN23170@kernel.org>
References: <20240902142953.926891-1-jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902142953.926891-1-jchapman@katalix.com>

On Mon, Sep 02, 2024 at 03:29:53PM +0100, James Chapman wrote:
> Sessions in l2tp_v2_session_idr always have a non-null session->tunnel
> pointer since l2tp_session_register sets it before inserting the
> session into the IDR. Therefore the null check on session->tunnel in
> l2tp_v2_session_get_next is redundant and can be removed.
> 
> Fixes: aa92c1cec92b ("l2tp: add tunnel/session get_next helpers")

Hi James,

As this patch doesn't appear to fix a bug I don't think a Fixes tag is
warranted. With that in mind, if you want to cite the above commit you can
just include the following text somewhere in the patch description.

commit aa92c1cec92b ("l2tp: add tunnel/session get_next helpers")

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202408111407.HtON8jqa-lkp@intel.com/
> CC: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: James Chapman <jchapman@katalix.com>
> Signed-off-by: Tom Parkin <tparkin@katalix.com>

And as you posted the patch, it would be slightly more intuitive
if your SoB line came last. But I've seen conflicting advice about
the order of tags within the past weeks.

The above notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

