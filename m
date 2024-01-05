Return-Path: <netdev+bounces-61945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD18254DD
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 15:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE0CB2162B
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2662D7A7;
	Fri,  5 Jan 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8fuoYDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3372D78D
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 14:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B37C433C9;
	Fri,  5 Jan 2024 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704463788;
	bh=YIZFlFTKuOSSkQeHzUs5u09JSVOu3c37OT5aarOCI7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e8fuoYDuvMXv3jRsqn6yQ3J2qewNQhRChPSfeX+rCCnxQIridzjDqeKgQf4sAvBIi
	 oogpO4TTN9KuhP408DfA2Zt/MstIfbBwQXbJsPwczPfFO69QAyQX+tVbbdETXAO2o/
	 2vyRw9snrnr+NMuzW13aS9GUn9hMsEhYjVD+uzUKAWs8A2zciJzEhxmS/r/LxalZB8
	 V0XnrjsVuU/YqZ6hK2jt88+Fo4UZTIzaFCnY1Wzy8OPrQuYpIXXnp+qZJIfsvz1Y/c
	 Wj/6YBzT3xlBIsb/YKesROsSvOoBsAoiBVJ9kq24PSqRvUDQOI6wmM6VLZy+r+nuyP
	 t+u4mP0YZ6XvQ==
Date: Fri, 5 Jan 2024 06:09:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Eyal Birger <eyal.birger@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 Florian Westphal <fw@strlen.de>, victor@mojatatu.com
Subject: Re: [PATCH iproute2-next v2] remove support for iptables action
Message-ID: <20240105060946.221ca96f@kernel.org>
In-Reply-To: <CAM0EoMnSVQHyQy37OoznsF15+M84o7L2c6UwtKL1Fcuwev4rHA@mail.gmail.com>
References: <20231226182531.34717-1-stephen@networkplumber.org>
	<CAM0EoMmH-5Afhe1DvhSJzMhsyx=y7AW+FnhR8p3YbveP3UigXA@mail.gmail.com>
	<20240104072552.1de9338f@kernel.org>
	<CAM0EoMkP18tbOuFyWgr=BaCODcRTJR=rU6hitcQSY_HD9gD87g@mail.gmail.com>
	<CAHsH6Gsz7ANvWo0DcfE7DYZwVzkmXSGSKwKhJMtA=MtOi=QqqA@mail.gmail.com>
	<CAM0EoMnSVQHyQy37OoznsF15+M84o7L2c6UwtKL1Fcuwev4rHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 06:20:10 -0500 Jamal Hadi Salim wrote:
> > I tested and it looks like the patch doesn't affect em_ipt, as expected.

Thank you!

> > I did however run into a related issue while testing - seems that
> > using the old "ingress" qdisc - that em_ipt iproute2 code still uses -
> > isn't working, i.e:
> >
> > $ tc qdisc add dev ipsec1 ingress
> > Error: Egress block dev insert failed.
> >
> > This seems to originate from recent commit 913b47d3424e
> > ("net/sched: Introduce tc block netdev tracking infra").
> >
> > When I disabled that code in my build I was able to use em_ipt
> > as expected.  
> 
> Resolved in: https://lore.kernel.org/netdev/20240104125844.1522062-1-jiri@resnulli.us/
> Eyal, if you have cycles please give it a try. Jakub, can we get that applied?

FTR it was applied by Dave soon after you asked.

