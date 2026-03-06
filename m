Return-Path: <netdev+bounces-264707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDqeIrKMqml0TQEAu9opvQ
	(envelope-from <netdev+bounces-264707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 09:13:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 962B121CE88
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 09:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A5E8300A64E
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1C3783C2;
	Fri,  6 Mar 2026 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKrynwym"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F819F11B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784812; cv=none; b=EC9mfust78W0xdWCyUdFQflFQPtVSF5HwdoeCTgZ9c7sQwarioFLaXLYYJTZyIamlEn8zTHwzZZgE4sXG0CJeDbYD8rq8CF1BW8gVFUa26o7uiLQc06j/ttYbrDxWsNwJT9v8xYE/8IdR+mVWATf/rdCfk4lglt8+I23XOaB1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784812; c=relaxed/simple;
	bh=ir/bf+hQ9gMvqU75p9G9sKsuD6FrwXfjUW2lCkne09E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LA+7J3kURALN+VCjmj9icdlOd0Fusdg0y6ylm2hCWN8vlt7n3FFQ+zwXJ5mqSmTqarOzwHqMn3yaNKUWih8Ky2n1wN01lyeLaeKcG8dSsd+Q09ogjJ1ghnXDkgiwykhU7qsSKnU9cmgpc/cZZzPqaEHNUM0G9uNK0fKxYYGlF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKrynwym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7DCC2BCB3
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 08:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772784812;
	bh=ir/bf+hQ9gMvqU75p9G9sKsuD6FrwXfjUW2lCkne09E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aKrynwym3Wq3y1NvZmFhT/NzvjN5rl2/ngYJxQZtZW+wnuBj3qiVts9jXMJ7ySxFq
	 oEQC6XE2vSImiNWxdR/KE02K760MkUD+wxLW2x99W/KKb1WLR7bGEBfGEZtYACEwUs
	 uoOyPGj0JMNWWycyqgFbwBDwQ+e4QBAefBTJRG5tcR8R5gNpY63Bf///aJVj9S7TH3
	 Eabe+B+7TWS2LCWANbZAOsDsXrnrooZp3avf62qEPDNpRKVrIsJaac217JY5xLR2Vt
	 htwCT4WkBaazyxW2RCy9XH8eC3Djg3f4Ti5BbiM1frayEXoCfG2NTH7PYmRfrP5t02
	 FOb/SR/cWhUTA==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899a5db525cso82459886d6.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 00:13:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJp+d9XuugDkrFfydDRPDCGCfBZNef1nd4frhR3rELfHH0vMohW0xQ+KtA7C19xyWyna+8lEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxucLyit7aU1byiSgiujOhgBybnsM/xpfjtQjCe01zhk3fe9x0U
	WhwUykXB5FqYVT+TivVRoyycMUs5qXaNMLIrgbvSdvKIkka8Xek72FwK7LT7FoqxhhNokdw/M7a
	NoYg9PCVMRbCI8+5Y5Mz6R67s/lQ8KUs=
X-Received: by 2002:ad4:5ecd:0:b0:89a:1832:7f5 with SMTP id
 6a1803df08f44-89a30afbdeemr14444766d6.64.1772784811111; Fri, 06 Mar 2026
 00:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304131855.3225539-1-bjorn@kernel.org> <20260304131855.3225539-3-bjorn@kernel.org>
 <20260305190518.4dce9ccc@kernel.org>
In-Reply-To: <20260305190518.4dce9ccc@kernel.org>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Fri, 6 Mar 2026 09:13:20 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNjwFLgHW-Y3z6yS_UMsAUtBXkwv_6ZH7x6B1MmJ5TnQhQ@mail.gmail.com>
X-Gm-Features: AaiRm52S8GWC9yjiKnHQDEw2jyfu95DOsw0mNURqI66UvQHnm7loQJ73Dunqwso
Message-ID: <CAJ+HfNjwFLgHW-Y3z6yS_UMsAUtBXkwv_6ZH7x6B1MmJ5TnQhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] bnxt_en: Resize RSS contexts on channel
 count change
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 962B121CE88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264707-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Jakub!

On Fri, 6 Mar 2026 at 04:05, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  4 Mar 2026 14:18:52 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> > +             if (netif_is_rxfh_configured(dev) &&
> > +                 ethtool_rxfh_can_resize(bp->rss_indir_tbl,
> > +                                         old_tbl_size, new_tbl_size)) =
{
>
> Doesn't this read a little odd? Shouldn't ethtool_rxfh_can_resize()
> return true when ... we can resize? You end up ignoring the real rc
> here, and it can only ever be -EINVAL.

Yeah, it does. I'll change to return a bool, and inverse the check!

Thanks,
Bj=C3=B6rn

