Return-Path: <netdev+bounces-290904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGN1IOyaEGoMaQYAu9opvQ
	(envelope-from <netdev+bounces-290904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:05:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBFD5B8C43
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A50B230AFBA1
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82932358381;
	Fri, 22 May 2026 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TfhnLQ/U"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974E3537E5;
	Fri, 22 May 2026 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472289; cv=none; b=Jzv73Ad7ii+jCFrRHQqaFGc3VEhn+jkORPWpHp/mRDDk9aAUQR3A5GS9ei4fD5SGmbLBNsyk/u1XnKsPB44nOEdEZmM/huKqI8O7F40hljU1SOQ2gADlz9zn+whipPIsPcYXYt+q+g5IkSQdHan6bIpzg3LlxJC6PoQ9+5Cew4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472289; c=relaxed/simple;
	bh=Lmd3fat+iy05VFwDV9OkZ+dPUBIpXT1swfKuILj553k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1hl9miao4FHXd+EUbcLZah5zSB/ncCaDXMjr5B5tVP8a0XzLxY2t+WdViC0zihM5hEk5+ybpiatCOSBgqfW/owceC1qwzA7ET/85i4nZnt/nrhgU8GqbrxGCbxDvjv8/T0iRBpPS0wmS02uQOXqjxosuX2ltLDD1+/5xdg6QoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TfhnLQ/U; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 752174E42D2B;
	Fri, 22 May 2026 17:51:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 411026003C;
	Fri, 22 May 2026 17:51:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8582108116E6;
	Fri, 22 May 2026 19:51:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779472283; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=yZgvA1gYQFIbvg6/jrRfXrn5G7Mjdvv4QrFMezU1bZo=;
	b=TfhnLQ/Ul+9LpYRg5sMzSfq880lKK1goD415ZCkyzjccrSd1l9y/RFVfsA5MdLwPfRIevj
	0iM8wKzvaOiD8mhq55z5nKBFfCt56U/O1BDbrg8Qe8zlePcYhWxURRIDVqa7NF5llJloYJ
	5lv1KI9+CaqqMhVCFHVsPpfti9P9JuYUo+CyUmEgf5DrbzY5JFXYouh1Gzk9rpxPf0d+dU
	2W+PnDi3IoM4ELdOwSnsD567Rak7O06ieidD6G5djJoQ9Iok5JG10cvwGK0as/kXehxrtr
	WPNwIkTTBSUs9sM2Gmtb8Sn1buDdJqD9s41QYcYTh3SF8v8Lfs25anPQhRfawA==
From: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] Documentation: networking: Add a test plan for ethtool pause validation
Date: Fri, 22 May 2026 19:51:06 +0200
Message-ID: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,pengutronix.de,nxp.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-290904-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.984];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 7DBFD5B8C43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Flow control configuration through Ethernet Pause frames is not
straightforward to get right when implementing a MAC or a PHY driver.

This is often a feature that's poorly tested during development, and
getting it right requires correct configuration both in MAC drivers,
that implement the flow-control, and the PHY drivers, which deal with
the negotiation of the pause parameters.

As part of the Netdev Foundation effort to improve driver testing, and to ease
the development and review effort, The netdev mailing list has been surveyed
to identify the common pitfalls. This testing plan has been written to try and
catch most of the common problems.

This document is aimed as being a human readable basis we can adjust and
discuss before diving into the actual tests implementation, it may not
necessarily have to live in the kernel doc forever, especially once
tests are implemented.

Note that Oleksij Rempel made some attempts at documenting Ethernet Flow-control
before [1], this current work isn't meant to superseed it but rather
complement it with a testing protocol.

[1] : https://lore.kernel.org/netdev/20260304094811.2779953-1-o.rempel@pengutronix.de/

Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
---

Temptative approach to send that as part of the kdoc, this may not be
the best path, as this could simply be some email thread.

 Documentation/networking/index.rst           |   1 +
 Documentation/networking/pause_test_plan.rst | 556 +++++++++++++++++++
 2 files changed, 557 insertions(+)
 create mode 100644 Documentation/networking/pause_test_plan.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 44a422ad3b05..fef54999267d 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -91,6 +91,7 @@ Contents:
    openvswitch
    operstates
    packet_mmap
+   pause_test_plan
    phonet
    phy-link-topology
    phy-port
diff --git a/Documentation/networking/pause_test_plan.rst b/Documentation/networking/pause_test_plan.rst
new file mode 100644
index 000000000000..5ff9860efbe5
--- /dev/null
+++ b/Documentation/networking/pause_test_plan.rst
@@ -0,0 +1,556 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Ethtool Pause testing
+=====================
+
+This document describes the test plan to be used for the ethtool selftest, aimed
+at providing a validation framework for Ethernet drivers that implement flow-control.
+
+To ease readability, the document uses the "ethtool" command to describe test cases,
+actual tests may use the netlink API directly.
+
+This document was written after surveying the common error patterns for pause-related
+patches on the netdev mailing list. The common mistakes are usually found in either
+MAC drivers that don't make use of phylink, or PHY drivers that interfere with
+pause settings.
+
+The main classes of problems are :
+
+ - MAC drivers incorrectly configuring the Pause/Asym capabilities in the attached
+   PHY device through calling phy_support_asym_pause() and phy_support_sym_pause().
+
+   These are used to allow the PHY do know what Pause settings the MAC supports, in
+   order to advertise it to the LP.
+
+   They aren't to be used to configure the Pause advertisement, and the MAC driver
+   needs to actually configure Pause on its side after negotiation finishes.
+
+   Using phylink is the easiest fix for this kind of problem.
+
+ - PHY drivers overriding the Pause/AsymPause bits in the supported/advertising
+   fields. Pause is a MAC feature, but the PHY negotiates the settings with the
+   partner. The PHY driver shouldn't have to tweak Pause settings, only advertise
+   them and report the negotiation results.
+
+ - MAC drivers confusing phydev->autoneg and pause autoneg. Pause autoneg is about
+   whether or not we want to negotiate the Pause settings with the partner, or use
+   locally enforced settings. phydev->autoneg, also referred to as link-wide autoneg
+   is about whether or not we want to negotiate anything with the link partner,
+   including speed, duplex, pause, etc. Both phydev->autoneg and pause autoneg can
+   be configured independently.
+
+ - MAC drivers mishandling the pause parameters in the ethtool get/set_pauseparam
+   callbacks, usually by ignoring the pause autoneg settings.
+
+The hardware capabilities regarding Pause support are reported through the
+linkmodes bits 'ETHTOOL_LINK_MODE_Pause' and 'ETHTOOL_LINK_MODE_Asym_Pause', the
+four different combinations are accepted and together describe the ability for
+the hardware to send TX pause frames, and process the received ones :
+
+ - **Pause** bit : the interface has the ability to Receive and process Pause frames
+ - **Asym** bit (Or AsymDir) : The TX and RX pause setting can be different.
+
+This translates to :
+
+ - **Pause** & **Asym** : We can support **ALL** combinations of rx/tx
+
+ - **Pause only** : only **rx == tx** configurations are valid
+
+ - **Asym** only : **rx** must be **off**, **tx** can be **on or off**
+
+Similarly, the link partner can advertise its capabilities through the same
+bits. These parameters are exchanged through the negotiation process, but can
+also be enforced locally by disabling **pause autoneg**, thus ignoring the
+link partner's capabilities.
+
+The local resolution of the pause configuration after receiving the link-partner
+abilities is done according to the following table, from 802.3 Annex 28B.3 :
+
++-------------+--------------+--------------------------+
+|Local device | Link partner | Pause settings resolution|
++------+------+-------+------+-----------+--------------+
+|Pause | Asym | Pause | Asym | RX        | TX           |
++======+======+=======+======+===========+==============+
+| 0    | 0    | Any   | Any  | No        | No           |
++------+------+-------+------+-----------+--------------+
+| 0    | 1    | 0     | Any  | No        | No           |
++------+------+-------+------+-----------+--------------+
+| 0    | 1    | 1     | 0    | No        | No           |
++------+------+-------+------+-----------+--------------+
+| 0    | 1    | 1     | 1    | No        | Yes          |
++------+------+-------+------+-----------+--------------+
+| 1    | 0    | 0     | Any  | No        | No           |
++------+------+-------+------+-----------+--------------+
+| 1    | Any  | 1     | Any  | Yes       | Yes          |
++------+------+-------+------+-----------+--------------+
+| 1    | 1    | 0     | 0    | No        | No           |
++------+------+-------+------+-----------+--------------+
+| 1    | 1    | 0     | 1    | Yes       | No           |
++------+------+-------+------+-----------+--------------+
+
+The currently configured and advertised settings can be queried with ::
+
+  ethtool <iface>
+
+  Settings for eth0:
+        ...
+	Supported pause frame use: Symmetric Receive-only
+        ...
+	Advertised pause frame use: Symmetric Receive-only
+        ...
+	Link partner advertised pause frame use: Symmetric Receive-only
+
+While testing can be done directly with the Netlink API, as a reminder here's
+what the ethtool output translates to :
+
++------------------------+-------+---------+
+|     Ethtool output     | Pause | AsymDir |
++========================+=======+=========+
+|          No            |   0   |    0    |
++------------------------+-------+---------+
+|     Transmit-only      |   0   |    1    |
++------------------------+-------+---------+
+|       Symmetric        |   1   |    0    |
++------------------------+-------+---------+
+| Symmetric Receive-only |   1   |    1    |
++------------------------+-------+---------+
+
+Mac drivers's current pause behaviour is reported through the
+ethtool -a/--show-pause command, e.g.::
+
+        ethtool -a <iface>
+
+        Autonegotiate:	on
+        RX:		off
+        TX:		off
+        RX negotiated: on
+        TX negotiated: on
+
+When **pause autoneg** is on, the currently used pause parameters are the
+*negotiated* ones, that may differ from the user-specified rx and tx values.
+
+When **pause autoneg** is off, the rx and tx values are the ones used by the
+hardware.
+
+A : Standalone driver testing
+=============================
+
+Requirements : The interface under test must be connected to a link-partner whose
+interface is admin-up. We don't require the link-partner to be configured in any
+other specific manner for these tests.
+
+A.1 : Sanity Checks
+~~~~~~~~~~~~~~~~~~~
+
+Pause autoneg is set to off::
+
+  ethtool -A <iface> autoneg off
+
+The 'supported' fields retrieved using the ETHTOOL_MSG_LINKMODES_GET includes
+a "Pause" bit and an "Asym" bit.
+
+The ETHTOOL_MSG_PAUSE_GET command returns the currently configured pause modes
+in the "tx" and "rx" attributes.
+
+These parameters must validate against the following truth table :
+
+   +--------------+-----------------+
+   | linkmodes    | pauseparam      |
+   +-------+------+--------+--------+
+   | Pause | Asym | rx     | tx     |
+   +=======+======+========+========+
+   | 0     | 0    | 0      | 0      |
+   +-------+------+--------+--------+
+   | 0     | 1    | 0      | 0 or 1 |
+   +-------+------+--------+--------+
+   | 1     | 0    |     rx == tx    |
+   +-------+------+--------+--------+
+   | 1     | 1    | 0 or 1 | 0 or 1 |
+   +-------+------+--------+--------+
+
+Test scenario
+-------------
+
+Following the reported value from::
+
+        ethtool <iface>
+        Settings for <iface>:
+                ...
+	        Supported pause frame use: <value>
+
+Iterate over all the 4 combinations of rx and tx pause parameters::
+
+        ethtool -A <iface> autoneg off rx <rx_val> tx <tx_val>
+
+The settings must be accepted or rejected, according to the above truth table.
+
+Failing this test likely means the MAC driver is incorrectly setting the PHY's
+Pause and AsymDir bits, or that the PHY driver overwrites the Pause and AsymDir
+supported bits.
+
+A.2 : Half-duplex operation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Pause settings as exposed with the ethtool API only concern full-duplex modes.
+
+Test scenario:
+--------------
+
+Set the interface under test in half-duplex mode with::
+
+  ethtool -s <iface> duplex half
+
+Expected behaviour::
+
+ - ethtool <iface>
+
+shows no Pause settings advertised.
+
+Should this test fail, it likely means that either the MAC driver incorrectly
+calls phydev_set_asym_pause(), or that the PHY driver overrides the settings.
+
+B : Combined devices testing
+============================
+
+Requirements : The interface under test must be connected to a link-partner that
+can be actively configured during the tests. It must at least support full-duplex
+modes, and optionally (but ideally) symmetric and asymmetric flow-control, as
+well as autonegotiation of the Pause parameters.
+
+B.1 : Autoneg advertising
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Goal: Validate that the *advertised* Pause and AsymDir bits match the configured
+pausemarams.
+
+The link-level autonegotiation must be enabled::
+
+  ethtool <iface> autoneg on
+
+Pause parameters are set with::
+
+  ethtool -A <iface> rx <val> tx <val> autoneg on
+
+Pause advertising is retrieved with::
+
+  ethtool <iface>
+
+Case 1
+------
+
+Pause parameters : rx **off** tx **off**
+
+Expected advertisement : **None** (Pause = 0, AsymDir = 0)
+
+Case 2
+------
+
+Pause parameters : rx **off** tx **on**
+
+Expected advertisement : **Transmit-only** (Pause = 0, AsymDir = 1)
+
+Case 3
+------
+
+Pause parameters : rx **on** tx **off**
+
+Expected advertisement : **Symmetric receive-only** (Pause = 1, Asymdir = 1)
+
+Case 4
+------
+
+Pause parameters : rx **on** tx **on**
+
+Expected advertisement : **Symmetric** (Pause = 1, Asymdir = 0)
+
+B.2 : Autoneg resolution
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Goal: Validate that the Pause and AsymDir negotiation translates to the right
+TX and RX pause parameters.
+
+The following table, from the 802.3 standard, exposes the autoneg resolution
+result for the advertised pause parameters by each link partner.
+
++-------------+--------------+--------------------------+
+|Local device | Link partner | Pause settings resolution|
++------+------+-------+------+-----------+--------------+
+|Pause | Asym | Pause | Asym | RX        | TX	        |
++======+======+=======+======+===========+==============+
+| 0    | 0    | Any   | Any  | No        | No           |
++------+------+-------+------+-----------+--------------+
+| 0    | 1    | 0     | Any  | No        | No           |
++------+------+-------+------+-----------+--------------+
+| 0    | 1    | 1     | 0    | No        | No           |
++------+------+-------+------+-----------+--------------+
+| 0    | 1    | 1     | 1    | No        | Yes          |
++------+------+-------+------+-----------+--------------+
+| 1    | 0    | 0     | Any  | No        | No           |
++------+------+-------+------+-----------+--------------+
+| 1    | Any  | 1     | Any  | Yes       | Yes          |
++------+------+-------+------+-----------+--------------+
+| 1    | 1    | 0     | 0    | No        | No           |
++------+------+-------+------+-----------+--------------+
+| 1    | 1    | 0     | 1    | Yes       | No           |
++------+------+-------+------+-----------+--------------+
+
+The mapping between the configured pause parameters and advertised modes follow
+the following truth table :
+
++----+----+-------+---------+
+| tx | rx | Pause | AsymDir |
++====+====+=======+=========+
+| 0  | 0  | 0     | 0       |
++----+----+-------+---------+
+| 0  | 1  | 1     | 1       |
++----+----+-------+---------+
+| 1  | 0  | 0     | 1       |
++----+----+-------+---------+
+| 1  | 1  | 1     | 0       |
++----+----+-------+---------+
+
+We can boil that down to the following cases to test, keeping the number small
+to avoid dealing with the whole combinatory::
+
+        ethtool -A <iface> autoneg on rx <rx_param> tx <tx_param>
+
+Failing tests here would likely indicate that the MAC driver doesn't correctly
+accounts for the negotiated Pause parameters in its .adjust_link() callback. A
+MAC driver that uses phylink should pass these tests.
+
+Case 1
+------
+
+Local device : rx **off**, tx **off**
+Remote device : rx **on** tx **on**
+
+Expected result on local device after autonegotiation completes :
+        rx negotiated **off**
+        tx negotiated **off**
+
+Case 2
+------
+
+Local device : rx **off** tx **on**
+Remote device : rx **off** tx **on**
+
+Expected result on local device after autonegotiation completes :
+        rx negotiated **off**
+        tx negotiated **off**
+
+Case 3
+------
+
+Local device : rx **off** tx **on**
+Remote device : rx **on** tx **off**
+
+Expected result on local device after autonegotiation completes :
+        rx negotiated **off**
+        tx negotiated **on**
+
+Case 4
+------
+
+Local device : rx **off** tx **on**
+Remote device : rx **on** tx **on**
+
+Expected result on local device after autonegotiation completes :
+        rx negotiated **off**
+        tx negotiated **off**
+
+This case looks surprising but boils down to the fact that we advertise Asym only,
+whereas the LP is advertising Pause (and not Pause + Asym).
+
+As per 802.3 this resolves to all "Off".
+
+Case 5
+------
+
+Local device : rx **on** tx **off**
+Remote device : rx **off** tx **on**
+
+Expected result on local device after autonegotiation completes :
+        rx negotiated **on**
+        tx negotiated **off**
+
+Case 6
+------
+
+Local device : rx **on** tx **on**
+Remote device : rx **on** tx **off**
+
+Expected result on local device after autonegotiation completes :
+        rx negotiated **on**
+        tx negotiated **on**
+
+This is also not an obvious result. We advertise Pause, the Link partner advertises
+Pause + Asym, so it resolves to all "On".
+
+Case 7
+------
+
+Local device : rx **on** tx **on**
+Remote device : rx **off** tx **off**
+
+Expected result on local device after autonegotiation completes :
+        rx negotiated **off**
+        tx negotiated **off**
+
+Case 8
+------
+
+Local device : rx **on** tx **on**
+Remote device : rx **off** tx **on**
+
+Expected result on local device after autonegotiation completes :
+        rx negotiated **on**
+        tx negotiated **off**
+
+B.3 : Pause Autoneg
+~~~~~~~~~~~~~~~~~~~
+
+Goal: Validate that the Pause autonegotiation flag correctly toggles the
+advertised Pause and AsymDir link parameters.
+
+Test scenario:
+--------------
+
+ - Enable pause autoneg and at least rx or tx pause::
+
+        ethtool -A <iface> rx on tx on autoneg on
+
+ - Check the Advertised pause frame use::
+
+        ethtool <iface>
+
+        ...
+        Advertised pause frame use: Symmetric Receive-only
+
+ - Disable pause autoneg::
+
+        ethtool -A <iface> autoneg off
+
+ - Check the Advertised pause frame use, which must be 'No'::
+
+        ethtool <iface>
+
+        ...
+        Advertised pause frame use: No
+
+B.4 : Pause autoneg transition
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Goal: Validate the advertising and pause parameters upon toggling pause
+      autonegotiation. When pause autoneg is disabled, the local pause settings
+      are dictated by the user configuration, without relying on negotiated
+      parameters.
+
+This validation focuses on cases where the pause autoneg result differs from the
+user-specified rx and tx pauseparams, e.g. :
+
+Local device : rx **on** tx **off**
+Remote device : rx **on** tx **on**
+
+This will negotiate into rx and tx being **on**, contrary to the user intent.
+
+Test scenario:
+--------------
+
+ - Enable link-wide autonegotiation::
+
+        ethtool -s <iface> autoneg on
+
+ - Enable Pause autonegotiation, setting RX on and TX off::
+
+        ethtool -A <iface> rx on tx off autoneg on
+
+ - Expected result::
+
+        ethtool -a <iface>
+
+        Pause parameters for <iface>:
+        Autonegotiate:	on
+        RX:		on
+        TX:		off
+        RX negotiated: on
+        TX negotiated: on
+
+Note that the currently applied configuration here is expressed by the "negotiated"
+parameters, so the link is currently using RX and TX Pauses.
+
+ - Disable pause autonegotiation::
+
+        ethtool -A <iface> autoneg off
+
+ - Expected result::
+
+        ethtool -a <iface>
+
+        Pause parameters for <iface>:
+        Autonegotiate:	off
+        RX:		on
+        TX:		off
+
+Note that now, the currently applied configuration really is RX on TX off. It is
+expected that upon running the above command, the link flips down and up again
+as flow-control parameters are updated.
+
+ - Re-enable pause autonegotiation::
+
+        ethtool -A <iface> autoneg on
+
+ - Expected result::
+
+        ethtool -a <iface>
+
+        Pause parameters for <iface>:
+        Autonegotiate:	on
+        RX:		on
+        TX:		off
+        RX negotiated: on
+        TX negotiated: on
+
+The user-defined pause parameters needs to be again converted to advertised Pause
+and Asym parameters, negotiated and the final outcome must be the same as the original
+conditions.
+
+B.5 : Pause autoneg only to Pause and Link autoneg transition
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Goal: Validate that drivers store the user intent in the pause rx/tx attributes
+when disabling link autoneg, but *keeping the pause autoneg enabled*.
+
+When pause autoneg is enabled, the rx and tx pause parameters are the user intent,
+but can be different to the actual pause parameters actively in use.
+
+Test scenario:
+--------------
+
+ - Configure rx and tx pause parameters to **on** and pause autoneg to **on**::
+
+        ethtool -A <iface> autoneg on rx on tx on
+
+ - Disable link autonegotiation::
+
+        ethtool -s <iface> autoneg off
+
+ - Configure rx and tx pause to **rx off**, **tx on** and autoneg to **on**::
+
+        ethtool -A <iface> autoneg on rx off tx on
+
+ - No change in the pause parameters should occur
+ - Re-enable link negotiation::
+
+        ethtool -s <iface> autoneg on
+
+ - Link must now re-negotiate pause to **rx off** and **tx on**::
+
+        ethtool -a <iface>
+
+        Pause parameters for <iface>:
+        Autonegotiate:	on
+        RX:		off
+        TX:		on
+        RX negotiated: off
+        TX negotiated: on
+
-- 
2.54.0


