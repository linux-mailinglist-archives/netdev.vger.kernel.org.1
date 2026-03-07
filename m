Return-Path: <netdev+bounces-265058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBKwJfWdq2lsewEAu9opvQ
	(envelope-from <netdev+bounces-265058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:39:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E322229F98
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 860503022042
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96D330BF6B;
	Sat,  7 Mar 2026 03:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32D1A76DE;
	Sat,  7 Mar 2026 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854768; cv=none; b=KeG7DAUQfuUST5cDMojl2z7rwG949Nr3BaBNoj38q6e47WHQeFA3aG3TvMfrPs2eW5nSwWRIPe9x8hAKmNbAa3rOO56tKmj+hck4+byCIyrv/AGb2sXip7WDSxU8/oZ8YpYQmbsrlgsLkBZSc6ZXIGm+G1CzaQQyblMDt4RthiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854768; c=relaxed/simple;
	bh=KscHdiSEQiii0HKqx4eJDbtIJ199rOzryEaumQFHEQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEiACriQOa1AEuy1kHo4rZKVTCAOxvOxxHmyGji33ev58cYZY0ZEz6/dqxjqis1wWCO87OOIGucxfwDrFjV2Od8VpY+LQ2vXhIndsMeIBtliFCYFYh23ORaZmf7oSFT/hZH+QIqr0poib6hda7YqPUMbZOGOOBCj4Z7CSiQqryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vyiVf-0000000040j-2Zqp;
	Sat, 07 Mar 2026 03:39:23 +0000
Date: Sat, 7 Mar 2026 03:39:20 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 0/2] net: dsa: mxl862xx: add support for bridge
 offloading
Message-ID: <aaud6NQWZB5eol-8@makrotopia.org>
References: <cover.1772853341.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772853341.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: 2E322229F98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-265058-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.041];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,makrotopia.org:mid,bridge_vlan_unaware.sh:url,bridge_vlan_aware.sh:url]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 03:29:15AM +0000, Daniel Golle wrote:
> As a next step to complete the mxl862xx DSA driver, add support for
> offloading forwarding between bridged ports to the switch hardware.
> 
> This works pretty much without any big surprises, apart from two
> subtleties:
>  * per-port control over flooding behavior has to be implemented by
>    (ab)using a 0-rate QoS meters as stopper in lack of any better
>    option.
>  * STP state transition unconditionally enables learning on a port
>    even if it was previously explicitely disabled (a firmware bug)
> 
> Note that as the driver is still lacking all VLAN features (which
> are going to be added next), at this point some of the
> bridge_vlan_aware.sh tests are failing after applying this series.
> 
> This is expected and cannot be avoided without implementing
> port_vlan_filtering + port_vlan_add/del. And adding both bridge and
> VLAN offloading at the same time would be too much for anyone to
> review.
> 
> All other relevant selftests (including bridge_vlan_unaware.sh) are
> still passing.

I forgot to add that (as expected) also test

VLAN-aware bridge with different PVIDs: Checking which packets were received

now fails in no_forwarding.sh, and will be fixed by implementing VLAN
operations in the next series.


> 
> Daniel Golle (2):
>   dsa: tag_mxl862xx: set dsa_default_offload_fwd_mark()
>   net: dsa: mxl862xx: implement bridge offloading
> 
>  drivers/net/dsa/mxl862xx/mxl862xx-api.h | 171 +++++++
>  drivers/net/dsa/mxl862xx/mxl862xx-cmd.h |  19 +-
>  drivers/net/dsa/mxl862xx/mxl862xx.c     | 576 ++++++++++++++++++++++--
>  drivers/net/dsa/mxl862xx/mxl862xx.h     |  21 +
>  net/dsa/tag_mxl862xx.c                  |   2 +
>  5 files changed, 757 insertions(+), 32 deletions(-)
> 
> -- 
> 2.53.0

