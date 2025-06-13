Return-Path: <netdev+bounces-197420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46514AD89B1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B996E3B70E9
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B92E1759;
	Fri, 13 Jun 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFWyq0c/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9DC2E173D;
	Fri, 13 Jun 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811216; cv=none; b=uOO8tmPS8l0MDQrP/+eVeJ7IKnEnTdI2zOkJkNCzDpGPSVqPTyoIqLz5ogylEIb20oiS2WbeuQpQHjLEdCTExdaw2UowqsCUpTiyLdFwHUMESKpL5AoZk+F3Ro4Td1QhKqYrTdQCIgOeafI+7azr6QnBXmwrONXu+8qsqyhD5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811216; c=relaxed/simple;
	bh=mLZwn8nwTw0SpjqZedbLfqtbjfMBNExKx1RJT6U74bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzIqM3YrlF+qedY3CUI1W0eTClQXtaXIuTndMMqqeZY2u2yjqjZP0HZ2OXELFRaNnXYnxN3MjCOUNEnW9upahcvy4lp2mxi8BRh4eebFBIDgWd0z9hOtuTsXft97T8Q24wz3N39Jg66sFuSEFqNA8ubm+QmM/CIe1wC9JMdsPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFWyq0c/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0623DC4CEEB;
	Fri, 13 Jun 2025 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749811215;
	bh=mLZwn8nwTw0SpjqZedbLfqtbjfMBNExKx1RJT6U74bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PFWyq0c/e1O6gPHVqvZjxxyEKgSKVMVRV84ZPqcDpoOKSs0Tcys2Boi28pGi7Nr7X
	 xWkWCSDaI4xpq5aS+PKb8shbEagetpCELAEQ0MsDeM4roDQ69EBaTqUACzOhP4F/u6
	 1LDvdMUXLXEUGnGimoWhWEnEgJQ+RrzWyQZwjv0Dyr3ktgtg6xzNCdPZB7JIZHa70I
	 Rw6xb804N8kxIWuGsqxlBg5kdj48Jqn1XZ7/VXqHYTRC1k4mV5fo+OnwJaBpwPnM6F
	 cH9g1WECWv5DfMMdvN7rDeC+u6F3bY9b9gFIxP6Y4Z77jX3tsQPZD4sT3fla2Fnxg1
	 irXdMl4Nfn2JQ==
Date: Fri, 13 Jun 2025 12:40:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, "David S. Miller" <davem@davemloft.net>, Ignacio
 Encinas Rubio <ignacio@iencinas.com>, Marco Elver <elver@google.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>, Jan
 Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben
 Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, lkmm@lists.linux.dev,
 netdev@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v2 0/2] Some extra patches for netlink doc generation
Message-ID: <20250613124006.3f0bb3c6@foz.lan>
In-Reply-To: <m2ldpwnj5g.fsf@gmail.com>
References: <cover.1749735022.git.mchehab+huawei@kernel.org>
	<m2ldpwnj5g.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 13 Jun 2025 09:24:43 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > This patch series comes after:
> > 	https://lore.kernel.org/linux-doc/cover.1749723671.git.mchehab+huawei@kernel.org/T/#t  
> 
> Can you please incorporate this series into a v3 of the other patch set.

Sure. Will send it in a few.

Thanks,
Mauro

