Return-Path: <netdev+bounces-303348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kBH4ETYdRGqjogoAu9opvQ
	(envelope-from <netdev+bounces-303348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:47:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FA46E7A38
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:47:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IzAp5xBE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303348-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303348-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 318D8302BFE5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9653DFC8F;
	Tue, 30 Jun 2026 19:46:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7BD3C4154;
	Tue, 30 Jun 2026 19:46:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848815; cv=none; b=kpeOLDaYecyO3HTTJ29dYJ+w4RDOSVXa5Imzn4Zdhpwm2QFFMPPCMo9cmT+gNt2R7igcfkcFuw43N1pYJ/o57D7lORQPjSDpw/XusugeQqRyRCVCPceyIkFOk7KVAadyGU8Vfh1AkAuhBaQS7LbwMn9MDMDpHrzj4x2PXqIikDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848815; c=relaxed/simple;
	bh=dPWWumFbEV5yA3udEfWNt+0vEpK1URSqyUAkaq+3HAQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Hw5uDpFXnZ2mW+q89P/IFrc0vuuEClL4RIH/lGxzXB1HNghKlvaZafKLj4kNxM21n9iag5P7PZ7fcqQTIZSMEEOl3ZK3ONDgxQrc70DfdF+j/eGo9ovXBigHTkdhdMR1NPvdPHayeq8wNWej6bbB1d3vWYIJsOdw2auWNt/mChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzAp5xBE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A68A1F000E9;
	Tue, 30 Jun 2026 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782848814;
	bh=dPWWumFbEV5yA3udEfWNt+0vEpK1URSqyUAkaq+3HAQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=IzAp5xBEJGJQptQ5UMwMw4MhsshLrt31YLvU57xcLhOn39OcNMheAlXXFayLySHIj
	 cnclQ6JZ15+RRDC+StrWDioDaPn+4fp6ArrE8G0Z423E3XEXTREAiq2UvRB5vRk0Ov
	 /hv5yW/hjmcAou+oC2YsaraneRj8TL/lEr//ghoLNMNOlzSJZi9uRfv+CWiozavXJ4
	 SOcclaeWHBLmH5PK508WcV2Sx9mJhYch0ODD6QyGli/BLSNLQP+a81ZGsRqdAxlob4
	 ryfWFa6hFoSn1TJ+xwTuDeCLkqQ3ZFhNM2IOQNZmQNH4VLapU14vnXFmUjBdiBYnf/
	 JPAuYf7XkPQkg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 21:46:47 +0200
Message-Id: <DJMN5NFA766Y.1LSK7LF1Q7SL0@kernel.org>
Subject: Re: [PATCH v2 2/7] nsp32: don't keep pci_device_id
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Zhenzhong Duan"
 <zhenzhong.duan@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Damien Le Moal" <dlemoal@kernel.org>, "Niklas Cassel" <cassel@kernel.org>,
 "GOTO Masanori" <gotom@debian.or.jp>, "YOKOTA Hiroshi"
 <yokota@netlab.is.tsukuba.ac.jp>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, "Vaibhav Gupta" <vaibhavgupta40@gmail.com>,
 "Jens Taprogge" <jens.taprogge@taprogge.org>, "Ido Schimmel"
 <idosch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <linux-pci@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
 <industrypack-devel@lists.sourceforge.net>, <netdev@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net>
 <20260630-pci_id_fix-v2-2-b834a98c0af2@garyguo.net>
In-Reply-To: <20260630-pci_id_fix-v2-2-b834a98c0af2@garyguo.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303348-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dakr@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:zhenzhong.duan@gmail.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dlemoal@kernel.org,m:cassel@kernel.org,m:gotom@debian.or.jp,m:yokota@netlab.is.tsukuba.ac.jp,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:vaibhavgupta40@gmail.com,m:jens.taprogge@taprogge.org,m:idosch@nvidia.com,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-pci@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:industrypack-devel@lists.sourceforge.net,m:netdev@vger.kernel.org,m:gary@garyguo.net,m:zhenzhongduan@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com,linuxfoundation.org,kernel.org,debian.or.jp,netlab.is.tsukuba.ac.jp,HansenPartnership.com,oracle.com,taprogge.org,nvidia.com,lunn.ch,davemloft.net,redhat.com,vger.kernel.org,lists.linux.dev,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3FA46E7A38

On Tue Jun 30, 2026 at 1:09 PM CEST, Gary Guo wrote:
> pci_device_id is not guaranteed to live longer than probe due to presence
> of dynamic ID. All information apart from driver_data can be easily
> retrieved from pci_dev, so just store driver_data.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

