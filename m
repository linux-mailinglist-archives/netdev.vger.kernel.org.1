Return-Path: <netdev+bounces-156660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EBDA07465
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EF8188B15D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A05215180;
	Thu,  9 Jan 2025 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f359Yxu8"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B9202C43
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421367; cv=none; b=aeQOEipbb+N5CXwg20XDbU3ZJabiFTytSjWgIU+w7mMo4oNTIjYXEjyGvkTVsCb+UoDG9npvId5YT4rSVI/HoMYmkaf9xvlrvhRxFX0H7/q2MepAWxvznVcSESEFCQF7apVol68xPi1hL/eQHoXOubh5Qw+jOpC4EERnWvci8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421367; c=relaxed/simple;
	bh=Q/yof+wLCrXgJOospYNz6DftLgTDGKgDPummcPIhOSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1ZoPKAlhnfGKP9kwxTSXRJ2OrRrz6MrM4Z40Qv2G0VYbzY1YGMVjcqUBMMwHO/mYh0OBNBZazHtG4XgOHF1i5fzXggtyf931mjLszAQCV6oYwd6Q48FD7Na4xUyiRb1scz05bSGMcuLNzgUzMtJj7iBMh+05WugrsVO35nAU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f359Yxu8; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 789CBE0004;
	Thu,  9 Jan 2025 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736421363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/yof+wLCrXgJOospYNz6DftLgTDGKgDPummcPIhOSE=;
	b=f359Yxu8Xj/QeMp3V4YGsE/RMy3amyhWOJU+KqwmHgq30XPg+rDdfY9lVlJCVmIFfw48Kx
	/AXky3Ptg87MzmN6wWHyVQ+YkOHZX61He9sWXAsvmaLnbW693Vt+hIVLvroYs5gRkmWp0h
	AsLwoKxiPsay57MW05qS1VeAA2EntMq3XK0WsY1iTrDwnLQ764GQnu7b65+UnI1C6hlg77
	6AZFuH9wvQyl/avmeD8NmHylLYB84K6lxGbHjUmY6gspcA94mPskGb/IGM9pOjhXxk+h86
	j0K2j+vgzQxCryEhUkvwHeBZqraAh5xQBFirt1UAtQh9cmXPNkOS6x5k4HbGDA==
Date: Thu, 9 Jan 2025 12:16:01 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: lirongqing <lirongqing@baidu.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <willemb@google.com>,
 <aleksander.lobakin@intel.com>, <hkallweit1@gmail.com>,
 <ecree.xilinx@gmail.com>, <daniel.zahka@gmail.com>,
 <almasrymina@google.com>, <gal@nvidia.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH][net-next][v2] net: ethtool: Use hwprov under
 rcu_read_lock
Message-ID: <20250109121601.7afc4f12@kmaincent-XPS-13-7390>
In-Reply-To: <20250109111057.4746-1-lirongqing@baidu.com>
References: <20250109111057.4746-1-lirongqing@baidu.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 9 Jan 2025 19:10:57 +0800
lirongqing <lirongqing@baidu.com> wrote:

> From: Li RongQing <lirongqing@baidu.com>
>=20
> hwprov should be protected by rcu_read_lock to prevent possible UAF

Thanks for spotting it!

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

