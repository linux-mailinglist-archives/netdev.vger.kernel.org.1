Return-Path: <netdev+bounces-103822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C6909AFF
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 03:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A670A1C20D1B
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 01:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1FF1C33;
	Sun, 16 Jun 2024 01:16:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D910F4;
	Sun, 16 Jun 2024 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718500564; cv=fail; b=Pm0IE531TK9PpM8RVnDpd+FK6ts6N/L6sVeyLB2MyynkosjjIA6ZDCKy5nCR7p0nRFPnL3PyYwptMCvGWAgJ/dgoYxFGtgY0x08Y9X78ga4bB0uHscxCFn/euVkJBhoJ056LJEcjyzYP7dzm8oSSLIFcZtwoNpJzWHkg2y9DNhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718500564; c=relaxed/simple;
	bh=u3J2R9dHqH9U5+M4VblI/C6GCQw7qUXDmUKXVkn6zM4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qd7rIF750ItfDMimWYMl9Xomvy4tpvp501jOCBtgii5DQ+exHIBqmNFOS5hXk7h8XqvnuEJcuWRl3vuey2J2Z60jWUb2cH1A4uTJ37+6nv3y5SPlQxXbWZQfEfqqq6F7UnAinuFyeWjFprTHm4zxgcBNZFQurO7cNILwFU86SNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G0Kls9005254;
	Sat, 15 Jun 2024 18:15:19 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ys682ggyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 18:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCdv9UZxwX/TkVMdH+mEsd4z4QpZEBUjPkUVUXXL98MU9unv9Dam1C7O+41kLoO28kuP8saXq4rnHOCi/gzA8qTmcAmPRFWoP3tbY2AkX5o/UtQExELRfHHBgO/Z68gB0/fNQmWpH6lVKZy1641qBu78j0dpyeOqDCwgbxIZlh//quefHomCQCbXK948iOImjnLNj9xu+CROgGrGRjKugTKy5fQV+NQR+tOYC8FnjB8f/frioaHMLwdHmxcmkIZ5Sn4bXmDfOqrJVDk9OyW6d/VNEFe89RqOXtzinBtzWMfpJZSQgPDXOrOajl8dcDQ4PzUQF+o/eO0r5JszgQbJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SvUqqdyVjH/WYt6/hcMmtXn0V59gx4qVpGscFY9m3c=;
 b=dgwyERQrMLQdSXjdAZfFRg7VtWXY0RYlxbJQjgaLwgMtAq5Knq2Cu9GqYgzyfoe4ktfW5uRoS6ZsVR9gZgFefWaO82cdysNl9PTj/wSZOzM2zVwa3Q57MUDEeMzXjENtk0RbboVKhCN53NICZrjMow7HswmILre9M39U8FZlyC4USrDu62xbkF+D7qGEjg7qik/w/3TGsJUXjMb52IKyExIIdV9Acb3+q13iCto6kS1kIpZAjRakfaw/IPxthl5oTPNbjiQRfKetb26YNN8hEd+3p3OXAQMx6NF48qzNsxdPCbtEzmC2FIE1mUTfGji/SCpMj+fIX/0rHr/h7A3hJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH8PR11MB6973.namprd11.prod.outlook.com (2603:10b6:510:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Sun, 16 Jun
 2024 01:15:15 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7677.027; Sun, 16 Jun 2024
 01:15:13 +0000
Message-ID: <ec41f61f-d500-4dda-8a79-37a68ddafced@windriver.com>
Date: Sun, 16 Jun 2024 09:15:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] net: stmmac: No need to calculate speed divider when
 offload is disabled
To: Simon Horman <horms@kernel.org>
Cc: olteanv@gmail.com, linux@armlinux.org.uk, alexandre.torgue@foss.st.com,
        andrew@lunn.ch, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, wojciech.drewek@intel.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20240614081916.764761-1-xiaolei.wang@windriver.com>
 <20240615144747.GE8447@kernel.org>
Content-Language: en-US
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <20240615144747.GE8447@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0115.jpnprd01.prod.outlook.com
 (2603:1096:405:4::31) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH8PR11MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 6018c6dd-dc8a-4209-018a-08dc8da1c5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QnBrdWEvYWtUeTY5WElQZDZzSmVMb0Y1Zk5EbVpDUTRxNndVRkJQRURWV2lF?=
 =?utf-8?B?czhjNkNJejBSeFVFQUR6bVRZbTlkN3IvdnhNNkJoUDlGSE5lampKMVJLbzNh?=
 =?utf-8?B?VVY3NmRLaGd1WEU4UEQxZHBPTDA4RzlUUDQza3UzdkZwK1NWSWxuS2N4OE9q?=
 =?utf-8?B?LzdpZUJlT1BuVTdRWW4zUEVUQjdhZGliajVjamtKZm96ZURyS1RmdElPTE1S?=
 =?utf-8?B?akk0aENVNWZ0Y2lScjY1UmxaMUhUMWE4M3U1RGhSYklWNktlTldLZnRpS21o?=
 =?utf-8?B?b3VTLzc4K3VualNralF3R0Qzd3gyYVMzdlpjdE9JR0IxdGFQYVd2RXM2ZlZQ?=
 =?utf-8?B?RGFXNDdZRUJ2eUw5L29QRlhLc0lFNzJhM1ljOGVUTHh1Nzl6ZXNGSDZ5bTNF?=
 =?utf-8?B?NWs3Rlp3UW44ZWhvNElEUjI2T0x4S1dRZG9aM3hNNVpEL3NYR2RvOE9lakR3?=
 =?utf-8?B?djV1b3FXV0dYUW9MZmJ2MVVLVk5TUnBGdHpaTEtzekhyYUxKY2VuR29JdGFu?=
 =?utf-8?B?UGQrU3Vlb0NSMmpQNC9CTFhERzBYTXh1TUVjRHdkY1ZXZC9ZVk5WdHM0d2JM?=
 =?utf-8?B?b3diUEdsYW12a3dZYnI3NkNCMUZON2N6aFcrdmZwK2xxMFFvTlJ1Q3N3N2J5?=
 =?utf-8?B?VlZpUXpVbU1CN3JOVVdlYXdqU09tbHRzbE1weVpLbEFkVTJMdkxYVWZSaE5j?=
 =?utf-8?B?MndMakNxQzVrNFVCY1ZLU0hPUWZwcnpCRzl0WTNuSHd1VHlGU1BpZlYrcmor?=
 =?utf-8?B?d3VTV09pdmlnbUNBdEZwUURiV3hOcGNaOEQyZUxPMlNYeUJnczZsT0RqUUFT?=
 =?utf-8?B?UkVuMXVGb0tkTzREMUc1Z0lhMVBJY3FKMmc1VmNzSk13a2NRSitsMTIrSkQ3?=
 =?utf-8?B?R3pyRGl1Z0o4eFUxMTZ0QXUrZWR0SHZDSjRyY0RyZyt4RzJERllUVUJ0TDFk?=
 =?utf-8?B?U0NLTHUyeTFqcWxndGxrTE50ZUZpb0xaU3VCREZVclRoUEtVYkhRc3NxSkhw?=
 =?utf-8?B?R3I3cUVKRDRqS3pFVmp2TkVMdWNocGJhRW9GS1hmRHdBdUtkYUl2YVorOGJa?=
 =?utf-8?B?QVpFOVpZUmM2bmdSVXJ6WFoyQVlSRENmd1h0OGx2Ynh2VnFFWnNwT2grVllk?=
 =?utf-8?B?aUFjS0h2UU9JL1Q2cXlQeUhGVElZbmhEa1JOMHdnR3U3M3BTYjM1MjhpcjNU?=
 =?utf-8?B?aXozbEZUR1NxU3k4Zzc2RzNNbXVQQnFSOWp5V0N6SmNuWTRyaUljTGlmNTdw?=
 =?utf-8?B?MnRrcGYxM0NhRGYzMHZZNlg1bDRoZERtUm5IMDhsRTdxcFVWSmx6dGhOSWtp?=
 =?utf-8?B?cDdUeTVLT2s5M2lRQ0tlM2hOdW5vbVlxb1htdHMyT2FHNzdsRmFBUWo3cGtl?=
 =?utf-8?B?UkhBM01Xd29ZSHZOUXpyREdMZFNjdTFZMHIyUzFLZlBIWTdsSzZ3RzVxNjhL?=
 =?utf-8?B?TXRpTkttSkRjc0FGTmJxSVFVYUdGbjhGdVM4NlhWejVXN1NyWlVqN2kxOFJo?=
 =?utf-8?B?QkYyRC95V3Q5a3pxeHhkMG41K0V4K1p3N3ZyaWpFclZMYzBkMzlwbitBQXNL?=
 =?utf-8?B?K3lydlBGelJzNFJxUkJkUytZbFdoTG9RbkNPdVNzWXFRKzd5NzBoYWhvaUhO?=
 =?utf-8?B?ZEc5OEFaK3N2andWbEpFazJwbHBVN2R2WkptQS9QMUcvR1pabnlxdDN0Vnhj?=
 =?utf-8?B?THBsemdLYnlWUVBkN01sT2cwbVJkZ0FKOFN5L0ZWRjJrYTBWcUw1ZTJZMkpa?=
 =?utf-8?Q?9VjuQ/j8yrtRH9dtHx5uM9G2YzXySfguMqd6BXC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUdOeE9BQmZBOEN1b2JET2lEZWwvVy9mbTViMGZ0eDA1QllkZ044RFJrT1ZP?=
 =?utf-8?B?czJRM2NmbC80SFhDZnZ6MXZwdHA4OUxoOHlzU2YwYU45VFFOb0dUZkpMYlhu?=
 =?utf-8?B?N3dOSmNOZE8zNTg4VDJMcjdCdXlRRWJqZ1B1MXRkbThnT1gvdCs5cnQvUlBI?=
 =?utf-8?B?Q3NoU1QwNHlIUjRTb3g2NFRrY0ZYeTZqazVzc0hEM1lYdXp0WmwydllzMUFC?=
 =?utf-8?B?VlhWNkQ1V0w3bCs2VWFVTXB1bUlHMXdYUC9Jem5hakhpeFZJaHF2UDNwalNG?=
 =?utf-8?B?SkkyVmxYdTh4L3N5alJvU1h6elU1OXJxVlVhTnhmREd6S045dkFWbkQ1WFlY?=
 =?utf-8?B?dVo4QTVXN1pnOWVlc1VTWEwxMjBOc25OTzYrUUtxRzFEQzJjYnFhRTM4NWU3?=
 =?utf-8?B?UG1oL05PLysveURTOHJaOHZQeDR0T3NRVlVLOG5CK0VhNDlzNC9QSCtRbmVy?=
 =?utf-8?B?OUY4cW5VcE9wMUZQV0NvZ3EybStJTWpuWWNxYTVsZDdwVFFZd29sSWdMNEZa?=
 =?utf-8?B?TFJmdnp5amN5SHM3Z0dCMlMwYVZ4K1JiUGwwbGNBSjZiOUJJT3pVVU9vcTY4?=
 =?utf-8?B?ZXVxZXJ2MExVeS9lcHJFa2F6Q1ViaGZDTm9qUEJXNUZ5Q2J3RWtIeHBmeW1P?=
 =?utf-8?B?ZUwvOXhQMFlpRmJMUWZtd0hmcUVISnIvQzRGcHUrOEw0L2hvNWQxNXBRY0tj?=
 =?utf-8?B?K0tzM0xqaCtuMjllNkZnbnFrNld3SFFOTjJFTG9MUWo2T2I2TTlJNzVXNFc5?=
 =?utf-8?B?OG9VZTU2dC9TSFZPdEI2U2ZUdFhXbExJekZqR2xncXMxYlR3akRRK01OQTZH?=
 =?utf-8?B?UUNTNmRaZlF5cVRhYTZLcXA4eVFKY3BUWk04dUdFdWZDdXN3aWJRSXhmdHhu?=
 =?utf-8?B?MU9LMVRnLzJGaUhONDgvZ3NwMVpMT3M4djVUckRuTXZiYllJU3ZYazhOUnNy?=
 =?utf-8?B?YzdRdlhUQkFpQjg2N2hRVFh3VnlCMWNjSFdaQkhvc0t6cEpadnV1dmFTbUg4?=
 =?utf-8?B?cHdXWkgwUUFzZ1dTcHV4Uk5jYk1UZ3M1Ym5GNkRxUkJBNmxQZ01zdC9XNWp6?=
 =?utf-8?B?Z2dibWkxNldlV3VTN2hJSHdUaDZNR2NXY2hid2hxUFlVbXJkUFA5Qnc0SUtV?=
 =?utf-8?B?Y2Z3OFFINjdyRjhtcE8wQ3hiQWtkTE9oUDFvR2lMQXZjRHNWZEhlR3IvUlhu?=
 =?utf-8?B?WURFeXZFUXpoVGZZRkN0M0xtaVd2dzc5RjN6Z1JtUUxub3g2SW44WVYxSGd1?=
 =?utf-8?B?Tno3Q1lpTnoyQjBjRmI3Mm1DOHdrb29xVGRMT2tISlJTbnRnWWtWUXNzdFNM?=
 =?utf-8?B?VjJjcFBpSlVyeGJweTRlQmFTcjRVVDFsclFudjZjQzFKQ3pOdVFWN241T0dG?=
 =?utf-8?B?cFBoN1BEalN4ZHNrRS8ra1RIeVVFbDlhdC93cllFV0NCUjg4a1FCbWl1K1Nv?=
 =?utf-8?B?Yjk3YVVmRWI4RGFUcmloQ090SXcvbkVqZWQyc1VsR2dGZ0oyUisyQy9yZ3Zj?=
 =?utf-8?B?S3JTZFZTYzlDQ1dGM2dSNTR6RkhCYWtXZDVCK3NHNXdobVpKL0pOL0luZTdY?=
 =?utf-8?B?VWV5MDdYMmN1YlVxQXZnWWRCemxqREoyZ0JWZ2t0QjZ5alhGRk9OL2MvbTBM?=
 =?utf-8?B?L3U2TzdkUENRNGhzQitjejludDZ4MzJqbDgrbFZaei9nL01rTnZVYTFzL0dH?=
 =?utf-8?B?bFRQUHNDc0FtVVZVcEk4T04vcnFFQVN0QVZsNC9GK0JGRnBpdG0zQmZKcmo0?=
 =?utf-8?B?ZnNRU3F4K3JweGNmeHhPa2J0RDQvVXFMTU1yWWRLOUE3M3N5TlVhTThGUy92?=
 =?utf-8?B?Nm11aVF1Z3o1dzNJcUtwK1VqeHVIdTY5cWZHeG1pTk1uTHJtQTNVZFhHMlg3?=
 =?utf-8?B?d0t0US9jZVdDMml1Vy93MXY3bUl1aE5kQThsaFNvNEhWVFUzdlVLLzJaR0tL?=
 =?utf-8?B?NUg5MXdQbEJNZTdKcUs0amJKS0hqWDYrUXV6M1g0MlVDeGtSNW13eVV0d2E2?=
 =?utf-8?B?MEhJK0JRUTFhdDlCczV3NUdhT21PaFJqT2hmRnAxM3hqVVQ0engySEhJVUFJ?=
 =?utf-8?B?R2FJYkg0M0xyNmttN2FWeDdudlRCZnhubmhKQ0RiL2xnVWhFbzRhUStWaits?=
 =?utf-8?B?ckxvK2IwTHNJelJuSWR6YWt4YXZTbUQrVDVTR0daV2s5RVBqbm13MTlObk5C?=
 =?utf-8?B?WUhnRERJUDl2U3ZVTVNTdmtZaDdRaGcwNUxNM1p3aDc2SGE3Vmlib3RicW1K?=
 =?utf-8?B?YWtEaFFYMjh3N2JRbUhEd0xla3dBPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6018c6dd-dc8a-4209-018a-08dc8da1c5cf
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 01:15:12.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75MUUjO6skGPqaX8IAiSeElJsS4XdPiH0v7F9U/T6RDduHCleyFhgVXwhnFyr1aDTRUltLjsquMoJh+2uW4Ntxexh2JuZ4BwHw3J7pc4R5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6973
X-Proofpoint-ORIG-GUID: VpNy0OnWyCl29v0S2sULXfyBO0YxGECQ
X-Proofpoint-GUID: VpNy0OnWyCl29v0S2sULXfyBO0YxGECQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_18,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406160008


On 6/15/24 22:47, Simon Horman wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, Jun 14, 2024 at 04:19:16PM +0800, Xiaolei Wang wrote:
>> commit be27b8965297 ("net: stmmac: replace priv->speed with
>> the portTransmitRate from the tc-cbs parameters") introduced
>> a problem. When deleting, it prompts "Invalid portTransmitRate
>> 0 (idleSlope - sendSlope)" and exits. Add judgment on cbs.enable.
>> Only when offload is enabled, speed divider needs to be calculated.
>>
>> Fixes: be27b8965297 ("net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters")
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>   .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 38 ++++++++++---------
>>   1 file changed, 20 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>> index 1562fbdd0a04..b0fd2d6e525e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>> @@ -358,24 +358,26 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>>
>>        port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
>>
>> -     /* Port Transmit Rate and Speed Divider */
>> -     switch (div_s64(port_transmit_rate_kbps, 1000)) {
>> -     case SPEED_10000:
>> -     case SPEED_5000:
>> -             ptr = 32;
>> -             break;
>> -     case SPEED_2500:
>> -     case SPEED_1000:
>> -             ptr = 8;
>> -             break;
>> -     case SPEED_100:
>> -             ptr = 4;
>> -             break;
>> -     default:
>> -             netdev_err(priv->dev,
>> -                        "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
>> -                        port_transmit_rate_kbps);
>> -             return -EINVAL;
>> +     if (qopt->enable) {
>> +             /* Port Transmit Rate and Speed Divider */
>> +             switch (div_s64(port_transmit_rate_kbps, 1000)) {
>> +             case SPEED_10000:
>> +             case SPEED_5000:
>> +                     ptr = 32;
>> +                     break;
>> +             case SPEED_2500:
>> +             case SPEED_1000:
>> +                     ptr = 8;
>> +                     break;
>> +             case SPEED_100:
>> +                     ptr = 4;
>> +                     break;
>> +             default:
>> +                     netdev_err(priv->dev,
>> +                                "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
>> +                                port_transmit_rate_kbps);
>> +                     return -EINVAL;
>> +             }
>>        }
>>        mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
> Hi Xiaolei Wang,
>
> The code following this function looks like this:
>
>          if (mode_to_use == MTL_QUEUE_DCB && qopt->enable) {
>                  ret = stmmac_dma_qmode(priv, priv->ioaddr, queue, MTL_QUEUE_AVB);
>                  if (ret)
>                          return ret;
>                  priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_AVB;
>          } else if (!qopt->enable) {
>                  ret = stmmac_dma_qmode(priv, priv->ioaddr, queue,
>                                         MTL_QUEUE_DCB);
>                  if (ret)
>                          return ret;
>                  priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
>          }
>
>          /* Final adjustments for HW */
>          value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
>          priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
>
>          value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
>          priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
>
> And the div_s64() lines above appear to use
> ptr uninitialised in the !qopt->enable case.

Oh, when deleting the configuration, idleslope and sendslope are both 0, 
do you mean we also need to set ptr to 0?

thanks

xiaolei

>
> Flagged by Smatch.
>
> --
> pw-bot: changes-requested

