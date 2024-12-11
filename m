Return-Path: <netdev+bounces-150969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B579EC358
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4474D188A2B2
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642B21FCD0B;
	Wed, 11 Dec 2024 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz/mQm9b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389633A8D2;
	Wed, 11 Dec 2024 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887872; cv=none; b=PsmiaWLPbcMES3wsA4mo8XlcCa/JAwsQpl75SqJbIq2yUjLNb9B57vYKfNWTNj4rXP0ERJBr6sUtNJVg4cb5HGMypZsawAEl05GIuHcAoMQvkE4uCoZ+X8ZlXxRVXqr0AkizqClB8rrObgxrGcFLMhl9iQ+B4he+tlu4fZjps4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887872; c=relaxed/simple;
	bh=5IV18YcC5cLxSzU3d7kfwNcRuyfo32UMTMhq8B2l2cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mnqm+kgIrCAvawDEdM1llAGLJ/RRZCyGM7hqMvPdgyih0C+FsNz6hH7t67iS6jLNANvI1IAPnDsZyQchoNf6PRS39Z9fozR8Eid3UNUA17eMj+xGYOfHIzwrq7cfHWC5mtuutLemer+3150hcJPyqDj0cuCA2Zl4dTgOVoRMcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz/mQm9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E310C4CED2;
	Wed, 11 Dec 2024 03:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733887871;
	bh=5IV18YcC5cLxSzU3d7kfwNcRuyfo32UMTMhq8B2l2cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bz/mQm9bXPKYvVTTkepVIEWK8VL2bddKd6ibd5MAD2mOtyLkQ+PqWMGy54c2LN2vz
	 jo1iqZQJRsjZFw5OklcOx6NSXMTfMcyT1Q2S1+c+gRPHzVz7NrMulpGaqoSQs4Jp1z
	 TU6RAvC/dQL2q8Uyl5LDmYJS6oxWgqdTBJbuU1WHL3z3Mu8jf55Nv6y9MJzGcxJutJ
	 /bc+K155F0sDrTBi/EF1Himk6IZMHm1sbJW9UNDDFuL53xse0sTizDHfWceIpZZYR2
	 HDBmmBWZ/eA7AloqMoeFBZC04lLx/N/NaSKENnWqk1o+AWj2lAFTuBlxTp1kODfDSz
	 WLhp4Te8OS9pA==
Date: Tue, 10 Dec 2024 19:31:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, stfomichev@gmail.com, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] tools: ynl: add install target for specs and
 docs
Message-ID: <20241210193110.18ddb9f6@kernel.org>
In-Reply-To: <0271f19ad8f5453d2fea5b0f05648b9c2667d771.1733755068.git.jstancek@redhat.com>
References: <cover.1733755068.git.jstancek@redhat.com>
	<0271f19ad8f5453d2fea5b0f05648b9c2667d771.1733755068.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 15:47:16 +0100 Jan Stancek wrote:
> +SPECS_PATHS=$(wildcard ../../../../Documentation/netlink/specs/*.yaml)

Maybe factor out:

SPECS_DIR := ../../../../Documentation/netlink/specs

? It's pretty long and we repeat it all over the place.

> +SPECS=$(patsubst ../../../../Documentation/netlink/specs/%.yaml,%,${SPECS_PATHS})
> +RSTS=$(patsubst %,%.rst,${SPECS})
> +
> +all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI) $(RSTS)
>  
>  protos.a: $(OBJS)
>  	@echo -e "\tAR $@"
> @@ -40,8 +50,12 @@ protos.a: $(OBJS)
>  	@echo -e "\tCC $@"
>  	@$(COMPILE.c) $(CFLAGS_$*) -o $@ $<
>  
> +%.rst: ../../../../Documentation/netlink/specs/%.yaml $(TOOL2)

TOOL2 -> TOOL_RST ?

> +	@echo -e "\tGEN_RST $@"
> +	@$(TOOL_RST) -o $@ -i $<
> +
>  clean:
> -	rm -f *.o
> +	rm -f *.o *.rst

No strong preference but I'd count .rst as final artifacts so I'd clean
them up in distclean target only, not the clean target. The distinction
itself may be a local custom..

>  distclean: clean
>  	rm -f *.c *.h *.a
> @@ -49,5 +63,19 @@ distclean: clean
>  regen:
>  	@../ynl-regen.sh
>  
> -.PHONY: all clean distclean regen
> +install-rsts:
> +	@echo -e "\tINSTALL generated docs"
> +	@$(INSTALL) -d $(DESTDIR)$(docdir)/ynl
> +	@$(INSTALL) -m 0644 $(RSTS) $(DESTDIR)$(docdir)/ynl/
> +
> +install-specs:
> +	@echo -e "\tINSTALL specs"
> +	@$(INSTALL) -d $(DESTDIR)$(datarootdir)/ynl
> +	@$(INSTALL) -m 0644 ../../../../Documentation/netlink/*.yaml $(DESTDIR)$(datarootdir)/ynl/
> +	@$(INSTALL) -d $(DESTDIR)$(datarootdir)/ynl/specs
> +	@$(INSTALL) -m 0644 ../../../../Documentation/netlink/specs/*.yaml $(DESTDIR)$(datarootdir)/ynl/specs/
> +
> +install: install-rsts install-specs
> +
> +.PHONY: all clean distclean regen install

I think .PHONY needs install-rsts install-specs, too?

>  .DEFAULT_GOAL: all
-- 
pw-bot: cr

