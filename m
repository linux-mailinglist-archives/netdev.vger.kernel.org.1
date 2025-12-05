Return-Path: <netdev+bounces-243822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D0FCA7F98
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A281B3295609
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B532EBBA6;
	Fri,  5 Dec 2025 14:29:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132B32FA33;
	Fri,  5 Dec 2025 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764944991; cv=none; b=FIjNPJOoq80xTjSSE7rjAZGtMQwUfqiRkHet6XJxb7YCZFkA3FzNrtt6vZN4OWfm6Jc0BRmWosNcWTQ4QUgUBGj2rd7pS2gDvVhR3QCjQscKVe66iyoJraFREoo8RcEoAvuTV9bivPQylL+kqMu5B75V3McqNpx8H1KFM9YYcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764944991; c=relaxed/simple;
	bh=5ChspuaYcYtUvxmdLX9ecS+PM8u32enfiRWW7RaPn8A=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Mge85S0MmMOQ4SaAkb81yMezB3UaxQxW9iC8K/roQKCFcE7ElIKUVVdKGfIViIybSA9m7QM0oXXEHc03xxxKn57jKD/S3LhUy1gKWSOB6FUOfquhr61PS+q/oZEwQcN6eshKLbBKCoZy/RiIs2Qm8MSd23OiU+HN32CeaZpPD5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1vRWNM-000ICM-25;
	Fri, 05 Dec 2025 15:01:36 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1vRWNM-000I4e-1q;
	Fri, 05 Dec 2025 15:01:36 +0100
Message-ID: <672ab222-db78-4cad-821b-19256a7a4078@hetzner-cloud.de>
Date: Fri, 5 Dec 2025 15:01:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Autocrypt: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Cc: sdn@hetzner-cloud.de
Subject: [BUG] ice: Temporary packet processing overload causes permanent RX
 drops
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27841/Fri Dec  5 10:23:11 2025)

Hi there, I broke some network cards again. This time I noticed continuous RX packet drops with an Intel E810-XXV.

When such a card temporarily (just for a few seconds) receives a large flood of packets and the kernel cannot keep
up with processing them, the following appears in the Kernel log:

kernel: ice 0000:c7:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002b address=0x4000180000 flags=0x0020]
kernel: ice 0000:c7:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002b address=0x4000180000 flags=0x0020]
kernel: workqueue: ice_rx_dim_work [ice] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
kernel: workqueue: ice_rx_dim_work [ice] hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
kernel: workqueue: psi_avgs_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
kernel: ice 0000:c7:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002b address=0x4000180000 flags=0x0020]
kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
kernel: workqueue: ice_rx_dim_work [ice] hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
kernel: workqueue: psi_avgs_work hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
kernel: ice 0000:c7:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002b address=0x4000180000 flags=0x0020]
...

After that, the NIC seems to be in a permanently broken state and continues to drop a few percent of the received
packets, even at low data rates. When reducing the incoming packet rate to just 10.000 pps, I can see over 500 pps
of that being dropped. After reinitializing the NIC (e.g. by changing the channel count using ethtool), the error
goes away and it's rock solid again. Until the next packet flood.

We have reproduced this with:
  Linux 6.8.0-88-generic (Ubuntu 24.04)
  Linux 6.14.0-36-generic (Ubuntu 24.04 HWE)
  Linux 6.18.0-061800-generic (Ubuntu Mainline PPA)

CPU: AMD EPYC 9825 144-Core Processor (288 threads)

lspci | grep Ethernet
  c7:00.0 Ethernet controller: Intel Corporation Ethernet Controller E810-XXV for SFP (rev 02)
  c7:00.1 Ethernet controller: Intel Corporation Ethernet Controller E810-XXV for SFP (rev 02)

ethtool -i eth0
  driver: ice
  version: 6.18.0-061800-generic
  firmware-version: 4.90 0x80020ef6 1.3863.0
  expansion-rom-version: 
  bus-info: 0000:c7:00.0
  supports-statistics: yes
  supports-test: yes
  supports-eeprom-access: yes
  supports-register-dump: yes
  supports-priv-flags: yes

ethtool -l eth0
  Channel parameters for eth0:
  Pre-set maximums:
  RX:		288
  TX:		288
  Other:		1
  Combined:	288
  Current hardware settings:
  RX:		0
  TX:		32
  Other:		1
  Combined:	256
These are the defaults after boot.

ethtool -S eth0 | grep rx_dropped
  rx_dropped: 7206525
  rx_dropped.nic: 0
ethtool -S eth1 | grep rx_dropped
  rx_dropped: 6889634
  rx_dropped.nic: 0

How to reproduce:

1. Use another host to flood the host with the E810 NIC with 64 byte large UDP packets. I used trafgen for that and
made sure, that the source ports are randomized to make RSS spread the load over all channels. The packet rate must
be high enough to overload the packet processing on the receiving host.
In my case, 4 Mpps was already enough to make the errors show up in the kernel log and trigger the permanent packet
loss, but the needed packet rate may depend on how CPU intensive the processing of each packet is. Dropping packets
early (e.g. using iptables) makes reproducing harder.

2. Monitor the rx_dropped counter and the kernel log. After a few seconds, above warnings/errors should show up in
the kernel log.

3. Stop the traffic generator and re-run it with a way lower packet rate, e.g. 10.000 pps. Now it can be seen that
a good part of these packets is being dropped, even though the kernel could easily keep up with this small packet rate.

In my case the two ports of the E810 NIC were part of a bonding, but I don't think this is required to reproduce the
issue.

Please let me know, if there is more information I could provide.

Thanks,
Marcus

