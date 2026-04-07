Return-Path: <netdev+bounces-275922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NGzFMjN1GmtxgcAu9opvQ
	(envelope-from <netdev+bounces-275922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:26:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD763ABF11
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 271943007CAD
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5093739BFFD;
	Tue,  7 Apr 2026 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2RBhsgU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BE39B49C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553778; cv=none; b=NMgaQ8wTxMqDfdeN9KvQ3lkESR5oMT/JJdZ0kcmLrV7zoag2+bqGwwknF23wZDt7tJSELHAdVUHZAopIxw+1aHyMsK+EsRx/cBy3aXTdXPjzGCeAKNLBR1g/DI3Q8x/n/h11zcHHC7+mlMA/hPPq8NDwJm0ggaz2lxSLUjtaO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553778; c=relaxed/simple;
	bh=hRO2sH+AZYMuioqBbIdAHoSERuZOO3FkQS3wvzTDRS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peAnVApD8S0xNf1fnYIRXi7pUY7SUuyilQpKWYZil8LsziV4wUXxIHny3q5QHt+Um1RiyuXtjPPAyATRwJ1EPlIoCNq/YoApuOQ98NWLzSadSpFcYDBhhrLbZ+4fJ/TtMI5aSjJwCtjq5aTEyRlB5NgI6S9v9dEoQtGPYcAzduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2RBhsgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B20C2BCB4
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775553778;
	bh=hRO2sH+AZYMuioqBbIdAHoSERuZOO3FkQS3wvzTDRS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p2RBhsgUOeuzvBlq+zLOb1DQ/zXfapti97Fhb2E/eDOggFqCr71M3f7T1GhJZh2Mu
	 mxnwYXPhJcXXY19WcXShLaVdwhtPa8M2dfSFVfIE2hP4SogWTRXaZP4ilWdRSOyZFx
	 kviqHDInpQ2UZY2c4+Ikml5SQS7ogjjZY8NlHMDZT8GERxO6z+KU0qAQgDrETzFhJI
	 lc1cw+Tt5pd9eSv+fsKHxFldHF69m1H+3o59rqMSAZVHlDdaTy7UEjAsPHnV6S6soR
	 3GMzt5dkuqL36MBTwGysPWnmDCMZKRU/y5xBL4JrGZcLj2CwpsOthQvfz9BldLFM8C
	 F+RS1xFsturUA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a7109f568so52122617b3.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 02:22:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXM46EIh3IfIF+RZISzRCN//ioXeeyvO5FB46MKVvwg5DNvkhFXKHwRY5Bc4dfgZVj2Teg6tqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcgfkIJBsJ5HIM3hRkXNKzksl1/38pR/dTGIs3OXFBTZavJAs
	Ui530DddjwexRf53QCGYRdiDjRVirE4a4pC0mioBJQh5q8QKgnkcqR12lFBijRvVtU42T5fDpZa
	rzKlaNG6lXXG+gXalQU/sq7pOB+F7TQQ=
X-Received: by 2002:a05:690c:385:b0:79a:bde3:7085 with SMTP id
 00721157ae682-7a4d39c8c04mr166065927b3.14.1775553777353; Tue, 07 Apr 2026
 02:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com> <20260331-realtek_forward-v1-10-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-10-44fb63033b7e@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 7 Apr 2026 11:22:46 +0200
X-Gmail-Original-Message-ID: <CAD++jLmX31KfhGXA6SMAPXb14dHSC1t4JQZ=PQvjh-3hUcnzJA@mail.gmail.com>
X-Gm-Features: AQROBzCxgk2wWtBb_ytqICh5rGz9Rc8aTvJ6IXb1NfEGqfOE0SSPKJA9UtMVF5E
Message-ID: <CAD++jLmX31KfhGXA6SMAPXb14dHSC1t4JQZ=PQvjh-3hUcnzJA@mail.gmail.com>
Subject: Re: [net-next PATCH 10/10] net: dsa: tag_rtl8_4: set KEEP flag
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 9AD763ABF11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 1:01=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> KEEP=3D1 is needed because we should respect the format of the packet as
> the kernel sends it to us. Unless tx forward offloading is used, the
> kernel is giving us the packet exactly as it should leave the specified
> port on the wire. Until now this was not needed because the ports were
> always functioning in a standalone mode in a VLAN-unaware way, so the
> switch would not tag or untag frames anyway. But arguably it should have
> been KEEP=3D1 all along.
>
> Co-developed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

I think you could just send this and patch 1 separately so they get
merged first as they are completely self-contained and uncontroversial
and touch the same code.

Yours,
Linus Walleij

