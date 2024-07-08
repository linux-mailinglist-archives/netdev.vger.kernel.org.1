Return-Path: <netdev+bounces-109735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C882929CA5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681AA1C20E04
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07E156E4;
	Mon,  8 Jul 2024 07:01:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046761BF3F
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422063; cv=none; b=rFnNKc5BqV5B6JImDhvXoEzYIo6ZO2Gd0b94Az5kX5RCbUopIK5msb4djSZ8CyU+8u7Ms7EYZu4dKeaNttQhw6/lqDaGCfUVsQi5KGvfoCMSo+cGkPu4ioPR/nmxrxAxWtCzBn3ldRQkyjgHFqn8yFXnsfndXr33xGyEaWeB1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422063; c=relaxed/simple;
	bh=hvRzMyw9VsOHmKJb0ZKJRQobCbvFg2m2dDqki5Ewvtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zli13LN9nB5H8qv1+e4u5gkAGHqk29xT3Z/cwQN5Zskt8MoGvMd5k2FPMlFaFgHJ7606Y7xNcQ+a7njtoZmZp28McyxDZp4z4KJ7qhZjhFUkvWAyz/Tsh24kk5hHdRxlPaRECtRqIoJiSfIKFWlU77IzZa3TACmOQqnfjL6+bWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8CxruupjotmTewBAA--.5758S3;
	Mon, 08 Jul 2024 15:00:57 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx08SYjotmHFU_AA--.4165S3;
	Mon, 08 Jul 2024 15:00:50 +0800 (CST)
Message-ID: <5f735f50-301d-4995-8637-798e4907939f@loongson.cn>
Date: Mon, 8 Jul 2024 15:00:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
 <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>
 <vss2wuq5ivfnpdfgkjsp23yaed5ve2c73loeybddhbwdx2ynt2@yfk2nmj5lmod>
 <648058f6-7e0f-4e6e-9e27-cecf48ef1e2c@loongson.cn>
 <y7uzja4j5jscllaq52fdlcibww7pp5yds4juvdtgob275eek5c@hlqljyd7nlor>
 <d8a15267-8dff-46d9-adb3-dffb5216d539@loongson.cn>
 <qj4ogerklgciopzhqrge27dngmoi7ijui274zlbuz6qozubi7n@itih73kfumhn>
 <c26f0926-7a2e-4634-8004-52a5929cd80a@loongson.cn>
 <3pmtzvpk5mu75forbcro7maegum2dehzkqajwbxyyjhauakapr@j7sovtlzc6c6>
 <16ce72fa-585a-4522-9f8c-a987f1788e67@loongson.cn>
 <2iptp5kd4kk2pqpynqx6apdhfrri3mtmhgt7kqzglgd26h7pmv@56up3lir53dd>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <2iptp5kd4kk2pqpynqx6apdhfrri3mtmhgt7kqzglgd26h7pmv@56up3lir53dd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx08SYjotmHFU_AA--.4165S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfJF1DCFy5uF18CFWfXry7urX_yoW8Gw1xKo
	WrCF1UAr4rJryUG34UCr1rtr15Jr1rtrn8Jry8Jr47JF1UJr4UJ34DGrWjq3y3tr1xGr1U
	XF1UJr17GFyUtryUl-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYG7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==


在 2024/7/7 18:40, Serge Semin 写道:
> On Sat, Jul 06, 2024 at 09:31:43PM +0800, Yanteng Si wrote:
>> 在 2024/7/5 19:53, Serge Semin 写道:
>>>> $: cat /proc/interrupts
>>>>
>>>>              CPU0       CPU1
>>>>    20:       3826      12138   CPUINTC  12  IPI
>>>>    21:      15242      11791   CPUINTC  11  timer
>>>>    22:          0          0   PCH PIC   1  acpi
>>>>    28:          0          0   PCH PIC   7  loongson-alarm
>>>>    29:          0          0   PCH PIC   8  ls2x-i2c, ls2x-i2c, ls2x-i2c,
>>>> ls2x-i2c, ls2x-i2c, ls2x-i2c
>>>>    34:       7456          0   LIOINTC  10  ttyS0
>>>>    42:       1192          0   PCH PIC  17  0000:00:06.1
>>>>    43:          0          0   PCH PIC  18  ahci[0000:00:08.0]
>>>>    44:         40          0   PCH PIC  19  enp0s3f0
>>>>    45:          0          0   PCH PIC  20  enp0s3f1
>>>>    46:       1446          0   PCH PIC  21  enp0s3f2
>>>>    47:      11164          0   PCH PIC  22  xhci-hcd:usb1
>>>>    48:        338          0   PCH PIC  23  xhci-hcd:usb3
>>>>    49:          0          0   PCH PIC  24  snd_hda_intel:card0
>>>> IPI0:       117        132  LoongArch  1  Rescheduling interrupts
>>>> IPI1:      3713      12007  LoongArch  2  Function call interrupts
>>>> ERR:          1
>>>>
>>>>
>>> So, what made you thinking that the enp0s3f0, enp0s3f1 and enp0s3f2
>>> interfaces weren't working? I failed to find any immediate problem in
>>> the log.
>> I'm sorry. I made a mistake. It works fine.
>>> The driver registered eight Rx-queues (and likely eight Tx-queues).
>>> enp0s3f0 and enp0s3f2 links got up. Even the log reported that two
>>> interfaces have some network access (whatever it meant in your
>>> boot-script):
>>>
>>>> The device(7a03 and 7a13) can access the network.
>>> Yes, there is only one IRQ registered for each interface. But that's
>>> what was expected seeing you have a single MAC IRQ detected. The
>>> main question is: do the network traffic still get to flow in this
>>> case? Are you able to send/receive data over all the DMA-channels?
>> Yes, I can. in this case, enp0s3f0/1/2 can accesswww.sing.com.
>>
>>
>> Because I did another test. I turn on the checksum.
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 25ddd99ae112..e1cde9e0e530 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -133,8 +133,8 @@ static int loongson_gmac_data(struct pci_dev *pdev,
>>                  /* Only channel 0 supports checksum,
>>                   * so turn off checksum to enable multiple channels.
>>                   */
>> -               for (i = 1; i < CHANNEL_NUM; i++)
>> -                       plat->tx_queues_cfg[i].coe_unsupported = 1;
>> +               // for (i = 1; i < CHANNEL_NUM; i++)
>> +                       // plat->tx_queues_cfg[i].coe_unsupported = 1;
>>          } else {
>>                  plat->tx_queues_to_use = 1;
>>                  plat->rx_queues_to_use = 1;
>> @@ -185,8 +185,8 @@ static int loongson_gnet_data(struct pci_dev *pdev,
>>                  /* Only channel 0 supports checksum,
>>                   * so turn off checksum to enable multiple channels.
>>                   */
>> -               for (i = 1; i < CHANNEL_NUM; i++)
>> -                       plat->tx_queues_cfg[i].coe_unsupported = 1;
>> +               // for (i = 1; i < CHANNEL_NUM; i++)
>> +                       // plat->tx_queues_cfg[i].coe_unsupported = 1;
>>          } else {
>>                  plat->tx_queues_to_use = 1;
>>                  plat->rx_queues_to_use = 1;
>> @@ -576,11 +576,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,> const struct pci_device_id
>>          if (ret)
>>                  goto err_disable_device;
>>
>> -       if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH) {
>> -               ret = loongson_dwmac_msi_config(pdev, plat, &res);
>> -               if (ret)
>> -                       goto err_disable_device;
>> -       }
>> +       if (ld->loongson_id == DWMAC_CORE_LOONGSON_MULTI_CH) {
>> +               // ret = loongson_dwmac_msi_config(pdev, plat, &res);
>> +               // if (ret)
>> +                       // goto err_disable_device;
>> +       // }
>>
>>          ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>>          if (ret)
>>
>> In this case, enp0s3f0/1/2 cannot access thewww.sing.com.
> Smart.) Indeed it implicitly proves that at least two channels get to
> work. Checking out the interface queues statistics (ethtool -S
> <interface>) would make it less implicit. Although something more
> comprehensive covering all the channels would be better. But it's up
> to you to decide whether you need such test implemented and performed.

OK.

[root@archlinux ~]# ethtool -S enp0s3f2
NIC statistics:
      mmc_tx_octetcount_gb: 77779
      mmc_tx_framecount_gb: 765
      mmc_tx_broadcastframe_g: 4
      mmc_tx_multicastframe_g: 68
      mmc_tx_64_octets_gb: 199
      mmc_tx_65_to_127_octets_gb: 480
      mmc_tx_128_to_255_octets_gb: 75
      mmc_tx_256_to_511_octets_gb: 3
      mmc_tx_512_to_1023_octets_gb: 1
      mmc_tx_1024_to_max_octets_gb: 7
      mmc_tx_unicast_gb: 693
      mmc_tx_multicast_gb: 68
      mmc_tx_broadcast_gb: 4
      mmc_tx_underflow_error: 0
      mmc_tx_singlecol_g: 0
      mmc_tx_multicol_g: 0
      mmc_tx_deferred: 0
      mmc_tx_latecol: 0
      mmc_tx_exesscol: 0
      mmc_tx_carrier_error: 0
      mmc_tx_octetcount_g: 77779
      mmc_tx_framecount_g: 765
      mmc_tx_excessdef: 0
      mmc_tx_pause_frame: 0
      mmc_tx_vlan_frame_g: 0
      mmc_tx_oversize_g: 0
      mmc_tx_lpi_usec: 0
      mmc_tx_lpi_tran: 0
      mmc_rx_framecount_gb: 33212
      mmc_rx_octetcount_gb: 2202315
      mmc_rx_octetcount_g: 2202315
      mmc_rx_broadcastframe_g: 32383
      mmc_rx_multicastframe_g: 216
      mmc_rx_crc_error: 0
      mmc_rx_align_error: 0
      mmc_rx_run_error: 0
      mmc_rx_jabber_error: 0
      mmc_rx_undersize_g: 0
      mmc_rx_oversize_g: 0
      mmc_rx_64_octets_gb: 31088
      mmc_rx_65_to_127_octets_gb: 1888
      mmc_rx_128_to_255_octets_gb: 141
      mmc_rx_256_to_511_octets_gb: 91
      mmc_rx_512_to_1023_octets_gb: 2
      mmc_rx_1024_to_max_octets_gb: 2
      mmc_rx_unicast_g: 613
      mmc_rx_length_error: 0
      mmc_rx_autofrangetype: 0
      mmc_rx_pause_frames: 0
      mmc_rx_fifo_overflow: 0
      mmc_rx_vlan_frames_gb: 0
      mmc_rx_watchdog_error: 0
      mmc_rx_error: 0
      mmc_rx_lpi_usec: 0
      mmc_rx_lpi_tran: 0
      mmc_rx_discard_frames_gb: 0
      mmc_rx_discard_octets_gb: 0
      mmc_rx_align_err_frames: 0
      mmc_rx_ipv4_gd: 920
      mmc_rx_ipv4_hderr: 0
      mmc_rx_ipv4_nopay: 0
      mmc_rx_ipv4_frag: 0
      mmc_rx_ipv4_udsbl: 0
      mmc_rx_ipv4_gd_octets: 107826
      mmc_rx_ipv4_hderr_octets: 0
      mmc_rx_ipv4_nopay_octets: 0
      mmc_rx_ipv4_frag_octets: 0
      mmc_rx_ipv4_udsbl_octets: 0
      mmc_rx_ipv6_gd_octets: 17360
      mmc_rx_ipv6_hderr_octets: 0
      mmc_rx_ipv6_nopay_octets: 0
      mmc_rx_ipv6_gd: 219
      mmc_rx_ipv6_hderr: 0
      mmc_rx_ipv6_nopay: 0
      mmc_rx_udp_gd: 571
      mmc_rx_udp_err: 0
      mmc_rx_tcp_gd: 337
      mmc_rx_tcp_err: 0
      mmc_rx_icmp_gd: 231
      mmc_rx_icmp_err: 0
      mmc_rx_udp_gd_octets: 65149
      mmc_rx_udp_err_octets: 0
      mmc_rx_tcp_gd_octets: 23525
      mmc_rx_tcp_err_octets: 0
      mmc_rx_icmp_gd_octets: 8880
      mmc_rx_icmp_err_octets: 0
      mmc_sgf_pass_fragment_cntr: 0
      mmc_sgf_fail_fragment_cntr: 0
      mmc_tx_fpe_fragment_cntr: 0
      mmc_tx_hold_req_cntr: 0
      mmc_tx_gate_overrun_cntr: 0
      mmc_rx_packet_assembly_err_cntr: 0
      mmc_rx_packet_smd_err_cntr: 0
      mmc_rx_packet_assembly_ok_cntr: 0
      mmc_rx_fpe_fragment_cntr: 0
      tx_underflow: 0
      tx_carrier: 0
      tx_losscarrier: 0
      vlan_tag: 0
      tx_deferred: 0
      tx_vlan: 0
      tx_jabber: 0
      tx_frame_flushed: 0
      tx_payload_error: 0
      tx_ip_header_error: 0
      rx_desc: 0
      sa_filter_fail: 0
      overflow_error: 0
      ipc_csum_error: 0
      rx_collision: 0
      rx_crc_errors: 0
      dribbling_bit: 0
      rx_length: 0
      rx_mii: 0
      rx_multicast: 0
      rx_gmac_overflow: 0
      rx_watchdog: 0
      da_rx_filter_fail: 0
      sa_rx_filter_fail: 0
      rx_missed_cntr: 0
      rx_overflow_cntr: 0
      rx_vlan: 0
      rx_split_hdr_pkt_n: 0
      tx_undeflow_irq: 0
      tx_process_stopped_irq: 0
      tx_jabber_irq: 0
      rx_overflow_irq: 0
      rx_buf_unav_irq: 0
      rx_process_stopped_irq: 0
      rx_watchdog_irq: 0
      tx_early_irq: 0
      fatal_bus_error_irq: 0
      rx_early_irq: 0
      threshold: 1
      irq_receive_pmt_irq_n: 0
      mmc_tx_irq_n: 0
      mmc_rx_irq_n: 0
      mmc_rx_csum_offload_irq_n: 0
      irq_tx_path_in_lpi_mode_n: 0
      irq_tx_path_exit_lpi_mode_n: 0
      irq_rx_path_in_lpi_mode_n: 0
      irq_rx_path_exit_lpi_mode_n: 0
      phy_eee_wakeup_error_n: 0
      ip_hdr_err: 0
      ip_payload_err: 0
      ip_csum_bypassed: 0
      ipv4_pkt_rcvd: 920
      ipv6_pkt_rcvd: 219
      no_ptp_rx_msg_type_ext: 1139
      ptp_rx_msg_type_sync: 0
      ptp_rx_msg_type_follow_up: 0
      ptp_rx_msg_type_delay_req: 0
      ptp_rx_msg_type_delay_resp: 0
      ptp_rx_msg_type_pdelay_req: 0
      ptp_rx_msg_type_pdelay_resp: 0
      ptp_rx_msg_type_pdelay_follow_up: 0
      ptp_rx_msg_type_announce: 0
      ptp_rx_msg_type_management: 0
      ptp_rx_msg_pkt_reserved_type: 0
      ptp_frame_type: 0
      ptp_ver: 0
      timestamp_dropped: 0
      av_pkt_rcvd: 0
      av_tagged_pkt_rcvd: 0
      vlan_tag_priority_val: 0
      l3_filter_match: 0
      l4_filter_match: 0
      l3_l4_filter_no_match: 0
      irq_pcs_ane_n: 0
      irq_pcs_link_n: 0
      irq_rgmii_n: 0
      mtl_tx_status_fifo_full: 0
      mtl_tx_fifo_not_empty: 0
      mmtl_fifo_ctrl: 0
      mtl_tx_fifo_read_ctrl_write: 0
      mtl_tx_fifo_read_ctrl_wait: 0
      mtl_tx_fifo_read_ctrl_read: 0
      mtl_tx_fifo_read_ctrl_idle: 0
      mac_tx_in_pause: 0
      mac_tx_frame_ctrl_xfer: 0
      mac_tx_frame_ctrl_idle: 0
      mac_tx_frame_ctrl_wait: 0
      mac_tx_frame_ctrl_pause: 0
      mac_gmii_tx_proto_engine: 0
      mtl_rx_fifo_fill_level_full: 0
      mtl_rx_fifo_fill_above_thresh: 0
      mtl_rx_fifo_fill_below_thresh: 0
      mtl_rx_fifo_fill_level_empty: 0
      mtl_rx_fifo_read_ctrl_flush: 0
      mtl_rx_fifo_read_ctrl_read_data: 0
      mtl_rx_fifo_read_ctrl_status: 0
      mtl_rx_fifo_read_ctrl_idle: 0
      mtl_rx_fifo_ctrl_active: 0
      mac_rx_frame_ctrl_fifo: 0
      mac_gmii_rx_proto_engine: 0
      mtl_est_cgce: 0
      mtl_est_hlbs: 0
      mtl_est_hlbf: 0
      mtl_est_btre: 0
      mtl_est_btrlm: 0
      rx_pkt_n: 33212
      rx_normal_irq_n: 33004
      tx_pkt_n: 764
      tx_normal_irq_n: 33
      tx_clean: 651
      tx_set_ic_bit: 33
      tx_tso_frames: 0
      tx_tso_nfrags: 0
      normal_irq_n: 33037
      napi_poll: 33655
      q0_tx_pkt_n: 512
      q0_tx_irq_n: 26
      q1_tx_pkt_n: 15
      q1_tx_irq_n: 0
      q2_tx_pkt_n: 33
      q2_tx_irq_n: 1
      q3_tx_pkt_n: 9
      q3_tx_irq_n: 0
      q4_tx_pkt_n: 20
      q4_tx_irq_n: 0
      q5_tx_pkt_n: 9
      q5_tx_irq_n: 0
      q6_tx_pkt_n: 134
      q6_tx_irq_n: 5
      q7_tx_pkt_n: 32
      q7_tx_irq_n: 1
      q0_rx_pkt_n: 33212
      q0_rx_irq_n: 33004
      q1_rx_pkt_n: 0
      q1_rx_irq_n: 0
      q2_rx_pkt_n: 0
      q2_rx_irq_n: 0
      q3_rx_pkt_n: 0
      q3_rx_irq_n: 0
      q4_rx_pkt_n: 0
      q4_rx_irq_n: 0
      q5_rx_pkt_n: 0
      q5_rx_irq_n: 0
      q6_rx_pkt_n: 0
      q6_rx_irq_n: 0
      q7_rx_pkt_n: 0
      q7_rx_irq_n: 0
[root@archlinux ~]#


Thanks,

Yanteng


