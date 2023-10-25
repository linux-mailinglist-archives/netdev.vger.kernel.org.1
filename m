Return-Path: <netdev+bounces-44081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B597D6049
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE65B210BB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4950D1360;
	Wed, 25 Oct 2023 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QncQjFqZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12C5220
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 03:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDEFC433C7;
	Wed, 25 Oct 2023 03:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698203487;
	bh=1zXxJKDjm5lozyrD4GOUNkxoTQh9dFOuF8bEs0pKo8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QncQjFqZYkydOC37RyyUevm4RK0+v8wK33SaVG9nx3JZBWRdHA1NV0FvVYN56dFRj
	 zMr3GSP3FdrQ4jLmUxG8Rny5GteMwuYz0IW2437dHiqiEq4/aPFTJuH8ZqzMTWRdWm
	 hGezSh0qsSkJaVFK3+3hDWLXdWPIHn+rL/7iWCxxJ0Axr0rapSzvaVbi/9MRyxpIuL
	 YY2VlYZiLyT0ekKHnV1iPLy5ba5IgWqVoyCl0LQT0Vg3nJlhcrvQUlv7RQDNh4MARX
	 WhsecYaMo8u9ap93y5U2nbvGtpuIShokapDDYH5P1OnjMe/YfQ9YBJz1vXO6SKW9nP
	 JqwyV6aeZTCBA==
Message-ID: <5cd4aec9-ca43-400a-97bb-9e94b20abb49@kernel.org>
Date: Tue, 24 Oct 2023 21:11:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 5/6] net-device: reorganize net_device fast
 path variables
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
References: <20231025012411.2096053-1-lixiaoyan@google.com>
 <20231025012411.2096053-6-lixiaoyan@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231025012411.2096053-6-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 7:24 PM, Coco Li wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h index
> b8bf669212cce..d4a8c42d9a9aa 100644 --- a/include/linux/netdevice.h +++
> b/include/linux/netdevice.h @@ -2076,6 +2076,60 @@ enum
> netdev_ml_priv_type { */ struct net_device { + /* Caacheline
> organization can be found documented in

same here -- double aa in Cacheline

