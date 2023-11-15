Return-Path: <netdev+bounces-47959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371767EC169
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADD5B20ADF
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34925171C4;
	Wed, 15 Nov 2023 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cyw0t6W0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097F17723;
	Wed, 15 Nov 2023 11:46:00 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686CCC;
	Wed, 15 Nov 2023 03:45:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mM5ZNWQ7yPwnUyuF2cVQrqTxxdUPu5qszwF0yKxuzPB80tdGBvDh5pH6ZGFtMvGQ3z4CzxSJhao496L++2GBXw3XkOtL3C5phn7ZVA9oll1EP0BX5SSG7nezl6ssLxJ6/PuEbQxrdIfwwSBY84j6rd5ipwyPoSB+6mUmlgDtgGkVRlaVjPnanMq5e94Oc7xDQ/LaSPcQjgLjFR9Sug3g1C7GoZhlN2IcZkU68VSpJE4eHMUGM7XK8KZL+hrahvVeVsxkzUQQSCqx6YGogJvnzO20k4nY7T6Nqhz01vs2dSMb8cF5+Gai32zp2CwRWs+GlKGCxFaid/aMkC5BHOGnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkZ+ZSyZwa9J1ANePX4FIWBQv6Yx3p4N7NTiBQzxpUk=;
 b=LInESdLEa+9ylymOO7gWaYVvt/hQGuZapupKkGqF3HM1LGu+j8N1gw+/o04BkgBrR9WmbpVXB8HQd5HCJD7DusTYDxsnSo+CHjx9qY757uUgSI6/cyUoCpKsx8eb7Eg6yhzPHHz3aCKt7mw+H2xilraDAQZzuhx2q77c7xOoRVlyVNwcSU+Mufea0qK9ClrdRs+iTVNugfZIelP3c2qXqYnCeHcGiXSLXd3b66bVWzC/e9ZCChevJkh3eJTlQ4cl608YzPAffmB42fPM6UtYhjS/RAmcSjV5k5ij1EZTvKZRD8dK3HE7jsdb2s71xz0o1ww5egnuHjvJOp2y5CidtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkZ+ZSyZwa9J1ANePX4FIWBQv6Yx3p4N7NTiBQzxpUk=;
 b=cyw0t6W0ohmH9OoYVyHDJZCfhpPFgVk4Gv8ZntGavgktFbADFkyRV5dCMW9XBQ762zM13BTbxPymaQyyBLa+GNX+QS//SwIOh6U0KfpVnHTXMRe8IQvIW3dlytDlTzPmP2wWdXoIVRnY0hh2i4zt9dCO+Z8SsNoI48ZOO8ctwX9KtRZDx19y1MLQPhMeSGcLYk8mMzgzuWa95ZMLYvTVlEQ/KezQHq9bUOeKdsB2CzUsFEL4WuBk8EW4Q+iZvEju6+fT52QAu/3UIraZ+o1d7ZH7gbtS/lSuVxKlYQq+3mnjgsng6FRYDuYb6MigIM4D+3oaON7MoCekRDFS6qb5Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by AS8PR04MB7528.eurprd04.prod.outlook.com (2603:10a6:20b:297::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 11:45:56 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%6]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 11:45:56 +0000
Message-ID: <7f704401-8fe8-487f-8d45-397e3a88417f@suse.com>
Date: Wed, 15 Nov 2023 12:45:53 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Szymon Heidrich <szymon.heidrich@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
From: Oliver Neukum <oneukum@suse.com>
Subject: possible proble with skb_pull() in smsc75xx_rx_fixup()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|AS8PR04MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: aeca0be1-77fc-4dc9-d058-08dbe5d06d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xIUXrcq0xRko82KIRgPGCpuBAq2Kz890uHjzSmqTcIeOiGXY+YEr1l1lvVlxyF9FDyCuSd88NvRz7IyuVif1UoKJkVRQzNZFomtEljhAxN52TCwoH+X870nlXqytENbe4zCcCnUnjWmW4TxrOC0GahztFE51jTAu4PJEWCJxb0YopqHg4jlVGFzqbAaY3jkiAdgWnaGNKs63Kuh3EcubMiLcrR6zLC7H/JOzDfYFnuEjUqsIWNdKC+fD+2FiAfQMjGs5ot385f8FSKeI2KcU6jJdxUPC4UswUjpBLI1dDVL15bWT+6AvzOlAsNGV71DMB/ba6WKAmF2xs/yH50ELPqgGb1UooQf25iExO+d6DPKtybEK+swgMQvRWuXuc3GZ/8QgSu2eu2nmAIr2lfRTMcRTCQnX6YUwyo9kzZBMQOfch5QnjLqT9M1skj/9Oa4ft9J3EBRqeGyT0ZolsYSO9Pd/CuLgSRDPaTp/hH2IdLuyGSUABUbhBflYZ/KQJ9wpJzWuGc/A0XcdKXuYuquER/ClFadrFDFfyXQMOdgnVyow820Xi8m4Jh7NyuQHdWCV6qzbHKsiZa9Oc2P4IsUB83qcrT0mMgd+Dd4sdrd8HV13BVBzGwd9hAL69Nt88ZzLaOfrEEZx8TiqNTa/J8gyMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(36756003)(8676002)(4326008)(66476007)(66556008)(66946007)(54906003)(316002)(6916009)(8936002)(2906002)(5660300002)(6666004)(478600001)(38100700002)(86362001)(83380400001)(31696002)(6512007)(6506007)(2616005)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXhSWDBxNFVrdlpVZ0xpS0pjNTRyZ1o1NnVrL1YydkhDWWd3ZjlVOHBBYmNn?=
 =?utf-8?B?alJWVVhWc1VnRndlT2U5bHFYMGNCRnhkcmhpbTdXdEEvQjZYQk0xb3dQRDM4?=
 =?utf-8?B?RlczbW1STEtObkZhbjhZTmhmMUZ5Mmhlek1hZXdnT3pLN2NrRzI5Y2ZwWk5H?=
 =?utf-8?B?RWtrSk1mbGQ0QU5GQVdUcFlzOStYUG1xMnF5MGF0d2ZhRnVtV2pkeU5nbG1t?=
 =?utf-8?B?VWNLRlF5VG1YZmRDWUtHWDUyTm9PQUhtb2xER2UyK3dNK0M5Q2Z3NGFwUmsr?=
 =?utf-8?B?WW1TOTV5bGs1NlZoN2MwcGk5ZU4xaWFCbCtaSnFCRkNoNERlOElWS0VIU3Fa?=
 =?utf-8?B?dmxVU0NzR0FpWGFTUjBRWnhyUEJOUnZJVGVBcmczQVd3Mm9IVm05RmZ0ODhB?=
 =?utf-8?B?ekVNQkpCVkUrTGM5N0czYmtoQjNTM2xnZElPMHN6Rm9ESXRtS3hucW1pRzl3?=
 =?utf-8?B?Umc4aTkwaDlYNjB1Q1B6ejg3MFBQSjFJcWJGTjVaNFRjR0ZDYS95dDVJVjQz?=
 =?utf-8?B?RlRXUk5sZno4MFBCS09aSDdKVzhGU0QzVjRVQjlYczJ5TUlqQjVqaFlVZVM1?=
 =?utf-8?B?WFhqOHlIYWVqUU5PV2c5clhIK3lHVG9HV2h4bWo3ai9DNGdCU0xPNHp0WG9O?=
 =?utf-8?B?RkdadzlxSVdaR3dBRWtYOE5hUG9ROS9JVHNleVRwQVpGMWdoQjhHL3ljWXVX?=
 =?utf-8?B?ekF0bTU5UGtvbFM0N25xL2FZR3hJSFFZUlNENll5S21pOWhob0UyeXMzQzQw?=
 =?utf-8?B?L3p0VE8rNjY3T09jVFJieHovdVJJRHVJcFI1Z2dHcXFsWmZFRGg4WUZLTkl6?=
 =?utf-8?B?SC9hZU1rY20vYm02REh1NlBWeUJaRmdFcGdOWm1aeE1NdWlhaW9DTStRVlFm?=
 =?utf-8?B?am43MGxXcjNKUXVLa213VU1aWG14VGpIVnB3aEtUYXJvSWVJQ2wyUG4zZTd4?=
 =?utf-8?B?Wjl2ZUhnb3hJRXFObWorTVJKdGN2VVFGTk5rbmY5S3IyTmhjcEFlbkZCYUYx?=
 =?utf-8?B?Z2w2V2ZxTXNRRnZyektzZzM1dUpKU3RQclhIbTFQRXBJMWZJZ1hTa2dFRUFI?=
 =?utf-8?B?S094Zll2V1RWcW44b3JNNWJFbyswWDFTMXpnRzlNWk5DZm9SV0JaaWVRU01i?=
 =?utf-8?B?TGNaUWozWjBrN0N0V25kVHBPaE15WlRzdkJNNTIxYjJ5YkwrWU12K0lNV3pU?=
 =?utf-8?B?cGluOVU3ZDFyOXJYMjJScWo2ekZwU1htKzZRaFBTV1JiS09rcFBEMWRTcEtr?=
 =?utf-8?B?d0xjV0lvaUd2MG14SkRuTFdSUnlqSnFoTHJUZk9BeUlnUXJ1M05hRXIyZmlK?=
 =?utf-8?B?OUIyZ3NYZ29yQllEMkdjWlM2amZTbGFYZitzY0lYZGdtaGw5aElMa1VqTGxU?=
 =?utf-8?B?WkRENC9UOUJIZm9tMTk0RUs4U0RKY3JRTk5NS3ZJUFhLbkM2N21SZENzSjB4?=
 =?utf-8?B?ektIcDNmd3FkbWlaVXJ2Tm12MGJOZFU2WVNyL0kvR2JudlJQYjdwVm1XUzVN?=
 =?utf-8?B?ZjcyNk1VMUYwQWc5VlZlWUpyeFNpWmovcnlGRTFoYUY2L0Z4YWFNVXlGRWQz?=
 =?utf-8?B?b2w5TUlML3A4clVhbjdvck1WTzdEeWZCVTl0WXZpbjZlMmpPdS9YVTVSMXcz?=
 =?utf-8?B?L3VnU2FvRnd6MTdPMkFCV2tyMGVhVjZYeW55UjR5bXk3cU5hMFd2YnFMQ2VH?=
 =?utf-8?B?dzNLc0JFTEJoNlFDb1BvUFJtNFRwRVN5TjJUdzE5bktyaHYzaDEwOHpmaDR2?=
 =?utf-8?B?eUlKNWthdisrQmNLTFZNTXcxWXc3NnVvUW9JYmFOTkdqL1lkNkFVNVUwbXlj?=
 =?utf-8?B?eTJtb1JNUFJkOHRwVTE5RUdWUUdZakZZKzB3YUFkYzlsbHJhcTNQbWlOaVZB?=
 =?utf-8?B?azdHZUttWkF1NHVaVWY4alhLVEpmOHRmKzZZY3ZKQ2poUHJHbXNianBsMlp1?=
 =?utf-8?B?M1NqMlBoRjRWU1dNNFQyTWxQQWdMVHNabDNDakxGelZzWjUzanRwcWNySkVF?=
 =?utf-8?B?TnEyZGtEOFVzdXRwazE5SERRb1VlSVB3eXljaEVaK3FiVHFsTWhyRXdEQmFl?=
 =?utf-8?B?MldOc1ZsUUZMcUNlZnp4SE85d1YvNWlvVkxIV0NCdFZiTm1HejZ0YngwNEN1?=
 =?utf-8?B?THpYRHBNUWliUFMvYVpzTi9iWGkrQW9QSVdGZUJYQXB0UFB2REZkVDFxbkdw?=
 =?utf-8?Q?GvYrYFzqoz2v7yihJH76xkeuhyF5DITa4Cha5LtDhb2i?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeca0be1-77fc-4dc9-d058-08dbe5d06d8f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 11:45:56.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNPq2+yNBDD3QJRJe5AS6lxNVo8IIlqoRQ47Am8xAF9qcA2qmqVjjowJRAu2V68CS/V5pHj4H92IVFWulmq4iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7528

Hi,

looking at your security fixes, it seems to me that there
is a further issue they do not cover.

If we look at this:

         while (skb->len > 0) {

len is positive ...

                 u32 rx_cmd_a, rx_cmd_b, align_count, size;
                 struct sk_buff *ax_skb;
                 unsigned char *packet;

                 rx_cmd_a = get_unaligned_le32(skb->data);
                 skb_pull(skb, 4);

... but it may be smaller than 4
If that happens skb_pull() is a nop.

                 rx_cmd_b = get_unaligned_le32(skb->data);
                 skb_pull(skb, 4 + RXW_PADDING);

Then this is a nop, too.
That means that rx_cmd_a and rx_cmd_b are identical and garbage.

                 packet = skb->data;

                 /* get the packet length */
                 size = (rx_cmd_a & RX_CMD_A_LEN) - RXW_PADDING;

In that case size is unpredictable.

                 align_count = (4 - ((size + RXW_PADDING) % 4)) % 4;

                 if (unlikely(size > skb->len)) {

That means that this check may or may not work.

                         netif_dbg(dev, rx_err, dev->net,
                                   "size err rx_cmd_a=0x%08x\n",
                                   rx_cmd_a);
                         return 0;
                 }

There is also an error case where 4 <= skb->len < 4 + RXW_PADDING

I think we really need to check for the amount of buffer that is pulled.
Something like this:

  static int smsc75xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
  {
+       u32 rx_cmd_a, rx_cmd_b, align_count, size;
+
         /* This check is no longer done by usbnet */
         if (skb->len < dev->net->hard_header_len)
                 return 0;
  
-       while (skb->len > 0) {
-               u32 rx_cmd_a, rx_cmd_b, align_count, size;
+       while (skb->len > (sizeof(rx_cmd_a) + sizeof(rx_cmd_b) + RXW_PADDING)) {

	Regards
		Oliver


