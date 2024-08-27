Return-Path: <netdev+bounces-122497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA81961851
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC2E1F23EA7
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E961C57AB;
	Tue, 27 Aug 2024 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9aGPYDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1432E2EAE6
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724789181; cv=none; b=rrBBaBbuR3ntca1xt82Hokyos2ZAh+0tExNQvaHqEu8/HDtZN2n4O0hNF/X4Cp/SPElOiGg/ww5lL6o+W5x8oPIEepsGgXej4cP/LQIchnNVFEkJeNl5gxD1Nj7XTNMubZZ3kPAgCmWRXgG9/KrcigECPirScjcBN54iAqVCAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724789181; c=relaxed/simple;
	bh=Pax8EwozMqqgorRSpulZH/Zb77RNUp9Zf9aKNCa5XIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu7JdqSv1t9WjiOaOj7qNHaeliEBJofybs2pnIQG8FVsKHoARpjqQUYOMiTB/pbE4WFpcX0Vqi2+b+HMVihk9AOaEhDmYzKZKSi3NatxkUFcXve0m/lhxqDgBzz5nrTya6vmGw/QY6IiEtNyFceTz5YOGIM1IWo8XgB5uq85nTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9aGPYDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07536C567D8;
	Tue, 27 Aug 2024 20:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724789180;
	bh=Pax8EwozMqqgorRSpulZH/Zb77RNUp9Zf9aKNCa5XIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C9aGPYDWYlkFHFw1Chzx+3tAO/3dT9GyobW6RVWq9m9JtRwt6VHCfOK42kEyrtZfT
	 1DVbAutbYuqVrNYA4+ghLPQZIktgt1TuD8LEru6kEg+Hdh7F0OjCDfRq/EMMl8O6R6
	 WVPRtG3ibnSofxRlwddZ4T0QR9R5+hSXopGTP6qa1AyM5d6eQBIky/jqu7UYeVGqyQ
	 XeAZz9idmI6El8AOLfcr+4E9C3o2mWA24vxDwFZ34EnbHdqUnrWpnI2H/lCoRUY/P6
	 gFimbESGRkH256h9xdx5m+9kfkIXfs9qMU9xiKIyvikcYgsF3pmKCLA+rpJLVTkCTT
	 tKn/8l4hfBQDA==
Date: Tue, 27 Aug 2024 13:06:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Sabrina
 Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, Steffen
 Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCHv4 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <20240827130619.1a1cd34f@kernel.org>
In-Reply-To: <20240821105003.547460-2-liuhangbin@gmail.com>
References: <20240821105003.547460-1-liuhangbin@gmail.com>
	<20240821105003.547460-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 18:50:01 +0800 Hangbin Liu wrote:
> +/**
> + * bond_ipsec_dev - return the device for ipsec offload, or NULL if not exist
> + *                  caller must hold rcu_read_lock.
> + * @xs: pointer to transformer state struct
> + **/

in addition to the feedback on v3, nit: document the return value in
kdoc for non-void functions

