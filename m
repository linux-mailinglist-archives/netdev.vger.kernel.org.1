Return-Path: <netdev+bounces-25529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D79577473C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568BE2816FA
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2228615AC1;
	Tue,  8 Aug 2023 19:12:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ADE13FF5
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:12:15 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7947E1DD00
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe/764FSNBIdY+jtSxMtAi0vMkUCEgqyhvoQO0HJgAwkY24rKQUKPekFpekVQFTj3i2SjbgKo4nZvQpWNFWc3yl7mz8EQt9LAvzE4FYc0hrO5C8brtX3UyxW1Hc0V2IzkrWMnMKmXkL1qv+N35CK+y8xNbRq2m/upw3uuWA2lDBgdp7PmUH8EOEecNicBrRGURe5DHlh3EbR9VWYotIwE8ylz/wUWGlWQwu5OMKLHmnep4hMXoLNumwxNXUayUpfuvWqQbVV3KLjueTMHGD1qFo+dvIQ6RvNkq/o1oGf6hEsuMwgQCubBv8QaZQaNqfC8KelHkP3Rkd+1CeBpZpYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvIjigsvBMHS4Lw2EpApJNMcWFWcoMUUPd7On6iFYDA=;
 b=PylZYHLBf6lGqaZSZEUD+pu0/YSOZVo/ixD0HRkMKumXr3mOyT3kGyGgMFUzDfz6op63NhPNjHqyuEiNcJEnre2a0luBjkpr7/9Vmm5KamEH5vvqP9ym+QSSQFBgJ3IZKDF4mDXonvXNhrWeuTLOaJTF1gFcFmyqfsv/7arENlGFupFp38sikqQv5S4PMzHnGoyyy05xkfZkVtcROgSA7KQiJnMB+GLgfKpBe3J4FGkC+kGSKqd9HRo6u8+2DFD39dAvE3v4xtlilbgEJ30UQ1DKv9Aq+p2UjgOuTRhk9U1TaSjh0LOyVL6C/TMILvGrhoF3ShH6xtBkNP3i5n9D0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvIjigsvBMHS4Lw2EpApJNMcWFWcoMUUPd7On6iFYDA=;
 b=BhyH6UtEo2BWYBMc9zg0B1QE+KbfQKiy1+MKYTERvx62i0lXpiyzfKf2kLmRRdY1XSPTXiXF2M1w3qd0lYuO8fQU6IYWlXGKMQvvk+PGbQqaH05/2X847x+HoQ3NAda3g4YluBorPEixDf3O7ghEL+P54715+K7x6KEtbHrAnnGi4MXGM7KgCXU678LYhRZrqG22gdS8I0U1gwegBieQZ6X1Oa6jyqJLGL5qRMu5ZzcektwMCMZTyivZEfNyMehClNTdHpayNj+tZgABKkh/59D93okSsfZT5nt+V+/U1UbNxHoEfOaSCAIUvvErFzNcqAvw74FfFdTSUOEzVzUzcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 18:59:05 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec%5]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 18:59:05 +0000
Date: Tue, 8 Aug 2023 14:59:00 -0400
From: Benjamin Poirier <bpoirier@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: Thomas Haller <thaller@redhat.com>, nicolas.dichtel@6wind.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZNKQdLAXgfVQxtxP@d3>
References: <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1>
 <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1>
 <20230725093617.44887eb1@hermes.local>
 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
 <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
 <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org>
X-ClientProxiedBy: YQBPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::11) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BN9PR12MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 572d9e78-0999-47e4-4557-08db98418991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lAbmQ5cynCaP3zmMlGnOZnFltULoa94d9Nf1lDrmBVSW/6CaXuea76k3MBlyjWF8AvOJEAnINsH/BnNRUbCZFqIfLuwR+DToB0YBD5gGjIX7p/RcXxhJolD49XF2qzo6941A1BzzGGDycBQDpEKi5MMqj+yNZ0xB94/UrKG6gEkOzmAafh/7SCNuIgsDp21/jXg/DpWCvMDUJPzTLCRnVEEoQ3z73KNagSFQv/G4zfoFVHiaE1rpKe+EjOgOMbGPbkHn8HejhRkHIDU9JxuAhByFQRt26hkBiPq0ppWqNiPCNEEgOFJHdvwoUbzWDjh7HWgJxGQB24/nhzlI+SrYj1baNCpMT/1OyfF6LUlA2/v++14KQVwaforZQvaxTKbEiogp1DuSZKbq4L8Vyjvu/CN1wgzhZU58Q41sVOLw8J3eDZu6d9V6g+WmQkoQIx/ISuyCLvrmHzDqKmG6e9QOBPoljquJNDQI9tm9TfPMzotpllzQtRnRTmEbJ13p9Hd0EFZUWT4UdtLahDSFUlu6egiOFR8IcM+/71TyUMQBLWEvLTEpNgzTcLJvGj3gAE886rNDk8QmYOH0z0o5TPSm63YB9kgNMqB6W7ztDpZdZVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(1800799003)(186006)(451199021)(26005)(8936002)(2906002)(5660300002)(7416002)(83380400001)(41300700001)(8676002)(6916009)(316002)(38100700002)(53546011)(478600001)(6506007)(54906003)(33716001)(6486002)(66556008)(66476007)(6666004)(86362001)(66946007)(6512007)(4326008)(9686003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejF2dHdSMUc3Z2QxMU9zaEs2b0s2dGJSV2JTcENwdmZmaEF0anZVMUtwQnFk?=
 =?utf-8?B?YWJ3N1JzRWNrREszTEo2OFc0eVZLOVdzaU5vQTdlS3NTQ05WVkxKNG94ei9R?=
 =?utf-8?B?Y2JFTG1zeVpQWEVna0NsMlpUR2RuRWhCc292OGV2dXFlUTNXc0JoTC96OHd1?=
 =?utf-8?B?TUhOSU40TnVYWlZxVkF6WmFCL2pFUTVnQ2lnNy9OblBUNUhrMUs0ci85ZUJS?=
 =?utf-8?B?VWthUzQ4VjlHMDFCTHJheVg2UTFydTlMNDdWa0U3WFJpRnRnemJQaU5qdW1Y?=
 =?utf-8?B?UlU2VnFVdEI0Z0FYaE9SRlBKdVhzR2d2Q1p2c0V3YVVTY3VsdG85UVpMcDNy?=
 =?utf-8?B?aFY5MDF2bnJMQjZnMXlLQU1qcGJiVGVDVzhGSFFIMFdjdEhPQjNEVklBSHpP?=
 =?utf-8?B?R2FTbDJ3eHl2U1kwRFRVT25UQWUvQUpJMFIrZUpOY3dDc0M5bU1tZTR3VGhP?=
 =?utf-8?B?WFZnR2dtZXJicGhIaUg1c2FhNDkwQnpSTkxpTFZOSXdVYmh0WUhLUW1GbGhE?=
 =?utf-8?B?OEYwM1J1UE0zQ3N0Smp0QUJUU2JiSXRUcFpvRis4UzhxQzRkUkNtU0ROK0RE?=
 =?utf-8?B?bWFFODJhMG1TUXJwWUxTZGhPUm1qQStGU1MvTHRNNUdZZGJOQjRyMnA5UWc4?=
 =?utf-8?B?SUY4ZDBUN2JXUkhvem9tcmlWaEpVOEw3TUZGWDM2Z3laQ3djSEU2M0FUR2Vu?=
 =?utf-8?B?MGVFUnYwMXhsWDh4YWozM2ZYT082enA3djdjY3NBNGFrajNYRklTMS8zRlRx?=
 =?utf-8?B?TEd1UzBzR2cwSSs2OEZlQ0svbFpCMkIzWGlLNkRWbFU4NlNUcmgySlV5MnhY?=
 =?utf-8?B?SFVOb2tOK21VSmFiVEUwVTBxazRYY3A3d0NZcTl0amxHdXE3SUUveUM0TUQw?=
 =?utf-8?B?K1JWYkxOd29YY29ZUjQxMnFiZEdXTFUvMnlLbzdiVWZ6MGFnZVlOb2drcFRK?=
 =?utf-8?B?ZTlPSWIyTUR5dWtBSHoyOWpLKzVtSEF5dVpRdVJuVUR5YnpybExHeGsrSjNl?=
 =?utf-8?B?TThwU2dDMGR5YzFoNXpCTExxM09uNFAwdWZhVUNzakhiZEdsYVhSTkcwK2gy?=
 =?utf-8?B?UlUvWnE0Tnpmek5yUXcwMDE4TG10TVMzWjNldGg1QVNaaGRJYTk1WTlGT003?=
 =?utf-8?B?RXFqamxaM09hZUtMSk8vdGE5eTU0bmZTSm9pQzZSeVdKRzRnS0lOUWVqVGFW?=
 =?utf-8?B?cWdnRHJJSU5ZTVdFMVczbkxnZTBpa0lPS3dEWWQvUklNbjcrYnVRdzVpZWN5?=
 =?utf-8?B?QkN0UFdENk5rSHRRZTAvZVpCYnFuT0FVaFNwREIxaGJhaEUrdXhUdTlOb09W?=
 =?utf-8?B?Q1dtL3ppRGEvTmJFYzZYSXB4cXpEei9DbjdFVmRZMUtobGpQTlpISnlFWHVE?=
 =?utf-8?B?eGxsaGh1d3haUVVFN2d3Rklhc3dDOGRSRUNLS3R5c2tsQ3JvMGY0U0ZWQ0Z2?=
 =?utf-8?B?NEhNNzQrN0t4M3paZEIwKzFodTAzK1k4b2VIc2VhWHpyZHUzdmsxT3d3Ymsz?=
 =?utf-8?B?RE9yekZCWjB5S0U0WGxDQ1QxbmdvdjlFZTJpOU9mc2RCSHZnNDk5U1VoNzRk?=
 =?utf-8?B?RjV2S09GVkV6ckN1ZCtEQ1BBNXd4OHRoR2hpZEcyZ2RRUkpjeUpPalczcHpD?=
 =?utf-8?B?ZnVPM2UxMjN4NS9lRkRLVXRybFpCYmxpY0lUbG1HR1RMWm4wM1lkdzgxUytY?=
 =?utf-8?B?VWY4RGhNMjdSbzl2Mk5UVG5BWUZVejJwb3FabFJEN1FGWkZOVzU1MTVtVWRV?=
 =?utf-8?B?QVNLd1lmYWhkZlY5eVdIR2VZblE5U1dhR1F5dmxjbmZBaHh3U2dZK0J4WDcx?=
 =?utf-8?B?ODlCQnRMZlpVbzJQeXVFeXdsUlVTdmxUUGNyTytXQk52UktGSVQ2OU94K0FT?=
 =?utf-8?B?bEtXK2pUWWlDUW1rVlpHZ0VFVC9hNzlleStDbXFhbzVoQk1mUCtTczlObHRV?=
 =?utf-8?B?ZDlydTVVc3ZLVWE4VUkvZmNlNU5GZHVXQ2p0VU1CT0tYVzhNZlhNN0hJajNx?=
 =?utf-8?B?bEdYMUZGTEozcytCV3VqYWh6d0lxNko2QjdEUk8xdWVqZVNnZ0g1L2hZNWJZ?=
 =?utf-8?B?cEdhNzR5VlFTTG5UWUJQMi9xZnEwRGJyK2FsazZLWm5YeTN0akI5azZ0UHhp?=
 =?utf-8?Q?pF9u2ynQmT4kxGD286+tvArtL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572d9e78-0999-47e4-4557-08db98418991
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 18:59:05.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8u67Od17Ovhh2eNgMMUmMYVURUTyCwS3tqap8GeRPDu9cGX8nz+iuIuo+vdvBVxUbpk950i2XzU5RD1sGlioFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-07 19:44 -0600, David Ahern wrote:
> On 8/2/23 3:10 AM, Thomas Haller wrote:
> > On Fri, 2023-07-28 at 09:42 -0600, David Ahern wrote:
> >> On 7/28/23 7:01 AM, Nicolas Dichtel wrote:
> >>
> >>> Managing a cache with this is not so obvious 😉
> >>
> >>
> >> FRR works well with Linux at this point, 
> > 
> > Interesting. Do you have a bit more information?
> > 
> >> and libnl's caching was updated
> >> ad fixed by folks from Cumulus Networks so it should be a good too.
> > 
> > 
> > Which "libnl" do you mean?
> 
> yes. https://github.com/thom311/libnl.git
> 
> > 
> > Route caching in libnl3 upstream is very broken (which I am to blame
> > for, as I am the maintainer).
> > 
> 
> as someone who sent in patches it worked for all of Cumulus' uses cases
> around 2018-2019 time frame. Can't speak for the status today.
> 

Nowadays Cumulus still relies on an OOT kernel patch almost identical to
Hangbin's.

Looking through an old ticket on the subject, I can see you had indeed
prepared patches to make Cumulus' libnl-using application (switchd)
delete route entries from the libnl cache based on link down events.
Ultimately, those changes were left on the table for two reasons:
1) This would've been the first time for Cumulus that the libnl cache
would be modified by the application instead of in response to netlink
events. Roopa was concerned that there might be race conditions.
2) There was an expectation at the time that Cumulus would move to
switchdev, which would've made switchd and libnl unnecessary.

I brought up the removal of this OOT kernel patch again a few months ago
but there was not enough interest internally. In fact, I was just asked
to add *more* notifications for a similar case, sigh.

