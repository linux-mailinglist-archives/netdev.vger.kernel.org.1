Return-Path: <netdev+bounces-305916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8EY0HX+GTmpgOgIAu9opvQ
	(envelope-from <netdev+bounces-305916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:18:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 227DE7291D1
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:18:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=d+VdfyvR;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305916-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305916-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6ECE3017261
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4494B8DFF;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC88349CDF;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530756; cv=none; b=djSGnVHSG/RWRG/Nh9Z0TprSw89bZgmtDRSq5R9zeKnel0p/dTIt577TCFo5qi5gs8gucrP6l1JQqSXA08Jm/19BIHQJmvJyp7KbW0nxS9kS+ZbBNBK+Cl7ZhxXCsWfAlvRuj75B7//VDaQcKYg8GF/OOs1jPD47x1YoxfnMzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530756; c=relaxed/simple;
	bh=memOoRnla5Ro5FwjmRHjpkH2Fk7XYz7mXYt8tIJJUmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CeWyhRjWfDEwnojw9KmHP7QgFx9SunNf/K1T6jwefx5rmjHMQRpP9c1WmktZP/wzRtl21oNqxnA6eclVqLuIcXoPEDpyR+PJNJtQi8RIBFyUycL3siiz8JcJ80KFbwSGD9xisy8qO8A7KUmZyTsb0tAJIK3hQoSajI+xL6Dt9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+VdfyvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E435C4AF0B;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783530756;
	bh=memOoRnla5Ro5FwjmRHjpkH2Fk7XYz7mXYt8tIJJUmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d+VdfyvRXNQr+hx2C0nhqHxuv0H5F1OdoWVL1m3/iVud7erArdUAAwFGTNvH5ZZWO
	 ASzBJ+oMUbky6DVtj8zD3/sNk5u20CebQZTW16TKJEht1Hk121Orzx4HiQ3TjpLPod
	 gphbqVXl4qxn/Y6UBshp5gnVjGsnd25NmJ/cPlx5eCsD5Y4czTWr2fgqibWEP0evNG
	 6TBU1cz/rVAfDdoDM149WJ2S4gfxr5AU0fTdN+AZDITrDlv7zUx8FTeDxYvHJ4Xp/R
	 r1wGkUJbj/ut9OXXQU4R2YZfQ5CMxZiY/h4/1jU4VZ1HdSl9H54B+DrzpouBkPWJGd
	 GKWaJR+dab9Mw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD6CC44501;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 08 Jul 2026 10:12:32 -0700
Subject: [PATCH net-next v7 02/15] Documentation: networking: Add timestamp
 related APIs to OA TC6 framework
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-s2500-mac-phy-support-v7-2-478c877aa1a9@onsemi.com>
References: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
In-Reply-To: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783530757; l=5434;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=H5GeLlyjiawpJaJt1aTxsPM7HAFhY+Lxpr01l0nosNM=;
 b=RE9KKP7qLhTvHgdplYk2gh/E4Dq9crNz7jF6iQCJEg2KLtK4Sj3jZqakFn6lHBx266n+9XXYG
 ltjvV1Mc6n3BKdF6lA2rvrU3sRS1oNOkAY9UUSJ5IGgyZBirex4LNHr
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305916-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 227DE7291D1

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Added new APIs to support hardware timestamp feature as defined in
OPEN Alliance 10BASE-T1x MAC-PHY serial interface specification.

Expanded read/write APIs to take new mms parameter to avoid
bit manipulation before calling regular read/write APIs

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - Fixed "no blank line" issues in four places
changes in v4
  - Added information for new APIs in OA TC6 framework
changes in v3
  - Added more information for documentation
changes in v2
  - Removed the changes to the existing API
  - Updated information about newly added APIs
changes in v1
  - Added changes to an existing API
  - Added documentation to new hardware timestamp related APIs
---
 Documentation/networking/oa-tc6-framework.rst | 80 +++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
index fe2aabde923a..325d299d1a7d 100644
--- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -153,6 +153,10 @@ OPEN Alliance TC6 Framework
 - Forwards the received Ethernet frame from 10Base-T1x MAC-PHY to n/w
   subsystem.
 
+- If supported by the hardware and enabled, updates hardware timestamp
+  in skb, when indicated by one of the three timestamp capture registers
+  through TSC fields of the header.
+
 Data Transaction
 ~~~~~~~~~~~~~~~~
 
@@ -495,3 +499,79 @@ the MAC-PHY.
 Zero align receive frame feature can be enabled to align all receive ethernet
 frames data to start at the beginning of any receive data chunk payload with a
 start word offset (SWO) of zero.
+
+.. c:function:: int oa_tc6_ptp_register(struct oa_tc6 *tc6, \
+                                        struct ptp_clock_info *info);
+
+Registers the PTP hardware clock related functions with the kernel.
+This API simply registers. Initialization of the fields in the
+ptp_clock_info structure are left to the vendor as programming hardware
+timer is expected to be vendor dependent. The fields max_adj, owner,
+and all the functions for the clock operations, like adjfine, gettimex64,
+settime64, adjtime are expected to be initialized in the structure before
+calling the registering the hardware clock.
+
+.. c:function:: void oa_tc6_ptp_unregister(struct oa_tc6 *tc6);
+
+Unregisters the PTP hardware clock related callbacks.
+
+.. c:function:: int oa_tc6_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, \
+                                 int cmd);
+
+ioctl interface to handle hardware timestamp and PHY related commands.
+
+.. c:function:: int oa_tc6_get_ts_info(struct oa_tc6 *tc6, \
+                                       struct kernel_ethtool_ts_info *info);
+
+Provides timestamp related settings that are supported to ethtool.
+
+.. c:function:: void oa_tc6_hwtstamp_get(struct oa_tc6 *tc6, \
+                                         struct kernel_hwtstamp_config *cfg);
+
+Returns hardware timestamp configuration. Part of net_device_ops callbacks.
+
+.. c:function:: void oa_tc6_get_ts_stats(struct oa_tc6 *tc6, \
+                                         struct ethtool_ts_stats *ts_stats);
+
+Provides hardware timestamp related traffic statistics for ethtool.
+
+.. c:function:: int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6, \
+                                         struct kernel_hwtstamp_config *cfg);
+
+Helper to set hardware timestamp configuration. Part of net_device_ops
+callbacks.
+
+.. c:function:: void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
+
+Helper to map MDIO_MMD_VEND1 command to vendor specific Memory Map Select
+(MMS) value. This function offers flexibility for vendors that may have
+used any MMS value between 10 and 15 as allowed by the specification.
+MDIO_MMD_VEND2 is already mapped to MMS4 in the OA TC6 frame work code.
+
+.. c:function:: int oa_tc6_write_registers_mms(struct oa_tc6 *tc6, \
+                                               u16 address, u16 mms, \
+                                               u32 value[], u8 length);
+
+Writing multiple consecutive registers starting from @address for the
+given @mms memory map selector in the MAC-PHY. Maximum of 128 consecutive
+registers can be written starting at @address.
+
+.. c:function:: int oa_tc6_write_register_mms(struct oa_tc6 *tc6, \
+                                              u16 address, u16 mms, \
+                                              u32 value);
+
+Write a single register addressed by @address and @mms in the MAC-PHY.
+
+.. c:function:: int oa_tc6_read_registers_mms(struct oa_tc6 *tc6, \
+                                              u16 address, u16 mms, \
+                                              u32 value[], u8 length);
+
+Reading multiple consecutive registers starting from @address for the
+given @mms memory map selector value, in the MAC-PHY. Maximum of 128
+consecutive registers can be read starting at @address.
+
+.. c:function:: int oa_tc6_read_register_mms(struct oa_tc6 *tc6, \
+                                             u16 address, u16 mms, \
+                                             u32 *value);
+
+Read a single register addressed by @address and @mms in the MAC-PHY.

-- 
2.43.0



