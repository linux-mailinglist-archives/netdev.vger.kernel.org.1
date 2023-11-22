Return-Path: <netdev+bounces-50000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B027F4398
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B061C208E8
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A2D54BCA;
	Wed, 22 Nov 2023 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TZEQrgKl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261DE12A;
	Wed, 22 Nov 2023 02:20:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1VJdDlahiEZjiSe/gZsVDsYRmIyuQVt/Qhs8zXGes0Kq+mRMCM95dZuYJhuMzWR0eUnezxNAwtKsIQP5iNI3CNhT+yraad68A2H2YEBvkdcjqekeb7P1GsICxYQ8lnhB7UynV3mi0stATaYLSE+gqj8xJDztCSSRxccGWAHq5TXk21jOTBVl11+E/h6lLg7Wi2hlJDIvdkVcsCKMgOBI4PTisUJwjJQTxCJoXKg2USu3zpNqVG/Ry+Gg3DOI3Y/v8o45JwFVB0YCMePRwcwbVFyqlmQXE/I1N1+rlxaVJQUtgGPvpY3QGNbUexyd8PwMitzzJgY7hJ78hRzdDZMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9SCZ79dMedyOwFDz3fbOjXCoX+UWKTw81Q1Qa+aQM4=;
 b=G4S8+mYud2ZuTBH0VbMczgZjNlWmW8iZ6bRAMQxcEgqixVm5xY3fkNkV7UPhI1BoBuRhN7aBOBJDIjkkQfXdnPYcqHAHu7homuERegISnlr5UlL6pAJJFLl7NRb7KJ42A9FTfj+uWdpH2q/FgAFb8epX5kEmt2GqOhl0aRD6eIUgXAbSXgUTdFT2kMz0jxLUgI0ihd83si4rDhr1KaImV4r8/i5TuPxfYC/5UFy+LLyczGcsDPBbrDrBuoX8zaSnht290etZuhBp3VXaOHRTxyhPXowpXbnm4CLI/shR7w/OoNNYFRnIqa0m/BUyt40LeXhnbV7VztJodI/aTYztdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9SCZ79dMedyOwFDz3fbOjXCoX+UWKTw81Q1Qa+aQM4=;
 b=TZEQrgKlA5H+38bTWDnGsN/IS3CGcCTjOjNc6TVP6kBv/9TInjqQmeJ4UwFybHvHU71U1t00wLoACmEiroeiTedabq0gXNXN/UANUCEbLS97ygtCuUG8PQwtlJ5YzRUPFaWRQBw+jeXqPDbgU7a7NwcAxlplKR40WXXS2+NkkX52bchYfW2HiWo0yFNJauqMmTxZVBVrYez+FZnY20ek2uqL8pqSOlubFkCId3SYMQA71ts8rkVb87tRoHV5bM4G6FmjxyHizaCJTDqoA+ftFv2U9vU4pRvPHM3/AlJ8h5DnczaekYnV4DYnDVR/3aV3ATuBTYcPiOAm0yr5LT1QEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by PAXPR04MB9350.eurprd04.prod.outlook.com (2603:10a6:102:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 10:20:50 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 10:20:50 +0000
Message-ID: <2338f70a-1823-47ad-8302-7fb62481f736@suse.com>
Date: Wed, 22 Nov 2023 11:20:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] USB: gl620a: check for rx buffer overflow
Content-Language: en-US
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Oliver Neukum <oneukum@suse.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 dmitry.bezrukov@aquantia.com, marcinguy@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
References: <20231122095306.15175-1-oneukum@suse.com>
 <2c1a8d3e-fac1-d728-1c8d-509cd21f7b4d@omp.ru>
 <367cedf8-881b-4b88-8da0-a46a556effda@suse.com>
 <5a04ff8e-7044-2d46-ab12-f18f7833b7f5@gmail.com>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <5a04ff8e-7044-2d46-ab12-f18f7833b7f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|PAXPR04MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: d64b5bfd-31ee-4ff1-2bcc-08dbeb44b386
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kjhp7EiAPosrjCKN0SZy2567IDrn1GId5Q8lG2uzNmQy01BRcG2UsM7y1hmq6njwcgwu2Uz8CJ4YjiltGxkM6hOChJP/1PA2CHzhE/Aw3HpcEgkolmmU5z74MB3/w/JxE0J+fq4Gbiy0tvIEJ8apxHnCy0szGN2aCUW+3mxc3pIUx4jEOs79PllW5ru/lDSxOKJYclla49AzsqbtK/geR5coUduXJTFzbgqlFno+kYB+/PGwsSZEAP6L3qK9CcUgHMzpypRpVUQuMLKD7z7waQ+9VjmmsdvuFM6RVbIhFL0XHw+Cu57LFoY9TZx1xssnJAl4lFrn+IMNHxQQcqC5Hav/a1ximCM2lgfCaQJOZkJZrWUPD593AJZAin21C6b45i3oUMvRn02xvBhbHlhmxVURHlYde4Wo0oPglv8b6aL3dhZMvt5JRlNJEK9UWHP14bJWBEwdpWFBE5DbEXGxuEPnXYvvdvXLPbJkTYsJmpFkyCxEGd69Au2jHH06VnpbR358Ryr6GMtb/gwwEvBzC43eLTRieQWySteV9Lu5ug0b57HRKJH97aPaJ75EUl0wjPRjMR45wLJMe1x48V0idA//b44CubehWWJaKMJjr1vnXBrGIdMic4auIFPye7JQ4I7AuRX17dZnaVi0V3jCuhdl2Gx/ZAFXBfvvJ1AckGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(110136005)(66946007)(66476007)(66556008)(316002)(2616005)(6506007)(53546011)(6666004)(921008)(6486002)(36756003)(6512007)(478600001)(7416002)(5660300002)(38100700002)(4744005)(2906002)(31686004)(41300700001)(31696002)(8676002)(8936002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnFWYUFSVDVnYkhtRFJHNWtCUlR6L1E4ZkVuWHlaNit1NE9WSmZ0MTNvSlhU?=
 =?utf-8?B?TUVhTU43NWJHdGdxbTdMekFQbDJsOUNiYUs2dVlXWXR5VDNiWmVNQzJqeGFF?=
 =?utf-8?B?Q2xkaTFydlJNWEFXRk9jbDlDVXFIYlVBU09ZTE9QZ0xES3BQcElCRzh6bllS?=
 =?utf-8?B?eTYzU3V6TERpQVliNVd5S0V2bTkxb2RHTWFkOFowdUZuemNOU3QwaVBUMm1W?=
 =?utf-8?B?Sll2RURlWXdtTHpLSjduTXhhdU84dktVTkwwSEtLeHpIcGFSNnhueU5Ma1Z3?=
 =?utf-8?B?QkxNTGd1V1VJdmQzVnVRZUtYUWt0ZDNnVjEyV0dGZFFFRHVKWDZHSnlFUU5s?=
 =?utf-8?B?YnMvWUtzNmhFQmNOOFYzRURnN2lIb3RzcUVVV25pM2J0enhTMlIvYUlqTW1B?=
 =?utf-8?B?bWJQd2dhV1A1cVpjYzNrL0pXYlBNcHRmbWxGMzM2R3hzajNZVlBtWm5hOUxQ?=
 =?utf-8?B?UHRPdHdRZGNBSlVOZnpCbnBQcnBSczFJbVFnY2Z1NHI0ODlLVTN2d2Q2VEN2?=
 =?utf-8?B?cXRJTkpyNW1aaWJHUDVaQlhBSS9LZUlHcjFuTDJwUlVEa2FpdEVxajhCOE1M?=
 =?utf-8?B?ckNXNjRNbGI2VEc1RUJla2srcWZTMkVheXgwL0E4R2lZdStFakVPMTVrMHRG?=
 =?utf-8?B?Y3lqZ2Q1cWlPNG9RZlhOV2NGMFczYytqVHdCTmlib2RmQ3V0TC92UDhTcGZQ?=
 =?utf-8?B?dFlCNnlmWks4b0kzT3VXQmw3cnA5WXVRS051MFhoQm1sVWRLallSUjlZL09t?=
 =?utf-8?B?NERzL1hwMG1wWTdqYUxONnYrbjNCUHI3TWpVQ1BpZnRxV0VTYXUra2R2dkV0?=
 =?utf-8?B?eVJGVjNlQWdOTWpacEtJZ2NlekhIQ2tZSEoxU2t0dnBJOVNidkY2dmtMbWRG?=
 =?utf-8?B?TGlKTWlYSXNzK05wMC8zVjVDVk5vL2IwcDF0cklCakQvMjJNR2hJa0RjTk51?=
 =?utf-8?B?emp4ZWk4aFdlaGRnMDlOUktjbHM1em5zaDhrYkJJUmRvOUhDN1B1dVdhZ01R?=
 =?utf-8?B?aWJyUmF5aGREaTN6OGtmZUtMUTY2bTVoRmVjUTdWSzhCT3RrZjJKa05LQWxU?=
 =?utf-8?B?V204bkNPb3UvR25VYmpGYXdrTXBJSWxNakpLZWF1dTk4bXZpOEdUWVBlMEpF?=
 =?utf-8?B?aCtETnp4T2liRXJLM3lVd3Bwb3FUMkRXaUhhUFg2dU5YQTBwL3BKbkxkVjBi?=
 =?utf-8?B?TjloM3lsN1ErVGVOSGpEZk9IaUtlV1d5b0c5UEFEU1k4M3JMZ1ppQStNOTd2?=
 =?utf-8?B?U3NuZGxQRks0N3dOb2JzV093RVNmV1pxWEZGYmNCUi9DdkM2U0xBWWhZRU80?=
 =?utf-8?B?SnMzWEVLUkNvZ1ZIM1VkT0thaC92UTJXelhxYzlnSHdQalF1eldGRDhzc1Ew?=
 =?utf-8?B?RURkVWpXaXhHR01PRGZLdUhwTDBhOVE4b09xajJwTGRKMkZmVzlnT0NmVXV5?=
 =?utf-8?B?Zmt2b0dZb1lpb2J0VWFDU3BmR1VqUGVKQ2Rlb25LeVlUOWN6ZHdpQ2JybThS?=
 =?utf-8?B?S0VxQ1RBbXR1Z1o4eURFenNBa0tFTUNOd05uR2d0eklsbHFXV3l5UTBYMHZN?=
 =?utf-8?B?OGViL2FpUnNsMndhZWp3OUpkdlE1QVJiMzgzdkJZdEYxSTdtOXlOZGFaSnFZ?=
 =?utf-8?B?MlFkMll6ajBNdWpmekhxeHlLNStTL1hLZTI5NFBEN2hucjJ3SHRnQ0MyTWFF?=
 =?utf-8?B?dU9SeGxOWjBDM3JBdTc0d09UeUYrNUtjeEVEZjJXZndDVVh1VEJFZHlCM0wx?=
 =?utf-8?B?K2RHblkzRlFBc3BUSXFvNzkySjIvbWIvV3FKTkRZa3JMeHRUcWVCQXJwaXJr?=
 =?utf-8?B?b0c2YzZBWS8wRU1zRThBcCtZMW5wc0k5Z1FnVXdxYWxVM3I4WEd6emxMcEpm?=
 =?utf-8?B?eHdPZmxHYzI1Zm5KbVhPc2VsZG1JUHdySlQyTk5GNGp5Tkl5Q3phNDVZdkpX?=
 =?utf-8?B?clQ4d1ZRU3kxdlhvSk9VZ2xNT2ZlZGlYVDJSakxYT3EzOVlSWEpEUlhhYkhk?=
 =?utf-8?B?YTBxSFM2cWdubjBpSHpMdmF0MW9BVWJxNEVUek00Y05uT2x3aktFNUxQNHdm?=
 =?utf-8?B?THBGZ1JISGtRL2dSNHZXM2l3MXpERzN3Z0VHZVZtTy9PTFJqVno5WW15VW5z?=
 =?utf-8?B?SjdXbGI1Z1owS3BZQTMzSEZpT1JBRWVZaWkzNU5tUzZpWW9QRldRUWdCQXNx?=
 =?utf-8?Q?M82D90xqtTU614unmquPCa5ZOwH5BLtJEm18ut+cO3Hg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64b5bfd-31ee-4ff1-2bcc-08dbeb44b386
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:20:50.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXm6YZcPrjkXPhz0tkjW8Zh3rnjteROsDbCzF22LhIWFIay8yLtk4L5OKem5qGGY5NnoMHxwj90mmM8DgFainQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9350



On 22.11.23 11:07, Sergei Shtylyov wrote:
> On 11/22/23 1:04 PM, Oliver Neukum wrote:
> 
> [...]
>>>> The driver checks for a single package overflowing
>>>
>>>      Maybe packet?
>>
>> No, that would be read as network packet, which
>> is precisely what this not not and should not
>> be mistaken for.
> 
>     But "package" hardly fits either. Is it a USB packet or something else?

Technically the content of the buffer associated
with a single URB. Which on USB physically can be multiple
packets. The network packets arrive together in a package.
That is how this and related drivers operate.

	Regards
		Oliver


