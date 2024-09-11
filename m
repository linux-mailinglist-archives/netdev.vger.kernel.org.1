Return-Path: <netdev+bounces-127224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE020974A1D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEBB287C94
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 06:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25995B05E;
	Wed, 11 Sep 2024 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="WWv1gkK4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BCA38DE5;
	Wed, 11 Sep 2024 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726034894; cv=fail; b=brQOMMToBZ9tFvy026tLqLbSjUMvX0I8XidA4Fnolnz52obE5z3fCn6q+V/2RdPxRHwUHFBGQPFquR3sha6xhmbNPGzUxykqU31Wba0AH+o6HLy4jlhBjB7soR5LMiz3Q7SGNEjCt5QSMP99SxXAn2YGfNvfIV3EMIrmUiITQxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726034894; c=relaxed/simple;
	bh=RuxT2REpLSyXPFq07vFgzQN1uAfOXTvADWjMvSSATuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O6WyyGFTMFTSePPUDWcqGp4ZJ/uqLJKs0bnUcmIcZ9z1NH+BrX2GCPcfjghdtaEsRFt0cl7NCIUNznDbhKC0v6B//dwqG76cCN3gehs21sAw5X/wFG0vbbLeeXB5TLquKctLFIXr9dgr52IJ6nqyXzgOiSOREmsq11xrehIYaEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=WWv1gkK4; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AIuvxw016525;
	Tue, 10 Sep 2024 23:07:51 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41gyc0d46y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 23:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkqK3Y7cO9GQlgMg37D7fFSsdjsXjrqolp7mabk5oSoku/nhB5fSGJ7QlikYE9t/Y5vMB1eQC+n8RVzq39/zx48cPfww8Jqkk4pkIWKsoKz1c8quPU39VA7lHXtEo6c8RZUkCRC96qaB1w3MaiyfRo6DfXP92TzLswPy72skyCnbleC1OHtmu5BUYMVL6heLa8LAnZtCixTKpXUNZINJ6AOmtRaDCl7kqHaFt7HxjAqjdI6vxpJL8jQ4mgVRFWoYQp40qQAwrCE9TgmfvQAqCjA0hEJIENVJz38PJre/PwXPxhuIQ1O/I/huO4q9bcOUc3ONLMbbWEQJSgrB1hAQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuxT2REpLSyXPFq07vFgzQN1uAfOXTvADWjMvSSATuI=;
 b=nIvO0ricVXauEqs3DSUVkTfNXo7THa51NwS2nwfZGz9MpnWOdCo5yRglEWFKFk5TLKogs3UCtgW4dXbVQmz2d/9wNYK9RZzca6PeKailfHrUH8VlcSlDgGaH7vDi+SovFvbWlCnn8jhNwZACiYz80iSfZxtHEXUZ2Lqthy9v/D3I+lAH0YHpGZck5zRqcVv9kMmqG+iT+e7ayIbyRhDaWEaiL6/ihAPWWYtLRPe9BOt7p1m4gBM0SPQ+XCttXMRHI73FVIuy2JDfDwS967zcoZm//OhPfdDdWk00UAIkCPbzCantwdPTJcuNifi3AKf2eXZ6HNdinj+T6zG1eQJ2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuxT2REpLSyXPFq07vFgzQN1uAfOXTvADWjMvSSATuI=;
 b=WWv1gkK4lvEd0bbGaZ7wIivqg5UU1qbwIvHz/6amyxnF/9V7iYue4H9GzHmqQ8/bhxgS3Vs+rhSrFvplAL9s2ft2wmT5YHaDTo262AL5zUP8p65A6nIZw/dHvmd2cjc7K53nNOiUxKEV9ouJJOduYty8XJ6ENfxgN/yRlD338KA=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SA3PR18MB5603.namprd18.prod.outlook.com (2603:10b6:806:39d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Wed, 11 Sep
 2024 06:07:48 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%2]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:07:47 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v2 1/4] octeontx2-pf: Define
 common API for HW resources configuration
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v2 1/4] octeontx2-pf: Define
 common API for HW resources configuration
Thread-Index: AQHa/3jzmgJLeNIpo0Oh/KE+wuw+5rJQygOAgAFYGnA=
Date: Wed, 11 Sep 2024 06:07:47 +0000
Message-ID:
 <CH0PR18MB433931A363A1213F114DCF91CD9B2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240905094935.26271-1-gakula@marvell.com>
 <20240905094935.26271-2-gakula@marvell.com>
 <a914a5a0-5726-40dc-b5cc-4f5924059ced@redhat.com>
In-Reply-To: <a914a5a0-5726-40dc-b5cc-4f5924059ced@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SA3PR18MB5603:EE_
x-ms-office365-filtering-correlation-id: e14050ce-09fb-4c8e-dd60-08dcd2280f62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2dsS1pNdG55eTBhVG9CdlIvNmppZ1NWWGRkaGM0OEtpUGpZR3JUZXlwYnVs?=
 =?utf-8?B?RVhVemozRlRkUjZ5eUE1SUwvZXQ1WFB4WXg3d2c0TGkyeFlUZkhqd2d5dFhJ?=
 =?utf-8?B?bW1xbllnbWtBZEhEb0t6T1UwVFY2NjE4MkNTdmFja1FmaUtXdVM3MHNOUUtH?=
 =?utf-8?B?V3dLMFZnU28yMGZyakVhYnZTNW5na2dTSms4N2dJY1VQTVFXcncyRlNYODM5?=
 =?utf-8?B?WGxhK2REWndBUE4wbUcvMk0yLytTR3BwK3dKOVNUYTFqWFF3c3NlY3BMaHlJ?=
 =?utf-8?B?OE9nMWovUmlIY1dnV0p0MHBEUTZsZVcyVSt1WkF3ZW9VR1pWSTJwdkw5R1hT?=
 =?utf-8?B?SW53Nm1FSjlwK3VmR0tXV1BuRWIwbUtQZFVwVGVaSFJLZUtsSDUwb1ovZkhV?=
 =?utf-8?B?S2dyRkdUL2psUS8xMWhJOFVhSC83V2ZHVk5uOUtLWnh2Y1ZVb2lhVGpTUno3?=
 =?utf-8?B?Z0VReDlybTY5K1Y4MkJkSTV3L3Zoei9QaC9NUVY2ditkRDdVcGNkbnJjQUx3?=
 =?utf-8?B?dlRNSUZ4Z1NDc1FvQ01FZnMwNjhvc2VXcG4xSFY4amJzeWFoa0s4UGNMQXY0?=
 =?utf-8?B?VWNBVFJ6SXhwY0tPWm8zbUZQajd1SmltYklCOUVyanl5NW14dnFWRERWUkF1?=
 =?utf-8?B?cjU1S2ZwQk9VSStiRG9FTVNOYW55bS83S3puSitaMVJHYklKeCtXUTVlTkkw?=
 =?utf-8?B?N0hqZ3lsM3dxTnY1RWxmSk50ajJ0dnZYeTlzS0pKRGNjWlBkQXlQdXBTN1Qr?=
 =?utf-8?B?TDdNMDQ0MXVtSkxIQ3h3aTlWb25yaEhuOU5GZ0kyRGdYTThhclVPT2hVUkx6?=
 =?utf-8?B?UkF0TWFDVFJTUnpqaCt2b0lOcld4MUtPWlZWSlFIOWtoYXF4WFpFeGx6ZGFa?=
 =?utf-8?B?NTR2WFkwSmhDaTYyajM5c081azFndjVEVXpVNlV6dEVaSC9JeUZIWW5oTlJW?=
 =?utf-8?B?RXk0QXQ5R3dEL1hOb3VROXJJbWliaXlFWk4yR2JBMHR2TzNFV3dLTE42ajVF?=
 =?utf-8?B?MlVxT2pqeTM2VUVWdDZhTmdSSTN5Skxxb09NZkZYL2VyRityVTBSV3ZiL013?=
 =?utf-8?B?UGFsbU92Z1RmT2lHeVVlYU1TbVFwV3NDTHd4MHp2cGF6R1VkNjdXcDJTU3Ra?=
 =?utf-8?B?VHZQdkJ6eHNxMDhQRktrR21TMjNWblZyM3dBNFRaNUovaUFBR0tZYmZWMFNu?=
 =?utf-8?B?ZmI2VnZQSFRma05aNXpmbFdvVGttYkR4U204M0p6a0M2K3o0ZmV0THRIU2Ft?=
 =?utf-8?B?VGpnaHkvVEgxMGRFUHFoQnY4NjRzei9QeGNudmRXNWNDMDZUT3JOSFB1bytW?=
 =?utf-8?B?WnAwd0xuTHBlbWY5eGNGc1IrWkdJazdPaFVQVmNTRVJmT05ORjlOMTVsZkZs?=
 =?utf-8?B?U1BPZnNvQnBCMXg2OFY4RVVNQUtYRHBUa1VYOWVMaVByU0ZKM0ZlbFhxVmdl?=
 =?utf-8?B?SDZZM0RoaGRCb29NUkdqRU8zWFAxbHBjdktlMjF0TWFRaW16ZDhzcTZXbWhJ?=
 =?utf-8?B?RUc0NnN1cVR3aUJ0ZzNXWW9TRXk3d2Q1UnU3K3EyczZCNWVFWE42bnVXdG9Y?=
 =?utf-8?B?WUhhb1NwbkhoUU9lOVdLVFZSRGdyMFRENWYxZGxSRDdkcG1VS3JOYXF5T0Nw?=
 =?utf-8?B?TEZtMjNvOGthVS9qZHp2TE90LzFxYlVqbTdjak42bjBuYUt5MWo4V25zSURZ?=
 =?utf-8?B?N0lLMjhxTnNUb3ZVcnN0MC9NRjRhVURBMTI0OG1FdWpVeVNjUjE5SHhvN0JN?=
 =?utf-8?B?MWtKdXk0bWdzSWdMSG9MYnBWYi85MUQ5ZXl6UVJnUmlTUENwak5DV3pyS29N?=
 =?utf-8?B?ZnVaK0NrS21McnptTThCRnVFQkJpZHNOSTZWeUxLaWIxVXNUMFpoTklTb1BW?=
 =?utf-8?B?cmJPQmQ2cFNGcGwwYWR2dWhSYm9rOUZKcktzYlBVQjRSNWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUNvWEFCSDEvWVlnUHdjTEJOdmV2eVNmRlRXbS9iNzVvemJIQzdwZTBFNWRz?=
 =?utf-8?B?KzgwamNieXFmdzZwTmNHMVVpbmZhVmVFYlBNbG1XV3UxSFVHdyt3Y1M1bUl1?=
 =?utf-8?B?UVRUbTduUFZiaHFnSlJxMGF4ZU9NL3h0NzgzMlhvZzJYUGJLRVRVcDN1ditD?=
 =?utf-8?B?dEZIRGRkZEY3L2tDWW1oNW5jUm5XZStRUTJHQWtDb2s1eXJhUDBjYWtQOUI1?=
 =?utf-8?B?Tkc1NHZ5eVU5M2NOd1gvdFplcit0SUVYN0k3VVEzYkF4QUl3UC8yNU84NVR4?=
 =?utf-8?B?QjlHTXJ0SnR5bys1SmJIVHFDRkRHaWNjaHdrczFYOHVoS0lBd1VON1Jucit6?=
 =?utf-8?B?YVBYRjBXUE9BV0FtajM4OS9QY21WTkNjNGV6eU53Q00vRFhsQ1NET1ZJelkz?=
 =?utf-8?B?UXdnZVNGQ3UvQUpXaVRiS2RkWlVWY1B2cStYZVd6ZXFiOHdJcmpxc3lGTmNr?=
 =?utf-8?B?eXo5Z2NCRzI1bTExZnNyd1M2MWRoMkhwWGdoT0MrWEMvZzhaa0pDOU12Uk5P?=
 =?utf-8?B?ZVFPRXFicHVoMWtVTDJITyt0M3k3bE1rTUVHSjBqenNzRnZwb0sxRkVIQVZ4?=
 =?utf-8?B?emFDUTNVRjFqNy9zNEN1bDJBV1M3SHFDRW1mMGpHd25HbUdnaU52RUNycFZ5?=
 =?utf-8?B?R2lCMkhUcmVQWU9STkxyUE92a1hzUFpUQldidGZkMnBvd0RUNkd6OHh5OVRX?=
 =?utf-8?B?QXkzbmgrWG9qODJON1BsWXV3RHJ3alI4T3JScnRjNXFEMlc4T1g3eW9CSzJv?=
 =?utf-8?B?eE53YkN1KzViU2FHQmJjVHFrOUJ4WFBFdVpxTENKZVNPMitqRzcrUlE5eW1Q?=
 =?utf-8?B?NGNEWDhsYlJoYTNyOC9mclhhUHgvZVgzZDlJTnl2ZjBCYm13aWpaOWVReTFI?=
 =?utf-8?B?YXdGaDd2Mmw1WkJUYUtkbHRSV1pBS1dnT0hFbldNZ0NsZkxua3BXT1pQL2FV?=
 =?utf-8?B?WUd3K2dtMXU2aVpQa2MyNFRqVXU2NjlDUnBvU082ci9kVElOaVRlTnRXYWtv?=
 =?utf-8?B?VHFGSE9NcWtrQ1VwR1hmQkkzcHJoa2N6eUFqS09odkJmekFWbVVKcEh5Q0V3?=
 =?utf-8?B?dVc5RXlWOXdaM2I0RkdYMmpUc01TejQ0cW11bUdxUEtVa2pQOStHbXhkVjZW?=
 =?utf-8?B?bWFDckhIelFMdTM4Wkp5QlQ1dG5HQXVlQW81M0dQK2hzMnFaSVlLRFp0ZnVQ?=
 =?utf-8?B?K0c1TDljckpGQzV6WGRic1VYcldtZWoySmF4NTB4SXFUYnRBNGYrUitsMy9U?=
 =?utf-8?B?UzNVZ3hHWWpjQ09oRU5ycWNEcEdJQ3FENnRFL3ViTzNIL2NDRmF3cStmb0Ur?=
 =?utf-8?B?MEdwbldka2puK09qWWpJWWdKZFZMMVZmZGd6bnN4aFpSSjZ3cUk4VUJVaTFm?=
 =?utf-8?B?L1lZRXU0cEU4ekw5VVVYWWNLeE5BQjBpMlc4ZFZoclNEQmt6MWgvREhRaExE?=
 =?utf-8?B?Q1VreWlQNTNhblF4Vlc3aXQ3L0RKTnVSaHdHSHJGUDJKWkFtMXRRM0RIT2tQ?=
 =?utf-8?B?Q2I4TkZWTStubEFIbXNmUG5SUGZOcUJTZWFVMmVtbHJjeTVnS0YrKzF6VFVI?=
 =?utf-8?B?d0g2MVJac3dPeEJJS2NCSXJ2SDQ3OHR6RFFhUGx0VmJGWE9hWTYyRkhwTkNw?=
 =?utf-8?B?S3ArZFJ4S0FpS3JNaCs1YWJ5Y2hzMXk2N3g5c0JEM0hYNG9UN3IrSXpLQTV1?=
 =?utf-8?B?SXRTWUFDd2tNaDV1NTlPR1F6c3c3ZWlORVMzZkhkdFJSaUtQcGRKelh3bk1j?=
 =?utf-8?B?SmZBOVJqbWNUU0IzbEhMMytyN3BFL2psMkVnQUQ0dVFmU210b01DaXFGQ21o?=
 =?utf-8?B?NXhNa08xVUpyVlRYV3c4SVNVTmNZWVZuWlRJSTlSa05ta0xsSW9RcjlrWElM?=
 =?utf-8?B?M3I2YnlwYTcrelNOVE9GclcwWXJ2U2x4VkYzMWM2cjZ5OXVhVEJwUUdMWG5B?=
 =?utf-8?B?Snd0bEpIeWpxRmdJWGpRc3BoUmpwZ3pIQ3BaUHUveHZTOUNTbUo3eDJ4d1Bq?=
 =?utf-8?B?K0JZeHJPYWF6ZnZNQmlQb2xuN1Ztb2pRYUZwaFRFQ1VsMy9aOHh6ZkRjWk5w?=
 =?utf-8?B?MXdPbndmTFpJaWRRcFBselBkQUdtRHJ1U20zdysyaGdNaTVFWlpRRk45a3hI?=
 =?utf-8?Q?HgUY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14050ce-09fb-4c8e-dd60-08dcd2280f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 06:07:47.8114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f//HdklOy1sPrUuHNwHTK6ADyCBfFKEIImmoJnYpV3gDAFvxc0KXjZmx1vTfA3S+6tMGAiPrs33x4yAr45Gnag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5603
X-Proofpoint-ORIG-GUID: uA-ULqMO6LaVPxNxUi1Z4UiovVtTEgID
X-Proofpoint-GUID: uA-ULqMO6LaVPxNxUi1Z4UiovVtTEgID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTAsIDIwMjQgMzowMyBQ
TQ0KPlRvOiBHZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2FrdWxhQG1hcnZlbGwuY29tPjsgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+Q2M6IGt1
YmFAa2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgamlyaUByZXNudWxsaS51czsNCj5l
ZHVtYXpldEBnb29nbGUuY29tOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZl
bGwuY29tPjsNCj5TdWJiYXJheWEgU3VuZGVlcCBCaGF0dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+
OyBIYXJpcHJhc2FkIEtlbGFtDQo+PGhrZWxhbUBtYXJ2ZWxsLmNvbT4NCj5TdWJqZWN0OiBbRVhU
RVJOQUxdIFJlOiBbbmV0LW5leHQgUEFUQ0ggdjIgMS80XSBvY3Rlb250eDItcGY6IERlZmluZSBj
b21tb24NCj5BUEkgZm9yIEhXIHJlc291cmNlcyBjb25maWd1cmF0aW9uDQo+DQo+T24gOS81LzI0
IDExOjQ5LCBHZWV0aGEgc293amFueWEgd3JvdGU6DQo+PiBEZWZpbmUgbmV3IEFQSSAib3R4Ml9p
bml0X3JzcmMiIGFuZCBtb3ZlIHRoZSBIVyBibG9ja3MgTklYL05QQQ0KPj4gcmVzb3VyY2VzIGNv
bmZpZ3VyYXRpb24gY29kZSB1bmRlciB0aGlzIEFQSS4gU28sIHRoYXQgaXQgY2FuIGJlIHVzZWQN
Cj4+IGJ5IHRoZSBSVlUgcmVwcmVzZW50b3IgZHJpdmVyIHRoYXQgaGFzIHNpbWlsYXIgcmVzb3Vy
Y2VzIG9mIFJWVSBOSUMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogR2VldGhhIHNvd2phbnlhIDxn
YWt1bGFAbWFydmVsbC5jb20+DQo+DQo+Rm9yIGZ1dHVyZSBtZW1vcnk6IEppcmkgZ2F2ZSBoaXMg
YWNrIG9uIHYxLCBhbmQgSSBkb24ndCBzZWUgYW55IGNoYW5nZXMgaGVyZQ0KPldSVCBzdWNoIHZl
cnNpb246IHlvdSBzaG91bGQgaGF2ZSBpbmNsdWRlZCBoaXMgYWNrIGluIHRoZSB0YWcgYXJlYS4N
Cj4NCj5Zb3Ugc2hvdWxkIGhhdmUgaW5jbHVkZWQgYWxzbyBpbiBjYXNlIG9mIG1pbm9yIG1vZGlm
aWNhdGlvbi4NCj4NCj5Zb3Ugc2hvdWxkIGluY2x1ZGUgYSBjaGFuZ2Vsb2cgaW4gZWFjaCBwYXRj
aCBpbmNyZW1lbnRhbGx5IGRlc2NyaWJpbmcgdGhlDQo+bW9kaWZpY2F0aW9uIGZyb20gcHJldmlv
dXMgcmV2aXNpb24sIHRvIGhlbHAgdGhlIHJldmlld3MuDQpXaWxsIGFkZCBjaGFuZ2UgbG9nIGFu
ZCByZXZpZXcgdGFnIGFuZCBzdWJtaXQgbmV4dCB2ZXJzaW9uLg0KPg0KPlRoYW5rcywNCj4NCj5Q
YW9sbw0KDQo=

