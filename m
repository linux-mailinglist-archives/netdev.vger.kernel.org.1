Return-Path: <netdev+bounces-12699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D673895D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42F6280CF8
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E53B1951B;
	Wed, 21 Jun 2023 15:35:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91318C2E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:35:00 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2110.outbound.protection.outlook.com [40.107.100.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA69183
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaLF2eVfi+TjTEGWbzYMkYE8cu0HKOOEk7C6DYgYMEZgACUNQhuSt9p13fSkiJJKON5wguJpkXzRUpsfyDgURKEpiVsMmPcl6m8QHd1ecOQjoxCc67zZoEpE75iNT6Y7kvF/MQMfPQD7pVUjIrK4WHxbBVVprdoi80KAF55nk/StL9VfXsGRBqbHZZW3jRT504bZL9aW13qyeWoX7vu5Ocb8mpYp6Ipe+wY+hKKwD/qlK9bStNkOUkTDUpY1DJvD1yv3eLm/9uYoONTidum/kh07A35u7/Xjkyz2mkcxsuhkq+rckABifbs0rYTLBt2mSitD1E1WsQDKItePyhi9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CzoirVv0oYQHcx2XzLiRQDme+UigXNO1EgZXgu0rEg=;
 b=Mie74yjVjoZXubCTJ9uDia5fCChhOOBJdPTg65JpI+xxnfEeUPEV9NN/ASAakf5ZwVc2+9WEMaRBPV2L2ncEE3PyBRUrzqRYcj7wpcUTkSfSwNzF6PCNbUExTHdtKgWbHoZ8nSvWUne7S4YbVwdjTM+ajcoH5K5Nl3lHiZjnFxzGqenYkGczL8dAMxDTCLPFVHfPAk/7LoS6J26UuTSbzeURMmcpOgSgIlfijtpxE5+E2UUKZrMe2lnChC657zqnh1dgDY5m9OswL8pt8BOaF9yYOpxMO+/RDnlZnNOLCepSJGoYF0uXdYb7H897aAXz7RZ8bdf7Gx8xK7rPVdo64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CzoirVv0oYQHcx2XzLiRQDme+UigXNO1EgZXgu0rEg=;
 b=MBf1EbB+Gb7Gs7Yje7KcxKkmc6/KvQF54DvqCQEdM+0rkNOdnHRFZ4bCxBXhkf5P0gmfseoocmmf6pt5qQe37roZ9ooiFGKgw15FJWoP28NC3RkJkzHB3e4SNZyNZURTmwegM9LosMP1vFv2DuI3X5v8+V7x1UOCJkEqIlBguoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5639.namprd13.prod.outlook.com (2603:10b6:510:12a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 15:34:36 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 15:34:36 +0000
Date: Wed, 21 Jun 2023 17:34:30 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v1 1/3] led: trig: netdev: Fix requesting
 offload device
Message-ID: <ZJMYhiZpip8ly8+0@corigine.com>
References: <20230619215703.4038619-1-andrew@lunn.ch>
 <20230619215703.4038619-2-andrew@lunn.ch>
 <ZJL9I5rQlYFUZWPp@corigine.com>
 <864bfa14-ab8f-4953-873c-a9ad4721be22@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864bfa14-ab8f-4953-873c-a9ad4721be22@lunn.ch>
X-ClientProxiedBy: AM0PR04CA0039.eurprd04.prod.outlook.com
 (2603:10a6:208:1::16) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ca04b0-380c-4b3c-56e5-08db726d04f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MDJzQdQjGInMVnt5Rq3XRn0zF/TmcNIiTcQv5IxW6JwDZQ8vjTAoJNqn88/libyOw0rPZQHq+10xLCisC9d5Z6lZ0TxaP9c3C525bun2hlxwOf8+c0yYLcYW64m227Uji8tLmusiTuaGI2jZNyRMRZRLkg1shXcFs87c/1IFaGxOMiEnvgKup6Z6GObsv1Ffz+ZllFHF+bEghyfGY1a+N3pmWTyAUuLNVtY7X/UQybx/NTVG3sNUcT/hE+gMqkVCho85qTE78ldQWo72afTbHGiSH6UrEyG3lgUVrIMe1z25e5YyBAwY02TwhjKJbe+qNwaKE35/P26XROFOANBwAnnc2SLhBL3nNjP7H5JWWCzwDz8ls2gHhOmzPQJl76/uu/u+yLtORAtN+F6cajceKM/karFMHeKEYzDQHy1tRraKj11dTg+v5kCftqmVkjd+Dy/p3sDeiosikJihD8SiEnsongx+gE19GZl8gk1Kzo+CP75noWeYUDFG39jMSrkmogOKS8rBq5H8w5SUgH/E9bONZxz6oDhqGbeGtEOoCnlt1hkx2E5aquRrjxNH5FzuUAqETSrGCuekNXl10QyJx8fWrxvSwriB6eFF5mkM++sVYhcUOEsKhylE9MM5g8QZe/GR+LjZ+s1kU0xwqH+RlZ0+tiTSYLKBopL5h9MmtqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39840400004)(451199021)(6486002)(478600001)(6666004)(186003)(36756003)(6506007)(86362001)(2616005)(6512007)(38100700002)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002)(54906003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N7XP+bbQqhYO+8F6A3B+Yb7h8E9Wl+Bu0yFNOjcxhpuDVVTCvkcyTFKT1pgk?=
 =?us-ascii?Q?XdY83VF+E86O5+vwXCciyCXMH+nroW4A51yW/PMX8nyb2++A4GCyooSdVwHk?=
 =?us-ascii?Q?V3batmETc+KQNWl5VW19lHZZHOgXAeII+kcaB15xXh8w1wONJX43OglWR5TG?=
 =?us-ascii?Q?rJR/mRal/sPmJvUjhEYVBu5e8836pxYVOxCjPGnCyqqkz4urX5ysXRdAlC2O?=
 =?us-ascii?Q?Xp5w8Oc8N7sLr5qYvXxbeJzecKNVp6LO8glcn66VSymSw0m6fGY7SR2s0cqF?=
 =?us-ascii?Q?OlZY7Kc7phlv2sjzVFa3TETKRr44Hircvpe8/Q+Eie1wXx4RS3OCsrLkMBUt?=
 =?us-ascii?Q?bQ17doimy/qhLFGQqyU10R+wgFs1Oa4k8petQKzKjbDRpT/0DhJZwexv/N20?=
 =?us-ascii?Q?M8EIc8CQnFSix4S03hMhQUQ4CJk17sjP+eqSHDBgM8knVqlUD6MljfzomWl4?=
 =?us-ascii?Q?67DAHyF5kbuLmYctSTzf7fxvl/5Bq5nWQVdNJx0gwGkAiZhSn367Stbg/KEG?=
 =?us-ascii?Q?+GCuVMw8EpdLsnJ34FZ9Qrvt67ROrWO9RVqXo9aXBzIaspP9LL8kHojX+sLW?=
 =?us-ascii?Q?iey1m+yiJ2SRm6g0gNiFm//CJIPW1eHgyqgu8goI7UT4eCIAXjQaFk28zz+e?=
 =?us-ascii?Q?Ecfx5rDGdH/L/Y1kC+RPfdLRbnPacNGGoz3PtOfeJfHr4bQC/CYb380CkUIM?=
 =?us-ascii?Q?2C/1KB1bByuAUUHRH7V2rN32jPu63galGXiLSVRcSPpONi0MhZ/gHh0lHJAP?=
 =?us-ascii?Q?feH84wgyj5gHCpONr7o+0KVzSf5SGz42YzytKpcSzKsFSLWXcFT+1Bl0uzsY?=
 =?us-ascii?Q?gs1Xbp3vAqxqcGEvw6zWmT+uVP+LLlQNUk9EOmpCRzni1cVp/PZtptHL53Nw?=
 =?us-ascii?Q?VTPNxs5i68DBvL1oIh48P+FL+FJS6FS6z63x1YrfYbLq8uuIgY2R3RbQOOeJ?=
 =?us-ascii?Q?NdOXKVaOLiUDF/HQP5ZPAiYgF697/0By2kSMPZVyeXiJgS9P4SiKLSw4r1AY?=
 =?us-ascii?Q?ZWRQb7yQsTaSG/LUB+7n4aGQ4J7V4T6/Qf9TdIpZB1uLrme15M282Pi8YLq3?=
 =?us-ascii?Q?onrWjxOAXVZUbrICFlCp3njw9LE2gg87PlOc2PLJhx0O6aFCHHAkl4PKyvQR?=
 =?us-ascii?Q?CqtRSEIyRIJqNBfcfNAYCUhOPm35m/3yVLjb1R3sDJA/uMOd759L1pJhjJ20?=
 =?us-ascii?Q?4M6abFXsz76BnSfLOzZH9xx2sTwlGvNfGbq5wqqPPJygZggbjdBgf3yjoxBq?=
 =?us-ascii?Q?IfJdSdTw5AJlYLLfPhMvw9xuextm6cLWmJV9XxdBd/RDpB3j0hoWdQsXpC2/?=
 =?us-ascii?Q?qAMd7qd8HMfukp0ZQhzU/22tr/x/ORzYD3xbQLcJ8J2dGnWS43P4x/fW8rGS?=
 =?us-ascii?Q?smaxL6TK1dkJ6TopbvjFfAgXHvcenkWBnBEh2eRvErSN/eeie2+MHft1X3g3?=
 =?us-ascii?Q?32PJQoodpIiUEOl3OhhYwMfrmrXacfbF8BABmo8I+MNoQ3seEQGziAYEPsVJ?=
 =?us-ascii?Q?AuNjKjIF7PzuTjVNa0Xt1oxZ1TUTXZi4o0tei/EPv9ousE4quaGKApNoigiX?=
 =?us-ascii?Q?6trNCKUXGGFNakP10H3PhV1NIgx1RuHboscpmQJJdEY9h2VOOexL/WcSfPCR?=
 =?us-ascii?Q?vRIoZsQFqbLh5gy8Bh5uzpRYDMVUls0jdPZYTUVPcgW7a3lwUZj+a4bsY5+g?=
 =?us-ascii?Q?ql/8dQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ca04b0-380c-4b3c-56e5-08db726d04f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:34:36.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPT+omsU24rRXMw1QOhrZS2+SQq7AlBxB5XQpvGAf9nmmQpe+9DtRkx0b0J7Wowq0KXujNUb4cTS119qj0fk+GrWXZ0mRyWSC8if6DjnPG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5639
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 05:19:01PM +0200, Andrew Lunn wrote:
> > >  			set_device_name(trigger_data, name, strlen(name));
> > >  			trigger_data->hw_control = true;
> > > -			trigger_data->mode = mode;
> > > +
> > > +			rc = led_cdev->hw_control_get(led_cdev, &mode);
> > > +			if (!rc)
> > > +				trigger_data->mode = mode;
> > 
> > Is the case where trigger_data->hw_control is set to true
> > but trigger_data->mode is not set ok?
> > 
> > I understand that is the whole point is not to return an error in this case.
> > But I'm concerned about the value of trigger_data->mode.
> 
> Yes, its something Christian and I talked about off-list.
> trigger_data->mode is 0 by default due to the kzalloc(). 0 is a valid
> value, it means don't blink for any reason. So in effect the LED
> should be off. And any LED driver which the ledtrig-netdev.c supports
> must support software control of the LED, so does support setting the
> LED off.
> 
> In the normal case hw_control_get() returns indicating the current
> blink mode, and the trigger sets its initial state to that. If
> however, it returns an error, it probably means its current state
> cannot be represented by the netdev trigger. PHY vendors do all sort
> of odd things, and we don't want to support all the craziness. So
> setting the LED off and leaving the user to configure the LED how they
> want seems like a reasonable thing to do.
> 
> And i tested this because my initial implementation of the Marvell
> driver was FUBAR and it returned an error here.

Thanks Andrew,

sounds good to me.
Especially,

	"we don't want to support all the craziness"

Reviewed-by: Simon Horman <simon.horman@corigine.com>


