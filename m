Return-Path: <netdev+bounces-64229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66099831D83
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 17:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB6A1C22544
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8E22942A;
	Thu, 18 Jan 2024 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C80AZFTB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31329436
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594959; cv=fail; b=J5XHhRcLzN4MrI19NdFNeLYt3KJu/6m/b/JYNReriLy5jw05EU8d3Qdrd5X1FeGonqyK6EdVV41xmrsXwG3C23JZgs66UySpLxoowDPjaixq8xGVW+jGEmtdGtgrS0aRiH26M36NE7zW6xVYs8srkOmm3QwK8w1vNWfiwv4MFC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594959; c=relaxed/simple;
	bh=bIJPiksjD0JSR/xSsRDb1PO0tdpXOaERFJLv8CWP7cI=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=XT2kxgeuT8lhn/xRK7RjgwtSdRJFLXT3sk2ACA4OrTaSepPJpYz6xAk20K+uSwdb1M3ew/GLsLeYOY0BZ2HeVZK0kUyNhBCLUAvJiXHpJSeekRv0kVQbz9PT6w7hh+KI+ckpa+sALVFIjQ+zPx9Gf7D9Ui100zBGSz2rDjXhHW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C80AZFTB; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqz8U5YQslHj2K6pb5gpenHJMm/titMsQ1Xgx2VEIYccArfluTOXKMEyxKhN2Q5V1cXAjlf0ZNmmYVlIMITifu9+mHYjo35Li7Xup8rZeCVGlXa/DhArxysXCpuzy+Xxc7fujrz1EQMiEo/RIYIYQG8sqqMbRItfK4O4O9lobPjfrlD3tthub6aWJHuyjBUTMxS72YcfTnNkLy8onWULVSDgu6QnL2a5BWodGzbbSae1wPtFuyhDpg+e683Ggh+jOe5IO0irLOVMsMsUabjj94yNKaXKCN3LGRnO/lMEaHl29lBnDbHh6VR6b/1PIAOCRZIEH93NgsttdpNVrS6a3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GaV6wnegBWydgvUBgGM6weYZOtJxqUT2XNSX5mFvLs=;
 b=UqzuqvBkVg5jmBk+8jnqOX1WcXffr7eiRHL75OIkYQcRQoGnB6bzE10Xpio52RLm3DoHa5ku+J9l/YOhkeVuJLwGWUwYZbAwoDrBjj5MXVc4ccx0S+RBaFMmMjKZKApXnTaQT5WATw1Gb6LSvp+1tq/75S314p9QxiVWqZmPtOiFmu0jFzxEhStexidV8AfWaZnvxBqC8yclnjG8V9U1Kn7jXvAdxCwp02yyAsVacQb1GN7fzqLDYT46f6PSK1W2dRfDYt5ogGGXSsGBCVEhFPL6yND1uH+HLujSsKGHPMDR+P4mYfrjuM0b7V5lsEdzhOLbQMvrsA1SOUNAPL/dmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GaV6wnegBWydgvUBgGM6weYZOtJxqUT2XNSX5mFvLs=;
 b=C80AZFTBekK0ieiuvu1h+JgqoVUi89OnOEyB09LU2gratU+i4E4WEUmipvVQVQKTJe+QCGSL7RrVnJwI6H7onoapnAT2e1zPwwi30h5MFhrErP18+LO6TIOTgiEPjJwfuEuRsiK2H1EXpBC5hpskOV7LzuGACmPfMmy4g1J2XXdA0Oz3CIWcTGHsY55V/9HJtmUn8vYCV3Q3sGBuQIY2W7X4Bk28Hr+Cad0Mt8XERpmnm+UDwcKtVkvC/jkoAGbV7rg+M8rBaNT+++h8fL6Tg6hb29HpIDIsNLV8rCLTZHr8OLvVFHNpBoLz9E98rbMZnXyHCGPMZvEnMOG1A9noUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 16:22:34 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::e6d3:757d:1bd:8bcd]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::e6d3:757d:1bd:8bcd%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 16:22:34 +0000
Date: Thu, 18 Jan 2024 17:22:30 +0100
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Ian Kumlien <ian.kumlien@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, 
	saeedm@nvidia.com, gal@nvidia.com
Subject: Re: Re: [mlx5e] FYI dmesg is filled with
 mlx5e_page_release_fragmented.isra warnings in 6.6.12
Message-ID: <uxlqaq25tft55nwyfueyj7g5co2lva2j5qnbsijwazxr2ld4l4@uqhiteuyduhd>
References: <CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com>
 <CAA85sZtZ9cL4g-SFSS-pTL11JocoOc4BAU7b4uj26MNckp41wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA85sZtZ9cL4g-SFSS-pTL11JocoOc4BAU7b4uj26MNckp41wQ@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::6) To DM6PR12MB5565.namprd12.prod.outlook.com
 (2603:10b6:5:1b6::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5565:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: b7cd677a-917f-4724-3a7b-08dc1841ad5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	82TMAP4MiWK+kS58/nbwH3po/z4abqYntDK6F8zOMOoG8txgUoPRSul+d4QhafhsZwD445UV1o0exqE4v+C80Rn7AEbQ5k4n8rtm7EM+jBnUYmeG1Z83HgJdOltLghBohRO2biQvWxG9QEqcUppH37Eep4M3FRJphcBmWbC8UQGQx5KqzsiTZ3N0Kms/j7lEJCXJRNgBoQx2imM9RTr3F/HJsRCor8if6KQLCxgKvUpx63ndV1L3+3M1DD1LCZMqfF8hZFv3QmfEbsa9tgak8XxxUxyX1Qnd/mrwPbIviBawWdUElzX3KBd7KjyoHlb1rf/T1SPegVfyVDf4OecDbeJF3leHrGBKjX5ScL43PK49tVCTr4Dak+6Lt+9KbOXizYjSiXzprpO8JjtdatStjm4PCtmAuh3L5ScqFAl4qwDxu6JTuDJJvPoHCqWX27E+UxKYIo8e1wOT9a+YrXBStLq7erev+nm/ZL4qX+AI2Z8uWz0zrh5slb94cwfl6+/FewJVpWm70xvZWUG7mpKrxdpnf/08jfD98BTGRPmvOV5FNSncN1RJRZoQbwtnd+OZgBdaY7gqkMoOpYImh+XLz7J06FQHE0Jz2WJkmb+LaYwpqSMx5T8HxXP+gISSfCcblza49D3ZH3VZto786mljCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(366004)(376002)(136003)(346002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(9686003)(107886003)(6512007)(6506007)(53546011)(6666004)(86362001)(38100700002)(2906002)(41300700001)(8936002)(8676002)(4326008)(6486002)(33716001)(5660300002)(83380400001)(316002)(45080400002)(66556008)(66946007)(66476007)(6916009)(478600001)(27256008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjZOOGZrNDQ3a29RWXhPUERjMGxZeXZlM00yM3p3N0hyeEpaV1k4ZE5mZi9R?=
 =?utf-8?B?L3AwK3ZOendtYkV6Z21aOUNORHd4WlJ4bWVxalVVOGtsTlcxc2FWaGVScFp4?=
 =?utf-8?B?VHdqMUQ1SmlVT2hPVnJNUTRKazBIUGVwMWplcmNneEFCNi85czZmQVNWTWJ2?=
 =?utf-8?B?T3djd3lpSlQyUUlaeVd6STVlRGdOWHpUUWQ2M0lFWG9Zb0p1c3dTTnhyWGda?=
 =?utf-8?B?a1pKWERSQVVSZXkrNmczU1JPZGtDRTFTa2NTQlAzUHpMQU9XYi9BeHJOSVNS?=
 =?utf-8?B?NU9SdnlOUlh3cUxkcmxLTU03R01DYlV6WUw2TEVjN1hxNlo0RFNIZFZ5Smth?=
 =?utf-8?B?RHE5SG5BelRwWlRueUJxTW4zYVlSaUJEeXhaNlZHQTlTTCtLSmhlRkZIQTMx?=
 =?utf-8?B?QXVlYWlXcG8yNk8zdGFrWVI5eDF6cmxnQzY1V0JMa3AxTGdvcEtyWllGZFNq?=
 =?utf-8?B?U2V3Y0tQQSs4OGNLdmFjTmM4T2JidVZJMzErYlNCV1JWL1lHWFV3OThaeVVn?=
 =?utf-8?B?YTBFalpSbjlwNWpVTlEzSWFZeGdtUnhiNmJHeGpVNE54d0NjRmt3c0VDZ0hx?=
 =?utf-8?B?NWlLNVljTWEzck5qLzQ3bmU2ZzMzLzNsTmhPdmZNbVE1S1QxdFE0QnlSeDV2?=
 =?utf-8?B?T1R2R3gvY0VpNURJRTNXRVZ2dzgyZm1GbTlsazZDK1BGb25mcGZJQnozSE94?=
 =?utf-8?B?QU5heVFBWWVpQlcrV0FTdmg4b3JTNmlJeHdhRVMza2xML3hSbGVVWnE3dTJn?=
 =?utf-8?B?ZFJCaE1zYTRwUWNsQ0RaVE44WkRFOVVWQUhEY2F1VlVONDk0K2NlSmZydkhw?=
 =?utf-8?B?a25oRitGbStSZXh0T3VNa204YXdyRWQrZmV1M2dZZWlxQTN5NGgybUJTNDhm?=
 =?utf-8?B?MFkwR1pLUndsWVZMM2RnT1VPRy8rR3RnSUJZdG5MRkpLbjZjSC9oZ1dLNGhG?=
 =?utf-8?B?NWc3VEt4RHh5U0gxckhkYmdmYWV4MlpubG1nUktYTmZFR3F5Q0lQcjRvK2hH?=
 =?utf-8?B?TE9aUGxQclRVaGRwdnkzbWR4MGtzZ2dmVkNXS1lOTlgzSEVGWnA5MWhQQm5P?=
 =?utf-8?B?WFdEQU16OW4wcVczenhpY0IrRVZPRHlnclhZUmQrZUltby80TEtCR00rbi91?=
 =?utf-8?B?TC9Oeko4ZXUvc3lLb0NzaHlPdG1OOEZHWkQrWG5qUEE5N1ZCeGFmcGNqWWJr?=
 =?utf-8?B?YWxRQjBIVXZJZHBMZkRjRzRpNEphSk0zL3RXWEV0RmZKd0YxYkxLV0QvOG5P?=
 =?utf-8?B?QWZPWDUveUVzbmtFeEhMZHFUWHlmN1ltMnVsQ29ObnA5TjRydFpmTm03cHlx?=
 =?utf-8?B?aFdJbXNXUFZXSklpSVVUTi9HMVRPZmIyRDMrRnhKZWZKOTlLWlcrYWRZRXA3?=
 =?utf-8?B?UXhKUzZUeGkrVW00ZHorcWlMRFgrMStUZlZBZVVSN3ZQbXJnVHhyWG1GV3gy?=
 =?utf-8?B?Nm53S0xPQzZzZ05BZGlmUDMxclNTbXMwZDAzVExveGxCNW1KdFVnZUJHbnF0?=
 =?utf-8?B?RnlDTndOSEhwR0pjb0tYOGZCb25DUWNmbUZhYklBYUJ0NUlOWDFPUXhxQkwv?=
 =?utf-8?B?UWNIY0VZMXZ1aEVIV2xNZ3VSVzA1Vk9ZdVhFRnhraEhpWjVXN1hWUERJaVlO?=
 =?utf-8?B?T2hwMHlYMlNxZE01RzE3WkRnalVKM21BREhrSVZWOGpnbzQ1cHh4L3FwbTBu?=
 =?utf-8?B?VGdiQjNNTW1ldVd5T2hNdFlyRUdXMTdBRXJLQ3ZDYUhFdENmVnlERzVNeUd0?=
 =?utf-8?B?SnZob1RWTlgyOUVWYmJHbkg5Wnpuby9qYklmcktERXU3cFJNZU11SXQ1TVVq?=
 =?utf-8?B?SGs0MTBpYlNsSm16OFJxRWtDL0dCK0JBQzZvbllsMVhRQ0NvMmNTTkhocDd5?=
 =?utf-8?B?aVBBcE1RUWQ3Sm9Uc0RwejdIVXRsOS8xVG1aUmdRMGJ1b2pKMFBsWDdNeCtU?=
 =?utf-8?B?Zm1TQjZGQXJTazBXWEkxQ3lnVk5CWG0yYkkvVktjWGVBZ2JPcGVkUlF1T005?=
 =?utf-8?B?azFCLzhGZk41ZmdvYWpTZTFGK0d1dmZUL1FCb0xWNDB2TXNtWks0T1lGeERQ?=
 =?utf-8?B?dERMbXpUekVoYzgzQ3FidGpSUkpma2pPdWt4OXNtRDhMOW1jMXg4cU9kTGdT?=
 =?utf-8?B?UExoK1FXdGhvT25LMFJjcVJ1UWFKQUI3Sks4SzRTMUErRmZPYVZXZG81Sjdv?=
 =?utf-8?Q?Gn8Wf3hNSfT5dXylFw3OZrNte4+zpu5oaR4K+pMClJlJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cd677a-917f-4724-3a7b-08dc1841ad5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 16:22:34.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikU+D2RU4xDy8YKuxL9Tz8q4Q7lyoosvgyZFoxd+R4yN9Dl7ZUDW7Z36aag4nAqax+ak/lFmTPZR3TG4gfPk3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559

On 01/18, Ian Kumlien wrote:
> ok, so after about 200 of these, we had a full kernel oops. more
> graceful than earlier kernels but...
> 
> On Thu, Jan 18, 2024 at 4:08 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > [ 1068.937101] ------------[ cut here ]------------
> > [ 1068.937977] WARNING: CPU: 0 PID: 0 at
> > include/net/page_pool/helpers.h:130
> > mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
> > [ 1068.939407] Modules linked in: echainiv(E) esp4(E)
> > xfrm_interface(E) xfrm6_tunnel(E) tunnel4(E) tunnel6(E) xt_policy(E)
> > xt_physdev(E) xt_nat(E) xt_REDIRECT(E) xt_comment(E) xt_connmark(E)
> > xt_mark(E) vxlan(E) ip6_udp_tunnel(E) udp_tunnel(E)
> > nfnetlink_cttimeout(E) xt_conntrack(E) nft_chain_nat(E)
> > xt_MASQUERADE(E) nf_conntrack_netlink(E) xt_addrtype(E) nft_compat(E)
> > nf_tables(E) nfnetlink(E) br_netfilter(E) bridge(E) 8021q(E) garp(E)
> > mrp(E) stp(E) llc(E) overlay(E) bonding(E) cfg80211(E) rfkill(E)
> > ipmi_ssif(E) intel_rapl_msr(E) intel_rapl_common(E) sb_edac(E)
> > x86_pkg_temp_thermal(E) intel_powerclamp(E) vfat(E) fat(E) coretemp(E)
> > kvm_intel(E) kvm(E) iTCO_wdt(E) mlx5_ib(E) intel_pmc_bxt(E)
> > iTCO_vendor_support(E) acpi_ipmi(E) i2c_algo_bit(E) ipmi_si(E)
> > irqbypass(E) ib_uverbs(E) drm_shmem_helper(E) ipmi_devintf(E)
> > ioatdma(E) rapl(E) i2c_i801(E) intel_cstate(E) ib_core(E)
> > intel_uncore(E) pcspkr(E) drm_kms_helper(E) joydev(E) lpc_ich(E)
> > hpilo(E) acpi_tad(E) ipmi_msghandler(E) acpi_power_meter(E) dca(E)
> > i2c_smbus(E) xfs(E)
> > [ 1068.939782]  drm(E) openvswitch(E) nf_conncount(E) nf_nat(E)
> > ext4(E) mbcache(E) jbd2(E) mlx5_core(E) sd_mod(E) t10_pi(E) sg(E)
> > crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E)
> > polyval_generic(E) serio_raw(E) ghash_clmulni_intel(E) mlxfw(E) tg3(E)
> > hpsa(E) tls(E) hpwdt(E) scsi_transport_sas(E) psample(E) wmi(E)
> > pci_hyperv_intf(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> > nf_conntrack(E) libcrc32c(E) crc32c_intel(E) nf_defrag_ipv6(E)
> > nf_defrag_ipv4(E) ip6_tables(E) fuse(E)
> > [ 1068.947864] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Tainted: G
> >       W   E      6.6.12-1.el9.elrepo.x86_64 #1
> > [ 1068.949014] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
> > Gen9, BIOS P89 11/23/2021
> > [ 1068.949552] RIP:
> > 0010:mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
> > [ 1068.951033] Code: f7 da f0 48 0f c1 56 28 48 39 c2 78 1d 74 05 c3
> > cc cc cc cc 48 8b bf 60 04 00 00 b9 01 00 00 00 ba ff ff ff ff e9 da
> > f7 f3 da <0f> 0b c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90
> > 90 90
> > [ 1068.952632] RSP: 0018:ffffb3a800003df0 EFLAGS: 00010297
> > [ 1068.953301] RAX: 000000000000003d RBX: ffff987f51b78000 RCX: 0000000000000050
> > [ 1068.954279] RDX: 0000000000000000 RSI: ffffdb5246508580 RDI: ffff987f51b78000
> > [ 1068.955358] RBP: ffff987fcdb0b540 R08: 0000000000000006 R09: ffff988ec44830c0
> > [ 1068.957674] R10: 0000000000000000 R11: ffff987fcab77040 R12: 0000000000000040
> > [ 1068.958669] R13: 0000000000000040 R14: ffff987fcdb0b168 R15: 000000000000003c
> > [ 1068.959828] FS:  0000000000000000(0000) GS:ffff988ebfc00000(0000)
> > knlGS:0000000000000000
> > [ 1068.960466] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1068.961350] CR2: 00007f173925a4e0 CR3: 0000001067a1e006 CR4: 00000000001706f0
> > [ 1068.962230] Call Trace:
> > [ 1068.962478]  <IRQ>
> > [ 1068.963055]  ? __warn+0x80/0x130
> > [ 1068.963073]  ? mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
> > [ 1068.964275]  ? report_bug+0x1c3/0x1d0
> > [ 1068.964585]  ? handle_bug+0x42/0x70
> > [ 1068.965228]  ? exc_invalid_op+0x14/0x70
> > [ 1068.965538]  ? asm_exc_invalid_op+0x16/0x20
> > [ 1068.965854]  ? mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
> > [ 1068.966518]  mlx5e_free_rx_mpwqe+0x18e/0x1c0 [mlx5_core]
> > [ 1068.967221]  mlx5e_post_rx_mpwqes+0x1a5/0x280 [mlx5_core]
> > [ 1068.967810]  mlx5e_napi_poll+0x143/0x710 [mlx5_core]
> > [ 1068.968416]  ? __netif_receive_skb_one_core+0x92/0xa0
> > [ 1068.968799]  __napi_poll+0x2c/0x1b0
> > [ 1068.970066]  net_rx_action+0x2a7/0x370
> > [ 1068.971012]  ? mlx5_cq_tasklet_cb+0x78/0x180 [mlx5_core]
> > [ 1068.971683]  __do_softirq+0xf0/0x2ee
> > [ 1068.972002]  __irq_exit_rcu+0x83/0xf0
> > [ 1068.972338]  common_interrupt+0xb8/0xd0
> > [ 1068.972738]  </IRQ>
> > [ 1068.973324]  <TASK>
> > [ 1068.974019]  asm_common_interrupt+0x22/0x40
> > [ 1068.974412] RIP: 0010:cpuidle_enter_state+0xc8/0x430
> > [ 1068.974787] Code: 0e c0 47 ff e8 99 f0 ff ff 8b 53 04 49 89 c5 0f
> > 1f 44 00 00 31 ff e8 87 99 46 ff 45 84 ff 0f 85 3f 02 00 00 fb 0f 1f
> > 44 00 00 <45> 85 f6 0f 88 6e 01 00 00 49 63 d6 4c 2b 2c 24 48 8d 04 52
> > 48 8d
> > [ 1068.976473] RSP: 0018:ffffffff9ca03e48 EFLAGS: 00000246
> > [ 1068.976872] RAX: ffff988ebfc00000 RBX: ffff988ebfc3da78 RCX: 000000000000001f
> > [ 1068.977869] RDX: 0000000000000000 RSI: ffffffff9c30e0ff RDI: ffffffff9c2e82f0
> > [ 1068.978824] RBP: 0000000000000004 R08: 000000f8e18f1bef R09: 0000000000000018
> > [ 1068.979802] R10: 0000000000009441 R11: ffff988ebfc317e4 R12: ffffffff9ceaf6c0
> > [ 1068.980841] R13: 000000f8e18f1bef R14: 0000000000000004 R15: 0000000000000000
> > [ 1068.981801]  ? cpuidle_enter_state+0xb9/0x430
> > [ 1068.982669]  cpuidle_enter+0x29/0x40
> > [ 1068.983003]  cpuidle_idle_call+0x10a/0x170
> > [ 1068.983349]  do_idle+0x7e/0xe0
> > [ 1068.984015]  cpu_startup_entry+0x26/0x30
> > [ 1068.984333]  rest_init+0xcd/0xd0
> > [ 1068.985008]  arch_call_rest_init+0xa/0x30
> > [ 1068.985326]  start_kernel+0x332/0x410
> > [ 1068.985628]  x86_64_start_reservations+0x14/0x30
> > [ 1068.986337]  x86_64_start_kernel+0x8e/0x90
> > [ 1068.986653]  secondary_startup_64_no_verify+0x18f/0x19b
> > [ 1068.987068]  </TASK>
> > [ 1068.987305] ---[ end trace 0000000000000000 ]---
>

Thanks for the report. We got another similar report recently which we
don't see internally.

Do you know what was the last known kernel working version?

Could you describe the configuration and the reproduction steps?

Thanks,
Dragos

