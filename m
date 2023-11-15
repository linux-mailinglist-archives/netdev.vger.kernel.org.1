Return-Path: <netdev+bounces-48157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016917ECA7A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BD81F27493
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063C731735;
	Wed, 15 Nov 2023 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ah9pquXa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C90189
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:23:51 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFHrkkK013906;
	Wed, 15 Nov 2023 18:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SWe6sAACRynn97B1wJ+RvtftEdEn2WIAMgfM6FpK3qc=;
 b=Ah9pquXaZrjSXVNvS4YG9cmJeRFkmmpSQ30pPpTGcRZdOyt2/YoayQOar/c1ivSSjvnb
 pJc3xGDgMgRzmjAo4mD4m20c6sPyObUvp3vvGjYpVLb9ElzfswEv+Kl/XLs4dtuhjbU4
 D1YCrDUd0w7Y30TxeMJu34Z5mzepYKNOZr4ynvJdxs+o7dVuwNxsFCS3ermMHubxY6+s
 8T8xavEvg2Tq5vn7vFtZIz2Uzfh7w35lTpzhJ39uohpC5nkkfv6CPK95RI8O2d0KbMV0
 j9tjj6LJ/dClA+XTM2GgIWkeSm2lzFrErXgv8JdmPI+OgxkltKCQx1OVm1QVoz2sLUcL tw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud25f26ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Nov 2023 18:23:49 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFIEpbL016727;
	Wed, 15 Nov 2023 18:23:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxt1nub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Nov 2023 18:23:48 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFINlfC459426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 18:23:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E05FB58051;
	Wed, 15 Nov 2023 18:23:47 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9307F5805C;
	Wed, 15 Nov 2023 18:23:46 +0000 (GMT)
Received: from [9.67.182.43] (unknown [9.67.182.43])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Nov 2023 18:23:46 +0000 (GMT)
Message-ID: <bab94c00-c26e-4883-98c9-eb0a31b781fd@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2023 12:23:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/tg3: fix race condition in tg3_reset_task()
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, pavan.chebbi@broadcom.com, drc@linux.vnet.ibm.com,
        venkata.sai.duggi@ibm.com
References: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
 <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
 <CACKFLimX4Pjm89cneeTa36B519DN3mdXXo5FXfDFi6e0SBwUSA@mail.gmail.com>
 <14584a37-2882-4cd8-9380-40a532d07731@linux.vnet.ibm.com>
 <e76f324b-b043-4349-bd19-455542c6480e@linux.vnet.ibm.com>
 <CACKFLinMiWBabbBdHE=T=vR_BG1st2EsgyCN7GpPYt0g6Pq_AQ@mail.gmail.com>
Content-Language: en-US
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
In-Reply-To: <CACKFLinMiWBabbBdHE=T=vR_BG1st2EsgyCN7GpPYt0g6Pq_AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yjAFMFhs5oYuoYVvDGU36scGHxAjMGgg
X-Proofpoint-GUID: yjAFMFhs5oYuoYVvDGU36scGHxAjMGgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_17,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150143


On 11/14/2023 3:03 PM, Michael Chan wrote:
> 
> Could you provide more information about the crashes?  The
> dev_watchdog() code already checks for netif_device_present() and
> netif_running() and netif_carrier_ok() before proceeding to check for
> TX timeout.  Why would adding some additional checks for PCI errors
> cause problems?  Of course the additional checks should only be done
> on PCI devices only.  Thanks.

The checking for PCI errors is not the problem, avoiding calling drivers 
->ndo_tx_timeout() function, causing some issue.
Here is the fix in the dev_watchdog():

--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -24,6 +24,7 @@
  #include <linux/if_vlan.h>
  #include <linux/skb_array.h>
  #include <linux/if_macvlan.h>
+#include <linux/pci.h>
  #include <net/sch_generic.h>
  #include <net/pkt_sched.h>
  #include <net/dst.h>
@@ -521,12 +522,32 @@ static void dev_watchdog(struct timer_list *t)
               }

               if (unlikely(some_queue_timedout)) {
+                      struct pci_dev *pci_dev;
+
                        trace_net_dev_xmit_timeout(dev, i);
                        WARN_ONCE(1, KERN_INFO "NETDEV WATCHDOG: %s 
(%s): transmit queue %u timed out\n",
                        dev->name, netdev_drivername(dev), i);
-                      netif_freeze_queues(dev);
-                      dev->netdev_ops->ndo_tx_timeout(dev, i);
-                      netif_unfreeze_queues(dev);
+                      pci_dev = to_pci_dev(dev->dev.parent);
+                      if (pci_dev && (pci_dev->error_state != 
pci_channel_io_normal)) {
+                    /* checking the PCI channel state for hard errors
+                     * for pci_channel_io_frozen case
+                     * - I/O to channel is blocked.
+                     *   The EEH layer and I/O error detections will
+                     *   handle the reset procedure
+                     * for pci_channel_io_perm_failure  case
+                     * - the PCI card is dead. The reset will not help
+                     * Report the error for either case, but not calling
+                     * the driver's ndo_tx_timeout() function.
+                     */
+                          if (pci_dev->error_state == 
pci_channel_io_frozen)
+                               netdev_err(dev, " %s, I/O to channel is 
blocked\n",dev->name);
+                          else
+                              netdev_err(dev, " %s, adapter has failed 
permanently!\n", dev->name );
+                      } else {
+                              netif_freeze_queues(dev);
+                              dev->netdev_ops->ndo_tx_timeout(dev, i);
+                              netif_unfreeze_queues(dev);
+                      }
               }
               if (!mod_timer(&dev->watchdog_timer,
                                 round_jiffies(jiffies +
--

from the crash dump on a system with 4-port BCM57800 adapter
crash> net
    NET_DEVICE     NAME       IP ADDRESS(ES)
c000000003581000  lo         127.0.0.1, ::1
c000000008f8b000  net0       9.3.233.69
c00000000315c000  enP23p1s0f0 101.1.233.69
c000000003164000  enP23p1s0f1 102.1.233.69
c00000000316c000  enP23p1s0f2 103.1.233.69
c000000003174000  enP23p1s0f3 104.1.233.69
crash> dmesg
[  752.115994] ------------[ cut here ]------------
[  752.115996] NETDEV WATCHDOG: enP23p1s0f0 (bnx2x): transmit queue 2 
timed out
[  752.116018] WARNING: CPU: 3 PID: 0 at net/sched/sch_generic.c:528 
dev_watchdog+0x3c8/0x420
[  752.116037] Modules linked in: rpadlpar_io rpaphp xsk_diag 
nft_counter nft_compat nf_tables nfnetlink rfkill bonding tls sunrpc 
binfmt_misc pseries_rng drm drm_panel_orientation_quirks xfs sd_mod 
t10_pi sg ibmvscsi scsi_transport_srp ibmveth bnx2x vmx_crypto mdio 
pseries_wdt libcrc32c dm_mirror dm_region_hash dm_log dm_mod fuse

------ snip the watchdog's dump ---------
------ in dev_watchdog() checking the PCI error and skipping 
->ndo_tx_timeout()  --------

[  752.116430] ---[ end trace 868b17f3f105be7b ]---
[  752.116437] bnx2x 0017:01:00.0 enP23p1s0f0:  enP23p1s0f0, I/O to 
channel is blocked
[  752.195975] bnx2x: [bnx2x_timer:5811(enP23p1s0f3)]MFW seems hanged: 
drv_pulse (0x2ca) != mcp_pulse (0x7fff)
[  752.195986] bnx2x: 
[bnx2x_acquire_hw_lock:2023(enP23p1s0f3)]lock_status 0xffffffff 
resource_bit 0x1
[  752.196507] bnx2x 0017:01:00.3 enP23p1s0f3: MDC/MDIO access timeout
[  752.196792] EEH: Recovering PHB#17-PE#10000
[  752.196795] EEH: PE location: N/A, PHB location: N/A
[  752.196797] EEH: Frozen PHB#17-PE#10000 detected
[  752.196798] EEH: Call Trace:
[  752.196799] EEH: [c00000000005102c] __eeh_send_failure_event+0x7c/0x160
[  752.196808] EEH: [c000000000049cf4] 
eeh_dev_check_failure.part.0+0x254/0x650
[  752.196812] EEH: [c00800000107c7a0] bnx2x_timer+0x1e8/0x250 [bnx2x]
[  752.196863] EEH: [c00000000023eb00] call_timer_fn+0x50/0x1c0

--------- snip here -------------

[  752.196913] EEH: This PCI device has failed 1 times in the last hour 
and will be permanently disabled after 5 failures.
[  752.196915] EEH: Notify device drivers to shutdown
[  752.196918] EEH: Beginning: 'error_detected(IO frozen)'
[  752.196920] PCI 0017:01:00.0#10000: EEH: Invoking 
bnx2x->error_detected(IO frozen)
[  752.196924] bnx2x: [bnx2x_io_error_detected:14190(enP23p1s0f0)]IO 
error detected
[  752.197024] bnx2x 0017:01:00.3 enP23p1s0f3: MDC/MDIO access timeout
[  752.197039] PCI 0017:01:00.0#10000: EEH: bnx2x driver reports: 'need 
reset'
[  752.197041] PCI 0017:01:00.1#10000: EEH: Invoking 
bnx2x->error_detected(IO frozen)
[  752.197042] bnx2x: [bnx2x_io_error_detected:14190(enP23p1s0f1)]IO 
error detected
[  752.197093] PCI 0017:01:00.1#10000: EEH: bnx2x driver reports: 'need 
reset'
[  752.197095] PCI 0017:01:00.2#10000: EEH: Invoking 
bnx2x->error_detected(IO frozen)
[  752.197096] bnx2x: [bnx2x_io_error_detected:14190(enP23p1s0f2)]IO 
error detected
[  752.197151] PCI 0017:01:00.2#10000: EEH: bnx2x driver reports: 'need 
reset'
[  752.197153] PCI 0017:01:00.3#10000: EEH: Invoking 
bnx2x->error_detected(IO frozen)
[  752.197154] bnx2x: [bnx2x_io_error_detected:14190(enP23p1s0f3)]IO 
error detected
[  752.197208] PCI 0017:01:00.3#10000: EEH: bnx2x driver reports: 'need 
reset'
[  752.197210] EEH: Finished:'error_detected(IO frozen)' with aggregate 
recovery state:'need reset'

-------------- snip here --------

[  754.407972] EEH: Beginning: 'slot_reset'
[  754.407978] PCI 0017:01:00.0#10000: EEH: Invoking bnx2x->slot_reset()
[  754.407981] bnx2x: [bnx2x_io_slot_reset:14225(enP23p1s0f0)]IO slot 
reset initializing...
[  754.408047] bnx2x 0017:01:00.0: enabling device (0140 -> 0142)
[  754.412432] bnx2x: [bnx2x_io_slot_reset:14241(enP23p1s0f0)]IO slot 
reset --> driver unload

--------- snip here ------------

[  764.526802] PCI 0017:01:00.0#10000: EEH: bnx2x driver reports: 
'recovered'
[  764.526806] PCI 0017:01:00.1#10000: EEH: Invoking bnx2x->slot_reset()
[  764.526808] bnx2x: [bnx2x_io_slot_reset:14225(enP23p1s0f1)]IO slot 
reset initializing...
[  764.526898] bnx2x 0017:01:00.1: enabling device (0140 -> 0142)
[  764.531117] bnx2x: [bnx2x_io_slot_reset:14241(enP23p1s0f1)]IO slot 
reset --> driver unload

---------- snip here --------

[  772.770957] bnx2x: [bnx2x_io_slot_reset:14241(enP23p1s0f3)]IO slot 
reset --> driver unload
[  772.886717] PCI 0017:01:00.3#10000: EEH: bnx2x driver reports: 
'recovered'
[  772.886720] EEH: Finished:'slot_reset' with aggregate recovery 
state:'recovered'
[  772.886721] EEH: Notify device driver to resume
[  772.886722] EEH: Beginning: 'resume'
[  772.886723] PCI 0017:01:00.0#10000: EEH: Invoking bnx2x->resume()
[  773.476919] bnx2x 0017:01:00.0 enP23p1s0f0: using MSI-X  IRQs: sp 55 
fp[0] 57 ... fp[7] 64
[  773.706115] bnx2x 0017:01:00.0 enP23p1s0f0: NIC Link is Up, 10000 
Mbps full duplex, Flow control: ON - receive & transmit
[  773.708230] PCI 0017:01:00.0#10000: EEH: bnx2x driver reports: 'none'
[  773.708234] PCI 0017:01:00.1#10000: EEH: Invoking bnx2x->resume()
[  774.307404] bnx2x 0017:01:00.1 enP23p1s0f1: using MSI-X  IRQs: sp 65 
fp[0] 67 ... fp[7] 74
[  774.546123] bnx2x 0017:01:00.1 enP23p1s0f1: NIC Link is Up, 10000 
Mbps full duplex, Flow control: ON - receive & transmit
[  774.548304] PCI 0017:01:00.1#10000: EEH: bnx2x driver reports: 'none'
[  774.548311] PCI 0017:01:00.2#10000: EEH: Invoking bnx2x->resume()
[  774.747483] bnx2x 0017:01:00.2 enP23p1s0f2: using MSI-X  IRQs: sp 75 
fp[0] 77 ... fp[7] 84
[  774.756111] bnx2x: [bnx2x_hw_stats_update:871(enP23p1s0f0)]NIG timer 
max (0)
[  775.038454] PCI 0017:01:00.2#10000: EEH: bnx2x driver reports: 'none'
[  775.038466] PCI 0017:01:00.3#10000: EEH: Invoking bnx2x->resume()
[  775.228049] bnx2x 0017:01:00.3 enP23p1s0f3: using MSI-X  IRQs: sp 85 
fp[0] 87 ... fp[7] 94
[  775.548237] PCI 0017:01:00.3#10000: EEH: bnx2x driver reports: 'none'
[  775.548245] EEH: Finished:'resume'
[  775.548247] EEH: Recovery successful.
[  775.556120] bnx2x: [bnx2x_hw_stats_update:871(enP23p1s0f1)]NIG timer 
max (0)
[ 1203.919654] bnx2x 0017:01:00.0 enP23p1s0f0: using MSI-X  IRQs: sp 55 
fp[0] 57 ... fp[7] 64
[ 1204.156946] bnx2x 0017:01:00.0 enP23p1s0f0: NIC Link is Up, 10000 
Mbps full duplex, Flow control: ON - receive & transmit
[ 1204.159011] IPv6: ADDRCONF(NETDEV_CHANGE): enP23p1s0f0: link becomes 
ready
[ 1204.386939] bnx2x 0017:01:00.0 enP23p1s0f0: NIC Link is Down
[ 1209.789617] bnx2x 0017:01:00.1 enP23p1s0f1: using MSI-X  IRQs: sp 65 
fp[0] 67 ... fp[7] 74
[ 1210.026894] bnx2x 0017:01:00.1 enP23p1s0f1: NIC Link is Up, 10000 
Mbps full duplex, Flow control: ON - receive & transmit
[ 1210.028955] IPv6: ADDRCONF(NETDEV_CHANGE): enP23p1s0f1: link becomes 
ready
[ 1210.357268] bnx2x 0017:01:00.0 enP23p1s0f0: NIC Link is Up, 10000 
Mbps full duplex, Flow control: ON - receive & transmit
[ 1214.526868] bnx2x 0017:01:00.1 enP23p1s0f1: NIC Link is Down
[ 1215.647561] bnx2x 0017:01:00.2 enP23p1s0f2: using MSI-X  IRQs: sp 75 
fp[0] 77 ... fp[7] 84
[ 1220.357087] bnx2x 0017:01:00.1 enP23p1s0f1: NIC Link is Up, 10000 
Mbps full duplex, Flow control: ON - receive & transmit
[ 1221.517564] bnx2x 0017:01:00.3 enP23p1s0f3: using MSI-X  IRQs: sp 85 
fp[0] 87 ... fp[7] 94
[ 1222.012323] systemd-rc-local-generator[16948]: /etc/rc.d/rc.local is 
not marked executable, skipping.
[ 1232.476909] bnx2x 0017:01:00.2 enP23p1s0f2: NIC Link is Up, 1000 Mbps 
full duplex, Flow control: ON - receive & transmit
[ 1232.476941] IPv6: ADDRCONF(NETDEV_CHANGE): enP23p1s0f2: link becomes 
ready
[ 1237.996937] bnx2x 0017:01:00.3 enP23p1s0f3: NIC Link is Up, 1000 Mbps 
full duplex, Flow control: ON - receive & transmit
[ 1237.996961] IPv6: ADDRCONF(NETDEV_CHANGE): enP23p1s0f3: link becomes 
ready


---------- snip here ---------
[ 1592.978832] Kernel attempted to write user page (e) - exploit 
attempt? (uid: 0)
[ 1592.978836] BUG: Kernel NULL pointer dereference on write at 0x0000000e
[ 1592.978838] Faulting instruction address: 0xc0080000010bb1e8
[ 1592.978841] Oops: Kernel access of bad area, sig: 11 [#1]
----------
crash> bt
PID: 41       TASK: c000000003d29b00  CPU: 5    COMMAND: "ksoftirqd/5"
  R0:  c0080000010bb1a0    R1:  c000000003b7b910    R2:  c008000001178000
  R3:  08000001173928be    R4:  c00c00000045ce40    R5:  00000000000028be
  R6:  0000000000000001    R7:  ffffffffffffffff    R8:  0000000000000000
  R9:  0000000000000010    R10: 0000000000000000    R11: c0080000010fee78
  R12: c000000000231cf0    R13: c000000fffff9080    R14: 0000000000000000
  R15: 0000000000000000    R16: 0000000000000001    R17: 0000000000000000
  R18: 08000001173928be    R19: 0000000000000000    R20: 0000000000000000
  R21: c0000001173928be    R22: c000000003164a00    R23: c000000012570200
  R24: 0000000000000000    R25: 0000000000000001    R26: c00000001c51e050
  R27: 0000000000000005    R28: c000000003164000    R29: 0000000000000000
  R30: c0000000d38a8ae0    R31: 0000000000000000
  NIP: c0080000010bb1e8    MSR: 800000000280b033    OR3: c000000000230128
  CTR: c000000000231cf0    LR:  c0080000010bb1a0    XER: 0000000020040000
  CCR: 0000000048008482    MQ:  0000000000000000    DAR: 000000000000000e
  DSISR: 0000000042000000     Syscall Result: 0000000000000000
  [NIP  : bnx2x_start_xmit+496]
  [LR   : bnx2x_start_xmit+424]
  #0 [c000000003b7b4e0] crash_kexec at c000000000279f8c
  #1 [c000000003b7b510] oops_end at c0000000000291a8
  #2 [c000000003b7b590] __bad_page_fault at c00000000008d1cc
  #3 [c000000003b7b600] data_access_common_virt at c0000000000088dc
  Data Access [300] exception frame:
  R0:  c0080000010bb1a0    R1:  c000000003b7b910    R2:  c008000001178000
  R3:  08000001173928be    R4:  c00c00000045ce40    R5:  00000000000028be
  R6:  0000000000000001    R7:  ffffffffffffffff    R8:  0000000000000000
  R9:  0000000000000010    R10: 0000000000000000    R11: c0080000010fee78
  R12: c000000000231cf0    R13: c000000fffff9080    R14: 0000000000000000
  R15: 0000000000000000    R16: 0000000000000001    R17: 0000000000000000
  R18: 08000001173928be    R19: 0000000000000000    R20: 0000000000000000
  R21: c0000001173928be    R22: c000000003164a00    R23: c000000012570200
  R24: 0000000000000000    R25: 0000000000000001    R26: c00000001c51e050
  R27: 0000000000000005    R28: c000000003164000    R29: 0000000000000000
  R30: c0000000d38a8ae0    R31: 0000000000000000
  NIP: c0080000010bb1e8    MSR: 800000000280b033    OR3: c000000000230128
  CTR: c000000000231cf0    LR:  c0080000010bb1a0    XER: 0000000020040000
  CCR: 0000000048008482    MQ:  0000000000000000    DAR: 000000000000000e
crash> bt
PID: 41       TASK: c000000003d29b00  CPU: 5    COMMAND: "ksoftirqd/5"
  R0:  c0080000010bb1a0    R1:  c000000003b7b910    R2:  c008000001178000
  R3:  08000001173928be    R4:  c00c00000045ce40    R5:  00000000000028be
  R6:  0000000000000001    R7:  ffffffffffffffff    R8:  0000000000000000
  R9:  0000000000000010    R10: 0000000000000000    R11: c0080000010fee78
  R12: c000000000231cf0    R13: c000000fffff9080    R14: 0000000000000000
  R15: 0000000000000000    R16: 0000000000000001    R17: 0000000000000000
  R18: 08000001173928be    R19: 0000000000000000    R20: 0000000000000000
  R21: c0000001173928be    R22: c000000003164a00    R23: c000000012570200
  R24: 0000000000000000    R25: 0000000000000001    R26: c00000001c51e050
  R27: 0000000000000005    R28: c000000003164000    R29: 0000000000000000
  R30: c0000000d38a8ae0    R31: 0000000000000000
  NIP: c0080000010bb1e8    MSR: 800000000280b033    OR3: c000000000230128
  CTR: c000000000231cf0    LR:  c0080000010bb1a0    XER: 0000000020040000
  CCR: 0000000048008482    MQ:  0000000000000000    DAR: 000000000000000e
  DSISR: 0000000042000000     Syscall Result: 0000000000000000
  [NIP  : bnx2x_start_xmit+496]
  [LR   : bnx2x_start_xmit+424]
  #0 [c000000003b7b4e0] crash_kexec at c000000000279f8c
  #1 [c000000003b7b510] oops_end at c0000000000291a8
  #2 [c000000003b7b590] __bad_page_fault at c00000000008d1cc
  #3 [c000000003b7b600] data_access_common_virt at c0000000000088dc
  Data Access [300] exception frame:
  R0:  c0080000010bb1a0    R1:  c000000003b7b910    R2:  c008000001178000
  R3:  08000001173928be    R4:  c00c00000045ce40    R5:  00000000000028be
  R6:  0000000000000001    R7:  ffffffffffffffff    R8:  0000000000000000
  R9:  0000000000000010    R10: 0000000000000000    R11: c0080000010fee78
  R12: c000000000231cf0    R13: c000000fffff9080    R14: 0000000000000000
  R15: 0000000000000000    R16: 0000000000000001    R17: 0000000000000000
  R18: 08000001173928be    R19: 0000000000000000    R20: 0000000000000000
  R21: c0000001173928be    R22: c000000003164a00    R23: c000000012570200
  R24: 0000000000000000    R25: 0000000000000001    R26: c00000001c51e050
  R27: 0000000000000005    R28: c000000003164000    R29: 0000000000000000
  R30: c0000000d38a8ae0    R31: 0000000000000000
  NIP: c0080000010bb1e8    MSR: 800000000280b033    OR3: c000000000230128
  CTR: c000000000231cf0    LR:  c0080000010bb1a0    XER: 0000000020040000
  CCR: 0000000048008482    MQ:  0000000000000000    DAR: 000000000000000e

crash> dis -s bnx2x_start_xmit+496
FILE: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
LINE: 3858

   3853          /* get a tx_buf and first BD
   3854           * tx_start_bd may be changed during SPLIT,
   3855           * but first_bd will always stay first
   3856           */
   3857          tx_buf = &txdata->tx_buf_ring[TX_BD(pkt_prod)];
* 3858          tx_start_bd = &txdata->tx_desc_ring[bd_prod].start_bd;
   3859          first_bd = tx_start_bd;
   3860

I have not identified the root of this crash yet.

Regards,
Thinh

