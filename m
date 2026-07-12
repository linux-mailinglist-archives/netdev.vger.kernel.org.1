Return-Path: <netdev+bounces-306961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HHeiI77ZU2o8fgMAu9opvQ
	(envelope-from <netdev+bounces-306961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:15:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C81787459CA
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:15:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=DudX3+5d;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306961-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306961-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FCE43004603
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEE12989B5;
	Sun, 12 Jul 2026 18:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66F1DED5C
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 18:15:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783880123; cv=fail; b=CL/8gwu6J21yw6ht1ekfaxhOkycGg1ZBxxLZKeg+9gNmyIbae0Pc57KkZKVr1efVCSuNRIM+mV7Sv/DWAzngEJrP8gldHg6tAzBU8Jaeu6D5yQLAf75USW1ajr12yt5n7EUXN0hfgIShXEFq5/W+MoB5OVMU0n/s3RlK5ok+4/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783880123; c=relaxed/simple;
	bh=oOtqnnXvldi6Hjcf26e5uVItFGbzyHFs8FOINBnndpM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxfCVzkNnhyCLD5iGlzy6i1wM+EnH5ET1+9yVOt/SgTrdOMCvlDHKPaqjNpGsy1FdiWdsVQw6PotlwyJ+27qjc1vtIXxqv+AfjiEp0R+KBk65U3+LqonqLepV0UxFsqLz73TzumyAP8Cf6ZlSrEQ7uieT5EB5HS3HgNwFPTB+rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DudX3+5d; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsH1yu4pvVRsRVh0BWBcnn7hpx8sjNPH7OcrFPy8Tiw4kazTCerkcm5CW/cJZS/5WDxdC7rrHsl34ay8wczhnIX8WTsrGFv/HNqPlaOEg+Ehodpya7BDN8U0MyB3ydZVHCEu/aD3FGBcnq02hacHYT1cU+PNDDZPB2ZuXTGEHw23+FLI3rOVwTeu+7TT4un4BQi2D011FW55+fngMp3sMsBEil5Bq2p8mMqkqhfcvgUxHb3LvodS8c7dxEkQSUzZAp/+IhG8HVrzZmLiahQgC01cBpvSxDEiH7+DfjnO2pg37vhkHunDxl5t7wx6ZKloES0Ek1n68DZqhePWdvE/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOtqnnXvldi6Hjcf26e5uVItFGbzyHFs8FOINBnndpM=;
 b=SXODzySXJVB9CEvhuoe0ZWg/e1vurGOEw8UAX22wkzNqVTHRvotRBJ8Z2sUcuhZx8IvmI5Oz10sMx7bokb4xYIvq5kE+aBzhFb3BvydiCOYg8TAOVMDDFmxP3dsOTiKkCZCRHO2639w4AGtvVmQVGMcLGUI/BrOFquWnqOIdJDC6kAJ3WccvDQG3JOceAgpiZWwo1W/2zuR7mzcJb7RTXhcQpzzSZrftqatomu4tU6kejB5lCtjCwJCVoWMeb+Zq0vsVst09vbi2Qt12fl0ncFC0cD8vGbVKptiz7U4vBDF2ESV8RRyKx8PmaqrrZHC4FLmRkwKCAKrwfsqxLfdoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOtqnnXvldi6Hjcf26e5uVItFGbzyHFs8FOINBnndpM=;
 b=DudX3+5d69rXQ/WgHq4y3WizbpFH3qUnSR3Rv2JWNV88WbD7NE6yyHoe4JX4T0IGDmgfgFOJTCog3ECh4nxyjuOmhV4wVb25XN0bviPFTDnPVmA2ysNHdYdYEwrXyhHsIWAj0Epn1t2n/IwRSlZuogSKLmAz2zAScBIEw0tOEZ/QvW1WO8/MdpaFBX70hGPc1vNW6xq0+T6qye9g7M8AAoq+RNJbVkJK/6tG20E30ePq8r4iaoC+l35wsGtPLWpKgDJ63QQ3SBiK60OtMcJlh1C+lkDr2WpLplNSUuT89QMkdJ9kOiLUa6B5bFNZcKgbl1xQ2iPlQLkAoMTQ6hL7XA==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.23; Sun, 12 Jul 2026 18:15:17 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0181.014; Sun, 12 Jul 2026
 18:15:16 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jbe@pengutronix.de" <jbe@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH ethtool-next v2 1/2] sfpid: print all implemented options
Thread-Topic: [PATCH ethtool-next v2 1/2] sfpid: print all implemented options
Thread-Index: AQHdERvLUt7RqaaHQkWCU3aM3jeXx7Zp07xw
Date: Sun, 12 Jul 2026 18:15:16 +0000
Message-ID:
 <SJ2PR12MB900887F3DE8B760321EE5F5BD8FB2@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <20260711095803.257213-1-olek2@wp.pl>
In-Reply-To: <20260711095803.257213-1-olek2@wp.pl>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|DM4PR12MB5962:EE_
x-ms-office365-filtering-correlation-id: 42fb132e-3ebc-44fe-f3d9-08dee0418688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|23010399003|22082099003|18002099003|11063799006|3023799007|38070700021|56012099006|6133799003;
x-microsoft-antispam-message-info:
 MI+jv5e5OdBy+G68Jp3dpmpVGt3TACafkhXylHzYiUc7q/aN+II5KguKv5Kd3w5YfrfPoxRIwzl3UyMXbIebWa3ciTjK9Xrx4rBHsUa7/StlmG6q7/nlrvDnwOt2RmayVb3vhBEHRbwvacph06sCIz1XMXGQRNDiyMcsnEfFW+QkiqtAMJwTV0IBS6TvyKYJeq6wwA8qSw648lUmkvwrJn/Dvj79hWru/SgRakAU5zJaKSKi4qXxZF6dY3QZ3tsFv+F4yhvufmi+e/tV/2xfN+UCVwaJH/fxcN5N36+mkoCZN8M/ukrPDm5wqYxjEnJ6GvWeilBA+u4D4b+4XzNTcguslcqXCCjtx3l/rzEKZufC6g+qLmv6AljhxivRN1tHAh24n6akaGLs91GCpQoiRFzoQxBAI1kip1dg+s8DX+hTwxZjoowrefPrR+QnjCwlOjow9JHOQg201cdio1wLs/JoaS0toFnhACC983YAu00EyFzYrJu54MGnhdCE/0MIMAlkolIxlGU/XkxdL5MshqRBtC2NxWSSjXe5ptv3J4r5WXpkfwoGp91fkfgWOy1ybqXMMX81STXola7NQuMKZ2/pYvZVasaKrXaLh/7YMQge08BHHOb73iIRwchLYxK1ewoa/tOWHvr24ZqCR1yTshgZL5IPwt5xz2qmBNm3PsWwe/t/zsbFuVxdk2i4LFNvzmgPUi6tW/ECUEFDYhGmkg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(23010399003)(22082099003)(18002099003)(11063799006)(3023799007)(38070700021)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3dSTnBwdVdFeEN1aE02OXQyWHI0RHFUL05nT1VKTEJSSERrbkRldUoxQ29j?=
 =?utf-8?B?cDZYQkRpbHNJQldHTnFYUjB2WG9uc3BmVUZmZjJ5cTlMbTN2bTF5OVVkSGtO?=
 =?utf-8?B?OTR4ajZWZHBURjVlZVJZUjJ6dFVIWlpHU3NmcmdXRVJUaGJJOXZuZkc2dHZY?=
 =?utf-8?B?bkd4OFdiSjgxR1VkWW1MNTJLU24yRmlUcXpVdGRnUXJLTFdDYUVIbVVRNG1H?=
 =?utf-8?B?VTVLa1FVWjZYamNIYndGWldUTnFnT3FET0gwQzdpY1VDQXFSQ1QvakFXN2dx?=
 =?utf-8?B?RTRlQjZzWXY1ZTlsemk4THZHVUVVNm4zdUJnNEd0MS9ONktYeDRteGEzenBV?=
 =?utf-8?B?b1ZUV3ZhUVVoVGtFTEpGOGZHVjJzZkcyYWRwTVJNSVBSaGJMWjJieWtuREdM?=
 =?utf-8?B?WWpDY3gwUUxRa09Jb2tnY0VlajBoREdqT0FPbTdiN0NwaTdrZ2hpanF1SFpi?=
 =?utf-8?B?YlBWc2JnaUs3dDVCaXpmNWp3ODI3amNmcWc5eGFxdE5pM0RTaGZTaC9yWWQ2?=
 =?utf-8?B?NnRYSkpoL09xSWZQb1F3MnphVFVpMG5ZdUhHcitXR3k3RTYxSlUrSmxROFZ4?=
 =?utf-8?B?UXkvUU44TmhEMUtsTjk2eTVvS09FM3Y0Ylk2a3NYRXFhYWJ5R2JhbitzdDZN?=
 =?utf-8?B?WU5pc0t2cDEzTTFkYWhVb0NVRzFBS2VUeHA0eERhT2g2bXF1WGdVYmNFUDln?=
 =?utf-8?B?c25VVXN0Mm5qR1NlWTJPZnJ5UEVEYU5JbytlSkdrMi82a0RHMjFmRjBaQ25C?=
 =?utf-8?B?RHFmZGxVTUhqbXR3RkttRFFGN2xicURKbVhaZ2h6WHorYUNBWEVFUmk3dHRq?=
 =?utf-8?B?R1Z0bmY4Ym5YUzBQSUE3TVQrWWk1Y09nK0M1aE1TYVZWYVd1MUpONlVsY2Vs?=
 =?utf-8?B?MEtVTTNVZnhVb0ZBOVpSMDN6ZmhyMXh1dUVNYXZNbVhEcVRKVDJwdFc2NlF6?=
 =?utf-8?B?R3JrVmtnNks1RVVjREVzQzAyd2JBZEpicFU1MlVhVGJCVTFGNHJ1OFl5ekNw?=
 =?utf-8?B?ZFQ0QStDeUdubFFxNXFtTzQ4TGNtbUdGbkhUR25XYUtGU3JFNkRKM0ZCejhN?=
 =?utf-8?B?WlNZVUhtWnVLTTdTWDlGemlwUG1mZ3NNcFFoOFZUOG02bHNEQUhxcEVlSHk4?=
 =?utf-8?B?YmFucUt6ZGJGT2E2d3pndXUvalQxTDFRUjVFNWRGM0EyRk5hYVV5Q0tnSlVH?=
 =?utf-8?B?Y1MydGY3bE1zaXNEd0pESTNyV09nWWhjMXZYOW5jNzBITWJ4Z1pHN1dzWVA1?=
 =?utf-8?B?VzZFMDFXUUowN0ZMR1ZERHFMUE0yMEsvMTRZRDZWQVNRK2ZwdjVCYmhuaCtZ?=
 =?utf-8?B?ZWV1L3hDWkt3WVRNVE5VNWpIb1ZISmlFbUwrbHF6YVkvT1gxZ3FhNVN0dGtB?=
 =?utf-8?B?R05jU3B5cVpmMXdPTjFaaFlnQVgwcktjVitKRUpqTEZORzlVTElmbG9TRkds?=
 =?utf-8?B?c2hTdXRlQVVHa2Z3NTdhZVFRRnNuVWhKdGJ3ZStqR2tyRzArZG1GSkVCcmFx?=
 =?utf-8?B?MU9EWG4xbkZlaW9UOVl1Slp4blFmanVnYzRoY2hGNGUxWDNRVDJ3d3l5VTZl?=
 =?utf-8?B?aXZ6MlBiOWJDczJRKzdIOSthNGQvSm1JUDVYQTNDUDVrdGNLN0ZtYlppZWFF?=
 =?utf-8?B?RlFwY3BzVlZ1MmpuSUJ6Wk5pbW81MGR4TlVWZnZMcHlZN2FhWDMrS2NJaHZH?=
 =?utf-8?B?OWtHcXY5T011ako4SUVRZ2xqR2xGSWI3blB0QkppdlpJVXNxNmxweTBDdEwx?=
 =?utf-8?B?aVVNakJCMFVYSkhJVWwxcFJzTmhiZ2VYQXBjaGNETEdwTC80REMrdW91c3NX?=
 =?utf-8?B?Nm1iNkZqQ1hFT0UrVXRLVERsd1l1SG9XVHNaYktQTnZsU05uK1pDcUVUQUpp?=
 =?utf-8?B?VXYyNllYKzFYemJVOTlKamdoUlZvTXBtM2lmRVhqdUFyWE12MHhkcnhvdnZu?=
 =?utf-8?B?Z1NGdkdwci9lOVh5QkR5ZjVYSlc3a0VObjVmRlJ4eXVhTW5TYWxqMFpmcXRL?=
 =?utf-8?B?S05IaExxYkZjdG03Vll0ZkYrb3RzcGxYREhwbkdMWkV2NHFOeXlMdktCeUxi?=
 =?utf-8?B?azRIKzhXYU5mb0tNeXNIZW5FYzlSRGRnYWsvKzVZbU44NlJyTXlhaDdrZCs1?=
 =?utf-8?B?RGJ3bmRyUzFYUU5xZjJ1WGxIUS82OTJ4ZlQ2ZUU3Y1JZeHI3ZUluVUF3ODk1?=
 =?utf-8?B?WTN5alZldjFGUjRSREtBSFlqRnFUS2RQa3hYaTBLZEhkdks4TmI0U2Y0NDBo?=
 =?utf-8?B?MnZwUGEzRkZNK1A1eG1NdkJEbm9KYTZpd201R2l6cHNlMUk5bXRHcE4wYXlT?=
 =?utf-8?B?Y251SndZZXV2SGFrSFFYYlFvRFBJNGhRM0drYklqMlI3QkkwRCtSVzhVNGY4?=
 =?utf-8?Q?BC+hAY+OBADLYpfB9wfrg2ARnoOYKYNcCKMrKRZqBvV5d?=
x-ms-exchange-antispam-messagedata-1: Vc3W5YUIbCqf/Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fb132e-3ebc-44fe-f3d9-08dee0418688
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2026 18:15:16.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAAxsrPdaC30dHTgkRuyHBWnnY7JNqDRbhXKU6KSn3pfzQxDeilWTT8cotPfj8MuaoSXRdjMIn7rt+f7zatIHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.06 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306961-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:olek2@wp.pl,m:mkubecek@suse.cz,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jbe@pengutronix.de,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[wp.pl,suse.cz,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,vger.kernel.org];
	FORGED_SENDER(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C81787459CA

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGVrc2FuZGVyIEphbiBCYWpr
b3dza2kgPG9sZWsyQHdwLnBsPg0KPiBTZW50OiBTYXR1cmRheSwgMTEgSnVseSAyMDI2IDEyOjU0
DQo+IFRvOiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEuY29tPjsgbWt1YmVjZWtA
c3VzZS5jejsNCj4gYW5kcmV3QGx1bm4uY2g7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0
QGdvb2dsZS5jb207DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGpiZUBw
ZW5ndXRyb25peC5kZTsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogQWxla3NhbmRl
ciBKYW4gQmFqa293c2tpIDxvbGVrMkB3cC5wbD4NCj4gU3ViamVjdDogW1BBVENIIGV0aHRvb2wt
bmV4dCB2MiAxLzJdIHNmcGlkOiBwcmludCBhbGwgaW1wbGVtZW50ZWQgb3B0aW9ucw0KPiANCj4g
U0ZQIG1vZHVsZXMgaW1wbGVtZW50IG11bHRpcGxlIG9wdGlvbnMuIEJlZm9yZSB0aGUg4oCcanNv
buKAnSBvcHRpb24gd2FzDQo+IGludHJvZHVjZWQsIGFsbCBvcHRpb25zIHdlcmUgbGlzdGVkLiBD
dXJyZW50bHksIG9ubHkgdGhlIGxhc3Qgb3B0aW9uIGlzIGxpc3RlZC4gVGhpcw0KPiBjb21taXQg
Zml4ZXMgdGhpcyBidWcuIE9wdGlvbnMgYXJlIHJlcHJlc2VudGVkIGFzIGFycmF5Lg0KPiANCj4g
QmVmb3JlOg0KPiAkIGV0aHRvb2wgLW0gc2ZwLXdhbg0KPiAuLi4NCj4gCU9wdGlvbiB2YWx1ZXMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogMHgwMCAweDMyDQo+IAlPcHRpb24gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IFJBVEVfU0VMRUNUIGltcGxlbWVudGVkDQo+
IC4uLg0KPiAkIGV0aHRvb2wgLS1qc29uIC1tIHNmcC13YW4NCj4gWyB7DQo+IC4uLg0KPiAgICAg
ICAgICJvcHRpb25fdmFsdWVzIjogWyAwLDUwIF0sDQo+ICAgICAgICAgIm9wdGlvbiI6ICJSQVRF
X1NFTEVDVCBpbXBsZW1lbnRlZCIsIC4uLg0KPiAgICAgfSBdDQo+IA0KPiBBZnRlcjoNCj4gJCBl
dGh0b29sIC1tIHNmcC13YW4NCj4gLi4uDQo+IAlPcHRpb24gdmFsdWVzICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA6IDB4MDAgMHgzMg0KPiAJT3B0aW9uICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgOiBSWF9MT1MgaW1wbGVtZW50ZWQNCj4gCU9wdGlvbiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDogVFhfRElTQUJMRSBpbXBsZW1lbnRlZA0KPiAJT3B0
aW9uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBSQVRFX1NFTEVDVCBpbXBs
ZW1lbnRlZA0KPiAuLi4NCj4gJCBldGh0b29sIC0tanNvbiAtbSBzZnAtd2FuDQo+IFsgew0KPiAu
Li4NCj4gICAgICAgICAib3B0aW9uX3ZhbHVlcyI6IFsgMCw1MCBdLA0KPiAgICAgICAgICJvcHRp
b24iOiBbICJSWF9MT1MgaW1wbGVtZW50ZWQiLCJUWF9ESVNBQkxFDQo+IGltcGxlbWVudGVkIiwi
UkFURV9TRUxFQ1QgaW1wbGVtZW50ZWQiIF0sIC4uLg0KPiAgICAgfSBdDQo+IA0KPiBGaXhlczog
NDA3MTg2MmY1OGQ4ICgic2ZwaWQ6IEFkZCBKU09OIG91dHB1dCBoYW5kbGluZyB0byAtLW1vZHVs
ZS1pbmZvIGluDQo+IFNGRjgwNzkgbW9kdWxlcyIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5k
ZXIgSmFuIEJhamtvd3NraSA8b2xlazJAd3AucGw+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAgLSBmaXggdHlwbyBpbnRyb2R1Y2VkIC0+IGludHJvZHVjZWQNCj4gIC0gcmVuYW1yIG1vZHVs
ZV9wcmludF9hcnJheV9zdHJpbmcoKSAtPg0KPiBtb2R1bGVfcHJpbnRfYW55X2FycmF5X3N0cmlu
Z19lbnRyeSgpDQo+IC0tLQ0KPiAgbW9kdWxlLWNvbW1vbi5jIHwgIDggKysrKysrKysNCj4gIG1v
ZHVsZS1jb21tb24uaCB8ICAxICsNCj4gIHNmcGlkLmMgICAgICAgICB8IDQ4ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2Vk
LCA0MSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9t
b2R1bGUtY29tbW9uLmMgYi9tb2R1bGUtY29tbW9uLmMgaW5kZXggNDJmY2NmNi4uNDNmZjY0OQ0K
PiAxMDA2NDQNCj4gLS0tIGEvbW9kdWxlLWNvbW1vbi5jDQo+ICsrKyBiL21vZHVsZS1jb21tb24u
Yw0KPiBAQCAtMjU4LDYgKzI1OCwxNCBAQCB2b2lkIG1vZHVsZV9wcmludF9hbnlfYm9vbChjb25z
dCBjaGFyICpmbiwgY2hhcg0KPiAqZ2l2ZW5fanNvbl9mbiwgYm9vbCB2YWx1ZSwNCj4gIAkJcHJp
bnRmKCJcdCUtNDFzIDogJXNcbiIsIGZuLCBzdHJfdmFsdWUpOyAgfQ0KPiANCj4gK3ZvaWQgbW9k
dWxlX3ByaW50X2FueV9hcnJheV9zdHJpbmdfZW50cnkoY29uc3QgY2hhciAqZm4sIGNvbnN0IGNo
YXINCj4gKyp2YWx1ZSkgew0KPiArCWlmIChpc19qc29uX2NvbnRleHQoKSkNCj4gKwkJcHJpbnRf
c3RyaW5nKFBSSU5UX0pTT04sIE5VTEwsICIlcyIsIHZhbHVlKTsNCj4gKwllbHNlDQo+ICsJCXBy
aW50ZigiXHQlLTQxcyA6ICVzXG4iLCBmbiwgdmFsdWUpOw0KPiArfQ0KPiArDQo+ICB2b2lkIG1v
ZHVsZV9zaG93X3ZhbHVlX3dpdGhfdW5pdChjb25zdCBfX3U4ICppZCwgdW5zaWduZWQgaW50IHJl
ZywNCj4gIAkJCQkgY29uc3QgY2hhciAqbmFtZSwgdW5zaWduZWQgaW50IG11bHQsDQo+ICAJCQkJ
IGNvbnN0IGNoYXIgKnVuaXQpDQo+IGRpZmYgLS1naXQgYS9tb2R1bGUtY29tbW9uLmggYi9tb2R1
bGUtY29tbW9uLmggaW5kZXggNDA2MzQ0OC4uZjNiYWYyYQ0KPiAxMDA2NDQNCj4gLS0tIGEvbW9k
dWxlLWNvbW1vbi5oDQo+ICsrKyBiL21vZHVsZS1jb21tb24uaA0KPiBAQCAtMjgxLDYgKzI4MSw3
IEBAIHZvaWQgbW9kdWxlX3ByaW50X2FueV9zdHJpbmcoY29uc3QgY2hhciAqZm4sIGNvbnN0DQo+
IGNoYXIgKnZhbHVlKTsgIHZvaWQgbW9kdWxlX3ByaW50X2FueV9mbG9hdChjb25zdCBjaGFyICpm
biwgZmxvYXQgdmFsdWUsIGNvbnN0DQo+IGNoYXIgKnVuaXQpOyAgdm9pZCBtb2R1bGVfcHJpbnRf
YW55X2Jvb2woY29uc3QgY2hhciAqZm4sIGNoYXIgKmdpdmVuX2pzb25fZm4sDQo+IGJvb2wgdmFs
dWUsDQo+ICAJCQkgICBjb25zdCBjaGFyICpzdHJfdmFsdWUpOw0KPiArdm9pZCBtb2R1bGVfcHJp
bnRfYW55X2FycmF5X3N0cmluZ19lbnRyeShjb25zdCBjaGFyICpmbiwgY29uc3QgY2hhcg0KPiAr
KnZhbHVlKTsNCj4gIHZvaWQgbW9kdWxlX3Nob3dfdmFsdWVfd2l0aF91bml0KGNvbnN0IF9fdTgg
KmlkLCB1bnNpZ25lZCBpbnQgcmVnLA0KPiAgCQkJCSBjb25zdCBjaGFyICpuYW1lLCB1bnNpZ25l
ZCBpbnQgbXVsdCwNCj4gIAkJCQkgY29uc3QgY2hhciAqdW5pdCk7DQo+IGRpZmYgLS1naXQgYS9z
ZnBpZC5jIGIvc2ZwaWQuYw0KPiBpbmRleCA3NGE2ZjUxLi5lYzVkZDk1IDEwMDY0NA0KPiAtLS0g
YS9zZnBpZC5jDQo+ICsrKyBiL3NmcGlkLmMNCj4gQEAgLTM5Niw3ICszOTYsNiBAQCBzdGF0aWMg
dm9pZA0KPiBzZmY4MDc5X3Nob3dfd2F2ZWxlbmd0aF9vcl9jb3BwZXJfY29tcGxpYW5jZShjb25z
dCBfX3U4ICppZCkgIHN0YXRpYyB2b2lkDQo+IHNmZjgwNzlfc2hvd19vcHRpb25zKGNvbnN0IF9f
dTggKmlkKSAgew0KPiAgCXN0YXRpYyBjb25zdCBjaGFyICpwZnggPSAiT3B0aW9uIjsNCj4gLQlj
aGFyIHZhbHVlWzY0XSA9ICIiOw0KPiANCj4gIAlpZiAoaXNfanNvbl9jb250ZXh0KCkpIHsNCj4g
IAkJb3Blbl9qc29uX2FycmF5KCJvcHRpb25fdmFsdWVzIiwgIiIpOyBAQCAtNDA3LDM1ICs0MDYs
NTINCj4gQEAgc3RhdGljIHZvaWQgc2ZmODA3OV9zaG93X29wdGlvbnMoY29uc3QgX191OCAqaWQp
DQo+ICAJCXByaW50ZigiXHQlLTQxcyA6IDB4JTAyeCAweCUwMnhcbiIsICJPcHRpb24gdmFsdWVz
IiwgaWRbNjRdLA0KPiAgCQkgICAgICAgaWRbNjVdKTsNCj4gIAl9DQo+ICsNCj4gKwlpZiAoaXNf
anNvbl9jb250ZXh0KCkpDQo+ICsJCW9wZW5fanNvbl9hcnJheSgib3B0aW9uIiwgIiIpOw0KPiAr
DQo+ICAJaWYgKGlkWzY1XSAmICgxIDw8IDEpKQ0KPiAtCQlzcHJpbnRmKHZhbHVlLCAiJXMiLCAi
UlhfTE9TIGltcGxlbWVudGVkIik7DQo+ICsJCW1vZHVsZV9wcmludF9hbnlfYXJyYXlfc3RyaW5n
X2VudHJ5KHBmeCwNCj4gKwkJCSJSWF9MT1MgaW1wbGVtZW50ZWQiKTsNCg0KSW5kZW50YXRpb24s
IGhlcmUgYW5kIGEgbG90IG1vcmUgc2ltaWxhciBwbGFjZXMgb24gYm90aCBwYXRjaGVzLCBpcyB3
cm9uZyBhbmQgbmVlZHMgdG8gYmUgYWxpZ25lZCB0byB0aGUgb3BlbiBwYXJlbi4gQ2hlY2twYXRj
aCBmbGFncyB0aGF0LCBwbGVhc2UgcnVuIGl0IG9uIHRoZSBwYXRjaHNldC4NCkFsc28sIGxpa2Ug
aW4gdGhpcyBjYXNlIGFuZCBhbHNvIHNvbWUgb3RoZXIgcGxhY2VzIGFyZSB1bm5lY2Vzc2FyaWx5
IHdyYXBwZWQsIGV2ZW4gdGhvdWdoIHRoZXkgZml0IGluIDgwIGNvbHMuIA0KDQo+ICAJaWYgKGlk
WzY1XSAmICgxIDw8IDIpKQ0KPiAtCQlzcHJpbnRmKHZhbHVlLCAiJXMiLCAiUlhfTE9TIGltcGxl
bWVudGVkLCBpbnZlcnRlZCIpOw0KPiArCQltb2R1bGVfcHJpbnRfYW55X2FycmF5X3N0cmluZ19l
bnRyeShwZngsDQo+ICsJCQkiUlhfTE9TIGltcGxlbWVudGVkLCBpbnZlcnRlZCIpOw0KPiAgCWlm
IChpZFs2NV0gJiAoMSA8PCAzKSkNCj4gLQkJc3ByaW50Zih2YWx1ZSwgIiVzIiwgIlRYX0ZBVUxU
IGltcGxlbWVudGVkIik7DQo+ICsJCW1vZHVsZV9wcmludF9hbnlfYXJyYXlfc3RyaW5nX2VudHJ5
KHBmeCwNCj4gKwkJCSJUWF9GQVVMVCBpbXBsZW1lbnRlZCIpOw0KPiAgCWlmIChpZFs2NV0gJiAo
MSA8PCA0KSkNCj4gLQkJc3ByaW50Zih2YWx1ZSwgIiVzIiwgIlRYX0RJU0FCTEUgaW1wbGVtZW50
ZWQiKTsNCj4gKwkJbW9kdWxlX3ByaW50X2FueV9hcnJheV9zdHJpbmdfZW50cnkocGZ4LA0KPiAr
CQkJIlRYX0RJU0FCTEUgaW1wbGVtZW50ZWQiKTsNCj4gIAlpZiAoaWRbNjVdICYgKDEgPDwgNSkp
DQo+IC0JCXNwcmludGYodmFsdWUsICIlcyIsICJSQVRFX1NFTEVDVCBpbXBsZW1lbnRlZCIpOw0K
PiArCQltb2R1bGVfcHJpbnRfYW55X2FycmF5X3N0cmluZ19lbnRyeShwZngsDQo+ICsJCQkiUkFU
RV9TRUxFQ1QgaW1wbGVtZW50ZWQiKTsNCj4gIAlpZiAoaWRbNjVdICYgKDEgPDwgNikpDQo+IC0J
CXNwcmludGYodmFsdWUsICIlcyIsICJUdW5hYmxlIHRyYW5zbWl0dGVyIHRlY2hub2xvZ3kiKTsN
Cj4gKwkJbW9kdWxlX3ByaW50X2FueV9hcnJheV9zdHJpbmdfZW50cnkocGZ4LA0KPiArCQkJIlR1
bmFibGUgdHJhbnNtaXR0ZXIgdGVjaG5vbG9neSIpOw0KPiAgCWlmIChpZFs2NV0gJiAoMSA8PCA3
KSkNCj4gLQkJc3ByaW50Zih2YWx1ZSwgIiVzIiwgIlJlY2VpdmVyIGRlY2lzaW9uIHRocmVzaG9s
ZA0KPiBpbXBsZW1lbnRlZCIpOw0KPiArCQltb2R1bGVfcHJpbnRfYW55X2FycmF5X3N0cmluZ19l
bnRyeShwZngsDQo+ICsJCQkiUmVjZWl2ZXIgZGVjaXNpb24gdGhyZXNob2xkIGltcGxlbWVudGVk
Iik7DQo+ICAJaWYgKGlkWzY0XSAmICgxIDw8IDApKQ0KPiAtCQlzcHJpbnRmKHZhbHVlLCAiJXMi
LCAiTGluZWFyIHJlY2VpdmVyIG91dHB1dCBpbXBsZW1lbnRlZCIpOw0KPiArCQltb2R1bGVfcHJp
bnRfYW55X2FycmF5X3N0cmluZ19lbnRyeShwZngsDQo+ICsJCQkiTGluZWFyIHJlY2VpdmVyIG91
dHB1dCBpbXBsZW1lbnRlZCIpOw0KPiAgCWlmIChpZFs2NF0gJiAoMSA8PCAxKSkNCj4gLQkJc3By
aW50Zih2YWx1ZSwgIiVzIiwgIlBvd2VyIGxldmVsIDIgcmVxdWlyZW1lbnQiKTsNCj4gKwkJbW9k
dWxlX3ByaW50X2FueV9hcnJheV9zdHJpbmdfZW50cnkocGZ4LA0KPiArCQkJIlBvd2VyIGxldmVs
IDIgcmVxdWlyZW1lbnQiKTsNCj4gIAlpZiAoaWRbNjRdICYgKDEgPDwgMikpDQo+IC0JCXNwcmlu
dGYodmFsdWUsICIlcyIsICJDb29sZWQgdHJhbnNjZWl2ZXIgaW1wbGVtZW50ZWQiKTsNCj4gKwkJ
bW9kdWxlX3ByaW50X2FueV9hcnJheV9zdHJpbmdfZW50cnkocGZ4LA0KPiArCQkJIkNvb2xlZCB0
cmFuc2NlaXZlciBpbXBsZW1lbnRlZCIpOw0KPiAgCWlmIChpZFs2NF0gJiAoMSA8PCAzKSkNCj4g
LQkJc3ByaW50Zih2YWx1ZSwgIiVzIiwgIlJldGltZXIgb3IgQ0RSIGltcGxlbWVudGVkIik7DQo+
ICsJCW1vZHVsZV9wcmludF9hbnlfYXJyYXlfc3RyaW5nX2VudHJ5KHBmeCwNCj4gKwkJCSJSZXRp
bWVyIG9yIENEUiBpbXBsZW1lbnRlZCIpOw0KPiAgCWlmIChpZFs2NF0gJiAoMSA8PCA0KSkNCj4g
LQkJc3ByaW50Zih2YWx1ZSwgIiVzIiwgIlBhZ2luZyBpbXBsZW1lbnRlZCIpOw0KPiArCQltb2R1
bGVfcHJpbnRfYW55X2FycmF5X3N0cmluZ19lbnRyeShwZngsDQo+ICsJCQkiUGFnaW5nIGltcGxl
bWVudGVkIik7DQo+ICAJaWYgKGlkWzY0XSAmICgxIDw8IDUpKQ0KPiAtCQlzcHJpbnRmKHZhbHVl
LCAiJXMiLCAiUG93ZXIgbGV2ZWwgMyByZXF1aXJlbWVudCIpOw0KPiArCQltb2R1bGVfcHJpbnRf
YW55X2FycmF5X3N0cmluZ19lbnRyeShwZngsDQo+ICsJCQkiUG93ZXIgbGV2ZWwgMyByZXF1aXJl
bWVudCIpOw0KPiANCj4gLQlpZiAodmFsdWVbMF0gIT0gJ1wwJykNCj4gLQkJbW9kdWxlX3ByaW50
X2FueV9zdHJpbmcocGZ4LCB2YWx1ZSk7DQo+ICsJaWYgKGlzX2pzb25fY29udGV4dCgpKQ0KPiAr
CQljbG9zZV9qc29uX2FycmF5KCIiKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBzZmY4MDc5
X3Nob3dfYWxsX2NvbW1vbihjb25zdCBfX3U4ICppZCkNCj4gLS0NCj4gMi41My4wDQoNCg==

