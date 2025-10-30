Return-Path: <netdev+bounces-234485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C8BC217E3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144581A26593
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE8368F4A;
	Thu, 30 Oct 2025 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0BzNoO4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BB3678BC
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845338; cv=none; b=ic9wFWd4IiIwjWMvPKpwYCeUUFo95YW0xSAdzgM+gPZPQIOBzSo9qUZd+yw6wX4riWdQF+ORZHvsM5NrS6sCjXp1cUPznVWgGVqMJOu9I3W04CkAHTR3ZZGxrMQjICsBdXdwM9EpV++VKiSknKxSHboKavZKa4jUu+m62eVosVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845338; c=relaxed/simple;
	bh=sD4zmr6CtvJ+Iz0ZB2QGn6PbJMUMD6NUE0V5ablXLqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZINB+GEEUS22dyqOQprjj6JOKwK2McMwR0VWIsa/yD4fPJIRrHcNmQ21tPLuXRvFV7epkOwZKnaF5wWhvNfcklsedROeQng6Pvj9OmC6t30op8R3jDg28kiyTjj2ExdIZ1QeZwNwBJ9veQziQ3RlXaPnrLcBEAoFcDU012AiB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0BzNoO4E; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CEA354E413FF;
	Thu, 30 Oct 2025 17:28:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9BE1860331;
	Thu, 30 Oct 2025 17:28:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EAA6411808D0E;
	Thu, 30 Oct 2025 18:28:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761845333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=HrWqQMXP9ro2YOOBcyYxggQYvyf6hY0UcZoeHPIrNhE=;
	b=0BzNoO4EElG1CZmfkfOetzwjB6yhzoFGIz2revS8qAUm108R57uV66PoVXqTeU4rz57Q+s
	WdepiG5gYRuKd0hiVfwZ1x1a6kUySyhZAmtB1gXLIfGv4jnGzrpAz5o5OHRP57vQVvGg7f
	lHE2FH8ccuR/ZK9dDR0lxDf42b7c+lXIQyznBcrxSO5wvO/tdx9DeA0hCN2GokXgre2ol6
	Seik1Lcb8Nq1uIO/4Sl6AnX+FgbB2Gbi1+52LpCEeX3NeK+ZDeWoG+EWeVJk9R8rrbo3YG
	WPZCQ5msBySt3D7JXdm5ZZVA90v80RSMf7vlUKaKe5wfMxuioIrIip0dEpcMKg==
Message-ID: <3d2e1a79-9ec5-4144-8787-b09c3f444544@bootlin.com>
Date: Thu, 30 Oct 2025 18:28:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v5 1/5] net: selftests: export packet
 creation helpers for driver use
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org,
 o.rempel@pengutronix.de, gerhard@engleder-embedded.com,
 Shyam-sundar.S-k@amd.com
References: <20251030091245.3496610-1-Raju.Rangoju@amd.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251030091245.3496610-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Raju,

On 30/10/2025 10:12, Raju Rangoju wrote:
> Export the network selftest packet creation infrastructure to allow
> network drivers to reuse the existing selftest framework instead of
> duplicating packet creation code.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>


