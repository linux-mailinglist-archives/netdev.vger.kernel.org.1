Return-Path: <netdev+bounces-272965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIGvDpxryWnqxwUAu9opvQ
	(envelope-from <netdev+bounces-272965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:12:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B8935391D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F7383003997
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7083137AA7D;
	Sun, 29 Mar 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCWcJKxC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D7285CAD
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807962; cv=none; b=BXMKnjiFz39RcPoDLiXTUunRjbJ+mc/CQLLp9fT9pe7UrXJecTZWskP/ywJMeAiOMcC4MCTKox5vm1TRZwxYaQMXASmEacvQu/0PlJiVCBPvNX0JzelEk2BVf9a/D1gxWXtPzIgwCgKKA3YBTICTNo1HYlF1U/QHiB6UTkZJdwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807962; c=relaxed/simple;
	bh=bwmFA2Nt21aYmIFe5PtTEfsfYbDoECPEHfjenb9wDRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gk/hxCkW/pj0Emxn6baQstSop8vzG2OtW0nlqFsbzBq3IcI3LAqFiSjYzTIljYYaf76TCEWlgB6LyL9vx7qcLfjy0ClBbk03rtSA1WiFNh2Mtor0yPVsOPjz+zOSJ+J/Q8vDfeQ60RJeQX6c6TXQj//GWdUI02pDtyvX2rIgFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCWcJKxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69763C116C6;
	Sun, 29 Mar 2026 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774807961;
	bh=bwmFA2Nt21aYmIFe5PtTEfsfYbDoECPEHfjenb9wDRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OCWcJKxCUJh7GpFjNKIJhSy71gvxutPYzpC3EdwVUac/V/qW8DctrakWtkvkpIYIs
	 nFJzT5DiCal1Z+BQarzKjo6wjw6DeDoPzrVXVTu/gm1yPD9jI6YPQO7jqi+Ls+eN17
	 ASfbOgJTDk+iwNOQR/1XwIvekAK8cWDgTGiRdMjbVnw+9P4wLKC0bq/7qXFJiIhuue
	 FnsWEU98TwNGi8WDEyyE2kXnXp5ENcmwefa6hyKgTyFwhlGzaaZPqP4stoyQFyfciS
	 TIHO3HaWN12PUO1SzO9IYMQdkzFIIK1G+m7iAk1BtqImSEnankmKaaRmfc4a3ucJ0x
	 HM4MOrhNy/jSg==
Date: Sun, 29 Mar 2026 11:12:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Wei Wang <weibunny@fb.com>
Subject: Re: [PATCH v8 net-next 0/5] psp: Add support for dev-assoc/disassoc
Message-ID: <20260329111240.67e6f097@kernel.org>
In-Reply-To: <20260329041922.3850747-1-weibunny.kernel@gmail.com>
References: <20260329041922.3850747-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,kernel.org,fb.com];
	TAGGED_FROM(0.00)[bounces-272965-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4B8935391D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 21:19:16 -0700 Wei Wang wrote:
> The main purpose of this feature is to associate virtual devices like
> veth or netkit with a real PSP device, so we could provide PSP
> functionality to the application running with virtual devices.

Does not apply to net-next.

