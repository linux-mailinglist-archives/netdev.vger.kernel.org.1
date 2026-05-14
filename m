Return-Path: <netdev+bounces-287936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MnFCPSyBWqeZwIAu9opvQ
	(envelope-from <netdev+bounces-287936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:33:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EEE5410EB
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E65630254D1
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D363A7588;
	Thu, 14 May 2026 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ9WxG//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54FB368D67
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758384; cv=none; b=aFDlFtfJ6IPOamqnf44ftE30YQUgYWUWpDrmG5dMy+rxN5cUsdU7CBj8tm6qkFPzDzOKqmH7aYUnZim4bVA1+e0wizjkOynDRwDrRCiNd9shqOxt9g9WEJX9wM1y57/MG6x1mHHwF6OmGS7gjRul3wglD5Ra1/bKuzZj3mF8NIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758384; c=relaxed/simple;
	bh=bhaZ8fijgpxpOxD/qtp5p7oENJE3emvbuPvo4yZJSLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFy4fQKezLiBbk36IP8i8jpbxqd7SGtTCWEPZ3Hl98jSITiioDNSrL3SJjURL8g4NAsEnzN+57jZxaPKZJTkRgL+XLLnLBonV6r+8I4glNuBfae0yZS3Dejhf7a8Xkq6rf+558tHuBzl/ylWmUoli826g5HkeEM/Xi6xV2Nf5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ9WxG//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55400C2BCB3;
	Thu, 14 May 2026 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778758383;
	bh=bhaZ8fijgpxpOxD/qtp5p7oENJE3emvbuPvo4yZJSLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZ9WxG//iDWN/mAHeSRB7BsKoBmPjRAWXdWABglrMNKA2PUWvC9BRgVxJKcGW+As+
	 C4cfKgyFd33AHlaCEpm5b8fu3ydwuCavx1xcnVhw4dEgQAzwgbKbH8bjlyS70f7HYZ
	 nuLawvJzt9fp2yzbbLTfIkK9Ik9DG+fNpxBvVoL1wtgVkQ9RAfwXdd2e9ByVUA0BnJ
	 jfnrwsr7Euy9jVxWQ84AgQ2vy7s4M/Qw+WfScgUD6L4gPZ+SEFZQKpR8ZEkr1m/yTj
	 bUlV5hCGbRNnQ9ZGgREiO/jhj09WupzkwMHFVWzoYtWB5RmRE8+gEsjcLQs4s/ON8d
	 61oXj2EieeA3A==
Date: Thu, 14 May 2026 14:32:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Will Mortensen <will@extrahop.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, netdev <netdev@vger.kernel.org>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeremy Royal <jeremyr@extrahop.com>
Subject: Re: [PATCH v2] net/mlx5: don't printk garbage when transceiver
 overheats
Message-ID: <20260514113257.GO15586@unreal>
References: <20260512-b4-mlx5-sensor-fix-v2-1-531fee4fd7fd@extrahop.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-b4-mlx5-sensor-fix-v2-1-531fee4fd7fd@extrahop.com>
X-Rspamd-Queue-Id: 59EEE5410EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287936-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 12:32:38AM -0700, Will Mortensen wrote:
> When the mlx5 driver processes a temperature warning event, in events.c
> and hwmon.c, temp_warn() calls print_sensor_names_in_bit_set(), which
> calls hwmon_get_sensor_name() to get the NUL-terminated name of the
> relevant sensor, and then prints it to dmesg. In particular,
> print_sensor_names_in_bit_set() passes the bit index ("sensor index")
> within the 128-bit vector in the warning event to
> hwmon_get_sensor_name(). But hwmon_get_sensor_name() was expecting the
> index of the hwmon channel, and the driver registers hwmon channels for
> at most only two sensors: the ASIC sensor (sensor index 0) and the
> module sensor (sensor index 64 or 65 if we're on a 2-port NIC). So when
> the warning event concerned a module, hwmon_get_sensor_name() took the
> 64th or 65th element of the likely 2-element temp_channel_desc array and
> thus returned a pointer to some other kernel memory past the end of it,
> which was printed to dmesg up to the first NUL byte.
> 
> A further difficulty is that, at least in testing on our CX-8 C8240 with
> firmware 40.47.1088, the warning event can have bits set for other
> modules, e.g. if this PCI physical function is associated with
> port/module 0, we might expect bit 64 to be set, but bit 65 (for port/
> module 1) can also be set.
> 
> Fix this by clarifying that the argument to hwmon_get_sensor_name() is
> the raw sensor index, and correctly converting it to the hwmon channel
> index. Return NULL if the sensor index doesn't correspond to a hwmon
> channel (e.g. because it's for the other port's module).
> 
> Fixes: 46fd50cfcc12 ("net/mlx5: Add sensor name to temperature event message")
> Signed-off-by: Will Mortensen <will@extrahop.com>

Your Signed-off-by needs to be last.

> Reviewed-by: Jeremy Royal <jeremyr@extrahop.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/events.c |  2 ++
>  drivers/net/ethernet/mellanox/mlx5/core/hwmon.c  | 15 ++++++++++++++-
>  drivers/net/ethernet/mellanox/mlx5/core/hwmon.h  |  2 +-
>  3 files changed, 17 insertions(+), 2 deletions(-)

I would take a simpler approach by removing this extra complexity and  
using a static temp_channel_desc[64] array, avoiding any dynamic  
allocation. But this change is acceptable as well.

Thanks

