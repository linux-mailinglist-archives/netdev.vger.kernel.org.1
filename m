Return-Path: <netdev+bounces-56664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A57810668
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E425B20ACC
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1529538D;
	Wed, 13 Dec 2023 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsWIAbTX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944A38B;
	Wed, 13 Dec 2023 00:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6FDC433C8;
	Wed, 13 Dec 2023 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426746;
	bh=ZBCGLRUINAy3PJLznoZVcpFOozJlxcY0Yc4x3mKL4D4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WsWIAbTXHP1VM1e6OakL+nwXlgWXFu6ifsH6vcLswbaIXHmKjRe1bjy8OvhMfbdQ5
	 SZ4GT0yPs7aOWlrR/GzROUMP6wOg3nCnZ3VUKGV1F+8h8bfkKfAnRsqEtnv5J/kK1e
	 CnZQXxROByLf75nqOuwDW7Dj2JnfV3CLHBQdKW4Cd03G5SPXmheW0lRSnCx+HjzMXt
	 1P0loo8fLxEwD1u2otxA/Ocsup3vm2b6p+9Gjfne4E/E5IiWvyUYRmoIW08iJZAjmF
	 4dTYozJi/CzJcldG6UGAQfA/stHxeE84W+5kp2ajAv7FpLG8MqnejwKWPFiWJWkKzK
	 rRIJMRUAL7Hgg==
Date: Tue, 12 Dec 2023 16:19:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Breno Leitao <leitao@debian.org>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 05/13] tools/net/ynl: Add binary and pad
 support to structs for tc
Message-ID: <20231212161905.38a75b2a@kernel.org>
In-Reply-To: <20231212221552.3622-6-donald.hunter@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
	<20231212221552.3622-6-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 22:15:44 +0000 Donald Hunter wrote:
> The tc netlink-raw family needs binary and pad types for several
> qopt C structs. Add support for them to ynl.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

