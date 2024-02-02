Return-Path: <netdev+bounces-68581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721E384749C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E33B2916C4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873CE145B07;
	Fri,  2 Feb 2024 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEfSM85R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5D1474C1
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891040; cv=none; b=aL1aMmyb5zEFs67SMOy2hBNxmJZOWco0X+Ls50+Bta3wo1RS8DKpreyG/4Wf4B44FWou1DMs9+6HGoxJLnlW9xovp4Y21JB23JH2wRsLvHtvJcUnKlww9gr4O5i7nhrcvEIMKwyGcV9VY3gyU2jJeMq/2ZQQYQiFK0k7Vy9FfKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891040; c=relaxed/simple;
	bh=A4cjklZ1Oqe0cilrN2NQCkymwAfXc1h9dP9hoDDFxnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mESLnR8S54ikA9TnGtQLdUC4dpybjKBsVyWQpCnNjjUAkEGjCvvFsrChpRc9RZWUTMF35azfLZu5JLk0EHVIlbVSbKHskvvEvKm4YMJxQHR+T9Ckb0rwhGnIvfSGxfsuKg925RngXYvlR9sL4riqzaYSqxn5fYY0Y0Tql408uWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEfSM85R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBFBC433F1;
	Fri,  2 Feb 2024 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891039;
	bh=A4cjklZ1Oqe0cilrN2NQCkymwAfXc1h9dP9hoDDFxnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WEfSM85R+d7xZ5riYUuVyXqMI65LXEM6M7JRgPyYDX29lEKv4RWYS+JZb86O1LULH
	 /GJtdH7NcFvj08hVrmwO2q4dbaZSpdYLDMrjiP3RpCd5VKziKgyHqDaHzR95cmJHH6
	 hprHYV2z0VimLWvUG1VsAFyHg50c7XmG75g1g+kZ8ce8SEnUhTOuaAOk1eHJmbI0D2
	 slUYhFYRP3LBS01J98LwSZZZuI10JwWv3PTVRneKmf4mwV1PbaBpTkdKo8To6VlVNk
	 8FYq73HS+zzkJYUXKty3YxKZv9MepgtwIqpiAhBOkMJUKqQ9jCRI3AY2+srN8N9f5L
	 qOAUYOAJkybOA==
Date: Fri, 2 Feb 2024 08:23:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger
 <stephen@networkplumber.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] net/sched: netem: use extack
Message-ID: <20240202082358.1f2fd8ec@kernel.org>
In-Reply-To: <m2bk8zulpb.fsf@gmail.com>
References: <20240201034653.450138-1-stephen@networkplumber.org>
	<20240201034653.450138-2-stephen@networkplumber.org>
	<Zbtks__SZIgoDTaj@nanopsycho>
	<20240201090046.1b93bcbd@kernel.org>
	<m2bk8zulpb.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Feb 2024 11:53:04 +0000 Donald Hunter wrote:
> > Looks like most sch's require opt. Would it be a bad idea to pull 
> > the check out to the caller? Minor simplification, plus the caller
> > has the outer message so they can use NL_SET_ERR_ATTR_MISS() and
> > friends.  
> 
> There's also these which maybe complicates things:
> 
> $ git grep -A1 'if (opt == NULL)' -- net/sched/
> net/sched/cls_flow.c:   if (opt == NULL)
> net/sched/cls_flow.c-           return -EINVAL;
> --
> net/sched/sch_choke.c:  if (opt == NULL)
> net/sched/sch_choke.c-          return -EINVAL;
> --
> net/sched/sch_fifo.c:   if (opt == NULL) {
> net/sched/sch_fifo.c-           u32 limit = qdisc_dev(sch)->tx_queue_len;
> --
> net/sched/sch_hfsc.c:   if (opt == NULL)
> net/sched/sch_hfsc.c-           return -EINVAL;
> --
> net/sched/sch_plug.c:   if (opt == NULL) {
> net/sched/sch_plug.c-           q->limit = qdisc_dev(sch)->tx_queue_len

That's fine, I was thinking opt-in. Add a bit to ops that says
"init_requires_opts" or whatnot. 

> I'm in favour of qdisc specific extack messages.

Most of them just say "$name requires options" in a more or less concise
and more or less well spelled form :( Even if we don't want to depend
purely on ATTR_MISS - extack messages support printf now, and we have
the qdisc name in the ops (ops->id), so we can printf the same string 
in the core.

Just an idea, if you all prefer to keep things as they are, that's fine.
But we've been sprinkling the damn string messages throughout TC for
years now, and still they keep coming and still if you step one foot
away from the most actively developed actions and classifiers, you're
back in the 90s :( 

