Return-Path: <netdev+bounces-191983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955DCABE166
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482CF16DB33
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D9B268C55;
	Tue, 20 May 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1gbllJ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35B25C6E7
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760301; cv=none; b=MyOCrJo+8Ys2pI1xhPh+Ev57AWivB4fgjmJSh9YM/3RsqyCdaHt3R6DKVrd5VIJj6+wuRKy0psvwUtiYEReRPzM7/SUqk8owP4QzfXfUJaDQHSMGQMk69LfHo+ARUOmPLqKMrMi6UqnF5hOJIz8d5s4onAyv5x91t0i4OqJPIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760301; c=relaxed/simple;
	bh=6nvRqEXjDwN7HfDkFcTiXExfBwYJVN5gPxFvgZVOz7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvOs5Dtr6n0+9Xt/5/xl4ot49WKYgOWNzC+GfNDDYJNxLV+e7vCQAw2ZtYGDpNxwbb0pzllnvniV+J+ACheat9lySjPY5Nv3fPgOgp4tYopBTgUk0tmUSgxadbEGu4/09GDid3jFQ1kHbkYby2ezdsS8T1GllA7wKAJ/xIYro+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1gbllJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B41C4CEE9;
	Tue, 20 May 2025 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760301;
	bh=6nvRqEXjDwN7HfDkFcTiXExfBwYJVN5gPxFvgZVOz7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1gbllJ6qvTNXBTKzL4rpcZPfN/pfEHL8/0JaBT7+gCvrk1YYGh7ySSS0HgMuHfnQ
	 EwZR+mHMrwq9xxISihkb26CnAEtiPCFI2ZCeXqWbwhKrj6eocj1xKfiUxKhGphq5w0
	 35NEoNTcLTxQ3rBc3R2kd2fmkO4PhfTvGeBN8KOjKk3vUi16ndS9wnNuqVBGLNBjiI
	 JGwjdxJt5PBq8fR9aYP5ztPq1Gfz8E7oeYCIRwDEzugJRtK3sC0Af9OGOg7VeXVCah
	 ayKxXKw+O7/eh0+MXqFvXvz8YvUPgUzXkKmzdB+/RR+Fm4Zghfbh39FDTaJjcvB5RK
	 yQ3tJuP+4iOWQ==
Date: Tue, 20 May 2025 17:58:17 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
	linux@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 8/9] net: txgbe: Implement PTP for AML devices
Message-ID: <20250520165817.GN365796@horms.kernel.org>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
 <41FE252AE684333A+20250516093220.6044-9-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FE252AE684333A+20250516093220.6044-9-jiawenwu@trustnetic.com>

On Fri, May 16, 2025 at 05:32:19PM +0800, Jiawen Wu wrote:
> Support PTP clock and 1PPS output signal for AML devices.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


