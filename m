Return-Path: <netdev+bounces-60506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E591E81FA91
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 20:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59FC1C20FE9
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EFBFBF4;
	Thu, 28 Dec 2023 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MfQxc0fi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE9F9E9
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kx9BptWfpKMmKtc03IJGx9vO7yxoYRIZLy245PmP6NuVcg3K0Z2eAVRrlaLjZk/6aT+60Ukt8NnQ63PGYDPjzmP+GfKEPOjKfmrpKeAdNumHGLpKfCkMzjwqzA3amRfazFx2jNtR6LtjnCKLEdBxrfGkA0BYkL4Pwoo63BYVFYiyV7Cpt8eROcxlY/aNJIcB2G9TKuHVQ6yXWlrBdibpyAmJwGTYQ1KoP63iCIL5f722OeEKsX/9X2naj6lff6kISuf8EgeFvI25TpMGa1lIqk8AUOo62F8awkZJXdlSRLmYPIJBwOd2UiICcIN9acrTb8S90lP51TFPgFvjgwZZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNAoiCS7Nz9+Heylc5486mdJChR7op+LNVBJ3n/JICQ=;
 b=ndUGhFdU9Jml/qqPDPQa9p3fcHg1NyN9+JXxWHfA3u4cmnDYlL76VHE3sEplq6eChoMA/FwD8aOLsR33UlvQIsrz8mB1ZpwMFl9RkwSoFSjPM6ESrYI+bTRrWSX41xih6GUAmRrGw2tFANz1BTyG257Nml06S1TjxTgOWgEolz5oJVjLYYF3KHhS41+Ka4PjpKr2fv/iamo+Csi8vJW3yh65a01nDXqn8ZB1+a8Pgoc0L55VChW+lpWxQKDORCsRMm5yIoLu/5urVV0RVBxrGSL/vVGwrUg3jwQv6fUEXIIRoV1hvNCMtj4Pr38623zWO7kiY+yP/n/AYdi4KbZipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNAoiCS7Nz9+Heylc5486mdJChR7op+LNVBJ3n/JICQ=;
 b=MfQxc0fidXMOxmHRdoxRjNdGMP3PPyV68R6wMBm+TEtlSne/+pR2PqKmOnuqNS9Q7/QUNO7T/oFseZDvzzyeyiarl4J/fDUtuGXBoRgbEVVGyS0xo6sYAla0gSx0LWGyiY72l4jTZjSSuzWFKVtkO0IP/+/8GWJK9MKdddAOZngyV7oSxJuvbGAvVfr/pdcRJgsSFDeXmOE1ELjUFm5KZXT5gaI4/m8+KBRuKTlwBS1bFtRIjg6YChMYwRJZJ3xhkJLK+vfhzpKaK9YGsHM2H9n+0K44tPHICRI8HzYbFQCEk9w5XGTVeA9kOGwZMzk7tru71XjGlDquntMhmSYg6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 19:07:16 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 19:07:16 +0000
Date: Thu, 28 Dec 2023 14:07:13 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [RFC PATCH net-next 04/10] selftests: forwarding: Simplify
 forwarding.config import logic
Message-ID: <ZY3HYWBFsiQ9x_Ox@d3>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-5-bpoirier@nvidia.com>
 <20231222135836.992841-5-bpoirier@nvidia.com>
 <20231227192758.iq3s4mirkf2dm5mj@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227192758.iq3s4mirkf2dm5mj@skbuf>
X-ClientProxiedBy: YQBPR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::20) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: f386f333-3f1e-4170-059e-08dc07d834c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n2kHG2LLzYfBe7H+PdAfXwaX4SmKGwONQYIPfQdgUkkkz7JA/qRm4xLZzsK8GIN/U6DVSyvv9Zx2rj/ZO36seZHWevi1HEHxVLLW8OXBCEjRmxZWoVtUX4wadUwHP0JEsToHzxcawEJ4xScOQsgX9MW4KLdACpo5Nh636ldbDktfAExsW3z/KgmlUlw2e9LucoIVenpFP/QJUKBchrwlDk/d+wczjE1rvxfE+w7uxdPN8Bdn5+fNGDih0aXFzfQqzq87XNeGDVttl7JSZaUt482NkgNA36B6+vv876GgCCvBuXe7Q3b+8+YySmwt1V5PLIErofT4hiSaDHTPZaVxR6tsFpnnofj/AFvMrIBe0l2Qk2hyAnzrZq5IuOCs1jsfe+5Yqku3sza0B7/JpSVDFwDSyGsoe+Gwd3/LfCqjf/HL2nNLWpbXMIKRhsyw0YSy1qOKo4f4AmcGPlmZO889cZ98BfHU70gXGP25e1cJ8j0+rjZc009j4v+2FlGp765vGCO/fj6Fw57zjvfu3b2WZVBJ5JuYHQiO4akFl/7c+d/UYo54ML1iw1idiY5KHe04
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(33716001)(41300700001)(86362001)(6666004)(6486002)(478600001)(66946007)(54906003)(316002)(66476007)(66556008)(8676002)(6916009)(6512007)(8936002)(83380400001)(6506007)(53546011)(9686003)(26005)(5660300002)(4326008)(38100700002)(2906002)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ArOUDFhgNUToiKDHRfYSO59cYzm92jnAk61man90SDNccu2NaVFBmsgRjB64?=
 =?us-ascii?Q?TJpzy50Or3MQDmACLHa2aE5sC7iTnDMkJHweN9whQHjUxPcf9tq0MSLcrBhL?=
 =?us-ascii?Q?ecpdB7iKlUpjWXvzo3lUYA1ynnSxjkvjxg7MP5mAB5I26gGFWIEylHbWeU1Y?=
 =?us-ascii?Q?uqSuyKba79D/SM7FZaF8iaYKrxz+gHJu1aBEjraFSutrK9u0CLpXGBXI8x7B?=
 =?us-ascii?Q?iSuMZRAlI887LXE5TdDWGBV4JNubQ1E2rYzXH5CKfYNlANQbO5ca/r6fCv1E?=
 =?us-ascii?Q?CpYkVCHk4YmRCSHx3RWPP/3KMbq2gD3l+ww+HBHPxpONzUHV3iV8h0eDuc1G?=
 =?us-ascii?Q?X5i/E0ZyVUMo4hMH3rMuszl7xnZ3sG0AkUwSas9hEkjzdxOaIvCouBLBYMNY?=
 =?us-ascii?Q?3MkZet/H0Hq3cPlZ/91+RGQ/NjqB1sjE5ish6eZfB4sMlzhsvhEW5tJuKh8K?=
 =?us-ascii?Q?fT8dJuIe8wTAVVoY1hCEGly5oJGpmehImQdGHvHCcYJ/i4qWJ7z540qiEoNn?=
 =?us-ascii?Q?wdXBFo9UQ39/sYTOOA0sh/AlVJ6OFZjRgFXEme21Xk7+IjATMMdkRb0Cz7DU?=
 =?us-ascii?Q?FCz8kmdEeVVLJ0Bmh/hk7dwrr/1SnM878muDBtrS3aco2dJQwZoILuxo6jV7?=
 =?us-ascii?Q?jzvieTOQjvnAA9CwsnZA314rRCo4/H6RmoZBbxz7ww6P1cjMr4Yy529S7vzh?=
 =?us-ascii?Q?5Ub+oFx0RFWuYtWe+O9AXgXgWNZo9lanCJo84NkxHSI8GeAQYa82H6HQSGsN?=
 =?us-ascii?Q?UgUATgjK5eq3FmHf3d4kgKMlm7wFptOwTiWNYh4KY531ur7NMWoMEKjbqJhN?=
 =?us-ascii?Q?0VoxFsFYMk+B7iPZVDyhzN+aW8+zh8Q+5HMgGO4hZN6B0KsyRBHTXMtNOkdT?=
 =?us-ascii?Q?cj9RRLXPd0qCEg7KqjtI/Fku4Yicor477KvKRFMFHU1Wcx87IJWS0LNLgK0O?=
 =?us-ascii?Q?U9rDlmG2ohzz8gIHnjteg4k1qZwlFzRI18+Rhekv6D4wdNSib683leTJt+Tm?=
 =?us-ascii?Q?xrap4+E1DJvklvqK9oWHHgrtdUhKS+Uk7bod6WgI6rzb1QKQsw34F8ihjgzt?=
 =?us-ascii?Q?v2N4vU3V+KIuouZnClTJ4jOOJwcvgwx3itYeuVhFt4tcOSzQGc9FdMpz7Z0h?=
 =?us-ascii?Q?4QiPqIMdgSvnz2V81ut80Ks7HqYSFDmQQUJm5HjVDhi3N9ejgIsjMkBw3eS6?=
 =?us-ascii?Q?TtLDpO3BhMVOsQiegRcZsVV5NTAd2Gle9EUCWuXKHKmTjPP84dnOe2910b2H?=
 =?us-ascii?Q?FgNq2AeH7ujxEbXJppNCBgt1aMJLQJ2bVoWi6iZFrNE5i7IA1+hHdovNGTnf?=
 =?us-ascii?Q?Kw69j4h3LjfCI6zDGsjycb8hqIZrUrr9lH/KI/oRqw8aJgZ5wdIqmSdgagAu?=
 =?us-ascii?Q?aCPVOaANG5aq9DfGV5loTFvpcoqeDwgydjySbc0wwvahhSP6QEV8LpPtNsUf?=
 =?us-ascii?Q?uUBTBLpO5BmHPZ6oW4hMij4WVMCVRRNUbf4vShNtfm/ETKy1kdWyQJ4Jg+dL?=
 =?us-ascii?Q?tqWQRKwZryf7k6J/TqEX9y5a7zLLCXi1hVFH1E5i+iIsPEiIe7JbbeXltQ40?=
 =?us-ascii?Q?sP3z2ZoKLaMD6de/J/DTgqt1oNO2x4jIEPPiQQEp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f386f333-3f1e-4170-059e-08dc07d834c6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 19:07:16.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yav2TV98Ok+6hO51OBLnJJ583sxagfC3ScSyixCgF66hfHopw/4Q+6UdZBClMfk7YqDWbVYMUO7JXO3tdlZyGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

On 2023-12-27 21:27 +0200, Vladimir Oltean wrote:
> On Fri, Dec 22, 2023 at 08:58:30AM -0500, Benjamin Poirier wrote:
> > The first condition removed by this patch reimplements functionality that
> > is part of `dirname`:
> > $ dirname ""
> > .
> > 
> > Use the libdir variable introduced in the previous patch to import
> > forwarding.config without duplicating functionality.
> > 
> > Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> > ---
> >  tools/testing/selftests/net/forwarding/lib.sh | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index f9e32152f23d..481d9b655a40 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -29,16 +29,12 @@ STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
> >  TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
> >  TROUTE6=${TROUTE6:=traceroute6}
> >  
> > -relative_path="${BASH_SOURCE%/*}"
> > -if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
> > -	relative_path="."
> > -fi
> > -
> > -if [[ -f $relative_path/forwarding.config ]]; then
> > -	source "$relative_path/forwarding.config"
> > -fi
> > -
> >  libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
> > +
> > +if [ -f "$libdir"/forwarding.config ]; then
> > +       source "$libdir"/forwarding.config
> 
> Nitpick: this used to be indented with tabs, not spaces.

Thank you for pointing it out. I have fixed it.

> Also, any
> reason why only "$libdir" is quoted and not the full path, as before?

It's not necessary to quote "/forwarding.config" since it doesn't expand
or split, so I did not quote it. Also, the previous code was
inconsistent in its quoting.

