Return-Path: <netdev+bounces-303359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1XA+AmskRGqNpQoAu9opvQ
	(envelope-from <netdev+bounces-303359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:17:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C4B6E7C26
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:17:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oiAy+pYg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303359-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303359-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30FE2306FEC5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A898392C57;
	Tue, 30 Jun 2026 20:16:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC7326D65;
	Tue, 30 Jun 2026 20:16:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782850589; cv=none; b=OG8pMT1pVHQ575ToIGfsgSMxsOU0Ejxmk9TDN1w14wom3PY3z9aBZCKmfE61iuazE0Fio+nB3Gev1wCfMiFw+M7YcMOpSORZA3ruotjJOvmKVcZnW0lAdAnkDwL0ONTnjz2Lr8Yy+qw3U+IumooNle9LlpEHkvgqxqhkxnwiwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782850589; c=relaxed/simple;
	bh=fijCEL+ZCol4zwQKy1swij4Vs9reYyMa+XiDwC8T8cY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Dfii/7dRS53da+z+fRIfvHEl/09OfpFfB3u7jUkzkISrXa0c9+WRLa1nlXHKkJkOjw7VU/Qlk8B1ibno7I/onhz10oX+waYhabwUIjL+QmEx0Kkx9RzcD+acuzWQ+wAO1QF0W1QVfyjip33pedBV9IuqmruEMlosLUkrnXpc27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiAy+pYg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28241F000E9;
	Tue, 30 Jun 2026 20:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782850588;
	bh=Yiv0rscKmYbfa3JPkJvPHxwZQJrcYMfeu4v/Uuk4gTs=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=oiAy+pYgiWtbABVQgDNJ9zh/RWJV4Dpiib0GLjYg7X4KM068jy5XYF8zpLtWAxBKK
	 iruoUfyzsqD3q/CtZey+yqbO67OddPNCLU0CrwjMWGHHzaxwAgBj1p83t6IITtfiy4
	 cjx9m0DPOC9vPoGaHyOCp5C5ENrGiU+WEIxYt21AqrEKK+N7ZcaCF7j6TUKAL1IvSw
	 nWzhrSSNM+mbr5VFmRN2jwhvM5+40nxMCP1OzLlm6vJZ8OEquLxaD1QLS3hyEbkzDx
	 ILlNLpxQz6DOrspMAR0o4fZrEb+7HhflqaktgtjxnC+za6658ckFpIhc7Ezq3LA3fL
	 G0XH8BE+nxTzg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 22:16:21 +0200
Message-Id: <DJMNSA8JSD9Z.3JGVBN740JATW@kernel.org>
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
Subject: Re: [PATCH v2 6/7] pci: fix dyn_id add TOCTOU
References: <20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net>
 <20260630-pci_id_fix-v2-6-b834a98c0af2@garyguo.net>
In-Reply-To: <20260630-pci_id_fix-v2-6-b834a98c0af2@garyguo.net>
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
	TAGGED_FROM(0.00)[bounces-303359-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43C4B6E7C26

On Tue Jun 30, 2026 at 1:09 PM CEST, Gary Guo wrote:
> +static int do_pci_add_dynid(struct pci_driver *drv, const struct pci_dev=
ice_id *id, bool check_dup)
> +{
> +	struct pci_dynid *dynid, *existing_dynid;
> +
> +	dynid =3D kzalloc_obj(*dynid);
> +	if (!dynid)
> +		return -ENOMEM;
> +
> +	dynid->id =3D *id;
> +
> +	{
> +		guard(spinlock)(&drv->dynids.lock);
> +		if (check_dup) {
> +			list_for_each_entry(existing_dynid, &drv->dynids.list, node) {
> +				if (pci_match_one_id(&existing_dynid->id, id)) {
> +					kfree(dynid);
> +					return -EEXIST;
> +				}
> +			}
> +		}
> +		list_add_tail(&dynid->node, &drv->dynids.list);
> +	}

This should use scoped_guard(spinlock, &drv->dynids.lock) instead.

>  static const struct pci_device_id *do_pci_match_id(const struct pci_devi=
ce_id *ids,
> -						   const struct pci_device_id *dev_id)
> +						   const struct pci_device_id *dev_id,
> +						   bool match_override_only)

Maybe something along the lines of include_override_only? At a quick glance
match_override_only could be read as "match override-only entries exclusive=
ly".

