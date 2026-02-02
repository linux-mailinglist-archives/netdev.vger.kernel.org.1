Return-Path: <netdev+bounces-255754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO4XNuNSgGla6QIAu9opvQ
	(envelope-from <netdev+bounces-255754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:31:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA8C92B8
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486EF301BC37
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 07:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012428D8D9;
	Mon,  2 Feb 2026 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLH0oj4K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A732288C39
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770017356; cv=none; b=fsWXSKUSQr8iTWjvPaBY/ZmlKHd8wQAmcmvwXW5TFz4Fp3ZoyL4INUynt9GCjLU+Ee6+PNr5ixzyflcYlYmKr4raoC6vD4hHByEsr4WwujBc8FYaiCQN+DrmMRwiph8pgZL8Qmaa04ozYoucCnbbyMEL8bllLtUsnqIMoyE0Bqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770017356; c=relaxed/simple;
	bh=TGnT5lbpo0tIDMxQINJrccn3qHJ6m6eJOH+UZBFcV+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrdhGEOYml3feusi9NjagJlG+86kgeW5VNJ5UGHZfNlYeeqi27dITg13XG7choT/mXCKxVdHaDYFJt5JXNF6H4qQhoOc1OXgWyRpdRtc1xfN+oYy219yZkbz9ObDyxOSbXCk6Kum+kyRukPRn5OffGfSRkawzXe+2wJZUGMjM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLH0oj4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A06C2BCB1
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 07:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770017356;
	bh=TGnT5lbpo0tIDMxQINJrccn3qHJ6m6eJOH+UZBFcV+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WLH0oj4KqX2ig0SPDTUKIczlDHH2/doqWdv+mhA5O67RZr7TMuvBhnMc1tDraJnWQ
	 yxQLqT7uRHJxGzjtBVsxiEa6AuuZSWdmhHFh5qXpV3AtDJW0NghuDn32DD4lZb9soD
	 oYSWmTjKqXAtgl7KNJ3N/zjDYLY8IdPyMKleiIlxFfIVwdvnWgREzls+oF1aBIXQuQ
	 MdbQlVZobX9GZdLWykwYbQ7wMOplHovwminx6DkwC6P2ei2PkPFLFJA6WNonLsTKGw
	 QuImiLcqtaXQQTRDND1Io8gQR+4LzBYG7di0THgj0/e8dqOzIFHQ5h9W2PyOcNWmKN
	 DfAywDkyH1mPQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so6658246a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 23:29:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgY+ei2tkfiER23c4JgVWCG7iVeTVvvFlL+HLpfZ3C+EEHO6UAX42dDroflRPwAiGo+xGNCD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUpylT/yzMPFfcrIsbjzJfYyKpEN3q650R1mJQvdvwAAZMPkz
	no3NxXHu/EAZxg0Cuf6OjJs1FBxi8XDFOG5mvX2cYDy70MY+FRRpvmpw8xNPFQ06LZNrukAnf34
	a79YZxATIPSswdd5l8h6zWekeSnYdfoM=
X-Received: by 2002:a17:907:9491:b0:b87:115c:4a30 with SMTP id
 a640c23a62f3a-b8dff5dbcb0mr601744366b.16.1770017354475; Sun, 01 Feb 2026
 23:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201023619.366505-1-chenhuacai@loongson.cn> <524246d9-bc9b-4d65-814d-d544b53bcd0b@linux.dev>
In-Reply-To: <524246d9-bc9b-4d65-814d-d544b53bcd0b@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 2 Feb 2026 15:29:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5T=1FefitLWSf5Qw3HEwFO0ERhefq1udae6mt9tq+ikQ@mail.gmail.com>
X-Gm-Features: AZwV_QgGzJgYG70N5fLwFnRgnJT1H2uKpZxrzyYmWtqkr7Vxb0F18smoBxNIzhs
Message-ID: <CAAhV-H5T=1FefitLWSf5Qw3HEwFO0ERhefq1udae6mt9tq+ikQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: Correct spelling from clk_scr_i to clk_csr_i
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Serge Semin <fancer.lancer@gmail.com>, loongarch@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-255754-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[loongson.cn,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com,synopsys.com,gmail.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 39BA8C92B8
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 9:36=E2=80=AFAM Yanteng Si <si.yanteng@linux.dev> wr=
ote:
>
>
> =E5=9C=A8 2026/2/1 10:36, Huacai Chen =E5=86=99=E9=81=93:
> > In include/linux/stmmac.h clk_csr_i is spelled as clk_scr_i by mistake,
> > so correct it.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> fix tag?
>
> But this is just a comment, no need to backport it (I'm fine either way).
>
> If no fix tag, please update the subject to typo fix instead.
Why? Is the subject line wrong?

Huacai

>
>
> Thanks,
>
> Yanteng
>
>
>

