Return-Path: <netdev+bounces-205466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201AAFEDA7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C241887BD1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4632E7BBF;
	Wed,  9 Jul 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikPxL0de"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C91AD21;
	Wed,  9 Jul 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074723; cv=none; b=TTApBaZxS9uVTHwjLcfUM6ez9XCnUouaSVMi9/2Wrn2oRNNZV7nSRx22Ro/ZRChLjM6iulUA/CKLHkFdQAbNK3EVs4ywMws9CyEIDO3vd1830+3KlZeUxxOw3lIYf+5leZyPzXqsbyvDfjbKG5tSynAkOEKpjR8ZEx5q8RZntYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074723; c=relaxed/simple;
	bh=vQvUTZYDPFvJtZWLT3bsD4zVtLOSn/hT6DJD+GszzQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttQoATe+u4t1OHUkQS+bhvmGVoxCnb2+ClWGi7HC9I+O3eFzLIZQI+bvwLmKuAPubA7wZPdusAUNVSmTjXA0ey9WVIhO4JGZCm0WwY6WgIWm+bHaRjAsQvwRYFWJODpN0IfEfnAySZHxJlz6SVBXVi2oY9Qf7lZr3pZBSyA6TNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikPxL0de; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD41C4CEEF;
	Wed,  9 Jul 2025 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752074723;
	bh=vQvUTZYDPFvJtZWLT3bsD4zVtLOSn/hT6DJD+GszzQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ikPxL0deZqTQhV1qx988jIg1WQwS7TiasZUN6jIIG1fVwUWqn2ZJVuNt/sgdArR9x
	 UxkEzZlprVh+dmbrWTTQZzbw3lyjWYJhoJo90HwOFwZ3s7mbZVv3I7SOJDAF7EV5vB
	 RvEHdDUJu9v3HTnQ1AFyv14d6EXfzt9uNAr0qCkQ0a4RlRD+iDRaSK1Xm50YFbM7Fu
	 q+0hWU+fQjdb8P6+jnUjfIvznP8iSqjnTD31hZTq+Dfl90dlaQ5iS+8Wq0CGVc28bG
	 V8XK+76nKHlXpmaiJYYEhwx2pAd8xnVtdIYRYkQm87d9xgvd8ZIBaOdvqyled90aqY
	 wTfFf7ljiNuFw==
Date: Wed, 9 Jul 2025 17:25:10 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "Akira Yokosawa" <akiyks@gmail.com>, "Breno Leitao"
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>, "Jan Stancek" <jstancek@redhat.com>, "Marco Elver"
 <elver@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Ruben Wauters" <rubenru09@aol.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH v8 06/13] docs: use parser_yaml extension to handle
 Netlink specs
Message-ID: <20250709172510.191c116e@sal.lan>
In-Reply-To: <m2wm8x8omf.fsf@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<34e491393347ca1ba6fd65e73a468752b1436a80.1750925410.git.mchehab+huawei@kernel.org>
	<m2wm8x8omf.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 27 Jun 2025 11:28:40 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Instead of manually calling ynl_gen_rst.py, use a Sphinx extension.
> > This way, no .rst files would be written to the Kernel source
> > directories.
> >
> > We are using here a toctree with :glob: property. This way, there
> > is no need to touch the netlink/specs/index.rst file every time
> > a new Netlink spec is added/renamed/removed.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Donald Hunter <donald.hunter@gmail.com>  
> 
> This patch doesn't currently merge in the net-next tree because it
> depends on a series in docs-next.

True. It has to either be applied on docs-next or you need to merge
from it if you want to apply on your tree.

This patch depends at the changes there to properly address 
include_pattern/exclude_pattern.

Regards,
Mauro

