Return-Path: <netdev+bounces-133554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA499638D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DB02821B7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7D18B47E;
	Wed,  9 Oct 2024 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWNFSIAN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6912C18B465;
	Wed,  9 Oct 2024 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463289; cv=none; b=kzcvGXOIYxxfWqjpd5Ny10U3YNq7gi+/1YSImMrYAoaqwOiZIONFRHzaopva53lXLA5WzPZNAX101kuWk7kU6mbzVLiqY+QpeVGEJQZD2N3rASU4triBQzWa0AiolDmh9PYHcVrPIUaUYIV6+G3P0lComzEacxR+SJdICFbhmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463289; c=relaxed/simple;
	bh=+M0hTljpFJhCSug/HvxVU/vMs8xMiOATiEGTFmWW7Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/9XVzcteGtBOza1ZMDsvx9EKkX6v4sVTh2QvA8ENG3aI665y3vOaTJEhI12+q373epDyBmamGNtMvGA1bU6YN2FllqXtlZmvslTemdlbLPRZORdnu48+YDpCh15/rBo2lIAoBnrJsKZ3WCQos967H9ABcAyxP/XnIWfpx1SiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWNFSIAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F85C4CEC5;
	Wed,  9 Oct 2024 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728463289;
	bh=+M0hTljpFJhCSug/HvxVU/vMs8xMiOATiEGTFmWW7Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWNFSIANSpYCFOrIa/lcaOf0qJrFD0TuRH94M3Dk4EUt4qFIU2e2MmFHlILnCDRQ2
	 HzjxPj5/YaRNgZC9X7BNuy9+VZAKcPQBhJIcBPfVVO95NUPBCQCN48vims1AzDRJO2
	 PiP5AzMTXP/1//fjIALglyVOtmrCpZ03ceEdnJJa/rj02UGBwlKV9XaMohLOWoULmZ
	 ydwm1C3LvbqncVaGNiBmdgVXJXY69RM2e59h5p/PYwAqkf68uHWsDmXsgiOFwSmBe5
	 llsuCVrgTqrYac0Zh1CKNlTvyAnVPaMlkgFPSiYArO8HT7i/SBtwEeAv1P2S9e3Ide
	 GaMhk+Tp2N6EA==
Date: Wed, 9 Oct 2024 09:41:24 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH net-next v2] r8169: add support for the temperature
 sensor being available from RTL8125B
Message-ID: <20241009084124.GG99782@kernel.org>
References: <f1658894-4c46-447a-80e6-153c8b788d71@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1658894-4c46-447a-80e6-153c8b788d71@gmail.com>

On Mon, Oct 07, 2024 at 08:34:12PM +0200, Heiner Kallweit wrote:
> This adds support for the temperature sensor being available from
> RTL8125B. Register information was taken from r8125 vendor driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - don't omit identifiers in definition of r8169_hwmon_is_visible()

Reviewed-by: Simon Horman <horms@kernel.org>


