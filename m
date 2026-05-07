Return-Path: <netdev+bounces-285364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCZdD96o/GkNSgAAu9opvQ
	(envelope-from <netdev+bounces-285364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:59:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E8B4EAB57
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543A3300CC21
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D1E3A4513;
	Thu,  7 May 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQkSR2Ic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB5392814;
	Thu,  7 May 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165556; cv=none; b=Li1sbLJUUf+EAEmhb2DZKAR23MH4W2hlgyFAJlLoevatEOaZxe2IUiD7FZpdJLkikWquWsnkUZntw6I7JVccO89GJnOGGuJM/Iok/XHOJgYj0sqg5ACP4YzUXuOyxKV6IwnHjb8nJ550rkWhBh7AbU4h1Lg2Ds2evBo8N/0fUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165556; c=relaxed/simple;
	bh=uEufh4i4Xf8A8Ma1I31xNuq9nvx5pNtqY1KijnCuKww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrJlGZoia2D9wffaMFc323CXzjp6zvm73r+b1LuKrTz6QLhx3ogeKXBHxxnpdLc16o+6PHfwYorg7/tP074/IFvfWJqvGFKdT/B5epa/AsfCet8IPnOybUy7y8Tc3l5mcrm2Y0jIzdbnJvA1ppiqVmyyXhNHgBU+WM6CLcJg/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQkSR2Ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A842FC2BCB2;
	Thu,  7 May 2026 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778165556;
	bh=uEufh4i4Xf8A8Ma1I31xNuq9nvx5pNtqY1KijnCuKww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nQkSR2IcsXxuXbEKyP5uKEqFvmJ6tWLQHwnQKUIqwhhIjM5AzRutXx/kcx4RRQ0TY
	 E2L+Bj6y0V36UNUo6xQ99hV9poiATNjc5aFk1oLzSNVnJpPMXB7AtP1fhTKbCES7he
	 /q3h/FN/1VjcsYt4xWGhn1QJ8lnsoEk7W5TlgozhRXcmojIy5BFxQQv8/M+WWg3vyT
	 Zi7Mki+Q7OmABjPrZ74Jtxkc/aDhUGo8YzFnYQwvVjzeUTWUfDMo6HY0COPJaTAXSQ
	 wNsNAomYE4D3RRuDobvfeZtiHudTvLBSSx+zX6njbi858vGTmGK1sTfMa0NtmUFd+v
	 auaKcKmoDkPUw==
Date: Thu, 7 May 2026 07:52:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: =?UTF-8?B?w4FsdmFybw==?= Costa <alvaroc.dev@gmail.com>,
 jiri@resnulli.us, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org (open list:DEVLINK),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] devlink/param: replace deprecated strcpy() with
 strscpy()
Message-ID: <20260507075234.1630060f@kernel.org>
In-Reply-To: <20260507090445.3448d536@pumpkin>
References: <20260506211415.16343-1-alvaroc.dev@gmail.com>
	<20260507090445.3448d536@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 95E8B4EAB57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285364-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 7 May 2026 09:04:45 +0100 David Laight wrote:
> >  	case DEVLINK_PARAM_TYPE_STRING:
> > -		len = strnlen(nla_data(param_data), nla_len(param_data));
> > -		if (len == nla_len(param_data) ||
> > -		    len >= __DEVLINK_PARAM_MAX_STRING_VALUE)
> > +		len = strscpy(value->vstr, nla_data(param_data));
> > +		if (len < 0)
> >  			return -EINVAL;
> > -		strcpy(value->vstr, nla_data(param_data));  
> 
> The only sensible thing here is to replace the strcpy() with:
> 		memcpy(value->vstr, nla_data(param_data), len + 1);

That'd probably be a good move, to avoid getting the broken strscpy()
conversion submissions. Care to send a patch?

