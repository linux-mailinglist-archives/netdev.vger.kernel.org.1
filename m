Return-Path: <netdev+bounces-61573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EDD8244D0
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA94B215F9
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F422376D;
	Thu,  4 Jan 2024 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X23vgeYE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F40241E6
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9412DC433C8;
	Thu,  4 Jan 2024 15:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704381473;
	bh=6v+D9kXpgVFJwSz7K89RHBUTg28fQWYfaBq93zHvydg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X23vgeYEngP+xHEjNWk6m6yI6NUVfbXJkw/z29CFiavdpp7Q0p2K75DI5z/ej4ZQo
	 uL0OyAA3RvZxg34T2kc6JQPlf3RDvjmhKdWIhpB9/ccVPM0HdFBvSFy79sKvQWHXos
	 e/hUv3BY/kPl9G0CUqINcmASQsOv/pSknnT8R5TnHB09n2azqBgjM0M9FZ85s5OkDU
	 qVtZ4LfoxmIzqHbB+1NrFM8N2uKqhSisctmq4SZQnlmBCMXmATqBEc3QmAnw9IcUcp
	 fpgWrFBL29cc+hmHkd48P+zhSDbEi96uMKSIvGsrdAkMAR4+oPyO6yZpPTlgxCRXA6
	 oV0uel95zQs6Q==
Date: Thu, 4 Jan 2024 07:17:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Phil Sutter <phil@nwl.cc>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: rtnetlink: check enslaving iface
 in a bond
Message-ID: <20240104071752.433651ce@kernel.org>
In-Reply-To: <4e1d5b11-6fec-4ee2-a091-479e480476be@6wind.com>
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
	<20240103094846.2397083-3-nicolas.dichtel@6wind.com>
	<ZZVaVloICZPf8jiK@Laptop-X1>
	<0aa87eb2-b50d-4ae8-81ce-af7a52813e6a@6wind.com>
	<20240103132120.2cace255@kernel.org>
	<4e1d5b11-6fec-4ee2-a091-479e480476be@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 14:51:08 +0100 Nicolas Dichtel wrote:
> > Looks like the patch applies to net-next, so hopefully there won't 
> > be any actual conflicts. But it'd be good to follow up and refactor
> > it in net-next once net gets merged in. As long as I'm not missing
> > anything - up to you - I'm fine with either sending the test to
> > net-next like Hangbin suggests, or following up in net-next to use
> > setup_ns.  
> I will send a follow-up once net gets merged in net-next.

Ack, there's still going to be a v3 to update the error message, 
tho, right?

