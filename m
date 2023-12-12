Return-Path: <netdev+bounces-56397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C591680EB50
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5EEFB20C28
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A85E0A9;
	Tue, 12 Dec 2023 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JXRTBPUt"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB61AF
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 04:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/F0ZZU369qGrSEkHfW6uIpAmaPkObPpt5fzYdeVPh+4AGIs/0pD12WLS6uISYJ4a8MKpaNW3TTSYA3kNSm03WnKUzXnfS1zwfzgOksK0CYX2nKOJTiuh35eBxcalHly2JmhmXF0Nc3CnMUpsFGG/HI5bJ2pY2eh6RtVdHd/ogKZxQMpwCDacuyTcuEHMqbWwDp7xS1VzjAcJA0vaA86MOEeA502/1KDgdUYqzP9y5kRnmN9+bUEFNdY/jN9qrrh0pSmR4FOLRU1+9S11fxUm/FMekm7KNHA9S24O4Ap7yvkNRlFCf8OXbAp+DVi9GyDHrlDNEGy1rKrPzI2l4k3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+IdnPq+thzmYmUd0Df2c/2BkC1gV+bKY76Wvee1brw=;
 b=UWnNLLVuIvlduqwtQhSSZRCwh5/W+zskDvI8rnQgiekLpdg2cWLuErJ3M2eZTl/rrjQAGD2KHIV+H+dOL3rgQmg4fRYb+YczIf+r9OOjaZe9yQwD1eS4z/YfMvdfgs9J1X/GHoUtCkW7CH8YJ6VWco06t0jGeIo83RsYzTBgx7+brOCS+K2UlEaYm57PubH/E+MhoZXrjRS76oKx1EG7723E+hw5WTmMp5RnNKqLoJLsRHKBZD5nkzquexIIwQbBKlud+PiSCumPzOMXszlZ48fD6Qpfkuj1L4wX8kowGrGXIn1OlkjF7q4VOLIZ41aaZE0duhe1GCQyHd7zn+mUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+IdnPq+thzmYmUd0Df2c/2BkC1gV+bKY76Wvee1brw=;
 b=JXRTBPUt6lJCLSPV4mUIZ6Ldi78QU99Be+ipl1J1YhansvUsDdJ/yeN70QsqLhtHyhevWWAZ60ltoZGv7wlafuamvqd6ybuXAuxlHJ+PSripJ+EuzeGndbSf79yIvl/HaWp3NStYdHChKlrzJT/rjEZsJ8ZvGYh1DI3PQxUwEh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 12:17:41 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 12:17:40 +0000
Date: Tue, 12 Dec 2023 14:17:37 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 5/8] dpaa2-switch: do not clear any interrupts
 automatically
Message-ID: <ucdsjl73fcuesvelr3yqe36hiatcwaltmvgymv6ngy7be3jfyo@j3klqrud4xpo>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
 <20231204163528.1797565-6-ioana.ciornei@nxp.com>
 <20231205200232.410387cc@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205200232.410387cc@kernel.org>
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|DU2PR04MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c02e17-8d0b-4546-2feb-08dbfb0c5635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3kiR918CxiFagylCA6KvZ6q5sIqVonxIi6M212SegYwWEfyRlbgesvh5wmwDt/OsH+5AAOp/lvzGtENWVoUDeKrVTphL9SE2T/JR+zrFt4jUU9TPLrskG80msfhwQ7QC6TB8GboOF7JHQo5D7Ob+yhjCx4bOiPISgpqdmbD/AHLyk0quIlaPfTqtbTwNLjX3V1hWNJR0VcVUwyHNTVFlFLj8lvkHGsr97wS6GXrl08TiigVv4JsUEcCm4KAJ0F89KR8hv8FKPeUVLCzTk+qNQGdpzqPz7t/gr9g4SII7kl7f8w0u13FgJIgtwVTyAQ4l9oO/DzVKlDPKumZrc6CLuIJ+Klv2emUOMXxm0OPerkkhlzou2U3ya6ilHBZJLE+JW3dNTFEjHppVYAT/wPEMTFzL4+NA1eeH0kw63uK04cHn7HD3YrsOftHs34PYANial8M2Ml7InQiGwFZGSSh2K+wpLtYV1DwnRZSDa70Eo4x9fj2vC1NPT2Lb7kmhf0WBrDi6OPsacOc931pNRHN1eYWeRII+cHmfS5j4/NQ65P/9VQLCYTmuy2cXdtJeqpSk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39860400002)(376002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(9686003)(6512007)(26005)(6486002)(478600001)(6506007)(6666004)(41300700001)(4744005)(2906002)(44832011)(5660300002)(33716001)(6916009)(66476007)(66556008)(4326008)(8936002)(8676002)(316002)(66946007)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W87hE+laZqUf/pDKU96M9B7TW3rGUMLMD2Sx1n/aKAL14D6QKEnfoHyiu/cc?=
 =?us-ascii?Q?tE9A0IngB2CxKbWSr0vvwnsvzd2nikEygY9qNpGAYIRHuq8lDwzyWnPr4Z8s?=
 =?us-ascii?Q?5AInV3Fybs2fjUpPKl2qaJZErb0H07JWKtyL/BMn53s7PGr23vPB2aLyeWbp?=
 =?us-ascii?Q?HFm+kIuyNc8dme8B2xFCRnJJ5oIoGhVlALg4YSry4wLEPaW1ib3RnIbgqB3R?=
 =?us-ascii?Q?xnbBXLJZb3X86aiDdGjBaiM+UC2xILx/gY2Jbx3NmVGtAIv0hYLBLb93x5jJ?=
 =?us-ascii?Q?iHgzy9BJIPREw2R09ZR2E27ohcf65iVxWxGbLCtiSoTdDlmsUQK/wlauU7YJ?=
 =?us-ascii?Q?pQ/6CVrl8ZxpR6cePOx4niIHHKJaJg3AXJ9Ykbf9reWhTErlHaReSE75UXIc?=
 =?us-ascii?Q?mfN7veyB7GBSnskiYPJL/XYZnEhk5u0j/G/dDCy2LZoNQxbdJJpiPETL4QF2?=
 =?us-ascii?Q?Z3N8EagPlaUFSCwlpRiscqFA99fYHo1H1hv1LqWOxVqAdVpCpFuur4pziHiH?=
 =?us-ascii?Q?lgxDBj7oQ8ZhBMETDsBWxfIhHqNICGjNthQ5PQo/h90JPE2YR6JRWpMxb7dR?=
 =?us-ascii?Q?8TPXMzorjrIj4MH16Lk1j9Jv6DbYvX0OVxoVhsf6biFjjvjJAxEhTyjod+8/?=
 =?us-ascii?Q?85VDT2b1W+Ma5xLMNrZs4pQHX2VrgWMtjiV0VqDS2Xr04n4rpF3itCybITfC?=
 =?us-ascii?Q?9WC2frMJv8/pN89l77xnIqU89zNDzqdPB4W3bj3/gKOqoT7+Rw12QHh/JZP7?=
 =?us-ascii?Q?NK3PhTLWRNCImg7+b00CQJ4RmWvXGjc3bJ3Bl2BKz6PlCsdqyKSBAms5uU+c?=
 =?us-ascii?Q?CXtaAZ9K+DN4Q8zol0hrKeimUL4FM/0qMumvDHW+JgrlDkxn3zCekLsn5hFm?=
 =?us-ascii?Q?h86M7ylU5TB+56kA/6qAuMTVyQzCBYaRwGzJZbruPKW1kxGS4Z9b03VQa6zV?=
 =?us-ascii?Q?N3IKmyd9NMVH+k19pcb9EKTJvi5MJvFt+fQEigwHXgRZ3gHMKChmnSZDruGJ?=
 =?us-ascii?Q?lE2k5gG5N4mE0LS7lp4Vw87GrhJHKeds1HKMARIX/sLuoBYYksHSK1knlnuG?=
 =?us-ascii?Q?B+njsRx8yGTs/aiUwCxT8Q1Cv17WE04w9TrsUG+AaWFU41TFJsTk0eNrmlJM?=
 =?us-ascii?Q?v5SKjxYWftemrv+LV601wYSwnNksPImRCejXLT6NZpOo2UDmKYo+2NzYOjfK?=
 =?us-ascii?Q?hEO5bfx/5iDS4NGHA5mIu8+gGs0Jl+Si+S5UtgLAnLQgCrquNrTQIXKxm3yu?=
 =?us-ascii?Q?RBCgApwHLhXrIoI8rOhmKG6Vfv1zw04QJcZztoz6seM5788Q4sq+XNQ/W8RI?=
 =?us-ascii?Q?ykcRhDzviByuzzJTRAeJ5HubSozsIke/S7LtYTOcEq/lw3Ajm+pBDTFRDRgN?=
 =?us-ascii?Q?U9cZxYQauoy+H6MWCq+2yRj8YdQ7RzndVQsiLK4UEJ1og2XGpafz9x030F+S?=
 =?us-ascii?Q?qCxRhJXg9GDgmOi/sLeFpB24VhDSgwltxOdRHMDQ++GaRGNios5AUZ0mqIo3?=
 =?us-ascii?Q?RR2BYVPy1y9wEYsvrJGz1w3aRIyxjfOcqI1g/skPQQ35z2kbkibzhqz/givY?=
 =?us-ascii?Q?HIWa1nQ8MYNO+prG5KO94+KUqmYoSpo5S/4tugDS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c02e17-8d0b-4546-2feb-08dbfb0c5635
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 12:17:40.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cMh64b2hBUg4CdSpccHmdSwcSjjWqnwgeAcRoW6msRq7crIb3Z8aK9pl3uHZm38nIU9MbVLumAEKxAP4uxsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8840

On Tue, Dec 05, 2023 at 08:02:32PM -0800, Jakub Kicinski wrote:
> On Mon,  4 Dec 2023 18:35:25 +0200 Ioana Ciornei wrote:
> > The dpsw_get_irq_status() can clear interrupts automatically based on
> > the value stored in the 'status' variable passed to it. We don't want
> > that to happen because we could get into a situation when we are
> > clearing more interrupts that we actually handled.
> > 
> > Just resort to manually clearing interrupts after we received them using
> > the dpsw_clear_irq_status().
> 
> Currently it can't cause any issues?
> We won't get into an IRQ storm if some unexpected IRQ fires?

We don't get into an IRQ storm because we can configure which event
sources can raise the IRQ. This means that the driver can ask only for
the events which are handled.

