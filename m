Return-Path: <netdev+bounces-44499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F34B7D84EE
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F90F28203C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26242E65D;
	Thu, 26 Oct 2023 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA648829
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:38:29 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0911B1
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:38:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qw1VC-0007Pq-HO; Thu, 26 Oct 2023 16:38:26 +0200
Date: Thu, 26 Oct 2023 16:38:26 +0200
From: Florian Westphal <fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, Antony Antony <antony@phenome.org>
Subject: Re: [PATCH ipsec-next] xfrm: policy: fix layer 4 flowi decoding
Message-ID: <20231026143826.GB22233@breakpoint.cc>
References: <ZTp4dDaWejic16eT@moon.secunet.de>
 <20231026143642.23775-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026143642.23775-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Florian Westphal <fw@strlen.de> wrote:
> +	switch (flkeys->basic.ip_proto) {
> +	case IPPROTO_GRE:
> +		fl6->fl6_gre_key = flkeys->gre.keyid;
> +		break;
> +	case IPPROTO_ICMP:

Sigh.  This should be IPPROTO_ICMPV6. I'll send a fresh v2
in a minute.

