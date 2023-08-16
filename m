Return-Path: <netdev+bounces-28118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8554E77E475
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39F2281A42
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD60712B95;
	Wed, 16 Aug 2023 15:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41310957
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7633C433C8;
	Wed, 16 Aug 2023 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692198008;
	bh=zIFuavAAkrRzHP97/+EypFEFEaYwyMI665GY6yMI4Hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XsI833QBL1DiCoS9rGj8A1KK5ljEkiOOPQOlRDcexni1sWI+j4923/ncmD/PsyJjb
	 xXrrENoEI1BjbVsD2+vZ7WltgbL1HDnavZxD+iySM/E0ywBYpwMf1Begt+Okog8Itf
	 /4vi00CxwGnkP0G347P24S6NNZGHWcuqcc4vt68DcJsTpHIfkvVJ77nEOioWID6zBT
	 drLQkcmIa/RTZHdgAsOdouzz/YIDwpedSyclQ7qAZe0oxGQU92UXECEGQ22Kt7gprn
	 BLTGKTvCLowct7OiuNuvTrbCc2OfunZUf1wRS7Vz5OZd6uQCQubDEZxoyP/PN6QcjY
	 /A81610E7jnHw==
Date: Wed, 16 Aug 2023 08:00:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Stanislav Fomichev
 <sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 02/10] doc/netlink: Document the
 genetlink-legacy schema extensions
Message-ID: <20230816080006.42496226@kernel.org>
In-Reply-To: <m2ttszi0um.fsf@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-3-donald.hunter@gmail.com>
	<20230815194902.6ce9ae12@kernel.org>
	<m2bkf7jswr.fsf@gmail.com>
	<m2ttszi0um.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Aug 2023 14:16:33 +0100 Donald Hunter wrote:
> > Ack. As an aside, what do we mean by "kernel input policy"?  
> 
> So I've just spotted that kernel-policy is already documented in
> core-api/netlink.rst and I guess I shouldn't be documenting it in the
> userspace-api at all? I could add a reference to the core-api docs so
> that it's easier to find the kernel side docs when reading the
> userspace-api?

Ah, yes, reference sounds good.
But we should also add split to the doc, I only see ``global`` and
``per-op`` described?

