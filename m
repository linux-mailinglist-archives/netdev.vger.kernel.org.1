Return-Path: <netdev+bounces-285359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCtLCN+k/Gl2SQAAu9opvQ
	(envelope-from <netdev+bounces-285359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:42:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E6D4EA676
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 343FF304CA51
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B693FBEDF;
	Thu,  7 May 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVsNleZv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426CB3B3C18;
	Thu,  7 May 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164650; cv=none; b=CNX0nB5cZDzcj6cdyV3kbygOL4FMt51QWEcDMW8tSgFRcWDzRZpPDm0ScaFL8VnwyEnyS5LDFs5Ifeok0uUO0YTp+fEQ6A0leN6wpFEqen58YIb0AsCbG9diqpNrLJi1CBkShHNSPx8t8UCTv868FZ5Orgr7y4nTTKwmGvCn8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164650; c=relaxed/simple;
	bh=/06iJTIswHJAGuKB9QgfyKxE3j1xdhVa55IUHj0wWac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCFTz9R+fmlDZPM7dXRrMg+2pwSh9loRAk45FosdMuKujOZU7BTwn79b2c8+y+zDhpztL/D3DnjUlQDgWGww5ei7AFsw/uizANpwo53cn+KagB8iZQhDIJUiwslRg05W14x7ZrlwjqxZOLbFYy7jvsyuYn1L9zZ/miHArZbz31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVsNleZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E51C2BCB2;
	Thu,  7 May 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164649;
	bh=/06iJTIswHJAGuKB9QgfyKxE3j1xdhVa55IUHj0wWac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BVsNleZvytsBNu+ZwFTDjsYzykaf/tfLWtKe09AEygw7152R6qJz2do20D776/E/C
	 gO0WzHhMn2nKJuzOToRzsxVrV7sVlouFg8+RVApAQ71th58K8VVodGGvS50z+IcdWo
	 YyfexPIUYKXSGE3zU6UFRXL+XAYLSEEUPVnZxNp3Kgjyktm1Xo3T92LfXvP4lYemJs
	 9DyfcVXCV4s3/Zf8T+1Yt3fHmi6ocSQ4RiiObrztHsAMr0JnnDUQAzNubrv4vMEf+5
	 +V3hXy4rTNxRgX5vKg+gM7qYsL/gFbEI19iTQzQZzGOr04fBA4rcxIPrZAEYDG88FV
	 fDN0iFVq11EMA==
Date: Thu, 7 May 2026 07:37:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: sched: tbf: pass all params to
 offload users
Message-ID: <20260507073728.68287a31@kernel.org>
In-Reply-To: <CAAXyoMP3RNFWG+n39ZtCYb3Aq66KvpEjMhKr_2zU85mah0czrg@mail.gmail.com>
References: <20260504101258.1608004-3-mmyangfl@gmail.com>
	<20260507012306.2187935-1-kuba@kernel.org>
	<CAAXyoMP3RNFWG+n39ZtCYb3Aq66KvpEjMhKr_2zU85mah0czrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 74E6D4EA676
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285359-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,mojatatu.com,resnulli.us,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 7 May 2026 11:11:58 +0800 David Yang wrote:
> > >  struct tc_tbf_qopt_offload_replace_params {
> > > +     u32             limit;
> > > +     u32             max_size;
> > > +     s64             buffer;
> > > +     s64             mtu;  
> >
> > The buffer and mtu fields are stored in tbf_sched_data in nanoseconds
> > (see tbf_change() in net/sched/sch_tbf.c where they are derived via
> > PSCHED_TICKS2NS(qopt->buffer) and psched_l2t_ns()), but they are
> > exposed here as bare s64 buffer / s64 mtu right next to max_size
> > which is a byte count.
> >
> > Would it be worth renaming these to buffer_ns / mtu_ns, or adding
> > kerneldoc to describe their unit?
> >
> > A driver author reading this struct and seeing mtu adjacent to
> > max_size might reasonably assume mtu is a byte MTU and program
> > hardware accordingly.  
> 
> These are carbon copies of struct tbf_sched_data, I see no reason to
> rename just here.

Driver API has broader exposure and more potential for
misunderstandings. AI's naming suggestion makes sense to me.

