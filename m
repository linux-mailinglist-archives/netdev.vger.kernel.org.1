Return-Path: <netdev+bounces-38801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3EE7BC8B0
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06463281EA9
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8922E637;
	Sat,  7 Oct 2023 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rI1acNMf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6ADDC8;
	Sat,  7 Oct 2023 15:39:54 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F23B9;
	Sat,  7 Oct 2023 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sMf+V8nMVKrjhB8nBVy+ReB5cCuZ6Kdvix3SI9yE6xo=; b=rI1acNMfry8/msW8N68g/cfjLO
	/hkHpAxUpLVN5BjKPg7UI11N9Cz6NgQCfooRnSRwEOziUfeqPw5Z/dStjiEuIZiOZii/21j8ydmc1
	Zwfdq+b5unYs3MEi6n1drAJEMUSZMXQGuiCvfOUPydZUhbRfheJtW2u3UdvZCsaU8km4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qp9PD-000KL8-Bj; Sat, 07 Oct 2023 17:39:51 +0200
Date: Sat, 7 Oct 2023 17:39:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: tmgross@umich.edu, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <2913e1bf-819e-4edb-8721-5b123e6c6c55@lunn.ch>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <20231006094911.3305152-4-fujita.tomonori@gmail.com>
 <CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A37FjwUzZO9Fn-iPaoA@mail.gmail.com>
 <20231007.210734.448113675800173824.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007.210734.448113675800173824.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> reexporting all the BMCR_ values by hand doesn't sound fun. Can we
> automaticall generate such?

The C22 address space only have a max of 32, and no more are expected.

C45 address space can have in theory 32 x 65536, although in practice
it is sparsely populated. But new values are added every so often. So
generated at build time from the #defines would be better.

	  Andrew

