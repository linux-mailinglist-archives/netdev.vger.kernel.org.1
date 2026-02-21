Return-Path: <netdev+bounces-259804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ewhFGrYCmWkxPAMAu9opvQ
	(envelope-from <netdev+bounces-259804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:56:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E016BA04
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166BB302D5F3
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FBD3112DB;
	Sat, 21 Feb 2026 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkjRGHbB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E011DA60D
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771635378; cv=none; b=kjYqmAQACDZh63BLHg11Wef0XOp0ZA/OjY9NtABduv0cAFvkSxC+nptXO4FKwfg5F/V6zlJQrSDouuwthNOa6m0PPsdMrGH3Y6YDZWgAk8kfYfvgv7cjRoKwyWA3acqr+65fLgalnkYuj6qSk7SrfTtGK3wIXgFW06+XsbuiYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771635378; c=relaxed/simple;
	bh=wlZDSkm6dCKIC/yRs3a//+3oanKk/T1jmwR5qGC3nlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knBA/zqLsO51SqrOIYjpVT+AJD4QrkDjZ53wa0DR/4s9Qsa7yCOefnJDHdVcWYPIbiUyEA6hwecwflC6f2qY64e/JlTpiyGupOVf5Wn0n8qOyg2FeYAAb4g8senmOhW/bpf0Wjba229jt1KqL92hLPVJxjVGoL9jnsy44DPOkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkjRGHbB; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-124afd03fd1so3617093c88.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 16:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771635376; x=1772240176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAuHkLoWGxu4w6ydGTuoVLuEOItX13UcgZ4dNROHNx0=;
        b=HkjRGHbBmsmC7OEHdNa8IUn57y1DBWNpYPle3CtOvWD9nmU+eeFDIXur44KpWzRJz+
         4fgvENId1+QZbF7jUNrzExdh1kVkyRYoRVOQ/wOIpJG9dVVHms8kqzyu3CHgYMMWvzDG
         XwtvscabcmwLdruWjdipyQx1AEaK5eu/U1ONfkmoywibzwIfw06tzaCnTR2fHPeKvDPU
         rTQHkPx9TR69Xs2IS6B6hgBprUBK9Pc5rHJ4diDuFHq6LeMm0Dqbu1WbizU6N8hdeZ1q
         bOA8r+vf5ek/Wh8cKf05Y/bVzbOWLFcpF2mtUEGNKHv07uo4QdNsCY6r4OFZl+zWLnlJ
         kRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771635377; x=1772240177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAuHkLoWGxu4w6ydGTuoVLuEOItX13UcgZ4dNROHNx0=;
        b=oOKfT1CJaISMdv6UA/LUI7aiyMncOF01sdRPCoxB/UAmTaGpgv6+WA7UXoz9VJ2AH9
         DUe4YBlrquFGqbIPGIBUPSK3mlScqozXp4ano0cKp2CEbwrac65A3swNXOZczDPL9VYt
         Q6JU2Muy3iPSiA9QAOpuX9TvePtu6fnMKnCSlD9tVPkF/NmXnRINuCbMbsIdgRcpJMWn
         ih/GzwdH6KAIS3vyjfUQBZ1GZWgglCy4ro5/EixAKhl4AcZmZftJ5LBUMSAfDpLJQhG1
         maUJ+cyGOk+cKal42c21usxqSpvMg15Fbs+Tb39q9GsHZb4ifb9aQDpG7j0KFxeQotNE
         Q1/g==
X-Forwarded-Encrypted: i=1; AJvYcCVaPzLWT991403p9lXgU9boR2x5h8W1qidIrtQWb6zB5xvI0/+F6RPdjd8K85RgN8DPMn4YQDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhfjfNyiNXwlH34dglQM2d81Iyee97JCs0ZPOcbzo3ltmRA3Hs
	6uKMR0NAY259+qWpTSQhAszgzPahcBPuHqT9gQQEF+8Rd2ns3ye3ZbCD
X-Gm-Gg: AZuq6aKUyMrO0ib/MTGbf6Zx0eogRBjylqDVslliePiGOCJnJXQptx2M14z103iH3qm
	J0Cq0cjOKRGNjCtA7gEa6Oq3VkQ9zvBFuOqcWWd9jH14s21Sj3FJCfTCJliak5Ye0KktyfzDqTC
	XjjMaf5JJacR6HsWkn6IgTA6q2dVeA+Q/0DtTPMqlD81fiwZGoi2nJMraei45gZEcPPDVqDAODQ
	xoy8/uCx76eh2PyaM+COqvyAKe2VTG5zu7DLk9iNDf8fktzid0lFWcMgFmt5dBnkXCNJxGw9k5s
	Vmmdb/KRmFpJLBFE8OQcF7DD+PhDUVW0ZUpST3GPNNHJSiFVq6Od0N5+Ag7jFd39EqJoql+li5C
	A0WOaZsJOCUMr4286Z85jr+EXTRBI1hml2hpotLua7nQQ8xY3Qku52PJvftbNFfkk0qduH+75m6
	Z8DJ1v9AtHT/bibcs2ibCXPkghbe6qFpCielaWXu2fthGv641IRMdmwHjWeYrfKICAJMpFtULMA
	MM=
X-Received: by 2002:a05:7022:6607:b0:123:35a4:e8be with SMTP id a92af1059eb24-1276acc047amr629943c88.13.1771635376447;
        Fri, 20 Feb 2026 16:56:16 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:30e0:64af:2b48:14be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af7ad65sm795757c88.11.2026.02.20.16.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 16:56:16 -0800 (PST)
Date: Fri, 20 Feb 2026 16:56:12 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Simon Horman <horms@kernel.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: wan: framer: fix potential UAF in
 framer_provider_simple_of_xlate()
Message-ID: <aZkAaoBxb8j3FqGr@google.com>
References: <aZefB5f3EAkQQM1m@google.com>
 <20260220162553.3beafdcc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220162553.3beafdcc@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259804-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 881E016BA04
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 04:25:53PM -0800, Jakub Kicinski wrote:
> On Thu, 19 Feb 2026 15:40:57 -0800 Dmitry Torokhov wrote:
> > The implementation put_device()s located device and then uses
> > container_of() on the pointer. The device may disappear by that time,
> > resulting in UAF.
> > 
> > Fix the problem by keeping the reference to the framer device, and
> > avoid getting an extra reference to it in framer_get().
> 
> I have failed to understand what you are talking about after looking 
> at this for 15min :S Please write better commit messages?

Yeah, I should probably rephrase it, container_of() is not that
important.

The core of the issue that once you do put_device() it may disappear,
so when you do 

	return dev_to_framer(target_dev);

the returned pointer may no longer point to the valid framer device. The
memory may get used for something else entirely.

You have to hold on to the reference until you are completely done with
the device.

> 
> > Fixes: dcacb364772e ("net: wan: framer: Simplify API framer_provider_simple_of_xlate() implementation")
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/net/wan/framer/framer-core.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/framer-core.c
> > index bf7ac7dd2804..397fabc3da4e 100644
> > --- a/drivers/net/wan/framer/framer-core.c
> > +++ b/drivers/net/wan/framer/framer-core.c
> > @@ -482,8 +482,6 @@ struct framer *framer_get(struct device *dev, const char *con_id)
> >  	if (IS_ERR(framer))
> >  		return framer;
> >  
> > -	get_device(&framer->dev);
> 
> AFAICT this get_device() does not pair with the put_device() 
> you are removing

It does not "pair", but it tries to bump up a reference to the device we
just did "put" on in framer_provider_simple_of_xlate(). If we remove put
there as I propose then we do not need to do it here, or we'll end up
with an extra reference.

> 
> >  	if (!try_module_get(framer->ops->owner)) {
> >  		ret = -EPROBE_DEFER;
> >  		goto err_put_device;
> > @@ -749,7 +747,6 @@ struct framer *framer_provider_simple_of_xlate(struct device *dev,
> >  	if (!target_dev)
> >  		return ERR_PTR(-ENODEV);
> >  
> > -	put_device(target_dev);
> >  	return dev_to_framer(target_dev);
> 
> The only caller of this function does not dereference the pointer
> (no idea why it even calls it, for some setup validation?)

The returned pointer ends up in framer_get() through a few layers.

> Calling container_of() on a stale pointer is safe.

But using what it returns isn't. And I am sure there is an arcane C
rule that disallows container_of and gives compiler a license to kill a
kitten.

> 
> >  }
> >  EXPORT_SYMBOL_GPL(framer_provider_simple_of_xlate);
> 
> I'm kinda curious about the backstory for this patch..
> What made you look at this code?

I want to remove class_find_device_by_of_node() in favor of
class_find_device_by_fwnode() so I happened to look at the code.

Thanks.

-- 
Dmitry

