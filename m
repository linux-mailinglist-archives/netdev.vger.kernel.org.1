Return-Path: <netdev+bounces-60515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C83881FAC2
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 20:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB60C1F24DDD
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC7101EC;
	Thu, 28 Dec 2023 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o5XYquVt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19616101C8
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArWUsMgwMKweSsVRntK/Gp2B+JJSy5YUi4Fry9g+XIt1uj1LjKdNo3ZdPEe0nZ3C4EZ84TQBoDVzL51xCmDoB11f5AhVSc4qmthc2bDhZnQ9ivFRdmE3xuwJFEpZ+cJ76YTsxly2nMS++29JpoxQQ+Q6fd1QVjW70eoudjC+xICAJn/g0ZjU1G8/jhgiylR0EWSumXNJaqh385aVpdgvJ0rOsmmqWVYlZyRWfZFEpVt2JltV9e5GxicYCFXP3LTWm+BCK6tHqePpfynFiDw+zZmXfe1PBGmD2CbXj35WBlJnNyFrb6i0FU2g7Qy9y3+7aFqNkiWwJ+uDluN2gBKSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9Retu8PgDO+ZtZ+m+IUaO09CXUDGUDkfgRT7pK/lB0=;
 b=nEFCzZQiJ4PKtMVT/REIl0h15/wC/yCCbghWxw00gZJytGkqpG6cTlAyzLb+djlh5uUXXxai3XaIiG0VuU0j8WhxgV1fqsSWNXwmRnfSARgnPxOJp2kpL/HC0VL0mOry3wJWDlhfx/AGC7tJ61Zu7fODF14M113oer1XtJXGf9En56YHRNcCglxFaISoEUBF5aKH4E5hFRTuucmlCrvk485X2Kuiu8gfhYlpsJmpNwi+3BqloCROuexMxaToF1mlbOX4Nd7+ikgwhKFC0mGSwdaoUBlKqaMCZhsize0k+AJOeMhK6DOawvXTLr60hW0RGRS2riQHt5vHmpMU9EaZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9Retu8PgDO+ZtZ+m+IUaO09CXUDGUDkfgRT7pK/lB0=;
 b=o5XYquVtTuAZwrg6lIag1/xKPoyp+V2f+e4D5qwJcjVTyWON44g52k7UJoe7b+O2mxI+GxeVDxk2fgSCg9+ogZDcsm4qZ8D87aYeDD82Od/x183Z5Z0vj5QbJOYdSq78LsT53LwM3RMaOqy3qXWVxU/Jsqn+X9Q4KSQu9dXxkIZcMjrPlW/WUBW+/weeCY4aUPQNykjlNK8lSgfWPszSxZ/zPEfV27jxYNq99tw38/d0c4ivdup2/2wt8+UJ+W4/DWG1IMErU+1kOcMcL6C9Y+EquW4/L4nPQaKSNZ7PfO3T0ong8H0hYiZin9kexisM5hl2kyPW3YoagnMJs+uo3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Thu, 28 Dec
 2023 19:28:08 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 19:28:08 +0000
Date: Thu, 28 Dec 2023 14:28:06 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [RFC PATCH net-next 05/10] selftests: Introduce Makefile
 variable to list shared bash scripts
Message-ID: <ZY3MRl5Jtb08YotB@d3>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-6-bpoirier@nvidia.com>
 <20231222135836.992841-6-bpoirier@nvidia.com>
 <20231227194356.7g3aec3kujnk2qo2@skbuf>
 <20231227194700.zqhod5nbn6bibub3@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227194700.zqhod5nbn6bibub3@skbuf>
X-ClientProxiedBy: YQBPR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::39) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: d2697a88-56ce-46a4-d6c7-08dc07db1ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vj+stVBpT3IoV5peR5KoI3dtzDWpNt83Njc6ieV92BPQBmkrh+zR+V2D2VMKg24FzbMTeNNY7G3YmW3hdOCyfL66QwXCeIViS0/4uBY4RJ4sPTNph7jiPKKn8TkbvVfFQ9MpdbthGwuVDWKU/TzI21P8JwtikiijcOkeh0bRfmZWq6NGnd4mzz7MmnEDQZy/f4El/LoUm9WwTso0ITYN4Pwdj5jQFSaq0yjMAukkaQW2Ym/itwEaHL+1ajyK8Rr7zmyIpgdoXSVMU5W9Y+UoiX6gX3lPdk/8vVyCmNlgzbli3KPh2gLqXzlpMQtpTZhe8KVrRdg0UtxcSpSQseZ+pGW8dI58L9ErKB83MsfbDAvR24qDdFHx6yK+hdoC85otXf2VzRBeyWG2/QiJsQPl//qEBCaTfZOuENVYqYwpS55eQ173fWxJhmadLG62wEvcH08xzHWOWpi8B4hn0l2mlPxFoXClAd/nCwZwPjBi/momPBejk+FHuecRSU8bTM8Zv6spkl1Nhc3mo4OyjVYxGI96zfgi5n4/9BMXS5OY/5ulCsloV1n3pf7r6HDxbvUs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(86362001)(83380400001)(53546011)(38100700002)(9686003)(5660300002)(6512007)(6506007)(8936002)(6486002)(66946007)(54906003)(41300700001)(33716001)(4001150100001)(478600001)(8676002)(66476007)(6916009)(66556008)(316002)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eBfAtm06sivZoQyzIA1zjmE6hTd+c1Qr7GOawZC5asQ5kGz7JdTC8x6edDW+?=
 =?us-ascii?Q?MMlVBYbdL8d4z5us6EFnPLd5tlSVgf/Y8YV5T5W67IuT7Sib4hYPHGSIZuQA?=
 =?us-ascii?Q?2iE6fj6qEsaK39xPmoLDrNKJhg4M/YH8TDCg/0zWScvWyqir+j14lxf1f2rE?=
 =?us-ascii?Q?rXWFcPiEJfTqqdnSBu3q92PvCGy2884hM47qCWfwf6XxN+XYCR/EaxKs2MWI?=
 =?us-ascii?Q?LMMP7KVejsOUzvJG+ieDaSz2pKp+82Bcts8DMHeoTvA4zVSDmXKUdmCaoq57?=
 =?us-ascii?Q?AzbyvodtA7VpTzZRabfxtHLDMxXZuygU0YLGf/RgwATS7m1+HdeJDy4O7j/p?=
 =?us-ascii?Q?hv04qWnIkjtdx+gKfCB45UbIhIUKrzHIJB4KVzeoWHPi5/Fuu16g7KHeCBmB?=
 =?us-ascii?Q?TZjG31a69pBtlSu2oGwtolK9reGpZz6Bf2XYhho5fcvo51fEt1A8wYrrcq1p?=
 =?us-ascii?Q?NyjQ1ZqBLTMiQBZXuoYK58MX1+VvoP9wX63v3FNQduYhYkgAbETPfR111Y8v?=
 =?us-ascii?Q?cvUTPgHpjXr0hqfeHQsdRrhZqdmnuWZ744IGlu+x9tJ3X3UQXtLRSJkBCsCA?=
 =?us-ascii?Q?GmkY+tWsP2PX/7YDNwRbPMvy8OCGOEm73sSlI+Zg08mWer5CIcAHuwUcquv/?=
 =?us-ascii?Q?zKO4GCoB6cMmOsRhuZTjLQvsLJ2iUY24IRqEpm1RH3M6b4RPmrP0a2WJyqNL?=
 =?us-ascii?Q?GM2WnryzMgt3wF6dIA0PoDISV4xSdZ+Vt8NVAPRfxkL/9PkPi+DZxMqXiNuR?=
 =?us-ascii?Q?GBBViFisuOVznFXoGq59M1XpoCTMXqNEJhod4bz13PFM46qs+LQ0WTKh0yxz?=
 =?us-ascii?Q?1/bYHLIIWRnTg+grb6aidFuIt92qLrd7l8Sk1W9yT6B9wM5Y4b8taSVcPzkc?=
 =?us-ascii?Q?fyopqD2ItLEoOOTNALXE+emNbNHKo+JdSmF1RuDX9B4RIpvMwnyXjtNH6Y/u?=
 =?us-ascii?Q?oMmEJVr7K5EebwK0Y/B8L428bbL1LMhAS+qXnF6uIX/ZD2yL+xLg590Tgj2i?=
 =?us-ascii?Q?Xq5fxz8rqQfJabf4tfCxq2Cpm+UeO6wKleZpm/fiXwXlY7v36zMnMRtmH8mY?=
 =?us-ascii?Q?9XSrJFN6qHf3Ox5kaqhTFidlLjw05PiYwJ2/Lvx0TmuLKKU31X+SnNcAwaFV?=
 =?us-ascii?Q?XPw1ZJhTqGxH7gvi3LPr6A2Rk2/5PEfrS1uPUGeL3+NAC9P7q+yIojzuOq64?=
 =?us-ascii?Q?n7XXSPDCnkpvTZzQWiny0HG9Z8UvTNZOMO/dBcVaKl5YKM30hw6pIlfBSxuU?=
 =?us-ascii?Q?lEl0ziigmgUbkxPpgAoIX+dfwiDhVPbETtz943B3r3ra1owySY0UUykimqmI?=
 =?us-ascii?Q?K6gBzklJrLOW/Ru7ehDIO/9i29JVh9U3rmYGZyBrItqRdPas3687UveeEX14?=
 =?us-ascii?Q?I6eXcGxHvJK7Qmwqn+hXf7Yarlz9OLhrD9FiL5c8zAtB7cUEa/TQVxFF+6wS?=
 =?us-ascii?Q?UOE+uxLliiLeGXssm2AbK6i2p5iCVfTXlTU58i1b15N3L0qVlh31XDPKagRT?=
 =?us-ascii?Q?WFbIjgRBeB9AZqaVK5FziUQK3+Uj/DbBaCTuqXy7tqYGEcwwRSPz/sGUjxZh?=
 =?us-ascii?Q?DVzYrwub1oUSzP5o4+SIKVfOiioKK5jmriTuJ3mx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2697a88-56ce-46a4-d6c7-08dc07db1ed5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 19:28:07.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhDaFsNkVrv+PD5kJ0D8w1RNaV2Fe247Ay6SiCeECUp34ayJbvrBG94unKPj7PQ0fqNqAnrmlLuS6jXFblih+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

On 2023-12-27 21:47 +0200, Vladimir Oltean wrote:
> On Wed, Dec 27, 2023 at 09:43:56PM +0200, Vladimir Oltean wrote:
> > On Fri, Dec 22, 2023 at 08:58:31AM -0500, Benjamin Poirier wrote:
> > > diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> > > index ab376b316c36..8b79843ca514 100644
> > > --- a/Documentation/dev-tools/kselftest.rst
> > > +++ b/Documentation/dev-tools/kselftest.rst
> > > @@ -255,9 +255,15 @@ Contributing new tests (details)
> > >  
> > >     TEST_PROGS_EXTENDED, TEST_GEN_PROGS_EXTENDED mean it is the
> > >     executable which is not tested by default.
> > > +
> > >     TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
> > >     test.
> > >  
> > > +   TEST_INCLUDES lists files which are not in the current directory or one of
> > > +   its descendants but which should be included when exporting or installing
> > > +   the tests. The files are listed with a path relative to
> > > +   tools/testing/selftests/.
> > > +
> > >   * First use the headers inside the kernel source and/or git repo, and then the
> > >     system headers.  Headers for the kernel release as opposed to headers
> > >     installed by the distro on the system should be the primary focus to be able
> > 
> > I've never had to touch this infrastructure, but the fact that TEST_INCLUDES
> > is relative to tools/testing/selftests/ when all other TEST_* variables
> > are relative to $PWD seems ... inconsistent?

I agree with your point about consistency. I have changed TEST_INCLUDES
to take paths relative to PWD. The implementation is more complicated
since the paths have to be converted to the old values anyways for
`rsync -R` but it works. I pasted the overall diff below and it'll be
part of the next version of the series.

> 
> To solve the inconsistency, can it be used like this everywhere?
> 
> TEST_INCLUDES := \
> 	$(SRC_PATH)/net/lib.sh

After the changes, it's possible to list files using SRC_PATH but I
didn't do it. Since the point is to make TEST_INCLUDES be more like
TEST_PROGS, TEST_FILES, ..., I used relative paths.
For example in net/forwarding/Makefile:
TEST_INCLUDES := \
	../lib.sh


diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 8b79843ca514..470cc7913647 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -259,10 +259,14 @@ Contributing new tests (details)
    TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
    test.
 
-   TEST_INCLUDES lists files which are not in the current directory or one of
-   its descendants but which should be included when exporting or installing
-   the tests. The files are listed with a path relative to
-   tools/testing/selftests/.
+   TEST_INCLUDES is similar to TEST_FILES, it lists files which should be
+   included when exporting or installing the tests, with the following
+   differences:
+   * symlinks to files in other directories are preserved
+   * the part of paths below tools/testing/selftests/ is preserved when copying
+     the files to the output directory
+   TEST_INCLUDES is meant to list dependencies located in other directories of
+   the selftests hierarchy.
 
  * First use the headers inside the kernel source and/or git repo, and then the
    system headers.  Headers for the kernel release as opposed to headers
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3f494a31b479..c289505245f5 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -188,7 +188,7 @@ run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests \
-				SRC_PATH=$(shell pwd)               \
+				SRC_PATH=$(shell readlink -e $$(pwd)) \
 				OBJ_PATH=$(BUILD)                   \
 				O=$(abs_objtree);		    \
 	done;
@@ -242,7 +242,7 @@ ifdef INSTALL_PATH
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) install OUTPUT=$$BUILD_TARGET -C $$TARGET \
 				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
-				SRC_PATH=$(shell pwd) \
+				SRC_PATH=$(shell readlink -e $$(pwd)) \
 				OBJ_PATH=$(INSTALL_PATH) \
 				O=$(abs_objtree)		\
 				$(if $(FORCE_TARGETS),|| exit);	\
diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index a61fe339b9be..03a089165d3f 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -18,7 +18,7 @@ TEST_FILES := \
 	bond_topo_3d1c.sh
 
 TEST_INCLUDES := \
-	net/forwarding/lib.sh \
-	net/lib.sh
+	../../../net/forwarding/lib.sh \
+	../../../net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/dsa/Makefile b/tools/testing/selftests/drivers/net/dsa/Makefile
index 8259eac80c3b..cd6817fe5be6 100644
--- a/tools/testing/selftests/drivers/net/dsa/Makefile
+++ b/tools/testing/selftests/drivers/net/dsa/Makefile
@@ -16,17 +16,17 @@ TEST_FILES := \
 	forwarding.config
 
 TEST_INCLUDES := \
-	net/forwarding/bridge_locked_port.sh \
-	net/forwarding/bridge_mdb.sh \
-	net/forwarding/bridge_mld.sh \
-	net/forwarding/bridge_vlan_aware.sh \
-	net/forwarding/bridge_vlan_mcast.sh \
-	net/forwarding/bridge_vlan_unaware.sh \
-	net/forwarding/lib.sh \
-	net/forwarding/local_termination.sh \
-	net/forwarding/no_forwarding.sh \
-	net/forwarding/tc_actions.sh \
-	net/forwarding/tc_common.sh \
-	net/lib.sh
+	../../../net/forwarding/bridge_locked_port.sh \
+	../../../net/forwarding/bridge_mdb.sh \
+	../../../net/forwarding/bridge_mld.sh \
+	../../../net/forwarding/bridge_vlan_aware.sh \
+	../../../net/forwarding/bridge_vlan_mcast.sh \
+	../../../net/forwarding/bridge_vlan_unaware.sh \
+	../../../net/forwarding/lib.sh \
+	../../../net/forwarding/local_termination.sh \
+	../../../net/forwarding/no_forwarding.sh \
+	../../../net/forwarding/tc_actions.sh \
+	../../../net/forwarding/tc_common.sh \
+	../../../net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 8a9846b5a209..2d5a76d99181 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -4,8 +4,8 @@
 TEST_PROGS := dev_addr_lists.sh
 
 TEST_INCLUDES := \
-	drivers/net/bonding/lag_lib.sh \
-	net/forwarding/lib.sh \
-	net/lib.sh
+	../bonding/lag_lib.sh \
+	../../../net/forwarding/lib.sh \
+	../../../net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 2b6c2be4f356..087fee22dd53 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -69,14 +69,29 @@ define RUN_TESTS
 	run_many $(1)
 endef
 
+define INSTALL_INCLUDES
+	$(if $(TEST_INCLUDES), \
+		relative_files=""; \
+		for entry in $(TEST_INCLUDES); do \
+			entry_dir=$$(readlink -e "$$(dirname "$$entry")"); \
+			entry_name=$$(basename "$$entry"); \
+			relative_dir=$${entry_dir#"$$SRC_PATH"/}; \
+			if [ "$$relative_dir" = "$$entry_dir" ]; then \
+				echo "Error: TEST_INCLUDES entry \"$$entry\" not located inside selftests directory ($$SRC_PATH)" >&2; \
+				exit 1; \
+			fi; \
+			relative_files="$$relative_files $$relative_dir/$$entry_name"; \
+		done; \
+		cd $(SRC_PATH) && rsync -aR $$relative_files $(OBJ_PATH)/ \
+	)
+endef
+
 run_tests: all
 ifdef building_out_of_srctree
 	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
 		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
-	$(if $(TEST_INCLUDES), \
-		cd $(SRC_PATH) && rsync -aR $(TEST_INCLUDES) $(OBJ_PATH)/ \
-	)
+	@$(INSTALL_INCLUDES)
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
 		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
 				  $(addprefix $(OUTPUT)/,$(TEST_PROGS))) ; \
@@ -106,9 +121,7 @@ endef
 install: all
 ifdef INSTALL_PATH
 	$(INSTALL_RULE)
-	$(if $(TEST_INCLUDES), \
-		cd $(SRC_PATH) && rsync -aR $(TEST_INCLUDES) $(OBJ_PATH)/ \
-	)
+	$(INSTALL_INCLUDES)
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 5b55c0467eed..1fba2717738d 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -130,6 +130,6 @@ TEST_PROGS_EXTENDED := devlink_lib.sh \
 	tc_common.sh
 
 TEST_INCLUDES := \
-	net/lib.sh
+	../lib.sh
 
 include ../../lib.mk

