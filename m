Return-Path: <netdev+bounces-89508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0EA8AA7CC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 06:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BF11C217EF
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 04:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7E522E;
	Fri, 19 Apr 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EybklzWg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rc0z+sGw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286303D64
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713502010; cv=fail; b=mv8JtvuQrRkZV7jDRcRgg9ujiQ29h6uT6kAT6NHe2J5iiT9WGOiAjWfBsTPTk4iA5SZnLIkhO43Iiq73Mw9f4R6o9VC1ZecZ5T2iS5+toVRE0RMLF7y/J39G2n1gTZlsuyoBM4ZEsamAFofVXxbF2fh2N34fAG1Mggpyg3JxegA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713502010; c=relaxed/simple;
	bh=SkuVAHYiSv0RVvKQpDSXS52YmDATwWso8c+jLXTEgCU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EGQfw5XIQSyoROHSLEN6KLIIKmf22T9BZpFQckNLPkFBvEz2zgW95SnDzKm2CWajZwsv4BX4rTdYI/Sl64Xz/U/U9W7qwZ15Wa13e4k/Y6eDJicBNzq5OekHWy3xbKfyEbqL1ikD6SymdMjmMlkg7S1CdMXhOhqq/aukUaiwX9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EybklzWg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rc0z+sGw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43J1K479014228;
	Fri, 19 Apr 2024 04:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=zf2g6DRI3Kk9BmTnFJbM5tXGMYRbhquaIqhUTzGyZR0=;
 b=EybklzWgehqAT9Tm58SyIPRcqnhl6yWd8m1/MA85PjAbXcMBJvaAcwMq/su3BFFNmLWR
 Ign5mpmLJBsF4YyT0bshh6Qdd2NLJSBCWgsko1dm9Ra+EnrH95lmRRqLPpp2NRMyNXzG
 IFk1VUKVfZ2ywv5MknClxceaWp+sYSCb9JQH6akQnrd9AjIITpigf9Fb0kmaPar5544M
 vZxsp/dYsaYSHeMmIE831zycJZUVHWI5fMjMbDWmlaqdGxNv4tbM2xH6pOYcZa9b19zO
 mEMrSwCDNVBBnSJ6wbYqcjS4J227bCYVpe/Mf17VsgQtmZBe2+t8lretfF6d96cVWJV1 rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3ec6mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 04:46:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43J4Piok014922;
	Fri, 19 Apr 2024 04:46:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xkbuqj38p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 04:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc2l+9JjRcPYqdncwtDwuwSfEq1opMTaw5JQ/rfC9cWPysoGNEOikm8HSzpUyqacutPArXiIj2LF4Pbem/kl/qpAL0kd87xp91gqaLlcXcdICCv6WopuCAGGvTyEA/yOB5jDRiNMA07Ie0H5CcLCIlR2YEyQcw8+Sm8osHMfxvbmqHIbPo9NFqzmwPTZMzRH0qPi4IsPAcU4Gc9xqKTkh5kSoEM3AMPnGsLcYGdd+BQvFfzcmxaPyJFMcB5kL3FqOQfO+yeC+ipChKrRcoKpr97JwJjODQ1vIHf9IPj2MDK/zaqJ2oVLB08klEqO1VACW3i23GPJn3/7yWorUCSLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zf2g6DRI3Kk9BmTnFJbM5tXGMYRbhquaIqhUTzGyZR0=;
 b=CbMWfB/ZWhGhto3IM0hCxNsgcviCrOt06dWKyC/GVORdKmkJiiRzAeHbgl5UEgWlPvQ62ARundavoTr7+NZXgqOF9n92kyMW/1vfeVAkLWSW6EYjr87c/qcYN0T6WejBRmqzUBUxZ/puKaf9goLAVdBgvpPqqLCTSfAnmqqp3DM2Bo6k2JPZeJeXg04RM0S3UpgNqbgZ8GLg0pUtCw2xS37k82iTaz6WcEQ2AlC0mjirgDB8y+aFFND+S83WkPwRDfO61I8f6lKrjLfCq8aP7mESml8r3UGZXjLmz35XZw/u0Kx/DfJmScBt143cH15IW2UIOr1s70x0ouFhiyBXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zf2g6DRI3Kk9BmTnFJbM5tXGMYRbhquaIqhUTzGyZR0=;
 b=Rc0z+sGwgkCgXMqFpS8tPmFnruV7uRT0iYzU2pE3sVDZWoEYYatT5ydDqTs9RgjszOvHTji4wgdurZNpM6SxtZ6RNIwLTTpAMJRLbDcX1GS8V8r4g8+ARyMFpP9aqEvOLRHiT6RCso+rt4ErQue97fNExhBxP7pygN3R5Lg1lQw=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by PH7PR10MB6481.namprd10.prod.outlook.com (2603:10b6:510:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 04:46:33 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%4]) with mapi id 15.20.7409.053; Fri, 19 Apr 2024
 04:46:32 +0000
From: Rao Shoaib <rao.shoaib@oracle.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: [PATCH net] af_unix: Read with MSG_PEEK loops if the first unread
 byte is OOB
Thread-Topic: [PATCH net] af_unix: Read with MSG_PEEK loops if the first
 unread byte is OOB
Thread-Index: AQHakhRDLvv3cqUDNEa8wsgJsCjGeA==
Date: Fri, 19 Apr 2024 04:46:32 +0000
Message-ID: 
 <CH3PR10MB683386BD63824096BF86BA9DEF0D2@CH3PR10MB6833.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB6833:EE_|PH7PR10MB6481:EE_
x-ms-office365-filtering-correlation-id: 7d020d0f-80da-40d8-46f3-08dc602bafd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?q7pp4hlUM9v49amVbEuv2X6XF5wGDOku/hoUCeqb01D5I2r/QwamvzoC4T?=
 =?iso-8859-1?Q?BOVn5HqNIie/kf53AF89HbcqC4WMov4Z6kw/nkvKf9Aj8H8sVq9lEVmQGf?=
 =?iso-8859-1?Q?qXCokhxPnfzZp4DHYJxwKdf+3xZ2+M4Td0RWgmMRmHACuocgUT0Y/CQmEP?=
 =?iso-8859-1?Q?Lan2LPKUTNtkMPwloIUoToa8VR0sw3RtOpF/L9DrK9wZzpkdXrbMlQqp2u?=
 =?iso-8859-1?Q?vJzbvc7+GX0uHGsi+Prb0DsZVk4PFNCtz6QifVTzWLjU1JNJhux7wEL54h?=
 =?iso-8859-1?Q?tF/3VsKH1MHjqF7HoUG/iSX5BUG8HFGwqdUMEdCXIj2IroXp+DbB7/FH84?=
 =?iso-8859-1?Q?2jAGn5cnB71APe8ofCqH3orKzc1XsmUXnV4u8UV0UuKFLUJEnIu5v3eUGQ?=
 =?iso-8859-1?Q?r8KA+jTMv/20aA07aalYpGou8NCnZDXfn9nH0WiLyNAHqAEqJql4jx92UI?=
 =?iso-8859-1?Q?P81XB/7fwN0bPxLOOXi5W6zdQIBZleCRCnLYdU6sesyOf3T5cGA9hed/Be?=
 =?iso-8859-1?Q?b8sSjHCGQVogZNBcekRUvZfDQTIjpGoOA7ousrlVjZdTIq0tyfFhl/Y8Ne?=
 =?iso-8859-1?Q?wgxytu13adUKPKfh+ZY5YLivzxoCHoryuPlIBN9Qix4/C7TkNIk3vAGIh6?=
 =?iso-8859-1?Q?zJfwwYbVqkcc4DJLclLlhNJcTt29tMAairFn2MMYqGHdRRqbOGAQanOnrk?=
 =?iso-8859-1?Q?zeg1UB7c2Mzo3DLAUHjaqRlvx9Wye2V56BxNfS8EyrXKhibV4g8y0/S+zi?=
 =?iso-8859-1?Q?Q5wB9zaQV8ZSOX7K/4uzYduQtqzsQZd6vaG/ck8MO+Z/Ckk36m8bMWfdkJ?=
 =?iso-8859-1?Q?rP0SG7Fpp+aUJ/Wk+tl1OZ9iw0E/kAA26v1RpeWxMZLm3tWl+Y4fXMpSif?=
 =?iso-8859-1?Q?0tdfm85VwuXzvtE6qcomjpTJ31nbO6ecVCRWCWO1NhukwL6pSwh5MwRrhJ?=
 =?iso-8859-1?Q?6XVqsbEPX/nuilSNSe8fkqh9KyKxGKBgY87oDmAlxsF0G5R/PQLb42wJ7V?=
 =?iso-8859-1?Q?QSThXcOFAjUMMKckEPpCxU5y/4svH5mKULoA36IApFt4uuHvVZXgFASd7C?=
 =?iso-8859-1?Q?w4Zlak4tkoX+c7lH5BuQhPzup7iZG4QXNrpD5Zk/bEdix1wHeLpPuNCLuh?=
 =?iso-8859-1?Q?QP6S6CoOZaQPAOd5Jqe8yEHMXTiGMJKkGfUV5TORiuOChlSgoHgO78vtR1?=
 =?iso-8859-1?Q?1YhZ1BlH5OURxi57nGbIN9LQm/75gcttNHnmRO2tz+iXw0JYmexhduwuug?=
 =?iso-8859-1?Q?GZQsM1KGUH09jyfuHUH2TMGeQgGbLO+L2e895D6t+vNQJTHvNXXdTIszSN?=
 =?iso-8859-1?Q?JKKkY6oxWJ7nZRRMIB+EPgVqYLWm60wrq1om9XD9XPA29wSh9FoaudxicC?=
 =?iso-8859-1?Q?uDMlx6JpMrYLy5aDfikhDmECUFQo/EBw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?71UuDpmSaguKSKwJSnmGlUw4/QWDna1tLMZdwhyL75nFt+p2Gf0Qjsp4yQ?=
 =?iso-8859-1?Q?5x+t17Y4axL9IGiP43yEENxGWGKB/iWEz0ORJ8/a/0iHuDKcJ/h9lJ4VKU?=
 =?iso-8859-1?Q?Wn3rUgymqt1RPJ+phJNwDXw+i49JluVt9rOpXaW4tVEnPD4e271xBETnJh?=
 =?iso-8859-1?Q?B12dwdtveHVsuV+ocmXEWU303hRJPYbXeL5n3Otexu1H30/6IojknZu5ZE?=
 =?iso-8859-1?Q?6TA2sD1z0YILbYFJmF7LrH+RtN3XoXwpJXRZPT5U84nZkoKeNlY3J+Vvm9?=
 =?iso-8859-1?Q?iD5eg+lXL3dS3cd2z8d5EgoHZ6eUSmqKuUGwfwPvJcdWgsBLq9YV8NevYV?=
 =?iso-8859-1?Q?mCmS3Nc1gC7IgAzPLKifR0ub8sO30R9fQw1+QM15MhXbwtfVcS+lSG+QA1?=
 =?iso-8859-1?Q?qdU51bQy7If8yF+KA4XwwQCBtbnZsOxto1kRA2Pk/lwrZDqtgIL3o3No7U?=
 =?iso-8859-1?Q?5yma99kH7YdR5eEVQ/0AgvCO6ULxRpQiZKTEUWP1v5AqkF5GWLDq99qESi?=
 =?iso-8859-1?Q?cUS+kpfpbScH0amMCKwQJi3dcbHQZ736DDq95Oml/5AgiV9/tOoQu9R4af?=
 =?iso-8859-1?Q?R8S9LbURfV5eE5Cnaz69fgcUZFhKe9+s01AcTAJe8TvVGuv27nZGBKTDpP?=
 =?iso-8859-1?Q?j9kpnYRDWqmupyRum87Fg0IZSReTRPH9uY1X1Hulps7OtuBT3Hdp6+AgWt?=
 =?iso-8859-1?Q?mXBgPS8W1Jix+cJ+3fsEips0cFge2UB8B6//UsilIdne6sVNqh0NMm3C0Q?=
 =?iso-8859-1?Q?7RystyVtDw3i+gYKgGdCf6mRSitv+o7xwbTAxb9OaKqfq0tgSKOMCTGHyE?=
 =?iso-8859-1?Q?IGhFVhSZaU85+wE9Z7SQPMuhx8ZSgCuKrhc+gzZ2+q8oGhGgoYhvttfyWO?=
 =?iso-8859-1?Q?hYAOlBPVR7WU6lLQj6Gx/E1hNhs+/MIb3dREttcz0qlAdoht+7qnFQ18d3?=
 =?iso-8859-1?Q?qczHMOYhAsXzUTZBbyJC3IC0IYQlfwI8bx0liun/lpS3RatNEeeSzZ7XAw?=
 =?iso-8859-1?Q?sNBYe5iF8oNz+0Gg2wGjmkY7c5/K0/t9sZcjFDQ2OtYGJFAUpAJ0KJYnGp?=
 =?iso-8859-1?Q?ois8Cybf+8j+392AHZCuomGt2hProo+cpznAeFhVziOLyn9dRP0w9ltQJa?=
 =?iso-8859-1?Q?tvNzYye8NGKSic88PXYTMsbj64cljCSY86kMfI1kEWc1oIsoU2SxyvndFy?=
 =?iso-8859-1?Q?8CgguFuDhbHLPtfqXvM4KoPp0vZzBBgEJKTDABznBQFL1nHznIa2hwuRE/?=
 =?iso-8859-1?Q?qdnUIuz703GaBs5y95ojSwcBragci+N1V3n7wYiEOUK46X2e10wbcxMVyV?=
 =?iso-8859-1?Q?nvMlN+e2xib0J5ppI0ksSpFdM7EeUcZfjwpMkrZyJqXY/K+qo/+cPniKfv?=
 =?iso-8859-1?Q?GgCfYdZWUFRFaE6kVn3ybup3ItWcE9K58dmQW7SHNbLbssShDeTbwtXXpT?=
 =?iso-8859-1?Q?WHl5YpNcZ9x3Yl2Ry7gWCecKTCQUmz3+gVkKOlwVhLGlAIKicCRFY+0762?=
 =?iso-8859-1?Q?wxn5bGvZozmuj/dkrkLQrABne/teR9Uuud/xRvJjLN6cb6BmYn3e9/fH7v?=
 =?iso-8859-1?Q?b0udtJkSo2KgVx39NKAoCNyoKsdjdxad4Cv6aOXEv76vL9yKoMVDDQSjKj?=
 =?iso-8859-1?Q?aVFtUYwlzP1yMXri/Vkr345g3NdtVnaath?=
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
	C8CDaupTpqKQg4aXe42uFwtp2CDzcv/IvV8sex6BwzIPeJJdpOA3gfwwkJqzi1vQD/+CkFWDY3UMrADyKYng1D2M3cvNX7feHL8xD9GWIBOvRMIRA1QizwXfFuudbv+9nYlHPiWRmQ6si8DL41g7MeAyrBcfELWMVsNma3Et8KldULGNalj9J0oryvUzA4XXBeWRbKKztUTT9WwSeIZWrH8FLRgXKO9wCfwWyx/G0tO+Ud3qLXWWNt0BtKJ7sCiDATFWJ9/Hx8uLssUxY1+gy9R6bFMNtCWfXBdIbhK5/k8H23Zd0CF7oQ3QLgvbf0Nd3ITcZGFQE0GqgRYXAzem2W+EJR0gIDj2lMqFBkculIl94mwuOTpEyQwP8h9p0q22SUQSIrphqIN1hP6l84+lL49Zlg74y57VF5db1w1zwLvkPIFPLWbjrx065vsGqFSbTFOUXEZlWM/kBr8kXpNOQUFJ1rW4cIoTiyPzAR5z0UN8IHagkTD9Wez1DOOBdWMwgHXk+Yxd6E70MixyFPwxL6TJlLCYj7Q3mX0kmI5rL4ObxJoBEJSI3W/l2U62xixHZt2bEPvaNv4cK88a1MjL7g4+1Ct8a9jBcjy3+EVyNqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d020d0f-80da-40d8-46f3-08dc602bafd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 04:46:32.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyu5J9knv3VY7xUQklwV+lYZKRYG8WNDv/L9l0ElSObDAj6Rv/GxlyAuNsoQrScb46n0+qWRyMJAmUpXfj61UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_02,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190032
X-Proofpoint-GUID: 78NNx41oQqu93P3gDFkFKnpwsSKpCdW8
X-Proofpoint-ORIG-GUID: 78NNx41oQqu93P3gDFkFKnpwsSKpCdW8

Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.=0A=
commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")=0A=
addresses the loop issue but does not address the issue that no data=0A=
beyond OOB byte can be read.=0A=
=0A=
>>> from socket import *=0A=
>>> c1, c2 =3D socketpair(AF_UNIX, SOCK_STREAM)=0A=
>>> c1.send(b'a', MSG_OOB)=0A=
1=0A=
>>> c1.send(b'b')=0A=
1=0A=
>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)=0A=
b'b'=0A=
=0A=
Fixes: 314001f0bf92 ("af_unix: Add OOB support")=0A=
Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>=0A=
---=0A=
 net/unix/af_unix.c | 25 ++++++++++++++-----------=0A=
 1 file changed, 14 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c=0A=
index 9a6ad5974dff..8928f1f496f4 100644=0A=
--- a/net/unix/af_unix.c=0A=
+++ b/net/unix/af_unix.c=0A=
@@ -2658,19 +2658,20 @@ static struct sk_buff *manage_oob(struct sk_buff *s=
kb, struct sock *sk,=0A=
                if (skb =3D=3D u->oob_skb) {=0A=
                        if (copied) {=0A=
                                skb =3D NULL;=0A=
-                       } else if (sock_flag(sk, SOCK_URGINLINE)) {=0A=
-                               if (!(flags & MSG_PEEK)) {=0A=
+                       } else if (!(flags & MSG_PEEK)) {=0A=
+                               if (sock_flag(sk, SOCK_URGINLINE)) {=0A=
                                        WRITE_ONCE(u->oob_skb, NULL);=0A=
                                        consume_skb(skb);=0A=
+                               } else {=0A=
+                                       skb_unlink(skb, &sk->sk_receive_que=
ue);=0A=
+                                       WRITE_ONCE(u->oob_skb, NULL);=0A=
+                                       if (!WARN_ON_ONCE(skb_unref(skb)))=
=0A=
+                                               kfree_skb(skb);=0A=
+                                       skb =3D skb_peek(&sk->sk_receive_qu=
eue);=0A=
                                }=0A=
-                       } else if (flags & MSG_PEEK) {=0A=
-                               skb =3D NULL;=0A=
                        } else {=0A=
-                               skb_unlink(skb, &sk->sk_receive_queue);=0A=
-                               WRITE_ONCE(u->oob_skb, NULL);=0A=
-                               if (!WARN_ON_ONCE(skb_unref(skb)))=0A=
-                                       kfree_skb(skb);=0A=
-                               skb =3D skb_peek(&sk->sk_receive_queue);=0A=
+                               if (!sock_flag(sk, SOCK_URGINLINE))=0A=
+                                       skb =3D skb_peek_next(skb, &sk->sk_=
receive_queue);=0A=
                        }=0A=
                }=0A=
        }=0A=
@@ -2747,9 +2748,11 @@ static int unix_stream_read_generic(struct unix_stre=
am_read_state *state,=0A=
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)=0A=
                if (skb) {=0A=
                        skb =3D manage_oob(skb, sk, flags, copied);=0A=
-                       if (!skb && copied) {=0A=
+                       if (!skb) {=0A=
                                unix_state_unlock(sk);=0A=
-                               break;=0A=
+                               if (copied || (flags & MSG_PEEK))=0A=
+                                       break;=0A=
+                               goto redo;=0A=
                        }=0A=
                }=0A=
 #endif=0A=
-- =0A=
2.39.3=0A=

