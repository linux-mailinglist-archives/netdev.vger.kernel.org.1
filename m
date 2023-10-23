Return-Path: <netdev+bounces-43523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345117D3B94
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660D01C208F2
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33181CA81;
	Mon, 23 Oct 2023 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836471B292
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:00:08 +0000 (UTC)
Received: from janet.servers.dxld.at (mail.servers.dxld.at [IPv6:2001:678:4d8:200::1a57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47FDE9;
	Mon, 23 Oct 2023 09:00:06 -0700 (PDT)
Received: janet.servers.dxld.at; Mon, 23 Oct 2023 17:59:56 +0200
Date: Mon, 23 Oct 2023 17:59:50 +0200
From: Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireguard: Fix leaking sockets in wg_socket_init error
 paths
Message-ID: <20231023155950.oyl2olisob6dnvwo@House.clients.dxld.at>
References: <20231023130609.595122-1-dxld@darkboxed.org>
 <ZTZ9XfPOXD4JXdjk@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTZ9XfPOXD4JXdjk@zx2c4.com>

Hi Jason,

On Mon, Oct 23, 2023 at 04:04:13PM +0200, Jason A. Donenfeld wrote:
> The signed-off-by is missing and the subject does not match the format
> of any other wireguard commits.

Ah, I don't usually send kernel patches. Forgot to do format.signOff=true.

> On Mon, Oct 23, 2023 at 03:06:09PM +0200, Daniel Gröber wrote:
> > This doesn't seem to be reachable normally, but while working on a patch
> 
> "Normally" as in what? At all? Or?

I committed this while working on my address/ifindex binding patch[1]
(which I will also resend shortly), at the time I thought this fix makes
sense in isolation but apparently not.

[1]: https://lists.zx2c4.com/pipermail/wireguard/2023-August/008148.html,

> > for the address binding code I ended up triggering this leak and had to
> > reboot to get rid of the leaking wg sockets.
> 
> This commit message doesn't describe any rationale for this patch. Can
> you describe the bug?

It's been a while since I wrote this patch. Unfortunately you didn't
respond to my initial mail in Aug, so some context has already been lost to
time.

I may have been under the mistaken impression that udp_sock_create can
return <0 while leaving *sockp!=NULL, but as I recall it I did re-test with
this patch and it fixed the bug, that I wish I remembered how to trigger
now. Unsatisfying.

--Daniel

