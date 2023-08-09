Return-Path: <netdev+bounces-26073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA36776B53
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E2C280A16
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211021DDCC;
	Wed,  9 Aug 2023 21:58:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047352452D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:58:58 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B22103;
	Wed,  9 Aug 2023 14:58:56 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qTrCY-0002Gf-QW; Wed, 09 Aug 2023 23:58:46 +0200
Date: Wed, 9 Aug 2023 23:58:46 +0200
From: Florian Westphal <fw@strlen.de>
To: Justin Stitt <justinstitt@google.com>
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] netfilter: ipset: refactor deprecated strncpy
Message-ID: <20230809215846.GE3325@breakpoint.cc>
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
 <20230809-net-netfilter-v2-1-5847d707ec0a@google.com>
 <20230809201926.GA3325@breakpoint.cc>
 <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Justin Stitt <justinstitt@google.com> wrote:
> On Wed, Aug 9, 2023 at 1:19 PM Florian Westphal <fw@strlen.de> wrote:
> >
> > Justin Stitt <justinstitt@google.com> wrote:
> > > Use `strscpy_pad` instead of `strncpy`.
> >
> > I don't think that any of these need zero-padding.
> It's a more consistent change with the rest of the series and I don't
> believe it has much different behavior to `strncpy` (other than
> NUL-termination) as that will continue to pad to `n` as well.
> 
> Do you think the `_pad` for 1/7, 6/7 and 7/7 should be changed back to
> `strscpy` in a v3? I really am shooting in the dark as it is quite
> hard to tell whether or not a buffer is expected to be NUL-padded or
> not.

No, you can keep it as-is.  Which tree are you targetting with this?

