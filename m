Return-Path: <netdev+bounces-295997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8djXFlheI2pmrQEAu9opvQ
	(envelope-from <netdev+bounces-295997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:40:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4864BD49
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aM1eTWM1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295997-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295997-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1BEB303FEFC
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 23:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C77D3FB048;
	Fri,  5 Jun 2026 23:39:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8640B360
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 23:39:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702778; cv=none; b=FvKMyi47W/CChBzOpZEXI2dyl3sD/6skz9xVNfexq6nDoXPyLKg2pufSp40ie8vxkAR8qX1Y8yxTBnVbY8KRKX1umvTzUgmiBhyP3y24bo6j3aROo3KMq5OuxurxRN/Wq2HVJphQr2gHhlZJCy7oLtwaRLF4DTTk6VrNQo4Kht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702778; c=relaxed/simple;
	bh=1m5DMUHMutsRulgLy1wQ+Vt+ivcmY4xgriwPalShQBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATE4PwrNVyrU52ZijFEuFaPMKNgK0SNHupefmZzhyWypJn21WYaqWWJln5Pq6A+A8W4A1IMOKNYgl3eMCP/z7W3AWKRXdIQsBcEjZzq8qpABUb7TEEU1JXVmXM658vIVsEAnMP6VKVS8K04uQ3i9W5rUGM3QVNHjYnWzJHoDiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM1eTWM1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D032F1F00893;
	Fri,  5 Jun 2026 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702776;
	bh=AQq9czar8AbipDD8eVbqtXsxiT3BezSjgfZW2+6o/pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aM1eTWM1nLmjy82I0KXtiq/od/OIE0nd++u9w31jqsjI1ngIJi3d4Ay2ejbmQxqMn
	 +cvz0YlLgFbna4hSwkQzVtea05wwHmlT5oZiweATHROmU3zBxk7INB6pQjfVbF4W4A
	 n9iCn5OWnYvsrr6dOPlWm2+P+If2jgGiRHOH4QHIUPm57K2NONwF6PS5YXlFzDbXVs
	 IgcicS1wg9wceXn3zo19pWxpUfNLJbulKOfx1Uomi0KTNj8OMCOvNSLzYd5f+IOUnw
	 CrlDQf0m6nux2brotkHXPSsf/Y3AhOh8x/bVRf1uDP4DoiSz++xrLXEzBKGjtQabdn
	 tIOeMyZFm8gBw==
Date: Fri, 5 Jun 2026 16:39:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <poros@redhat.com>,
 <arkadiusz.kubalewski@intel.com>, <przemyslaw.kitszel@intel.com>,
 <horms@kernel.org>, <aleksandr.loktionov@intel.com>,
 <pmenzel@molgen.mpg.de>, <sx.rinitha@intel.com>
Subject: Re: [PATCH net 1/3] i40e: keep q_vectors array in sync with channel
 count changes
Message-ID: <20260605163934.547c7bdd@kernel.org>
In-Reply-To: <25ca3a21-7d29-47e8-a0fb-5fbb7ddfea99@intel.com>
References: <20260602225513.393338-2-anthony.l.nguyen@intel.com>
	<20260604012707.2843206-1-kuba@kernel.org>
	<25ca3a21-7d29-47e8-a0fb-5fbb7ddfea99@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295997-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:poros@redhat.com,m:arkadiusz.kubalewski@intel.com,m:przemyslaw.kitszel@intel.com,m:horms@kernel.org,m:aleksandr.loktionov@intel.com,m:pmenzel@molgen.mpg.de,m:sx.rinitha@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBC4864BD49

On Fri, 5 Jun 2026 11:01:19 -0700 Tony Nguyen wrote:
> > Should the new err_lump label, and the existing err_vsi exits from the
> > two allocation steps above, instead unwind through the err_rings block
> > (unregister_netdev / free_netdev / i40e_devlink_destroy_port /
> > i40e_aq_delete_element) the way i40e_vsi_setup()'s err_msix path does?
> > 
> > The pre-patch code had the same defective err_vsi target for the
> > qp_pile and arrays paths, but the patch adds two new failure points
> > (the unconditional q_vectors kzalloc and the new
> > i40e_vsi_setup_vectors() call) that route into it during reset
> > rebuild, where vsi->netdev is already registered.  
>  
> This does seem valid, but as mentioned by Sashiko the pre-patch code has 
> the same target/issue. There's a recent submission [1], with changes 
> requested, that should cover this. Did you want to take this now or wait 
> and have it sent with this other one?

Hm. I convinced myself yesterday that the old code did _not_ 
have the issue because it was pass false as the second arg to
i40e_vsi_{alloc,free}_arrays() ? Good chance that I misread,
it's tricky code. As much as I would love to apply this to prevent 
the deadlock in NIPA - let's wait for the follow up. I'll pick up 
the other two patches from this series off the list.

