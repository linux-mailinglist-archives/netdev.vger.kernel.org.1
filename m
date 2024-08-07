Return-Path: <netdev+bounces-116570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE69F94AF7F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 20:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78899283D81
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7518EBF;
	Wed,  7 Aug 2024 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vK+s93Bm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3F142915
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054624; cv=none; b=N40TZKr9J1jgWUgE4tQ0ZcFTy0s+48lggQt4PEeTKui6TjviTg6DGfjFBXn9vUEtcUH0Mnae0XsZ37fPOqeg5SL1NO21l2AY2kEDTvT6c8/b2ttX2ePtDmvB6PJb38rEjxga7TSYnGaKQW6HfuRJPrZgJbx8Noh4KsXEimyO4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054624; c=relaxed/simple;
	bh=t0UbQCNoIRW1BDPtlmscIk4bNj5SvbNJmJAQ2vzhIc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFi/HywQhIX5QbW2FJjeptTJuflh+7yU4UmYwsjFD3BVZ6qe//T6H98Iqc7SOLQtB8T+3ppgfDbLN+eL95jmiAp4ELFxURlWkSN/6dfw9JotWLCWEAIqXL8afYA0y2FEeZwWvcMBalQKP0lpNvw/GDjphcL+qhJqngYmXoUjLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vK+s93Bm; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WfJKd1mlCzktY;
	Wed,  7 Aug 2024 20:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723054613;
	bh=e4v4cHOXu3daGmidLDolI+XJc3ecJMkNhgA4af0TWPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vK+s93BmP2oAOoj2R9uGVJ7Br4v+ZNBu36lRhvJPJET0Y85vV2KMDzm/WEfoA9Urc
	 ZrkUXZlJobyUnFsDFM8Zxc07xn6rO9p1lPqc0RhQtDBet2XsN12CPuGDP9ebGpoxuu
	 fv+ETOOBKBQraJiyFD8Oc0StWnt68JlhkUcw9wxI=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WfJKb6kN3zr9f;
	Wed,  7 Aug 2024 20:16:51 +0200 (CEST)
Date: Wed, 7 Aug 2024 20:16:47 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, 
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
Message-ID: <20240807.Yee4al2lahCo@digikod.net>
References: <cover.1722966592.git.fahimitahera@gmail.com>
 <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Aug 06, 2024 at 11:55:27PM +0200, Jann Horn wrote:
> On Tue, Aug 6, 2024 at 8:56 PM Jann Horn <jannh@google.com> wrote:
> > On Tue, Aug 6, 2024 at 8:11 PM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > > Currently, a sandbox process is not restricted to send a signal
> > > (e.g. SIGKILL) to a process outside of the sandbox environment.
> > > Ability to sending a signal for a sandboxed process should be
> > > scoped the same way abstract unix sockets are scoped. Therefore,
> > > we extend "scoped" field in a ruleset with
> > > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> > > sending any signal from within a sandbox process to its
> > > parent(i.e. any parent sandbox or non-sandboxed procsses).
> [...]
> > > +       if (is_scoped)
> > > +               return 0;
> > > +
> > > +       return -EPERM;
> > > +}
> > > +
> > > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > > +                                   struct fown_struct *fown, int signum)

I was wondering if we should handle this case, but I guess it makes
sense to have a consistent policy for all kind of user-triggerable
signals.

> > > +{
> > > +       bool is_scoped;
> > > +       const struct landlock_ruleset *dom, *target_dom;
> > > +       struct task_struct *result = get_pid_task(fown->pid, fown->pid_type);
> >
> > I'm not an expert on how the fowner stuff works, but I think this will
> > probably give you "result = NULL" if the file owner PID has already
> > exited, and then the following landlock_get_task_domain() would
> > probably crash? But I'm not entirely sure about how this works.
> >
> > I think the intended way to use this hook would be to instead use the
> > "file_set_fowner" hook to record the owning domain (though the setup
> > for that is going to be kind of a pain...), see the Smack and SELinux
> > definitions of that hook. Or alternatively maybe it would be even
> > nicer to change the fown_struct to record a cred* instead of a uid and
> > euid and then use the domain from those credentials for this hook...
> > I'm not sure which of those would be easier.
> 
> (For what it's worth, I think the first option would probably be
> easier to implement and ship for now, since you can basically copy
> what Smack and SELinux are already doing in their implementations of
> these hooks. I think the second option would theoretically result in
> nicer code, but it might require a bit more work, and you'd have to
> include the maintainers of the file locking code in the review of such
> refactoring and have them approve those changes. So if you want to get
> this patchset into the kernel quickly, the first option might be
> better for now?)
> 

I agree, let's extend landlock_file_security with a new "fown" pointer
to a Landlock domain. We'll need to call landlock_get_ruleset() in
hook_file_send_sigiotask(), and landlock_put_ruleset() in a new
hook_file_free_security().

I would be nice to to replace the redundant informations in fown_struct
but that can wait.

