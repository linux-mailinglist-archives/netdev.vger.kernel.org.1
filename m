Return-Path: <netdev+bounces-255252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LfDkD10afWlLQQIAu9opvQ
	(envelope-from <netdev+bounces-255252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:53:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54067BE907
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDDED3013D73
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34D30BF7D;
	Fri, 30 Jan 2026 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpWTrKv8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068972FC00D
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806426; cv=none; b=HHh19TMo2Ttzef/uKo94Tlf/JsugQfKMHz0rMAq8sYRwovmKiNhq9RY1Ue9XcDopMpSVnrXvjMOYRuXUSHBos780c2CO1Unohuqsr5N7+fLdBG8osp5r1TEq6PVwdJjVHZ+PriZZou+CbrwbZBL91mrzSgRWDuHSpiJOeHqKWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806426; c=relaxed/simple;
	bh=lkPwYTzl0DbCZYhLCGJ65Pus+xrdtoKH3YxMB4vzDoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLMw4edTpAaCIds7cCuG2AN/XhWnKzJifglAIovm8z4Xnv1ZptDkpIRnlUThW91IIEmscUN9EMByAWtZ5sqYKqLEbjfJ0XD7NzXSiXBbPBJf1ehrQlClNTcxZ9LDA3jSCTSZz5d2nJu6wQ0/m/ERHy30vbvG2TfeQPxGZTE3ric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpWTrKv8; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1249b9f5703so3674820c88.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 12:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769806424; x=1770411224; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YJJRhfFtrMmO8MclixSPtlLRJyCgYpUlgh2rmwRF9PU=;
        b=fpWTrKv8MRlKW0KhMJxQfuY8opi59Hayz7tOUKqc3a1kZ+wjQdYB7uo3IDI/e9ol+W
         3Z5Jwlm9OPZHibfIC5C9bEGKNrUdlcCkiHlmoEkNb0DZS704/UepepJBQZHLx/jcd0bt
         IHLonElnykCOOd1VT93kSSQYqhPqayXNf7t8K5pbspOCZ5NWgkipKJo8qvyDq9NG/3Cq
         T7oZHhPaL3LU2JBSio9MoCOS1NovvBJ9WFdVGPQcjLn+OyK3tb0bNPkTpG56bdDTYcms
         DST8FWax+ri8Qe1som4kHdgHD2LxeFEs5vvHFyUj1BSv14dHmYTNYsL4h7ab9gVcqgcN
         kulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806424; x=1770411224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJJRhfFtrMmO8MclixSPtlLRJyCgYpUlgh2rmwRF9PU=;
        b=oPFdqIVy0CgP6LiE32k8VHnO6MH5ssCxk9LPXC6d/5Sbx7BBB78i8PIK1SE9rWpsif
         obYZZTgq2bvTqQB85n9lH8LQGXgFmLF+VQn7osLvFQ1KJjv74+jzcSj00mapywc1R2MB
         8mC/Vt3Tg/rwn78d3XdgEgG4cShl97/pmB1rzhzz/XTvS6j98Hgpp+h2Kv1OCwXquEnC
         +mfwjOsuY7gHF1iQui0o1BQ0XHb7R7DSEilWht9QTz5VSnkyrv7vrZhHMQAhxzvTv0dY
         HfFW7E2DmGHo55Iv7WqAhIO7CuEVNVpe0V2oCWt/3n77dpHQyTJHe+k3kp+QFXAJSXwn
         SX5A==
X-Forwarded-Encrypted: i=1; AJvYcCVY+x6LCtmaEzIbtGtAUT7FgK/YDPwzCPwuMzswyXqZ7rpMvZ0JMy62rt50VYu5rXwXhWkGOl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLA9xrWgtNkLYWMU3i5HXsbmgnm1PJ2Dc4UNN6zk6wcFoqWwbH
	eMzSHwhlBrfN7qasaLVjRzizfiF6W0qUfM1kvI4QKxvpPygrUH/EX+WO
X-Gm-Gg: AZuq6aL3MU19y0SFPmlj2LCyKyds5ZYPOP70qobsSR/ph9PxlWTOSCLlvwPKvrJXqmv
	DciPByxq2BvsAV+4uQMopORZ4Bd1kZn6YFi3OePjaJsI/ljm2lo2ehZBIjfGA3RUmgkBstB2cOZ
	8/c9x9s7zkYTgwJj0CYIZ109BEDp7vS7UNsTp9Rrto8gr73zIenQ5+q0UoVbCvADfwdXfpyqfb/
	dPWw7CEdCjy6BP2qHz0TEuwi923v+ig3JDy9ZoPyZ+8qlenllFMJIM9r3rSBUI1tx7pkaOfTlni
	mREeJhuNAKpl8HJeHWjwMeWzVZUoEfpXeybLHxhxKd9MXYqDydDMNMQIwmzkRfdKFAmLokSzfa6
	Y2LYvclz8oMhAFJL96MpysNZMsdYc32pfC9PLrYfvzTQCJqOSZZzyct4ZlAvv+jj8grpf8Bnxed
	X/LhJy3exoEbFsdts=
X-Received: by 2002:a05:7022:221b:b0:119:e569:f61b with SMTP id a92af1059eb24-125c0fbf76cmr1460200c88.20.1769806424094;
        Fri, 30 Jan 2026 12:53:44 -0800 (PST)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9de7febsm11278545c88.10.2026.01.30.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 12:53:43 -0800 (PST)
Date: Fri, 30 Jan 2026 12:53:42 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Subject: Re: [Patch net v8 0/9] netem: Fix skb duplication logic and prevent
 infinite loops
Message-ID: <aX0aVgCBTGpGYaJV@pop-os.localdomain>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
 <CAM0EoMn=bx-AMR0RbFmSj8MjWTxLtB_xo5419AW18paZ9r1wDQ@mail.gmail.com>
 <20260127091556.052604cd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127091556.052604cd@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255252-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54067BE907
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 09:15:56AM -0800, Jakub Kicinski wrote:
> On Sun, 18 Jan 2026 10:07:37 -0500 Jamal Hadi Salim wrote:
> > On Sun, Jan 18, 2026 at 1:16 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > This patchset fixes the infinite loops due to duplication in netem, the
> > > real root cause of this problem is enqueuing to the root qdisc, which is
> > > now changed to enqueuing to the same qdisc. This is more reasonable,
> > > more intuitive from users' perspective, less error-prone and more elegant
> > > from kernel developers' perspective.
> > >
> > > Please see more details in patch 4/9 which contains two pages of detailed
> > > explanation including why it is safe and better.
> > >
> > > This reverts the offending commits from William which clearly broke
> > > mq+netem use cases, as reported by two users.
> > >
> > > All the TC test cases pass with this patchset.
> > >  
> > 
> > These patches should not be considered for any review because they are
> > not following the rules that are set for the community. The rules,
> > which are well documented, state that you must cc all stakeholders.
> > When someone does this _on purpose_ such as Cong, some accountability
> > needs to be imposed. I would say totally ignoring these patches is one
> > option. Otherwise anyone can just throw a tantrum and decide those
> > rules dont apply to them. Either that or we modify the rules to state
> > it is ok to do this..
> 
> We (the netdev maintainers) had a chat off list and concluded that it'd
> be great if we (the two of you and one maintainer) met over VC. Either
> technical solution is fine, but we want to make sure there's no ongoing
> animosity. No agenda for the meeting, just want to make sure you can
> have a friendly chat. We can talk about the weather, AI code reviews or
> everyone's favorite animals. At the end of the meeting we can either
> decide or flip a coin.

I offered people involved here for a video chat, *check note*, in

26 Nov 2025:
https://lore.kernel.org/netdev/aSe%2FIfNSZBTTAfTA@pop-os.localdomain/
8 Jul 2025:
https://lore.kernel.org/netdev/aG2OUoDD2m5MqdSz@pop-os.localdomain/

No one responded, obviously.

Jakub, please let me know how to talk to people who kept rejecting to
talk. It is just logically impossible to me, and I have tried my best.

I wish you best luck for doing so.

Thanks!

