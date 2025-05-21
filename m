Return-Path: <netdev+bounces-192284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBCDABF3BD
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0268C1F04
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5734E264A92;
	Wed, 21 May 2025 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="qI9rdeyj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50768221D8D;
	Wed, 21 May 2025 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829250; cv=fail; b=l8uHoudhybWX6RnwpN+wPhUACr37NinFb8zuDn9KCAhEKfneb1f+GA33qQHul+vc48JkwsfMYEHRgcw8CEBTVncXW7RhUpIEZ5h1/FjrmyI6eFri+EvtcmPBxvw/mxeX2UVgcO7LrPG+FQNECVDf4uaD7eqDx4nhcvgJ+FM/J+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829250; c=relaxed/simple;
	bh=hODGo6qfqEGhJR12lJ/Z4EnMKZHapxIAUgJITsu70hg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIzgQVMfhUQyakwBtd1YT/4FRZk0EDNUKp282Ys5doFXgru1HMnMP8a9hTxbA4iyd6WbJR1dH45vzt4KzpCJ9Kf9a9yU+d4iG1baJqQRD+CRkPVjSw2tPlEx2NuPO1dn1fJB3BSdKW6Lmom5ghA91x7BCbF9+JJX0wfSKgg+9vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=qI9rdeyj; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9s42S015914;
	Wed, 21 May 2025 05:07:09 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3pus5by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 05:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmagNWGFuudUFc4re1gY3+/ofpDDlF/c/vATNTvWJSh4UlcwYrkdwO5Isa5+2W9C7ULkwnT1hDXt4OSeyD+N1n/r6M1fJUg/5nwZxFentspasqHuE6oorHqVX3uVpnsD+ocJEfOVQFoSIfEG3Gk4tmPCdyyYiUkYzIKlTUxeVy8W8/xgHwk/wQSAHw0STP7ObghVUvq2+zJu3dsj7lnd7l3Ewd1MGVyeAXQ08wxmE3zc35oew27vJnrOSkAEHGFmABiRAI8RGnHemFpA7AEQ+jvOHfAqr4plbq56C0tVrh3cwuIpKeecr3DZ0iSYJZm+CRpcfCLrJziwqSZcRaUOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hODGo6qfqEGhJR12lJ/Z4EnMKZHapxIAUgJITsu70hg=;
 b=S9kT3q4uOq6zDNfQLVBt6xoOkMc6Iv3L2BiYf9IHKvWNPpByIG9sHIDhZxkK2RCR7457l+1hhjglgVs4t3ZN03Dd1QJOn76bDfKQTWjKq9E+zHtBAcG8xTCKFvL2vFBABMFTB2kxDJqv6uoAs21jUVDcx9OCeGUJa5FMXEkA+pLEXAV+LB4X3HZnchNqkBzjgl8HZsS0J44KwC/z5myOMyboALrs78DoHRqJp4EWSwmPvY4zE22ppvHXYqQ8F95vZO/mryZkDz5btmHZ6Y/g/MUvwVhIOEq4rBzDKqzf3I+oPNwOv+0UOzPBp0DOBQUxK1iKaSu9M8OIybRDy2J7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hODGo6qfqEGhJR12lJ/Z4EnMKZHapxIAUgJITsu70hg=;
 b=qI9rdeyjCb5VjXP4zer4Z+ltM2mId1583BTCwVb29ndhyXRvCKsbrrAfFWV4n6VsYqOur0G3FL7dTfQjiLOZdLr4fBs7eMqkwm5JAiwJ4lshJYR/wl42OOEgiApYf99Wm9RpL31sfPyIjnMxKrb2eJBx0jqb9HlHZCK/RJoKmeI=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by MN2PR18MB3496.namprd18.prod.outlook.com (2603:10b6:208:269::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 12:07:04 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%7]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 12:07:04 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>
Subject: Re: [net PATCH 2/2] octeontx2-af: Fix APR entry mapping based on
 APR_LMT_CFG
Thread-Topic: [net PATCH 2/2] octeontx2-af: Fix APR entry mapping based on
 APR_LMT_CFG
Thread-Index: AQHbykjdxrq0r4qx1EWWDAk54TpiWA==
Date: Wed, 21 May 2025 12:07:04 +0000
Message-ID:
 <CH0PR18MB43394C628856976D81897627CD9EA@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20250521060834.19780-1-gakula@marvell.com>
 <20250521060834.19780-3-gakula@marvell.com>
 <aC2QdjlVJTNhfvV9@mev-dev.igk.intel.com>
In-Reply-To: <aC2QdjlVJTNhfvV9@mev-dev.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|MN2PR18MB3496:EE_
x-ms-office365-filtering-correlation-id: 23a805d4-2908-4701-f5eb-08dd9860005a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXBwTmdVQ3haVTNtbjcxdlJtc0NWMnBQdVd5dmxld0NuRjhOR1ZIRkcrRTB4?=
 =?utf-8?B?Y29GNEt5azJMMm5LeVBTWEpTTnRUbDVmQy9CeWtTMmwwSWxOMDIvOUJOazZH?=
 =?utf-8?B?b09RbG5FdUVCTmJNeExZRDFGL2wvUjFJNjlJOXEvVjlWQUtPcE44SVZ4V3dX?=
 =?utf-8?B?dnE4d2YweDVTamd4OVlEL0J3SlFIR1JXb3NQQTNLNU5lczNaNmppaTZIN3VO?=
 =?utf-8?B?c1Z2eUwvSjYwVmVibkYvMm9LOHEwUjNOSzJ3ZjRZeU1xWU4xQ21LcFNWTmls?=
 =?utf-8?B?Q2NDWWxkeWQ2amM5QWZkSTduaXhFMll4SCt2K05TVWl5TmlzK1d0eTNiNEtZ?=
 =?utf-8?B?T1N0U2tXWG5iZnp2VlR5TzNabVZ3L1V4VjJnNmduMWxUSG16MFJMSVRDaStP?=
 =?utf-8?B?VzlYWkdpOEIvQUxyMXIvKzY3LzFxS3hwVk4vSDNQMTI2cm1TTUhJcUNHK2pU?=
 =?utf-8?B?My8zNVM5MkRqdHZCWFJreDhPaWtLZGdncEN3ZG5pNnNnU1ppT0NiREc0WWhS?=
 =?utf-8?B?NUY4T1Q5cFJWU2ZweU01MFptbExEUUhPdFgveG1jTXQvVmxXeHdnU2trS2Fh?=
 =?utf-8?B?Zk9YWmZOYk9FM0lCaGpuZlB2UHc0dEtTaDVtR3BtWE1neE9wYnBqdUFDcjR3?=
 =?utf-8?B?R3RVbUlLQXVHenluR1MzR1VHMnRGMTdaTStNQjZrdTN4TWtCdGVoL05USUVw?=
 =?utf-8?B?SVNEV1h6Uy9PeStzaHNwOGlwSVlMekJKRjNiS0JDN0p0SnZTRU9zNkVwa0xy?=
 =?utf-8?B?UVRZd3dDdks3dFdqbmtxa2FMZGJzem9RWXJkOTVyS1laRm1vWm1LWDh4cW1o?=
 =?utf-8?B?L3Fod3V5aWZGNHFJUE12T05qSDVRMEs3WlZIc0lDbU9hcHBOU3ZMUnltQnU4?=
 =?utf-8?B?bTJGb2dCVTJURTNiSXdac0pYUFd2VUI5UVhtcnlGbVY3Z1FYanlROVRrdUJ3?=
 =?utf-8?B?M0duRlBCYk1ONXhDYmVTTGdudDlhcE53a1ZNdmxPRzFsVUV3MW9uV2Fxdllt?=
 =?utf-8?B?UGJ3bkZ6S1hxbGNQUkJqaStGVUlidWRYeHZvRWJ6SytuRFlUNzN2NGxWbzdD?=
 =?utf-8?B?NVJ5QVE3UTkzeVNIYi9YdzN1bjE2RHBXUitJWStvek5sT1UrTUc0WHVyejVt?=
 =?utf-8?B?SEpxK3NERndCaXAxMVovRmQzMldIRzk0Rk1MSmd6S2ZQVmt3YjEzWWRHUm1s?=
 =?utf-8?B?MXNKNHM2OWVUZlhRYWJaQjZCTEF1Qzl3Mmt2WUgzNzYzaUxudDB1dTFiMFB4?=
 =?utf-8?B?bW83K2VSNVZJR0ZsSFJCc01VajRocUp1TWdQMFoyQmdxYW1oMjVUU3pMampo?=
 =?utf-8?B?VDFWeDU4S0VIdnBkbXdXMzY4Q3ZOTExuSituVG5wOUo1RzVxa1UrTGlqcDk2?=
 =?utf-8?B?cWx5Tk1pWEYxUGlMRWNsWWhmekNpYzMxS2UyelRkSVVKMUFLeFA4cmFIRkJX?=
 =?utf-8?B?SkhQMnp0cDk2K041Rk9WZ21EY3NFeDgwN0tGaUpRczVjL1lodkpLMVJvTzA3?=
 =?utf-8?B?Sk5Uc3ljazRoMHFrREZaRkxZMjR4RCtoQzlTMzJETzFBVDVVbVU1enJkbi9G?=
 =?utf-8?B?ZmJjQkVFa2lwWHlYdFVWOG9TbWdzczB6ODl3TGY0bW92R3lvc2pOKytYU2pi?=
 =?utf-8?B?V3krT0xJMkN0RmgvbWE0azBVK01vVFlxcEMwT2VOTVQvRTgweXo2b0lTQW9n?=
 =?utf-8?B?cnB1dVVxenRxWU5YYkU0U0NUVE1Gc0xzVmRTSk1NdHE2bVZqMmF4c050bDZO?=
 =?utf-8?B?WFpBbUhiV0o4RkJVWHY5QkxDbDBhcnpsZ0dWNFBweFVNR0puMVZta2lnc295?=
 =?utf-8?B?eXN1VW43clNoVG9ONWlzL2VCaEszNDlyZUJ6Y3hyNHRyQS9LSTVZajBwWEFy?=
 =?utf-8?B?c2JTejdtREFtTGRDQnhEdzl3STN1UG0xeXBxUGZ2RHJhRzRJU3JNaGszMXhF?=
 =?utf-8?B?S0V6MkhlTkh3UVU5TTEwQ0dwVVZUZGpac2xMd3ZqMHpFVnZBMU9hM2w0UlRP?=
 =?utf-8?B?S2MyT3FDRXNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlhwVjBFY3dXNFdWOUxJNWRQRFlTRXdFOVpvTGEzdFhJY2dkcXc3aHVyVXVM?=
 =?utf-8?B?L3JvR3ZtTFg1aGQ2d0ZCYS85dmIyUjRmSTYvcTRVS0FyTEZuNnpSQzlvR0NZ?=
 =?utf-8?B?TTk5dEVOYmtIR1dVc3RYeVFtQXAzZGFGVDB4TCsrM0JHQUU3aGwxci9ITDh2?=
 =?utf-8?B?Z3VjLzF2ZjJoRk1NVTIrSHIvY0xFL2tjK25XV0FnSXB0bmlkaVdEQUlVU08z?=
 =?utf-8?B?U1JiMkVMcXlMZlNSeUUyVHJCYVltdSt2UU9nMnYvVkt6dWxZS1JTZkJTK3Va?=
 =?utf-8?B?ZHlwckptbk9uQVdjdlN3cUE1Q2s2cnJDY1dTenU2M2N2NTBUTUV1WUkyMUtD?=
 =?utf-8?B?OHFNY0JZTU9kd0ErY3YxNjExQTJ6djdVSW1aQy9hbkpobGxYL3NhZExEWXNu?=
 =?utf-8?B?Uy9XeU5iT3FqdzVXOE9BTzZsdDZ0cW01TWNBenB6VTAzM2dFOG1lenBqVG90?=
 =?utf-8?B?QVpEZzZ5YTk1MWpKRC9keVBkMTBmOHNaV3grUnU3cDNXcXo4SEN0d3A0Vk9y?=
 =?utf-8?B?ZUdHVVVmOVJHU3BYZFh6ZXBnVTFwYXJkNlVhV3hkeG4vQWFiczlETlRkVDd1?=
 =?utf-8?B?TElydTFDYmxZOVV1OHdiK3JpcDBJelM3cnRtTFBTMU5MVTBhR3VLaExNeUlq?=
 =?utf-8?B?enIrS2xxZllSWFRGelk0N3dmZWFNY0xSRGlObU1nSFg2S0w5c2NLSDZ6cU1N?=
 =?utf-8?B?QW85emtZTDBWTUhlTzRyYUd6N0ZkSVl0cno5RkdocHA4U3l6WEJ6Q2trby93?=
 =?utf-8?B?STFpL21KQzVQdWdEcnF3bzNNdjcrSnoxUnpxRFhyWkRseHRoL0NEWjJ3T0Qx?=
 =?utf-8?B?bFZlTEFaemZIaWxsdkdVbXlMMCtWUFR2SGRyRjRwcndsK2dKSlRlcitNWHpt?=
 =?utf-8?B?V2lVV3VydXcxV01jM1pTVWk0M2REWGs2OTdrNG4rU3BiMUM1UStZQXVNTGNk?=
 =?utf-8?B?WmJQYis0TVE4MEhUQnZFcS81R2VtQ21DK0kzZGpVamVWY2xWQ0RxRUR6NkJp?=
 =?utf-8?B?bTROaG9paUdzMjdsMmZDT2Y5Q1AySkdHK2hqaWRMa2VvVW93QUJTbTg1b0h2?=
 =?utf-8?B?Sk1HNzhOUTNiRVZWU1hLNElDSE4zc2hGVmRoeDBTV1VlaUlyTDFaeGxYUFlQ?=
 =?utf-8?B?L3g1dmFPcGovd2hZZWtuRm80V1phZi8vQmJlR2dYYnl2akRwSENnVjNZc0ky?=
 =?utf-8?B?UnpkSXljVHNaUEJKdzA5SHB3R25vMDBIR000S2JBTGV2TzJKNnRVbEhOOVlK?=
 =?utf-8?B?ZmkxaUxKUUR1RE94QlZtNnc4T2RENFZtcWM5VVlsdWY0WlUwSlBlbzdYTHlB?=
 =?utf-8?B?S252Y1BJSWRNZ2Vibzg3NlhZU2t5b3phK0l4ci83Q3JoRmZmUktUQ2E4a3oz?=
 =?utf-8?B?QTUyeVplZk1OdnRpLzRZRkpzYVhsZ0Q0T2VjbEhjT2MxUmpKL3M5VGI0cGU0?=
 =?utf-8?B?My9WbHQvdUc4UWF2cndJTGxyRXk4SjUraFVvL1VxbUVSSVlJSW5MTkN2a3Bp?=
 =?utf-8?B?Zm42NjFIa1czR1lIamZmQmsxLzNlT1NNNHdGTG45YWFzM3BMWWVzTU1nMDAx?=
 =?utf-8?B?M0xYYm44WTlOSFllY0tlRjM2OWhCaEVGNjVOc2laOGtCaDJkb01UTHkxMzNt?=
 =?utf-8?B?cmJLdXdoU29WdHhaRGhzR1huR2pkZzBjOFNsTGJWaTE4M0hHUHFKZzRyRHNH?=
 =?utf-8?B?MDFoZFloQkNhWFdhVDRveHlRTkZZY2pyNlQvS1JZMTMzNmFNdjdBMEN6VEM1?=
 =?utf-8?B?TXJqRDJjcmZ5dytZN2grQWpYYlJXOW52MXBBNk13cjhmSy9kbGdINXVIaVVY?=
 =?utf-8?B?SVQ5eHdxRUNYbE1scmlyQ3o2eXhwTm8ydHZKa3dob0p0dmowN292aVVRWktv?=
 =?utf-8?B?akdQRU5JMkw2dlo0RjY0SDZMRGdJNWc3bzR3VGZlV29NOGFIMEptQmdVSTFB?=
 =?utf-8?B?RmFVdm1BcllVZ21nL1pZS2d4QWVSQXhWOUNWWEdKWVY1ZXFCL3hMMEUzMldB?=
 =?utf-8?B?YUtNdmRNd2p5VTk2SkRHSnJlM3hURUZHYmxld2lyTldOdStIMmlEM0hTWGoz?=
 =?utf-8?B?NUdCazc4aTY4NUVHeGRSdTh4Sk1udXl6N29JRWRZR2RVZHpYWVh1VFhxaHI3?=
 =?utf-8?Q?h0nA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a805d4-2908-4701-f5eb-08dd9860005a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 12:07:04.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4krRaJjSMyBflXw25wbBuP5Dft+4Qbjn5q3RAjNcU7nx11aGhCQEJALuLA3MASmXgysmz/ApIyJypqzPX8DlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3496
X-Authority-Analysis: v=2.4 cv=SMtCVPvH c=1 sm=1 tr=0 ts=682dc1ed cx=c_pps a=fpyyTn7Kx2iM0+fj1eipXw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=T-l2Xttz1mwtbHAEOzoA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: APdRy6hxNtNvrMT2bKscGjZjupqcoNfw
X-Proofpoint-GUID: APdRy6hxNtNvrMT2bKscGjZjupqcoNfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDExOSBTYWx0ZWRfXwwIjMQSFuIIc VWsYbZQ/zLdU5v83vCRMTGnMaE6Wmsa4LcaYxLRodjDO75es3Wi65iWwFJKxD5I0AbLd6KHw1HT uvOxSulHWmF7A9CgmA48tf0fcBpraX1942xqiPYQpa/kJr1W1JX8YKPiOiXz3c7+ttIbFm5Mb34
 qcplrPFcubU6Tucuncy/YKiHspWmbG2d3z6CvRP2D6tJtiD6kg54PVmk0yzcXMPDuM5EYYWGIxF wxnN8JaR4ryceBv5a77xmaVXiGbxblWUhlrD9OViRq33seZoUNJLuOVRsFczgkeO5PAouvYTShy eezFeGM6RZgCB0lb0r/LKzeT7eRSEskukasll0+LyJB7bi7N8dPi2C1h0f+u2b/J5easaZ64pr1
 3Kl1ae62e7O6wyZGZIO6mlIXatL376JYprwqg4gU80ERqDxM/KpsHelCBlhTD7PY7132Trsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1pY2hhbCBTd2lhdGtvd3Nr
aSA8bWljaGFsLnN3aWF0a293c2tpQGxpbnV4LmludGVsLmNvbT4NCj5TZW50OiBXZWRuZXNkYXks
IE1heSAyMSwgMjAyNSAyOjA2IFBNDQo+VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFA
bWFydmVsbC5jb20+DQo+Q2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGt1YmFAa2VybmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBw
YWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj5hbmRyZXcrbmV0ZGV2QGx1
bm4uY2g7IFN1bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+Ow0KPlN1
YmJhcmF5YSBTdW5kZWVwIEJoYXR0YSA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT47IEhhcmlwcmFzYWQg
S2VsYW0NCj48aGtlbGFtQG1hcnZlbGwuY29tPg0KPlN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtu
ZXQgUEFUQ0ggMi8yXSBvY3Rlb250eDItYWY6IEZpeCBBUFIgZW50cnkgbWFwcGluZw0KPmJhc2Vk
IG9uIEFQUl9MTVRfQ0ZHDQo+T24gV2VkLCBNYXkgMjEsIDIwMjUgYXQgMTE6Mzg6MzRBTSArMDUz
MCwgR2VldGhhIHNvd2phbnlhIHdyb3RlOg0KPj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24g
bWFwcyB0aGUgQVBSIHRhYmxlIHVzaW5nIGEgZml4ZWQgc2l6ZSwNCj4+IHdoaWNoIGNhbiBsZWFk
IHRvIGluY29ycmVjdCBtYXBwaW5nIHdoZW4gdGhlIG51bWJlciBvZiBQRnMgYW5kIFZGcw0KPj4g
dmFyaWVzLg0KPj4gVGhpcyBwYXRjaCBjb3JyZWN0cyB0aGUgbWFwcGluZyBieSBjYWxjdWxhdGlu
ZyB0aGUgQVBSIHRhYmxlIHNpemUNCj4+IGR5bmFtaWNhbGx5IGJhc2VkIG9uIHRoZSB2YWx1ZXMg
Y29uZmlndXJlZCBpbiB0aGUgQVBSX0xNVF9DRkcNCj4+IHJlZ2lzdGVyLCBlbnN1cmluZyBhY2N1
cmF0ZSByZXByZXNlbnRhdGlvbiBvZiBBUFIgZW50cmllcyBpbiBkZWJ1Z2ZzLg0KPj4NCj4+IEZp
eGVzOiAwZGFhNTVkMDMzYjAgKCJvY3Rlb250eDItYWY6IGNuMTBrOiBkZWJ1Z2ZzIGZvciBkdW1w
aW5nIExNVFNUDQo+bWFwIHRhYmxlIikuDQo+PiBTaWduZWQtb2ZmLWJ5OiBHZWV0aGEgc293amFu
eWEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9jbjEway5jIHwgIDkgKysrKysrLS0tDQo+PiAgLi4u
L25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVfZGVidWdmcy5jICAgfCAxMSAr
KysrKysrKy0tLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVs
bC9vY3Rlb250eDIvYWYvcnZ1X2NuMTBrLmMNCj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFy
dmVsbC9vY3Rlb250eDIvYWYvcnZ1X2NuMTBrLmMNCj4+IGluZGV4IDM4MzhjMDRiNzhjMi4uNGEz
MzcwYTQwZGQ4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9v
Y3Rlb250eDIvYWYvcnZ1X2NuMTBrLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21h
cnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9jbjEway5jDQo+PiBAQCAtMTMsNyArMTMsNiBAQA0KPj4g
IC8qIFJWVSBMTVRTVCAqLw0KPj4gICNkZWZpbmUgTE1UX1RCTF9PUF9SRUFECQkwDQo+PiAgI2Rl
ZmluZSBMTVRfVEJMX09QX1dSSVRFCTENCj4+IC0jZGVmaW5lIExNVF9NQVBfVEFCTEVfU0laRQko
MTI4ICogMTAyNCkNCj4+ICAjZGVmaW5lIExNVF9NQVBUQkxfRU5UUllfU0laRQkxNg0KPj4gICNk
ZWZpbmUgTE1UX01BWF9WRlMJCTI1Ng0KPj4NCj4+IEBAIC0yNiwxMCArMjUsMTQgQEAgc3RhdGlj
IGludCBsbXRzdF9tYXBfdGFibGVfb3BzKHN0cnVjdCBydnUgKnJ2dSwNCj4+IHUzMiBpbmRleCwg
dTY0ICp2YWwsICB7DQo+PiAgCXZvaWQgX19pb21lbSAqbG10X21hcF9iYXNlOw0KPj4gIAl1NjQg
dGJsX2Jhc2UsIGNmZzsNCj4+ICsJaW50IHBmcywgdmZzOw0KPj4NCj4+ICAJdGJsX2Jhc2UgPSBy
dnVfcmVhZDY0KHJ2dSwgQkxLQUREUl9BUFIsIEFQUl9BRl9MTVRfTUFQX0JBU0UpOw0KPj4gKwlj
ZmcgID0gcnZ1X3JlYWQ2NChydnUsIEJMS0FERFJfQVBSLCBBUFJfQUZfTE1UX0NGRyk7DQo+PiAr
CXZmcyA9IDEgPDwgKGNmZyAmIDB4Rik7DQo+PiArCXBmcyA9IDEgPDwgKChjZmcgPj4gNCkgJiAw
eDcpOw0KPj4NCj4+IC0JbG10X21hcF9iYXNlID0gaW9yZW1hcF93Yyh0YmxfYmFzZSwgTE1UX01B
UF9UQUJMRV9TSVpFKTsNCj4+ICsJbG10X21hcF9iYXNlID0gaW9yZW1hcF93Yyh0YmxfYmFzZSwg
cGZzICogdmZzICoNCj4+ICtMTVRfTUFQVEJMX0VOVFJZX1NJWkUpOw0KPj4gIAlpZiAoIWxtdF9t
YXBfYmFzZSkgew0KPj4gIAkJZGV2X2VycihydnUtPmRldiwgIkZhaWxlZCB0byBzZXR1cCBsbXQg
bWFwIHRhYmxlDQo+bWFwcGluZyEhXG4iKTsNCj4+ICAJCXJldHVybiAtRU5PTUVNOw0KPj4gQEAg
LTgwLDcgKzgzLDcgQEAgc3RhdGljIGludCBydnVfZ2V0X2xtdGFkZHIoc3RydWN0IHJ2dSAqcnZ1
LCB1MTYNCj4+IHBjaWZ1bmMsDQo+Pg0KPj4gIAltdXRleF9sb2NrKCZydnUtPnJzcmNfbG9jayk7
DQo+PiAgCXJ2dV93cml0ZTY0KHJ2dSwgQkxLQUREUl9SVlVNLCBSVlVfQUZfU01NVV9BRERSX1JF
USwgaW92YSk7DQo+PiAtCXBmID0gcnZ1X2dldF9wZihwY2lmdW5jKSAmIDB4MUY7DQo+PiArCXBm
ID0gcnZ1X2dldF9wZihwY2lmdW5jKSAmIFJWVV9QRlZGX1BGX01BU0s7DQo+PiAgCXZhbCA9IEJJ
VF9VTEwoNjMpIHwgQklUX1VMTCgxNCkgfCBCSVRfVUxMKDEzKSB8IHBmIDw8IDggfA0KPj4gIAkg
ICAgICAoKHBjaWZ1bmMgJiBSVlVfUEZWRl9GVU5DX01BU0spICYgMHhGRik7DQo+PiAgCXJ2dV93
cml0ZTY0KHJ2dSwgQkxLQUREUl9SVlVNLCBSVlVfQUZfU01NVV9UWE5fUkVRLCB2YWwpOw0KPmRp
ZmYgLS1naXQNCj4+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYv
cnZ1X2RlYnVnZnMuYw0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4
Mi9hZi9ydnVfZGVidWdmcy5jDQo+PiBpbmRleCBhMWY5ZWMwM2MyY2UuLmM4MjdkYTYyNjQ3MSAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2Fm
L3J2dV9kZWJ1Z2ZzLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0
ZW9udHgyL2FmL3J2dV9kZWJ1Z2ZzLmMNCj4+IEBAIC01NTMsNiArNTUzLDcgQEAgc3RhdGljIHNz
aXplX3QNCj5ydnVfZGJnX2xtdHN0X21hcF90YWJsZV9kaXNwbGF5KHN0cnVjdCBmaWxlICpmaWxw
LA0KPj4gIAl1NjQgbG10X2FkZHIsIHZhbCwgdGJsX2Jhc2U7DQo+PiAgCWludCBwZiwgdmYsIG51
bV92ZnMsIGh3X3ZmczsNCj4+ICAJdm9pZCBfX2lvbWVtICpsbXRfbWFwX2Jhc2U7DQo+PiArCWlu
dCBhcHJfcGZzLCBhcHJfdmZzOw0KPj4gIAlpbnQgYnVmX3NpemUgPSAxMDI0MDsNCj4+ICAJc2l6
ZV90IG9mZiA9IDA7DQo+PiAgCWludCBpbmRleCA9IDA7DQo+PiBAQCAtNTY4LDggKzU2OSwxMiBA
QCBzdGF0aWMgc3NpemVfdA0KPnJ2dV9kYmdfbG10c3RfbWFwX3RhYmxlX2Rpc3BsYXkoc3RydWN0
IGZpbGUgKmZpbHAsDQo+PiAgCQlyZXR1cm4gLUVOT01FTTsNCj4+DQo+PiAgCXRibF9iYXNlID0g
cnZ1X3JlYWQ2NChydnUsIEJMS0FERFJfQVBSLCBBUFJfQUZfTE1UX01BUF9CQVNFKTsNCj4+ICsJ
dmFsICA9IHJ2dV9yZWFkNjQocnZ1LCBCTEtBRERSX0FQUiwgQVBSX0FGX0xNVF9DRkcpOw0KPj4g
KwlhcHJfdmZzID0gMSA8PCAodmFsICYgMHhGKTsNCj4+ICsJYXByX3BmcyA9IDEgPDwgKCh2YWwg
Pj4gNCkgJiAweDcpOw0KPj4NCj4+IC0JbG10X21hcF9iYXNlID0gaW9yZW1hcF93Yyh0YmxfYmFz
ZSwgMTI4ICogMTAyNCk7DQo+PiArCWxtdF9tYXBfYmFzZSA9IGlvcmVtYXBfd2ModGJsX2Jhc2Us
IGFwcl9wZnMgKiBhcHJfdmZzICoNCj4+ICsJCQkJICBMTVRfTUFQVEJMX0VOVFJZX1NJWkUpOw0K
Pg0KPkFzIGl0IGlzIHRoZSBzYW1lIGFzIGluIGxtdHN0X21hcF90YWJsZV9vcHMoKSBJIHRoaW5r
IHlvdSBjYW4gbW92ZSB3aG9sZSB0byBhDQo+bmV3IGZ1bmN0aW9uLg0KPg0KPnJ2dV9pb3JlbWFw
X3djKHJ2dSwgYmFzZSwgc2l6ZSk7DQo+DQo+b3Igc3RoIGxpa2UgdGhhdC4gSXQgaXNuJ3Qgc3Ry
b25nIG9waW5pb24uIFJlc3QgbG9va3MgZmluZSwgdGhhbmtzLg0KV2lsbCBhZGRyZXNzIHlvdXIg
c3VnZ2VzdGlvbiBpbiBuZXcgcGF0Y2ggYWxvbmcgd2l0aCBvdGhlciBjb2RlIGVuaGFuY2VtZW50
Lg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCkdlZXRoYS4NCj4NCj4+ICAJaWYgKCFsbXRf
bWFwX2Jhc2UpIHsNCj4+ICAJCWRldl9lcnIocnZ1LT5kZXYsICJGYWlsZWQgdG8gc2V0dXAgbG10
IG1hcCB0YWJsZQ0KPm1hcHBpbmchIVxuIik7DQo+PiAgCQlrZnJlZShidWYpOw0KPj4gQEAgLTU5
MSw3ICs1OTYsNyBAQCBzdGF0aWMgc3NpemVfdA0KPnJ2dV9kYmdfbG10c3RfbWFwX3RhYmxlX2Rp
c3BsYXkoc3RydWN0IGZpbGUgKmZpbHAsDQo+PiAgCQlvZmYgKz0gc2NucHJpbnRmKCZidWZbb2Zm
XSwgYnVmX3NpemUgLSAxIC0gb2ZmLCAiUEYlZCAgXHRcdFx0IiwNCj4+ICAJCQkJICAgIHBmKTsN
Cj4+DQo+PiAtCQlpbmRleCA9IHBmICogcnZ1LT5ody0+dG90YWxfdmZzICogTE1UX01BUFRCTF9F
TlRSWV9TSVpFOw0KPj4gKwkJaW5kZXggPSBwZiAqIGFwcl92ZnMgKiBMTVRfTUFQVEJMX0VOVFJZ
X1NJWkU7DQo+PiAgCQlvZmYgKz0gc2NucHJpbnRmKCZidWZbb2ZmXSwgYnVmX3NpemUgLSAxIC0g
b2ZmLCAiIDB4JWxseFx0XHQiLA0KPj4gIAkJCQkgKHRibF9iYXNlICsgaW5kZXgpKTsNCj4+ICAJ
CWxtdF9hZGRyID0gcmVhZHEobG10X21hcF9iYXNlICsgaW5kZXgpOyBAQCAtNjA0LDcgKzYwOSw3
DQo+QEAgc3RhdGljDQo+PiBzc2l6ZV90IHJ2dV9kYmdfbG10c3RfbWFwX3RhYmxlX2Rpc3BsYXko
c3RydWN0IGZpbGUgKmZpbHAsDQo+PiAgCQkvKiBSZWFkaW5nIG51bSBvZiBWRnMgcGVyIFBGICov
DQo+PiAgCQlydnVfZ2V0X3BmX251bXZmcyhydnUsIHBmLCAmbnVtX3ZmcywgJmh3X3Zmcyk7DQo+
PiAgCQlmb3IgKHZmID0gMDsgdmYgPCBudW1fdmZzOyB2ZisrKSB7DQo+PiAtCQkJaW5kZXggPSAo
cGYgKiBydnUtPmh3LT50b3RhbF92ZnMgKiAxNikgKw0KPj4gKwkJCWluZGV4ID0gKHBmICogYXBy
X3ZmcyAqIExNVF9NQVBUQkxfRU5UUllfU0laRSkgKw0KPj4gIAkJCQkoKHZmICsgMSkgICogTE1U
X01BUFRCTF9FTlRSWV9TSVpFKTsNCj4+ICAJCQlvZmYgKz0gc2NucHJpbnRmKCZidWZbb2ZmXSwg
YnVmX3NpemUgLSAxIC0gb2ZmLA0KPj4gIAkJCQkJICAgICJQRiVkOlZGJWQgIFx0XHQiLCBwZiwg
dmYpOw0KPj4gLS0NCj4+IDIuMjUuMQ0K

