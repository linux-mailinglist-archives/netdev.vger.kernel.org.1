Return-Path: <netdev+bounces-269047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGfyFj67umk4bQIAu9opvQ
	(envelope-from <netdev+bounces-269047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:48:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E8C2BD80A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B98F3053B29
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491083DB62A;
	Wed, 18 Mar 2026 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E2xjcuj/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34FB3DCD98
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845046; cv=pass; b=ZzLSoxIo0aXZinOjwwvB8w6cRAZRlSRlitRpy/hq4saZ2+qB5q/9I6oX5ijDxLz3fBznNu83a1JDex98xdaFKUlczk7ppvHZvwB0nZTd2WIAztBU8XvKJQBFfMRNiPmgIVYFmijjar966zoEdwSVnIhFHyqPC+bJHPyBWGSVGBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845046; c=relaxed/simple;
	bh=1vWGIGNakDqtlJkhrm20pGjTTl2ZGpSelhz88I5gY5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOihM71bt4BS3jQkLi1MQSJIpJZ1joGZI8ULjxbEhgBpr9YCMHgTxERXlCl9dzuSLknS6iDa0vklJVJRpWhNtcF445OqXd46icEy+EGJ6RYht/1nCGtMgYzU0SlcUxrfG/jX7fxu6eZre4vuy43XAfVH2VkP1of5eMcoToyz4Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E2xjcuj/; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b94a19fdso6376176f8f.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845043; cv=none;
        d=google.com; s=arc-20240605;
        b=BYtfdieOXL2NmvAka9SN2xNjxMG4JZHcxj82/RE/RjzPoif6fEwQfnzkXd+E4aZL7f
         FjbCAIVSK0jzmfbZVw1a0MpQ8mQUBFTYSo8RF/LE15iTQT9kdPqR5EzNpsGY4DAyFzH8
         J/NN/xn/o38SbZiqawXkUsTmgwgYOZ8y9fwpIVQTGVCkoCAMk27O0gdc4DCaf/97KqHz
         Zq9CzBcm29J55rSc6l+13IrdP35iiSCEnJIf2kF2Tx7I71Sz5QAxpVCGzdPo78RZ+6ng
         +eNN6XpxQz/ndCDRapcuFTnHhFXDnsImGlPagjdT3wiL793gUWLZgiCHioXlnze24ZtA
         kGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jMXohInzeoqakjhzYWU7cUPd1dT7sCRRVXjW4BqY0cg=;
        fh=4sSjh7Z+aKbA88qg+kkxmWF4bxVzrxwIGtkoQzuwd+w=;
        b=Stq9xIAwTvS32C9UpP5kVdoPdPv0pyKNc/DxQr+w5GalfOCsNqmBV29d6/1C6avuXj
         GlQN6SarxCMpkydILkUQnp1TPIv3my9KvLaXG7w3/5NnRp5r8ozZgybvhXGE6SX27PH/
         PtoZC+qHTrjF5jFf7yqX3ZGAIvabjskcE5urXSf8ItzlEsuV99WpDn/9mXTCPmcr+uVB
         r+97xNT6X2fSR3SYeZE/oXyyrr9Z22UWnmll5xgA91hWCY4yfYt5I/NF4xp8jAjbkzAq
         NH+m59nIx45/GnI8unF9953MIggUVOl+ownfDUIaluKhtVEW/bQ7hptJ9l+MCZzPqflq
         kH1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773845043; x=1774449843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jMXohInzeoqakjhzYWU7cUPd1dT7sCRRVXjW4BqY0cg=;
        b=E2xjcuj/o8e9EZmwo+OXzHuS2ZyjaoYYxrHkvduwcSJMmuFjtd6BStVUOlF9USVesT
         t49QFmGYdGe4hKHM/40zyChPXy9VmWtKHeShHlozs9Jm37SSC7vU7mkEas3pMZD/eCme
         DyF7M0VVnjhDxWL+kVKZ8gOtVTD5PSA5BPTZTyTM3b7gMMa5CVwifiZuFO6ysP2oqXfg
         jREhOn4P1tLxplXFvabNkf/25O2VxD+THR5gz3Xi8gSogdqegi+p8HpOycfWmWrgnkAY
         nN6HkTqiw3iA4y0gI7cj+R6iHeUL2+/QrC6tn2+ufwPrAevcza2rgTHPIwCqFFHYbtvR
         UW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845043; x=1774449843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMXohInzeoqakjhzYWU7cUPd1dT7sCRRVXjW4BqY0cg=;
        b=TbVtH7OY1TS7GxFeuUdDugygfbC35UycqriAC/ljcy1zSjw+O+3IS9w8vsHXUNCgHk
         ehMaRx+v8FsCJpnQJZFWHYdVzFeJpCA8s8ibrCAvm0RPGPnUjMeWc/Z5tBdmauRqm/iK
         taFBB63bf+Vi8f10YgpCD67++wYN9rwUC+jEcweuHCq0akm8oLw9Z3tmbFDhdNTDv1sd
         O5w6U2UC6x1mt1cymauDduhcKZ75otorG107d2S9PQPWreFLSNO7WigheCGm2N3gZWqz
         seFrIeJbn/VyLDCJEdtuKvZlrVOE8G+wjl8zLBOgc6T6TXu+WtehrkfUp4Oq199SN2WH
         LgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI0kVSq6zLLZKTHdqtdqrYkebOB4G0RDq6wpbLvCrb+ENcYsFzhVAxKdsuk2SYq7keb6Rwg0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeo2SwJ+JKanTRUDLG0ExBgDiI+a6alxswUuWxI56s7PAY13hv
	DooDTF5BdH2g0OBHR78xy2nFfFtQRItu79TnN2lnDutjcrUEdiBa3SdDD55H1bx0Be1qZYOlz1Q
	nDkqdLc/ZmV1JNcyEqx7pWMce5CM/bMLLVpyaHSfvLQ==
X-Gm-Gg: ATEYQzyXRpTNCByXRiJHuGlWA75kKX95K0BjWNHpmiG+iNf7zPghpy/MeNQ1yle2dCM
	lHVwMbtA+RCXFkGqmqMstgIERaAZQOq9BwW8bfSx8TU//Z7eXmoYEn4mpjdLv1p4n8YNFJZkvnx
	DIMI+9ryGJ4aNLjDIeMCV9m4RjgxTac3R+HL+rd6hGI4SAD1kmqcIy1yI34luCCCMdk5xpzTzvq
	tZe7mZ53uNb/PgSM05qovS49JDnqE9zjFpFI6LnbAMP5LKiy8AhhUNp1Yf2+LOLHV6BX5GXOaFw
	KlT29feB371aT2i2WyYCAXqq43YZpoAueOYazGCORca3x53SUL0yPYJdRH+fgZW3Fu6C/QplgZk
	uT/FG
X-Received: by 2002:a05:6000:2302:b0:43b:5192:894b with SMTP id
 ffacd0b85a97d-43b527adde1mr6536659f8f.23.1773845043152; Wed, 18 Mar 2026
 07:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
 <20260217095700.SjYjM8RO@linutronix.de> <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de> <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de> <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de> <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com> <20260318111849._MMol8Hr@linutronix.de>
In-Reply-To: <20260318111849._MMol8Hr@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Mar 2026 15:43:52 +0100
X-Gm-Features: AaiRm51ceOk8VoveqAJnCirxUSK7B48kEkYDgq5_TgUOhULNInsCtDs8hn0BiCw
Message-ID: <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, spasswolf@web.de, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,lists.linux.dev,web.de,linutronix.de];
	TAGGED_FROM(0.00)[bounces-269047-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: D5E8C2BD80A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 at 12:18, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-03-18 11:30:09 [+0100], Daniel Vacek wrote:
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > >             /* Other cpus might concurrently change txq->xmit_lock_owner
> > >              * to -1 or to their cpu id, but not to our id.
> > >              */
> > > -           if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
> > > +           if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {
> >
> > Ain't this changing the behavior for !RT case? Previously, if it was the same thread
> > which has already locked the queue (and hence the same CPU) evaluating this condition,
> > the condition was skipped, which is no longer the case with this change.
>
> The above was me thinking and does not even compile for !RT. Commit
> b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> netdev_queue::_xmit_lock") is what was merged in the end.

Hmm, that means txq->xmit_lock_owner is not used at all for PREEMT_RT.
It's pointless to even store it. Shall we care?

--nX

> Sebastian

