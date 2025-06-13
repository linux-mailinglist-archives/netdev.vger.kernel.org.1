Return-Path: <netdev+bounces-197548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B9AD91AE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAAB16F890
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A2D1F463A;
	Fri, 13 Jun 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c94WwD+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2A19D08F;
	Fri, 13 Jun 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829332; cv=none; b=Qg5b1vCcM3cgfvAQ2zK4pyJa0VSGylHgUGXz6kpN9tTRytffExcBDoZGFqIkyk6qm3F5VxBZyFerBmbFxI6b4tTk6DyhTybV1PzUTKDnILpllEvj5wTqpdvQ2CPj3MJoDIXiBA8s9IHUf5c66/xITxl3WVr97Mp94cJIUef3wCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829332; c=relaxed/simple;
	bh=zewWVz9OBaB1bQbv1bL1NQdNn0xp5wKBNRoUrIH5RDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMLGCWUBClK61EKCQw2ssU12POBzGvWNVpvR2FAbH+/uA00GN689ZrcS1blY6ho3TK88xMNCilw/4e8vGo+6xHNp+bODXYKS/m5bxE8N6ncTXbMx5XbCGdFIkAylwN5BBeRP5cQ33beci5ULcfl4OY0sQUVyxO/jthC+mNRTOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c94WwD+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AFFC4CEE3;
	Fri, 13 Jun 2025 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749829332;
	bh=zewWVz9OBaB1bQbv1bL1NQdNn0xp5wKBNRoUrIH5RDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c94WwD+JJWKs8yyv3+igkbzlPTOpkGQm3ioCluPpNTsMr8wQ6SucQvqkEjY0ZqzzW
	 3ZaQlqzlbbHklbhU6U6WfkG/94jBAq/m/YI4CjZ7BBil8tGZw1/eo0C7m0pY3X6QpG
	 M1sWB191a1bYcnQXQKTuJ5UZLdEJSt6b5UxTABSgMetVbF/uoKPc8YGk8SNjmZCSGq
	 9+/IUTersjN/xlbV8rx7Sb+iZcMSTJOmu2NLQpTLBQweRNX4AnixwCxWlwJN3oCp91
	 lzuUfDL+R/lsonzi5sHVTF9SSXr2eUNmeLbSw5DBqsqrWtTHjGCkBhJj8JthlnqxTS
	 NeLmGje+wPXUA==
Date: Fri, 13 Jun 2025 17:42:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "Akira Yokosawa" <akiyks@gmail.com>, "Breno Leitao"
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>, "Jan Stancek" <jstancek@redhat.com>, "Marco Elver"
 <elver@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Ruben Wauters"
 <rubenru09@aol.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v2 09/12] docs: sphinx: add a parser template for yaml
 files
Message-ID: <20250613174203.1bcdf4bc@sal.lan>
In-Reply-To: <20250613142644.6497ed9b@foz.lan>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<39789f17215178892544ffc408a4d0d9f4017f37.1749723671.git.mchehab+huawei@kernel.org>
	<m2tt4jnald.fsf@gmail.com>
	<20250613142644.6497ed9b@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 13 Jun 2025 14:26:44 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> > > +
> > > +    supported = ('yaml', 'yml')    
> > 
> > I don't think we need to support the .yml extension.  
> 
> Ok, will drop "yml".

"supported" is not just extensions. It is a list of aliases for the
supported standard (*), like:

    supported = ('rst', 'restructuredtext', 'rest', 'restx', 'rtxt', 'rstx')
    """Aliases this parser supports."""

    (*) see: https://www.sphinx-doc.org/en/master/_modules/docutils/parsers/rst.html

Anyway, I tried with:

	supported = ('yaml')    

but it crashed with:

	sphinx.errors.SphinxError: Source parser for yaml not registered

On my tests, if "supported" set has just one element, it crashes.

On this specific case, this, for instance, works:

    supported = ('yaml', 'foobar')

Anyway, not worth spending too much time on it, as it could be
a bug or a feature at either docutils or sphinx. As we want it to
work with existing versions, I'll keep it as:

	supported = ('yaml', 'yml')    

at the next version.

> > > +def setup(app):
> > > +    """Setup function for the Sphinx extension."""
> > > +
> > > +    # Add YAML parser
> > > +    app.add_source_parser(YamlParser)
> > > +    app.add_source_suffix('.yaml', 'yaml')
> > > +    app.add_source_suffix('.yml', 'yaml')    
> > 
> > No need to support the .yml extension.  

Dropping .yml works here. So, here I'll keep just:

    # Add YAML parser
    app.add_source_parser(YamlParser)
    app.add_source_suffix('.yaml', 'yaml')

Regards,
Mauro


