Return-Path: <netdev+bounces-116352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59194A190
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671E328646E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 07:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC7F1C7B81;
	Wed,  7 Aug 2024 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="o3yBmlWr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582911C4601
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015278; cv=none; b=mbS67btYOkUWrkJ7h5/Lt4p8gMClhH88wAvoAZLy/J4XHZcZ5bVW2Hz8mhC2yJ9UmvKrZgDVVlZ9VQAEuX/GRP86CebYHyu/MWzU2BizlmGUDsfWYHGoxDjj0VoKhD3zOBS59gaUgNXcpdKrxflVgLir4DZhMUlptPevKsFzLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015278; c=relaxed/simple;
	bh=7GiOD3hAA5u3pX+4hiB33+FC3gICUOjC8VXRM5Uh38Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+lmmDpfncWzVzzZIapsimwN5IRFRt8ko12SQr8eCxDEbScXnGq7dno4x318Pebubi0i2KckyEshcoLuPOturcfGgsmd9xtx0GkXp4Dd/yU20Xx7eBJJXmEIXk74FTBs/njyu1Cx//o/pUzNkPlzu1nqcnRUMytfqR8afvfYtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=o3yBmlWr; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wf1n1016jzp2P;
	Wed,  7 Aug 2024 09:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723015268;
	bh=f6mO+1q8PwKecFRsqn5TluZM5OL5Ouz6M2O6XTeSBls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3yBmlWrwUnT0/LpaGMbiFtkJP2TpwalO8gphuckK1ZkYcx9S0LKPI4lQLomvEdkL
	 hSYynCxLoo/r8IBdxaiezxyjBCDV8sn/X0F5JW3aXA66vUECSy7abj+h0wWwAsHRA2
	 SNHkthlv+ufZKpD+iuoTytOUDo5waLHu+UGwYy50=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wf1mz65nKzF6C;
	Wed,  7 Aug 2024 09:21:07 +0200 (CEST)
Date: Wed, 7 Aug 2024 09:21:03 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, 
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240807.mieloh8bi8Ae@digikod.net>
References: <cover.1722570749.git.fahimitahera@gmail.com>
 <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
 <20240803.iefooCha4gae@digikod.net>
 <20240806.nookoChoh2Oh@digikod.net>
 <CAG48ez2ZYzB+GyDLAx7y2TobE=MLXWucQx0qjitfhPSDaaqjiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2ZYzB+GyDLAx7y2TobE=MLXWucQx0qjitfhPSDaaqjiA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Aug 06, 2024 at 10:46:43PM +0200, Jann Horn wrote:
> On Tue, Aug 6, 2024 at 9:36 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On Sat, Aug 03, 2024 at 01:29:09PM +0200, Mickaël Salaün wrote:
> > > On Thu, Aug 01, 2024 at 10:02:33PM -0600, Tahera Fahimi wrote:
> > > > This patch introduces a new "scoped" attribute to the landlock_ruleset_attr
> > > > that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope
> > > > abstract Unix sockets from connecting to a process outside of
> > > > the same landlock domain. It implements two hooks, unix_stream_connect
> > > > and unix_may_send to enforce this restriction.
> [...]
> > Here is a refactoring that is easier to read and avoid potential pointer
> > misuse:
> >
> > static bool domain_is_scoped(const struct landlock_ruleset *const client,
> >                              const struct landlock_ruleset *const server,
> >                              access_mask_t scope)
> > {
> >         int client_layer, server_layer;
> >         struct landlock_hierarchy *client_walker, *server_walker;
> >
> >         if (WARN_ON_ONCE(!client))
> >                 return false;
> >
> >         client_layer = client->num_layers - 1;
> >         client_walker = client->hierarchy;
> >
> >         /*
> >          * client_layer must be a signed integer with greater capacity than
> >          * client->num_layers to ensure the following loop stops.
> >          */
> >         BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> >
> >         if (!server) {
> >                 /*
> >                  * Walks client's parent domains and checks that none of these
> >                  * domains are scoped.
> >                  */
> >                 for (; client_layer >= 0; client_layer--) {
> >                         if (landlock_get_scope_mask(client, client_layer) &
> >                             scope)
> >                                 return true;
> >                 }
> >                 return false;
> >         }
> >
> >         server_layer = server->num_layers - 1;
> >         server_walker = server->hierarchy;
> >
> >         /*
> >          * Walks client's parent domains down to the same hierarchy level as
> >          * the server's domain, and checks that none of these client's parent
> >          * domains are scoped.
> >          */
> >         for (; client_layer > server_layer; client_layer--) {
> >                 if (landlock_get_scope_mask(client, client_layer) & scope)
> >                         return true;
> >
> >                 client_walker = client_walker->parent;
> >         }
> >
> >         /*
> >          * Walks server's parent domains down to the same hierarchy level as
> >          * the client's domain.
> >          */
> >         for (; server_layer > client_layer; server_layer--)
> >                 server_walker = server_walker->parent;
> >
> >         for (; client_layer >= 0; client_layer--) {
> >                 if (landlock_get_scope_mask(client, client_layer) & scope) {
> >                         /*
> >                          * Client and server are at the same level in the
> >                          * hierarchy.  If the client is scoped, the request is
> >                          * only allowed if this domain is also a server's
> >                          * ancestor.
> >                          */

We can move this comment before the if and...

> >                         if (server_walker == client_walker)
> >                                 return false;
> >
> >                         return true;

...add this without the curly braces:

return server_walker != client_walker;

> >                 }
> >                 client_walker = client_walker->parent;
> >                 server_walker = server_walker->parent;
> >         }
> >         return false;
> > }
> 
> I think adding something like this change on top of your code would
> make it more concise (though this is entirely untested):
> 
> --- /tmp/a      2024-08-06 22:37:33.800158308 +0200
> +++ /tmp/b      2024-08-06 22:44:49.539314039 +0200
> @@ -15,25 +15,12 @@
>           * client_layer must be a signed integer with greater capacity than
>           * client->num_layers to ensure the following loop stops.
>           */
>          BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> 
> -        if (!server) {
> -                /*
> -                 * Walks client's parent domains and checks that none of these
> -                 * domains are scoped.
> -                 */
> -                for (; client_layer >= 0; client_layer--) {
> -                        if (landlock_get_scope_mask(client, client_layer) &
> -                            scope)
> -                                return true;
> -                }
> -                return false;
> -        }

This loop is redundant with the following one, but it makes sure there
is no issue nor inconsistencies with the server or server_walker
pointers.  That's the only approach I found to make sure we don't go
through a path that could use an incorrect pointer, and makes the code
easy to review.

> -
> -        server_layer = server->num_layers - 1;
> -        server_walker = server->hierarchy;
> +        server_layer = server ? (server->num_layers - 1) : -1;
> +        server_walker = server ? server->hierarchy : NULL;

We would need to change the last loop to avoid a null pointer deref.

> 
>          /*
>           * Walks client's parent domains down to the same hierarchy level as
>           * the server's domain, and checks that none of these client's parent
>           * domains are scoped.
> 

