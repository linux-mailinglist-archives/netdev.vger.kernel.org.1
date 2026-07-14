Return-Path: <netdev+bounces-307570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BuhDLMyKVmq78gAAu9opvQ
	(envelope-from <netdev+bounces-307570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:15:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3712A75825D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:15:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307570-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307570-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 339013052F6A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843D541B8E2;
	Tue, 14 Jul 2026 19:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121E418A5C;
	Tue, 14 Jul 2026 19:15:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056507; cv=none; b=GkKRggC06VZpWWD1UK9YxAXJE5UebMDCEEWoRCXRmxxNoOhDUpSldV62beXZ5YrMYY6PViTsrCpP14fm3R0ykByqLMZbwTcdGaO1hWIDkj/PTWARlHetVQTsmmwpv/p1Iyt88dK83vgbKVUxWVMt9HCIddx3BYnK+hHMcdCkndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056507; c=relaxed/simple;
	bh=p0wmZLOKDngMCtvjd+Iw+F/TFcdzRjhdAPjVktGfQrU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2uHtWEv/qQo5wyyylamlgvgApMBEB200uvXKfyAXVYmVDrCZvYmlUaZv1YhAUyLFzd6KzkJ/TEJhph9agx4RAhzBBR37Vjd4TZzrtG854uE5lqs2P4beyXF23Z9fKv25RP6ejx9ary6ktY06C8/SIZsUduD/CQ/yHwAdQrkCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wjiaq-000000006sq-0Sxh;
	Tue, 14 Jul 2026 19:15:00 +0000
Date: Tue, 14 Jul 2026 20:14:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <alaKsBXSK9tP__O8@makrotopia.org>
References: <cover.1783988826.git.daniel@makrotopia.org>
 <5d1614d1cd6b99bf0f0635c6370bbed10736a7fa.1783988826.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1614d1cd6b99bf0f0635c6370bbed10736a7fa.1783988826.git.daniel@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-307570-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,makrotopia.org:from_mime,makrotopia.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3712A75825D

On Tue, Jul 14, 2026 at 01:51:02AM +0100, Daniel Golle wrote:
[...]
> +	if (!of_property_read_string_index(ds->dev->of_node, "compatible", 0,
> +					   &compatible)) {
> +		ret = devlink_info_version_fixed_put(req,
> +						     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
> +						     compatible);

Review of the fwupd counterpart of this series[1] made me reconsider
what the driver reports as the "asic.id" fixed version. The devicetree
compatible string used here ("maxlinear,mxl86252") turned out to be an
unfortunate choice as the comma is awkward for userspace consumers, so
for v3 I plan to follow the mv88e6xxx example and report a chip name
from a per-model info table instead:

  fixed:
    asic.id MaxLinear MxL86252

Before sending v3 I would like to clarify the preferred format of the
value. Existing implementations differ: mv88e6xxx reports for example
"Marvell 88E6085", including the vendor name and a space, sja1105
reports "SJA1105E", hellcreek reports "hellcreek", and bnxt and ionic
report bare chip identifiers.

Documentation/networking/devlink/devlink-info.rst only describes
"asic.id" as "ASIC design identifier" without any format constraints.

Userspace builds firmware matching identifiers from these values, in
the case of fwupd for example

  MDIO_BUS\COMPONENT_fw&ASIC.ID_MaxLinear MxL86252

and while a space works there, such identifiers commonly avoid spaces
in favour of underscores, hyphens or dots.

Is there a preference for new drivers? Should the vendor name be part
of "asic.id" as done by mv88e6xxx, or would a single token such as
"MxL86252" be more appropriate?

[1] https://github.com/fwupd/fwupd/pull/10667

