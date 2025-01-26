Return-Path: <netdev+bounces-161031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BE1A1CC9B
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 17:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C727A1ADA
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C2278F32;
	Sun, 26 Jan 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yTQUiDjw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5E25A655;
	Sun, 26 Jan 2025 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737908479; cv=none; b=ugksldrdkvPvaI+8eWPb/3zyrPLfzNUA8D0oGCXiacICgWn6GT1dRWe39qft5U9gTx7BzRq/Z4mB2qknIm0+mELabSn5fuoaQJeO+5rL0DMfgS6//cqV8uWQ6woQk/utDznOEE9XH3rHoSSQhkr8rCXV/ReyP+oKTzpqL3e55bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737908479; c=relaxed/simple;
	bh=2i3FB8VnZYbuLqOZNMbD8+iMXuwO0s4gIQlMIxsMykE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPtDyJlFv1pNbUFFEa6qrUFzZtBIDtt7k/BHJ6A8wNuf5VuHO+vKLaXK1/cbGXNy4Df3o+3xJJF3CvbdIGAx9cQzY16rZL5sji6VqrnoXSmvan64DgUNgGd63j2NZNPrbGGNAjuKdvVZT/JnwNgypzTDjMw2sbdqYtMecN9aVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yTQUiDjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B84CC4CED3;
	Sun, 26 Jan 2025 16:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737908478;
	bh=2i3FB8VnZYbuLqOZNMbD8+iMXuwO0s4gIQlMIxsMykE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yTQUiDjw+X8J/z+b4Uj9ijpfDSq7g/fArxKDx4SExp04vNHQbj5UMvIW0utCV1pt8
	 qWMy8CqNpBAmewQL9ccrMtnw1t7yPmZqUaH8ibyYj0oP6+w3Sv9OB8f+hkdwcAUtqN
	 bF3L0bGcDka0mDHEQPTKLWvL0yklbikuKGOYUmBM=
Date: Sun, 26 Jan 2025 17:20:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Max Schulze <max.schulze@online.de>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	andrew+netdev@lunn.ch, s.kreiensen@lyconsys.com,
	dhollis@davehollis.com
Subject: Re: [PATCH v2] net: usb: asix: add FiberGecko DeviceID
Message-ID: <2025012646-unleaded-laboring-d81a@gregkh>
References: <20250126114203.12940-1-max.schulze@online.de>
 <20250126121227.14781-1-max.schulze@online.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126121227.14781-1-max.schulze@online.de>

On Sun, Jan 26, 2025 at 01:12:19PM +0100, Max Schulze wrote:
> Signed-off-by: Max Schulze <max.schulze@online.de>
> Tested-by: Max Schulze <max.schulze@online.de>
> Suggested-by: David Hollis <dhollis@davehollis.com>
> Reported-by: Sven Kreiensen <s.kreiensen@lyconsys.com>
> 

For obvious reasons I can't take patches without any changelog messages,
but maybe other subsystems have more relaxed rules :(

thanks,

greg k-h

