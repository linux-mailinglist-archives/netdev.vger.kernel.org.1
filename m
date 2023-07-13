Return-Path: <netdev+bounces-17567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9304775210A
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0446A1C21358
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BDF125C0;
	Thu, 13 Jul 2023 12:18:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32413ACE
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:18:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2AD2694
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS47z93NQm31Kx2uqJZDSqrERDROJfEBYnFFtNBoHv8g0dutM+s527XqfT4m3/4Lk2rIifPmFNwgqq0+5EBIRopLfV0dGs0LyISuI7DW865HLECPrAMgYttfg00+TOTYbGVoOZfQXDB1gl5XCSVJ1GbtcVnYMynwPNlaXSBtkUp6zK7XkoO9Q7vymKoWtaTU8gJ+ZHPAuvwkGVctV4dVAkmWJiqUa8ruUjgJEGUf4K5nrVQs6QnHl6H5RdpnRvxlu5BheVSGr6PjqopNN/Z38wjGiSgIwf1aLvsU7vrNHCJJu0hgcE44P3JX21GmWNXj43jHwvQmhwW2xMVnFpOMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvjmjsjazhwWd3w4ci0nFAwilzX3RcJKg14Yf59WSOU=;
 b=InxZlP57XvRU1n/fbjRSvmAFu/SPN9qIuLivwEvtALe6HXpbAWlqQDMHTRokWsG4lGET2JDqazRg//Ir//yrMIaFVLk4dLEqRmDd/cTIMhb++wiQVIxUnJN/ykgo7MSfHNzRl8PIsuz5SMzt0OJpyaN+C9sEI90Nrm//PmgjFR9HAIOg1i6AZJ0pSFi7kwjupBSAB7wZGnFOZWlsc6VE+CLlr/GHN+rny+HH2Rcx8ZCo6hRVTILTePDx4Pd4LQVPts4JTpIdGyC0+bqwKc+HIukArpC5kkDgtHOVKkwXTdcoChOfMVfPMHg09yGC6gjtLv2R8udRCNAUG7cBXZQs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvjmjsjazhwWd3w4ci0nFAwilzX3RcJKg14Yf59WSOU=;
 b=TsYBsdDAlBEZequeMsNZBok27Ynt3tP1zqDhm8hFfse+ATrWluNB5vVhNuh367/V/R15/PkqFYLLUQzxXewCAp4IXknbaQbPV4PdbG8Ev1HDwadEpSdcyGhasZYnrQT10O6wBiT+YF8+W1gWSs9my2AlKNer0hjEIMCItu8cwvpH/gdGFyH/W2I/o8gvL7SHsdutUVRj00xaQ21YT2Lt1AEvDOVwe/Vd/t0Grwv7IjNmlCBIqOuXQuKBWWzur+7qSdTRuXGCBB1epA1fCeQfv59Rt1oQNQoo+J4cpKp62Z7pHS2DPRiDseKlkJinaNOYPxwvRkqU7D4BwAyytdQ+Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:18:35 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::3aad:bfe2:42fb:705f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::3aad:bfe2:42fb:705f%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 12:18:35 +0000
Date: Thu, 13 Jul 2023 15:18:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, moshe@nvidia.com
Subject: Re: [patch net-next v2] devlink: remove reload failed checks in
 params get/set callbacks
Message-ID: <ZK/rlALBlXUELycx@shredder>
References: <20230713094419.2534581-1-jiri@resnulli.us>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713094419.2534581-1-jiri@resnulli.us>
X-ClientProxiedBy: VE1PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:803:104::33) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f664aff-e6f1-46dd-e64f-08db839b4814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9dYMMABDNXHtcIo4Tyoeem9moDvhGwJ4jEnpni13oE7IBpmYjot7Q4LMs+8Q/8kZRCEWW57J8CmyQpeiGtqu8i/LXKP3OBkBCaxG+6dHQM3PKQkoU1OdxWGpdGODbv0YPETwBKiIOKFrPy+07y55YKLyFmYCOXD3Sgf+kqz2qecYdPFDvBWAcrVw5Ykbmx54YJtfPn23jmESv5dmRGipsn6fJ6lIK4fY10MliJuuMScBWXSgZ76WNdPPs2JqBdMZLxO5kVLdHTKbbIPY0X0TdN2H1xpooqh/q1b6jnJaERTQuCcO4xORzDEUgwBP/gSpeNhTLNcWkVAFoq1yiqjb7CGVIR5a1VvRxPj1wPYl5OD2MDhouavVIq26VAPHD/vRBxwpgaXovK1i+DC5ywyRiLUBlDLofjysfEqFpSxUgyMU/ngPVVCOESiBKXvH6wbcf3zJpYRlYYYt6Fu2zJI6Xe+Jj50SuGgXO2MHIjmakx784D8ad9Pfe144WGSoa2qjagOXWtvDlkOZEVthTYg0PYtuAgqqXwtyKscudE5Wg6mAIdUtEP7SPTDAo/QDFqct
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(6486002)(6512007)(6666004)(186003)(6506007)(9686003)(83380400001)(26005)(86362001)(38100700002)(33716001)(107886003)(4326008)(6916009)(66476007)(66946007)(66556008)(2906002)(41300700001)(316002)(8936002)(8676002)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Jg+HLCWywlwaIbn9efwOmRBR29MhdgWa/NM1uNfBjCwgQLAf1ol2CXhpgQl?=
 =?us-ascii?Q?C1ZKiOOVqRdW1pChhJc53tNca6lBhBtRYnkDllY4JyFfra6BA8D0d3GSwOMg?=
 =?us-ascii?Q?sl2u/d6/GCV31hg5D6kEOChMWqo6be9/bN9mYG50mrj4/uNrHmJxn6jYEUCH?=
 =?us-ascii?Q?RmCI7oB2lGIkUYyUjJw2+V9hgsKnNEr4FAXbMjHXdSH7Bl9EqH2+B8m0BAze?=
 =?us-ascii?Q?XsBkF3Gt2MPgGwAmIX53xm/ZV/U4pHjmF7Vlcn+C8WCqxOZaqeDr7pdf12/r?=
 =?us-ascii?Q?LbSABkDywa6Ah3T0PI63PVQ2wtAy+99pjat5YtB5vGAbAnVAB9iiFlpprlys?=
 =?us-ascii?Q?cg7CtB/T7gUb4HuvH8ETXBlj/bnxtjHUKBOU6aQ0H7epIeQXlB9QZqan9MEu?=
 =?us-ascii?Q?8gmwMpiTBh4l0IIArNqbTJCweoPM7D1pcXtoK4i2NeYUS0q40PqDZPUwGM3Y?=
 =?us-ascii?Q?byz8qMU2acbda2AHPRDUO/GJ2tX1vz7ObI/Y7sURr8gk2gbpyh2B7vOqGOmT?=
 =?us-ascii?Q?meWirXpQoypkJ377eJbAgMK4/T/bBUCv0yxbBfgy0+/aY/Vy0/Gv/5V/+IZx?=
 =?us-ascii?Q?9rQDWmVemt0lMnQMzw+TMKKcE2a+4wL5SPcTL1KbxK8iFLsCyNi5wH7MH4Vs?=
 =?us-ascii?Q?mPIY7JHV7QnT8tTEKVTNYUiui+yRMA+DPbLQMoaTEIOq4jSRvHNowHfgWeMR?=
 =?us-ascii?Q?83hxMA0w5ZbnuMkoIuLZE8a2JmC8Z/wscbJt7Zj6FGp5STkHTfQZWhmiyAL7?=
 =?us-ascii?Q?Vrfi/Nt5K1MDfki26OozgVOYZSkGcXni9bUbtgoADBS9udcXUuSpEpRR4KDE?=
 =?us-ascii?Q?V3pWt+Q3+E01xOk7pHc5dW/NVH5QO9Qm0tiO8Jazzwc5GD0lHwxrz3E67o0C?=
 =?us-ascii?Q?sOxYzMvA9XXu5LkNcBXeFH7q5zFoydXtprlzyXauZ0tQabyC3jF0a1ySkk5G?=
 =?us-ascii?Q?wvHEqeJ2OmG+dxrsJY7Y/eWX67g4J0hKwBMyG+XSuoyvE8bRrP49aVyAr5ur?=
 =?us-ascii?Q?AeTdaz2812i3l0dAphJ4uKc7qqbMCppIRS0D6WqkNS33ygWSMiWnbjdTbUsW?=
 =?us-ascii?Q?II/N0w9eL2FRD+JvFudY/QTPnx82FYsFQKjErgGjJZWGCaGyDLKkownMDt8R?=
 =?us-ascii?Q?COu1BuohOqxCW/pf1u5wc/R97rSPgeyN7EvnotKq3DJtMgzJk8sZ3dH3pt3U?=
 =?us-ascii?Q?6O6IVoI50pJSB5mcdOY+VrCb3JrTCzyi4HtTUh5343MiqB9yEWMMC0rjrpa8?=
 =?us-ascii?Q?mJU3Ny49WYAUSCfuwirn5WY9yFCs1h4LL4rCZzTIdeducYA8nR8YJpmRPfhC?=
 =?us-ascii?Q?2eq+rNOsfFVtL+MIVOdZh51SUTymTdvNbWprc4PnWO7uNF+7CYyHUNUUQO22?=
 =?us-ascii?Q?jj8iv8IiZXOKkw+q5o+j0lzFXBCUO0ka4Vy7M/utxGbfXJKmtuw0Tf1UOoqF?=
 =?us-ascii?Q?vghzUf1TFlQp/MgVkFBrxhamQj2KsO39QPwguPlRSvAHpoFAXq+3E9z5dyz0?=
 =?us-ascii?Q?l84VNPerAA3hT5W4WsdmxcbMlJng6WEv84YTNIVPkBke9hNvjEURt+4rgh1V?=
 =?us-ascii?Q?cNCkB1DkBz1CA3n9Ohwt4E21ooetbva6UWlTwi1O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f664aff-e6f1-46dd-e64f-08db839b4814
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:18:35.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JchP9sMVMRUbtcCxsejzoihR3082i24uSLdQTLiGINDoM9ZX/FjURSSAFlSCX+0a8BQfWr+WA29GWdgQ3yQVAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 11:44:19AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The checks in question were introduced by:
> commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
> That fixed an issue of reload with mlxsw driver.
> 
> Back then, that was a valid fix, because there was a limitation
> in place that prevented drivers from registering/unregistering params
> when devlink instance was registered.
> 
> It was possible to do the fix differently by changing drivers to
> register/unregister params in appropriate places making sure the ops
> operate only on memory which is allocated and initialized. But that,
> as a dependency, would require to remove the limitation mentioned above.
> 
> Eventually, this limitation was lifted by:
> commit 1d18bb1a4ddd ("devlink: allow registering parameters after the instance")
> 
> Also, the alternative fix (which also fixed another issue) was done by:
> commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").
> 
> Therefore, the checks are no longer relevant. Each driver should make
> sure to have the params registered only when the memory the ops
> are working with is allocated and initialized.
> 
> So remove the checks.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

