Return-Path: <netdev+bounces-298135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lf/ODIWxKmp7vAMAu9opvQ
	(envelope-from <netdev+bounces-298135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:00:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AFD6721C4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:00:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=couthit.com header.s=default header.b=mfMmyCqn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298135-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298135-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=couthit.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FB793040C95
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CE63F929B;
	Thu, 11 Jun 2026 13:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074A63FD13A;
	Thu, 11 Jun 2026 13:00:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182807; cv=none; b=PgLrlV8+Qa52D4itEf6UsBD9+eNX+5MMdY7SkXzcBNQm8ScBPWmFcuB0gEXWnhHtLPPb716rKrxsVYVSg+L+inScjVXs1QkPt7tR1VHaZ9qfkfdTvDZRRJJJ0SIyLyGMJSz/Ui9f09yXJ8HXzF8C5LNW98IzPAZhlA61UbE6s/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182807; c=relaxed/simple;
	bh=uWO1lbY+nU4FlBCgnCujnAkrMh99Z+rpaql+VS6FCpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FodjUPz8TpCtZirb984xGEMBN2tOaq37FiFn5PLuN2xHVzHQxqBMuzP/F1ClSoj0WR60/z6wCqlnYXe139nf5hECU8yiLTWyibWzYO+iqhSShDBwXgfdetl8EusbWw3f8UQd1/EhGjWNoZEM3pyTzDvDXNM5SLCIwmBFGhkXK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=mfMmyCqn; arc=none smtp.client-ip=162.240.164.96
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZznGsftuv6bAIyaYgD2VneaO8CnuMyWdwvVIbwofWdA=; b=mfMmyCqnLlI0PKldrJXXhW2OJz
	Mv+mOUURqIDVbsGcySMEq79WBiFSeWVuglBGTCrG4gsWz3XM0XtqyWKogY+KH6VowhSz6LPaOfZH1
	ow1h8x67wSE5HNkHkr5dBAB1hjFGDD5nNdMoJvJqnVvTu5fz+QrGZzPbyxxMlA1VNgFYL+QaHLp5V
	OuEdv5tHa3B27c/FJ3uN0/uwdDGvDYpw6TrpWDoc1Fg0dEiyEY4EmkudiN6DMWsbQGa2qo1i06u3e
	3PaoqPdHqDg3n8U3hZK9Edn8VqdxTHfIeZuHmrAUnrclPO4A2eZUfeHVXPe3OpcJcQQblbPQNq5qY
	RKX79Z6w==;
Received: from [115.246.246.98] (port=61440 helo=cypher.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <parvathi@couthit.com>)
	id 1wXeei-0000000611E-3ugY;
	Thu, 11 Jun 2026 08:37:09 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	basharath@couthit.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next 0/3] Introduce HSR/PRP HW offload support for PRU-ICSSM Ethernet driver
Date: Thu, 11 Jun 2026 18:03:25 +0530
Message-ID: <20260611123636.376577-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[couthit.com:s=default];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[couthit.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298135-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:parvathi@couthit.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[couthit.com:query timed out];
	FORGED_SENDER(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	HAS_X_GMSV(0.00)[parvathi@couthit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_AS(0.00)[parvathi@couthit.com];
	DKIM_TRACE(0.00)[couthit.com:-];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	HAS_X_SOURCE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_X_ANTIABUSE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[parvathi@couthit.com:query timed out,netdev@vger.kernel.org:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,couthit.com:mid,couthit.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5AFD6721C4

Hi,

This series introduces HSR and PRP protocol HW offload support for ICSSM-Prueth driver.
HW offload support for HSR/PRP is implemented using dedicated HSR/PRP firmware running
on 2 PRU cores(PRU-ICSS) as a "DAN" available in AM57xx, AM437x and AM335x.

The following features are offloaded to HW in case of HSR and PRP:
1. L2 forwarding of a HSR frame via traditional store and forward or via cut-through (only for HSR)
2. Transmit frame duplication is offloaded to HW
3. Tag removal on the receive is offloaded to HW
4. Redundant duplicate packet discard on the receive is also offloaded to HW

In HW offload mode, redundant tag insertion in the transmit path will be still done by HSR driver
and firmware updates the LAN information available in the tag on the fly when PRU is transmitting
frame in that respective LAN.

HSR Test Setup:
--------------

     ___________           ______________           ___________
    |           | Link AB |              | Link BC |           |
  __|   AM57*   |_________|AM57/AM43/AM33|_________|   AM57*   |___
 |  | Station A |         |   Station B  |         | Station C |   |
 |  |___________|         |______________|         |___________|   |
 |                                                                 |
 |_________________________________________________________________|
                            Link CA

Steps to switch to HSR forward offload mode:
-------------------------------------------------
Example assuming eth1, eth2 ports of ICSSM on AM57x, AM437x and AM335x EVM's

  1) Bring down both slave interfaces
      ip link set eth1 down
      ip link set eth2 down

  2) Set matching MAC addresses on both slave interfaces
      ip link set eth1 address <mac-addr>
      ip link set eth2 address <mac-addr>

  3) Enable HSR offload for both interfaces
      ethtool -K eth1 hsr-fwd-offload on
      ethtool -K eth1 hsr-dup-offload on
      ethtool -K eth1 hsr-tag-rm-offload on

      ethtool -K eth2 hsr-fwd-offload on
      ethtool -K eth2 hsr-dup-offload on
      ethtool -K eth2 hsr-tag-rm-offload on

  4) Create HSR interface and add slave interfaces to it
      ip link add name hsr0 type hsr slave1 eth1 slave2 eth2 \
    supervision 45 version 1

  5) Add IP address to the HSR interface
      ip addr add <IP_ADDR>/24 dev hsr0

  6) Bring up the HSR interface
      ip link set hsr0 up

  7) Bring up the both slave ports
      ip link set eth1 up
      ip link set eth2 up

Switching back to default mode:
--------------------------------
  1) Delete HSR interface
      ip link delete hsr0

  2) Disable HSR port-to-port offloading mode, packet duplication
      ethtool -K eth1 hsr-fwd-offload off
      ethtool -K eth1 hsr-dup-offload off
      ethtool -K eth1 hsr-tag-rm-offload off

      ethtool -K eth2 hsr-fwd-offload off
      ethtool -K eth2 hsr-dup-offload off
      ethtool -K eth2 hsr-tag-rm-offload off

Testing the port-to-port frame forward offload feature:
-------------------------------------------------------
  1) Connect the LAN cables as shown in the test setup.
  2) Configure Station A and Station C in HSR non-offload mode.
  3) Configure Station B is HSR offload mode.
  4) Since HSR is a redundancy protocol, disconnect cable "Link CA",
     to ensure frames from Station A reach Station C only through
     Station B.
  5) Run iperf3 Server on Station C and client on station A.
  7) Check the CPU usage on Station B.

CPU usage report on Station B using mpstat when running UDP iperf3:
-------------------------------------------------------------------

AM57xx
------

  1) Non-Offload case
  -------------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.00    0.00    0.00    0.00    0.00   10.41    0.00    0.00   89.59
    0    0.00    0.00    0.00    0.00    0.00   20.88    0.00    0.00   79.12
    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.00    0.00    0.10    0.00    0.00    0.73    0.00    0.00   99.17
    0    0.00    0.00    0.20    0.00    0.00    1.46    0.00    0.00   98.34
    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00

AM437x
------

  1) Non-Offload case
  -------------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.30    0.00    0.80    0.00    0.00   35.19    0.00    0.00   63.72
    0    0.30    0.00    0.80    0.00    0.00   35.19    0.00    0.00   63.72

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.10    0.00    0.31    0.10    0.00    1.74    0.00    0.00   97.75
    0    0.10    0.00    0.31    0.10    0.00    1.74    0.00    0.00   97.75

AM335x
------

  1) Non Offload case
  -------------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.30    0.00    1.10    0.00    0.00   90.32    0.00    0.00    8.28
    0    0.30    0.00    1.10    0.00    0.00   90.32    0.00    0.00    8.28

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.43    0.00    3.61    0.00    0.00   13.28    0.00    0.00   82.68
    0    0.43    0.00    3.61    0.00    0.00   13.28    0.00    0.00   82.68

PRP Test Setup:
---------------

     _________________        LAN-A        __________________
    |                 |eth1-----------eth1|                  |
    | AM57/AM437/AM335|                   | AM57/AM437/AM335 |
    |    station A    |eth2-----------eth2|    station B     |
    |_________________|       LAN-B       |__________________|

Steps to switch to PRP offload mode:
------------------------------------
Example assuming eth1, eth2 ports of ICSSM on AM57x, AM437x and AM335x EVM's

  1) Bring down both slave interfaces
      ip link set eth1 down
      ip link set eth2 down

  2) Set matching MAC addresses on both slave interfaces
      ip link set eth1 address <mac-addr>
      ip link set eth2 address <mac-addr>

  3) Enable PRP offload for both interfaces
      ethtool -K eth1 hsr-dup-offload on
      ethtool -K eth1 hsr-tag-rm-offload on

      ethtool -K eth2 hsr-dup-offload on
      ethtool -K eth2 hsr-tag-rm-offload on

  4) Create PRP interface and add slave interfaces to it
      ip link add name prp0 type hsr slave1 eth1 slave2 eth2 \
    supervision 45 proto 1

  5) Add IP address to the PRP interface
      ip addr add <IP_ADDR>/24 dev prp0

  6) Bring up the PRP interface
      ip link set prp0 up

  7) Bring up the both slave ports
      ip link set eth1 up
      ip link set eth2 up

Switching back to default mode:
--------------------------------
  1) Delete PRP interface
      ip link delete prp0

  2) Disable PRP offloading mode
      ethtool -K eth1 hsr-dup-offload off
      ethtool -K eth1 hsr-tag-rm-offload off

      ethtool -K eth2 hsr-dup-offload off
      ethtool -K eth2 hsr-tag-rm-offload off

Testing the PRP offload feature:
--------------------------------
  1) Connect eth1 of Station A to eth1 of Station B (LAN-A).
     Connect eth2 of Station A to eth2 of Station B (LAN-B).
  2) Configure Station A in PRP non-offload mode.
  3) Configure Station B in PRP offload mode.
  4) Run iperf3 Server on Station B and client on Station A.
  5) Check the CPU usage on Station B.
  6) Disconnect LAN-B cable to verify Station A frames still reach
     Station B over LAN-A with no traffic interruption.
  7) Reconnect LAN-B and disconnect LAN-A, verify the same.

CPU usage report on Station B using mpstat when running UDP iperf3:
-------------------------------------------------------------------

AM57x
-----

  1) Non Offload case
  -------------------
  CPU    %usr   %nice    %sys  %iowait    %irq   %soft  %steal  %guest   %idle
  all    2.04    0.00   18.85    0.00     0.00   27.83    0.00    0.00   51.27
    0    1.80    0.00   21.56    0.00     0.00   54.89    0.00    0.00   21.76
    1    2.29    0.00   16.14    0.00     0.00    0.80    0.00    0.00   80.78

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys  %iowait    %irq   %soft  %steal  %guest   %idle
  all    2.79    0.00   18.36    0.00     0.00   18.16    0.00    0.00   60.68
    0    3.89    0.00   22.16    0.00     0.00   36.13    0.00    0.00   37.82
    1    1.69    0.00   14.56    0.00     0.00    0.20    0.00    0.00   83.55

AM437x
------

  1) Non Offload case
  -------------------
  CPU    %usr   %nice    %sys   %iowait  %irq   %soft    %steal  %guest   %idle
  all    5.68    0.00    43.27   0.00    0.00    43.57    0.00     0.00    7.48
    0    5.68    0.00    43.27   0.00    0.00    43.57    0.00     0.00    7.48

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys   %iowait  %irq   %soft    %steal  %guest   %idle
  all    6.39    0.00    42.86   0.00    0.00   32.57    0.00      0.00   18.18
    0    6.39    0.00    42.86   0.00    0.00   32.57    0.00      0.00   18.18

AM335x
------

  1) Non Offload case
  -------------------
  CPU    %usr   %nice    %sys    %iowait  %irq   %soft    %steal  %guest   %idle
  all    2.29    0.00    14.04    0.00    0.00    75.50    0.00    0.00    8.17
    0    2.29    0.00    14.04    0.00    0.00    75.50    0.00    0.00    8.17

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys    %iowait  %irq   %soft    %steal  %guest   %idle
  all    5.70    0.00    48.50    0.00    0.00    29.00    0.00    0.00    16.80
    0    5.70    0.00    48.50    0.00    0.00    29.00    0.00    0.00    16.80

Note:
  hsr-tag-rm-offload and hsr-dup-offload are tightly coupled in the firmware implementation.
  They both need to be enabled / disabled together and hsr-tag-ins-offload is unsupported.

Roger Quadros (3):
  net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for
    AM57xx, AM437x and AM335x
  net: ti: icssm-prueth: Add priority based RX IRQ handlers
  net: ti: icssm-prueth: Support duplicate HW offload feature for HSR
    and PRP

 drivers/net/ethernet/ti/Makefile              |   2 +-
 .../ethernet/ti/icssm/icssm_lre_firmware.h    | 141 ++++
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 604 +++++++++++++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  68 +-
 .../ethernet/ti/icssm/icssm_prueth_common.c   | 282 ++++++++
 .../net/ethernet/ti/icssm/icssm_prueth_lre.c  | 223 +++++++
 .../net/ethernet/ti/icssm/icssm_prueth_lre.h  |  19 +
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 310 ++++++++-
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |   1 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  35 +-
 10 files changed, 1639 insertions(+), 46 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_lre_firmware.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_lre.h

-- 
2.43.0


