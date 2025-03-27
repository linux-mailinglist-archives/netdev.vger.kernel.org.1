Return-Path: <netdev+bounces-177999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D99A73E6A
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 20:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7C51789A6
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE85015533F;
	Thu, 27 Mar 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbFjXmKY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A4C2FB2
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102724; cv=none; b=UY1lA0E1lkgiOyQNHbDeVc9s7bIsmCu+KSgu6VeCSMVPDWmp4U8d+P4VkF5KOp8ccgCLukOXlsNHHxhd3AALpaLY/yKF14qDGOmt/zo1YN9ZSzclzgzlWcCO1g7Qs+n3daHstv0UfV4kC3dBEwOxNvzXrdDfFChu9dRSg7MvLW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102724; c=relaxed/simple;
	bh=tIqzniDmCeq1Ulih25OAx6nH4yi7/Ws3rBZYRFzgg3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ed6iLi4yZzXe3Gt/HqQzAivu1LUCAxPsTFL09lvO0gsjxFAC7CP6IJ5ij+3zkq8GPZA7VeDiVHmv0X1rztBXUJYdbjnrPc+PrFtBIzejzfruihPHo0z9SiODezfONKEIcvo0pJ80/S7eEwzcHjJrWp3t+X5xoHETrmQb5efdIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbFjXmKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3A3C4CEE5;
	Thu, 27 Mar 2025 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743102724;
	bh=tIqzniDmCeq1Ulih25OAx6nH4yi7/Ws3rBZYRFzgg3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sbFjXmKYqZVGpCMwjaAcowj2g8f7hr9JKsZvM+KeoZS/tNks4c/ujzitocR1YrO9k
	 z45OcNVNOf48qhrRzP024RxU1yLPWObzrGUaLc7A4J5953tM8YaPIbL426X66ObNxl
	 0kBmd4KmQQeDOgkT6igy/+5vNHRSISLvchLVu0JKj+b21UHaLAzJ1YJP/GKI3cVlbw
	 UwWrI0OjUuaj+mxSfVmbsSpGjSLiYY20CXugRKIOG2PRhyGoKNB7APbBaoJS2J5N15
	 MzDdIHHK0xCxmWvh93I7UFSIEnixG6OZ7UmjRuLFFW/Q5TV1tNwdkvP2jdTWsGH9ui
	 okjEb7VLAH8IQ==
Date: Thu, 27 Mar 2025 12:12:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net v2 06/11] netdevsim: add dummy device notifiers
Message-ID: <20250327121203.69eb78d0@kernel.org>
In-Reply-To: <20250327135659.2057487-7-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-7-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 06:56:54 -0700 Stanislav Fomichev wrote:
> In order to exercise and verify notifiers' locking assumptions,
> register dummy notifiers and assert that netdev is ops locked
> for REGISTER/UNREGISTER/UP.

> +static int nsim_net_event(struct notifier_block *this, unsigned long event,
> +			  void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +
> +	switch (event) {
> +	case NETDEV_REGISTER:
> +	case NETDEV_UNREGISTER:
> +	case NETDEV_UP:
> +		netdev_ops_assert_locked(dev);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}

Can we register empty notifiers in nsim (just to make sure it has 
a callback) but do the validation in rtnl_net_debug.c
I guess we'd need to transform rtnl_net_debug.c a little,
make it less rtnl specific, compile under DEBUG_NET and ifdef
out the small rtnl parts?

That way we'll have coverage without netdevsim loaded which would 
be all HW testing.

