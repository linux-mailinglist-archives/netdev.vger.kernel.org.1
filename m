Return-Path: <netdev+bounces-278516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJlHNm1g3mn+CQAAu9opvQ
	(envelope-from <netdev+bounces-278516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:42:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D882C3FC0E6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E06193032ABC
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6F83EAC8A;
	Tue, 14 Apr 2026 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hcJLcAVt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F13D902A
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181222; cv=none; b=Blp6+oAdUio6P+K2mA4NQtz1pAk3sg4vgoc9cOXYSxlc73SUjJJdnDc+Ci/HXtf//LdsEMDsHNcr1wZWjIjMFD9o9NamWFMk8nqyj1F5aQiHbCtBiFOJ5nZYy7aeI6YSavQY2uofsMdAXcuRwN8/0WyTaHuQ0h8hEp1BYcWD0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181222; c=relaxed/simple;
	bh=hNEgoftVnqoHxChDeFRkfLMjkNJ9rWqwQSFm616iVJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiyJzk48u73KMlpIaT95yj4HjVes3jvF/mrJKn+Zh+bgmPd9+p2/m6em4h1gpseUH0UuGi6+AI3bNJ0eaF4aUYuy/lgoBO+5wk1SWqfChF51Bztf0NyUVj+jdmBIFey10f19J7MaIX030pwm5fZiqZEdfLRmp6o0tMj/nV338Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hcJLcAVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA59C2BCB3
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:40:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hcJLcAVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1776181217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNEgoftVnqoHxChDeFRkfLMjkNJ9rWqwQSFm616iVJo=;
	b=hcJLcAVtp/lhy/6qIa1d586uxjXRaJek6BpZ1pAlo0kTkFQH9N2T9hhEBIRQU3VeFAjVIa
	78Di1AG3BY8qK+sMyc0zYhpQk19/sEi1mi4TLsdfxHwBE9ED8+8Ni2sFqQJol9FMzW+5Ee
	JxI477YaSaXBqowBXv8pHArJZkKaD4k=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 24fd0403 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Tue, 14 Apr 2026 15:40:17 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4779b2497b4so3012603b6e.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:40:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8OjHTnF8EIuVQ15QRV5Wh66v/+zkkS4kGCNFUweJBUaUB4Ke2Oa2SoXsEbk+54NAuUAFv3Mys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFEbsU0s/HO3RLDXJinegezJKmB9ZReKTECMOgz4ceACQ+8NR
	cThRFqMdILfoM44EvD37IG3+7nnl5luU0SAXMs7FeqoOCUDATsf2VDxEqQ1TXq+xqZ1veukyzxC
	h5gUiyhtDA3qNe7BomNtSBnXqVXJa6nc=
X-Received: by 2002:a54:4386:0:b0:45f:2788:b006 with SMTP id
 5614622812f47-4789a7837a7mr6900130b6e.0.1776181215218; Tue, 14 Apr 2026
 08:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413151232.1004611-1-shardul.b@mpiricsoftware.com>
 <CAHmME9oXoXykXq_emkA3v8nG2VR28CmRP2+WmhrvGJc0ZbPfpA@mail.gmail.com> <20260414081824.0edf6113@kernel.org>
In-Reply-To: <20260414081824.0edf6113@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 14 Apr 2026 17:40:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9rwKae5b9PYzuqmwG3p05iZ=jqyp6LQefg0OsB3OP6oWg@mail.gmail.com>
X-Gm-Features: AQROBzDS9-WdOFRB3RLO4RUiIqKfEG5TSyNuS3pFkcbRNyBINYjricSkOHLuOXs
Message-ID: <CAHmME9rwKae5b9PYzuqmwG3p05iZ=jqyp6LQefg0OsB3OP6oWg@mail.gmail.com>
Subject: Re: [PATCH v2] wireguard: device: use exit_rtnl callback instead of
 manual rtnl_lock in pre_exit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>, kuniyu@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, janak@mpiric.us, kalpan.jani@mpiricsoftware.com, 
	shardulsb08@gmail.com, syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278516-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,google.com,lunn.ch,davemloft.net,redhat.com,lists.zx2c4.com,vger.kernel.org,mpiric.us,gmail.com,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,f2fbf7478a35a94c8b7c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zx2c4.com:dkim,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D882C3FC0E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 5:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 14 Apr 2026 15:28:37 +0200 Jason A. Donenfeld wrote:
> > Thanks. Applied to the wireguard tree, and also added the missing
> > __net_exit and __read_mostly annotations in the process.
>
> Hi Jason, while we have you - do you have a PR for us for wireguard?
> We're going to be sending the net-next PR later today..

Sent!

