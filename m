Return-Path: <netdev+bounces-253959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4INqJwX7eGlfuQEAu9opvQ
	(envelope-from <netdev+bounces-253959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:51:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 260F198A6D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 498F03055E4C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EEA324B2D;
	Tue, 27 Jan 2026 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIpBomvR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C726324B1B;
	Tue, 27 Jan 2026 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536237; cv=none; b=XsP0EM4XAUA8xeu1ycwynOgpoqbXssZua8ZPUw7kN1ncHgcAsvt+Ah1lyMw2gE0DE55koQeUGxfKkPnhPQ3vvq0qUSlZgEtWfSfN8HjEqQInRqxGE3qHa4TMgjGpTyNFdfCYb8VxPnOJiUD6h4YhrTsXJh3zB2HnSxH+UfQwQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536237; c=relaxed/simple;
	bh=GI3V/ud6ht1wYZZFEboSh6jjV8pOjQpJpn+qPWSx5i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEnhxP7bbTyImbV7KryaveNLboyhD6dqrvoLERecvYJEdSO75qpSyfixJwXaPL75bVpq2JXgsp87vM9CLoiVRtSRahjZcR2Ds9MVXHFotWwvbg+gF49sTPEkzrw90MnshYoIYv4B4UnTNEwMR9bAy6uPG+jjWlTU+gGClgKTSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIpBomvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0B6C116C6;
	Tue, 27 Jan 2026 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769536236;
	bh=GI3V/ud6ht1wYZZFEboSh6jjV8pOjQpJpn+qPWSx5i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIpBomvR9PQoOnCgGkMoWDrbakGohqx3v6gsBuHZISl6YErK4C3O89yWIdVxGRo07
	 xf7j2aoctzPaWJuXfhoLQPV3xB67z2KL7cc9uUIJ2eDeixVjrvCM7KA0Gq95GuOQOM
	 r3AV5SA0FwW7j2AlJgohiGAo4v6AdsXfcneGt/Z24WYNdQWsuSo/6KRo9Wecek9lUP
	 bFkcPtOPtfCuG/3+LojsfMscLZ+21MVE08HbeL/KIRyLks1KXXTT9zxjYQi6zTHFV/
	 ol8mGXbAnDqLRpDxh4jcoexVpvsfsCfATjhhNqH0zo8VR9N8f+T//SuHS/RfRKblL1
	 Z8X4fnf7CNaMA==
Date: Tue, 27 Jan 2026 17:50:31 +0000
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Brian Vazquez <brianvv@google.com>,
	Brian Vazquez <brianvv.kernel@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	David Decotigny <decot@google.com>, Li Li <boolli@google.com>,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Tantilov, Emil S" <emil.s.tantilov@intel.com>
Subject: Re: [Intel-wired-lan] [iwl-net PATCH] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
Message-ID: <aXj652w2_ogi6ysW@horms.kernel.org>
References: <20260123204058.651080-1-brianvv@google.com>
 <IA3PR11MB8986BB2FDDBB664CB318FB15E593A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986BB2FDDBB664CB318FB15E593A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,intel.com,davemloft.net,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253959-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 260F198A6D
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 07:27:15AM +0000, Loktionov, Aleksandr wrote:

...

> I think could be nice to have proper Fixes: tag, but anyway.
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

If this is to be submitted to net (via iwl-net), which I assume is the
plan, then please add a Fixes tag.

Thanks!

