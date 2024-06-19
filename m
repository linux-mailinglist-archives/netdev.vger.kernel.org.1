Return-Path: <netdev+bounces-104747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D5490E41E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965EB283FC2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87A674E0A;
	Wed, 19 Jun 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXfAjh3N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE36139;
	Wed, 19 Jun 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781177; cv=none; b=VGOV2ixgYnvgzaG7YjdGfM+j0HRqO8D6JZnbIPyyXetU4nK1Sgagio7VkYn19JcCeno6hwepVNU7rS+yXkABar5dnxSdHMh9ki4jvcWysU/TfHh9CDjIB55vw4c4EEfLXzsNJ/0dKpYyrhqPso6ymOhpd1rNgA4ffv3sHVd/SK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781177; c=relaxed/simple;
	bh=1chuFAqYE6dJD49A1FU7iaMclljnN30WPad6vj2dIoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlCN1dUEZLXCVi107Mqk/Antp/0aY01z63zGatevO5OGFYCgeuXIdI1cKyVBM9F6BFq+EhRmV4jGyjxOnYiaDM3P90NnhnjUNKbvvlVovftdkNAr40wCG3nAUVu7Md9rQ1sQq7PXl+iNmwHcKV3QONTv+ViVSSkjvOrKibQdeN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXfAjh3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C80C32786;
	Wed, 19 Jun 2024 07:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718781177;
	bh=1chuFAqYE6dJD49A1FU7iaMclljnN30WPad6vj2dIoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXfAjh3NbnxJNcVD6gM3s1BgEP7eRbGSTbVqml1/XqenyATV3CgMJXIgDPZPvmVfT
	 DN5tWbEE3+obD3s73UTA6vxAIcHz4ACGIyByj3qXAi7go9UMJPvh9AP5kLLqdd/wmv
	 WrKZrIU4kTrG5tU9vUSbgLzlfUOvZ/RJ71CxHz55vebIkcBzjbqGo0Ta+LGhvUMNVt
	 pOG1l3geCyMLLAAe5esg4u/2vwiF352qPtL6CzU7oy4h0VKNh5t7JmlYd7uG0JE5Qa
	 F6nYxxDFBQ0MurmaA4bi8mGAekdcVZME2WFUxP85w/nTMdz9MssaqeZF7JKfUr0c+B
	 vdbVVuVHDyLxg==
Date: Wed, 19 Jun 2024 10:12:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: [PATCH 2/2] Documentation: best practices for using Link trailers
Message-ID: <20240619071251.GI4025@unreal>
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
 <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>

On Tue, Jun 18, 2024 at 12:42:11PM -0400, Konstantin Ryabitsev wrote:
> Based on multiple conversations, most recently on the ksummit mailing
> list [1], add some best practices for using the Link trailer, such as:
> 
> - how to use markdown-like bracketed numbers in the commit message to
> indicate the corresponding link
> - when to use lore.kernel.org vs patch.msgid.link domains
> 
> Cc: ksummit@lists.linux.dev
> Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat # [1]
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
>  Documentation/process/maintainer-tip.rst | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
> index 64739968afa6..57ffa553c21e 100644
> --- a/Documentation/process/maintainer-tip.rst
> +++ b/Documentation/process/maintainer-tip.rst
> @@ -375,14 +375,26 @@ following tag ordering scheme:
>     For referring to an email on LKML or other kernel mailing lists,
>     please use the lore.kernel.org redirector URL::
>  
> -     https://lore.kernel.org/r/email-message@id
> +     Link: https://lore.kernel.org/email-message@id
>  
> -   The kernel.org redirector is considered a stable URL, unlike other email
> -   archives.
> +   This URL should be used when referring to relevant mailing list
> +   resources, related patch sets, or other notable discussion threads.
> +   A convenient way to associate Link trailers with the accompanying
> +   message is to use markdown-like bracketed notation, for example::
>  
> -   Maintainers will add a Link tag referencing the email of the patch
> -   submission when they apply a patch to the tip tree. This tag is useful
> -   for later reference and is also used for commit notifications.
> +     A similar approach was attempted before as part of a different
> +     effort [1], but the initial implementation caused too many
> +     regressions [2], so it was backed out and reimplemented.
> +
> +     Link: https://lore.kernel.org/some-msgid@here # [1]
> +     Link: https://bugzilla.example.org/bug/12345  # [2]
> +
> +   When using the ``Link:`` trailer to indicate the provenance of the
> +   patch, you should use the dedicated ``patch.msgid.link`` domain. This
> +   makes it possible for automated tooling to establish which link leads
> +   to the original patch submission. For example::
> +
> +     Link: https://patch.msgid.link/patch-source-msgid@here

Default b4.linkmask points to https://msgid.link/ and not to https://patch.msgid.link/

https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/.b4-config#n3
https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/docs/config.rst#n46

It will be good to update the default value in b4 to point to the correct domain.

Thanks

