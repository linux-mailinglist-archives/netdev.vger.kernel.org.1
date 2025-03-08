Return-Path: <netdev+bounces-173186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA34EA57C40
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 18:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992523A96F8
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ABB1D5ADA;
	Sat,  8 Mar 2025 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHpWMo/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE7839F4
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741453923; cv=none; b=OMiZax2/mGBZy1604stZiLNnzGFGrUl5SZSw+JywrEwt4EFLd4WXc0BYvMNsjFGcIRJs/XoM6wvcHhS/F3y3gbzuSJBviQkIo49iPd46wDAzom22xtMkV2mDbC3yOYs20BgBgXFJHmpGqoMIUMdLcvdNDIaZMhug1NymFmxUn3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741453923; c=relaxed/simple;
	bh=W564L2XexdGdC18I7XU/Yh64zFrc7i1Eg5pR4Y+MhEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amknO+Uv+xI94QQ/6Tfg8wb47yZ/T+3kP4rbhxo3i04NLzuM1Q8E8G2K0SHAAH7SHcANq/qFi8mDKKG044WyGzuGwrn8MzszldkDVEKLVeqlmmijdHsOOfQfBp/hU6lpNS8WF3MhyXWCvW0X+mHiSSiXzcV+hvUliWcSXR4yRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHpWMo/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5F7C4CEE0;
	Sat,  8 Mar 2025 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741453922;
	bh=W564L2XexdGdC18I7XU/Yh64zFrc7i1Eg5pR4Y+MhEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FHpWMo/icNSPsxo3Gnadxf7rk9kHTmNwLWUgA6yuDfLxVmbjUfncW5SD40m+VWxR4
	 FssG5tG454h8vpQGTHtcA1HDGLCTGP3tpi7RSmv4HCINnl717ibAiQFNSo3mfq3T1E
	 IjWyMSb2JC35JRxnLftNeVlGbI4Xwy7vQw4X3XBpqaTxYfsyhGL9HtZlS8nu6FqGb8
	 aq+n00OJGpn6JkGfboVn+VgL1fYfgIthpRSFvUgVRuHkGqTnItZO6RiZ0/idzAS6Zu
	 KqEKyKR8LXY7Q+UhqO1zI0q+NO48c7Q8mNQqaWCSLpwSHEapAZjzO6gCzWcjMD2B33
	 vj155KNEAyRxg==
Date: Sat, 8 Mar 2025 09:12:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH net-next] net: move misc netdev_lock flavors to a
 separate header
Message-ID: <20250308091200.58af6d70@kernel.org>
In-Reply-To: <Z8u6laRzRAoxyXH_@mini-arch>
References: <20250307183006.2312761-1-kuba@kernel.org>
	<Z8u6laRzRAoxyXH_@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 19:33:41 -0800 Stanislav Fomichev wrote:
> On 03/07, Jakub Kicinski wrote:
> > Move the more esoteric helpers for netdev instance lock to
> > a dedicated header. This avoids growing netdevice.h to infinity
> > and makes rebuilding the kernel much faster (after touching
> > the header with the helpers).
> > 
> > The main netdev_lock() / netdev_unlock() functions are used
> > in static inlines in netdevice.h and will probably be used
> > most commonly, so keep them in netdevice.h.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Applied (with an addition for Eric's fix).
-- 
pw-bot: accept

