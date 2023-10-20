Return-Path: <netdev+bounces-42960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC4A7D0C96
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0071C20F95
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C81156EE;
	Fri, 20 Oct 2023 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E315E81
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:01:09 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E3DD63;
	Fri, 20 Oct 2023 03:01:06 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qtmJL-0006Bk-Bu; Fri, 20 Oct 2023 12:00:55 +0200
Date: Fri, 20 Oct 2023 12:00:55 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexander H Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] ipv6: remove dst_allfrag test on ipv6
 output
Message-ID: <20231020100055.GC9493@breakpoint.cc>
References: <cover.1697779681.git.yan@cloudflare.com>
 <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
 <CANn89iKU6-htPJh3YwvDEDhnVtkXgPOE+2rvzWCbKCpU25kbDw@mail.gmail.com>
 <CAO3-PbqtEPQro4wsQbaD-UbF-2RpxsVKVvs3M0X10-oE7K1LXA@mail.gmail.com>
 <CANn89iK6WE1MUdHKfNcEf=uhKXustwQ-mtC5_toVAkz=VFctgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iK6WE1MUdHKfNcEf=uhKXustwQ-mtC5_toVAkz=VFctgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> I also noticed that iproute2 was not supporting RTAX_FEATURE_ALLFRAG,
> so we might kill it completely ?

Yes, I intentionally did not expose it in iproute2.

Lets remove ALLFRAG.

