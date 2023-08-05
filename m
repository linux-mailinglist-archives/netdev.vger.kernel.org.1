Return-Path: <netdev+bounces-24669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F310770F85
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 14:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B7E282364
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FFBBE5E;
	Sat,  5 Aug 2023 12:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E8AD2E
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 12:06:03 +0000 (UTC)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2164.outbound.protection.outlook.com [40.92.63.164])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2734237
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 05:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GowqZsAGTkIPHwxy9b5/1+g+T9U8ONc6qPwEPhdrkZzFvt3uxjMTZAV68Wz1AOYv8ySYYPvPfr/1mOn9NwIe5V9r2tUrf/OsMMY3RCqBey4S4rP88tXiYLaIRWmUsbo+X67CWCFVpNJCrdN0VxcjLKYROM3xdCVuGsflCOWJbMpJgCqwi0p/YQvQyAfGDuvTMNouTmE7oKmh9Tx5JhoLpKh7LbLlPkavFh5ZsZq4CssRfyGy2OyAj75DT/18PMNvogShFWu6TGSlK/aVMBDjRIlhNT+uvMU4Cm3q5qRVUBvlIPrg9KfWpaUmrgQpADeKwLeqYiJrLaQHMjOMokLSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKseneX2Xa/rsEWVqxQdqGfRXcAF5a40tzRoY92lRtU=;
 b=S5VKR1xrO/f+mOifoMkfb2Q3bGqVT5N0rX3vmt/xh3xlRKQ3PEBORWJ3hQXCUWjZd31fUtrg6XNZsVkoi0Rwao4jkvLQ9P7wnXqCC70AVT5/OfXqI1txJ+dzXdAZP7BZLaMZ2+jA5eB8k4WK6oeA2FyxPCR89b7lRbozVN1NSS1sF2jgSAYQGrG4i19bm2SZ4EEpgCR/Dew+tGX5fjvyw+ZYhE6Pdac7w4nm4XQ6jnGaSkPs3b58zUUOy/AFUnjlrnjW0AUQfCK0nJr0PxG1eJK3R1anaTfgKcTQWwvldCsH6VNO21StlnKztKIimwBRNC6ZdxKgGoO6CbOntuQfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKseneX2Xa/rsEWVqxQdqGfRXcAF5a40tzRoY92lRtU=;
 b=KBGReGD+mgwB6JkzGJ+vMbsRItJjfE/bX4hasTSe4bD74LbB9U/25PCKTJiAGgXDSMJcId+bBcN4k4QJFylppudMlftRT7ZzmQtCJIW1JcIo87MLT5UggLc8IWH9ACZJdH0iey8lC/ZWRHJvwvfy9QnQMRcuG4XKPUfXxoXy9Tq20BNqk8pSHx1y2AvqsVEiS9ihT5uufzjh6Kap8zsJc37kdZ59+cz8WJZeve1jS5xUWgHSohte8qwZzvS/g9M0tTIx4QyuOhFvCdSUg+PjtseB9uBiQowSRNZZuhDovXZy3dGUdvpiQBhT4+GCCCiaI2YWPAsY3o0VVLNJBf8W9Q==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by MEAP282MB0053.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:69::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Sat, 5 Aug
 2023 12:05:54 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.022; Sat, 5 Aug 2023
 12:05:54 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: jiri@resnulli.us
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	ilpo.jarvinen@linux.intel.com,
	jesse.brandeburg@intel.com,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linuxwwan@intel.com,
	linuxwwan_5g@intel.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	songjinjian@hotmail.com,
	soumya.prakash.mishra@intel.com
Subject: Re: [net-next 3/6] net: wwan: t7xx: Implements devlink ops of firmware flashing
Date: Sat,  5 Aug 2023 20:05:35 +0800
Message-ID:
 <MEYP282MB269742CBB438E43607FA3BC4BB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB2697937841838C688E1237FDBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20230803021812.6126-1-songjinjian@hotmail.com> <MEYP282MB2697937841838C688E1237FDBB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8bit
X-TMN: [rHArD8bi8njPD1b6Dvn5Gj3bY0UcDOGv]
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <ZMt4+6rnbZE9Ejao@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|MEAP282MB0053:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a14d47-8e71-4f6b-4253-08db95ac5188
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLReiYfHXNkQ4NrfDn7Gc7QubF1vbljyUnnovM7tV+imlwYZt4LfOxiFWEj/ZoLF+Z4Xyu8U0ADufmWQgz4KRhvYFqpVIYx/vqOd1kwhz43jyDLcD80eubHE7DQS3tGEkKSCBN0VyctLC9wKSE/by6sD+xz+VdPkllyBIhOm79NcJDwGgJBsuZP/eUYP4UqcADSdx8hhPMCDY5PKjUM5Srp0miKXokCxVqABEl68b4/jUc9GvV0ABRRJRHm6DuuNJmsxevA6yN1qcLDqO0vpS3dY0VQ/yL94mCjkmsztUFWBxHae0SywalCX6lSA9AbKyXSU9VMnEkYjJThNYm8tThLuyJD8hQ+EL3M6DaVnjV3LHJxneDPqtxzTDFE812CmOcXLP0hWOWfj8FJrI2R4eTlnQTgnywYPJafL0J0OkEY1+EeoPhE7zDWonS64Yni7YXaDa1dgFt1xgyrwrmhrpjNMaFZw1BMa0epy8soqZnl2oU4gkccSO4yYi19XZ0T7xxxgc3FHHS5BL7FqsJlhFBxs75C2cmSvbvHNzeGNrfl3i+t3i1+ZRhosSf4QYA6RPTXf5PR7sIR8MNMOjS3K7BOdKU8e3zxSwewGPyEiPmoz1LuJX3WB2rEQJbMec9V8qrB2VeprC8pif4FuBrMNInT9ZWBvd98LAQ/Ic3O2iW1wgSBneYT7FrxX61H/1gy2n0YRde2WM8yXut93mnq9Qw3b9tIskpZkVGfbdwJeR/nMNZjyhdEYlD9pUc5d+E7ckusnZK+cDaVNBXab5KVd3Oft
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sFES8/pRuThSkLWivY64WcCZuN2et/Cie0GTohkSf0fWSQbtxdfut0mEomMQmbc6t0ABYMYEAOA5BR0Nc/1kzAw1eC55XvPE5549eaDIi3OpkM1pXCs1ScIH6f44VX1d2UH5oVwQkhdqrOBJRBpiZQ/h7nAtdnv+Y65keXxtIGahDhcdov8glmwwvIbgDB5Vrb+qCBYM3w9C8c5ihpkYAApIHDgNtCGjzCCefLdTHJJViA20VlNNUM3eg9cZTnRxPi5+6uf7vOD8HC8LuNlpyD5Ey3MgK3NhgEz7new6kpHEfM6X5jy4RyoTcH3jfr5S3VZ5tCjypfzlhjZ8vixxrGjj6xHddCUOOeJI+EPjOvDyHSPsni3Hyp3ji4jjavzUYVqZntZK74cxnggqKq3ZHtahCnOW4ubJ97mYi+u4cvJuhGfeRka5KCLc9uwR4z0l27PuEct+HuuTJVfk1lTj8xYx3G5fmTdpV3cu9gLwvGpJUzf9a1OFoYDYzaxwnH3wW9NRlEyMNKeVARPdCNX51hAQn0zxcYdHYR905FturxliOLbBerYbyZTch48X5IvZEDABSV6AZRAs7sA/HpuDYbTeoJmV0UsqoBbe51Hi+1s=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xiX+P3EBGSQJ7tX+yb1ob/lgrxO/OrTxm/lFulI+NHBxFeQ1SfEM9tXnJHfN?=
 =?us-ascii?Q?jUfbEaL0aF3eee4CHnxSUTZQtJWYI5Ys487WGYuUvSwc+G+cSrDaLl+DeKSH?=
 =?us-ascii?Q?putnctEPOGmk9SC2/czQjKzZp8x/mLn4LrzmUb3OM5+Lf2P25xj4FlIobjuE?=
 =?us-ascii?Q?JB37RIH8P2YGitkaZJeJMJ13pEaTD2esqUrHDzufivUc3K6R1S1v0e+hNyai?=
 =?us-ascii?Q?Y9d0SIPuFkPd0n+4yI42ZfArG/MZniOgcMPwU7GYfauAW1Dmcxy9kGErdrkM?=
 =?us-ascii?Q?cgW6jM2ZPjPEmxbayv0infPlwU2OJBZ3Bge5xfMCndcwO8hP+qtELzN4tBCA?=
 =?us-ascii?Q?xr4OJdqbp/K2egpr9XZoiGGth37RWgsauISp1ex8WgOUIPMttftOv7LapWv7?=
 =?us-ascii?Q?E8BfoPxUuiO1ORL5WvbNkPpLrRPDf7eHKv6dn6RJxiXmGxO1A8mwGyHyLxq+?=
 =?us-ascii?Q?6evJCPaVg8wbgn4K5HupJYYEVaqd98WavYaLPvA69mJBGhlX1RoSZiOuuIsu?=
 =?us-ascii?Q?62S169fuDtEuJri3yvuSC5taJiPO6sER8UrnYa9Lm1AcSzxiJ1QzBX2taTK4?=
 =?us-ascii?Q?acX7k7Jyi/KPJK7r1JTD1PqUPNiBE6nGagQJBnNJUN1x2PwJ8ShImHv4wLU7?=
 =?us-ascii?Q?1Jaxb9gLH7XSxx++9aUwQOsulcve972NCactBn+TV19QsniX6xmxdRhsthLj?=
 =?us-ascii?Q?JYHq7TnkF0OtNPJLIt7TwQpIRem12FGYZLhJIBpgF4fN/wSlSBCTd784NXco?=
 =?us-ascii?Q?uS1hEF8X5M8ovBdq64XNUZPYo18BZx+nmeWcJF/FQ/vncUsnXU2ESSAmA7uA?=
 =?us-ascii?Q?q1NwER52NgCa2sQrvOCqFpkO5hbj6ogcRSB5BzjMlFoS1c7l/EV4j5TIloqk?=
 =?us-ascii?Q?kEd0V4nH/wigmn5NunD/9IIFeABJOGCfC7tEsYnYJdH9N62I8Fp4Pjg0Qy7E?=
 =?us-ascii?Q?I2VGw0aJMH0bgIpgFH5skPljtTyMpZ+SYG0324HwAxeoAVvp2KcwcN7nst4r?=
 =?us-ascii?Q?spu0zqT9ID4S1p7dsJl+EZZo4RLRHnA99rvm70kiqVPZKIJB4+HLgm79enzC?=
 =?us-ascii?Q?bVEnAFBNF085ZWCdPgkm8il+edvGvNpYxEf6wbSetoOy3QB+DLkrLeqZtHHv?=
 =?us-ascii?Q?NQ2ybmdc3aJuJTWTSdKO/ODGS/P4PzGtH6j5z3B8QtJalrGgjYhBsn20xVKG?=
 =?us-ascii?Q?p4MXTs3ITk/c3BRBJBrpZ3yYhC6fRPsnL2Vxuta516YUdIl2Nc15WvXhKY0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a14d47-8e71-4f6b-4253-08db95ac5188
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 12:05:53.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAP282MB0053

Thu, Aug 03, 2023 at 04:18:09AM CEST, songjinjian@hotmail.com wrote:
>>From: Jinjian Song <jinjian.song@fibocom.com>
>>
>>Adds support for t7xx wwan device firmware flashing using devlink.
>>
>>On user space application issuing command for firmware update the driver
>>sends fastboot flash command & firmware to program NAND.
>>
>>In flashing procedure the fastboot command & response are exchanged between
>>driver and device.
>>
>>Below is the devlink command usage for firmware flashing
>>
>>$devlink dev flash pci/$BDF file ABC.img component ABC
>>
>>Note: ABC.img is the firmware to be programmed to "ABC" partition.
>>
>>Base on the v5 patch version of follow series:
>>'net: wwan: t7xx: fw flashing & coredump support'
>>(https://patchwork.kernel.org/project/netdevbpf/patch/fc8bbb0b66a5ff3a489ea9857d79b374508090ef.1674307425.git.m.chetan.kumar@linux.intel.com/)
>>
>>Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>
>Overall, this patch/patchset is very ugly and does some wrong or
>questionable things that make my head hurt. Ugh.

Thanks for your review, this is my first time to do this and when I git send-email,
my email account locked so the patchset break at 3/6 and I resend the remaining 3 patches again.

I will reorganize and prepare v2 version, sorry for that.

>> #include "t7xx_port_devlink.h"
>> 
>>+static int t7xx_devlink_port_read(struct t7xx_port *port, char *buf, size_t count)
>
>You have "devlink" in lot of the function and struct field names. Does
>not make sense to me as for example this function does not have anything
>to do with devlink. Could you please rename them all?

Thanks for your review, I think I can rename them all to flash_dump port read, this functions used
to send or recieve data(firmware/coredump/command) with modem

>>+	set_bit(T7XX_FLASH_STATUS, &dl->status);
>>+	port = dl->port;
>>+	dev_dbg(port->dev, "flash partition name:%s binary size:%zu\n", component, fw->size);
>>+	ret = t7xx_devlink_fb_flash_partition(port, component, fw->data, fw->size);
>>+
>>+	sprintf(flash_status, "%s %s", "flashing", !ret ? "success" : "failure");
>
>Don't put return status in to the flash_status. Function returns error
>value which is propagated to the user.
>
>In fact, in your case, usage of devlink_flash_update_status_notify()
>does not make much sense as you don't have multiple flash stages.

Thanks for your review, yes 'success' and 'failure', Function can returns error I will remove 
status notify and flash_status
 
>>+	devlink_flash_update_status_notify(devlink, flash_status, params->component, 0, 0);
>>+	clear_bit(T7XX_FLASH_STATUS, &dl->status);
>>+
>>+err_out:
>>+	return ret;
>> 	return 0;
>> }

>> static int t7xx_devlink_reload_up(struct devlink *devlink,
>>@@ -50,13 +266,114 @@ static int t7xx_devlink_reload_up(struct devlink *devlink,
>> 				  u32 *actions_performed,
>> 				  struct netlink_ext_ack *extack)
>> {
>>-	return 0;
>>+	*actions_performed = BIT(action);
>>+	switch (action) {
>>+	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
>
>Your driver reinit does not do anything. Please remove it from supported
>actions.

I want to register reinit action and fastboot param with it, so it work like follow:
1.devlink param set fastboot 1 driver_reinit
2.devlink driver_reinit
3.use space command remove driver, then driver remove function get the fastboot param 
true, then send message to modem to let modem reboot to fastboot download mode.
4.use space command rescan device, driver probe and export flash port.
5.devlink flash firmware image.

if don't suggest use devlink param fastboot driver_reinit, I think set 
fastboot flag during this action, but Intel colleague Kumar have drop that way in the old 
v2 patch version.
https://patchwork.kernel.org/project/netdevbpf/patch/20230105154300.198873-1-m.chetan.kumar@linux.intel.com/ 

>>+	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>>+		return 0;
>>+	default:
>>+		/* Unsupported action should not get to this function */
>>+		return -EOPNOTSUPP;
>>+	}
>>+}

>>+struct devlink_info_req {
>>+	struct sk_buff *msg;
>>+	void (*version_cb)(const char *version_name,
>>+			   enum devlink_info_version_type version_type,
>>+			   void *version_cb_priv);
>>+	void *version_cb_priv;
>>+};
>
>Ah! No. Remove this. If you need to touch internal of the struct, this
>is definitelly not the way to do it.

Thanks for your review, got it.

>>+
>>+struct devlink_flash_component_lookup_ctx {
>>+	const char *lookup_name;
>>+	bool lookup_name_found;
>>+};
>
>Same here.

Thanks for your review, got it.

>>+
>>+static int t7xx_devlink_info_get_loopback(struct devlink *devlink, struct devlink_info_req *req,
>>+					  struct netlink_ext_ack *extack)
>>+{
>>+	struct devlink_flash_component_lookup_ctx *lookup_ctx = req->version_cb_priv;
>>+	int ret;
>>+
>>+	if (!req)
>>+		return t7xx_devlink_info_get(devlink, req, extack);
>>+
>>+	ret = devlink_info_version_running_put_ext(req, lookup_ctx->lookup_name,
>
>It actually took me a while why you are doing this. You try to overcome
>the limitation for drivers to expose version for all components that are
>valid for flashing. That is not nice
>
>Please don't do things like this!
>
>Expose the versions for all valid components, or don't flash them.

For the old modem firmware, it don't support the info_get function, so add the logic here to 
compatible with old modem firmware update during devlink flash.

>>+						   "1.0", DEVLINK_INFO_VERSION_TYPE_COMPONENT);
>>+
>>+	return ret;
>> }
>> 

