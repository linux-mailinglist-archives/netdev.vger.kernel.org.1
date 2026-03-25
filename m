Return-Path: <netdev+bounces-271573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAtkHrjsw2kAvAQAu9opvQ
	(envelope-from <netdev+bounces-271573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:10:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A253267E9
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1196531D0A61
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2163C342D;
	Wed, 25 Mar 2026 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pVqRGZeb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOjhDuXi"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4143A7F7E;
	Wed, 25 Mar 2026 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446556; cv=none; b=XTELGg3F7t25dsH4PXPKcc49Tp+kiM3fMX3YHlhLO7bCZlXUORSAMTYpULiTgQGUwlyg/ZVb9OlEXx4eihbrXgTYEZX8fuz1VleQ6rSdufzAU5sbJvFe18sjfU1JG1ngvdtUGDFNaigYci7Wp8imdAt8qiPDAqmCoeBK90SOJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446556; c=relaxed/simple;
	bh=RUVqa+RRB+Blgh5kTh82WxFI2rrCB+MaiOvjcswq+IM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kQOE1iZDWrd68SRn6klaExpQfTq8JztnqlcNA89UEx6AQJZGfCVtbEDowOTqyRXQRsN8u3LsFO8lgA9F0/6g/J/QDci7zQaI6OCSHljRQjkPf4lH+jbhgrnWfHuVhHTefRu8oCaWH4pdzgPKA/nPRJjI1jbjAdp0HMJReBliOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pVqRGZeb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOjhDuXi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9336C140026D;
	Wed, 25 Mar 2026 09:49:13 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 09:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774446553;
	 x=1774532953; bh=O+42aIe44EcreLEetKhLjOBvDrCC6rqqhKNt49YXH4Q=; b=
	pVqRGZebhPRXE6f3bg0KhoR2GHdVjAaILOUwqgo1ygjqene8boQbNyCbJoaWSZRv
	tLQUNYzVvvl0o3+vNi2Jzrdn8wGbXY6MIn9KsH+l6HnRsP+PyyPT8BlfuounV/ej
	7niisDuN2+YFfkhwY/unERP1JpkZkDCeGrhegz9NvlMSsuFt+PNsBkq7HzmNIaPK
	woqySohItriXfpnP2SI1VCNos5oV+mqsPda3Vxgb0F80lIaJcxbCU8X1NEMRNPkv
	E+WlR2VSJFQm552VxrdlVC5l1TDTHSpaUKIWFA25nd12tMfqvlhWxDOeEytyG4mR
	inj9ymdB2JLWlR6abtminA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774446553; x=
	1774532953; bh=O+42aIe44EcreLEetKhLjOBvDrCC6rqqhKNt49YXH4Q=; b=d
	OjhDuXiALqQ2qDUuOjVzUM9xt+ZEz3J/ddcaDIB8JNXzcvnDBKn+aXDJYFWFJns2
	wdKjuZ8FW/CThhbT8BDrlT+PhgGlXlEkzrJZNUQ2gdhVH1qQOBB7p6ElOen03p6u
	KHWjIdKt8BDJO8r5wlg9XGGeh/c/1+sZ2skRylbc+TOWdhy8vFHp0VQFlWqaEvsD
	SuYLIIpOHPyS1bVsaJCu6AvgNXXrIZLdXlgX4Ugg8/RLThqOMhuZ1/oN0UGmMIk7
	ITIPY+yPd617wsis/k99bw1UIgyipHS01iS2bg+CukdZznzp7pcqf/zsXVdNiQYF
	U3kQ6uy8GK3SFEDRPMKZA==
X-ME-Sender: <xms:2efDaaHDU-hatmQ3Br6wewb_Xol2ZCD4wNFXP-0kP3xnizUTq1b_vA>
    <xme:2efDaWLFZ_99kDKcod3cE80WE_nualNVzfRHqyYUS10ISYt2l8YVz4hru-MUAMjtF
    91tOteD4MFF9iAxiEGFGnbjPl2YkBz6QvezioEiku_Q6Uhk9eTcE9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsrhgvthhtrdgtrhgvvghlvgihsegrmhgurdgtohhmpdhrtghpth
    htoheplhhinhhugidqnhgvthdqughrihhvvghrshesrghmugdrtghomhdprhgtphhtthho
    pegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhgvihhtrghose
    guvggsihgrnhdrohhrghdprhgtphhtthhopegvtghrvggvrdigihhlihhngiesghhmrghi
    lhdrtghomhdprhgtphhtthhopehnihgtkhdruggvshgruhhlnhhivghrshdolhhkmhhlse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehmohhrsghosehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:2efDabmokKFV15gfzsfCwsEW9HkE-fWDdrydGIfyHk86Wte8JzsuTA>
    <xmx:2efDaatbvZZ-b92Id--vGcYBhevs12HLTpFh4slY_yhAiRjbBAJu6Q>
    <xmx:2efDadKQsyNeWN5nfdAhsvFuzR-9-fn8-bZxnTjolzvLKX7wsRNVOw>
    <xmx:2efDaXg_nHgTC0oNhTVRgHjHvNzt9yotoIWjFGx6V_GOAQgRBJY9UA>
    <xmx:2efDafXl9Hz2NTMf0JBHsAIrp6areKtNhickN62SgNg2pBt4pC59WCbT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DEF6E700065; Wed, 25 Mar 2026 09:49:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aywyuz1KiUOB
Date: Wed, 25 Mar 2026 14:48:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Edward Cree" <ecree.xilinx@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Jeff Garzik" <jgarzik@redhat.com>,
 "Ben Hutchings" <bhutchings@solarflare.com>
Cc: "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Brett Creeley" <brett.creeley@amd.com>, "Breno Leitao" <leitao@debian.org>,
 "Kees Cook" <kees@kernel.org>, Netdev <netdev@vger.kernel.org>,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <eac3d942-6378-454f-81e7-0d5936a3f6d0@app.fastmail.com>
In-Reply-To: <9763c19d-131c-45ca-8976-a6473539240a@gmail.com>
References: <20260320151924.3474821-1-arnd@kernel.org>
 <90a03d3c-def3-4e34-89a0-6e952d3b0d7a@gmail.com>
 <61de3aea-26b3-4c00-8598-3a137ebef1bc@app.fastmail.com>
 <9763c19d-131c-45ca-8976-a6473539240a@gmail.com>
Subject: Re: [PATCH] net: sfc: avoid format string warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-271573-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,solarflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,google.com,amd.com,debian.org,kernel.org,vger.kernel.org,lists.linux.dev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,lkml];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17A253267E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026, at 01:22, Edward Cree wrote:
> On 20/03/2026 20:48, Arnd Bergmann wrote:
>
> That would work, but all those -1s are a bit unsightly.  Like I said,
>  I'd rather have two different efx_fill_test() functions, one which
>  takes a unit_id and one which doesn't.
> (Also you need to change the kdoc description of unit_name.)

I sent a new version now, tried your suggestion but ended up with
yet another variation where I preformat the string in the two
cases (per driver) that actually use a nontrivial format. This
ended up simpler both four the source and compiled form.

>> There are not a lot of good options here, and splitting the line seems
>> better than an overlong line to me. I don't really have a strong opinion
>> on where the __printf attribute should go either, but I do see that
>> after the return type is probably the least common, so I'll change
>> that. How about having the specifiers on one line and
>> the type in front of the name? that seems faily common.
>> 
>> static __printf(7, 8)
>> void ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,
>
> I'd rather just have
> static void __printf(7, 8) ef4_fill_test(unsigned int test_index,

Done.

      Arnd

