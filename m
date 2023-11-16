Return-Path: <netdev+bounces-48270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1E7EDE47
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F34C1C20754
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6DF29438;
	Thu, 16 Nov 2023 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YkSwu2n3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E301B6;
	Thu, 16 Nov 2023 02:14:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8wX9YAdBYSkJaDY0ql8bvNcSwjLJVSTbXvGuywO1MX06P7t09oK3Q/9cLWE9IkBhiZsBza5VJowPfoc99GNIUcN1QpXzOjPmezwxVA9UJ0jFuUSihPHgCcW3iG3/YkTuEAqX0QqdwpDJSOf3SpVi7OmjGsgRnGYZQ8pADyQCMQ6XSM4gw3QkWhP2rFgjMN6PzXFsL8GDXiuGajxj0RB+uZVRbXM5HYNOKlFcRGg5Sapyz/ekp6lniQ01VED9oVCQu/tDvctRUQSzgDF1ISjmIZSNKISZqs0Frk5/TJ8qxT6YEBY7dv/XJ7lLnpf8KGPK+pO2eirZD4xF811Qt8AMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy7y9f47x/KDULQmvG0S67sD8XclzMROlV0GqHsHkfw=;
 b=h7RNREVSqW5w3y4gJL3msv0stOAjbLGvmCdvJNuAZuES9zL0H14zZqATn5hXeBOP49Pl8sztuvuM25VsE4SRoznDv1Dzt+lRwc1fB+CClQEVbJEnLX33IMNCZ2GFibFBshlp4kPem8Nv2S5qr/0/RagT9QhEKiehV2ecyPrkleAfpbFaz8G9VElwvqcluBUBYmShqxOHaBFwXy0gV3RSgNgHn9MP3uXDsev+WpHa8ue/yEG2fja9jXiK9A7ymEJtUIaIvwv8hJSrfY5UNLPcDxJtUPhAOCMga7VcvmdzbY5RtVyKRo2s4M26ZQGXjjEjFKGM0GunHh4YT9HZVlcN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy7y9f47x/KDULQmvG0S67sD8XclzMROlV0GqHsHkfw=;
 b=YkSwu2n3PqO1vNFZ2rsm5wShcBHJIpKmlbCovh9GwIlCVJhsQDKA9Oa604WvgO/jyqNAt0n0lc89oc01BTNhsSMaoajWL5AJJKRqI2Zsq9ZkK4FnYQbUe6hXu50OwjpFfwEQUK3IFRrbr6ysPmbuWa4uUrzw7hmSw0AQWvDYRZbhY2TEJ1tjDXXDpayQRWh/x5pq/csNVgJhcGYh90orjEfhXp2lW03lb1gHEG0q6BOAyaC11oY9HMpGF0w+vbzoR5yKHyXtaqRqZc4yVBkN38C1K3tqmwqrEmhantaVJwasT0zXnDh6RoF7wErlwhmn8jwAZEwPdbMh0EMv2SNSNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by VI1PR04MB7005.eurprd04.prod.outlook.com (2603:10a6:803:136::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.12; Thu, 16 Nov
 2023 10:14:53 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%6]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 10:14:53 +0000
Message-ID: <53b66aee-c4ad-4aec-b59f-94649323bcd6@suse.com>
Date: Thu, 16 Nov 2023 11:14:49 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
From: Oliver Neukum <oneukum@suse.com>
Subject: question on random MAC in usbnet
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0353.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::16) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|VI1PR04MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd50e44-303a-400b-6eca-08dbe68ce010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vuySLXPJVCpHF4MWfBMyOiNUs/5yaV1gm/AoyFXkk8nXOeNCt4gHKjh+nrP9w7KFKZl+phe80Kqdab2+40/pzWj7U2rrxEaVBPvafzloS3iDtuFzbHr9W9r0V8BStiC2Uh7Lo70D9Ln/zyX3XZKDKltX/dc1KecEnyo3ODx+MlPnqhFceMFcpWmXaT7/b8bHr6bkW03o4fTuXe8jeS21lBOvzIJhj9UQaVHScIN3wNRSmSO+tpGTQTB66uDhh/OS1B+qrTPMaAYpo7tD5scLiOTlStD39ch+LiJiSMbcXKV9vmwmqs5w9N/lBX8Yh6eFN6RN+CFRw4wXBrxMlMs0Kp0V+K0s0VA8LnfEmTGwH+AWvJp4NVXCP5uU/oUKsgSQ9f7a2melLV3iJpviakeXNPhhI23kBk570sbdg9dN9B6xPoYP823KMU+4kz1UzTOWkprtzSg2tmtrKURiI2DJCDf+jHmSnD5WJW/NysQbBQDArjlFv+MTtPiYplOM9nFWExYBtIYgQuQHyRqDl62UwjD4yjrp28/ZhcAH1H0fys2vkTqNgB9V/S8h3b9XEonQbZDBNbZTY+UsC3Yzotarl2k7/aEsTRjvk6ekRP4uDqcmDn6aWci67ryEn8T5RTi/peRQWRcol2C9qYvVn19faQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(6512007)(6666004)(478600001)(2616005)(6506007)(6486002)(36756003)(38100700002)(86362001)(4744005)(31696002)(66946007)(66556008)(2906002)(6916009)(54906003)(8676002)(316002)(5660300002)(41300700001)(66476007)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDFSUUVnYmRreG4rNHFiWFBBamgxdkQ2WjhzUVJQNnc2ajA2QU5rOTF1ZC9y?=
 =?utf-8?B?VHBpOE01QWZWZnlvU1NTMkc0OGVaT1ZhRFJMb2M0T2t6aU0zbnIzQXFZbzVl?=
 =?utf-8?B?S3ZOSjZUUEtqQXQrcTBQZ2YvQVg1eklIV0c5UGUwYTdJK1pPQklaTU8rQ3Zm?=
 =?utf-8?B?QndoYnBOTjZDdHJPbzJWaEhsWW00VFFJbVY4Z2lqdndzVUhPRUorV1owdjhM?=
 =?utf-8?B?NGlmbGJmNzdLQWZTaStTaFFhdE1kenFHYnRXb1ZKVittMW9QUDk5LzB6N040?=
 =?utf-8?B?dmpkWjY3VEJJVXdrN0FGb3BFWEJGaG9hdlJ5K0hSaHE0dlFienZrSEZvSUFl?=
 =?utf-8?B?YjdIYUVQeDAwTHFKblR0bjdkRWtjbngwSkV4Y2J4eGhiaUJZMG9GYUZIeThC?=
 =?utf-8?B?ZkdFS2l3clhERU02OTVOZWovaUpWSTJsekpYQmlSMzczRFBqV1RTdTFGSG53?=
 =?utf-8?B?VVNRcS9LMWxQbDRjMWNyWElGMTlRVncyTzIyMzc0TUtSSjF1SlFQL1RvSS85?=
 =?utf-8?B?SEZyZDc5RlcxVHJBTUFXeGZ5QzY1MHFsV1o1Z3lNNDV3czNBR1VnR1lnWkZ6?=
 =?utf-8?B?dGR0UEtuTERLQURKQ0lSL3ZaTlU2WUFJVTdGWXBkS3I5bmxEaVh2MDFpL2F2?=
 =?utf-8?B?dlIwQ2Q1anNYMU5WRjZYRWxSSDAxajdCcTJkSXJnQ0xSSjJncHd3ZHhwMmFC?=
 =?utf-8?B?NTFLdGhWa2ZLcGNCNWNCdDRtbmxLanJpWWZqWkljMFpUOFovdERhc0hIOXJw?=
 =?utf-8?B?cUdLWFBybFRwR0hUdFNpcXJlRi80NXhhWGJOZHVMWHlybkhTdVZLNzVtT3F3?=
 =?utf-8?B?bWJsUVBqUndWcEtES2RobSttVEYyNHQ5OGUvdmVRS1JHd0JBMWVNeWNyeG8r?=
 =?utf-8?B?L3lrNTBQUWxxUkJVZ1dkVVFKNmlkQUg2S1Avckl3aWpTRS94WW1oRjh4TTdu?=
 =?utf-8?B?aG1zNHJubkx4ZDROQkVQU0hDRjA5V3VaRXYyZWg3THZFSTlFQ0hqZ2pnNElN?=
 =?utf-8?B?RDRzTWw0bi84b1lxa2hySTRwLzlXSW5ua1hrcUVReWpRVEZzczMzNzVmNUla?=
 =?utf-8?B?ODRuc0FzRkRvVDBVUTdYeWVvZkJreTJERXpsZ3dQZVVWbDJOY3BxbksvMmx0?=
 =?utf-8?B?YXM4NThYMnhOV2xUU0hxZTlRVVNkOU1MbjNsWDNKNFdOeTkvN0E5OUo5S0hY?=
 =?utf-8?B?U29SbHRsU3FKTTJCWVhDN1c0aElqK0ZEZHhjSXVwTm5XQmZLUE5ZbFZxUzZI?=
 =?utf-8?B?RUliUUpqcDVFWitybWgxWDNJOG9PWklXVVNRNGZtcVNvNzJoSm9NL0FUb3RD?=
 =?utf-8?B?eHVjOHl2dGt3RHBKYXJRaTNBUlN5STVoYXdZRTBjODlLaDF5c3B1YnFjREZn?=
 =?utf-8?B?THdEdXNmZWtld3U4bkpsQ2xmYzNFNC9aeWEzcXFtMkl2MWU0SDMrTU4rYjJK?=
 =?utf-8?B?Y2Jqa0ppcS9SMUVQRHNLVnpsY3ZFb2pYbTFUNmZuQ1FROFR0K2lSdHNFTUli?=
 =?utf-8?B?a29BWVJUR1V4S3MzZ3FsQVhmWVhaQ1BBRW1leXArY0h3SlR6eTRTWUowNDFl?=
 =?utf-8?B?bUNsaDFsV1R0NTh3QW9pRDFIcnlyaUMzQnJIRFRhem5XQU5uWWEyNlh4Kzd0?=
 =?utf-8?B?SnFOd1FWdmoyOUM3SHE5dFRYUXZPak5iZURHUTlYRmxtN1FjU3hidjU3bTdP?=
 =?utf-8?B?U2hFRDhDL3BHOERRb25Vckt3UlhIaGY5eG9OUUU1S3orTDBrOVdHMHgyYmVC?=
 =?utf-8?B?bG9VTjFUSE16bVA5bEJ0RnlMY1RTaVZPdUhlWm9kb3VLSmlLYVNnU0tyZzRI?=
 =?utf-8?B?QUwyeFV2bkdURkpjZWpPN0tZdUpua3ZCUU9ZTExhZTc2UUhvVG1VbW83KzNV?=
 =?utf-8?B?Nm9vRHNxSHM2TkpOcW00cHNLTHVBTXlNZXBMbE9UUkpmYW8zbXVmdHQra0dz?=
 =?utf-8?B?c1l3MUxpWWFHUEtZTUhDaGpZUjQrem9aRmd4R09rRWRJSXQ3MDNtRUR1Q2ds?=
 =?utf-8?B?bGduU0dNS1FBVDZhcTVTZHBXUHdDcEZxOHF1b2lTM1NqWkV4Sm40UUpHbU92?=
 =?utf-8?B?Uk5GbEpvVlpwdU9rcnhmUCs1b0RVdFVyOVQ5V0s4RUpGQzhpV3ZxODVQNEFq?=
 =?utf-8?B?a2ZWTFgzTlc4RTJDTnZ4M1JsY2VEV1BtVjBZRFdvZ1ZOaktqTTF6QzYwT1U0?=
 =?utf-8?Q?Y1P0r9K5PSXfUSZ9y+dh2zZA8jGoUnCGJfJupx8R8/Dt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd50e44-303a-400b-6eca-08dbe68ce010
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 10:14:53.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfDvm4+F/xttteDT4YDngNsZS/ZF6ulJ8z9fLolH1y9lQEcS5iyWqLqKnJCPs41a5FOw/oLEUtkNVriD7N9Yiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7005

Hi,

I am wondering about the MAC address usbnet is handing
out. In particular why that is a singular address.
Frankly that seems plainly wrong. A MAC is supposed
to be unique, which is just fundamentally incompatible
to using the same MAC for multiple devices, as usbnet
currently potentially does.

Do you think that behavior should be changed to using
a separate random MAC for each device that requires it?

	Regards
		Oliver

