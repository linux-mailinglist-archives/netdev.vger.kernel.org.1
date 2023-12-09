Return-Path: <netdev+bounces-55505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8E80B116
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33EE1C20BBF
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666D5628;
	Sat,  9 Dec 2023 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XXGXoJTg"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B91716
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 16:52:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itqi6jgImGSmoZqFpWlTUOKcFPlbRpXyxZF/PYTWSkHUcb1QRYtql9r7MZ0ltGk4EzqD2zL/0qeLzQ/5xCBdJMtoMaN1BZlBKhsplLCVmmkS4DWZAB3UrpWuz4OMwsproe0A92X6WuYQJ7qkzkO3wnCEL7ifEuNhPGaUWtUl1ehJdkYPYGej77190V7A5QMyNRvg+FwPh4RxJUWwImDqWpAEgjSRxc/fHDDWB+s0r3rD05dPEUZPkcYNhEXVDk05yV8xFOajaHGxePb3sU6bfwrs71ug2HXLyvgcCq4MaftDUZLU+zdpuEokUc1Jd2Mfoo7dEJG2jOrLle5bDlMhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gm9HXKUOW/xWPcYgGnWxb1iXeNRTGzj6QWn6RQU8bE=;
 b=bgTuZWNE4EuNcsKMAjUb22C63Oo+0HqlPHuTLyCAYaHVyS+aF2v2K5bV3vJ6uz2WBP8G7dbMTGIo5OaMr265L52+HajETBmAkkh8vJSpxe1Qr29b5cub1GKnpv15k3Uwb/hBB3nKH3sfG3XALO3ORCSLawEx6YiDbrIiv1wCl5g6Q6oh8lCpCaMZbvcSyvXKd+/KoXgAo1va6CTkRS1L5iZPWpQKzD7pLDMl3BOa/g/zdefbdV15hbf/4sfwSlWwARCQIqoRLihEPueoUb/sZi5/jiqtW6v7NHT7Siiiu1+vVGQJvowJBUBQcRjsZLN9w9y/UGMbStKqOJb9CRhxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gm9HXKUOW/xWPcYgGnWxb1iXeNRTGzj6QWn6RQU8bE=;
 b=XXGXoJTgBJ2zA5wQMQDhVZvsI4pGO447ClmWGrO9pd+dxb6beUuUXL5/VRTiR46q/3whCXF/kxfW/LkU3bxKxgH7v6AtLBwiNs00M3b0KKRGa08E5CW4mVG0ujXcFGZbVQsWePi8IFgJQb/tnkWKyyK/nFkwrHGTcKM6xTLGyZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBAPR04MB7445.eurprd04.prod.outlook.com (2603:10a6:10:1a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Sat, 9 Dec
 2023 00:52:54 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 00:52:54 +0000
Date: Sat, 9 Dec 2023 02:52:50 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Madhuri Sripada <madhuri.sripada@microchip.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net 2/4] docs: net: dsa: update platform_data
 documentation
Message-ID: <20231209005250.7vtad6dyajrhs7uw@skbuf>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-3-vladimir.oltean@nxp.com>
 <CACRpkdY3863-a5GgG4W_=KTBYh3RPPb75u-JuRtrN=DQ=k-J9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdY3863-a5GgG4W_=KTBYh3RPPb75u-JuRtrN=DQ=k-J9w@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBAPR04MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee94d4c-951f-4779-a562-08dbf8512d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sDgZ4rMT/7n6a7TpSwogikqcd75S7sMlh/EDWcZ8cJHFGmNxiqb21evJRLRtqCUZYL3Qn06nszzRYElzkY422N9F93DRIdHU/y9uqUNIVtisUB0bLKQ76ZOHTJpien9SVgrL0T9WfkNswbx/hCpdVK67cdFZdqwNAqzRIirwfIiJIbF1Go1hH3ll30YaAnVGxGqdL/48dNrqqim4pB6WIvLMClHOWWLM02wcXuskPIfPqgFK+gsSkWuJegdIlVKYFgTViJ4FQM39Q2MI36DUbOVi9ablbmVFxcrVZ4PAP7XoTy2KURqR03qv2uw34JGyh9qoSbjn4DL1Q/stYfD/Ah987KdZt+SJeOqfPMa1g0uNfpOw4XaVV4B0+7nkGVYNPmtKSscyhPgph03FWMB+IgCbqNj/j1zYNo8GEMqZ6HYsOWIFsCTuHDO3lS3uAG0e7mfxs6WUPVLrhEzwKNWlyZ7gbSkOz5Fq7d2G3+oQkMvqiCVlLigOZVFGGSp53qVEH3sYJIu1WZKH66VpxksSCIqPxwCJw9zNgYBc2GqPmH9bocsbP5Nox2kT6PD3FBMr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(316002)(66899024)(66556008)(66476007)(66946007)(6916009)(54906003)(9686003)(41300700001)(6512007)(6666004)(38100700002)(1076003)(6486002)(26005)(478600001)(86362001)(33716001)(53546011)(6506007)(44832011)(5660300002)(7416002)(4744005)(2906002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjhlUnFWMEVWSmJiWWNmb0QwZDdZZUROQTFQUFZreWg3YU1GSFRqbTJCM3Ix?=
 =?utf-8?B?V1h1SU1tdHBQc2JMUUVMQWt6WnNXYjR3TnBLa0dTY0lGT2l6WEJGcllMd0JU?=
 =?utf-8?B?RTBKRjJLdHduaHpJekxhZmJCWFBHSEUxNUVlUm1rMmJYcGNNUzdOYWhNMWdQ?=
 =?utf-8?B?QXF4dzZNMHdIaVNwcVhOU1plZWs2cXZ6RHg4ak43SHB4ekR0djY4SEcxdlN5?=
 =?utf-8?B?eUI3TWxYakdxRlRPbmp2VldjRjVSRGFDSitrRTdmVWh1OHI5WTZwdkZ6dWdq?=
 =?utf-8?B?bWF4Nnd6eTZPNjdvNEJlTXlvWVBRSitSTGw3R3p4dHgwcGtYV3dsTkJiMHU1?=
 =?utf-8?B?T3UwQnRGZGhtRmNLZ29va3dLQnFyaTBvdjBYRSs2cFI3ZktGcE8yVUxCWFdj?=
 =?utf-8?B?Uy9BMmEyVlNXWlEzMDYrT1piWjZWRWNVSkxlUUdrdWIzYmQyU0x6cUlhR1hv?=
 =?utf-8?B?QXVvQ0dQL0xDK0N6ZDZiWEFXODY3ait0RUtrV2hMVFdGZ2xnbVRJRkFYQ0I2?=
 =?utf-8?B?cEVpd3dKVmFQekxJQkFWTUJOY3F5L2xGVmhhUGFsNVI5R0RVTlJGcEx2MVNs?=
 =?utf-8?B?S0NUWE5RR3gwQUNQcitTTi9pcHAzenVWaFQvLzJ2Vk9lOGdkajdtK1dSNnNE?=
 =?utf-8?B?NXViRC9Gb0lvWU51Nm55WEU0VmFLTHAvNGU1QTVrSXd4UytsVzg0eTNqTHVk?=
 =?utf-8?B?akV4TjlrZWo3aGxXRm9UTDY5dUNsQ0YwMkpkRTZvQk4vMzBNejlUcE5jczZj?=
 =?utf-8?B?SHUrVC9ld2QzK3h2VldzZ1NEUlkvS0tyMy9GdHVDMVdsTndVaGlZZ2J5NDVp?=
 =?utf-8?B?ZzBydjQ5YWxvSm1MQThzalY2K3c1MlVHQXBwYjRtUmMyeHFhWmlLem9tSUhX?=
 =?utf-8?B?ODE1NGhrelU4clpwbFdOMUI3dHU5TnFIUWpKOTVRNUJVRnhwK2dyM2wva2Ra?=
 =?utf-8?B?N05vWm9pNDYxWTFkOURYT29tMXV6bGdpT2hOL2VBWVpyc1k2ZUJmRmJiRW5x?=
 =?utf-8?B?Ny96bVFJa2IwV1kvVTlQUXZVWGVXTFFZekYyNlcrcUFnS2djUXp5ekdlcTNq?=
 =?utf-8?B?WElxdTJaN3RubXdxTFBFNkZ0THJ0VFROUHU0K0V1b21FWGNOMC9BSDdxK1dX?=
 =?utf-8?B?TXRSRW1oUUowWlFtczBWTlplUE1oVkV6OXBKY3pqYTcrQzU0MnRSTTBmWGNj?=
 =?utf-8?B?cVJOZStuMlFxTEx4Y3FlbHJReDMxYWVWdXFvRW01bHJsWGZNT0tQeGxHYkRp?=
 =?utf-8?B?KzNPMExNeU1FQy9tN0NMME5vSGhheWlmaDdZS3N0T1ZTdWJQTHBSYjlkei8w?=
 =?utf-8?B?MHJtVjUxNURrTnFabHAycmFTbitWdXNwRko1UVJvbkV0V1QzakkrOEswbmln?=
 =?utf-8?B?OE5Ob0dzM2lXWStKRERrbHFVNG1yd1d0VWJ3NEFaL0FSMjA2aWZ5bHBpUUVS?=
 =?utf-8?B?OFNnMUF6cjRMQ0ltYTJMRkFSVzdMaitSYkYweGg1dE9BYzJBYjRqN1lHcG9x?=
 =?utf-8?B?ZzZuT0hEZzFWZnBYaTJTRVJBNEwyTGJDbWs5SzdpMjJwR1ArYi9SNDh4aCtu?=
 =?utf-8?B?N09sRVBoendZVkFSL2dyNHBEd2l5cDhTTnVmWEYydHI1R0MyQUhPSUVrUjBt?=
 =?utf-8?B?cldxajZDSzhkOUpaajhCUldSMjBhUmpaSmtkdjhtZUQ5Unk0eHZnbTRKNmhT?=
 =?utf-8?B?bU95czFxREY5c0lJYThka00zdGxPMDJncDJkNEdoZ2VlaXJmendjNnRQRUpi?=
 =?utf-8?B?STBaaEdLRUhsYTRqYk92czQyMkpTNTdoQmpHbHFFMlVYQzArOERhK0YyUFBt?=
 =?utf-8?B?dXNVdjk3a0IyOEUrVDNTZjFOdmdTQ1lPRTdWamNONXJCMmZHZlNTRUhIZ3lO?=
 =?utf-8?B?THZVa0U1NWJmRUlOcXRzS0loZTZNb2d5WldOMFpOY2ZaUysxZjdpRy94elc5?=
 =?utf-8?B?Njg2dHRTUllqellvWk05UXU2QzI4RHYxeE5sQzhTQzlxMUJMZ3NHbS9ZYi8y?=
 =?utf-8?B?cDZiTml0ODZIVFBOWmZuT3FMdU1IQURkdDdtNHBsNWRKU0hZL1E0SUIwajgz?=
 =?utf-8?B?ZnJSWnpoZTIrS2ErbkRLUGU0M0xsTS9HdWJiUE9jMHZ1MWc4bGpkQnhMd2VI?=
 =?utf-8?B?a1k4OVFNcjdWUzBaNXFsU082cXpSUzFyT2VnSWRaUEpjaHdNbDY3WE4wSExH?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee94d4c-951f-4779-a562-08dbf8512d84
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 00:52:54.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOpt/ie/PsBt/W04LlmSz++5/cwEgd6Rk/uzrBzCtDFyYsnUgkROwKbJUp5456tXU3b17AIZNkFkdQSM8mfEfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7445

On Fri, Dec 08, 2023 at 11:19:28PM +0100, Linus Walleij wrote:
> On Fri, Dec 8, 2023 at 8:36 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > +  ``ds->dev->platform_data`` pointer at ``dsa_register_switch()`` time. It is
> > +  populated by board-specific code. The hardware switch driver may also have
> 
> I tend to avoid talking about "board-specific" since that has an embedded
> tone to it, and rather say "system-specific". But DSA switches are certainly
> in 99% of the cases embedded so it's definitely no big deal.

I've changed this to "system-specific".

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for the review, I appreciate it!

