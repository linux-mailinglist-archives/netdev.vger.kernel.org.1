Return-Path: <netdev+bounces-264825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMdGC9bmqmkTYAEAu9opvQ
	(envelope-from <netdev+bounces-264825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:38:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24496222D18
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86EC530515B7
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBFA331A57;
	Fri,  6 Mar 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVAxW3uW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF3271A94
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807651; cv=none; b=Y+EnM7unWcx6z5Njfj4QDjvAwHK0W4gk85zcKCaBtOEimF3Qw0w/AhuK277nHPv0nCEwCmHRe3DyAjlEdKn5A4CcxDThfTl9C5CNzNDyfp/LPD/XvMwWqlJ3kgQBjrfnZNaZsZFZZ0hPHlrbR/6nNsW6e2pMuou28nImI4FaKUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807651; c=relaxed/simple;
	bh=IUXM/V0vQQ1M7CEmIuWmH7ES1RuOyROTK/vGA3CMs0g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=p1GuJ1ewKJhWnlVbmm692wD7KY8iIFsF3lg4ObHnxPWHAY63EjeH0wHkN5ZPV5aKQCIo+zcANYnb3RFoEWYLqNCIq0rYQP+I7apbxyTnqIRLb5OpbraAHw6fHlEeNSTRWYX9dHw4YJ5re6l8ZA0GIrtcgiyHVtq0sBcRP5aZADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVAxW3uW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C96C4AF09;
	Fri,  6 Mar 2026 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772807651;
	bh=IUXM/V0vQQ1M7CEmIuWmH7ES1RuOyROTK/vGA3CMs0g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WVAxW3uWpKc+RfvyxXUgIE45h44j635gcBEmXyENDbxX5zzQg4rWVlLec7XApxiHa
	 eQxHejONc1R0+gJZ6nhxUzij//j8mqBW2cfsPNEpxIBg0dr1O6pfZM2f2cfytYUn9O
	 Aw3yoAYd93TcpxAHnm+eUafrWJfpD3X9joUn5L9a8S6ZIJQD4U8bZjfC5wID/+t3xo
	 FMdhLlINnpBLZZsUDbnM/lPLFmd/VnhbbXiA98+psXozVJmVaum/yjdrXeDSagiD4c
	 XYqn+ciFNM0q1vIzkddJcQgPHyOiFnlIzptXytvo/ujHEvfBalkVTQ+r+Nvb5lAl0i
	 fTDIdJ4mUvmwQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A6A3FF40068;
	Fri,  6 Mar 2026 09:34:09 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 06 Mar 2026 09:34:09 -0500
X-ME-Sender: <xms:4eWqaU1nrJoUkGZWuGnS_v25uA-FvzBB_tId48xBjXdlzQdR_cdo0g>
    <xme:4eWqaZ79wZwiS9rxF5C_YfFCqW8AcQYB2hEWvm3XDQ41a1s-dE7707wYhEGnEIZSa
    Q2qctY7rHy_eXzxEwJsd9-yhscROTX4hIKEvMt4tlJGzYVx40MKHp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieelheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthhlshdq
    hhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegthh
    hutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsugesqhhuvggr
    shihshhnrghilhdrnhgvthdprhgtphhtthhopehhrghrvgesshhushgvrdguvgdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    lhhishhtrghirhdrfhhrrghntghishesfigutgdrtghomh
X-ME-Proxy: <xmx:4eWqaXVeeS8QgXqC_JCYOXG0OdWL3lVuVgbNFH9dYkCPfqPSwseClg>
    <xmx:4eWqablTHqzuDsDlEIlH4dfoWPpZeWd94zluKAnahyYH580nu_jeTw>
    <xmx:4eWqaVkscafG_uYAJTd1CWBq3MOhoHdrw53ztWbp4skuoikQGMy-3A>
    <xmx:4eWqaTa4xzu6UAZMARiiiPAvV4lqdcBn36CY1yRFTfG32DjG8iO-pQ>
    <xmx:4eWqafTHbxDfQ2tPeN9BDZHjVcGjTXnk4oQrwL1f_rxsEc-skucuu9jY>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7CD88780075; Fri,  6 Mar 2026 09:34:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AmC1BHMyQyic
Date: Fri, 06 Mar 2026 09:33:38 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, "Chuck Lever" <chuck.lever@oracle.com>,
 "Hannes Reinecke" <hare@suse.de>,
 "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <34d8051f-b985-4d33-8e8c-52f6a6c1b445@app.fastmail.com>
In-Reply-To: <20260305141954.1f6eae5e@kernel.org>
References: <20260305211402.39408-1-cel@kernel.org>
 <20260305211402.39408-2-cel@kernel.org> <20260305141954.1f6eae5e@kernel.org>
Subject: Re: [PATCH v1 1/6] tls: Fix dangling skb pointer in tls_sw_read_sock()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 24496222D18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264825-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Thu, Mar 5, 2026, at 5:19 PM, Jakub Kicinski wrote:
> On Thu,  5 Mar 2026 16:13:57 -0500 Chuck Lever wrote:
>> Evaluating a dangling pointer is undefined behavior under the C
>> standard.
>
> Reference?

ISO/IEC 9899:2011 (C11), =C2=A76.2.4 paragraph 2:

"The value of a pointer becomes indeterminate when the object it
points to (or just past) reaches the end of its lifetime."

For the next revision of this series, the patch description
will include this reference.


--=20
Chuck Lever

