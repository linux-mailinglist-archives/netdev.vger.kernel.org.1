Return-Path: <netdev+bounces-260662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKIOJbIhnmnWTgQAu9opvQ
	(envelope-from <netdev+bounces-260662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:09:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4C18D0A3
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029413008D01
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ECB33C195;
	Tue, 24 Feb 2026 22:09:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DE3358A9
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970955; cv=none; b=gsrjCN5lJYthUq3b44sJvS8G12RcRKbi14CaQjPwOJDhpz43oz2JiWYEA70UrI8AD1L41Cinp3P8naWiPu98Z3/pveP46ZJRwoWu84F89IG9sEiqn/4LAv5tZ/OXoQmbkpsXfCLUelTpURbBoVpVysCGdJcd774g67ZgWXW+/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970955; c=relaxed/simple;
	bh=k2+M4hVyUmwplnKUGUYz0nBAqIoxso7XBtSP7k8gCMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3pjMWs3B8BL0nhi3jwZQRJSUl/Bh26YKz/5zhVFvWE82e8KGoeHhvxblx7pOu1ebIQh578ep4M3YoLgKrEP4Tf7OEPNbtQi1JGpMN96evilhaFRinSfimWuLbghV1gtyeIbqdDA6chaf2BifhBIJFZWshlFk/3dCoWddCxvHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 589C860D11; Tue, 24 Feb 2026 23:09:11 +0100 (CET)
Date: Tue, 24 Feb 2026 23:09:06 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v20 net] net: pppoe: avoid zero-length arrays in struct
 pppoe_hdr
Message-ID: <aZ4hgh73UeHHd1gD@strlen.de>
References: <20260224155030.106918-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224155030.106918-1-ericwouds@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[earthlink.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 12C4C18D0A3
X-Rspamd-Action: no action

Eric Woudstra <ericwouds@gmail.com> wrote:
> Although it is needed to prevent warnings caused by my patches send to
> nf-next, it was asked to send this patch separately to netdev.

Yes, thanks for doing that.  While I occasionally do send non-nf patches
in pull requests, thats usually restricted to very small functional
dependencies, e.g. a new EXPORT_SYMBOL().

Dave/Eric D/Paolo/Jakub - this change can be applied to either net or
net-next; it avoids W=1 spew with patches under discussion on nf-next.

