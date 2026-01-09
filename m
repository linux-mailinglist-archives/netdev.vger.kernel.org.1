Return-Path: <netdev+bounces-248575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3297D0BCA5
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 927443009FBC
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2302B35B139;
	Fri,  9 Jan 2026 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5pJmPll"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E04500955
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981887; cv=none; b=kemyQnIWZSExZrK+YH1sUm5VQ+ZPgYyF3vvQ9TlncP+/3yPy80x/RIbbsTnyoiRjCYtKKdaDeDnHda7FXLN+aaT2S7xvIKksPyaC0XmseMoMcQ4ha8ryPO0xy0wiu4i9v//EOnLCub+vYgjMGX4IwnQ0KOOOuwZ6nESzSi1kgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981887; c=relaxed/simple;
	bh=rJRp1WHwb+AnTUMohLHAPXLUtoIPbXgArs01fEXai0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECqYnjbVh0g+tpjaLKVNYm+yZnsIJDLe96Yws8zp+ELmQZ4efB3NjUkNbvJ7xxXNQnvHioyknOD1SxnUd6F9BOjDwJ0qDB0Gs/4XhzE2yHOizkyD7R16USpGZyFWT/Btv2gA+rwOrqmZY9RMRYhYbJCVe/MFcqIBLy8ktIRWDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5pJmPll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06893C4CEF1;
	Fri,  9 Jan 2026 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767981886;
	bh=rJRp1WHwb+AnTUMohLHAPXLUtoIPbXgArs01fEXai0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5pJmPlllp0TrssaEWj1esykAqzk5+i97SFO/iCpsYG5linidGzPcd5L+5nxxl5l0
	 nVBtcTTjqFczQVgeVBs3IWP0q2CvZDTDNabgzeFDQFQQmZTdMN8z2T+YarBXKBrT+/
	 c0lmexjGoKbFAsSqCvbeo0E9JWbMtNKF21uctX250Rk96byO3RGteisq5bMIaw+1zD
	 WAGy37hEvfHDFztJmD4szmpqU3yRCZqGV7MDhEjBE2Ke2N5ku7oN8t6quHmkw7/aOS
	 oOJZc0kHGEy2fWSZ59XCIJWgi/Tl5rbeKWVzlHHQKg/isPb98T1MVBzzYh92bQesAt
	 JXLT4/v0x6/3g==
Date: Fri, 9 Jan 2026 18:04:43 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] pcnet32: remove VLB support
Message-ID: <20260109180443.GO345651@kernel.org>
References: <20260107071831.32895-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107071831.32895-1-enelsonmoore@gmail.com>

On Tue, Jan 06, 2026 at 11:18:31PM -0800, Ethan Nelson-Moore wrote:
> This allows the code managing device instances to be simplified
> significantly. The VLB bus is very obsolete and last appeared on
> P5 Pentium-era hardware. Support for it has been removed from
> other drivers, and it is highly unlikely anyone is using it with
> modern Linux kernels.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Hi Ethan,

I don't think this driver has received much attention for some time.
So, unless you have hardware to test changes on, I would suggest
either leaving it alone or, if we suspect there are no users,
removing it.

...

