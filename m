Return-Path: <netdev+bounces-202098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B32AEC381
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BD53B7CE6
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044D273FD;
	Sat, 28 Jun 2025 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMvHPrgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67912B94;
	Sat, 28 Jun 2025 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751070253; cv=none; b=XjZYOYR6popsjaTRCR27ZbloTO1tVkVCMcQFHphpbXR3e+DX2hX4TgkQw7Z5hrIEJWgZQhXYzIsc7zN6HJWOha+a+lQH2KH7onNfnsiu4MtJZuEni5+XRUQEbPT69WoJ2TVqOh+eXmYt3MJS9DSrgZ1yaoZjpLp3VusCWQoCxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751070253; c=relaxed/simple;
	bh=VyuzBj6v2m9F72db3rkCShuMGfRW3EXVNxMX/RGfKJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rORJfugaCv1ZsfBoaJmi6yjuyA9XXHMxPehBELvOIzx9UkZ8RbUsSYc8U/iTQblN94cT4uavZVha9Cwblb1jP3jYNkqwmE0o5AwB2vHoVvRUuRelkUdLsi8rH2WlnsG1csDqKDRdoCC3E5+XjnF9rAnFN0mi43u5g+XOWuylyms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMvHPrgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E15DC4CEE3;
	Sat, 28 Jun 2025 00:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751070252;
	bh=VyuzBj6v2m9F72db3rkCShuMGfRW3EXVNxMX/RGfKJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMvHPrgIERA7mO83Z9lL6UUFUo+RpSnaY6mKkiOAKmXibnEe6y+OP468vtIDa+aBz
	 nDvIBLyxanzBINc3ws2BfCPJKFeUvmwiLmZfZ8Rnaeb6bV2IanFw7TFWjHwxmivqVU
	 kKShrkeF69DLmFS7kFUwK20ScK7z3pwl8yXmilJSzvlIlKqBJm2pb/jDnILOwP7Jn4
	 eeiJZHrRknWNKXPXRCoJlt350OJF/J64n6IDcyLaff6zK5gWL3/PbIZP6aVvgYsGR+
	 AOHyTSxc5rKhtYSVuqM3AVW0b62/DG6+6UMUIYaRosj7f7nbtkuiziJwW26pbMeCO+
	 Iy0yaGgGrverA==
Date: Fri, 27 Jun 2025 17:24:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, Bhargava
 Chenna Marreddy <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next, v2 10/10] bng_en: Add a network device
Message-ID: <20250627172411.12e36f84@kernel.org>
In-Reply-To: <20250626140844.266456-11-vikas.gupta@broadcom.com>
References: <20250626140844.266456-1-vikas.gupta@broadcom.com>
	<20250626140844.266456-11-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 14:08:19 +0000 Vikas Gupta wrote:
> +static netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +{

you gotta free the packet here

> +	return NETDEV_TX_OK;
> +}
> +
> +static int bnge_open(struct net_device *dev)
> +{
> +	return 0;
> +}
> +
> +static int bnge_close(struct net_device *dev)
> +{
> +	return 0;
> +}

