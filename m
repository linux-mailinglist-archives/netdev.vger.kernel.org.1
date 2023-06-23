Return-Path: <netdev+bounces-13238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5948C73AEA3
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B9B281890
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7699519B;
	Fri, 23 Jun 2023 02:31:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54C196
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30553C433C0;
	Fri, 23 Jun 2023 02:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687487481;
	bh=jSwD819d6vzn1nQLBLA8tpzXQqn13wWvKCPwPru/PdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cpwzxnw9N3kv46R9cSZIavbUhGDpjQa4cZPus3bjviz9tKnFhvFcT7dT2MdZwxzu4
	 1Lt+HehGq0CqGLE1KCNMjMoMDyvcEpjp70VWZFL0ehX/ToNoqQ9E0bTxoFeUr/eoyQ
	 9rLA6FlIaSZl+Fi8hLvJSSSSGGC2QY/S7upU3pdGLDluAVzdnoo8g/wdsfQy0Cm/6Y
	 JP5uuUUfiiSjAGIpfhmgv2BK6p6rt7d38CPoDVS1OJGc1bsRJ6omLUYo0ZgRqLdcm/
	 dCwyLmPCgmhFykjqL5xNw5PdvR1JJUzPPBuVJhAlKeU6Nzd2dg0XB+Tyv10BlrONEh
	 n7jQAnd1C0vxw==
Date: Thu, 22 Jun 2023 19:31:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Pavel Machek <pavel@ucw.cz>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for additional
 modes for netdev trigger
Message-ID: <20230622193120.5cc09fc3@kernel.org>
In-Reply-To: <20230621095409.25859-1-ansuelsmth@gmail.com>
References: <20230621095409.25859-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 11:54:09 +0200 Christian Marangi wrote:
> The QCA8K switch supports additional modes that can be handled in
> hardware for the LED netdev trigger.
> 
> Add these additional modes to further support the Switch LEDs and
> offload more blink modes.

Something may be funny with the date on your system, FWIW, because your
patches seem to arrive almost a day in the past.

