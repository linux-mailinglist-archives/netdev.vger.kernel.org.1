Return-Path: <netdev+bounces-27583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1277C730
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53711C2042F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D85E522B;
	Tue, 15 Aug 2023 05:47:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC8440A
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 05:47:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82F1FF1
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 22:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVrXoc8Qq9MHvfI0AdlbFjNbB5mw3h7t2IAqxbVVgh3ynaZ6gRl1boxeYBMlWGz4OtZ3qFPKMCEQESV7G4AZusl1Dy6C0scyBMnx/2hbGR5LsxX9V8yJZbGjK88IkZfG2+bedOgirap0sSHN55L7p6FFgDwpQZa9f4IDX2+sUWrhRNbbscUiRK4MVdmfveTq0x7dtjhx/m0ppqTHmVWMzwgNeAasJDxNVs1hfEAk1iy2VnUHHYYxzIKY/yMQXe9XE/Ay6kR/9s12pl9Z7gKH5ltWTGsd2oKj4jmPXDji5HzqAP7tA4kyg/dvVnhK1hvDAJMpLblDTp83QguexDw4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/osJevSHTC17JuCf2qfRlrHSb2CuHhp+cCuHA8CpRPE=;
 b=BJku97IWqnWzkr6oLrataVpNcAebUT2fgemi91e+T/QpTEEheg1n1WWCNSGNsZyPv98YKveG1+2v0AyA09CkEa0urd/ZyOEfKO4fd5K63iOmW6OjKsnzY+Jl4l115bvhyafbSbFD2HOK0AEGAWw5tSwhDJlWW11oMb3KNldGcXMXfjvfJ+97noIfXsNV6v3Zq3xUI8+VlBC/s7Pxk86Zpd3k6T6ksu62vOudHx9Z08NUSUCPzDU//MaMz1ayhVvGfXXhr3iAKNJS/tUUBqms+Uxkvf5YnBoCaSMYUQ1RLKPjs6biYItl1RFcAaOIbHXnEPEY4DfJSa68cFxS2f2HTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/osJevSHTC17JuCf2qfRlrHSb2CuHhp+cCuHA8CpRPE=;
 b=iKRLjeCop+qmC+1/F99AwTvDi/oaxvJ4WEECvU/u9e6iBBSFJ+/v10U/fqQdmtTx7demHd6cVLDdV6E6QXeK4Bg7rwmLXVOmwKde7lulMGJ8UFLb35+mo3bLAXiz+nZcDhEG5eUvfExPjT0sqkrD3QPegOUu1bE08Vho67RIcuLW7xEThFFKu7B+QoFEE01BX5Qa8C2dtvxMSltAyQZzMqqQZ28j58ZQ0A2G3Lye7aFsP7wmJgNJw5y1Mv7Q1ICNkz0oxpPhS7mI7KX/J9MwtA3WtVOl2QgMsy1lUZMMp88p0FCkNLNYYx6bx+5Rm9f/CT5Tj+E9pcmbP4kNRvmIMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 05:47:03 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 05:47:02 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,  davem@davemloft.net,
  kuba@kernel.org,  pabeni@redhat.com,  edumazet@google.com,
  netdev@vger.kernel.org,  Alessio Igor Bogani <alessio.bogani@elettra.eu>,
  richardcochran@gmail.com,  Pucha Himasekhar Reddy
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 1/2] igb: Stop PTP related workqueues if aren't
 necessary
References: <20230810175410.1964221-1-anthony.l.nguyen@intel.com>
	<20230810175410.1964221-2-anthony.l.nguyen@intel.com>
	<20230813090107.GE7707@unreal>
	<f8b9cd9e-651b-8488-5c4f-aacc03a3c9c8@intel.com>
	<20230815052301.GC22185@unreal>
Date: Mon, 14 Aug 2023 22:46:51 -0700
In-Reply-To: <20230815052301.GC22185@unreal> (Leon Romanovsky's message of
	"Tue, 15 Aug 2023 08:23:01 +0300")
Message-ID: <87leecsvqs.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::30) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9071a7a9-acfc-4f47-be34-08db9d530cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WDs5iiiO9F7UY+DPkAKEHmUU5zzvQ0AEpIUFCbgeLflJtVxDuVQukSqMeEpTtDasjGCtxIjhCQAR9jzpBaN7jp/00EoMMun/LF7JtA2HHrIvwDf6gRDXKbL9TEh3kBlulGQkQoKCgfmkuizUsC1ZlctWoUaFJhaCICCKKV8MorsPHbmQFewTiiNQyGnTdOuq49icdzvWvCR/MaefgegNAtMnHR6hp/99YdWkHqBPhg7Bdiif4wPBPuH9vsIclo+nl03viKmTaC4zQuT4UleWzrYN9ZzrZ/S2jcPgSFpL8BXgEmrIt4lsSuaM0xwh1R60W5ApK5GfMtGdEGuxHt5OtT+edNwCscqo9spVXx76Ulaa6R2tqxkiMx3GR25KLKcFl4b43w/9ByZQRxq9+HgXVyAa8HJ+KUclUBALB5PzpKgRALOzTNcHpNFA2R8IbaXGvCLt/OB5APCyS4Wyz/hAu8ZUaZHPRtI518q1V/kK1aov9J2zEnL6xxjPno8Qd2BILx+D6u/k135FY4WRFplRlO7S/CBfPe0RAso+LSVOOa0xlV0MFg3MYJDIgyp0l07E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(39860400002)(346002)(186006)(451199021)(1800799006)(4326008)(8936002)(6512007)(86362001)(478600001)(6506007)(8676002)(6486002)(316002)(54906003)(66946007)(41300700001)(66556008)(6666004)(53546011)(66476007)(6916009)(5660300002)(26005)(2616005)(36756003)(7416002)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SXpHduKkGo0PRO9rW38F2ADstkWlY967ev3HHu+6ctSpL69tZTQjj20aslNu?=
 =?us-ascii?Q?lD9HD5brdGO6rHGVcgay+H04Jw5nDISgkz12cbUp/SzYtVSJYrF/dA2rKcLl?=
 =?us-ascii?Q?O4EnDA/fj5ASiEvgMToWIiqI3ubLNA8d8tsrGDxxeSTuHQr8F9TfvzmnZrAs?=
 =?us-ascii?Q?n4ZU0cCdVHeAkWq8Gr4BBVSLaJNkXgOJdY1v4K7UW2N02pMM4BT8Hl1sqpfC?=
 =?us-ascii?Q?dsS1q52rHW5nWwrzymancOD/YfZ6IuY/tNfOBE0Mm1cJc2ZOCPXEERQbShg/?=
 =?us-ascii?Q?q8H8xacEtIngfUS9ZEuVmSOgUQm9R/t3wQjiIUV/zptm96KE0NINGDFEu5V7?=
 =?us-ascii?Q?sm+ESQtZ9gZH6qXAqdBPq3NDdLA9lxmlKCLt+ZUyfXx9C30Z8/rVxuk0Z2kF?=
 =?us-ascii?Q?MnXASRjdIjbd6cvPyqXq7BVjjxNof5xTFqjJDxvslT4RmawaZ4150AOeeA8k?=
 =?us-ascii?Q?SqPQwVodeobLD5AQL7kl5mxq9utSNHw7Bt/4xFvYvlfn2cF8XC3qMEDeEXEQ?=
 =?us-ascii?Q?q9+8h8horEjwKhSE70sLUT7oVslqowlSd3pWA13Nan9A0A9uOqeJ9Ti/0u/v?=
 =?us-ascii?Q?ltN1pUpgSXPdIks9kXgLUFPRB1lT5Jhfmb3CE2t8SAfgGTqegIWC6Jg70k+y?=
 =?us-ascii?Q?uPve7l33HjIGq+YEbFYKG9OXxJJ2tQ5/b5e0ojADHIdS3xgbBWeTtFndpqf4?=
 =?us-ascii?Q?ExKxHRoqTZcLInjvirjnDWic5jWANr4yXW25m8qGADIZy0L862vSDAiOBDid?=
 =?us-ascii?Q?BEhoBVgMgKc6R3kuSnpjW3KKMX1jXd2w/Isz4tjlu6BLi5hLlcKR0vlqO+in?=
 =?us-ascii?Q?SIXcrhKfmafrgp8/qH3Q8uO4xbZqLnFMfSoRVq6vE3/Zv607yKUFOtPm581e?=
 =?us-ascii?Q?1UKvq0Mn3eCwpPM4TVCpAQv6I5HHQXbOguIfFLEG5d30whFRy0vpU0CsoKVl?=
 =?us-ascii?Q?Snl+TIud5VV7Xdlef6HE/XkPVBJlGm8GY9zxq1JRqiwuODQx3sQFBMNFLT8m?=
 =?us-ascii?Q?JE94yK7e+fz1V1qO3u8wLsTEyWHlybkbP6Fv9NVhb0KKMs2atU+xg3RXUJNs?=
 =?us-ascii?Q?g+SOTVT9VwH2r+XVBXkBpnRccTgWYM05uhJcpcqnbxCgziDSMJe8M1oQRw0Q?=
 =?us-ascii?Q?jZWujEN8PJGI+hC8mwBgnBXRltFXxETYDFJtYWu696dqL9lHejVZecCM0hvp?=
 =?us-ascii?Q?vO2KAXPClGd0ua/TTeiwJQtMM73XNgonO/YA+56bjdykYuV7236CUV1E8Y/V?=
 =?us-ascii?Q?0K0AoHOcXTsW/SBjUgekgAZ+yP8wipdRJ6k4dXcz7nY0JgYPCZMKZg5n3KCs?=
 =?us-ascii?Q?TeAd3MPa2mL3yOV8g1vJzvP/A5qnMl+UUlgdQ5D+TD2ZEic+2OevlaP8b7oC?=
 =?us-ascii?Q?FivOMft1cDyfkHcuJUrdkb9+dAtNlwiDPGNhQr0FZBsI7R7ReKGPsWrn1JWW?=
 =?us-ascii?Q?jxBBxfs6qvR1S2OkwBumdTWc/LGKAogGrLN5R9EG0AjBpwwC1Jc0hTkvI/l3?=
 =?us-ascii?Q?PXs32K7hQPK9Hlgjw5MxpIs/hzf3161kBt0lLd3sn5sGvYCrmeVZIvRkNl1J?=
 =?us-ascii?Q?lstDmdqqZ1ZML0fxGR0iTlxYlvbPcKg2ZjrlzyN51ntT5ZMGtS4CShCaNnql?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9071a7a9-acfc-4f47-be34-08db9d530cbb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 05:47:02.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8wD05q0+rbWfhBY05YelZbr7FtysMeg+Py1/xm3X6zDUa2IXYnpAZgg5jejEldgClMiXktpmtq+mn9jaiztaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 15 Aug, 2023 08:23:01 +0300 Leon Romanovsky <leon@kernel.org> wrote:
> On Mon, Aug 14, 2023 at 03:16:05PM -0700, Tony Nguyen wrote:
>> 
>> 
>> On 8/13/2023 2:01 AM, Leon Romanovsky wrote:
>> > On Thu, Aug 10, 2023 at 10:54:09AM -0700, Tony Nguyen wrote:
>> > > From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
>> > > 
>> > > The workqueues ptp_tx_work and ptp_overflow_work are unconditionally allocated
>> > > by igb_ptp_init(). Stop them if aren't necessary (ptp_clock_register() fails
>> > > and CONFIG_PTP is disabled).
>> > > 
>> > > Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
>> > > Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> > > ---
>> > >   drivers/net/ethernet/intel/igb/igb_ptp.c | 6 ++++++
>> > >   1 file changed, 6 insertions(+)
>> > > 
>> > > diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
>> > > index 405886ee5261..02276c922ac0 100644
>> > > --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
>> > > +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
>> > > @@ -1406,7 +1406,13 @@ void igb_ptp_init(struct igb_adapter *adapter)
>> > >   		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
>> > >   			 adapter->netdev->name);
>> > >   		adapter->ptp_flags |= IGB_PTP_ENABLED;
>> > > +		return;
>> > >   	}
>> > > +
>> > > +	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
>> > > +		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
>> > > +
>> > > +	cancel_work_sync(&adapter->ptp_tx_work);
>> > 
>> > Is it possible to move work initialization to be after call to ptp_clock_register()?
>> 
>> I'm under the impression that everything should be ready to go before
>> calling ptp_clock_register() so we shouldn't register until the workqueues
>> are set up.
>
> I honestly don't know.
>
> Thanks

I do not think it's an issue for the work initialization to be after the
call to ptp_clock_register after taking a quick read.

ptp_clock_register essentially sets up the needed infrastructure for the
ptp hardware clock (PHC) and exposes the hardware clock to the
userspace. None of the PHC operations seem to depend on scheduling work
related to the ptp_tx_work and ptp_overflow_work work_struct instances
from what I can tell. Essentially, the only case this order would matter
is if any of the adapter->ptp_caps operation callbacks depends on
scheduling related work. From what I can tell, this is not the case in
the igb driver.

>
>> 
>> Thanks,
>> Tony
>> 
>> > diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
>> > index 405886ee5261..56fd2b0fe70c 100644
>> > --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
>> > +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
>> > @@ -1386,11 +1386,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
>> >          }
>> >          spin_lock_init(&adapter->tmreg_lock);
>> > -       INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
>> > -
>> > -       if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
>> > -               INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
>> > -                                 igb_ptp_overflow_check);
>> >          adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
>> >          adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
>> > @@ -1407,6 +1402,15 @@ void igb_ptp_init(struct igb_adapter *adapter)
>> >                           adapter->netdev->name);
>> >                  adapter->ptp_flags |= IGB_PTP_ENABLED;
>> >          }
>> > +
>> > +       if (!adapter->ptp_clock)
>> > +               return;
>> > +
>> > +       INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
>> > +
>> > +       if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
>> > +               INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
>> > +                                 igb_ptp_overflow_check);
>> >   }
>> >   /**
>> > 
>> > 
>> > 
>> > 
>> > >   }
>> > >   /**
>> > > -- 
>> > > 2.38.1
>> > > 
>> > > 

--
Thanks,

Rahul Rameshbabu

