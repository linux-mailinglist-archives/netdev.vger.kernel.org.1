Return-Path: <netdev+bounces-294843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bzEGLvZfIGpZ2AAAu9opvQ
	(envelope-from <netdev+bounces-294843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:10:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0824463A0ED
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:10:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=Vjg8N7bN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294843-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294843-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24763173A04
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B49438FEE;
	Wed,  3 Jun 2026 16:52:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2BF44D696
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 16:52:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505576; cv=none; b=WB9nNUQVVNukFhRaGhWSoMYkecrl46k6wDbBG9nLNy6FLVhsKv0NgvHyRgN+mk7QG9yW6CDT2krZyyzCXhhybjsKzRPLk/pqpvLcQt9Xa4taQhTTmlieOtZZSfBcNKMzvK1MSqrbtAdAZ3DD4jzclmk6/NM7rsTH1q+uR6ip4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505576; c=relaxed/simple;
	bh=yfF7RMfFdw06+Jz0bfgKvLOWZz3Jg5V//OUWt61idJM=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=EveXuqgWm3QVinxBCWnWBMYbSBsESe5QmCgZpzhDuKpEoflTqb42FLFN5LCag687zc5ckGFXCg/QcytRzbe7Qlx7cmbapEMk4c8gcDT1Qu0A2nUCiJM8E4muunfqzlFYc7ojbhrqWt3aH83G4VZZaD+rNZplGS3GvLKPEcrdozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vjg8N7bN; arc=none smtp.client-ip=35.155.198.111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780505575; x=1812041575;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=Zp53lq8ckUqXmbXUKyvx2zMGiwCcsDDn+qDyATKk6jA=;
  b=Vjg8N7bNFpYMzIJj1gGq839eNAO2c0W7bEC/vs8MHgFUgHPmA/OeBjRD
   ryPiRpCPVAfsQrdwewiTa3uGC6PFphEZYPyJp+ilWU4wCu7DKUt/g1W1n
   V9Vj8H/YDcFA3O8FYlclM6+QgpFMv1H/tWUla21uqUyZ7lMZb+T2Eeulb
   g3VqD0hkS7lWZn852ftI0eZUDefUEr5jtgIWfYi0rY/NvLqZhBZFzSCLV
   0izzgaE7gkCm9rISH2P5aksCTzmyBjNObqNS1RUQZaFSe2FUNS/25LLMB
   4mqSgYuUpgJ/tPOIMybYIwJ4rrnS1ARsIbGPMmO94ExCqbJ0WbrYhvO5U
   g==;
X-CSE-ConnectionGUID: An43yZ8wT6eYVt/Ngg96ew==
X-CSE-MsgGUID: YAKiJjiWRfeOjxlAlSBlhw==
X-IronPort-AV: E=Sophos;i="6.24,185,1774310400"; 
   d="scan'208";a="20909992"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 16:52:52 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:6227]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.245:2525] with esmtp (Farcaster)
 id cc8d6ef7-ac36-4325-8920-7cc673ebab41; Wed, 3 Jun 2026 16:52:52 +0000 (UTC)
X-Farcaster-Flow-ID: cc8d6ef7-ac36-4325-8920-7cc673ebab41
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 16:52:52 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 16:52:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ena: PHC: Add missing barriers
From: Arthur Kiyanovski <akiyano@amazon.com>
To: saeed bishara <saeed.bishara.os@gmail.com>
CC: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
	<zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>
In-Reply-To: <CAHfVqdVpvEF6PXCqSu_Of6SkQY+Uv0b2C1K-0xrgV3Cyg-RcqA@mail.gmail.com>
References: <20260603065532.13260-1-akiyano@amazon.com>
 <CAHfVqdVpvEF6PXCqSu_Of6SkQY+Uv0b2C1K-0xrgV3Cyg-RcqA@mail.gmail.com>
Date: Wed, 3 Jun 2026 16:52:41 +0000
Message-ID: <178050556194.6110.12215070734658422269.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:saeed.bishara.os@gmail.com,m:akiyano@amazon.com,m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:dwmw@amazon.com,m:zorik@amazon.com,m:matua@amazon.com,m:saeedb@amazon.com,m:msw@amazon.com,m:aliguori@amazon.com,m:nafea@amazon.com,m:evgenys@amazon.com,m:netanel@amazon.com,m:alisaidi@amazon.com,m:benh@amazon.com,m:ndagan@amazon.com,m:darinzon@amazon.com,m:evostrov@amazon.com,m:ofirt@amazon.com,m:saeedbisharaos@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294843-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0824463A0ED

On 2026-06-03 15:20:52+03:00, saeed bishara wrote:
> On Wed, Jun 3, 2026 at 9:58 AM Arthur Kiyanovski <akiyano@amazon.com> wrote:
> 
> > Add dma_rmb() barriers after both req_id completion checks in
> > ena_com_phc_get_timestamp(). On weakly-ordered architectures,
> > payload fields may be read before req_id is observed as updated.
> 
> sounds good, note ena_com_reg_bar_read32() missing such a barrier,
> probably can be done as a separate patch.
> 
> saeed

Thanks Saeed,

I agree, will spin a separate patch for that.

Arthur


