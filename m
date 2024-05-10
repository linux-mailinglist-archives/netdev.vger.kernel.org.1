Return-Path: <netdev+bounces-95280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572EB8C1CE2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFC81C20DDF
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59692148FE1;
	Fri, 10 May 2024 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REVzbOSZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D845490E;
	Fri, 10 May 2024 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310974; cv=none; b=Kc5hbsk+RnCXd67+5OMqWtv43WgqATWfa/FctjcilX4+cvzgb9UISht1F/huWblyXAmo2RQgeDGO8lXwMT5gKrRxApMCVeOkYOEswVc97BeQWysqjGWbCagat2qVsl011shgYeqCPn7Z71xoDXEnS2ZK2fFXv3EJtuIq9uV6Jgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310974; c=relaxed/simple;
	bh=PytcuTsukT994oYXjr1HyDGo4xfMA1yb3JvQ6Ozqpgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBYdzXerp1a6DCbS5jwcQtuIf8xlTKY/KssswHxZg0J0sjpfb3pnP9KC6QOJel8YZ9ky+fMcg6Ok1+H4DOua5/F7MLr/jMBCzjnwdTSuO5PBOPerbgNuNN/sIs5OlvvR89aXrRWGQrQSeO00xCZWJ2HJEyEeLSK1pVNmXk6ZXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REVzbOSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAD0C116B1;
	Fri, 10 May 2024 03:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310973;
	bh=PytcuTsukT994oYXjr1HyDGo4xfMA1yb3JvQ6Ozqpgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=REVzbOSZzKaiStzn9IuNaLnNHmDhtLkhb1jbOPPqxd1KRnh9C2STYomtY4Hw7DwI0
	 OwkxU8qCaAgKvGTBjm5tMQ/v5ANBf78n7FzA2o57Z7zG6jFOptQYmkJd7veBHIfMUo
	 QtYiOTTbGQb3NAqH6gn9yE6XAphHbdfmrB35XoO3RcQBNSYwtDOF7LozvnpevmXxUu
	 vJ8G60zechptAbwfl758Cl7YRBAk+zk4+GWhXKTdb5EI5NVdv3X2aYodVQWVcnWYAi
	 qddA+g1p9JuD2art0a4ySlvIg8O5kjzveWXm7GxDiIA3Jj9rt0dJG8kRRh+x/+qBnY
	 5EreW0Tlm0vgA==
Date: Thu, 9 May 2024 20:16:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, Jeroen de Borst
 <jeroendb@google.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Harshitha Ramamurthy
 <hramamurthy@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, LKML <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, John Fraker <jfraker@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Shailend Chand
 <shailend@google.com>, rushilg@google.com
Subject: Re: [PATCH net-next 5/5] gve: Add flow steering ethtool support
Message-ID: <20240509201611.053027de@kernel.org>
In-Reply-To: <CAG-FcCNGsP3FnB6HzrcQxX4kKEHzimYaQnFcBK63z_kFTEQKgw@mail.gmail.com>
References: <20240507225945.1408516-6-ziweixiao@google.com>
	<3e10ff86-902d-45ed-8671-6544ac4b3930@web.de>
	<CAG-FcCNGsP3FnB6HzrcQxX4kKEHzimYaQnFcBK63z_kFTEQKgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 May 2024 17:19:00 -0700 Ziwei Xiao wrote:
> > How do you think about to increase the application of scope-based resource management
> > at such source code places?
> >  
> Is the suggestion to combine dev_hold(netdev) together with
> rtnl_unlock()? If so, I think there might be different usages for
> using rtnl_unlock. For example, some drivers will call rtnl_unlock
> after dev_close(netdev). Please correct me if I'm wrong. Thank you!

We are rather cautious about adoption of the scope-based resource
management in networking. Don't let Markus lead you astray.

