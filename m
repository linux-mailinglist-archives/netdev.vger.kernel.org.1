Return-Path: <netdev+bounces-211360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F0FB18284
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 15:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EEB587154
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF5D231856;
	Fri,  1 Aug 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep7vkVrE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0C22D78F;
	Fri,  1 Aug 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055179; cv=none; b=ZbVYnUxX7i6H3zZOLwrYzGAtHYBtbj5vKjABNmvegkpDMOA97tNUhhzTg4w8VA81KXJLFYIt9/RpBxClPwtdJNmi0qTyXZ/feymixeyvdKwfAHfMNSwxHPAy5Zqcgj+5pbzLCrx5r2RYJAtHJyWqURn38MGlBhja6MUvhIG8qJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055179; c=relaxed/simple;
	bh=qIrQbKlltABNgB9Pqa+YAH5TjC2GEgMe/cjMQfZnjxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siG+h+RNuKF+ZrYVwy5cGfzv6r9ubxJzRULxaiTTwo6CJBcwgNN+Dgign4wjTUEH53zkdsFMLSGlKLWC++NONDtG9qc2nlIEJj3GSGQKPXg/kYRJlzkViQhzZctG25+Og9K7ASwWp8VfhEAYGU0lP+9bLTXMoIWMUfbVi8sZG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep7vkVrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0A2C4CEE7;
	Fri,  1 Aug 2025 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754055178;
	bh=qIrQbKlltABNgB9Pqa+YAH5TjC2GEgMe/cjMQfZnjxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ep7vkVrE3UPPCXL7LAD9DrdMnolRhlMIAg9ii5YmV76Xlm+YUYV2t5VWvqLGsJCYw
	 z9Hb6isdtRbXkVXUdt+2JYq0tZnt9EOLWDge7vskf0j4AJqG63OY3o+BiVTPokx3km
	 TkrvGwU85nlO0RO7NTKs9yHTF6G6Vr3C0Div5ME3aXGkOxttw0Sx16BbhN7Ta+w1cF
	 2XOlZNSR229V1f+j7rzfWPxGlCqUJAnlSGTE5dkKlvAvRXuKxtZDEFXe2kQ1h9vEgY
	 uTWKrT2Jq61gUxX9Zd6VB0F9P7lbIwIa+Iu6iBwdGO5rGLmXN2MjSoORYgaUbKqowx
	 FoRDJZRvsal0Q==
Date: Fri, 1 Aug 2025 15:32:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.17
Message-ID: <20250801-luftschicht-pochen-b060b1536fe1@brauner>
References: <20250727013451.2436467-1-kuba@kernel.org>
 <CAHk-=whnXTvh2b0WcNFyjj7t9SKvbPtF8YueBg=_H5a7j_2yuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whnXTvh2b0WcNFyjj7t9SKvbPtF8YueBg=_H5a7j_2yuA@mail.gmail.com>

On Wed, Jul 30, 2025 at 09:20:46AM -0700, Linus Torvalds wrote:
> On Sat, 26 Jul 2025 at 18:35, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Networking changes for 6.17.
> 
> So while merging this, there was a trivial conflict with commit
> 9b0240b3ccc3 ("netns: use stable inode number for initial mount ns")
> from the vfs side (acked by networking people).
> 
> And the conflict wasn't hard to resolve, but while looking at it, I
> got very unhappy with that conflicting commit from the vfs tree.
> 
> Christian - when the "use stable inode number" code triggers, it
> bypasses ns_alloc_inum() entirely. Fine - except that function *also*
> does that
> 
>         WRITE_ONCE(ns->stashed, NULL);
> 
> so now ns->stashed isn't initialized any more.
> 
> Now, that shouldn't matter here because this only triggers for
> 'init_net' that is a global data structure and thus initialized to all
> zeroes anyway, but it makes me very unhappy about that pattern that
> ends up being about allocating the pid, but also almost incidentally
> initializing that 'stashed' entry.
> 
> I ended up re-organizing the net_ns_net_init() code a bit (because it
> now does that debugfs setup on success, so the old "return 0" didn't
> work), and I think the merge is fine, but I think this "don't call
> ns_alloc_inum()" pattern is wrong.
> 
> IOW, I don't think this is a bug, but I think it's not great.

I think we should not be initializing ns->stashed in ns_alloc_inum().
The function name is already wrong for that purpose:

static inline int ns_alloc_inum(struct ns_common *ns)
{
	WRITE_ONCE(ns->stashed, NULL);
	return proc_alloc_inum(&ns->inum);
}

That was done a long time ago via atomic_long_set() and I just changed
it to WRITE_ONCE() when I reworked both nsfs and pidfs.

We let all callers initialize the fields of struct ns_common embedded in
their respective namespace types already. I see no reason to not just do
the same thing for ns->stashed and drop that implicit initialization
from ns_alloc_inum().

But aside from that I think my patch should have probably been:

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1b6f3826dd0e..5c39fb544f93 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -815,7 +815,6 @@ static __net_init int net_ns_net_init(struct net *net)
 #ifdef CONFIG_NET_NS
        net->ns.ops = &netns_operations;
 #endif
-       net->ns.inum = PROC_NET_INIT_INO;
        if (net != &init_net) {
                int ret = ns_alloc_inum(&net->ns);
                if (ret)
@@ -1283,6 +1282,8 @@ void __init net_ns_init(void)
        init_net.key_domain = &init_net_key_domain;
 #endif
        preinit_net(&init_net, &init_user_ns);
+       init_net.ns.inum = PROC_NET_INIT_INO;
+       init_net.ns.stashed = NULL;

        down_write(&pernet_ops_rwsem);
        if (setup_net(&init_net))

so the setup for the initial network namespce happens right where it is
explicitly initialized.

