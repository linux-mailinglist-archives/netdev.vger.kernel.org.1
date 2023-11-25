Return-Path: <netdev+bounces-51027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE637F8B2C
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 14:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384CC2812BB
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28546111A5;
	Sat, 25 Nov 2023 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="iFtlktG0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2020.outbound.protection.outlook.com [40.92.18.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22D7103
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 05:55:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvYYZmJBlmQsUnHqNSKAxCSuxvtSXhhoLHHiK9u7aXM9s6bYM7c97bQrS/ylO27lSyzKFBtCK93lAubM3KJvyeeOp6IsE3l7lpOiO29n+1BxHAy9ou9NZzi4aPdlNXSfFwWUhgSWuSwbYf3NRFWN5Cd01qCj1cfdDC8PpZu6YtQZPgk9s1TAsE1TN60cVDgP3gq2MYARpbsWYPcRP5qh4lCn4r3hgsc4HXjlNhJjciZCd/ZbNIkoikYgho85LyuLdkv6VRzEn1hqjS0+Bgxj5haSOU9t0aPOpuVHdWjWxdG53irkegTIDGDBP+lrQtRkRhq3oyiPOsw4J++a0F7jMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qotS3Bozgh+vG+wblLQRmfY2o+3lE0novFEzfr3HvNg=;
 b=Q8FWIWiAPMr0foj4Zyozbk7CGUYPJddYtng5CtUBLX+Aj6zgMNLRbtxGjZzr2Q2Uln6vL5briO+ly0drtd5jBYm5vBh8C3USKM4umIEVSrtaU/DGTA9oDwWye3Zyknk1T2HiSDXOpPoPgO6Z724Ey5k0ooh7sqQzKDtayrywwz8td1CaehiOu79/VR+Tj3sRqi8kp/kpsONbDrnSYpMuO4BuCkFhHT3046QVF9+Tn6ahlr3z1Ow+PJpyHnFeoVEx8oCbDD6wxaNllInZPwpuoUcUA9yCHrG2MWmsebEKxqqygKS1suWC3ZrDNauu7iITiqnwtFe4LMKZImE9d3uMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qotS3Bozgh+vG+wblLQRmfY2o+3lE0novFEzfr3HvNg=;
 b=iFtlktG0G7Myd9tRekda9RXZ/Yy0tpPpZ7ps2t929okYiU+IS1M1IY9WHR9mTkoPcPbjPy4/iQz58XqMm0HC++9FJ2aL0ebKOEXDWnGW5z1Ruux+ZIPv4uTA+Ue3GMK5iaUWUP3X/ObuCbKCgjAtJjBiucTkdHsZXzg6gvJmdGV1g9l1Uu4CT9PMYItUe8RovD2ltTvK+ETLE/aupXn8FBIVGU5D62LCndwpOKZ86c22PksHY4YSBHq3nDSMKiOzr9Wl9/k38LfRvR3Pbk8Y8kK9qaJNQ3A2cH5G6kyP7Xk4cR4sc0Xq8QMFBJs1PXtUeuw8CWWNZtVdGAyblybpHw==
Received: from LV2P220MB0845.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:17c::9)
 by EA2P220MB1498.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sat, 25 Nov
 2023 13:55:06 +0000
Received: from LV2P220MB0845.NAMP220.PROD.OUTLOOK.COM
 ([fe80::af98:f812:9490:1266]) by LV2P220MB0845.NAMP220.PROD.OUTLOOK.COM
 ([fe80::af98:f812:9490:1266%4]) with mapi id 15.20.7025.022; Sat, 25 Nov 2023
 13:55:06 +0000
Message-ID:
 <LV2P220MB08459B430FFD8830782201B4D2BFA@LV2P220MB0845.NAMP220.PROD.OUTLOOK.COM>
Subject: [BUG] r8169: deadlock when NetworkManager brings link up
From: Ian Chen <free122448@hotmail.com>
To: netdev@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Date: Sat, 25 Nov 2023 21:55:00 +0800
Autocrypt: addr=free122448@hotmail.com; prefer-encrypt=mutual;
 keydata=mDMEXtBrbxYJKwYBBAHaRw8BAQdAa9gvMh14krPTOqHsW73dssLoBAYfuWEpKz7cKVuv8zO0MUlhbiBDaGVuIChkYXRhYmFzZTY0MTI4KSA8ZnJlZTEyMjQ0OEBob3RtYWlsLmNvbT6IlgQTFggAPhYhBE3O0V40bikjuTHW9xyidUa+24sBBQJe0GtvAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEByidUa+24sByXgBAIYklSutJ41f+6oqk+toGtRZ+7We0kLhn33X+Yxy3onFAP9SJwxJCGwaT4cU18KUgFmE0r1rED5HWmiKeBwWdCjaArg4BF7Qa28SCisGAQQBl1UBBQEBB0BmbIGmAxHZohxVw/4NKyrbBq6HAT13Y9RDHJv7jgVaNwMBCAeIfgQYFggAJhYhBE3O0V40bikjuTHW9xyidUa+24sBBQJe0GtvAhsMBQkJZgGAAAoJEByidUa+24sBnsUA/2Ktsgvi8U0eE2xme+89TaDQ3o4n6O7Ewsnf4j6eGdq4AP9ucLlz7H3TTHb1OYLpz1swgcqREn++72H5xG9XvYNuCQ==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-dQ5bdL9/1yj2T60/UO0J"
User-Agent: Evolution 3.50.1 
X-TMN:
 [z/9wdMCFRya542kJ2hYlUSKsYlwt1rtwSlm7PNYSWFcfi51vP6O3EUWea/HTrVXIZREmkR/YmAg=]
X-ClientProxiedBy: BYAPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::21) To LV2P220MB0845.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:17c::9)
X-Microsoft-Original-Message-ID:
 <7e8d41da2e9edf5935d4f02fb23954b8d9b07675.camel@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2P220MB0845:EE_|EA2P220MB1498:EE_
X-MS-Office365-Filtering-Correlation-Id: b0de8f06-1bd7-492a-aee0-08dbedbe2102
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D/ApL96XQi99P7q0QRNMVO2sW8sZg99dt6A0h8hx4OXExmfdBoiFzEiazUhCP2JykV2fl7wc/chuAJR3Jh1+AIqoG90+2qGbbFzpvfL/3IhkrH1DolJz+l8YB7Zjtu4FLccdc0gRiqV9TGEbZ4tWCOCGMLZAIpxcUbj7Q/Z7Ifm/f9OeVzg7Zs//CEZnCCtG0e5aPMowbrqDCegs1CMEAsZvkJ16yWotvsfybHEH6TcDSnL9DELvJVEGgdL9Fo/6kKj2mbS1GzJ0nX036+B93pw+Xu877gvv4QTo+6/zDoa9JuqZ6B1kqrK8JQdi03Tsn3bEFeAWV8Vfw82gynTAR7p7s+LVtgVZtu8XwpTvMVI42Aiji3hlA7RntmokmmNGenxQ9DquUoA/nNEPOBSKNKZog1MknwXb6TUUQd438deEDo5YXKexpiIbGsl7uiRaStEVTEdBWlslHp07xbpSim0F2bMu7M9kNo6oDPggh5j7+wislPTW9QqCqGTwpMGOzG4QpicSpKKs0qWQ1vGAb6lItGsxpiniTq7XvLcxIMpXW2XxTGQbaDIsCW0ADBJs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2FZemNiK0dqeG8yME9Id0poS1hxSDVWT3d3UmpNbWYxSU0xYldpWHdycGdu?=
 =?utf-8?B?VFZYN1Ryb0FXaWFncGlKakppNWwrSzNVbERFWSs5aXRyTklVZEJQREd3NmNC?=
 =?utf-8?B?WUxaaU1iTkp6a2lya0JmK0JhSUhnd01LWkxhVGRVckVlOHdMUWhpVzNVaG9O?=
 =?utf-8?B?QVhKbmFLd3ZKTG44Tm1pdGRIWkUrNVJKNWhYWmNaODl3d0VRZFczUHNmQUxM?=
 =?utf-8?B?ZnZWOGxUcFhCSDd2U3RIRXM3OFROaUMvemlvZzh6ckpuMG40clhuc21iL1Fk?=
 =?utf-8?B?ZnBpdHZFVUliRFltR0FoS2lJTUVWNGoyVEZLV3NtVis4ODNuS2pCUVFZUlJo?=
 =?utf-8?B?TjNRR1dTR0NMcXpxV2I1MEh6azA1a1hiendYQkxVU3hDUW4xbSt5Y2xtVVQ1?=
 =?utf-8?B?MW80QVlTcUZRSUJUUkZBb3ZPdExzOG1RMTlHOFhQenM1azdSVzNMSEYzMjBL?=
 =?utf-8?B?UlgxTFdKQitteEsyekhickNWNGNsb0Vuclg2OHhCejhoRnVMWFZzWEJTTXdM?=
 =?utf-8?B?UlZ2ZnVvcTBuNUJKdjRZbEZxUHB6RlEwbi9kVzB3OFNNSHlzKzRpVkFVenhK?=
 =?utf-8?B?UkdzV1A2YXVETXQ0eTVYbC9vUjRxM2NmVkZ0QTJRRlRrZnNqRUN2UUFHdHdP?=
 =?utf-8?B?OFlGNmZ1eEVKaGQrWHNycGhVTGl4TmtiWGdmYnVkaGwzU0dwNDN2SGpGaWx2?=
 =?utf-8?B?UDVkamdSc0lGeHAveVdlVWlZVmEwNDgrNUpRN0N4TXBEcWxsTTBUeWdiVDVH?=
 =?utf-8?B?OS9MdTlxY0F5Z1lXSGhYVi8zWms0bTZobjdnZXRNdGVkL3ZLT1BHbjIwczU1?=
 =?utf-8?B?TU1MRDRxR3BEVzcwV1BWNGkycWNQdjNWZGsvZ0swbGpwN05mN1hWSEo5YkxR?=
 =?utf-8?B?dEw2MTVHbk1kUnVUazBFb0dkSUJRRGVtRWZFdmZlNnZ1bEYzSW1aTDZQQmZ3?=
 =?utf-8?B?dGJZMVJpeGRsZUJoUnlndU93MXg5MCtPQTNFM0VvbEpBQmJQeXk0ajN0blAx?=
 =?utf-8?B?MHBvVm81Y0RzVGNnMy9leXcvZlNSaUZONlYzcjhQcmpGK1hmd3hJeno1NWVi?=
 =?utf-8?B?OW53VmhRMWd2U0tuZzVyWXZJZkZUbTVxWER2NFdwcjZic1ZIT0FzSTJsa0Fp?=
 =?utf-8?B?d21lQlZYazBhdkJUSDQxcHZvNjlKemtxM2Jaa1ZpQnJSTTFIMzhBaWtjYzZN?=
 =?utf-8?B?TW1tZUo1d1gzc1dZbmNndkdYemJ5bnpnS3BOa3Bia0R4T0RPTlVncm1USCtZ?=
 =?utf-8?B?ZG9GcmhaNDk4ZURUNFRCcldkRkFNTy8wdnJhSytJWkNtemtqeFZ1a2JCZnlp?=
 =?utf-8?B?TGhXMGNmYUV1Zm4ySTdxZ0VsTXM3MEphc1pMZTU5dVd0VWJkWk5QQmZtQ3JG?=
 =?utf-8?B?SzVYRTkrL3lCeElHQ3UzdEZLNm5OSUxBeGdrUFpwWEM2ZlA0REk5Q2wwNFVE?=
 =?utf-8?B?OHVRQnZLeStzaVpPd2NvRTBNN3ZxaW1OdWlxcEFrZ2JnOUN0QXdyV1I0QjUz?=
 =?utf-8?B?eEV2aEJNejV2NkZGWC9NdWNuakUwY21KWGlFdVkxTEIxdC9ZcVRac0VvRVJH?=
 =?utf-8?B?M09vMFJhMXVKcGJvdWRIQVJVeFdPVVFNOXpBSG5hL2dRV2FBdFRjcEVRZE5z?=
 =?utf-8?B?dlRiQUNFSk9BRmdQZ3hvZzlucDBGSDhoUDkrYUdieWE1VjdNeWZ2RDhNSzMy?=
 =?utf-8?B?S0NpRkk5NGk1VG82WldReFVLUy9BN0FKcEVFUVNLMDhwaWlwcmxSaVVXenZJ?=
 =?utf-8?Q?cpJH6kRCE/ONZ4iDIM=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b0de8f06-1bd7-492a-aee0-08dbedbe2102
X-MS-Exchange-CrossTenant-AuthSource: LV2P220MB0845.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 13:55:06.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1498

--=-dQ5bdL9/1yj2T60/UO0J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

My home server runs Arch Linux with its stock kernel on a GIGABYTE Z790
AORUS ELITE AX with its builtin RTL8125B ethernet adapter.

After upgrading from 6.6.1.arch1 to 6.6.2.arch1, booting up the system
would end up in a state where all operations on any netlink socket
would block forever. The system is effectively unusable. Here's the
relevant dmesg:

kernel: INFO: task kworker/u64:2:218 blocked for more than 122 seconds.
kernel:       Not tainted 6.6.2-arch1-1 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: task:kworker/u64:2   state:D stack:0     pid:218   ppid:2    =20
flags:0x00004000
kernel: Workqueue: events_power_efficient crda_timeout_work [cfg80211]
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x3e8/0x1410
kernel:  schedule+0x5e/0xd0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
kernel:  crda_timeout_work+0x10/0x40 [cfg80211
d1ff02bd631e7b94dc4a8630ea4cdb5aede1cb9b]
kernel:  process_one_work+0x171/0x340
kernel:  worker_thread+0x27b/0x3a0
kernel:  ? __pfx_worker_thread+0x10/0x10
kernel:  kthread+0xe5/0x120
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x31/0x50
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork_asm+0x1b/0x30
kernel:  </TASK>
kernel: INFO: task kworker/5:1:250 blocked for more than 122 seconds.
kernel:       Not tainted 6.6.2-arch1-1 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: task:kworker/5:1     state:D stack:0     pid:250   ppid:2    =20
flags:0x00004000
kernel: Workqueue: events linkwatch_event
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x3e8/0x1410
kernel:  ? sched_clock+0x10/0x30
kernel:  schedule+0x5e/0xd0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
kernel:  linkwatch_event+0x12/0x40
kernel:  process_one_work+0x171/0x340
kernel:  worker_thread+0x27b/0x3a0
kernel:  ? __pfx_worker_thread+0x10/0x10
kernel:  kthread+0xe5/0x120
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x31/0x50
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork_asm+0x1b/0x30
kernel:  </TASK>
kernel: INFO: task kworker/u64:6:290 blocked for more than 122 seconds.
kernel:       Not tainted 6.6.2-arch1-1 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: task:kworker/u64:6   state:D stack:0     pid:290   ppid:2    =20
flags:0x00004000
kernel: Workqueue: netns cleanup_net
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x3e8/0x1410
kernel:  schedule+0x5e/0xd0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
kernel:  wg_netns_pre_exit+0x19/0x100 [wireguard
0c090e6018e49e49957d27fd2202b1db304881dc]
kernel:  cleanup_net+0x1e0/0x3b0
kernel:  process_one_work+0x171/0x340
kernel:  worker_thread+0x27b/0x3a0
kernel:  ? __pfx_worker_thread+0x10/0x10
kernel:  kthread+0xe5/0x120
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x31/0x50
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork_asm+0x1b/0x30
kernel:  </TASK>
kernel: INFO: task kworker/u64:19:577 blocked for more than 122
seconds.
kernel:       Not tainted 6.6.2-arch1-1 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: task:kworker/u64:19  state:D stack:0     pid:577   ppid:2    =20
flags:0x00004000
kernel: Workqueue: events_power_efficient reg_check_chans_work
[cfg80211]
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x3e8/0x1410
kernel:  ? _get_random_bytes+0xc0/0x1a0
kernel:  schedule+0x5e/0xd0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
kernel:  ? finish_task_switch.isra.0+0x94/0x2f0
kernel:  reg_check_chans_work+0x31/0x5b0 [cfg80211
d1ff02bd631e7b94dc4a8630ea4cdb5aede1cb9b]
kernel:  process_one_work+0x171/0x340
kernel:  worker_thread+0x27b/0x3a0
kernel:  ? __pfx_worker_thread+0x10/0x10
kernel:  kthread+0xe5/0x120
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x31/0x50
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork_asm+0x1b/0x30
kernel:  </TASK>
kernel: INFO: task kworker/u64:23:581 blocked for more than 122
seconds.
kernel:       Not tainted 6.6.2-arch1-1 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: task:kworker/u64:23  state:D stack:0     pid:581   ppid:2    =20
flags:0x00004000
kernel: Workqueue: events_power_efficient phy_state_machine [libphy]
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x3e8/0x1410
kernel:  schedule+0x5e/0xd0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
kernel:  phy_state_machine+0x47/0x2c0 [libphy
93248cd1d88abf54f1b4cc64a990177f549a7710]
kernel:  process_one_work+0x171/0x340
kernel:  worker_thread+0x27b/0x3a0
kernel:  ? __pfx_worker_thread+0x10/0x10
kernel:  kthread+0xe5/0x120
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x31/0x50
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork_asm+0x1b/0x30
kernel:  </TASK>
kernel: INFO: task NetworkManager:849 blocked for more than 122
seconds.
kernel:       Not tainted 6.6.2-arch1-1 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: task:NetworkManager  state:D stack:0     pid:849   ppid:1    =20
flags:0x00004002
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x3e8/0x1410
kernel:  ? sysvec_apic_timer_interrupt+0xe/0x90
kernel:  schedule+0x5e/0xd0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
kernel:  ? pci_conf1_write+0xae/0xf0
kernel:  ? pcie_set_readrq+0x8e/0x160
kernel:  phy_start_aneg+0x1d/0x40 [libphy
93248cd1d88abf54f1b4cc64a990177f549a7710]
kernel:  rtl_reset_work+0x1bd/0x3b0 [r8169
08653ab60f23923c3943d53f140b2b697e265b93]
kernel:  r8169_phylink_handler+0x5b/0x240 [r8169
08653ab60f23923c3943d53f140b2b697e265b93]
kernel:  phy_link_change+0x2e/0x60 [libphy
93248cd1d88abf54f1b4cc64a990177f549a7710]
kernel:  phy_check_link_status+0xad/0xe0 [libphy
93248cd1d88abf54f1b4cc64a990177f549a7710]
kernel:  phy_start_aneg+0x25/0x40 [libphy
93248cd1d88abf54f1b4cc64a990177f549a7710]
kernel:  rtl8169_change_mtu+0x24/0x60 [r8169
08653ab60f23923c3943d53f140b2b697e265b93]
kernel:  dev_set_mtu_ext+0xf1/0x200
kernel:  ? select_task_rq_fair+0x82c/0x1dd0
kernel:  do_setlink+0x291/0x12d0
kernel:  ? remove_entity_load_avg+0x31/0x80
kernel:  ? sched_clock+0x10/0x30
kernel:  ? sched_clock_cpu+0xf/0x190
kernel:  ? __smp_call_single_queue+0xad/0x120
kernel:  ? ttwu_queue_wakelist+0xef/0x110
kernel:  ? __nla_validate_parse+0x61/0xd10
kernel:  ? try_to_wake_up+0x2b7/0x640
kernel:  __rtnl_newlink+0x651/0xa10
kernel:  ? __kmem_cache_alloc_node+0x1a6/0x340
kernel:  ? rtnl_newlink+0x2e/0x70
kernel:  rtnl_newlink+0x47/0x70
kernel:  rtnetlink_rcv_msg+0x14f/0x3c0
kernel:  ? number+0x33b/0x3d0
kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
kernel:  netlink_rcv_skb+0x58/0x110
kernel:  netlink_unicast+0x1a3/0x290
kernel:  netlink_sendmsg+0x254/0x4d0
kernel:  ____sys_sendmsg+0x396/0x3d0
kernel:  ? copy_msghdr_from_user+0x7d/0xc0
kernel:  ___sys_sendmsg+0x9a/0xe0
kernel:  __sys_sendmsg+0x7a/0xd0
kernel:  do_syscall_64+0x5d/0x90
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
kernel: RIP: 0033:0x7fc9232e7b3d
kernel: RSP: 002b:00007fffd4df2830 EFLAGS: 00000293 ORIG_RAX:
000000000000002e
kernel: RAX: ffffffffffffffda RBX: 0000000000000055 RCX:
00007fc9232e7b3d
kernel: RDX: 0000000000000000 RSI: 00007fffd4df2870 RDI:
000000000000000d
kernel: RBP: 00007fffd4df2c40 R08: 0000000000000000 R09:
0000000000000000
kernel: R10: 0000000000000000 R11: 0000000000000293 R12:
0000563fe71367c0
kernel: R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
kernel:  </TASK>
kernel: INFO: task geoclue:1358 blocked for more than 122 seconds.
kernel:       Not tainted 6.6.2-arch1-1 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: task:geoclue         state:D stack:0     pid:1358  ppid:1    =20
flags:0x00000002
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x3e8/0x1410
kernel:  schedule+0x5e/0xd0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
kernel:  __netlink_dump_start+0x75/0x290
kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
kernel:  rtnetlink_rcv_msg+0x277/0x3c0
kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
kernel:  netlink_rcv_skb+0x58/0x110
kernel:  netlink_unicast+0x1a3/0x290
kernel:  netlink_sendmsg+0x254/0x4d0
kernel:  __sys_sendto+0x1f6/0x200
kernel:  __x64_sys_sendto+0x24/0x30
kernel:  do_syscall_64+0x5d/0x90
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
kernel: RIP: 0033:0x7f977ae729ec
kernel: RSP: 002b:00007ffeeb6aba50 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
kernel: RAX: ffffffffffffffda RBX: 000056084849e910 RCX:
00007f977ae729ec
kernel: RDX: 0000000000000014 RSI: 00007ffeeb6abad0 RDI:
0000000000000007
kernel: RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
kernel: R10: 0000000000004000 R11: 0000000000000246 R12:
0000000000000014
kernel: R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
kernel:  </TASK>
kernel: INFO: task pool-gnome-shel:1986 blocked for more than 122
seconds.
kernel:       Not tainted 6.6.2-arch1-1 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: task:pool-gnome-shel state:D stack:0     pid:1986  ppid:1513 =20
flags:0x00000002
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x3e8/0x1410
kernel:  schedule+0x5e/0xd0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
kernel:  __netlink_dump_start+0x75/0x290
kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
kernel:  rtnetlink_rcv_msg+0x277/0x3c0
kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
kernel:  netlink_rcv_skb+0x58/0x110
kernel:  netlink_unicast+0x1a3/0x290
kernel:  netlink_sendmsg+0x254/0x4d0
kernel:  __sys_sendto+0x1f6/0x200
kernel:  __x64_sys_sendto+0x24/0x30
kernel:  do_syscall_64+0x5d/0x90
kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  ? exc_page_fault+0x7f/0x180
kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
kernel: RIP: 0033:0x7f232af30bfc
kernel: RSP: 002b:00007f223e1fbba0 EFLAGS: 00000293 ORIG_RAX:
000000000000002c
kernel: RAX: ffffffffffffffda RBX: 00007f223e1fccc0 RCX:
00007f232af30bfc
kernel: RDX: 0000000000000014 RSI: 00007f223e1fccc0 RDI:
0000000000000028
kernel: RBP: 0000000000000000 R08: 00007f223e1fcc64 R09:
000000000000000c
kernel: R10: 0000000000000000 R11: 0000000000000293 R12:
0000000000000028
kernel: R13: 00007f223e1fcc80 R14: 0000000000000665 R15:
000055638262fd10
kernel:  </TASK>
kernel: INFO: task evolution-sourc:1819 blocked for more than 122
seconds.
kernel:       Not tainted 6.6.2-arch1-1 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: task:evolution-sourc state:D stack:0     pid:1819  ppid:1513 =20
flags:0x00000006
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x3e8/0x1410
kernel:  schedule+0x5e/0xd0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
kernel:  ? netlink_lookup+0x151/0x1d0
kernel:  __netlink_dump_start+0x75/0x290
kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
kernel:  rtnetlink_rcv_msg+0x277/0x3c0
kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
kernel:  netlink_rcv_skb+0x58/0x110
kernel:  netlink_unicast+0x1a3/0x290
kernel:  netlink_sendmsg+0x254/0x4d0
kernel:  __sys_sendto+0x1f6/0x200
kernel:  __x64_sys_sendto+0x24/0x30
kernel:  do_syscall_64+0x5d/0x90
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  ? sock_getsockopt+0x22/0x30
kernel:  ? __fget_light+0x99/0x100
kernel:  ? __sys_setsockopt+0x129/0x1d0
kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
kernel: RIP: 0033:0x7f6aa096c9ec
kernel: RSP: 002b:00007fff2b442820 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
kernel: RAX: ffffffffffffffda RBX: 0000561e6b466d80 RCX:
00007f6aa096c9ec
kernel: RDX: 0000000000000014 RSI: 00007fff2b4428a0 RDI:
000000000000000a
kernel: RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
kernel: R10: 0000000000004000 R11: 0000000000000246 R12:
0000000000000014
kernel: R13: 00007fff2b442a70 R14: 0000000000000000 R15:
0000000000000001
kernel:  </TASK>
kernel: INFO: task gnome-software:1904 blocked for more than 122
seconds.
kernel:       Not tainted 6.6.2-arch1-1 #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: task:gnome-software  state:D stack:0     pid:1904  ppid:1613 =20
flags:0x00000002
kernel: Call Trace:
kernel:  <TASK>
kernel:  __schedule+0x3e8/0x1410
kernel:  ? __pte_offset_map_lock+0x9e/0x110
kernel:  schedule+0x5e/0xd0
kernel:  schedule_preempt_disabled+0x15/0x30
kernel:  __mutex_lock.constprop.0+0x39a/0x6a0
kernel:  ? netlink_lookup+0x151/0x1d0
kernel:  __netlink_dump_start+0x75/0x290
kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
kernel:  rtnetlink_rcv_msg+0x277/0x3c0
kernel:  ? __pfx_rtnl_dump_all+0x10/0x10
kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
kernel:  netlink_rcv_skb+0x58/0x110
kernel:  netlink_unicast+0x1a3/0x290
kernel:  netlink_sendmsg+0x254/0x4d0
kernel:  __sys_sendto+0x1f6/0x200
kernel:  __x64_sys_sendto+0x24/0x30
kernel:  do_syscall_64+0x5d/0x90
kernel:  ? __fget_light+0x99/0x100
kernel:  ? __sys_setsockopt+0x129/0x1d0
kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
kernel:  ? do_syscall_64+0x6c/0x90
kernel:  ? exc_page_fault+0x7f/0x180
kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
kernel: RIP: 0033:0x7fdbfd26d9ec
kernel: RSP: 002b:00007ffd15dd63e0 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
kernel: RAX: ffffffffffffffda RBX: 000056133c78f580 RCX:
00007fdbfd26d9ec
kernel: RDX: 0000000000000014 RSI: 00007ffd15dd6460 RDI:
000000000000000b
kernel: RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
kernel: R10: 0000000000004000 R11: 0000000000000246 R12:
0000000000000014
kernel: R13: 00007ffd15dd6630 R14: 0000000000000000 R15:
0000000000000001
kernel:  </TASK>
kernel: Future hung task reports are suppressed, see sysctl
kernel.hung_task_warnings

=46rom the call traces, it seems that the issue is caused by commit
621735f590643e3048ca2060c285b80551660601 (r8169: fix rare issue with
broken rx after link-down on RTL8125), which got backported to 6.6.2.

Ian

--=-dQ5bdL9/1yj2T60/UO0J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRNztFeNG4pI7kx1vcconVGvtuLAQUCZWH8tAAKCRAconVGvtuL
AfF7AP9AHdzyZpkCRbLHcleeKFJ9fhA8sRPd0pxa2kY7M+/u5QEAkf3j41rOfOhL
cg6hpID0F5cA6fg1Klg07VNvuyT/qAQ=
=EuR3
-----END PGP SIGNATURE-----

--=-dQ5bdL9/1yj2T60/UO0J--

