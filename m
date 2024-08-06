Return-Path: <netdev+bounces-116231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E88B94986B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A04A281DF7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EA145A10;
	Tue,  6 Aug 2024 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QBkB615q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FC18D62B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972981; cv=none; b=RWg2kpFv2gPMdSTCg1nWksb+WbiFPHgQhSsHHTQeznbaFHheTvQiravDHtJK8HIls6EZPZ0YWoOp1JlOT2ShJXdiAbFWeYqHsr3pYzLMrZ+Sd0ocUXrXpqpKFQlj/Cm7B86dtw93K6CmGrklaUrFamA5+my3OP/DH0Onwjued4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972981; c=relaxed/simple;
	bh=v4d4+80mx6jjlfhZikgpHEY+3o+j5eVEgAjlHgmbdZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY80azEXWRHOBpHyjmGMH7dR6CMtYZgUlnvhvsHYVLfSKee8bFA1wLyPGXh6NvjUKGSvFzBVp7TbF1NhO+uQvakFHFaIQhhYbT0HHe7ASSMKoJ7cQCqsaHqSmKPdbX6fXg3U033OUfoCDVqB/fsFLUqB1xc84pE4XLnQOAXuAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QBkB615q; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wdk7V04RgzXp2;
	Tue,  6 Aug 2024 21:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1722972965;
	bh=DJDQKI7EFaWtRQD3hkJj60ruguZO5HDctF4hNGbINy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBkB615q7XYvz49XJ84iFt188KRwhpo4QehrZN+r/vOZHTPtAe1CCnNdUOblGrioL
	 fT5co48BQ797iJxJJxwk2a5EKX2uS3IKFQUPP0p4VdriyKwiJorXEvOXCFNQX/rYBB
	 PrRAjt08SxH4+FjU66lXEanOTdLwHqaDd613e27s=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wdk7S4TZfzh6C;
	Tue,  6 Aug 2024 21:36:04 +0200 (CEST)
Date: Tue, 6 Aug 2024 21:35:57 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240806.nookoChoh2Oh@digikod.net>
References: <cover.1722570749.git.fahimitahera@gmail.com>
 <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
 <20240803.iefooCha4gae@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240803.iefooCha4gae@digikod.net>
X-Infomaniak-Routing: alpha

On Sat, Aug 03, 2024 at 01:29:09PM +0200, Mickaël Salaün wrote:
> On Thu, Aug 01, 2024 at 10:02:33PM -0600, Tahera Fahimi wrote:
> > This patch introduces a new "scoped" attribute to the landlock_ruleset_attr
> > that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope
> > abstract Unix sockets from connecting to a process outside of
> > the same landlock domain. It implements two hooks, unix_stream_connect
> > and unix_may_send to enforce this restriction.
> > 
> > Closes: https://github.com/landlock-lsm/linux/issues/7
> > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > 
> > ---
> > v8:
> > - Code refactoring (improve code readability, renaming variable, etc.) based
> >   on reviews by Mickaël Salaün on version 7.
> > - Adding warn_on_once to check (impossible) inconsistencies.
> > - Adding inline comments.
> > - Adding check_unix_address_format to check if the scoping socket is an abstract
> >   unix sockets.
> > v7:
> >  - Using socket's file credentials for both connected(STREAM) and
> >    non-connected(DGRAM) sockets.
> >  - Adding "domain_sock_scope" instead of the domain scoping mechanism used in
> >    ptrace ensures that if a server's domain is accessible from the client's
> >    domain (where the client is more privileged than the server), the client
> >    can connect to the server in all edge cases.
> >  - Removing debug codes.
> > v6:
> >  - Removing curr_ruleset from landlock_hierarchy, and switching back to use
> >    the same domain scoping as ptrace.
> >  - code clean up.
> > v5:
> >  - Renaming "LANDLOCK_*_ACCESS_SCOPE" to "LANDLOCK_*_SCOPE"
> >  - Adding curr_ruleset to hierarachy_ruleset structure to have access from
> >    landlock_hierarchy to its respective landlock_ruleset.
> >  - Using curr_ruleset to check if a domain is scoped while walking in the
> >    hierarchy of domains.
> >  - Modifying inline comments.
> > V4:
> >  - Rebased on Günther's Patch:
> >    https://lore.kernel.org/all/20240610082115.1693267-1-gnoack@google.com/
> >    so there is no need for "LANDLOCK_SHIFT_ACCESS_SCOPE", then it is removed.
> >  - Adding get_scope_accesses function to check all scoped access masks in a ruleset.
> >  - Using socket's file credentials instead of credentials stored in peer_cred
> >    for datagram sockets. (see discussion in [1])
> >  - Modifying inline comments.
> > V3:
> >  - Improving commit description.
> >  - Introducing "scoped" attribute to landlock_ruleset_attr for IPC scoping
> >    purpose, and adding related functions.
> >  - Changing structure of ruleset based on "scoped".
> >  - Removing rcu lock and using unix_sk lock instead.
> >  - Introducing scoping for datagram sockets in unix_may_send.
> > V2:
> >  - Removing wrapper functions
> > 
> > [1]https://lore.kernel.org/all/20240610.Aifee5ingugh@digikod.net/
> > ----
> > ---
> >  include/uapi/linux/landlock.h |  30 +++++++
> >  security/landlock/limits.h    |   3 +
> >  security/landlock/ruleset.c   |   7 +-
> >  security/landlock/ruleset.h   |  23 ++++-
> >  security/landlock/syscalls.c  |  14 ++-
> >  security/landlock/task.c      | 155 ++++++++++++++++++++++++++++++++++
> >  6 files changed, 225 insertions(+), 7 deletions(-)
> 
> > diff --git a/security/landlock/task.c b/security/landlock/task.c
> > index 849f5123610b..7e8579ebae83 100644
> > --- a/security/landlock/task.c
> > +++ b/security/landlock/task.c
> > @@ -13,6 +13,8 @@
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/sched.h>
> > +#include <net/sock.h>
> > +#include <net/af_unix.h>
> >  
> >  #include "common.h"
> >  #include "cred.h"
> > @@ -108,9 +110,162 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
> >  	return task_ptrace(parent, current);
> >  }
> >  
> > +static bool walk_and_check(const struct landlock_ruleset *const child,
> > +			   struct landlock_hierarchy **walker,
> > +			   size_t base_layer, size_t deep_layer,
> > +			   access_mask_t check_scoping)
> 
> s/check_scoping/scope/
> 
> > +{
> > +	if (!child || base_layer < 0 || !(*walker))
> 
> I guess it should be:
> WARN_ON_ONCE(!child || base_layer < 0 || !(*walker))
> 
> > +		return false;
> > +
> > +	for (deep_layer; base_layer < deep_layer; deep_layer--) {
> 
> No need to pass deep_layer as argument:
> deep_layer = child->num_layers - 1
> 
> > +		if (check_scoping & landlock_get_scope_mask(child, deep_layer))
> > +			return false;
> > +		*walker = (*walker)->parent;
> > +		if (WARN_ON_ONCE(!*walker))
> > +			/* there is an inconsistency between num_layers
> 
> Please use full sentences starting with a capital letter and ending with
> a dot, and in this case start with "/*"
> 
> > +			 * and landlock_hierarchy in the ruleset
> > +			 */
> > +			return false;
> > +	}
> > +	return true;
> > +}
> > +
> > +/**
> > + * domain_IPC_scope - Checks if the client domain is scoped in the same
> > + *		      domain as the server.
> 
> Actually, you can remove IPC from the function name.
> 
> > + *
> > + * @client: IPC sender domain.
> > + * @server: IPC receiver domain.
> > + *
> > + * Check if the @client domain is scoped to access the @server; the @server
> > + * must be scoped in the same domain.
> 
> Returns true if...
> 
> > + */
> > +static bool domain_IPC_scope(const struct landlock_ruleset *const client,
> > +			     const struct landlock_ruleset *const server,
> > +			     access_mask_t ipc_type)
> > +{
> > +	size_t client_layer, server_layer = 0;
> > +	int base_layer;
> > +	struct landlock_hierarchy *client_walker, *server_walker;
> > +	bool is_scoped;
> > +
> > +	/* Quick return if client has no domain */
> > +	if (!client)
> > +		return true;
> > +
> > +	client_layer = client->num_layers - 1;
> > +	client_walker = client->hierarchy;
> > +	if (server) {
> > +		server_layer = server->num_layers - 1;
> > +		server_walker = server->hierarchy;
> > +	}
> 
> } else {
> 	server_layer = 0;
> 	server_walker = NULL;
> }
> 
> > +	base_layer = (client_layer > server_layer) ? server_layer :
> > +						     client_layer;
> > +
> > +	/* For client domain, walk_and_check ensures the client domain is
> > +	 * not scoped until gets to base_layer.
> 
> until gets?
> 
> > +	 * For server_domain, it only ensures that the server domain exist.
> > +	 */
> > +	if (client_layer != server_layer) {
> 
> bool is_scoped;
> 
> > +		if (client_layer > server_layer)
> > +			is_scoped = walk_and_check(client, &client_walker,
> > +						   server_layer, client_layer,
> > +						   ipc_type);
> > +		else
> 
> server_walker may be uninitialized and still read here, and maybe later
> in the for loop.  The whole code should maks sure this cannot happen,
> and a test case should check this.
> 
> > +			is_scoped = walk_and_check(server, &server_walker,
> > +						   client_layer, server_layer,
> > +						   ipc_type & 0);
> 
> "ipc_type & 0" is the same as "0"
> 
> > +		if (!is_scoped)
> 
> The name doesn't reflect the semantic. walk_and_check() should return
> the inverse.
> 
> > +			return false;
> > +	}
> 
> This code would be simpler:
> 
> if (client_layer > server_layer) {
> 	base_layer = server_layer;
> 	// TODO: inverse boolean logic
> 	if (!walk_and_check(client, &client_walker,
> 				   base_layer, ipc_type))
> 		return false;
> } else (client_layer < server_layer) {
> 	base_layer = client_layer;
> 	// TODO: inverse boolean logic
> 	if (!walk_and_check(server, &server_walker,
> 				   base_layer, 0))
> 		return false;
> } else {
> 	base_layer = client_layer;
> }
> 
> 
> I think we can improve more to make sure there is no path/risk of
> inconsistent pointers.
> 
> 
> > +	/* client and server are at the same level in hierarchy. If client is
> > +	 * scoped, the server must be scoped in the same domain
> > +	 */
> > +	for (base_layer; base_layer >= 0; base_layer--) {
> > +		if (landlock_get_scope_mask(client, base_layer) & ipc_type) {
> 
> With each multi-line comment, the first line should be empty:
> /*
>  * This check must be here since access would be denied only if
> 
> > +			/* This check must be here since access would be denied only if
> > +			 * the client is scoped and the server has no domain, so
> > +			 * if the client has a domain but is not scoped and the server
> > +			 * has no domain, access is guaranteed.
> > +			 */
> > +			if (!server)
> > +				return false;
> > +
> > +			if (server_walker == client_walker)
> > +				return true;
> > +
> > +			return false;
> > +		}
> > +		client_walker = client_walker->parent;
> > +		server_walker = server_walker->parent;
> > +		/* Warn if there is an incosistenncy between num_layers and
> 
> Makes sure there is no inconsistency between num_layers and
> 
> 
> > +		 * landlock_hierarchy in each of rulesets
> > +		 */
> > +		if (WARN_ON_ONCE(base_layer > 0 &&
> > +				 (!server_walker || !client_walker)))
> > +			return false;
> > +	}
> > +	return true;
> > +}

Here is a refactoring that is easier to read and avoid potential pointer
misuse:

static bool domain_is_scoped(const struct landlock_ruleset *const client,
			     const struct landlock_ruleset *const server,
			     access_mask_t scope)
{
	int client_layer, server_layer;
	struct landlock_hierarchy *client_walker, *server_walker;

	if (WARN_ON_ONCE(!client))
		return false;

	client_layer = client->num_layers - 1;
	client_walker = client->hierarchy;

	/*
	 * client_layer must be a signed integer with greater capacity than
	 * client->num_layers to ensure the following loop stops.
	 */
	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));

	if (!server) {
		/*
		 * Walks client's parent domains and checks that none of these
		 * domains are scoped.
		 */
		for (; client_layer >= 0; client_layer--) {
			if (landlock_get_scope_mask(client, client_layer) &
			    scope)
				return true;
		}
		return false;
	}

	server_layer = server->num_layers - 1;
	server_walker = server->hierarchy;

	/*
	 * Walks client's parent domains down to the same hierarchy level as
	 * the server's domain, and checks that none of these client's parent
	 * domains are scoped.
	 */
	for (; client_layer > server_layer; client_layer--) {
		if (landlock_get_scope_mask(client, client_layer) & scope)
			return true;

		client_walker = client_walker->parent;
	}

	/*
	 * Walks server's parent domains down to the same hierarchy level as
	 * the client's domain.
	 */
	for (; server_layer > client_layer; server_layer--)
		server_walker = server_walker->parent;

	for (; client_layer >= 0; client_layer--) {
		if (landlock_get_scope_mask(client, client_layer) & scope) {
			/*
			 * Client and server are at the same level in the
			 * hierarchy.  If the client is scoped, the request is
			 * only allowed if this domain is also a server's
			 * ancestor.
			 */
			if (server_walker == client_walker)
				return false;

			return true;
		}
		client_walker = client_walker->parent;
		server_walker = server_walker->parent;
	}
	return false;
}

