Return-Path: <netdev+bounces-81889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0F988B813
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6392C7188
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122E812AAF3;
	Tue, 26 Mar 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apfG5dHP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400E12AAD7
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422631; cv=none; b=utpmx+IgvxIzcyq6quy/xL1j8cW7XcufbX/x8/5PlRxS6hOqB0CXXtFBxtBu2wwHRthBq5bQXGZK4sUrxLcXhPo4USgYeYLLhkCwaauBTSmVuES44yst+7BLreomE2iGY5CvyVZIMJPXPAHVNGnj5j/ufxAgS63NZjbLst93Xoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422631; c=relaxed/simple;
	bh=nyfdleGQ5dbHW19Q/O2Hbp9agoM8fvHaPF/1wNwtdec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fmC1MAtNriExeJJXEYh8OinuFUdJjj6QrX3+g6orGYm/+qN6KIZ9cNICv6TIWCU+NZn0O17vuwM1BdS83zymgk9eyqIpsRNGjeY6rUQT/98fEJ0aOEkODEeSr0QcDtAq5rseCLZkhwJIfqf9YusVPFRovbIDS2vi0fgdkNWitE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apfG5dHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ED62C43601;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711422630;
	bh=nyfdleGQ5dbHW19Q/O2Hbp9agoM8fvHaPF/1wNwtdec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=apfG5dHPnAvAsTZljVcX3hbr08ZRMh4s+dNrdmRfutGa9TI1txwL2G1j5C4K/S8pY
	 I3/Kc1G5uUDSZKHIUBYjPLzlgdrV9EWjIUusF66W2L9BrSDItUDIxYxXLURYsAvbPQ
	 53mwaKkKKO051SwDeWEMbY11A4Ae0Kd4dPM064h9AC9HmzkA7LvaKgSgG1yeARCKhx
	 0tu0WdzIfQZ0dRERkHj3FHgaXRigxOL8mk7HLzt1j7Y1NJTx3eN2m+M5loUKWe0eKH
	 2TsNKroU6/RPFHSLv7doiG73owSS+1OIjhBxOYZwI9YU6uD4FPwpLYg0E7IRP+WHix
	 LVpoeL4qh5eow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74F40D8BD1C;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: wwan: t7xx: Split 64bit accesses to fix alignment
 issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171142263047.4499.7147690554061491337.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 03:10:30 +0000
References: <20240322144000.1683822-1-bjorn@mork.no>
In-Reply-To: <20240322144000.1683822-1-bjorn@mork.no>
To: =?utf-8?b?QmrDuHJuIE1vcmsgPGJqb3JuQG1vcmsubm8+?=@codeaurora.org
Cc: netdev@vger.kernel.org, liviu@dudau.co.uk,
 chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
 chiranjeevi.rapolu@linux.intel.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Mar 2024 15:40:00 +0100 you wrote:
> Some of the registers are aligned on a 32bit boundary, causing
> alignment faults on 64bit platforms.
> 
>  Unable to handle kernel paging request at virtual address ffffffc084a1d004
>  Mem abort info:
>  ESR = 0x0000000096000061
>  EC = 0x25: DABT (current EL), IL = 32 bits
>  SET = 0, FnV = 0
>  EA = 0, S1PTW = 0
>  FSC = 0x21: alignment fault
>  Data abort info:
>  ISV = 0, ISS = 0x00000061, ISS2 = 0x00000000
>  CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000046ad6000
>  [ffffffc084a1d004] pgd=100000013ffff003, p4d=100000013ffff003, pud=100000013ffff003, pmd=0068000020a00711
>  Internal error: Oops: 0000000096000061 [#1] SMP
>  Modules linked in: mtk_t7xx(+) qcserial pppoe ppp_async option nft_fib_inet nf_flow_table_inet mt7921u(O) mt7921s(O) mt7921e(O) mt7921_common(O) iwlmvm(O) iwldvm(O) usb_wwan rndis_host qmi_wwan pppox ppp_generic nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack mt7996e(O) mt792x_usb(O) mt792x_lib(O) mt7915e(O) mt76_usb(O) mt76_sdio(O) mt76_connac_lib(O) mt76(O) mac80211(O) iwlwifi(O) huawei_cdc_ncm cfg80211(O) cdc_ncm cdc_ether wwan usbserial usbnet slhc sfp rtc_pcf8563 nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 mt6577_auxadc mdio_i2c libcrc32c compat(O) cdc_wdm cdc_acm at24 crypto_safexcel pwm_fan i2c_gpio i2c_smbus industrialio i2c_algo_bit i2c_mux_reg i2c_mux_pca954x i2c_mux_pca9541 i2c_mux_gpio i2c_mux dummy oid_registry tun sha512_arm64 sh
 a1_ce sha1_generic seqiv
>  md5 geniv des_generic libdes cbc authencesn authenc leds_gpio xhci_plat_hcd xhci_pci xhci_mtk_hcd xhci_hcd nvme nvme_core gpio_button_hotplug(O) dm_mirror dm_region_hash dm_log dm_crypt dm_mod dax usbcore usb_common ptp aquantia pps_core mii tpm encrypted_keys trusted
>  CPU: 3 PID: 5266 Comm: kworker/u9:1 Tainted: G O 6.6.22 #0
>  Hardware name: Bananapi BPI-R4 (DT)
>  Workqueue: md_hk_wq t7xx_fsm_uninit [mtk_t7xx]
>  pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
>  lr : t7xx_cldma_start+0xac/0x13c [mtk_t7xx]
>  sp : ffffffc085d63d30
>  x29: ffffffc085d63d30 x28: 0000000000000000 x27: 0000000000000000
>  x26: 0000000000000000 x25: ffffff80c804f2c0 x24: ffffff80ca196c05
>  x23: 0000000000000000 x22: ffffff80c814b9b8 x21: ffffff80c814b128
>  x20: 0000000000000001 x19: ffffff80c814b080 x18: 0000000000000014
>  x17: 0000000055c9806b x16: 000000007c5296d0 x15: 000000000f6bca68
>  x14: 00000000dbdbdce4 x13: 000000001aeaf72a x12: 0000000000000001
>  x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>  x8 : ffffff80ca1ef6b4 x7 : ffffff80c814b818 x6 : 0000000000000018
>  x5 : 0000000000000870 x4 : 0000000000000000 x3 : 0000000000000000
>  x2 : 000000010a947000 x1 : ffffffc084a1d004 x0 : ffffffc084a1d004
>  Call trace:
>  t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
>  t7xx_fsm_uninit+0x578/0x5ec [mtk_t7xx]
>  process_one_work+0x154/0x2a0
>  worker_thread+0x2ac/0x488
>  kthread+0xe0/0xec
>  ret_from_fork+0x10/0x20
>  Code: f9400800 91001000 8b214001 d50332bf (f9000022)
> 
> [...]

Here is the summary with links:
  - [net] net: wwan: t7xx: Split 64bit accesses to fix alignment issues
    https://git.kernel.org/netdev/net/c/7d5a7dd5a358

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



