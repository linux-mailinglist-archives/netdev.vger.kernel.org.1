Return-Path: <netdev+bounces-73290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF785BC76
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451DA1C22294
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7D69968;
	Tue, 20 Feb 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqQP7EBg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486467A04;
	Tue, 20 Feb 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433086; cv=none; b=pzhM7ErUi5vAo5dfoP/PWmIKgkC1IiDcxR3lZ7MV+7Emw9TpbGSIYzHIHN373/CRCBIPLxQu/qy0S6nISo72ccpWRLIXTS8TaGxKbe621i8r3ISvpYY7NYTyFKazKiWeObGNntWUy1H0RnNcboppNfOtl1mlcDjepqpebN/V5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433086; c=relaxed/simple;
	bh=Jayoe0AEApGo847AZul/y9I3ziKqFlXjmJFfOUTdMv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEqgfULGkODozsToDvgavAvzEyDAKFFc0T2IXMMcn1OLdE04B7laBHdJxdkD5EZ+DNuK33pxLFKIRNmSBm+BO+geq7ArUYIvsT6CE+54pNFfulYC6awjLDuLdBk4PGaCgl5GjmkcGt/6Y/TaXNvNXnDoUcEi7F6Q3vdglDb9/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqQP7EBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F770C433C7;
	Tue, 20 Feb 2024 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708433085;
	bh=Jayoe0AEApGo847AZul/y9I3ziKqFlXjmJFfOUTdMv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqQP7EBgV6H8v9YurUso45Yc8KtCWTMmrEjp0Vrsnxf98zXnt2jAEHP8I+I2mo6iN
	 wvC9UnecRCL313A3heSPu1tJuZtmGSWP8KTSWEp0IEdchtojs8yo7wpEZCbhe9sHy8
	 wwdOpAc9VQoqLqyai8Ahjc1h1JSSYyJNPlkqeU9AAvNDehZhwcKHUZqZMHqxvqBmAi
	 8hEcSN8n9sbhS0+DV+6XHMrhnsMYheFasYh7AoKRfAWK2mdx7IOF2JERkCI4Kpb673
	 0fJLq35yu8D/Cth7ihOqFi8ksz8GZ5kX2U9963QFXQX0lkRwhypGMV2mKKTfz3waHs
	 6UcTxAIUnK3zg==
Date: Tue, 20 Feb 2024 12:44:41 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 6/9] net: intel: e1000e: Use linkmode helpers
 for EEE
Message-ID: <20240220124441.GC40273@kernel.org>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-6-71f13b7c3e60@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-keee-u32-cleanup-v4-6-71f13b7c3e60@lunn.ch>

On Sun, Feb 18, 2024 at 11:07:03AM -0600, Andrew Lunn wrote:
> Make use of the existing linkmode helpers for converting PHY EEE
> register values into links modes, now that ethtool_keee uses link
> modes, rather than u32 values.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <horms@kernel.org>


