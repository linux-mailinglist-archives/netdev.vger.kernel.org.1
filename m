Return-Path: <netdev+bounces-106677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E0917366
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013E01F22C0C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F6017C7DE;
	Tue, 25 Jun 2024 21:27:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFF145FEB;
	Tue, 25 Jun 2024 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350850; cv=none; b=ijtpYuIhXMJtT8GC38Mw8JoUO3uj/jFDqFeDULBAWHR0cRP81LUesdhkbkzITcnLsmOCLWMHqOZTy1OPp8viyjosaJ1mkm3sGi1bVRdTISk1nti1c0az9me+7jgZ2xQrLUEiWXwpeNgaBf44RGQpgULvydEklDpNdzNoDTvOdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350850; c=relaxed/simple;
	bh=Mnk6eHE9OhQhHiuBtUICogEcEiSQ4Mx1OmMu4IAH1n4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHU9HbBjSXGzqeai0RqFkGATp7B+seJmjcuK30lkVod7nc5GqzMlnvd+xCXmNBnXgvxdt4s12QtEeOEo5CmoDH/03JiBjm4p05dCONFMhK4vd65aW/Rx8xoRRuFhION+gfjm0SdK6eqDaiTO73ftB7qKDjFmwFAalf9V4ph8Aj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1074C32781;
	Tue, 25 Jun 2024 21:27:28 +0000 (UTC)
Date: Tue, 25 Jun 2024 17:27:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Carlos Bilbao
 <carlos.bilbao.osdev@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: [PATCH 2/2] Documentation: best practices for using Link
 trailers
Message-ID: <20240625172727.3dd2ad67@rorschach.local.home>
In-Reply-To: <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
	<20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 12:42:11 -0400
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

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

Hmm, I mentioned this in the other thread, but I also like the fact
that my automated script uses the list that it was Cc'd to. That is, if
it Cc'd linux-trace-kernel, if not, if it Cc'd linux-trace-devel, it
adds that, otherwise it uses lkml. Now, I could just make the lkml use
the patch-source-msgid instead.

This does give me some information about what the focus of the patch
was. Hmm, maybe I could just make it:

  Link: https://patch.msgid.link/patch-source-msgid@here # linux-trace-devel

Would anyone have an issue with that?

-- Steve


>  
>  Please do not use combined tags, e.g. ``Reported-and-tested-by``, as
>  they just complicate automated extraction of tags.
> 


