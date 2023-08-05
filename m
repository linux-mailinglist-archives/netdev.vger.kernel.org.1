Return-Path: <netdev+bounces-24652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59106770F40
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 12:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E514B282544
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC19945F;
	Sat,  5 Aug 2023 10:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8D23A2
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 10:26:15 +0000 (UTC)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2169.outbound.protection.outlook.com [40.92.63.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CA113
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 03:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlFHjISnpyIw8eOcqoLLDMUu/Nf0AwEWrDbeuWeL/7m7dNVH5mmFlkp+s0h3VfCPR3NX0lZCUmTTtirbTByoVhtOti4Xlid5JtAZpC+/BWTSxN4seLO+yK0wWpC2EeBUdGcBsq3KPWJvay6Qu9M6kWx1Jtv1Bn+/VED2vT3PbeFqqXqg5GMYszZNXclE7uFD2qTeVaLkmNG9MK2J+aosSpHKIyFnBULC+vRarYCCNBYaVVYAQCGERS6+htxXnjLUj66MN1+FVQLqgJg/ze3MfoX/xn1DF5VkuOuP6aftmoCSre2yMaRqiQxLcswToWlLYBKiJ6oc6EjJbXD+NP6tEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i4xNTYF8DJ+gXOCoc6aF0LZ2Etjy0IKedQyqGjKPmU=;
 b=Qw7qcQ6CNc2TvwGjRFnl3jWIRO4J97ekEcEpR7CsGR3lxtuP6O0a0qkliD/K/0l/p+ChFsuhWkd6c48hwJH8ESLmzw4ZvnfKXjRCJUNCuJOCEAkb56pSscnCNMY73geHsv/vSI2K4/IFt6pbUq30bOKxLqiCMbBp2FXH5rxB2BqtrcaE5/h86E7C7KUGVPWUUdx/sF7j3WfqWCgLIrdhGJlNNfjxjZvSzp0nzkZIwDTsvmdqm+HuXBD376eVwFF1OxH19KsgcsFQReVCHOGPEeYvUm78ZQfKk429OpxCeidYkeZGZeYZU6mZ1nN4FBqUjOKPDxGgy7O6xrlBHmGk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i4xNTYF8DJ+gXOCoc6aF0LZ2Etjy0IKedQyqGjKPmU=;
 b=snCpDzgyJFjvg6Bhzj0jlaTm36MsJ+LcZ22GBTwwyP9WjuCGVLSwVszMemvHSxeaCbQ9+IpEgxyr2kUS2PE/Qc04YqIRutvzrHdKFDJYIwlxM3q2fMq9rI6iHT7UoRz6WLSM1/6sdIZE1MvuxwdczqNj2k7hpeDtCz60L0kSyFtPlBCxUmQWNUzIfYshmNw24djB6LYlwBg9ob9RyvyxgNd+m7kKoRjNSgDFJ+vpaY0cUoLTOp84CUdLF6W64PkYebRi9nVpgM86fGdgx90xEeK0LNw+aw25XjER7PyY/6rLGPg+oluxJeKHZnIlaJx/UqHJTnCTtWUFbtnkyUUWdg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME2P282MB0305.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sat, 5 Aug
 2023 10:26:06 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::826:d9a5:23be:3b14%3]) with mapi id 15.20.6652.022; Sat, 5 Aug 2023
 10:26:06 +0000
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
Subject: Re: [net-next 2/6] net: wwan: t7xx: Driver registers with Devlink framework
Date: Sat,  5 Aug 2023 18:25:40 +0800
Message-ID:
 <MEYP282MB2697D3424499D55697CD0DE9BB0EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20230803021812.6126-1-songjinjian@hotmail.com> <MEYP282MB269720DC5940AEA0904569B3BB08A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8bit
X-TMN: [Eu8jLwyTJ8gc14u3gPjgh1W0sLmUr9NE]
X-ClientProxiedBy: TYAPR01CA0207.jpnprd01.prod.outlook.com
 (2603:1096:404:29::27) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <ZMt0D+T/FqQhhO4v@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME2P282MB0305:EE_
X-MS-Office365-Filtering-Correlation-Id: 5deb06dd-d1ee-48dd-7906-08db959e609b
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMnac85kNyRxquJglHdERmYs70Mn38xhJ8wjFHdtACleaOX1w36tcOK2NKoydeo0WLFgoRfVTYEl9LT41o2KCxZzT9vZNUikMoZ8PITGewkykL1zYF/V3+R6g0SDhLjfUb08ybibLIZi3nSlXkXltGeFQr50Xae3SFYWQP0LoHepIObUzOoUoE4/2+6teLJ59puFhJO3pHbfzaENl+sGGij1reOeFcIr/Yk8kP0Z6hiTV1lj/A2Cl1g1KMYPLlXBLcG5vAmzQrdb4t8zESXhI2aDovKvE/+az1dZDZrndG+B7KQpVJgsAexGNDH6fTVXDE1ldIggnh9N+DGghtaGRfRj2kdeDBmOOibJFxtwzmer74r9WtOAN8EyyouSDU5w0y9JRlP37OdtVohYcugOYirUp6DPgoY9JDkp1eloh6BlGxHRly+8F3048OZgao7jT1zjzZlMxLh0V78UeX5SDqYwrmWJmkdcuHwAp+Vtw9SKuJULDy4wa5BIa+6ulnfW5vgZ562TPvvVwjsDqad9L4ICy7y5eg3lSgrhxsXXQjtIATAMtiINNBDCbXe1f9+xOIkz4h/ZmTDpCsYZEKvGzLN/l0ZSBgHL1qbG7nnJhFSINqfzzpysnGQae5v9yT6wsI2hekeOYNs11P3sRz7KzZULC7OguZltUoSm5q6sFbfYrF8TV1c0seeNcUk40twVaQZsvHgLDG6wtbTch32XXNA/Jr75xbJ27LbKkC8/CnTFM8GumgoT7zcikXDCmo1CP4=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5yiZteyU2EZppRdyaLeRMWfkzIleqD5JxRTvfH3b8sDzHTPdCjBtn8HCGfXS+ULT/r78QNey28Z/hpPhFzOrwqrqGnbfXGfWxBYj4bGgvZkJxagvKO376Lc3pmHyJ6yvVbO/UYaR/bc1Q3N/1QEILOVaYGqmTLq6VJGdBkvbUbilLoTdOS9O9Z5+0uH1rldAE0hlYauAs0PifMmn+fEbflW8DWu9EseOThWpJoZT9dx9ULynnHCpuNOuc3kerV8V1M8uinwN8uQJzUZEl9P5JAH+zMpwVJX4mexUxTyKc2VpudyhAVX40euf4CONr1G6GcMQWGSu1WEogncxzvyYP3OtqlUaRZxO5bmUUxnrT2Nrgm8iH3pZRZ8l8vxLGyPfAlBDtC2PMo4NSCuNeeoYOgxbYkDVPOXmPL0No//f2VetT/5WFfkfTlVOY2iwj6pB7XHRJuCsNMpwbDAhNWGP9uopzEPjD2gA2yWCswiXkvOflGmGLtY+/ym4quMdrv6hu2yagG+hE2YfaFvvUQJUWHvPa0ZYfvHVI014ZH1GkSngjom2jrdrC86+Tmjjh1a8O4M3WBOBJCy0+mRi5H43s43CMl+oiJPkQQodM+DmPhrnijpbvjm0g88kTRb+Bltt
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6UPYn+LQDsonx/2ghZcSNbStoF75JPPFX4uFfkymG06bRJFny0JCmeGUzgOa?=
 =?us-ascii?Q?UJvrV/M+uBo7sfPWIeeLPDEcVO2IBDhs6TYUBWswq6zzHOHxwGBp8VV/XvGZ?=
 =?us-ascii?Q?wK3SELGT5YnRkQuvu6cM8O5sypboRihcTc4UO0VV8dBKHiTKSGbTN1ULG+jL?=
 =?us-ascii?Q?PeUIioWs24oKwGwvwhFpwUe2VERo6IpMBCJW3hmanz1P85tPwfpq+sc8L5xa?=
 =?us-ascii?Q?iLbY6VfVAToqR6DUe327aha2P4BiGGYDs9Gn+mzhzh8Iu80sTAGKuUj9xu5u?=
 =?us-ascii?Q?ULmaf7SjmnWpQeMuerFQtuyRUF6qyqX/nv0vipcH10bm7tx3d0FFNQa0qQtx?=
 =?us-ascii?Q?9DlEWNC/GysdsFcfbmBWbmsVzgIhzfoltT4d7MW/8ruYIhRXKdCytFREqy+d?=
 =?us-ascii?Q?g4JFuvN6OvVUGhb1/+NuY8Rd7bOkPlSCJV2YNNhh0NNwNI+zDEk+BNuVnuDH?=
 =?us-ascii?Q?/sHP2B2bif9MHWBdQCvUHkQOW16SgpeJuCmxUkeNMLvQOlXoNkR5WdOUY5sl?=
 =?us-ascii?Q?wk7zABO5GIiOYWTBpbeoHMXXVGT1zFw3mDzT1JEKckmqDuczGA7OPd1Ob7SD?=
 =?us-ascii?Q?RGcPvMmvTXV6eemCvi30HNNKbdII0O44xLCl5UbMs2+2l+rKmsMLdJK3rL4W?=
 =?us-ascii?Q?poDDp9bXQFWRQ1Dm6AoNCsE3U6ukaH+XGtD8GiKOgndyNFKtnZMgBDYEv2oD?=
 =?us-ascii?Q?/aEsOJvHJd7/P5zfIn2DBgNNP+6PVe61iCBJQ5/0gK/ybkIm3waqalxMSa8A?=
 =?us-ascii?Q?F3nXq5tN3VobD80dcO3+PYXH49gmboG+Jk6c6xZLB9aePAe2dwXwJY1FBqpU?=
 =?us-ascii?Q?mdD+QGxGmM/lE7fsne+5F/zXUYA/AYe55Ah7zfiTC/tCTE9ZVY78F0u1oUHV?=
 =?us-ascii?Q?FTiP1FSseblTCjrOy1z6Ff8QwYHfK1GNJ2zl8eBmQR0eI8gml79TSo6ZCubG?=
 =?us-ascii?Q?mO2lJ4++29hEJYgUyJ2Yk19nCbwZXBr1pOJymBL3dybt1+z+sj9TR5gsq0jY?=
 =?us-ascii?Q?kblhIOags43b8mQh/iTc/u7zvXLcpzlnPBXKvnYNVLhhpfxak4u3PNJcTSeC?=
 =?us-ascii?Q?s0tjuWGBgpmDYoOW/Ii54OOIt2dwCYNZ23r1u7ECjyZ2KUc+q8LNxwbra3Am?=
 =?us-ascii?Q?9qeoxNnpw2SmJFlhCShI3cKI8SIbxsUVpWNaHXFavjygBci3CG4M3ZpAg2tI?=
 =?us-ascii?Q?40AFSCDpokWgx3bxBlEX3yVIr9A/xW5Q1yH49owN03J5gCMwRPcdnzQionY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deb06dd-d1ee-48dd-7906-08db959e609b
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 10:26:06.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2P282MB0305

>>+static const struct devlink_param t7xx_devlink_params[] = {
>>+	DEVLINK_PARAM_DRIVER(T7XX_DEVLINK_PARAM_ID_FASTBOOT,
>>+			     "fastboot", DEVLINK_PARAM_TYPE_BOOL,
>>+			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>>+			     NULL, NULL, NULL),
>>+};
>
>Please have the param introduction in a separate file.
>
>Just to mention it right here, this param smells very oddly to me.
>

Thanks for your review, I will add introduction.

>>+static int t7xx_devlink_reload_down(struct devlink *devlink, bool netns_change,
>>+				    enum devlink_reload_action action,
>>+				    enum devlink_reload_limit limit,
>>+				    struct netlink_ext_ack *extack)
>>+{
>>+	return 0;
>>+}
>>+
>>+static int t7xx_devlink_reload_up(struct devlink *devlink,
>>+				  enum devlink_reload_action action,
>>+				  enum devlink_reload_limit limit,
>>+				  u32 *actions_performed,
>>+				  struct netlink_ext_ack *extack)
>>+{
>>+	return 0;
>>+}
>>+
>>+static int t7xx_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>>+				 struct netlink_ext_ack *extack)
>>+{
>>+	return 0;
>>+}
>
>Don't put the stub functions here. Introduce them when you need them.

Thanks for your review, I have split devlink falsh to devlink register and devlink flash
as suggestion on v5 before, I want to move this functions to 
'device firmware flashing using devlink' patch, is that ok?

>>+static int t7xx_devlink_init(struct t7xx_port *port)
>>+{
>>+	struct t7xx_devlink *dl = port->t7xx_dev->dl;
>>+
>>+	port->rx_length_th = T7XX_MAX_QUEUE_LENGTH;
>>+
>>+	dl->mode = T7XX_NORMAL_MODE;
>>+	dl->status = T7XX_DEVLINK_IDLE;
>
>? What is this supposed to mean? Looks quite wrong.

Thanks for your review, modem register devlink framework to do firmware flashing and core
dump collection, we define mode to identify modem mode T7XX_NORMAL_MODE, T7XX_FB_DL_MODE
(modem fastboot download mode), T7XX_FB_DUMP_MODE(modem fastboot coredump modem)

status used to define the current devlink progress status T7XX_NORMAL_MODE<->T7XX_DEVLINK_IDLE,
T7XX_FB_DL_MODE<->T7XX_FLASH_STATUS, devlink ops info_get<->T7XX_GET_INFO, T7XX_FB_DUMP_MODE<->
(T7XX_LKDUMP_STATUS,T7XX_MRDUMP_STATUS)

>>+	dl->port = port;
>>+
>>+	return 0;
>>+}
>>+
>>+static int t7xx_devlink_enable_chl(struct t7xx_port *port)
>>+{
>>+	t7xx_port_enable_chl(port);
>>+
>>+	return 0;
>>+}
>>+
>>+struct port_ops devlink_port_ops = {
>
>Could you reneame this to me less confusing? Looks like this should be
>related to devlink_port, but actually it is not.
>
>Could you please describe what exatly is the "port" entity for your
>driver? What it represents?

Thanks for your review, this port ops used to define modem port witch used to 
flash firmware or collect core dump,devlink command will use this port config to send firmware data
to modem or recieve coredump data from modem.

The "port" mapping to the modem data channel, which used for different functions to comunicate with
modem, all the port configs defined in t7xx_port_proxy.c t7xx_port_config, devlink flash/regions will send
firmware to modem and get core dump info use this "port" config, so we need to define here.

Maybe I can define this port name to flash_dump_port?

>>+	.init = &t7xx_devlink_init,
>>+	.recv_skb = &t7xx_port_enqueue_skb,
>>+	.uninit = &t7xx_devlink_uninit,
>>+	.enable_chl = &t7xx_devlink_enable_chl,
>>+	.disable_chl = &t7xx_port_disable_chl,
>>+};


