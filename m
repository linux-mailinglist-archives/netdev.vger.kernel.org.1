Return-Path: <netdev+bounces-19988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C366A75D304
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E96282425
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F0220F88;
	Fri, 21 Jul 2023 19:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7C200AE
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:06:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F36C3A98
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3LKtVLOvZbSJ4EVPRdc17/9VD27pGJHV+Xpnq00Eq+MpEucaA5wnPh7zc73RL+kkh7tXfBRamwYb+dKjYySoUM2av7thOPW2JJe90mCINrFPQkq27BS5Xyx4wFZAx/yUHEhV7kZUsSH0yAL2hOyCUwY1y4+UqGHBGwhortuBGs5ayKAkLlhPmCzGsqE1+ToSpPf+QKjO2TZAomYKnndKiPSkrvu0+qFdgkJQmkkM9qtirx9HXWbJlD0TWu6UViUhL9vw6ZyKFI8qJZeqAhMxoJUD2TDWOQ+ueFKHa8vDZi825Ho3FQpKjeyaiU5d8MI/8+Y39v0xVOmp5b/ZEE6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TnXq64Q8cFjs661WHpdDNoxQ9IahO7l/M90zT6fpNw=;
 b=oYYfY9lSk1OXETw9wgEBnede9J6e2Vu6QhRDpCotBbMNmh0vCpq0/PyGtCJeCrCoLfTO/aQ2wbTqAGahZLcIbtlwNeMfXoG20Rp+R9wr3bxHQXsuqppJHqplggpBKjenxU7GDvc77ZEUffX4FG7nkiU/Z3Uk/ca0JywaostuzO5+E1j/cnPA2Gru+ZPGCO4oAtR9wcCRP1ODf9MmDUp2V31KdkWumIoMS87O8g2OVujmN4RALRZ5NQDRYlbR9n8fdolHNcypPlb+EB26sGMHRQrNdpWArZgbMBUKbl3NtVwB5qmlpJpNgVmszKyypKUJe61nomTU7aPuVh0p6bSM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TnXq64Q8cFjs661WHpdDNoxQ9IahO7l/M90zT6fpNw=;
 b=NVlIkjl9r10g8x8lyEqPd6nWQTpAuDCvNpTonDeWpM4bs8KZJ0KnQa2VXV4exbe2D5I6AUfcCJO87zHgORiCvXQgyrU5OWGOgR5zsQCubQN+OMedQ9XcawPAWA+yyRYHNBrWYyCFO9DnPqXRJ4UmPLJnUBWNucrLkpa0px0//VKC+DRahFsdIsMBYPAq5540o32wtRo2qeAN+NSloBuzwX54gxtW4ZEC/8KIqw7leLYHjbLJL6Nysm+5p/gz0zvGzjvk7u7Ex2chqU447+FumvriFZM++wYFy6kX/eKvETD0ojq3OOwJvpi+DbhYIkgMtYhJZt2vdqci4zI64XdbtQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 19:06:03 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::e3bb:fca5:70a7:9d25]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::e3bb:fca5:70a7:9d25%7]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 19:06:03 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "sridhar.samudrala@intel.com"
	<sridhar.samudrala@intel.com>, "maciej.fijalkowski@intel.com"
	<maciej.fijalkowski@intel.com>, David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH net v4 1/1] mlxbf_gige: Fix kernel panic at shutdown
Thread-Topic: [PATCH net v4 1/1] mlxbf_gige: Fix kernel panic at shutdown
Thread-Index: AQHZu95yT+g5xckp7kqGosWbtpbJ16/EUPJfgABDz1A=
Date: Fri, 21 Jul 2023 19:06:03 +0000
Message-ID:
 <CH2PR12MB3895C55CC77385622898BCADD73FA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230721141956.29842-1-asmaa@nvidia.com>
 <20230721141956.29842-1-asmaa@nvidia.com>
 <20230721150212.h4vg6ueugifnfss6@skbuf>
In-Reply-To: <20230721150212.h4vg6ueugifnfss6@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|DS7PR12MB5861:EE_
x-ms-office365-filtering-correlation-id: 823e6609-1c7f-4915-9c37-08db8a1d873b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 k1IAqDZSe5fyoOheiyxEFvMIi2pVgtoVXM/TUoUlVrpg0VIBkIN0jlCTNSFu04VJtyB/fqy/Te202HfAUoHKV4apLZkTSr3dCtyYjNwfi3EGQdO0QknBAsEE0TzNxJN0XHnUDQ+NAFvaYU+X6yHm7uEIH8HJ9OK/O51puYpTV3OXltevzrPE5Dy7ee3iYL0EigRQWKCrWh1SMWNqgS0RwXa8NWcbD9EwqCYJyX4xeYto4yiXhJJy92OQ/JqGVYDqAPbSHrVSnLqMOGbo1l6OLcHfCWyzS7pCMl85m0RMdMozO63+2nHRQgtBlu+XTY9rpQ+PKxigYv6sJHtqetL4ZpEMAyUDPElMrp02uw4Vo521cV983BLkTSo4DOfr0h6aWlo+FqoeUHlMtL2ZegLS9zphIXnCO9m8Z6+puedK69Awg3E5y1EKBkH7/+2Z0h1qI4e55qBarxRZj4IZmMqnPUInfJIbMDU8Z3XLCsxE4336dOgJ2TYEh+jTzpdCvQIab4gFUSs6BDYJfVR0seapCfPeO+FEK1SPDd16wsOVDDp1Zzjwme1kwlyAbX27gPlHNJt83IY3OqkpM9E7YtOj2NEb5orMklL3TRzWIsPvCvKP49R7uIrcF5I94Pj48B4p
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(9686003)(55016003)(107886003)(6506007)(64756008)(66946007)(122000001)(38100700002)(66556008)(66476007)(76116006)(38070700005)(52536014)(66446008)(5660300002)(2906002)(316002)(8936002)(4744005)(33656002)(86362001)(4326008)(41300700001)(7696005)(71200400001)(26005)(6916009)(54906003)(8676002)(478600001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NQoDyGDEPDe+pwWd4U0mLD0MpkhUP6L4Xhko0UuDCmB5eih/TBMhgBJWXxyO?=
 =?us-ascii?Q?+CB0+n9GNrR8Gr3Zh/g6OB/RX9lEo/+xpP/Q2Icf+GSHvWCBlhyoKv54/AkE?=
 =?us-ascii?Q?WLWLPKYeqS7JZRtj7r/+D7z04KiKRHvgFIGtoqsMAvkfvqhy8BsKxkbTx8tL?=
 =?us-ascii?Q?2HKqC/QgqvDE9YkEyg5ASw324IQso+q2UgzeSdpqzYGKkwUQlYGezr69q7Rp?=
 =?us-ascii?Q?qAbj1RTBzCmVHhQs8GkQc7KDg7mG09ELxRs5vOkrPUMKyiVSsNOPq78RHpiO?=
 =?us-ascii?Q?crzzhmd0A/OXtrjPzCbhcvUH24ivAufThWVOgC7jAtedznTSjNz5n+L5hUOx?=
 =?us-ascii?Q?uKBabS7cA+Nq+pGE1iEpO3j5Of6WWxqUoBXh2YCRUReJRrvblhEfqzu9w619?=
 =?us-ascii?Q?Lw7lO+epANlBQQhuP6IE3GHf+uc/UfxOOhwTdKwbGFcld68xzFUJp/ZfYDLZ?=
 =?us-ascii?Q?37CR45StzyUMI6QIoAAijPOqabGUDf89MkbF8uEvQqGwaMLdFkh6OQFTSVFb?=
 =?us-ascii?Q?63Zfb8iIgPeeTI11O7ID+ilydj78p29J6Td4SFzVgzpEB3gZGxXnZIpkIzRu?=
 =?us-ascii?Q?TV7+uIR85Oo/lP3eK2vmoCjiHwmXwyfehzAE6h7cDrJXEndzZfWtJegehHYE?=
 =?us-ascii?Q?ISzXSxuEJTg3fVRBzcn76yizYb9mJjYfX3HMFSEzySRNla/ByVXJa+dublIj?=
 =?us-ascii?Q?kpvd435MyoDVS2bMJina7JernnXLrvA5tWepI1RDlN4wwCyeGS6LyD9qImKH?=
 =?us-ascii?Q?/BxGW4yVNGNZ1hreDZe7FSYZvNum56cF/OrWEe31G0/oeDeFXBlWXXLwlQ7J?=
 =?us-ascii?Q?o1GdUpyp8oBSqpOnsoVXGSJculZ4BozOfFEPGVpLKDb9r8CtjABrNFHiaBuY?=
 =?us-ascii?Q?N8aapwVCpClQ1pa2ucalX9md2tH7yb55Cyt29s1y3zLI6tevS8CU48dSmLNY?=
 =?us-ascii?Q?N36n4KjwqleRv5UP5E8bImrk/I98BMcgcSGXxfU3BiKCzQ6BAZAxpWWE4CqG?=
 =?us-ascii?Q?baUBEw7IlJyINZr4G7jVSB+6ay7hgzfe3XIDRfs+o/eHeDV6qGc8vULFZE5V?=
 =?us-ascii?Q?zxzuJY3Ru3VubECyMRy565S0x467zgMRMf52YvZ9mz3KK7BQrp3SAKKucTTD?=
 =?us-ascii?Q?Eg2B7PuibR83P2pP7ldgKKE4JSIXWLfXD2/CEptM8/EfRFrea+V1hFtfDXmB?=
 =?us-ascii?Q?ODndEGuB8I8/Bw6RcoR5GOC/OUd3ob6uA+BJL3sBV12kFsgIv2G2tJNaq3wc?=
 =?us-ascii?Q?TgVXVdnuPhDUpoZcOKHD/0aSXWkWrga5l8RIctSuLwMst8Kfep02SIqedKEj?=
 =?us-ascii?Q?GDLUBGwjX8GegkJXBf6yk9+xXrAHE7eJo5U/YLX3HLTaAFPsmpDtcE6UiEof?=
 =?us-ascii?Q?/QzyoMdTZyRzB+qBNPB1Arm6bkAQnWbupjUJBe0bYD6xa7FcgfyrbLOsfn8y?=
 =?us-ascii?Q?J59S9CbzaZe7Bhp0+pldLrt4tQydqR41cjgW5tmAPWUDs8cT5LjBn30DyXET?=
 =?us-ascii?Q?TQRt2TgYYryTqtFpFYdKt7aXRUJJ4ASghCS6dDjwP79d5x3cTZ7MWfCg/AiH?=
 =?us-ascii?Q?7O40i7F9COUYjo1sKgg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823e6609-1c7f-4915-9c37-08db8a1d873b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 19:06:03.0399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZcZtOAyD2CNIHHKiAYM09k1mtB3OFFZPh4Ad/jcNLvdi2qkAPkL4W56wTNpJdIUUcfjtlN3tPgLD9rJsdOfwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> What is the race condition; what does the stack trace of the NPD look lik=
e?

Hi Vladimir,

[  OK  ] Reached target Shutdown.
[  OK  ] Reached target Final Step.
[  OK  ] Started Reboot.
[  OK  ] Reached target Reboot.
...
[  285.126250] mlxbf_gige MLNXBF17:00: shutdown
[  285.130669] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000070
[  285.139447] Mem abort info:
[  285.142228]   ESR =3D 0x0000000096000004
[  285.145964]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  285.151261]   SET =3D 0, FnV =3D 0
[  285.154303]   EA =3D 0, S1PTW =3D 0
[  285.157430]   FSC =3D 0x04: level 0 translation fault
[  285.162293] Data abort info:
[  285.165159]   ISV =3D 0, ISS =3D 0x00000004
[  285.168980]   CM =3D 0, WnR =3D 0
[  285.171932] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000011d373000
[  285.178358] [0000000000000070] pgd=3D0000000000000000, p4d=3D00000000000=
00000
[  285.185134] Internal error: Oops: 96000004 [#1] SMP

