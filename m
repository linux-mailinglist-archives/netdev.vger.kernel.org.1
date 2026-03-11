Return-Path: <netdev+bounces-266634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIdtBMZhsWl/uQIAu9opvQ
	(envelope-from <netdev+bounces-266634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:36:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A8263AA5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE7E4301B903
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BE2E040E;
	Wed, 11 Mar 2026 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm+bPJvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107AF2E7BB6
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232495; cv=none; b=k0UgbcBTe1dE/9MCT3AbrPFCbIkPMT2Czx7HUDn4mynV/9LvzztRJjeg9nPzoMbNH6sSDA55WyJucLozLbajSqGL7eYHsF9Wy6l0wQWa/wyl6baHCR4YZPQPUGg3GUchvc7BvHCN8KZuVEzCILmAfogNzMFSHchUZAImajkEuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232495; c=relaxed/simple;
	bh=4V/FLewYp4qpRJBMOlrGqYSXJ1bd8KpRc1fnh/8a82k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aavsvE6ZgWYHgQAVzJXO+3uHBKeANIJJ1c5IxptltAy2AUXEsCgho1SHIMl7cwWuWXVf7T/17hQNsgEgsXwwnKSm0Bd3pKpoojxlupizFwyCWJvHZqXcfZ+sy1D+LQZSea0bP3l9SiivetaiMAuXd78ufkulLJS8tKqmKuSQep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm+bPJvJ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79827d28fc4so130601627b3.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773232493; x=1773837293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bCTlsnYg7WlwyrXb9b++ZpE0INNBNp3LJgQh0I5kfE=;
        b=jm+bPJvJ5zE2Z91Qq6YgMknCJiN7F3XLqlJmdlKcxF+NQ1GMTxvoidhTjcGBunBYG+
         zt0aTPC93/9syrgsO7ND4e0Aluc+WxOTkyrhxpOKdLNbf0JYEukfjxaTwF/d//qGQWfa
         5AvOAPMumKKLvg0nV+LqEqqVoban4aJPfUe1nfmK1sRZwko3ylLAVpdeuZY6McH9GA86
         OYN+YDyQdWBOHCucTV1WO7Tl725BPnVGhtVQV26kRv/uGanJV1OeKAKWltGxXbMbm6Sq
         3W3E/xf7wmD4GKNC9Jzbd7HRHEIVpXmc8t/8xaptpFZNcnTvN0UFvkJOm7/UEqJlcE2F
         z2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232493; x=1773837293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bCTlsnYg7WlwyrXb9b++ZpE0INNBNp3LJgQh0I5kfE=;
        b=gvjNXVkP+36IyPzjNQvdtapQNvXBe3LiehdgK0nNbiFGkySH1dTXxj/igiTiOn9ebY
         570KJyot4zsXjephCNXaNYs6gp7zH8JX3vNP9cxIWXC8oCg2zapaX8NP1nJqCjbAEepq
         cC530Udo2zzPqUqhVtrbIPraoD0YaJuzZbisJwtvWg0R9f8d1fDDujSjsr3A1csmm5h5
         VJQoH86lca7aReSSNNY5HOI/iN/BCMIn0ZQe01q2g3/E6yphZXWzGVELta2oORnx3BHC
         QIVVhFpZ29JII6N3KAniOObuHJGw6qAB5zfEcXubltWBxKCOAai3akPv/33ijoRydyUR
         eCKg==
X-Forwarded-Encrypted: i=1; AJvYcCWy4+XUMW7mPkXQli4jSsHigcbeXyqXL6k16D3pyFw/En6bnN5NsaLIW9/szg7GixY6ag/iL40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVyruM3/pp2MliTogXc5jINsu9hz+rGyNG8jcqsvmh1X2NcKqy
	oTetouCxtifGgHX/iDlOLT0/H08bjouJXsVg7krGN51kk3na8rsRQaTK
X-Gm-Gg: ATEYQzyDe+8xkiehEPaA7eQUT5z8EAME15JsRQ6PncsTMKESNhRXTYAk3s/bxuACCJj
	E6m4mTS5n0OwIQcPfUUvtuoGJ23bPWd90Lz9sPqetpXPpQXy03kD1gKht6co9KQX0pgOe9sa6oy
	XVafMGlccyysGOrPppYYYfQFp2FZijZh3mg2rYmI3K9PRSvRNsxnMMEgM90XTBiOYHqKOSeeSXN
	zef+vrn7v+Y4Jfe+iiG9rAEK+8TgH/pn6qkQqbcpgd5oREvTjEbbHXf4FRgHKEPb/kZ1dW2s0GN
	8gxrbmADUJPRd/AmR4RDsmhoAuwgNnX0GFbgl5RyPhGdSDoZIx3FQtDxcKm5+zOhsbIykC9hyx2
	MLqnGF/Uqzu5vSFWBLAnPUZn4sjSbukukHeNTNAO9iks90mxwhmMuUlKHmHcdxl82Y9IDtDva2z
	lGg2G+ZHmnm4vBs2KbWrLM2BiIOBv5
X-Received: by 2002:a05:690c:6c8d:b0:785:cecb:4b19 with SMTP id 00721157ae682-79917e8baeamr20238127b3.5.1773232492914;
        Wed, 11 Mar 2026 05:34:52 -0700 (PDT)
Received: from suesslenovo ([129.222.85.110])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917ee4feasm12115467b3.30.2026.03.11.05.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:34:52 -0700 (PDT)
Date: Wed, 11 Mar 2026 08:34:51 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	brauner@kernel.org, demiobenour@gmail.com, fahimitahera@gmail.com,
	hi@alyssa.is, horms@kernel.org, ivanov.mikhail1@huawei-partners.com,
	jannh@google.com, jmorris@namei.org, john.johansen@canonical.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	matthieu@buffet.re, mic@digikod.net, netdev@vger.kernel.org,
	samasth.norway.ananda@oracle.com, serge@hallyn.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
Message-ID: <abFhawSTjNoa-KaH@suesslenovo>
References: <aZcPd3OKqxwCZV-5@suesslenovo>
 <20260219200459.1474232-1-utilityemal77@gmail.com>
 <20260219.de5dc35ec231@gnoack.org>
 <CAHC9VhSu=YtE0dMiEtUQgz0pFy5K8cuHh_EWprNtFTDAxhss_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSu=YtE0dMiEtUQgz0pFy5K8cuHh_EWprNtFTDAxhss_w@mail.gmail.com>
X-Rspamd-Queue-Id: 672A8263AA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266634-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,digikod.net,oracle.com,hallyn.com,zeniv.linux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[utilityemal77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,maowtm.org:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 06:39:12PM -0400, Paul Moore wrote:
> On Thu, Feb 19, 2026 at 3:26 PM Günther Noack <gnoack3000@gmail.com> wrote:
> > On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> > > Add a LSM hook security_unix_find.
> > >
> > > This hook is called to check the path of a named unix socket before a
> > > connection is initiated. The peer socket may be inspected as well.
> > >
> > > Why existing hooks are unsuitable:
> > >
> > > Existing socket hooks, security_unix_stream_connect(),
> > > security_unix_may_send(), and security_socket_connect() don't provide
> > > TOCTOU-free / namespace independent access to the paths of sockets.
> > >
> > > (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> > > This requires another path lookup. A change in the path between the
> > > two lookups will cause a TOCTOU bug.
> > >
> > > (2) We cannot use the struct path from the listening socket, because it
> > > may be bound to a path in a different namespace than the caller,
> > > resulting in a path that cannot be referenced at policy creation time.
> > >
> > > Cc: Günther Noack <gnoack3000@gmail.com>
> > > Cc: Tingmao Wang <m@maowtm.org>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  5 +++++
> > >  include/linux/security.h      | 11 +++++++++++
> > >  net/unix/af_unix.c            | 13 ++++++++++---
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 46 insertions(+), 3 deletions(-)
> 
> ...
> 
> > Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> >
> > Thank you, this looks good. I'll include it in the next version of the
> > Unix connect patch set again.
> 
> I'm looking for this patchset to review/ACK the new hook in context,
> but I'm not seeing it in my inbox or lore.  Did I simply miss the
> patchset or is it still a work in progress?  No worries if it hasn't
> been posted yet, I just wanted to make sure I wasn't holding this up
> any more than I already may have :)
>
Good Morning Paul,

Can't speak to the rest of the patch, but I sent this LSM hook for
review purposes before inclusion with the rest of the V6 of this patch.

Günther added his review tag, but I was asked to make some minor comment / commit
message updates. I sent the same patch, with updated comments/commit to him
in a follow up, off-list email to avoid spamming the list. No code changes were
made, just comments.

I don't think this particular patch will change substantially, unless we find
something unexpected. But the way we use the hook may change (esp wrt to
locking and the SOCK_DEAD state), which is important for your review.

So you may want to hold off your review until the full V6 series gets sent so
you can review the hook in context. There were some questions about
locking that needed proper digging into. [1]

Thank you for your time.

Justin

[1]: https://lore.kernel.org/linux-security-module/20260220.82a8adda6f95@gnoack.org/

> -- 
> paul-moore.com

