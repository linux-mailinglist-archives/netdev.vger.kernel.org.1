Return-Path: <netdev+bounces-303347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9AIuBA4dRGqfogoAu9opvQ
	(envelope-from <netdev+bounces-303347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:46:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 973586E7A30
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:46:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FJ20vSwT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303347-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303347-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DB8D30439A8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA22326D65;
	Tue, 30 Jun 2026 19:46:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A18305E3B;
	Tue, 30 Jun 2026 19:46:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848775; cv=none; b=D6+dw3gU6ovoNgv/zBI53M4ZxaenvpX8ztf5t1EuaBpaFBRGnDsEfN6YxsMq/M6+PVhJm+ga2FegmwjjboqXcYEeScqSnjW5hpicMnPivlUTS90fqYWBEScPtJwyn1cI/ztPBkLvje5fdyeorJYne3Nnj9TjGEXInamjF298I2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848775; c=relaxed/simple;
	bh=dPWWumFbEV5yA3udEfWNt+0vEpK1URSqyUAkaq+3HAQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=gigUuV/0sPALrH+MEDQNuYYa0uOzIViwB+j4Y/OZ1W/H3lsgYS8FxCF8XC65CMMFo2puwSCiIcz+aaxWoG+jEO8x4BILQYoOnxKRQcTHGfQH+Jkbd9aHiAQ+TWWXY6OyOVMb3MOEudL7uXJgGHuiflEMDTQ/OJJC2785K4bvX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJ20vSwT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FB21F000E9;
	Tue, 30 Jun 2026 19:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782848773;
	bh=dPWWumFbEV5yA3udEfWNt+0vEpK1URSqyUAkaq+3HAQ=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=FJ20vSwTIuj+zL1oaENG1GDgHXhqE4i8U05sqKGaRqJnlSJN0cMjsLy58DXa+FN3z
	 HJ+Pk2EjfZIC8iaTF5EvE7RmD7yEyHuqqj+KMfFPzKwUbhVkA88OCueHpw2qbNq5dN
	 i7ww33FqK2t0wpv6jqmkhJRmHyW+nxUm+CDDLDh38TWjzVS+NJTSGhqU/TbADYqURG
	 nbW1MNRrilIrtR4RuSH72udhVzJiE0mLa+bBMmuf/CQJ/A/uqGAM9efRs6MJACp8pG
	 +S4ludzToioI7DR4eAJ4j1RdiaTu0xMW7etuiZRleIoBy3pF2jOIrpK9KyUF/xdpZI
	 /VpofDNkmsDPQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 21:46:07 +0200
Message-Id: <DJMN54ZANNUT.DYHPIRG0GGVU@kernel.org>
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
Subject: Re: [PATCH v2 1/7] ata: don't keep pci_device_id
References: <20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net>
 <20260630-pci_id_fix-v2-1-b834a98c0af2@garyguo.net>
In-Reply-To: <20260630-pci_id_fix-v2-1-b834a98c0af2@garyguo.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303347-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 973586E7A30

On Tue Jun 30, 2026 at 1:09 PM CEST, Gary Guo wrote:
> pci_device_id is not guaranteed to live longer than probe due to presence
> of dynamic ID. All information apart from driver_data can be easily
> retrieved from pci_dev, so just store driver_data.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

