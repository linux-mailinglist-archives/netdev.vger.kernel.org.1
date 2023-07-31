Return-Path: <netdev+bounces-22946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C54876A24D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454BC281480
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E421DDF2;
	Mon, 31 Jul 2023 21:00:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064918C26
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86073C433C8;
	Mon, 31 Jul 2023 21:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690837245;
	bh=KL21ST4EEQnhv5fxf57IORwltkN1VqU/fjD0I4RXt3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EWQxSUIQ51uFFnekenk1T77nLQlcED+dQZZmEdJx5NZppeiDy6vxqCHeINARAUP4N
	 GRr68CZsDKGXjkQiBfuc9kmDK/FPrGK95N/0dAYtQDYG8Hfn5H8AFd0HdqZsjFhHRX
	 kAQ4asby07QY7US5WtyBw4jD8qSKpBhr4xPf49/vZTKtPOczYZRlmUFBIPciBivcRQ
	 +PavYut1Dh/TvSPin1xjulQWS2qlBdt297pG+iTKuT0/he1GVl/5inO/1+ZAliNkvu
	 G1UC0y+WdlKI4hcx3dHAUKhYnfOygA6RWxGVj7jffDfNL+ltOYMIllHuu+Ap9rzZnU
	 6z7hNupUWkI6A==
Date: Mon, 31 Jul 2023 14:00:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: <netdev@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
 <olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <20230731140043.28a42c8f@kernel.org>
In-Reply-To: <20230727082550.15254-1-ante.knezic@helmholz.de>
References: <20230727082550.15254-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 10:25:50 +0200 Ante Knezic wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.

Looks like the patch was set to Changes Requested in patchwork:

https://patchwork.kernel.org/project/netdevbpf/patch/20230727082550.15254-1-ante.knezic@helmholz.de/

Presumably due to lack of CC and/or Ack from Russell.
Could you repost with Russell included?

