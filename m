Return-Path: <netdev+bounces-284026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJx6Nk/y+GnJ3QIAu9opvQ
	(envelope-from <netdev+bounces-284026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:23:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24D04C3318
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4551130106B2
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF523FADEE;
	Mon,  4 May 2026 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8K66Ufl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36633FA5DC;
	Mon,  4 May 2026 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922603; cv=none; b=G1OD5HEn93eS1vf+pqtIuRGhJrbpO+cHqwKD9NiRkFGHLTttQghE2Z7ccbsuzcMOtwvV9/LxoGM74hWaj8KH+hMf4b506q3hjD47jGOoAlOkLXZcMTo46sz0BeydKETDMfIfdYUQ+MP2RlcmiBeBJROJV22Cq65AUB1flqh9Tjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922603; c=relaxed/simple;
	bh=6EehDOOpmIN6njM8C8Ksja0bF905DNnueZTtvSexwhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwMNsKv/+l7AZqQFXkgC4Lp+ogBtIHOY5vpMhJTuhZ/12BX3UY12Og8l0c51tHOb5h9BwBgL6DtXi5O1kK/qlCLvfXBcN5ic8zVqipCwVhlpRT2M7JsFQG9O5avze7dEGMBV8XG9kAKXFwepHNeGHGDvGOXmRg6hFcC4QdBV6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8K66Ufl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777922602; x=1809458602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6EehDOOpmIN6njM8C8Ksja0bF905DNnueZTtvSexwhc=;
  b=C8K66UflgURtBKPsQY7OCbFxs7Q5YurIEixfhe3jJ+LcLhja0kHlzRCC
   pInL0yMM2t6t+sEn8FNdTfoFycD9l1CNhfku4JvLf5UWVJlNznzRsM7Q2
   6rkN64qJx1lgn76eMJDj9iw8FWIcKOI5BHj6kWV+2I1F25aeUaiBoU3te
   s3ZT92LKDDfOndWncsDbxEOT1mxBUa47/j/IMS4KdmRVVcPTs1ODQIYwD
   NTeWxNkaK8QIEU8HbEIzMPU619j/X04vw1pEC4kzTcIPxvo0kDrmEHV3D
   LMsj5gzLFKLo9NMpoq5gNHnHdXscPQ8HBZLnFbXb5r690PPtDau+eR4h8
   Q==;
X-CSE-ConnectionGUID: VcqMJQzMQeOI8TGSRoKOog==
X-CSE-MsgGUID: 1raj9dz8RgqOP+nJlvlEVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89482102"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89482102"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 12:23:21 -0700
X-CSE-ConnectionGUID: 6fohn/fARMWEjEy5uKwJbQ==
X-CSE-MsgGUID: 0h6DVZXBTsKewiNeZrDZ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239565838"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 12:23:13 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: badal.nilawar@intel.com,
	rodrigo.vivi@intel.com,
	wojciech.drewek@intel.com,
	michael.brooks@intel.com,
	heikki.krogerus@intel.com,
	michael.j.ruhl@intel.com,
	thomas.hellstrom@linux.intel.com,
	michal.winiarski@intel.com,
	anshuman.gupta@intel.com,
	jacob.e.keller@intel.com,
	maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	singaravelan.nallasellan@intel.com,
	kelvin.gardiner@intel.com,
	jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	james.ausmus@intel.com
Subject: [RFC PATCH 0/1] Proposal for in-band firmware update over PLDM-MCTP
Date: Tue,  5 May 2026 01:04:21 +0530
Message-ID: <20260504193420.1232842-3-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E24D04C3318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284026-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badal.nilawar@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]

Problem statement: 

The CRI platform includes a dedicated I2C controller for in-band access to AMC.
AMC firmware updates leverage PLDM over MCTP, using the I2C controller as the
physical transport, enabled by the Linux kernel's MCTP-I2C driver
(drivers/net/mctp/mctp-i2c.c), which manages MCTP framing and delivery over the
I2C bus.

CRI Inband firmware update flow

        +-----------------------------------+
        |         User Space                |
        |	(PLDM requester/responder)  | 
        |   PLDM client via AF_MCTP socket  |
        +-----------------------------------+
                          |
        +-----------------------------------+
        |        net/mctp core              |
        |   (routing, EID resolution,       |
        |    MCTP framing)                  |
        +-----------------------------------+
                          |
        +-----------------------------------+
        |           mctp-i2c.c              |
        |   MCTP transport over i2c         |
        +-----------------------------------+
                          |
        +-----------------------------------+
        |          AMC Firmware             |
        |	(PLDM requester/responder)  | 
        |  MCTP Decode -> PLDM Processing   |
        +-----------------------------------+

Future GPU platforms may not include a dedicated I2C controller for MCTP
access; however, the requirement to support PLDM over MCTP persists. To
address this, a vendor-specific mailbox-based transport is proposed to
carry MCTP messages between the host and the GPU/AMC.

Solution:

The proposed approach involves implementing an MCTP transport layer with
binding type MCTP_PHYS_BINDING_VENDOR (0xFF) and incorporating it either
into the drivers/net/mctp/ directory or the drivers/gpu/drm/xe subsystem.
The latter is particularly fitting, as Xe is the exclusive consumer of
this functionality.


Option 1: MCTP Transport as Part of drivers/gpu/drm/xe Subsystem

Under this design, the Xe KMD takes sole ownership of the MCTP mailbox
transport layer. The implementation is introduced as a new source file,
xe-mctp-mailbox.c, placed within the drivers/gpu/drm/xe/ driver tree.

Although xe-mctp-mailbox.c resides within the Xe subsystem, it does not
operate in isolation from the broader networking stack. It integrates
with the standard Linux MCTP stack by registering an MCTP net device
via mctp_register_netdev(), allowing the net/mctp core to manage
routing, EID resolution, and MCTP framing in the usual way.
This means Xe retains direct ownership of the mailbox MMIO interface
(status, and data registers via BAR), while still participating as
transport in the MCTP network subsystem.


  +--------------------------------------------------+
  |                  User Space                      |
  |         (PLDM Requester / Responder)             |
  |       PLDM Client via AF_MCTP Socket             |
  +--------------------------------------------------+
                         |
                    AF_MCTP API
                         |
  +--------------------------------------------------+
  |              net/mctp Core                       |
  |    (Routing, EID Resolution, MCTP Framing)       |
  +--------------------------------------------------+
            |                        ^
            | mctp_register_netdev() | netdev / mctp_dev ops
            |   (called by Xe KMD)   |
  +--------------------------------------------------+
  | [NEW] drivers/gpu/drm/xe/xe-mctp-mailbox.c       |
  |                                                  |
  |   Owned by  : Xe KMD (drivers/gpu/drm/xe/)       |
  |   - Registers directly as MCTP net device        |
  |   - Implements MCTP transport over Mailbox MMIO  |
  +--------------------------------------------------+
                         |
           Direct MMIO access (BAR registers)
                         |
  +--------------------------------------------------+
  |         Intel Mailbox MMIO Registers             |
  |    (Doorbell, Status, Data Registers via BAR)    |
  +--------------------------------------------------+
                         |
              Hardware Mailbox Interface
                         |
  +--------------------------------------------------+
  |             GPU / AMC Firmware                   |
  |         (PLDM Requester / Responder)             |
  |   Mailbox Handler --> MCTP Decode                |
  |              --> PLDM Processing                 |
  +--------------------------------------------------+

Pros:
    + Tightly coupled with Xe and doesn't polute current generic mctp
      subsystem with vendor specific mailbox solution.
Cons:
    - Not a generic layer; cannot be easily reused or consumed
      by other drivers or subsystems outside of Xe.

RFC Patch: "xe/xe_mctp_mailbox: Add support for MCTP transport over mailbox"

Option 2: MCTP Transport as Part of net/mctp Subsystem

The MCTP mailbox driver (intel-mctp-mailbox.c) resides under
drivers/net/mctp/ and registers itself as an Auxiliary Bus Driver on the
Linux auxiliary bus. The Xe KMD is responsible for constructing an
Auxiliary Bus Device which encapsulates the mailbox ops and registering
it against the MCTP auxiliary bus driver. This binding allows the MCTP
layer to send and receive messages through the GPU mailbox interface.

  +--------------------------------------------------+
  |                  User Space                      |
  |         (PLDM Requester / Responder)             |
  |       PLDM Client via AF_MCTP Socket             |
  +--------------------------------------------------+
                         |
                    AF_MCTP API
                         |
  +--------------------------------------------------+
  |              net/mctp Core                       |
  |    (Routing, EID Resolution, MCTP Framing)       |
  +--------------------------------------------------+
                         |
              mctp_dev ops / netdev interface
                         |
  +--------------------------------------------------+
  | [NEW] drivers/net/mctp/intel-mctp-mailbox.c      |
  |                                                  |
  |   Registered as: Auxiliary Bus Driver            |
  |   - Binds to Auxiliary Device exposed by Xe KMD  |
  |   - Accesses mailbox ops shared via aux device   |
  +--------------------------------------------------+
       |                              |
       | auxiliary_driver_register()  | auxiliary_device_register()
       |                              |
  +--------------------+   +-------------------------+
  | Auxiliary Bus      |<->| Auxiliary Device        |
  | Driver             |   | (created by Xe KMD)     |
  | (intel-mctp-       |   | - Contains mailbox_ops  |
  |  mailbox.c)        |   |                         |
  | drivers/net/mctp/  |   |                         |
  +--------------------+   +-------------------------+
                         |
              mailbox_ops (send/recv via MMIO)
                         |
  +--------------------------------------------------+
  |         Intel Mailbox MMIO Registers             |
  |    (Status, Data Registers via BAR)              |
  +--------------------------------------------------+
                         |
              Hardware Mailbox Interface
                         |
  +--------------------------------------------------+
  |             GPU / AMC Firmware                   |
  |       (PLDM Requester / Responder)               |
  |   Mailbox Handler --> MCTP Decode                |
  |       --> PLDM Processing                        |
  +--------------------------------------------------+


Pros:
    + Natively part of the MCTP stack.
    + Consistent with existing MCTP transport implementations
      such as mctp-i2c and mctp-i3c. Probe occurs naturally
      when the auxiliary device is created, following standard
      kernel device model patterns.
Cons:
    - Introduction of vendor specific cases along with current
      generic mctp entries

	
Open for other ideas and suggestions.

Note: This RFC is prepared with AI assistance (e.g. GitHub Copilot etc).

Badal Nilawar (1):
  xe/xe_mctp_mailbox: Add support for MCTP transport over mailbox

 drivers/gpu/drm/xe/Makefile          |   1 +
 drivers/gpu/drm/xe/xe_device.c       |   3 +
 drivers/gpu/drm/xe/xe_device_types.h |   4 +
 drivers/gpu/drm/xe/xe_mctp_mailbox.c | 186 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_mctp_mailbox.h |  14 ++
 5 files changed, 208 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_mctp_mailbox.c
 create mode 100644 drivers/gpu/drm/xe/xe_mctp_mailbox.h

-- 
2.54.0


