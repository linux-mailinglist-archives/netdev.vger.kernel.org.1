Return-Path: <netdev+bounces-303357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WWEYOWQhRGpLpAoAu9opvQ
	(envelope-from <netdev+bounces-303357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:04:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 224246E7B74
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:04:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LvFMsP+9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303357-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303357-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8D043061632
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022B23DA5CF;
	Tue, 30 Jun 2026 20:04:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F0F3E023E;
	Tue, 30 Jun 2026 20:04:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849873; cv=none; b=ouJm0k0gPnq9DMPXsB8rlDLuVciBSbPWGvc2XYViFE6dfrJf4pl3g7SWQj+GnNO+caWiZoaWo9i3LBFA5Cbnmd8PeIEuIgo9dHunCZJKlFzBG1LmcUSYJzQyaWRDpPzhv8ulPpbzMbyvYwVxRp0OsWVH4Qc9KLlQcLzjFhZFsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849873; c=relaxed/simple;
	bh=uuR9+/Mqv6VzcB/o9cpudXm09xHl6MhhQ5yODAPtFgg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Eu1VXr6T1fN9Cqv9jHi8nZ2eXT2/BAvfb9OWi6gvy8de7ZNKWxpRC42LYsZSd+pPjMKzhZupn8G2koVeTwhU61plcuW5+8wEkK8PJSDjdU0rgfRpeuakYQslMzE2MdF3wI/w0bVqKVYLDVH9clATXLVp75kqqi/AxeOv8SxkrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvFMsP+9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C694F1F000E9;
	Tue, 30 Jun 2026 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782849872;
	bh=uuR9+/Mqv6VzcB/o9cpudXm09xHl6MhhQ5yODAPtFgg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=LvFMsP+9EeXKmXvFaZis9G2VLobXuWWGjGttLFjwM5011HTqQy38WMRVErXAfdps7
	 eGPsh7PUxStS3iKwj49mbjtCP+1R3NBTpwApg/bHfRo0U44e+/oeH1/Zf16AA8OKDz
	 f8cttZVjSDfUDywj2m19emj+BWBDVmhwO5zc88MFqBaL2VfjWunrfQjS/Hx+omw02L
	 1oMgJ4vCZ545huYVOLULqvx4FE7xBxKLlwW4KDlC5USJ42ORQA4rqamDCuH1aws4mw
	 kv+UjH5Qee0Ke6XdCUYR069j24FUc7BT3FZkPRcYgJkfa3j4oQBqwcgTf6izfltotW
	 sv1vk5zFmYCKQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 22:04:26 +0200
Message-Id: <DJMNJ5OPEMT0.1H4NP8NJ7JETR@kernel.org>
Subject: Re: [PATCH v2 5/7] pci: make pci_match_one_device match on ID
 instead of device
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
 <20260630-pci_id_fix-v2-5-b834a98c0af2@garyguo.net>
In-Reply-To: <20260630-pci_id_fix-v2-5-b834a98c0af2@garyguo.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303357-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 224246E7B74

On Tue Jun 30, 2026 at 1:09 PM CEST, Gary Guo wrote:
> There is a need to match just IDs instead of against devices. Thus rename
> this function to pci_match_one_id, and add a pci_id_from_device helper to
> make it easy to convert users.
>
> Similar convert pci_match_id to do_pci_match_id, however the existing API
> is kept due to quite a few users.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

