Return-Path: <netdev+bounces-265040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBYOG6ibq2kJewEAu9opvQ
	(envelope-from <netdev+bounces-265040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:29:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25744229EA1
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F25A03006839
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27DB30DED5;
	Sat,  7 Mar 2026 03:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF172FFDEA;
	Sat,  7 Mar 2026 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854177; cv=none; b=fSdU41jzLHUwuSx6DaMi6/UIFFUGMxw8QzGlafcpjin9Iv6nD30K4fjEO3rkDeQR4KNjCC7cHaJDIqESHbOAuCxkeGKGiIvjMErHSgSVhwZ0s7TyMtN8pfSksK8SCsMsEDCiqMVYmRmY/1H74TEuyg+OidTMytXmo7lDSCgUgIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854177; c=relaxed/simple;
	bh=5RKF/0AwTXLN9CWkDFz4TomVKBNQxpUlP8b1G+9dpv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VtgJuTwfu2fNGbNVZGZh/21SMlNa7LMMPGHdO6wQETLuak6p+nQRVxpiKD6B9VkvL/UGHb4t2XxOFoHxcjNyz620c2c7lRM0DnAESOKxqXA67rWhN2yZxIU9gi3ryT8N/E/qsV54Za9sJsUh2ft1PBqJyvgAG5MXaCc+bMgO4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vyiLv-000000003vr-1RL8;
	Sat, 07 Mar 2026 03:29:19 +0000
Date: Sat, 7 Mar 2026 03:29:15 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
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
Subject: [PATCH net-next 0/2] net: dsa: mxl862xx: add support for bridge
 offloading
Message-ID: <cover.1772853341.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 25744229EA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265040-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.080];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,makrotopia.org:mid]
X-Rspamd-Action: no action

As a next step to complete the mxl862xx DSA driver, add support for
offloading forwarding between bridged ports to the switch hardware.

This works pretty much without any big surprises, apart from two
subtleties:
 * per-port control over flooding behavior has to be implemented by
   (ab)using a 0-rate QoS meters as stopper in lack of any better
   option.
 * STP state transition unconditionally enables learning on a port
   even if it was previously explicitely disabled (a firmware bug)

Note that as the driver is still lacking all VLAN features (which
are going to be added next), at this point some of the
bridge_vlan_aware.sh tests are failing after applying this series.

This is expected and cannot be avoided without implementing
port_vlan_filtering + port_vlan_add/del. And adding both bridge and
VLAN offloading at the same time would be too much for anyone to
review.

All other relevant selftests (including bridge_vlan_unaware.sh) are
still passing.

Daniel Golle (2):
  dsa: tag_mxl862xx: set dsa_default_offload_fwd_mark()
  net: dsa: mxl862xx: implement bridge offloading

 drivers/net/dsa/mxl862xx/mxl862xx-api.h | 171 +++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h |  19 +-
 drivers/net/dsa/mxl862xx/mxl862xx.c     | 576 ++++++++++++++++++++++--
 drivers/net/dsa/mxl862xx/mxl862xx.h     |  21 +
 net/dsa/tag_mxl862xx.c                  |   2 +
 5 files changed, 757 insertions(+), 32 deletions(-)

-- 
2.53.0

