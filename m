Return-Path: <netdev+bounces-105810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71840912F2A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 23:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26B21C217A8
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 21:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3FE17BB01;
	Fri, 21 Jun 2024 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WysC2kJS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C416D311;
	Fri, 21 Jun 2024 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004065; cv=none; b=Y895xR+FwVrXsPDmeuFAlUE/QTAQ3isTfNN1u54rXQxizl4K3YtjfXjYctlFBgoVij4ALe0LjTCsANbg8G0IjHJqlDVMoBpltqpsF6cWE8ULUhFsjb/M41W/M52syrdvw7mnqcaRvlKCjxu6/H/4XqBCzSNR98wETBPb9u9dN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004065; c=relaxed/simple;
	bh=mlhkA/4MVrpRXs1HI2b+DGp6GTNtGbMKN/9ULvKi5bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvcwzs4lM6vncvTmWBOQbMv+m1g0uPSD2w0aGDgdnr2aWjk1pJgnOrvLsALwpk5ijkSqbDRUYLRgP5LasC6KB7jUA8mG6TSMc0Hh2igwPbp0HHeR1k/AAGVuWuv3mG/2CP3nBnHgC8V/eS7l4Tnm49OpAcC2JNgKQ97RAXwDCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WysC2kJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382E5C32789;
	Fri, 21 Jun 2024 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719004065;
	bh=mlhkA/4MVrpRXs1HI2b+DGp6GTNtGbMKN/9ULvKi5bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WysC2kJSiPn0ao/veeI/Pakff6HeD8k3kTgEGbfXsUK3Q3zrVtxCuSX5NWo0i4Nx1
	 VAQZh3ZZzCbQDNZX5i92RwStnoFegvbLYhw6rsdG89WBEni52jsd1d7sR6+WkWoMk/
	 LoJuDgteNNIHcbCeQxeQC16KxDUUvnx7uaKOGHes/2LejhE+j9VwnVpmDjA17Upvtz
	 IarP8qO+06l9Sz3MDZ1DvtDS1TJnTHVHK/iCm7tdo3ixWMGdWbrxDtEWGLATcuJD4T
	 DC0WuRs7shSf0FSm16RT2P1wHtrbOlMWptumKFgvlStGuG9tJrhEj40DoUGI5RV6X+
	 Ox86kzAhnysZg==
Date: Fri, 21 Jun 2024 14:07:44 -0700
From: Kees Cook <kees@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
Message-ID: <202406211355.4AF91C2@keescook>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
 <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>

On Wed, Jun 19, 2024 at 02:24:07PM -0400, Konstantin Ryabitsev wrote:
> +   This URL should be used when referring to relevant mailing list
> +   topics, related patch sets, or other notable discussion threads.
> +   A convenient way to associate ``Link:`` trailers with the commit
> +   message is to use markdown-like bracketed notation, for example::
> ...
> +     Link: https://lore.kernel.org/some-msgid@here # [1]
> +     Link: https://bugzilla.example.org/bug/12345  # [2]

Why are we adding the extra "# " characters? The vast majority of
existing Link tags don't do this:

$ git log --grep Link: | grep 'Link:.*\[' > links.txt
$ wc -l links.txt
1687 links.txt

# Link: URL... [1]
$ grep 'Link: .*[^#] \[' links.txt | wc -l
1546

# Link: URL... # [1]
$ grep 'Link: .* # \[' links.txt | wc -l
83

# Link: [1] URL...
$ grep 'Link: \[' links.txt | wc -l
44

# Link: URL... [#1]
$ grep 'Link: .*\[#' links.txt | wc -l
12


-- 
Kees Cook

