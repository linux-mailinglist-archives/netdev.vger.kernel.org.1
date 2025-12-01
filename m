Return-Path: <netdev+bounces-243088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC94C99684
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30914345701
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102E284662;
	Mon,  1 Dec 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3KQ70wU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2827CCF0;
	Mon,  1 Dec 2025 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764628964; cv=none; b=KbINqpFzHiO2Rs7n1PlXGzUpBNRh9486Mt5CclC4krBjsz0BMwWQ7Y8HXeawHRENKZYdoEPkC9jZZvlA8JbS0EhWsEvHJuIsKqM4+4is/oL0VSk9gJJR74cBgxbGy8k0x0CJOtD8jjiYqw+yUTSCYB2n17Sw9S4FbfjPGzxRT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764628964; c=relaxed/simple;
	bh=PxZRl6iuHCu5mhYWujwAS4a/BtPwr2KxoApM+EnapMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxoyDL59ZGl2SqDIAc+M6Llki4yTVNGpPmyvVo8WLO73S1brtXsDOeZzWAPprUbMeDvwLv1R0cYPtGysAu8eWCxWqDckpxjVgcFvRFVeWPExTUGp9U1JCU5szgPx9T3Q9/PeVCVJyzDfSMQDD78XdfLc7LovOcjLxDXWsRp1aVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3KQ70wU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABFDC4CEF1;
	Mon,  1 Dec 2025 22:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764628963;
	bh=PxZRl6iuHCu5mhYWujwAS4a/BtPwr2KxoApM+EnapMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3KQ70wUm9cigCnniI3XjHrukR4kTcq5Dn4UzYiqcTY8Dq8tUVHRhIKkynploOO9E
	 /S/sIM7Mtpwf4JdD3ozD/wRCiEv7fhg0J/YWVBpbb78y695jl2Tr5GpWS1ZXpxT/LG
	 zW8vbXtOBIA5kUcklQSIjQRsUJ2JpfTIH1pVJRBTeeU9OFKyD6Ro6FI8yfxdZcxrs8
	 fii+T3l7SncIUf3dTJ31A+zOThW2fO/nfSNIdeLT8hjdcboa++x4t6W+QKzl8hhE3T
	 uybe34MUoW34ZdjL6wM33sXw2jDslK/1ZidHvrUi4DMYz/5jOgoaHOIV3L4KW4Hcd0
	 jtJJVbXMNS5DA==
Date: Mon, 1 Dec 2025 15:42:38 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] r8169: add DASH support for RTL8127AP
Message-ID: <20251201224238.GA604467@ax162>
References: <20251126055950.2050-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126055950.2050-1-javen_xu@realsil.com.cn>

Hi Javen,

On Wed, Nov 26, 2025 at 01:59:50PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This adds DASH support for chip RTL8127AP. Its mac version is
> RTL_GIGA_MAC_VER_80. DASH is a standard for remote management of network
> device, allowing out-of-band control.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 3f5ffaa55c85..68e84462216c 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1512,6 +1512,7 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_52:
>  		return RTL_DASH_EP;
>  	case RTL_GIGA_MAC_VER_66:
> +	case RTL_GIGA_MAC_VER_80:
>  		return RTL_DASH_25_BP;
>  	default:
>  		return RTL_DASH_NONE;
> -- 
> 2.43.0
> 

I am seeing several new error messages from r8169 after this change in
-next as commit 17e9f841dd22 ("r8169: add DASH support for RTL8127AP").

  [    3.844125] r8169 0000:01:00.0 (unnamed net_device) (uninitialized): rtl_eriar_cond == 0 (loop: 100, delay: 100).
  [    3.864844] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    3.878825] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    3.892632] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    5.002551] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    5.016286] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    5.030027] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).

All r8169 messages at this change, in case there is anything else relevant there.

  [    0.000000] Linux version 6.18.0-rc7-debug-01318-g17e9f841dd22 (nathan@ax162) (x86_64-linux-gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.45) #1 SMP PREEMPT_DYNAMIC Mon Dec  1 15:30:17 MST 2025
  [    3.828802] r8169 0000:01:00.0: can't disable ASPM; OS doesn't have ASPM control
  [    3.844125] r8169 0000:01:00.0 (unnamed net_device) (uninitialized): rtl_eriar_cond == 0 (loop: 100, delay: 100).
  [    3.851005] r8169 0000:01:00.0 eth0: RTL8127A, 1c:86:0b:37:96:68, XID 6c9, IRQ 153
  [    3.851008] r8169 0000:01:00.0 eth0: jumbo features [frames: 16362 bytes, tx checksumming: ko]
  [    3.851009] r8169 0000:01:00.0 eth0: DASH enabled
  [    3.864844] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    3.878825] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    3.892632] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    4.988502] Realtek Internal NBASE-T PHY r8169-0-100:00: attached PHY driver (mii_bus:phy_addr=r8169-0-100:00, irq=MAC)
  [    5.002551] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    5.016286] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    5.030027] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
  [    5.727716] r8169 0000:01:00.0 eth0: Link is Down
  [    6.421496] r8169 0000:01:00.0: invalid VPD tag 0x00 (size 0) at offset 0; assume missing optional EEPROM
  [    8.931900] r8169 0000:01:00.0 eth0: Link is Up - 2.5Gbps/Full - flow control off

At the parent change, these messages are not present:

  [    0.000000] Linux version 6.18.0-rc7-debug-01317-g6557cae0a2a1 (nathan@ax162) (x86_64-linux-gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.45) #1 SMP PREEMPT_DYNAMIC Mon Dec  1 15:23:58 MST 2025
  [    3.828654] r8169 0000:01:00.0: can't disable ASPM; OS doesn't have ASPM control
  [    3.841662] r8169 0000:01:00.0 eth0: RTL8127A, 1c:86:0b:37:96:68, XID 6c9, IRQ 153
  [    3.841665] r8169 0000:01:00.0 eth0: jumbo features [frames: 16362 bytes, tx checksumming: ko]
  [    4.993504] Realtek Internal NBASE-T PHY r8169-0-100:00: attached PHY driver (mii_bus:phy_addr=r8169-0-100:00, irq=MAC)
  [    5.671710] r8169 0000:01:00.0 eth0: Link is Down
  [    6.941496] r8169 0000:01:00.0: invalid VPD tag 0x00 (size 0) at offset 0; assume missing optional EEPROM
  [    8.928899] r8169 0000:01:00.0 eth0: Link is Up - 2.5Gbps/Full - flow control off

I see these messages on both of my machines that have this card
installed. Some additional information, in case it is relevant.

  $ sudo ethtool -i eth0
  driver: r8169
  version: 6.18.0-rc7-debug-01318-g17e9f84
  firmware-version: rtl8127a-1_0.0.5 05/14/25
  expansion-rom-version:
  bus-info: 0000:01:00.0
  supports-statistics: yes
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: yes
  supports-priv-flags: no

  $ sudo lspci -s 01:00.0 -v
  01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8127 10GbE Controller (rev 05)
          Subsystem: Realtek Semiconductor Co., Ltd. Device 0123
          Flags: bus master, fast devsel, latency 0, IRQ 16
          I/O ports at 4000 [size=256]
          Memory at a1300000 (64-bit, non-prefetchable) [size=256K]
          Memory at a1360000 (64-bit, non-prefetchable) [size=16K]
          Expansion ROM at a1340000 [disabled] [size=128K]
          Capabilities: [40] Power Management version 3
          Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
          Capabilities: [70] Express Endpoint, IntMsgNum 1
          Capabilities: [b0] MSI-X: Enable+ Count=64 Masked-
          Capabilities: [d0] Vital Product Data
          Capabilities: [100] Advanced Error Reporting
          Capabilities: [148] Virtual Channel
          Capabilities: [164] Device Serial Number 01-00-00-00-68-4c-e0-00
          Capabilities: [174] Secondary PCI Express
          Capabilities: [184] Physical Layer 16.0 GT/s
          Capabilities: [1a8] Lane Margining at the Receiver
          Capabilities: [244] Latency Tolerance Reporting
          Capabilities: [24c] L1 PM Substates
          Capabilities: [25c] Data Link Feature <?>
          Capabilities: [268] Precision Time Measurement
          Capabilities: [274] Vendor Specific Information: ID=0003 Rev=1 Len=054 <?>
          Kernel driver in use: r8169
          Kernel modules: r8169

Maybe this is a preexisting issue or there are additional changes needed
to properly support DASH? If there is not an actual problem here, I can
mentally ignore the messages but it makes it harder to spot new errors
so it would be nice if this could be addressed.

Cheers,
Nathan

# bad: [95cb2fd6ce0ad61af54191fe5ef271d7177f9c3a] Add linux-next specific files for 20251201
# good: [e69c7c175115c51c7f95394fc55425a395b3af59] Merge tag 'timers_urgent_for_v6.18_rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect start '95cb2fd6ce0ad61af54191fe5ef271d7177f9c3a' 'e69c7c175115c51c7f95394fc55425a395b3af59'
# bad: [87d5c4addc7e535618586e7205191a7f402288ba] Merge branch 'master' of https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad 87d5c4addc7e535618586e7205191a7f402288ba
# good: [9abea31d25450ec48c284f3392a1ea285affbdf2] Merge branch 'fs-next' of linux-next
git bisect good 9abea31d25450ec48c284f3392a1ea285affbdf2
# bad: [0177f0f07886e54e12c6f18fa58f63e63ddd3c58] Merge tag 'linux-can-next-for-6.19-20251129' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
git bisect bad 0177f0f07886e54e12c6f18fa58f63e63ddd3c58
# good: [8180c4fa5444247c3fcecc98c75d53cdb801604c] Merge branch 'tools-ynl-turn-the-page-pool-sample-into-a-real-tool'
git bisect good 8180c4fa5444247c3fcecc98c75d53cdb801604c
# good: [ee458a3f314e9c669ddd227bf5ab08354d9e75cc] mptcp: introduce mptcp-level backlog
git bisect good ee458a3f314e9c669ddd227bf5ab08354d9e75cc
# bad: [c940be4c7c75684799d5bff495ac9c48ca19f183] net: Remove KMSG_COMPONENT macro
git bisect bad c940be4c7c75684799d5bff495ac9c48ca19f183
# good: [4718d39e72c008b1c96a8673719ad8f894ca4488] Merge patch series "Add R-Car CAN-FD suspend/resume support"
git bisect good 4718d39e72c008b1c96a8673719ad8f894ca4488
# good: [1fe7978329d736e90600b16b34c7656073dc7a5a] fbnic: Add handler for reporting link down event statistics
git bisect good 1fe7978329d736e90600b16b34c7656073dc7a5a
# bad: [ebb2eaeb05d0ee6bd46e98313f72eac2b0dbd9d7] Merge branch 'net-dsa-yt921x-fix-parsing-mib-attributes'
git bisect bad ebb2eaeb05d0ee6bd46e98313f72eac2b0dbd9d7
# good: [73f784b2c938e17e4af90aff4cdcaafe4ca06a5f] Merge tag 'linux-can-next-for-6.19-20251126' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
git bisect good 73f784b2c938e17e4af90aff4cdcaafe4ca06a5f
# good: [858b1d07e49106a302cc7c7fbeee4fb2698573c9] gve: Fix race condition on tx->dropped_pkt update
git bisect good 858b1d07e49106a302cc7c7fbeee4fb2698573c9
# bad: [17e9f841dd227a4dc976b22d000d5f669bc14493] r8169: add DASH support for RTL8127AP
git bisect bad 17e9f841dd227a4dc976b22d000d5f669bc14493
# good: [6557cae0a2a1952645e5df50e1d6eb7267ea2131] if_ether.h: Clarify ethertype validity for gsw1xx dsa
git bisect good 6557cae0a2a1952645e5df50e1d6eb7267ea2131
# first bad commit: [17e9f841dd227a4dc976b22d000d5f669bc14493] r8169: add DASH support for RTL8127AP

