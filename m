Return-Path: <netdev+bounces-237271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB9CC4813E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1971882332
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5B32ABD6;
	Mon, 10 Nov 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="um/XF6c5"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10E28003A
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792770; cv=none; b=swJ9i2SI71blI69bsqUlQcPkLWtp8EYPMNoQSxZmSYxPttc6Bg3tne0JHYORcuy51Rb7L/3A2fkIOBpfuci+R6hXApGq80Y6LKyErCyCJwivUOODv0JyRCp2MdrzVJUkyvncIusil9388unpTYIJeKoSbpiecoTGERtOiXQCJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792770; c=relaxed/simple;
	bh=nL2j/N7Be/y/+iyv9yUUhUIAjUwA9vecOWINri/2UC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URW2OrDWN0V5tvCqsgNySKXgztfiFfO3ZFsNJ6ArR18UqxpMXc5lpRFaOiTmrZC+Ae5GuwftIFgYqXvWAdpfUKq62sHcYnlGEtVPum09uiCPxoDYCdftDiCwEx00hVel1p0yDUp9ppn4PMATj2846ulRTou+oWoo6AjeXY+XtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=um/XF6c5; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1762792757;
	bh=nL2j/N7Be/y/+iyv9yUUhUIAjUwA9vecOWINri/2UC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=um/XF6c5uTKD0eKREyaQSJcUuKogKqcx0BEX8PFZODlV9ya/baaN+bFTjFmQKqCj9
	 Ui2au38veP2yNFdgYLMSY04We5T7TOg/VepgJzbYW5ligcmD/NgYBhRMgw3ZabA2w1
	 mzZOY3Pgei6uxxhb4MLvqaWhHrEZ+q7S7Y8kS9nqYTH01gdSpUq8gudWflLt6DCzY+
	 UDdvQwWTYXmB5KC1LBWBQAf2EqGayPoBBwMwXfAKiS3tLYZF8XyuP5WRpeGERuTC7R
	 y7CcKzY/bcVN2zN1Rts5YWGR44PFuImi6HrvGEnKwAERvgRUMwtoR1+MG8Wu+s3+uR
	 sJj11lXSJmHeA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5617F60075;
	Mon, 10 Nov 2025 16:39:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 8E1A4201F01;
	Mon, 10 Nov 2025 16:38:40 +0000 (UTC)
Message-ID: <85c4d051-8820-4083-8220-da2c14c29dab@fiberby.net>
Date: Mon, 10 Nov 2025 16:38:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 2/3] netlink: specs: support ipv4-or-v6 for
 dual-stack fields
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org
References: <20251110100000.3837-1-liuhangbin@gmail.com>
 <20251110100000.3837-3-liuhangbin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251110100000.3837-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/25 9:59 AM, Hangbin Liu wrote:
> Since commit 1b255e1beabf ("tools: ynl: add ipv4-or-v6 display hint"), we
> can display either IPv4 or IPv6 addresses for a single field based on the
> address family. However, most dual-stack fields still use the ipv4 display
> hint. This update changes them to use the new ipv4-or-v6 display hint and
> converts IPv4-only fields to use the u32 type.
> 
> Field changes:
>    - v4-or-v6
>      - IFA_ADDRESS, IFA_LOCAL
>      - IFLA_GRE_LOCAL, IFLA_GRE_REMOTE
>      - IFLA_VTI_LOCAL, IFLA_VTI_REMOTE
>      - IFLA_IPTUN_LOCAL, IFLA_IPTUN_REMOTE
>      - NDA_DST
>      - RTA_DST, RTA_SRC, RTA_GATEWAY, RTA_PREFSRC
>      - FRA_SRC, FRA_DST
>    - ipv4
>      - IFA_BROADCAST
>      - IFLA_GENEVE_REMOTE
>      - IFLA_IPTUN_6RD_RELAY_PREFIX
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks for finding these! I can't remember how I did my previous
check, and why I didn't find these earlier.

Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

