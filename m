Return-Path: <netdev+bounces-199721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E91AAE18FD
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A32A176F89
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34D02857CD;
	Fri, 20 Jun 2025 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKgssu6o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73462836BD;
	Fri, 20 Jun 2025 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415595; cv=none; b=d3qavcVdq3tixf+0LZVClpgm5nj5OeUlIjoTFQXi04PPHIiuJf96txSMwC+MVhdejt+cU8xk6zvrv1r0tG/t1Td+hBu0+DN7M/QWSDvEYAIWM0JgBT2IraKezZClQ2Pr9Hpp4wOo+/IRWebE687AsMwMXsc0gJF6CfbwduiCfIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415595; c=relaxed/simple;
	bh=e4Nci4ObCLP/J168AOudxulBu8JAi13G6X2rnZmFmNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNod2RjJqhB1NImObqJVK155VQe5kIRdoCM5mRPbZ+4gZ5ASCcwi9TuPjw6LV4iRsJSePyvONp9Zo45J+ct8n2HtmLPjDex7v0WICzLyuZZmVwfrIpOAaIrn8aT8KDAITzLc4mG67iL6DsgAEFIeBoh8Fy3Six8WQnyebqtwEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKgssu6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FD5C4CEED;
	Fri, 20 Jun 2025 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750415595;
	bh=e4Nci4ObCLP/J168AOudxulBu8JAi13G6X2rnZmFmNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MKgssu6ogl7jUd9OZGxsz+FxvZt/4rCLDZMj5tp2rHSXd9MudHroAioiMqYinUPPx
	 iVkVw2vj3pAONsfaR2QPoojKBYkqqu8yFuBjksjuu5x4/+5BH+6Ui+cIjRh+GkCYmR
	 7w9z/GmA/KLHboWleyI3DfQF8CV9tmkpQGLdpQaEsye5Qimn3gZq/AUfDO5Hrnp9/m
	 m94BWhbGT1ixTe7AcbdEbrzDmVYLu0i8NWPeM7SunppnqZPcs4SZbhm3c3T4dvq6Fo
	 k9eARlAxB/MldRfsQUroH8WSlMNBKGljn0xp1Cz7kh1dnXS2pBwzQQwaTDjyRypCuP
	 yhVCcvmhDGEMw==
Date: Fri, 20 Jun 2025 12:33:04 +0200
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
 Breno Leitao <leitao@debian.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Don't generate netlink .rst files inside
 $(srctree)
Message-ID: <20250620123304.4ab7bb99@sal.lan>
In-Reply-To: <m2y0tof82o.fsf@gmail.com>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
	<m2y0tof82o.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 19 Jun 2025 09:29:19 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >
> > v7:  
> 
> ETOOFAST

Heh, I'm now working on a v8 ;-) I guess I'll send it next
week to give Jon some time to apply the non-related YAML stuff.

> 
> https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review
> 
> I didn't complete reviewing v6 yet :(
> 
> > - Added a patch to cleanup conf.py and address coding style issues;
> > - Added a docutils version check logic to detect known issues when
> >   building the docs with too old or too new docutils version.  The
> >   actuall min/max vesion depends on Sphinx version.  
> 
> It seems to me that patches 15-17 belong in a different series.

Yes. I'm splitting it on two separate series: the first one
with changes that are independent of YAML parser. The
second one with specific stuff. It will depend on the first
one, due to the changes inside Documentation/conf.py that
the first series does.

Regards,
Mauro

