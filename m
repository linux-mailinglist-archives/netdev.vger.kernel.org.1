Return-Path: <netdev+bounces-14790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE0743D1F
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB0C2810AD
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E536156E7;
	Fri, 30 Jun 2023 14:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60E156D8
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 14:00:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2125.outbound.protection.outlook.com [40.107.244.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6252118;
	Fri, 30 Jun 2023 07:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM4+XrdaAeDE/ucs6K2DCQ7RwOYX0dLPqf6Q0UdxcfpActH4YXG/n9ppfmsv7NG5i+SMsUgvmiyG6u527TKmNfowKhiuz2m2A+x829o2hXzszMrIH6eq9Dcq+woRXQgtx2mNA7FkrTM2bArx2EruLUg4YHAF6RGYqpJjI4pgoQ5SvDI8W0wt9WtvCrknj/QLHCGq3VNXlzfhYsjz3f+JGliREvuHadc1E6J4blTIamDxAomcP/dWppCyQ2avmjd1tNUkDOqpcYcncPiTrNgr3IQkg4xVR4iJcibhGxpyjRDblXwj9HA6kMFIDYbMsENNoIR4JQxscVKkslqO16peHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAuWr/Xibrzo6rNgDJjIXpXi6wFVKNWM5h6Dwh08G14=;
 b=NUwct7kMULo1aDQJH32tiFKH8tnNYuWfMCubp7hPKPVWKeDU5eZBJFUszUOTCNpaFZHvg0Zmyk5uUQP4rXoEDqSTy4RIxHzlp7TkbcSu+o10YIuAeHNTN0hxT+225S5jcP2cDJRxMKa6/TEtR5sdpgGD1h6azx9gQY6PyZ8IuCo/8aZw24tvy+sL037S5WdXRjpTup1DoJllw8MfHaGa6lq8oc6NX6BQJWzPocTO/dht9U2oUIAsJAl/5Bp7uEDWHL8ZJ+1j7z+StGE0vuGEFH7TTbWwwQ2hGjRykh5sy8a4yJmPl1f9v5IxfgfwnYOyzQhWLqQl31ISuzBLdJYgSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAuWr/Xibrzo6rNgDJjIXpXi6wFVKNWM5h6Dwh08G14=;
 b=Z/k+0aVmqgRu68Lr6J2z9Aat0gkOhUHSh3xwdPXrS4Qx0id/ZoQU+FmXWSf8DAji3Gj+TJ1IMP63voU56hWIC45ryJtLsnFJF/OCYeQzE0iyXwFEVhom9DYHzimX6XEFMKDAH6GFVrJ67IxaLhKqiJpqav16dr3EFyHU+bVXMM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5722.namprd13.prod.outlook.com (2603:10b6:a03:409::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 30 Jun
 2023 13:58:58 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:58:58 +0000
Date: Fri, 30 Jun 2023 15:58:52 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Davide Tronchin <davide.tronchin.94@gmail.com>
Cc: oliver@neukum.org, netdev@vger.kernel.org, pabeni@redhat.com,
	marco.demarco@posteo.net, linux-usb@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH] net: usb: cdc_ether: add u-blox 0x1313 composition.
Message-ID: <ZJ7fnIKQcD3C7jOT@corigine.com>
References: <20230629103736.23861-1-davide.tronchin.94@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629103736.23861-1-davide.tronchin.94@gmail.com>
X-ClientProxiedBy: AM9P192CA0016.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::21) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 169ce541-2c86-4457-a4f1-08db79722674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2i6AJ/lNkPr/XtJXlyixTHdenGLldNTH9E6TZw//bk0tHN/cKggyDJNBVGL9FqwR3BeCIhMauvUVkBB4ZLA/YefPW4Pg/B6vDCFwJ3ZicXwZjitZEvKL2SM6m5TOTEppWdSLZDE+mjlIkC9rr1kcahBCLe7kKomzx+OLaJwync7SQ6033/+i2fcBInNyEpEzHO8YN0rT4SbY3YN7kcS0JYApRptcAnMgO5tzQ2uXFP+U+CKKT4U+S2DikpPn3I95C6DdDSG0yg5Lf/oGD1crf0MQ+g8DkDwZZ7c2M1IqWe4vs7o/+wx/j4MJdDx/Et+fGPKhNHYAC72aDnl3F0ElkpqVlqugASy9m8M0PAsbCu38V8c5i32hjK6ybo5Xh1E95s8KEnDJRqg9kYlHhOht/zvai3WCxWWC8Lzl54VuUQKnFD8hm3I/LF8ny//hbJIbY6ui5Uvk5NFWGbJE76fKjcz7z4gllRe2WbKQLbED/iAINpjq2iO6/yjNQVlJ/abOCKU3DamVl6J20vTloSvJ3mPcy+HHL6UWdStOVYAEB5YgyA9wHvLhoe/Yp3W0q+i4zTZf413RgOGmN74QVkqfybkK+H6R/lVZH1mcQkb8s9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(451199021)(5660300002)(8676002)(6486002)(8936002)(44832011)(186003)(2616005)(38100700002)(2906002)(4744005)(478600001)(41300700001)(86362001)(36756003)(316002)(6916009)(6506007)(66476007)(66556008)(6666004)(6512007)(66946007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4H5rm8f6LbVemDGRH3OIalNY3AIjJcdO6qEgvTWuls3UQoCIwk8WUwzzfOUm?=
 =?us-ascii?Q?zwyTulR1LveC2k2b8iaacamttAoc/zb0+iQtqsCawddAtoHwIapEH2y2HUt+?=
 =?us-ascii?Q?VbRBFoHy2fpCWJ9Som4ua4ul3xi6QtiN7iCDwSYr9x7JRWrCzHaM6u0HLzmF?=
 =?us-ascii?Q?5nF+3HxFu6QrZ4e8W8NyoJgIuIM7U1hHyh7aKRD2eisUqe2z1UyWemf9h+4F?=
 =?us-ascii?Q?qfGK5+Ldcj/l9HU3Tvm0fV3aShiCXfph91MkSx2jd5toXjuQ8P/I8NXvPnbn?=
 =?us-ascii?Q?J6fFHVnFNYDxUYusBdbg8YEifxIlUmCfAlNfVjelC6ofMcRCtExDm46W9iXg?=
 =?us-ascii?Q?erq6YSAZKlYT9SDo77i8XVickmvi9HdEP45FmgFSSL4WbeCmjdccuLOaAldF?=
 =?us-ascii?Q?ijEjS+T+H2vy2/H5NrcXMx+S5Gwr9rQsv39ImzWW2CUQC/wv7SbbUE6eFmpa?=
 =?us-ascii?Q?Aht2f1NOF3i1JTxQG6NWkA2eq2d88OTmaXZgzbw08cd0kIA9ukzkXqRXkwKx?=
 =?us-ascii?Q?Vzb0spvbVYBi+x9trNVrY6N4zOyl0lo5T6R17ZPcir8GMhLt4zReYvYLrhML?=
 =?us-ascii?Q?AWnAhjV/gzcWiAFJH7xjkF43ts7x4Dw5NiQeY/uM0ToC31Cby9OsJOnM6pIg?=
 =?us-ascii?Q?VX45hAD63A14m2OvFIr4nanxtvMJF9xSmJUfzKRrGPVTPBFggcK7TzAri79X?=
 =?us-ascii?Q?LAESOM0Kfk9kZnoUcu17Xhb4Pk5tGJq6e9TSypPNOCL6Ew3t4/Tp6rIhsJfw?=
 =?us-ascii?Q?tCimOxDSNsdSgbbNSLynphArzSkvV2Q+CUO66KVOyYEbDZJwNqdnAgK9kFzm?=
 =?us-ascii?Q?k/ko7TJE5Ck4rdXTVloAUomnDVhYJK7z6WnhGuswhQi7g1TZIxLjULVIxCLb?=
 =?us-ascii?Q?T6fpljMpboV0lToGlsgSdBAnWi+n2v+4geU4kqX0s/tJ/eno/nAshrorhjrT?=
 =?us-ascii?Q?qJqR83M0Gg0QJ+imwx+IIS8Vdw9wPGcUuEm9WtmW1y8GTJrc6Vb9lHmkoDF1?=
 =?us-ascii?Q?VMdK1nVbG/hL/SX/McMDZ8k/dj7rnCct7k70rY6zIw+aFjLM1BPS41kWzZkG?=
 =?us-ascii?Q?tTlT3bL1xXquPuFFxaZMAkukkK+5VTmbKkHsnzguvUWdbjriGIL7WP7UIRL5?=
 =?us-ascii?Q?2i5FdunMpnQo2wtVES+yFvzaQiT7LNUEcsP3V5us97bJ4foHhtRvRuosR5pC?=
 =?us-ascii?Q?zUAEcqtwdthp1ZXy6/jOsvIGUw9m26okJE/dtIYTGNiTKW1cIj3sJ9fOhxZC?=
 =?us-ascii?Q?wlyMbxwzFN54CHMY3Q09dE49sNJs3MTApzrRUS5w3e8gmcgwIF8sXwYcwT1k?=
 =?us-ascii?Q?x2Cf+XhKjGxpHVlf3fo4LXysyFB8Oe3MV2sVk380TFOkSeoHuzabqtZKox1x?=
 =?us-ascii?Q?gZzXdMes8PM+4qRi0V9Cvu6KOmGYnP9kib5F1dqeAdE8WlqsJ9VCuxMO3OeA?=
 =?us-ascii?Q?M/RFfMcgon9EHhwtReox3Z3DYku7lha7VcLwXl06rMgNvRKYBCWRHCDBqJ2x?=
 =?us-ascii?Q?6v+4EeFt/B6ma4V4+r5cClV1YGxdNDtf3gBB+bLeF51oDYIcdMUgPcd06QKV?=
 =?us-ascii?Q?KWPG3soc/uYw4WZhjpFcWUZUBlte4edxr0b0f1KURqAMFFZTu1wz5frGGFOM?=
 =?us-ascii?Q?vq8jGWptdu9YvVzRMaTPJysXj6luVf22qgWHU9Jlq5cg3LxF8yupOwH9V36w?=
 =?us-ascii?Q?qMVu2g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169ce541-2c86-4457-a4f1-08db79722674
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:58:58.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezn38opMLH2EoqZzqUqkwnQQGRr/zf5uPHjFhd25N0cvvdxOYt8CqoPIYfFbnScK2MEtp4HfR/Xz2DCQ6WTJkgas32ubYsCkVANML4T+2wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5722
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 12:37:36PM +0200, Davide Tronchin wrote:
> Add CDC-ECM support for LARA-R6 01B.
> 
> The new LARA-R6 product variant identified by the "01B" string can be
> configured (by AT interface) in three different USB modes:
> * Default mode (Vendor ID: 0x1546 Product ID: 0x1311) with 4 serial
> interfaces
> * RmNet mode (Vendor ID: 0x1546 Product ID: 0x1312) with 4 serial
> interfaces and 1 RmNet virtual network interface
> * CDC-ECM mode (Vendor ID: 0x1546 Product ID: 0x1313) with 4 serial
> interface and 1 CDC-ECM virtual network interface
> The first 4 interfaces of all the 3 configurations (default, RmNet, ECM)
> are the same.
> 
> In CDC-ECM mode LARA-R6 01B exposes the following interfaces:
> If 0: Diagnostic
> If 1: AT parser
> If 2: AT parser
> If 3: AT parset/alternative functions
> If 4: CDC-ECM interface
> 
> Signed-off-by: Davide Tronchin <davide.tronchin.94@gmail.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


