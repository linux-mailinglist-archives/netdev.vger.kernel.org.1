Return-Path: <netdev+bounces-302080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aYxuMBLLPWou6ggAu9opvQ
	(envelope-from <netdev+bounces-302080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 02:42:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35AE6C94CA
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 02:42:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=multikernel-io.20251104.gappssmtp.com header.s=20251104 header.b=OQ97Nl66;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302080-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302080-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD415300B819
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 00:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C8D26ED25;
	Fri, 26 Jun 2026 00:42:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540E323B638
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 00:42:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434573; cv=none; b=oaOYyLkL8g5QfbI/2/3gU2AIV/JZlmRXXOzRZW9y5XModee+MCcCLyeJhFWVaJj9aEvxJuphQB6TmP9J1Gy58f0TBg2pRbJeIM4xh5B6/CoMQe7K1H4s+KZ9Io4gQ7YSWdPx1UbnQvaVTiND74PN+YH6AetfItDcgG0/gvlQ/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434573; c=relaxed/simple;
	bh=ZF5CBE//uo1iUn0UcJDAyme3T9aP1Uvep0Kno8CtDHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyguHS8EVlbcuvvQhAQAVI7ko8LB1uk34c6et1zJfyk2aqITieJDoBzL4MOMoFQ37mH+bGJ3ohpoJLQ6VjlGnNyFIdI57RBSIRTGxD/hGRJg4TSx0brD050SvwNp37kWHUHMkbYGheLzshlZUC+9LfcKlMF4MQjrsRwALJq3ozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=OQ97Nl66; arc=none smtp.client-ip=74.125.82.177
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c591fb1cbso681215eec.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 17:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1782434571; x=1783039371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gFKwf36fYY31R1VACjALzX7vpz/XulsxWqVH3pAeFE=;
        b=OQ97Nl66751ttRaVk5uGMyYbvwaLgm9lYSLBpdQo3k9PW2IqWTGmIjgIoIof0W0idW
         T3IElBXYFXgRO3rR+v2CNhN/CyCuXKSSFkPeNglAY/gwTMaOrHjMrbzGTwgEFgrzZbWV
         JEBTnuDSJF9zGCFGkPyV9+w5X+qHeYHaXY7i52xBx/MhuVVm5tcOrQG5ZR0ydwnePrFy
         AN5iEIqB7xbS04j2CyP+bSTVXxXOV/oJjCrBRI5zigTrzxE4Ct2L/DzsQZqThDoxObUp
         dIQ3Bxt/EJECGxiTNjhYBpuFuom55pGg79Z7RDABE4FxXdkIWn/AdBLalslC9atCmtCs
         TGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782434571; x=1783039371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gFKwf36fYY31R1VACjALzX7vpz/XulsxWqVH3pAeFE=;
        b=nzU1ZTZ9+vkd/WIk8SHOHDffy9VnT4UNhyQ3mrFHNa2F0tXLY/X+XFxHCzTa+NRP2c
         R3FHFj69sI0HuOmfjEwl19V5fY82aALkt4pf86UCNb5unEYDYLIlm2i92q5Ih6lInQvj
         LcEvG0GoU4GurWU7ygSajpHGjvI2Okz7MIBJ/Fr9lpg/ElH45OH41NsgwC5wNMw8sKoV
         b+mSlBDAd+3JCIzxmvwJ2maMRQN8ViZEEztW3HA/DBzP3jGKyN4Tf9XuT4U90w1wCZCG
         Azj55trTu5IxLS9eDvtbAuwB8i/kotAn8kOZTg3M4ZGnwTDJjtTTfhSxdv6sZ8Pfxd8S
         IN5w==
X-Forwarded-Encrypted: i=1; AHgh+Ro7VPB3v6S2UiI+6YU8m9XbtyvyfbrORJRMiRn5cOjW5oUhHwjqB+ZAdw6d8KzLP1FJV1RP7wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBthlurU3NEnrPxkKnzjjZdmJbSvewKkLWPiQd8KWPtFXFAu0
	csC/9lLN44kiAQV48zBr/29/qiYvo6PZDQzPkFk5m1gmISQA/HbJhbpeNpZqEygoNXY=
X-Gm-Gg: AfdE7cmAnpYfFRc0XUiiER4QQ+UuNkxchptqYhJYe1Dx9vDF4oLa0S7ETd9IGK2YaQS
	NtQlbzqszRACjNGvEKGThqMyOtmuj4NNkV9lDkntkguFPa4DqQL0f4kB/zx6tLqBu+HJSlLYnAc
	XKzGhIpBu8mb2ANcfxOKfEZZsx+vY/61l6NifJ6O0mePcN949ak4+Bg1uLWaz4apMb7lXkTiQbi
	WyyH976G5iOUs++wDK1xT9sYJK/dmoOttzaYkq5R5foMYdwQYHufCxmVz/4fo9QI8KOSygU+CZp
	BbpAwhsUmw3dmjgyhQwWB4DH1M7KLQufbI13yczBt6Tecve6xBUgBJwJcxwAXoM26b4JW7A5Vsv
	VyPctuhFgP4g5F5UJqHrfV+AXerUakTGmV05dfH0zU5NM6Xq/gnMfsL/Ve//P+olD+OE71gyorz
	k5znhXz0fkGJhnBtIL1JEpLf9ywjPC5mMGJ5xg4K3nyYQ=
X-Received: by 2002:a05:7301:5789:b0:304:2cc9:2ba8 with SMTP id 5a478bee46e88-30c84df3c57mr4058957eec.30.1782434571261;
        Thu, 25 Jun 2026 17:42:51 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c58831asm13423174eec.13.2026.06.25.17.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 17:42:50 -0700 (PDT)
Date: Thu, 25 Jun 2026 17:42:49 -0700
From: Cong Wang <cwang@multikernel.io>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>,
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC net-next 00/17] MPTCP KTLS support
Message-ID: <aj3LCUkOy6MwY7AL@pop-os.localdomain>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
 <20260622090059.5d1813dd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622090059.5d1813dd@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:geliang@kernel.org,m:matttbe@kernel.org,m:martineau@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:hare@suse.de,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:qiang.zhang@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302080-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,queasysnail.net,suse.de,kylinos.cn,vger.kernel.org,lists.linux.dev,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[multikernel-io.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,multikernel-io.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B35AE6C94CA

On Mon, Jun 22, 2026 at 09:00:59AM -0700, Jakub Kicinski wrote:
> On Mon, 22 Jun 2026 18:43:20 +0800 Geliang Tang wrote:
> > Subject: [RFC net-next 00/17] MPTCP KTLS support
> 
> Please no. We have a ton of unfixed bugs and may have to revert some of
> the features we dropped back in. I'd prefer to avoid large new bug
> surfaces until we reach an LTS release.

Is this specifically for kTLS? Or the whole networking subsystem?

Asking because if it is the latter you probably want to announce this
new rule offically and update Documentation/process/maintainer-netdev.rst

Regards,
Cong

