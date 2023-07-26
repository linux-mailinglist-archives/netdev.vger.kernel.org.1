Return-Path: <netdev+bounces-21547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941CF763E0F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB38F1C212AE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29718040;
	Wed, 26 Jul 2023 18:01:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C41803C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:01:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E832697;
	Wed, 26 Jul 2023 11:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mOs0FbEX7U/JftVf/7w+izAt0GEtfD+who6ul2jmL1A=; b=Iln/whwi3yb0OCDfnbyBjMdx+m
	juFI59CritCNSyW6F5D0XpHC0iscqFmdZ00//lCiuYir0a6u4x+Trb0fDiT1I8lWJsP6oU29GK/FQ
	HnfImdfWz3d/FFVFAVn2c5NvOhMlPOV/jQ9Gw7gF/R+QQhgAxkPBg30gZGpfWe9e6F1g3T860ToDU
	3b3igthrZTDls6/w68U1gJwMhAvJIATJevMX85S2LJO5gw+sF1p7LDa7daV4DC/GaXuMpeYo9ezaB
	YVbkS848bTHFzserKKNJffxnqBuL9rIXky9EaSjRDnBy0AFCo9mO69kFKWdY6Q9jqUcRgtsOlJyZn
	kzcXs81A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qOip5-00BERo-0b;
	Wed, 26 Jul 2023 18:01:19 +0000
Date: Wed, 26 Jul 2023 11:01:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>, willy@infradead.org,
	keescook@chromium.org, josh@joshtriplett.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvs-devel@vger.kernel.org
Subject: Re: [PATCH 10/14] netfilter: Update to register_net_sysctl_sz
Message-ID: <ZMFfb4bJ6neACe5X@bombadil.infradead.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140706eucas1p1b11e5f0bd17f0de19af9608cbd8d17f3@eucas1p1.samsung.com>
 <20230726140635.2059334-11-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726140635.2059334-11-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 04:06:30PM +0200, Joel Granados wrote:
> This is part of the effort to remove the sentinel (last empty) element
> from the ctl_table arrays. We update to the new function and pass it the
> array size. Care is taken to mirror the NULL assignments with a size of
> zero (for the unprivileged users)

Same in this commit, the "why" is missing and size impact, if any.

  Luis

