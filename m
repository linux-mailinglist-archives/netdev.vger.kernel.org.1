Return-Path: <netdev+bounces-56141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B31180DF7B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1341F21A48
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B135675B;
	Mon, 11 Dec 2023 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSvpi2pn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66856474;
	Mon, 11 Dec 2023 23:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66056C433C8;
	Mon, 11 Dec 2023 23:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702337401;
	bh=gmN+4ZuIrAtVeRZuZrZfj4ROJVKVozluCainQp9ATa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WSvpi2pn4SKLJR+bxCIlMdi/nh7gtvmT2M4+rXbuTStCwUS3JBmzZyhL7/cLWl9jr
	 Jh/JOeMbaLgRBXIfCvqGuP7KxTaurs8/fxZ7ILFefq3i1KC7lYjSIwAuArlqz+C3wY
	 x0XDvrqw+xu7jY7RMkVIcItOPcWi+v+kDQOYye4uc8le24QSvt5AjiMLiql8MUvJfJ
	 rU3vJ7osMlIc0ij9rNOPzeBcIgSubtuxti7zTAcYuKnEl0OQhRUhf1IDD/5MjNMWa+
	 E//YdD7poM5hFmoTJ2NqYu/Dh39xYmdwroQSVnnt/2WIR+3Pq3PGs8ek7Wqf4oVIZH
	 zyJ4eqOntHt6A==
Date: Mon, 11 Dec 2023 15:30:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com, leitao@debian.org
Subject: Re: [PATCH net-next v2 02/11] tools/net/ynl-gen-rst: Sort the index
 of generated netlink specs
Message-ID: <20231211153000.44421adf@kernel.org>
In-Reply-To: <20231211164039.83034-3-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211164039.83034-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 16:40:30 +0000 Donald Hunter wrote:
> The index of netlink specs was being generated unsorted. Sort the output
> before generating the index entries.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Please do CC Breno on tools/net/ynl/ynl-gen-rst.py changes.
https://lore.kernel.org/all/20231211164039.83034-3-donald.hunter@gmail.com/

