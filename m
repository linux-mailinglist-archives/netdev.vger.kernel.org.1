Return-Path: <netdev+bounces-184312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 617EFA94A1B
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 03:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B966188E854
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 01:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4C4134BD;
	Mon, 21 Apr 2025 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bmd0DtBG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oh60JNbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F56DDA9;
	Mon, 21 Apr 2025 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745197852; cv=fail; b=lTwNG08gk8Zlzc9JIilG5ldMlRn2DZY147Lw8BjjgMvWJOwsualfS7Ga8PZ8upsAlaejwFE/ZCwY2KcGzJ//DnDrkQDRQX7R2cS2loqRf+a9CW6HC/J0UwFBxs0Wr2RET02j2fK07JishyV+8z1VJbH79596tAH3RvhfCtth97w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745197852; c=relaxed/simple;
	bh=ZFNF+tje08uJxBDjOPu3UiLjIBXBexRyuFGd6dOPJnA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZEVxWgstufcu/s4PqXDgP6MIwEHCU72lF4bkYQ6j8MnEgvvkakwXwOUAx4zS4AsnLWCNCw8811m8YN57dlc8Ge5sN89xA4Cp9jJQmiO+9wosEpFoY3ygKKmJOLVWvCipRxc20tSnHwSsad8D+Oql8BJe5PlhNM34qfTvHKoA11M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bmd0DtBG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oh60JNbZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KMuaZ4012358;
	Mon, 21 Apr 2025 01:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=wOi/TTOD/3aanFXC
	T47w5eUhMog1vPiCqLHizlbwksg=; b=bmd0DtBGxAT/mPh6Tfm8aSTMyfijd7Y4
	5uzYDSf/5nZCNyvXCqxbqCwPN3VYtT/Yu8ZRww6fSUGgVegskoF8cheCFuDk5s7A
	U43yRtaARzX1ZyIlMBvGEoorDwcLp9SPer4LwG5W2q3fG6ECgPU+LgspA9g7L3aZ
	euE8GTvm5EYqeOi9YLrRjRKf0CtviUR/m1wQyImyfFeA3X56UVPApRplcvRFMhuj
	3duu32qKBuLzrSdzuXNHVJnKZv0DpFYbP0uWbGqgA/E5wnPRfE29/sdWcMSUe3my
	ynWts/fbrUzWnNW7Jvlo+dwVmVh+E4l6UzkcIv14U9hgLoTF2VMFeg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643vc1pwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 01:10:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53KKP8G3021121;
	Mon, 21 Apr 2025 01:10:43 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012010.outbound.protection.outlook.com [40.93.14.10])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46429e037f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 01:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAtNx8bAnJzGshXCOTeZVHk5tYM3l0ffY77/T/ugfc+OcmZqbNV/6RbB8ul6meltpiKUPG9VsfIYshWX6l1Kb5NGARuS87w72Z14xstCTiss2SI1utZGak0F5IqkKQIt5azLmjD7lNvAbI9qv+5WCzTVmdHoGWOyzxwmXtGrfonloNtfEA4isaDdb5oo47EsXJWdolauNX8g5v+o/ZUFnZK5LiFiyPhocU3xFG86VUrvBxg3VWufIkNQUEuWjAhOY+yFx6bEE8CslQgiy6xjNWma53zidxV1+hWne18vIfXwSu83p5eZm3HHsmlqFdI18V4ymJ+Jv2pRz+fTRSs+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOi/TTOD/3aanFXCT47w5eUhMog1vPiCqLHizlbwksg=;
 b=FUL5xfSchp7cgIH00FxNfTyF7d2nMUySFgNTbmruNueSr69M2DvkAh31+VBvAdJTdnZve3cLZUd/pmxzNnzq0DckCK50mi4+JuAiniYS+QIUZ8Ovmc+7i48nZPLE9Hff3mOskabwbjk52mf4S0czqLJ2znNr+WwRPlNtMXAEamhVz0IrKKDqNdZMoVU7wB07OUzznt2N6hIV0jsitOEaU5j6h+e0T00PTPinTjlT9qD+GKN4RbAEm8wKfxESrVowX7R48QvZWVMPkxXL5q/R1x0ZEUTFxszveYSbhwf/dnnx5NUtSTTwJdH3D2AofdYDHqcq5gChEEwUORCs215CEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOi/TTOD/3aanFXCT47w5eUhMog1vPiCqLHizlbwksg=;
 b=oh60JNbZgCI5Qt2ltrE4hfxAWyTWLvULxgJZiB+41jLFxMIrQhyfGRAm84Q5DjK3SpbtgMy1Pbw+DAaIZbVrzzUo5X1+DGoJVso/7geXaj8LZYv3FDXCqaunH4iNFs9LIQHRBmQcZqXVClQqQl2ydWZbz16drXwHEfMTC1o9/D4=
Received: from PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5)
 by SJ2PR10MB6991.namprd10.prod.outlook.com (2603:10b6:a03:4ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 21 Apr
 2025 01:10:40 +0000
Received: from PH0PR10MB4504.namprd10.prod.outlook.com
 ([fe80::d0be:f934:6ec3:7fcf]) by PH0PR10MB4504.namprd10.prod.outlook.com
 ([fe80::d0be:f934:6ec3:7fcf%4]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 01:10:40 +0000
From: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
To: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>
CC: "razor@blackwall.org" <razor@blackwall.org>
Subject: IP de-fragmentation failing on bridge
Thread-Topic: IP de-fragmentation failing on bridge
Thread-Index: AQHbsleSONFirnLJokWzlQhxwz9fWQ==
Date: Mon, 21 Apr 2025 01:10:40 +0000
Message-ID:
 <PH0PR10MB4504888284FF4CBA648197D0ACB82@PH0PR10MB4504.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_|SJ2PR10MB6991:EE_
x-ms-office365-filtering-correlation-id: ef504750-d3da-4e10-6ab3-08dd8071552f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?U7r0zLoXorTFxybSLLZp8X9PVOwe0V2aidukpm0KafovKjhALQpinvONz+?=
 =?iso-8859-1?Q?EEAkhRk5/f5K51U8qvoPIdctTFE4CB/y2clFf+milcVf+PCk5jYSEJ3YQG?=
 =?iso-8859-1?Q?EJHXA4yQYu3eM8hmiUAv3K4dijnLzwDe7NUsZt2TMZTZUJ+9zJieZ+hP+D?=
 =?iso-8859-1?Q?6pen8BuguT4z9OWSbE0gBIpX32rNmCp6/5I7flUo9KNZymCfGzF9Sr952G?=
 =?iso-8859-1?Q?5hp909MIMm3CBjgpSIZvRj76Mwm9FYndZr8bJRAgI96NGbCnZesSMh2G8e?=
 =?iso-8859-1?Q?LxwhCOqf1YHzqpOi/yuLFwxUlrWeEQ8fWrzZtofhmBS/cETvjKVUwpE9xb?=
 =?iso-8859-1?Q?tW0n/wTEq1QpIEHXN/O/sUVRzL33luzwdEcUDqMyDF7WpbeOccWRvlwihz?=
 =?iso-8859-1?Q?DEgt6ssBtt681WejOJIyiaerLLoATmJuBK44gBlVXDv5sIW4LStd2jnB4w?=
 =?iso-8859-1?Q?DZr5RtNP+pm+Lgl4baf/Wv4CTcwO3RnlUxHQm/uw7Yut665EZNkL+EBjMi?=
 =?iso-8859-1?Q?xBY+BW+q9RCB7SgFyIAE4DZHQR2h9ri8Fsvq49GqidIEQkDtshrfTPjJF/?=
 =?iso-8859-1?Q?5fEzCjtpy9FFKbCyK5WPLryU2JN5LC60/zAbiacyFC3KDio+cwRgK9Rfs9?=
 =?iso-8859-1?Q?zxLADNY/ModM3wowbuRwfqrlzRGYBt29iUl7OTDjNN08mq4ODRYhFLDpv3?=
 =?iso-8859-1?Q?MD6o/lJPZjD4prQYrW+UwbzWjV8qjg9NyNAg6uLE30W1sO6s8ZCCOwEQXA?=
 =?iso-8859-1?Q?VSxmsNjX6vrIQ2SAtWy3tKKPZQDG/67WV55MDIg/iTKE0/DunaWajBf+lG?=
 =?iso-8859-1?Q?yMTopNuemaRJdGO/y2hYWd/u2eFAdBujuLDfDsTiDmN71I6HSQ30pXVW6p?=
 =?iso-8859-1?Q?8W5YXj80MWynfckVXrdWNe/bZJqy7sV45gl787BlhVQyPD9R8w5kSfQI8f?=
 =?iso-8859-1?Q?xkjYXSiozr9OOlkLd02FwKAM8TBT70cSxU8+fwNLkzPPXa7B19KuqgN5yC?=
 =?iso-8859-1?Q?3+G89TKmivldqwgAVWiQXtT2DKEixgwVaFvqHeLk+4NnHjHI163KuiESCr?=
 =?iso-8859-1?Q?zt5dKgJezsJ9MJI8jwIUq769LgEpk/+vg18KNu+H7Hu3Zoc+62tzJMFm4x?=
 =?iso-8859-1?Q?XG6ABjS4pCTV3YMNeQ9ycDDBw0hL3ivaB6iDvIwyYUXSBMxg5tWjQ5KeUQ?=
 =?iso-8859-1?Q?LPfrNcgbaC56gOTt3UWnXsE3rGu+CGaU6Wtafwy+Axta4AUnNzY8TCgMZC?=
 =?iso-8859-1?Q?mJlCvknqsq+zMmPYNLEe6c+x/gZGFrQtpu6Fyhd/vFSoaw+Wfowu87lgB6?=
 =?iso-8859-1?Q?Q/WvIcwwIrR+yLEv7++vR45Ue0jLrben8D4Qb6dR93rPwKDmnKhhMq/R6w?=
 =?iso-8859-1?Q?Ilsninb5XzPeyER/D4R8SovMcewu7sxzaJxfeWLyQFS7PnwaEOZuml1tv2?=
 =?iso-8859-1?Q?MgN9AHbeMJsJ34u/pIp442GZTcrSLnmHvgwTdw1ELkfRM7eWfzaBWJqiU5?=
 =?iso-8859-1?Q?O8gpra9Dt6mwq0uzoOp6ruhq3WKYdU+6OclCNjJDyW3w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4504.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iuqMYH0iomj2lK7m6t9qP7F9HQtWVQ8snXqVPsKlfZx9+XPhyvVFPebUQD?=
 =?iso-8859-1?Q?cFW++lSDXVB6/t46VDinm0zRFFFd2YKtMGC8SyT1FWFQ/GucZz/iqX2Ztf?=
 =?iso-8859-1?Q?YejVe61w4aZ3fjPI9w6jdiyzTrFWY8dqp25RurXjblZgJ3ioQP5cBGNAom?=
 =?iso-8859-1?Q?c36RyxSziMWQmH2vc+Nf8kkDZRzhZXNJgBCK9dQtuyaSk+soCi0ufwTwYP?=
 =?iso-8859-1?Q?TnQ5aPZqCuPHj+T/HWeiqNIZSlqCjHbr11MktatjzKtKTNfXtBi5eb3Ips?=
 =?iso-8859-1?Q?8KT52Sw3TSporiifdUCjFczLgvOu39C2Z3vk4nsNHya9YgSudT3+ONGUcD?=
 =?iso-8859-1?Q?5WqOj9weFAShfNtCHJPHJ9805Jo7YEiW937nTSxXZwi1IFh4DlwTIyJPAO?=
 =?iso-8859-1?Q?4iEPsivCEGNLdsR7didS9I1Vyi7D1jT43l0Ub6/Rw0j0xUuOPI+YyYbA2U?=
 =?iso-8859-1?Q?5wcZb7b3AftZkkGw0GFOfag2B+MnwdnBT3Jt4ITgdz7nS3CV1eO1S5wZTM?=
 =?iso-8859-1?Q?hw3aafPcQhLbXEiDD1u6+6sWJLQ36C/1/3/k6glmUjIBRNhA0ne222/lWu?=
 =?iso-8859-1?Q?8uH9OedUyY8pkdoOt13UnpS8Woma5DeA382S1Z/YJDZB/zl5quBrM78wej?=
 =?iso-8859-1?Q?cc8QiHmAKyyAddDv5yTvV8InGo7THwaR9+L/EKo/PaFvMMsg7PKM48/pkC?=
 =?iso-8859-1?Q?QF1nf3fsrjkl9kDU/ii/KyowYwcM2kY9qlipcFu76g/q+0Clbn1mTjiFNw?=
 =?iso-8859-1?Q?Ia2eg0NuIBaoQW1X/kEFdUl6wX5NA6oYHikPmYVpPsfRyOFjGqpMbGlZWt?=
 =?iso-8859-1?Q?9XyaqH3Hir8/zm7rIgAVzdD4RiP1nmKLyIRx9N1/gz8uSbdLRW5v4NQZvQ?=
 =?iso-8859-1?Q?YYFIAuErPwasSfv5snflcxMN6QWV/xqzb3dOBWyikssSxIN5FOv98+Al5t?=
 =?iso-8859-1?Q?G4pHy9qXq+nlXIVxfA1GHdcG31iCW7JOa8U1+vwOwRy5t1Ret70jy6QdD0?=
 =?iso-8859-1?Q?kotHpsjdsydryOCKOwpH8hhCQGUo5KfhdKxeSdqN8/BGW8Nbd53YjJFiIn?=
 =?iso-8859-1?Q?DXL0zu0osRQP/yaVIc8mSwhWdASDimt8Z3Y3sNcJ6Qy/lVg8mm/CNmm52R?=
 =?iso-8859-1?Q?ct2BV0KQrrt1FafKa0j1NZSrwftHD/6YDdezkJonscNF19l70pU2fq9ImI?=
 =?iso-8859-1?Q?KludBeZrMoGJ/b9Zc1+SdMm0MUMr5/SlsD48ZIb1ZMmHvBI+VFsh2L2PJT?=
 =?iso-8859-1?Q?+7W5NYQqHRBwTdPjtxgU1RGKKTT5G6jsW04/48Sra6g5GVHGpYC3LSkGde?=
 =?iso-8859-1?Q?v0bI2VZYiSyXmicyifBvjmEVRc2QzGix6uoiiFYQjDWbUqt5apxtK9b/LD?=
 =?iso-8859-1?Q?RjGXORzUzSFmIkxd3mB0T+qE9Xw+SDWWzO6hoH73eNs1+x/3GAtMjTmwEc?=
 =?iso-8859-1?Q?revJZlVmsd4r24kWS0XZU4WLguxUpb+iqs5L4i9iJ2j+mYwv7fHOpjpTzg?=
 =?iso-8859-1?Q?Gq/NW32uXdAF/ap4aA3AUdxx8ARd/KUnM7soKy3iafqkus5HVeiM5KfVhT?=
 =?iso-8859-1?Q?Dl2lRkZbp3cVkBl6lvwCYoEIAAOwEU25qq4J/wFo8cbjrGMTO5SuzUcTtY?=
 =?iso-8859-1?Q?qeP2fguApqliSFjg4rH8Q7YEYwIVlnuScg+s/mvHYVqpyeFWaxkDmyiQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3TAWK1KyLfXNX+mtYQTA8YmH4+rIKape7KHvD+TxsrNB3eiGzIIclmr7TrfL0AxbexIo8SDoLp+DWzS8WmcOz+zEOMYcinQ7nN/QEuptUHHNyjkQ/EA/s2Pz3Pj03seyLfkd2DijXoQ6REfirx4WgtbFxl3/8SykkoNnZFBkPwIFdKgvAqozd8c7hx/dxBeB7pwsIvP0nMmKFktVHdpESDNMMPrMzYPeSa5bkVhgYQicuJkyz2CJiaVGuDH7HEohTRYTeepmqaeY6eoHccGnEjw4l8w+VWC6jI9Q2z155TsrmUX2cZSW4E0Tey67aMZBU5WWRtZ/Xrr8v53IoHF74SWW6v4VyYLH8wY5JO9ph0q8hruaMq4WyjnZ4lAxlL/u2o37FIJ1LQowxb2j447MsLu2a2zNthRFISppvHcPkNx5tqhVMXtFLofu+HMrB4mMSPDvpkJsHoOpKETCoLIAztmdEK/Q10JPWGjj/fKs+U+Fzph429tHlVQ/j5z7yt4+ltwbi6B1VfQR7PvERdco6d3gQ3U8Us2RY1nuf1ZDQqtHnBco/9jssMkyKNlmz5NpvYQbNJ4hOyl2rW00u5FmnH/iRwow4/5nXFAvHPRVBH0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4504.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef504750-d3da-4e10-6ab3-08dd8071552f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 01:10:40.5239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2cTPyXYnuXWS+XKnrmuLVcwL7cNvb41LNMp6/69MUg4YM1T+DJHcq2mIIEpvvKCFUr95ZD5KUIdd74h5gktB+NmGUXf/Zt34kriRgElihU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-20_10,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210008
X-Proofpoint-GUID: 6vHlh62cfkussTPb4LYFiGQBT1gllNbf
X-Proofpoint-ORIG-GUID: 6vHlh62cfkussTPb4LYFiGQBT1gllNbf

A brief problem description.=0A=
=0A=
ping from a VM interface with mtu 9000 fails:=0A=
=0A=
# ping -c 1 -s 9100 192.168.16.124=0A=
PING 192.168.16.124 (192.168.16.124) 9100(9128) bytes of data.=0A=
1 packet transmitted, 0 received, 100% packet loss=0A=
=0A=
On the host they arrive as 2 fragments:=0A=
=0A=
frag1 iplen 8996=0A=
frag2 iplen  152=0A=
=0A=
They are passed to the bridge.=0A=
bridge-nf-call-iptables is enabled.=0A=
=0A=
# cat /proc/sys/net/bridge/bridge-nf-call-iptables=0A=
1=0A=
=0A=
The bridge's mtu is 9000.=0A=
=0A=
# ip link show dev privnet=0A=
11: privnet: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000=0A=
=0A=
It needs to be forwarded over icbond0 which also has mtu 9000.=0A=
=0A=
# ip link show dev icbond0=0A=
10: icbond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 9000=0A=
=0A=
At the time of defragmentation, the bridge drops the reassembled IP packet =
since it finds =0A=
frag_max_size (8996) exceeding the "mtu" which it thinks is 1500.=0A=
=0A=
Prior to=0A=
ac6627a2 net: ipv4: Consolidate ipv4_mtu and ip_dst_mtu_maybe_forward=0A=
=0A=
the bridge was getting the "mtu" from its "fake_mtu" dst_ops.=0A=
That returns the interface mtu. 9000 in this case. Which was good for us.=
=0A=
But post that patch it now depends on the dst metric for RTAX_MTU.=0A=
=0A=
        /* 'forwarding =3D true' case should always honour route mtu */=0A=
        mtu =3D dst_metric_raw(dst, RTAX_MTU);=0A=
=0A=
From dst_metric_raw we get 1500 which is the default set by the bridge.=0A=
=0A=
static const u32 br_dst_default_metrics[RTAX_MAX] =3D {=0A=
        [RTAX_MTU - 1] =3D 1500,=0A=
};=0A=
=0A=
Since the bridge sets the metrics as read_only, this metric doesn't seem to=
 be reflecting the true mtu.=0A=
Which is larger (9000) in our case.=0A=
=0A=
Is this already a resolved issue ? =0A=
Based on the latest bridge code I couldn't find a match for a fix.=0A=
=0A=
If we want to retain pre-ac6627a2 behavior, =0A=
would keeping 0 as the "fake" RTAX MTU be a viable option ?=0A=
i.e.=0A=
       [RTAX_MTU - 1] =3D 0,=0A=
instead of=0A=
       [RTAX_MTU - 1] =3D 1500,=0A=
=0A=
Thanks for your help.=0A=
=0A=
Thanks,=0A=
Venkat=0A=

