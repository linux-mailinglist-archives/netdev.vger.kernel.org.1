Return-Path: <netdev+bounces-302072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TkMZENSQPWqP4AgAu9opvQ
	(envelope-from <netdev+bounces-302072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 22:34:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C83FC6C886B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 22:34:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MKlPw8L7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302072-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302072-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43B3F3045944
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EDD325706;
	Thu, 25 Jun 2026 20:34:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DC30C168
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 20:34:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419664; cv=none; b=SJLu4kbmL8bwm634mdtYz7QF6MB7W5T6M/0QQboyRQaUl9DMvfgT23hs8X6Hsi6dxAkB7Oj9rE7QMWdC6SoO1YaCvePQjNQ8GnWLh0d0ObpoqNQhlaOSMg0hkBW4uO+UBUtX8bvu+Az30eH8KscLv4jeX35J840CTAuO7nkwW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419664; c=relaxed/simple;
	bh=AriwsaM6suT1eAmIWEleERv96n9MOQrVF9D9frMAO0E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OIsqlw2ezK976pcuVUTLLs/Q+7inJqFB4OjBtb5n9MapExPaHVtsphFJJn+5UITNuRzZqMX7Pw7GGW1sbVlBNS166ApfI0wYpg8NIzfqKp9fL9YvJG7RGZB66KNnwTaqAvNc94JSCyWFsfTjX+vM9PrwQKpav7DXAFjCZexfCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKlPw8L7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9DB1F000E9;
	Thu, 25 Jun 2026 20:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782419662;
	bh=CrnZsQKdS7AAoGkjVlyYp03N5EaC8cZoPjFmjktE5jQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=MKlPw8L7auHUeGJcwc/p2yVWrAzmNTGCISd85pr/c05y2znMT7FBokSrAPUbdzjgk
	 pk/fo5ES30aCRAk/O/RGwzpRnvhsXMEzxyYa9EX0wD8OcGITYlSaXnQW0kjX7TsitS
	 11JHId9ZhBTnuuZOGHHc7NQyaOeRXhSKmygFr/mEI5ZAroL0/e9Tm/cuFP6AUCSqLD
	 NKFL2ooqweAfNu9y5yOKHOqzcO5CsOAi9YZcV/1AoxVkeSrHZlCf0DKsjFpOLcxhd5
	 pe4xn8e0TS3D4dBVH+/mVxJI4b9bzYQUBTB+MG2QNy0R4JzmhmHQXPjrzDalBWp52T
	 aivqw7rbDtQfQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id B17C9F40085;
	Thu, 25 Jun 2026 16:34:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 16:34:21 -0400
X-ME-Sender: <xms:zZA9auiNddFkDUacL1n-OZCnXn8IExBTNqnjjEyOtiRUunexrGzuHw>
    <xme:zZA9alh72TPtsUsGrIYlpGhqq9fMhcb2HZjV0gd81EUEA8rf9LVZJSlHs_TnUrdni
    Go2pX-4FRoxDJuvEEaZLUuOxawHgL6Rr2Q3X-GsGbms3E_ZPZRsUdc>
X-ME-Received: <xmr:zZA9akGfdBYmedOk4MlfeaVdkLSU2gN0XsRzN1toHHH468TNPOn4igGTiWBmhXk4Ya5VBRzsh0WRYOSCadNqgzscCpu0fsfrbao>
X-ME-Proxy-Cause: dmFkZTG1Rtwr/kj/aowLQ7EpBqqFteEV5bqwvGXyYuaw+PPIqcqsVof71imww+EIjZgbtN
    V2PpvQ0EREPhB/DRvbf8QBoTq6zb2fd1cT3yV8NXUpo2+uG0D8SVsOrix0W/f0J5mepRCP
    U2IBSeUTpYmfFLG+T6APBX9JZbftoOt8X3kNDBy17M86BqXiFe6CFd+Wh759lR7wt1sWVw
    27jStPFb70rWmHYKOZqddmMH0L6AxAvv1NEMcv7J5w+Uqeskt+t/dAFFZp2R8YqG55z0O2
    p3jK29rqZqiaBAj9IcHvqHWeR9O064SaUeuR+phimsf3sOz+YUoht9QdO1kROSxIogVzjb
    6V+cJCY2uuGpll0rjohUE6mGJiwLONd2rnKSovNTPg4UzBq63tpGm+P4XfRHUrFiIG/NJV
    jRgTvralUYLHgSbdKDOaiUxRdSNPbETlJnltGhIaPQzEKdO2XHj2HRp3dxsf7LTV1wqkxx
    HdSxzbk9LLDhWxipO7dk09Fw6IvLCPk7zOqbWXvfCMWgAGcrMamGErxotN3BxykcErPZsI
    WpK+kj71SG+uIG/ztK9y2U+qsDXpOFQJ5iipzolEebwSDuN99ASYXAk04gBKdvbCup7C6+
    jaex2wl1sE7DZbXREDw+SoNX5Q4B73+iYO0DHanaQSTYdUfWEZM3QRcbLCZQ
X-ME-Proxy: <xmx:zZA9aqCAUpI1ZfFFZE6ho79u24Gg9EqcRCUsXag5nOIef-lQ7rWprw>
    <xmx:zZA9aiBnHjpjjg7IHxGbgwGPySquzyQa5VmP7mP5p18jufcWqwRHjQ>
    <xmx:zZA9agOc3n4darwMNheIDrchnYhfW8My6jbVmfn9hD6bD8zmjQlrwg>
    <xmx:zZA9auNsLjnd3_UdRmO1uzHG4-yuTeNFUrFnRX1Ve6XZVMcsOqI5pg>
    <xmx:zZA9aiKWXHrPIN_K7a2WCK9_d8-Na6LWu_gW3EkiaV0aOQ3hewF_qbK6>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 16:34:21 -0400 (EDT)
Date: Thu, 25 Jun 2026 13:34:20 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>, 
 alejandro.lucero-palau@amd.com, 
 linux-cxl@vger.kernel.org, 
 netdev@vger.kernel.org, 
 dan.j.williams@kernel.org, 
 edward.cree@amd.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dave.jiang@intel.com
Cc: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <6a3d90cc4913_164f9d10070@djbw-dev.notmuch>
In-Reply-To: <b0a45e85-f42c-4a52-8223-f8318da10649@amd.com>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
 <6a3c55eea91d0_f12301008f@djbw-dev.notmuch>
 <b0a45e85-f42c-4a52-8223-f8318da10649@amd.com>
Subject: Re: [PATCH v29 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302072-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[djbw@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:alucerop@amd.com,m:djbw@kernel.org,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:dan.j.williams@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djbw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C83FC6C886B

Alejandro Lucero Palau wrote:
[..]
> >> +{
> > If you are going to have an explicit efx_cxl_exit() then I would also
> > add an explicit unregistration of the memdev.
> 
> 
> This is necessary for undoing the mmap. Nothing else happens there 
> because it is all relying on devm ...
> 
> 
> I could change the ioremap_wc call to devm_ioremap_wc, but
> 
> 
> > This would also fix the
> > Sashiko report about pci_disable_device() running while the cxl_memdev
> > is still registered. Unfortunately, mixing devm and explicit unwind is
> > always fraught.
> 
> 
> I do not think there is a problem here. The cxl core does not need what 
> a type2 driver can do regarding PCI BAR mappings, or at least it is not 
> the case for sfc.
> 
> Any action through sysfs cxl will go through cxl core and the only thing 
> linked to the type device is the CXL registers which are mapped inside 
> cxl_map_component_regs() and those are managed resources.
> 
> 
> So, I can not see why this change is needed. If it is really necessary, 
> please describe the problem with more detail.
> 
> 
> It looks like you need reasons for delaying this further ...

What? Help with Sashiko reports is an act of malice? I assumed you
wanted help with those so that other maintainers would proceed with
these patches. 

I did do another run through to see if there are any paths that the CXL
core can reach if someone tried to fuzz the CXL ABIs or kernel paths
while SFC is unloading. I think Sashiko is hallucinating a sysfs path to
the BAR mapping given there is no mailbox and the EDAC capabilities are
usually not present on a type-2 device. The RAS path looks valid, but
that may also get lucky that most (all?) of the RAS use cases lock the
device before accessing the registers, so devres_release_all() would
become consistent with pci_disable_device() before any access attempt.
That does not seem like a clean design, but it is also does not appear
to be immediately exploitable.

If you believe the patches are ready and the Sashiko reports are
invalid, please do say so, no more comments from me on this set from
this point forward.

> > Let me know if this passes your testing, and I can send it out as a
> > standalone patch. You could also use it to unwind if the ioremap()
> > fails.
> 
> 
> You did not read my comments on v28 ...
> 
> 
> I changed efx_cxl_init to make the driver probe to fail if cxl is 
> supported and enabled but the cxl initialization fails, including 
> ioremap_wc(). What you proposed to do, explicitly undo cxl 
> initialization bits, has the same outcome: device detached from the driver.

Right, I did read that and that motivated the devm_cxl_remove_mem()
helper to undo the memdev creation without unloading the driver. You are
free to ignore that helper.

