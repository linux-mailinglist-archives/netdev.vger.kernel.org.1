Return-Path: <netdev+bounces-276682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ABGNJul1ml9GwgAu9opvQ
	(envelope-from <netdev+bounces-276682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:59:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52C3C2255
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDC6320F560
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A03AEF5F;
	Wed,  8 Apr 2026 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnNFVpDG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAEF2641FC
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674049; cv=none; b=Bk7La0Pg711LvBIlupqgyDRbNfjKj0hsP19BjpepsCu0IHq1f/osraIp9oNclESTfXR9O76vI4yQXa9RenLrODPs2Del/4aDiNAWz1QneSomFU03WhTy1TZj6c0hRjNAu4Eng0yzrKTld+zHwrsJ1SSlbbesrp8NWFCZcPmjc6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674049; c=relaxed/simple;
	bh=DmanvA9tHclxyhu+ESIggN6Ege+JBj0Mde5bEHp/2x4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XsfGmgrHoIt5hENWkNcEagOU68nDIZNTnrATOHwdHR+DsKdCab+7GPxLXPrgNgukVn1VNKnaqCElzOrOx9oZRoMdZCVgZqaQpd2GoIqtQxHemY0xYrxtmNlMMBPc96nHY9YCm1Y4La4Xobq/jKmVnp0deOEigVebgO2kV0h5r8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnNFVpDG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775674048; x=1807210048;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=DmanvA9tHclxyhu+ESIggN6Ege+JBj0Mde5bEHp/2x4=;
  b=dnNFVpDGQxWyStU46fIMsG5aB/yjiwCWM6Y2m+FbqRWsYnoiZao/rC8D
   zjvUaGaK8tF3s1j06iztpsK1lmgb03vc0rYGnHAe2CIN1CzDjCZXZdi/4
   0WdrkXKRZMxJrET5KZto9vhxW4WvGIP9dtcRyrYnlMo3LI1rMNtx91Dcn
   N+CRfX8hpEYHsBRxjMTLrP8F0ISoeNHiZCTxGZ2bNAVpxSw49/mvhZHUn
   EOxL7bJo7474wV4RIYAWp4IK88NmN9gNpNWG1pYiRbZgKpf0NviwCRRqq
   MziXdUsSMTELnHr6HnBM2YUXVmjsOxUZqX+PcfXtYvT3ZswuNuLwr5yJN
   A==;
X-CSE-ConnectionGUID: KiK7EuFmQDKt5I50mqbpuA==
X-CSE-MsgGUID: spVNKoa4STKDWDSJIlXOxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75841379"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="75841379"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 11:47:28 -0700
X-CSE-ConnectionGUID: ADitm5EzSh2dIfByfIqpTw==
X-CSE-MsgGUID: w1xbCf5STdaCnn9GT/g1+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="230217556"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 11:47:26 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net 0/4] ice: E825C missing PHY timestamp interrupt
 fixes
Date: Wed, 08 Apr 2026 11:46:30 -0700
Message-Id: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBAFf4Xs2U3aqhX9FeMB2qcuaiFdRBPCv
 1v1OJnMzKTIAqVDNVPGJCp9KmBXFYVrky5giYXJGefNxtTc3RgTEj/6DEbttoHP8obyvvEx7tb
 WttFTyYeMnyj1keR154SRTn+hz7ZDGL9jWpYPd7f0hYUAAAA=
X-Change-ID: 20260408-jk-even-more-e825c-fixes-9a6dd7311bd6
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Timothy Miskell <timothy.miskell@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-306a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5658;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=DmanvA9tHclxyhu+ESIggN6Ege+JBj0Mde5bEHp/2x4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsxri9Y2zNOprTy0fNsH8WWHGr5d2lfzKzEqbdL8A4cXv
 9Oy/7m9rqOUhUGMi0FWTJFFwSFk5XXjCWFab5zlYOawMoEMYeDiFICJtDxhZFj3nL9eqvp45pY7
 04rfzf5RWT910+u0k6zLO1xe15w+r7qS4X9AtWrVQlnp2zlyiX5s3pE8h4VePQnpVtMoeiCrqHh
 vDzcA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276682-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 7A52C3C2255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We recently ran into a nasty corner case issue with a customer operating
E825C cards seeing some strange behavior with missing Tx timestamps. During
the course of debugging. This series contains a few fixes found during this
debugging process.

The primary issue discovered in the investigation is a misconfiguration of
the E825C PHY timestamp interrupt register, PHY_REG_TS_INT_CONFIG. This
register is responsible for programming the Tx timestamp behavior of a PHY
port. The driver programs two values here: a threshold for when to
interrupt and whether the interrupt is enabled.

The threshold value is used by hardware to determine when to trigger a Tx
timestamp interrupt. The interrupt cause for the port is raised when the
number of outstanding timestamps in the PHY port timestamp memory meets the
threshold. The interrupt cause is not cleared until the number of
outstanding timestamps drops *below* the threshold.

It is considered a misconfiguration if the threshold is programmed to 0. If
the interrupt is enabled while the threshold is zero, hardware will raise
the interrupt cause at the next time it checks. Once raised, the interrupt
cause for the port will never lower, since you cannot have fewer than zero
outstanding timestamps.

Worse, the timestamp status for the port will remain high even if the
PHY_REG_TS_INT_CONFIG is reprogrammed with a new threshold. The PHY is a
separate hardware block from the MAC, and thus the interrupt status for the
port will remain high even if you reset the device MAC with a PF reset,
CORE reset, or GLOBAL reset.

PHY ports are connected together into quads. Each quad muxes the PHY
interrupt status for the 4 ports on the quad together before connecting
that to the MACs miscellaneous interrupt vector. As a result, if a single
PHY port in the quad is stuck, no timestamp interrupts will be generated
for any timestamp on any port on that quad.

The ice driver never directly writes a value of 0 for the threshold.
Indeed, the desired behavior is to set the threshold to 1, so that
interrupts are generated as soon as a single timestamp is captured.
Unfortunately, it turns out that for the E825C PHY, programming the
threshold and enable bit in the same write may cause a race in the PHY
timestamp block. The PHY may "see" the interrupt as enabled first before it
sees the threshold value. If the previous threshold value is zero (such as
when the register is initialized to zero at a cold power on), the hardware
may race with programming the threshold and set the PHY interrupt status to
high as described above.

The first patch in this series corrects that programming order, ensuring
that the threshold is always written first in a separate transaction from
enabling the interrupt bit. Additionally, an explicit check against writing
a 0 is added to make it clear to future readers that writing 0 to the
threshold while enabling the interrupt is not safe.

The PHY timestamp block does not reset with the MAC, and seems to only
reset during cold power on. This makes recovery from the faulty
configuration difficult. To address this, perform an explicit reset of the
PHY PTP block during initialization. This is achieved by writing the
PHY_REG_GLOBAL register. This performs a PHY soft reset, which completely
resets the timestamp block. This includes clearing the timestamp memory,
the PHY timestamp interrupt status, and the PHY PTP counter. A soft reset
of all ports on the device is done as part of ice_ptp_init_phc() during
early initialization of the PTP functionality by the PTP clock owner, prior
to programming each PHY. The ice_ptp_init_phc() function is called at
driver init and during reinitialization after all forms of device reset.
This ensures that the driver begins operation at a clean slate, rather than
carrying over the stale and potentially buggy configuration of a previous
driver.

While attempting to root cause the issue with the PHY timestamp interrupt,
we also discovered that the driver incorrectly assumes that it is operating
on E822 hardware when reading the PHY timestamp memory status registers in
a few places. This includes the check at the end of the interrupt handler,
as well as the check done inside the PTP auxiliary function. This prevented
the driver from detecting waiting timestamps on ports other than the first
two.

Finally, the ice_ptp_read_tx_hwstamp_status_eth56g() function was
discovered to only read the timestamp interrupt status value from the first
quad due to mistaking the port index for a PHY quad index. This resulted in
reporting the timestamp status for the second quad as identical to the
first quad instead of properly reporting its value. This is a minor fix
since the function currently is only used for diagnostic purposes and does
not impact driver decision logic.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Grzegorz Nitka (2):
      ice: fix timestamp interrupt configuration for E825C
      ice: perform PHY soft reset for E825C ports at initialization

Jacob Keller (2):
      ice: fix ready bitmap check for non-E822 devices
      ice: fix ice_ptp_read_tx_hwtstamp_status_eth56g

 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   5 +
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  40 ++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 253 +++++++++++++++++++++++++++-
 3 files changed, 265 insertions(+), 33 deletions(-)
---
base-commit: e3b6e4778608889866917014b7dfe88425073fe5
change-id: 20260408-jk-even-more-e825c-fixes-9a6dd7311bd6

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


