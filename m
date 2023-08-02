Return-Path: <netdev+bounces-23481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D9F76C1A9
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 02:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF6B281C6F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F797E8;
	Wed,  2 Aug 2023 00:53:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337D7E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD78C433C8;
	Wed,  2 Aug 2023 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690937619;
	bh=qrzmpZi6hydFeKd9V3EcDQx3aotLvdeCTmPFzSYgycE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M6fe6GkBHuOJCyzFdBx46ssTHZwe+rkNZ+m4kl7Bhti+gb5se65t7trtEZOGbu7wn
	 kOkM5oQYETrtpaxCQcenta6yVPWetAFSx6kUjOvLabjYKCwtcT2E19CvQwbI0vQb9o
	 P6l4HOKmuJPA5rTey7nOojgMJ7kThuT/j8U1GrHPxfuN4DDjIHZQeHASxXcz0yKatJ
	 oHZKksU6bz0D9ywUbWzaWMQ/14Y9b9wcXSPz29q5jcPTqBqv2ZAM9+2dbMNUgTtoJN
	 hPjcv1P9swQiPtWGdRzy8d3aSSVhZfE8d3x9PNSF1qOApjiSuHKUOfS3+Fs1j2JUkd
	 gW3a+p0B78LTw==
Date: Tue, 1 Aug 2023 17:53:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lin Ma" <linma@zju.edu.cn>
Cc: "Leon Romanovsky" <leon@kernel.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, fw@strlen.de,
 yang.lee@linux.alibaba.com, jgg@ziepe.ca, markzhang@nvidia.com,
 phaddad@nvidia.com, yuancan@huawei.com, ohartoov@nvidia.com,
 chenzhongjin@huawei.com, aharonl@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230801175338.74bc39c2@kernel.org>
In-Reply-To: <385b9766.f63d7.189b3a33c6b.Coremail.linma@zju.edu.cn>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
	<20230731120326.6bdd5bf9@kernel.org>
	<20230801081117.GA53714@unreal>
	<20230801105726.1af6a7e1@kernel.org>
	<385b9766.f63d7.189b3a33c6b.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Aug 2023 08:26:06 +0800 (GMT+08:00) Lin Ma wrote:
> This is true. Actually, those check missing codes are mostly old codes and
> modern netlink consumers will choose the general netlink interface which
> can automatically get attributes description from YAML and never need to
> do things like *manual parsing* anymore.
> 
> However, according to my practice in auditing the code, I found there are
> some general netlink interface users confront other issues like choosing
> GENL_DONT_VALIDATE_STRICT without thinking or forgetting add a new
> nla_policy when introducing new attributes.
> 
> To this end, I'm currently writing a simple documentation about Netlink
> interface best practices for the kernel developer (the newly coming docs
> are mostly about the user API part). 

Keep in mind that even most of the genetlink stuff is pretty old
at this stage. ethtool is probably the first reasonably modern family.
But do send docs, we'll review and go from there :)

