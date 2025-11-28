Return-Path: <netdev+bounces-242469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C70CC90971
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45B53342BF9
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EA61E3DDE;
	Fri, 28 Nov 2025 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjMCBhTR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA061D9346
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295889; cv=none; b=B98nZFFLY4xXSZFXk7DKKz5pfjXR0FyObRrJT/aGME9eqn5Wwfg726bFv01alnMSaRmpHj/Ue6afyFXYqAIre1R3A6lV9Qr/q82zzo9D2J9Zu2EwmgHuRg1jhnFrcwA80GXVAwzbG0fG0bMLmto+J9NYy7uXmU1CGVN7D4qdYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295889; c=relaxed/simple;
	bh=TkmPFlH4dLbLupR99jE6HJGld/tA3KOdzlC3Zw+aUVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=di16vp9eBQrQ7DLhNQNicBAL9/y/SCvE2b+U3jHYrI6qOCng0eHxRXC/2ttmGkgOmmyweecy3odSad0oK2NV8SOa7030NMkOKpneKBj+3QmX0yCMqeGlElRgktG16/buMsvxEmiTSksr4X11AmoaXlkMPUXD+hiN48eGYGZV+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjMCBhTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5AEC4CEF8;
	Fri, 28 Nov 2025 02:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764295889;
	bh=TkmPFlH4dLbLupR99jE6HJGld/tA3KOdzlC3Zw+aUVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tjMCBhTRHP0wGjCRE/bejtH8pwNgI7LLuHSPa6tU4s6YR3231kKQIngu8rFDhOZSF
	 gJXPco2rRzyGApBjI91gRgedDW5WIxu63bQd4HPUb9Imp5NvYM589p+AiWtECMJEBJ
	 ZqoiWYQb/oyq84EjtoqgoF2hd4++T6ooI+Ppsiqo1vaJUMUYvqfkHIphlQAiEOHsPs
	 JmpNwP/uxGYJVF4QDIbgnURuB5j7bKS2qWaVd2SH7RkRhN75076KkrMhMdGzRj2F1z
	 RCoDC/+9SZdby94ffMNlJcz6PzxqOvnh26cbuNMvnmV4WzCxxnTtO+rdwSiuE4tKA6
	 SRG1edvR3An4Q==
Date: Thu, 27 Nov 2025 18:11:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
 <kadlec@netfilter.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Florian Westphal
 <fw@strlen.de>, "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li
 <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Alexandra Winter
 <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove KMSG_COMPONENT macro
Message-ID: <20251127181127.5f89447b@kernel.org>
In-Reply-To: <20251126140705.1944278-1-hca@linux.ibm.com>
References: <20251126140705.1944278-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 15:07:05 +0100 Heiko Carstens wrote:
>  net/iucv/af_iucv.c                      | 3 +--
>  net/iucv/iucv.c                         | 3 +--
>  net/netfilter/ipvs/ip_vs_app.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_conn.c         | 3 +--

Jozsef, Pablo, should we ask the author to split this up or just apply as is?

