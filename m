Return-Path: <netdev+bounces-198925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79E9ADE567
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5958F7AA9E2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260827EFF3;
	Wed, 18 Jun 2025 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/8DVKLk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03AC214814;
	Wed, 18 Jun 2025 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234873; cv=none; b=E/jTnzzbieG2QqC2OoPEskDoiTIYlRleJ+/GtnXFJPgQtCxw7xR4l7lromXdjNCpBNZkrKNWQeP6sbiXof77Q2IYqMptp5PeJh3hDJ/v5dxjopv+rhv3vI20OlaWMkxFKBHquahZiz+fACJPZ2n5HBKCRmksNVIJiqxS+3KDdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234873; c=relaxed/simple;
	bh=2jmRDv6D0zcNdU19DqnV2thTGn3pGjWksLXvn5+PggA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIxG1mCQFyYEjQRcfPTg/Dmsa6RMHyVdBKGBdLqQA34ds6IiHpeXVLlbnWJ2JWIRfoHng1StG3vwyqhdIvAe0mYaGfG52b+CNbfL+ZjkWllvNTJn4VnhMtKZ1nrCZsRRGEhPMOJ/EVdOnF/FecOKI8iL2MC49eA2nyshcEWu+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/8DVKLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C3DC4CEE7;
	Wed, 18 Jun 2025 08:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750234872;
	bh=2jmRDv6D0zcNdU19DqnV2thTGn3pGjWksLXvn5+PggA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k/8DVKLk1jQCHbK1h5bINp41EjysKV48pO7nmzXin8chccf5giyGW2oCA3VuU0giN
	 GE+ZhpHpRgFhdmQb4oW+ZEPGWmcXzooJXo5+M75ZzRQGSsGWJkUyByTJvgA8tZn4uu
	 QJmGRRd9Z6dJkj2jAaSkiKF++lcEPaaucfGzCiCuD6md9NQIVlmtEt2eg7D+vSkO20
	 QEUu9jve94s9HsY7VtopXIwUmkP8mmoF8Fq4Qf39ztPsBUWr8VEWcr9T9yvtz6VLoq
	 MEXwkiwKj+ODQh0UIlUd033KTyYFAlpqcenVq8DQ3meW7GKSE+FC68bVBqqhECR/e2
	 jI1ND8WMXcbsA==
Date: Wed, 18 Jun 2025 10:21:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>, Breno Leitao
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Ignacio Encinas Rubio <ignacio@iencinas.com>, Jan
 Stancek <jstancek@redhat.com>, Marco Elver <elver@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>, Shuah Khan
 <skhan@linuxfoundation.org>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH v5 10/15] docs: sphinx: add a parser for yaml files for
 Netlink specs
Message-ID: <20250618102105.66ce01f0@foz.lan>
In-Reply-To: <CAD4GDZzWMoxnatNXYbKOphzVZ4NyedD5FtjxF7cgB1ad-wDFWg@mail.gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<c407d769c9f47083e8f411c13989522e32262562.1750146719.git.mchehab+huawei@kernel.org>
	<m27c1ak0k9.fsf@gmail.com>
	<20250617154049.104ef6ff@sal.lan>
	<20250617180001.46931ba9@sal.lan>
	<CAD4GDZzWMoxnatNXYbKOphzVZ4NyedD5FtjxF7cgB1ad-wDFWg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 17 Jun 2025 18:23:22 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> On Tue, 17 Jun 2025 at 17:00, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> > >
> > > (2) is cleaner and faster, but (1) is easier to implement on an
> > > already-existing code.  
> >
> > The logic below implements (1). This seems to be the easiest way for
> > pyyaml. I will submit as 2 separate patches at the end of the next
> > version.
> >
> > Please notice that I didn't check yet for the "quality" of the
> > line numbers. Some tweaks could be needed later on.  
> 
> Thanks for working on this. I suppose we might be able to work on an
> evolution from (1) to (2) in a followup piece of work?

Yes, it shouldn't be hard for you to migrate to (2) in the future. 

Currently, the parser is stateless, but, as there's now a class,
IMO the best would be to store the lines as an array of tuples
inside the YnlDocGenerator class, like this:

	self.lines = [
		(line_number1, message_string1),
		(line_number2, message_string2),
		(line_number3, message_string3),
		(line_number4, message_string4),
		...
	]

This way, the parse_yaml_file() method would just return self.lines.

Thanks,
Mauro

