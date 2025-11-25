Return-Path: <netdev+bounces-241639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B891DC87021
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298283B5AC4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6F33343F;
	Tue, 25 Nov 2025 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="uqYX820H";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vt9lnf7x"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EC25F797;
	Tue, 25 Nov 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102093; cv=fail; b=QnHbXXzcFBETsz9SHo7dA5BxncP33ZQ3E9cpeqE68jeU1Bhu9GitySxdFJJuMA/FbiRHpsHqViQZVcNRzc+/zxIBC2sTwRo6n1GxWc8hzy05/fcTgGkwgXHFYObvhSpc0JGnpYq6X567PNjtoagtMrO79D5Pidc0+vvrTqWylOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102093; c=relaxed/simple;
	bh=91gGb7dHMiV4OSIcEaS9dzlO9fEWWkqFaLR3uYQkMfU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hVa3VcbvpiFkuCLyBJ73BKQt798MAZ8ib0LHmfbKDU8t73q1/Lus3GdLR1CPHNjcY33CWfzcdImqBsfN+Xl3CBTzKkb3GysT0lYI4hi3ZoALkkPRo/kOIZAoNz27qbGbqy8VExHIshfdxu1Vtsz8JMxLEgHnC8OWv+cozZ+GcTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=uqYX820H; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=vt9lnf7x; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APHWwgu1890202;
	Tue, 25 Nov 2025 12:21:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=wTy566kVCE6D8
	ErA2u0b6uQdKXdjmiOiEXIexQlEJtM=; b=uqYX820HDtPx8LH4p0eGa9bJxVD8w
	gWLL3FsGQQvzcGdY6g93srvmIAxDxPtU6suF5UBR0GXi/ZVdbRmfe2j+y1yjjcXB
	fa/+5CTikOH0l6LugxMDJQMXunvos07j4MFW9pbnVDJuGCJN+e6YEmM/iXGlQ6xH
	4ImhwK1wUoU+O0pwk2zbdS1XMg5g0AQtoLyRpdMVpxm2pNP5sy+C19Avarb4KNcd
	1EjW8uNVTsTeEkEsfkMNaZASBIYtfOAOH6/DkwI5rEhbjd3v0lfiiAvZnF83Sb2X
	8Q9QR6Ve7cZPkoC8mPi/fpR57m4PoF52yWbW6TAk0SMYdvFGZmGUfrGQg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020074.outbound.protection.outlook.com [52.101.85.74])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4angxyrawf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 12:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A73Tx5raDeJ4aRBT1UhegrcpEXUoCgfUjxGIklWiOur/cx6qhKAvReZAWSGfkEiRjpZAJi84k08U4OQ87zCG95U6EmeOGvndg8Y28G2pT1pRX5yJzQK7zXh0j+fNbj1CUuq+zU26ucmzftEq3675SFNyXK7fR88AT1cJqTULF2VmMhkN8pK9gLDGPB+aA5Vs1mBmC6ixtsHFgqGaJFUn40KJtQvqpJG1/cYGfbAO8VBaAjbeCP1YmXK+V04wQTDIGeKRLFZ8TSL0eq3520B6RIyTLlMpaRPjBc3ZtnxrolKf+hPUkcQV7iJ8bQvEt2EoI+9rgoDQ4j7ctTaBV52d3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTy566kVCE6D8ErA2u0b6uQdKXdjmiOiEXIexQlEJtM=;
 b=BPO+TYhQHZy9h6YbNRFMUadF9f7Mgeo7eQ4EWrpBiG+y/VdwIM36C2PsdTTHwjHw7PgpbbIY0E694273UeoIctTauv+ntL7Cha2rl66wglyqKe+t85/w1pK5CKe6DbfNtxMNB3ssm3UUZa0h3LyFR+wtYy4Fg1gyaEeFf32iHNtH4mACVa4BvM7A5yTuAIv4cdkscbHXDGvAGUKBXoJXdgQ1m9I6DQ7Tyx381Idk3cbMmGhAqgOC6xK9mh5KI2AcuPAO5vDBSTKC69XyhKE+GaVhnCqSeaK/HeNPQ3Oo8SbhorbdiaEtBuL1YwLuWYAA8C2XDPPkCwxA1nU028E6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTy566kVCE6D8ErA2u0b6uQdKXdjmiOiEXIexQlEJtM=;
 b=vt9lnf7x9XNEwXF0SmyGMf1NT1nzdo1lgrGv/2VOpEyAlQJ8IszeSUzWvge79u1+RVBtzsW/hWsTfQh7dyqzZ8Kko7UL2bPD4limZB5qZe9GOKnShlbf9rIYyyMA5HY4tVneYIWVOps0xRXGQ+xEqT9eVdW99MPynz1FxCfgsb/bOSx+nWIODMC9ynygcOdn88j0PyVL855HqCWW0aozgpT/yZj/hAmDTqhqSPWnm4w1cEoH9RwMxvx6wdjJXTMakNSbf9Gp/tYGJUqBYFtO1VzGfHKcfb9CPrx8NbkPIgzb1y1k1OwHGR9oaW1idlH31hJbkoLXYatB4dXRud1rSA==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CO6PR02MB8804.namprd02.prod.outlook.com
 (2603:10b6:303:143::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 20:21:18 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 20:21:18 +0000
From: Jon Kohler <jon@nutanix.com>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next] MAINTAINERS: separate VIRTIO NET DRIVERS and add netdev
Date: Tue, 25 Nov 2025 14:03:31 -0700
Message-ID: <20251125210333.1594700-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P221CA0059.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::10) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|CO6PR02MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb8e7ed-ac47-4642-b755-08de2c6030e4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm9GUmhxME56T21wRk1lY0s0cndscFBjYWYxNXd2YWdFVUU5OXpHYlhiNDd1?=
 =?utf-8?B?bjRyWlpaUTNMS0EycDMrcTJ0c2Z4WjN2NjRkbEpLS3ovNFNOSk1pdnBwRGNa?=
 =?utf-8?B?ZnRtaFErayttUVg3akRHWGhWOUxGRHJiRkcveTdxWS9hUmp5TStIUG5TeWtk?=
 =?utf-8?B?YXUyK2YwZStPOXdMUE5nK25NR1U0WU5nc1pJdDJwanpEUWNCZ1JrcklPVmFI?=
 =?utf-8?B?bndUdTZ4U2VmazJKMVBHVnFyNktibFY0c2RSVXZxTEZYK1ZtR2lvVWNqajdl?=
 =?utf-8?B?M0k0VzQ1THdEanR5VkxicWdGVEdobk1hRXpicTdFMWF2cFFtU0E0UjdxYTdz?=
 =?utf-8?B?dnp4ZVRDNzRJMmtKL25VZUxpOXRSK1R3c0xjSklzMVUyRC9lRnNCMlhUUXZR?=
 =?utf-8?B?cGcrQkw5SXo2Yk5yTWJZZUowaEpaL3EyVkhsdHpVWHVJeGFoL1RaQzJVODBU?=
 =?utf-8?B?SFdzamlDMVRvY0V2N2dmYm83YmRNUWwxSUN5R0NJa255WmtVWUJ2dUxrWk9w?=
 =?utf-8?B?V0ZzVSs1dGRIeUR2d2lacjNJMzNlaW1QQy80aDZiZStSWktiaXFVNmxSS2hh?=
 =?utf-8?B?dFNuSDBCZkFnVllaT2xXVUwwY2VmYk1DMW9DTFRLVDQxd0VwZlA0SVl0YzE1?=
 =?utf-8?B?MG43SHo2MlV5RncyWDhmK0tXejBlc2Z5UUplZ2RITy9vNytaTTExaTEzaHpS?=
 =?utf-8?B?SlJYa0NjaHJBMHV0aFkwL05pcFhqUWp6RHM2ZUNWM3BBOWU0THBZalluVFc3?=
 =?utf-8?B?RzZ2ZHFIRVBNbVpmSjNDR2FNYlhGcmUya0hQOUh6Qm5OV3ZyZ2tKTGUxdEFw?=
 =?utf-8?B?Y3FtOU5GREFZcDFyWTFjazJpMk1tS2pkME1EWXJvNG8vRm5lVyt3VmZpMlhx?=
 =?utf-8?B?VzRNSGFqT09jYW1qN2hrSGF5bXdKRGc0QmpUVDc0eWpTK3YyeFhpMW15OXZs?=
 =?utf-8?B?Q1gyOUl4NW5lclJHTjI3Skh0OXRGUjVQbEphbCtEQWtwaUpKdm9sd0UxeFo3?=
 =?utf-8?B?R25qMDMvZG1Yalg4WTZqUUpvNkRxTzY0cExVeGR0ckF6VGE2c1VxUWpDckdj?=
 =?utf-8?B?WkxScThqUk13KzR6SXd2ZmtudVRlWVB4b1NpY2IwSS9GM0J1cUVMTmFTOHYw?=
 =?utf-8?B?WUhFa2dNK3dPMEFDUjRybTE0QUF5U1FadHl5TG5ZTDBQSjRaVHErNFlLblRa?=
 =?utf-8?B?Y1JUT3ZOVGZuczMvcEdHbHQrL3BselhXZDFMak1rRzNBSjVRc1c2VmpRVFlK?=
 =?utf-8?B?QlZtc0t3eVUyWXpyNk5mUnVwaTdoMyttSGJlUVFSa2lNT3paS0ZpdWorSG9X?=
 =?utf-8?B?K0JYd3IreTJ4aFhkZml4VFJjOWFTSCtVMUliOXRmMDI5Y09rTlhPOHYvNWZl?=
 =?utf-8?B?R1IwdlRQeG5aMFYyNmhYakJWSU8wajhMei9QRE84aHpaSlkzdVBiUkh1THZY?=
 =?utf-8?B?ODR1bDJSWmtxR1c0Tjk3aWpxbmpFZzFQWG5KNFVmU2FESFBxRFJDaEZobXMr?=
 =?utf-8?B?UUNDNGQvWlkvVWZKYTc3WllVNG13dVNyNytaYjRkRVRnTWo3bVd0NWx2dm56?=
 =?utf-8?B?SDVta0ozeUFWWnZGaytCV1hGWDRheS9NaWk0blhqS0xRdXoyWXl6V2cvRjRk?=
 =?utf-8?B?YlQ0c3Voazd1NFMxblNQNHJvdjdMRWc0QUs1NjNTM2lIQWRJSTg4YzZXM0FE?=
 =?utf-8?B?NnM4SFpNMTFPVlF2QWJQVWtlWklYVmlWMENnaXJ2YWgzSE9lUW1iV0lhOHhs?=
 =?utf-8?B?S3V2bDAzOXp5b3BRVmRlZmQxTDZDY3N5VmFvSGxseEg2djlSVmNJOGxNZFhl?=
 =?utf-8?B?a2RUcjdVcnRFU3pieWZBQ1I0SytTa0h5QkhuVWR4YmRZRFlxaXQrRnQwbFB1?=
 =?utf-8?B?eU9SZEprWUJHR2xlUWMyOVprVk8xdnhQdjBXZ1VYbUUrbCtFbHJzM2drdTVQ?=
 =?utf-8?Q?AmN6UJANRKrfKikwyqrpCdR3Kh9t6qcE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnA4UytRMTRQeE1zbSszc0x1a3pvR0ZQeURtZ1BPYUpINXhFUXl5b2ZSc2xu?=
 =?utf-8?B?VWlyckM3UnQ4VEVtSmp6bWsvdXM0QjQxU3h5ZzlibXdCcjdRK0lSblU1THhm?=
 =?utf-8?B?KzBDaU91a1lQdlkwRExieHVaOXYrTmpjV3VBbmNLT1h3N0tkT1ltSjRZNDZi?=
 =?utf-8?B?TytFNHBkUi94V04zbzRLWGxqUWljLzIrVGIwQU5MaEtXajRlR1dXa0dCZ3FS?=
 =?utf-8?B?MWxTc1dzWlZjbW1KcW10VDFCM3h2b2djS1Rmd1ovQVprUExSYkNWWVBhejVK?=
 =?utf-8?B?Ry9HSUQ3K2tFclpVejF4cndTaDFmZzZaanIrMGlUZWRYVkRlSlhuOVVoQmYv?=
 =?utf-8?B?eVV2YXpZa2tvcnlGS0ZSemQ4RnZoeS96UHhYUFRsYW9lTnhoWElSZzE3S0Fx?=
 =?utf-8?B?R2dPdDBnY3c2N0tlaTBoMUp3UmFvNzRDZk8zelg3dnA4ZHFjRE9IcWt1eUdW?=
 =?utf-8?B?QjBTUndPdkZRODFGMmZlQ1o0clh2V0ZTT3pLMGtUYTMrQ3BFeXRJVTMrRGNB?=
 =?utf-8?B?blVjZkplVkRCd1J4U3htOFdBQms2M3dSSS85aE16cGsyOHdtYVNJcnRQMmd5?=
 =?utf-8?B?OXJ6Z3V0LzZyT0czUThreldNZWR5NHZxR0VkWWVEY3NiZWlqMlBrYnJVbFpY?=
 =?utf-8?B?NnBNK0NkYnFKZG9ScG9ENHFsd2ViRkxhSzcrOFdPWUVnT2Rodmo0OE93akFj?=
 =?utf-8?B?Wkw4U0ViWVUwUHNHWDd2Q3ZXTGhXYk9oQjRwd2gxb1gxc3g3ZHN0WGZYREZE?=
 =?utf-8?B?ckR4QkpSQnhaVFV2SGlxV0RocHlIMmRRUzUvR1Y2STNWeEJlNTIzNEc4SWZD?=
 =?utf-8?B?dUNyUnpGY29ZWDQxSytCcGM3SVhWTDNWWVJpWE9GYVBYSlNxTUZBajg0ZmNL?=
 =?utf-8?B?cVM2SDJCeEdIWFJzNjRhTlY1dmxnMS81NlE5UmQzUmd5a2NUbkRRRjVqTEZ1?=
 =?utf-8?B?Skl5VHRmWTFLVjRrL3YvdEdCZUZsSFhIRjN3MmtidlFUS05TY2QrVXBUNm04?=
 =?utf-8?B?V2lUK1BWTGQ5OWdZYUJBVzhkSWNyN08vRnZqQnFwUVNucVFSaFdKMWc3UlBK?=
 =?utf-8?B?VTFhbkxIS2EwRVpCK2dlVHR0OUFSdjR6K1pnNFJWM0xpYVh4UVlCTGVSbFVl?=
 =?utf-8?B?SXYvYnJ3ckFNWXBYK2w0Q0ZJMmJycU9TckExMi9FMUNLSVIvVWVPVXpLTEFB?=
 =?utf-8?B?L3ZDc0tNaE9HWS92ZjBsZ0dGL1VaaGNtbFRlRFNxQlFYeUNiWXVZRkJReVp1?=
 =?utf-8?B?aUllVyszb2R0MFNWRVpMQnNiU1ZPR1R6TDJYNjk0QU15VCtFT0MvNk5WQ1Vq?=
 =?utf-8?B?emFPc2Y3NXpxRllkQUZ4QTQrajBPYURYMkQyTGpISVN2UWk2c2R2bm4zZ2Y2?=
 =?utf-8?B?a051Q3ZraG5CbHNFRmd6alFEZzZwRSttS2FWZDc5R2Q1M3hyOGhtN1M0RGNN?=
 =?utf-8?B?UGN4aW9Ob0w4SExVeXJqN1RDQkZUTWI4Qm01dTRlWmdmZ1VnU1BPZEhkeFh3?=
 =?utf-8?B?SFVjdnRobERNSTY1dmJxL2R6M0JOa3FhYlBDTTZRMmlwV0Y3elpNM0tQREN3?=
 =?utf-8?B?SkZ0emQvakt5NWg4MDZRNWpaWWpsOUNDR3dMQlEyK1kzY1RQQmJRVnpCYXJ4?=
 =?utf-8?B?dXhVa3p0U3ZBVmxRVytIYUFFN2UzS0pTYnZSMXVXVFRhSmNyZlJlZXJqU0Q3?=
 =?utf-8?B?Njk5RkFlYlFXT0FGMFZ6UU5HM3JjMUw1ejA3ajcyNkpXU0g4djhIa0RNS3pE?=
 =?utf-8?B?Nkh1ZlU2b3pSU05IMkJ4bE4rSlRLc2hVQkVzclhVRnhRWWdHOW12amttWWdB?=
 =?utf-8?B?U1hVNWFmNXFCYktSWVRlSlUvRFVEMG8vRXBnSWdxT1pyUmpleUpzdlJCOTYw?=
 =?utf-8?B?RmoxNVdoV3dBeHgzVXlTT2ZIeUxDeFNxV1h1ZGp6QjdubFdoeU1WTlFaSkRy?=
 =?utf-8?B?UVlRYkUvZFFjSExWTHRPdHdYV056d0ZySytyUEtvY1ZHU0l4ZDU1dldDdkwz?=
 =?utf-8?B?YWhQaFZ6WlZFNXdNdXloM1JvYXIvR21DUUxoektVMnlxTmVaMzUvUFBsNGtX?=
 =?utf-8?B?aFNuMU9FRjh0SVhFM0RVUktKRjZNWjlGT3h5enZ3MEtSWjhDbUp4b00yMGpo?=
 =?utf-8?B?ZndncUJoMWxkbEJrVUN0Y2xKMDMyc05jZkpsbk9ZVDFLaWhWd0N2TEIrRDNT?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb8e7ed-ac47-4642-b755-08de2c6030e4
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:21:18.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZPjOW/fcyhO0LeFrzo3AbPI8QTiPfzNDJyTtqqX2LMIzmvQ/90kjVA/ZOBmLkfAzZDnqvY+84D1DN5VKCfN+xaC6g5sNpmWZVYiqy6nlsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8804
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2OSBTYWx0ZWRfX/IgHkt7RDF1z
 qL/LKYMkXtyEDf5N1mhcx2zMx+PtssT97u12hPb4t4tWLA4KwqrlsdUbIVG+OT2KFqCAomKCL4K
 KnOubsaKTU7N6EDtsYezDESi5MgIZnHwNvTe8Id9YFh7n0PIO9qvH5/fo3FFdDezneYYgM2Gz6Z
 WqWz3F8iwoxnw2YBjK1Suiqu2RE361rMAqze4YWWGKsEj5yfW+W/606oCwuMNTpXHbPLEZwrHNK
 joiSTBvTzGzvXowq7zkHrUV5X3Of/0HNOwA1+ML/fvfew3T5P9Eq8TVlKPxfnBa6UaoaeC4d6Re
 uNpoIyHqGnFJELPw2wD/jAlBggRXOI0tHjSqfdkCF4QUPElyl+y7MmOM2Bb4oZKGcz1nh6qCLNK
 61M/hUbgCS447Tf4lORkVO7liTzfUg==
X-Proofpoint-ORIG-GUID: pILsg9GZh-Ae8YVOkTv7_WQkfhTsSGHN
X-Proofpoint-GUID: pILsg9GZh-Ae8YVOkTv7_WQkfhTsSGHN
X-Authority-Analysis: v=2.4 cv=BeXVE7t2 c=1 sm=1 tr=0 ts=69260fc3 cx=c_pps
 a=BkzQgYdJoksvgi0GI1zv2w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YJAArCuFAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=SRrdq9N9AAAA:8 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=9bVka8byOzxt5QZrNvMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ABE9cqDPcR8SteYt8ADh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Changes to virtio network stack should be cc'd to netdev DL, separate
it into its own group to add netdev in addition to virtualization DL.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 MAINTAINERS | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9a8d945632b..50cef0e5c7c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27139,29 +27139,23 @@ S:	Maintained
 F:	drivers/char/virtio_console.c
 F:	include/uapi/linux/virtio_console.h
 
-VIRTIO CORE AND NET DRIVERS
+VIRTIO CORE
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-vdpa
-F:	Documentation/ABI/testing/sysfs-class-vduse
 F:	Documentation/devicetree/bindings/virtio/
 F:	Documentation/driver-api/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
-F:	drivers/net/virtio_net.c
-F:	drivers/vdpa/
 F:	drivers/virtio/
-F:	include/linux/vdpa.h
 F:	include/linux/virtio*.h
 F:	include/linux/vringh.h
 F:	include/uapi/linux/virtio_*.h
 F:	net/vmw_vsock/virtio*
 F:	tools/virtio/
-F:	tools/testing/selftests/drivers/net/virtio_net/
 
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
@@ -27273,6 +27267,25 @@ W:	https://virtio-mem.gitlab.io/
 F:	drivers/virtio/virtio_mem.c
 F:	include/uapi/linux/virtio_mem.h
 
+VIRTIO NET DRIVERS
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	Jason Wang <jasowang@redhat.com>
+R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+R:	Eugenio Pérez <eperezma@redhat.com>
+L:	netdev@vger.kernel.org
+L:	virtualization@lists.linux.dev
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-vdpa
+F:	Documentation/ABI/testing/sysfs-class-vduse
+F:	drivers/net/virtio_net.c
+F:	drivers/vdpa/
+F:	include/linux/vdpa.h
+F:	include/linux/virtio_net.h
+F:	include/uapi/linux/vdpa.h
+F:	include/uapi/linux/vduse.h
+F:	include/uapi/linux/virtio_net.h
+F:	tools/testing/selftests/drivers/net/virtio_net/
+
 VIRTIO PMEM DRIVER
 M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
 L:	virtualization@lists.linux.dev
-- 
2.43.0


