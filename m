Return-Path: <netdev+bounces-300350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RvZUG6ioM2onEwYAu9opvQ
	(envelope-from <netdev+bounces-300350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:13:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B869E5DC
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:13:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300350-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300350-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73DAF301106F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AA63AF64F;
	Thu, 18 Jun 2026 08:13:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9E3AE70A
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 08:13:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770405; cv=none; b=IV/lxgP0qSHTw/4feDJTCZ2eJ/098NlDryZowdc1J0E7RLES3VTtK8Hps7xjzN9qaQikJ+s87c2JisDxloxyJfq0PeFfzJiDv/IZ8ojGskuvxslWXZE8oq5d3Um6tl0qG7yYUm5oFjJbQ3Im2P2yid8DiFq8qydiaRmBmt8csZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770405; c=relaxed/simple;
	bh=qT3TGQ4d0y9tUfJc/hPKLXqZe+/2KGNG6EH7xLEU0DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9qVANp6ZYjWtX/11RrbUIcoe0e3ElVRncnKMks0x+xSSJ2FpIF7vNLL+ZNmZ1wa4ri7i8S7OEtY1HWT76ue3SVghF5zbLNzoklIwCJaHhEYekK97z0K9HwfMx87aET14bzqKVCxsa7t50PRRF7imSqQoGIg1bXYd1aZ+VvG2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6cfd17e9250so272672137.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781770403; x=1782375203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKAZNU0FmJW8v6thQLRjRHc5rQqn36zhhyWy7vfjOZ8=;
        b=pp/SF8on1gS6CLs8x6vpz4LGYVYleclTaya30O2Uc5a7gNU4CROVSn7Jj4CisWKTS/
         q+nd5jVOyUx0yDbwuYjOF1jhmhZ0twnjMGyPqsXXOh0/NXwO/FlZ1gcyLGsrs/xYLwvx
         w62HH+ePYVg33edcWWMn8oQEugm+zd9TrItf3JToyWiiKiEPLSxkWuVaRj6WZCF7Ihsh
         L88ZXSjDz9i82azrvicyGnZ3CAWYF5/Lb2MzP5gz9MEzAmIs2oEUisNkR03tCVrrKwsI
         /yvQ3WTXho82g19zmSYFh4o/BzNcYqfGc0bg4hEA83Fk8ucghSX36PwWQU1U7bdowhQ4
         qgyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zgSbsQMnQYNPQZvhZCVfbDuFGE1bK0CRyiWLBlE8JsVDaYvnvzl4AD8aiA0MjkDMtNjFypok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQs0In0CivutUEOwsOpW0onk9Yv2IHlxY6OovD9WC0+q74zJ64
	uCb2QsyGN38PfDccG5jSrksyy/Ry+i+k14PLGobCYeEPUcO8Hc/3xThIBgFoEf+w
X-Gm-Gg: AfdE7ckaN+y9ldwLZAoeZrJXLcZZKEJjqzsxZWbVqMMcZh6pGoAUChaZgfZGAyyQWEh
	VWyf2sqvidKGA5O2j9oEyCrTaR1+oLfqodNp0ugI1G6Km+jhX420SG10ZBHdL5yIE+C/sBRFXCb
	2T4H+E0rYxskgo2/Dvr89LIefynn8N1TizzuUdTrUKssFe5utnUBedheyZyHGN6zTIY0j8ty9fL
	X4k2eeuGvyH8y8fh6lcnmzLm63qNYga97quR9LBQuFz6JloEGqG5OyjKhaxoDNZivOtjptK8MHt
	6TEUab2wzWdm0fd4vHIho18b1SOohAf8HZpjQavPkI4LxecAAcAtTJoZab9hPvAB5j0+tkP67X6
	10rhujjM2Z8NRghFowEG5fax7vcv+0ymaVWlKYQEKopxHbOJjwvtrplYGWIhdt2qX2tybV/xgy6
	Uc+c5AgQwS0G3xkM4hVjfRfjAplikmqWQpzbP1iEj0bjLK1ZWBCQ==
X-Received: by 2002:a05:6102:4bc5:b0:633:e67f:b7f with SMTP id ada2fe7eead31-7246d325344mr3981122137.25.1781770403200;
        Thu, 18 Jun 2026 01:13:23 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966a05d0068sm8927413241.11.2026.06.18.01.13.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:13:22 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-963f63fe025so171288241.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:13:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+K+4TxBzQGuFxXHoPe07FONIIchLZD5Fp6afqd5fLDNM1vRKB9m+Da+BoB+llMM+rbLUb5qwI=@vger.kernel.org
X-Received: by 2002:a05:6102:1626:b0:634:92c:bdd0 with SMTP id
 ada2fe7eead31-7245cec5b37mr3787588137.6.1781770401826; Thu, 18 Jun 2026
 01:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616084901.3319d82e@kernel.org> <1781694488854.956546368.818588236@strotmann.de>
 <489024bc-b6e5-f601-3bce-444d75abbf5d@linux-m68k.org> <2791b2e3-bf58-4dce-9262-4f1d8d3241fb@lunn.ch>
In-Reply-To: <2791b2e3-bf58-4dce-9262-4f1d8d3241fb@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jun 2026 10:13:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0em2r-SixT_+EpWJnm4f0g8mReYKBXOw42=HGb_T8WQ@mail.gmail.com>
X-Gm-Features: AVVi8CfLJ0ddT-LhKt0W0uHSh_81VvaoqDXBIXepEwXCQOI5G8FSGq0oRl6-8XI
Message-ID: <CAMuHMdU0em2r-SixT_+EpWJnm4f0g8mReYKBXOw42=HGb_T8WQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
To: Andrew Lunn <andrew@lunn.ch>
Cc: Finn Thain <fthain@linux-m68k.org>, Carsten Strotmann <carsten@strotmann.de>, 
	Jakub Kicinski <kuba@kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, chleroy@kernel.org, 
	npiggin@gmail.com, mpe@ellerman.id.au, maddy@linux.ibm.com, 
	linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300350-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:fthain@linux-m68k.org,m:carsten@strotmann.de,m:kuba@kernel.org,m:glaubitz@physik.fu-berlin.de,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:chleroy@kernel.org,m:npiggin@gmail.com,m:mpe@ellerman.id.au,m:maddy@linux.ibm.com,m:linux-mips@vger.kernel.org,m:linux-m68k@lists.linux-m68k.org,m:linuxppc-dev@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[linux-m68k.org,strotmann.de,kernel.org,physik.fu-berlin.de,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,gmail.com,ellerman.id.au,linux.ibm.com,lists.linux-m68k.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 077B869E5DC

Hi Andrew,

On Thu, 18 Jun 2026 at 10:01, Andrew Lunn <andrew@lunn.ch> wrote:
> If the appletalk community can take the workload off the top level
> maintainers, respond to all patches within 2 to 3 days, give
> Reviewed-by, or make change requests, it can probably stay in the
> Mainline kernel. Otherwise it will move out of tree.

"2 or 3 days" is rather short.  If we would have to move all code
maintained by people who cannot respond to all patches within 2 to
3 days out of the mainline kernel, you'd end up with a networking
subsystem without supporting OS ;-)

git grep three.*week -- Documentation/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

