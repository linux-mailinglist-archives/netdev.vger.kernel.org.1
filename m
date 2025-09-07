Return-Path: <netdev+bounces-220650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480FEB47892
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19853B0201
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A93D561;
	Sun,  7 Sep 2025 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="apZBW+Bo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sQhV1QSn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75EF1096F
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208873; cv=fail; b=k2OL4b/ynr+8Ui/f3MMJR4/tcYRh9U5Q2OvEKTr/qbik37tByBLGCa02CmeIrKsUFjY3B1a77pFjhjP9vMr5vlEC+BzD36Ke4CGvYkukEdrguN+XzvInkyOenbSDHh8XuJiy6mDZMGiIpTcc6WcJiUwEtJYMiBWmvNYx8bZ4gOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208873; c=relaxed/simple;
	bh=B6cnfawFDQlTC5RvvCbbDOH6RZm58x1VwqHJ6rWKYvU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MIN03EVeqDf/94pOkf0JbLZSG7V1BXm4OBe3VJtLrr3q+uKVPvAtgFzZsZpYz5IhG8ThO+rGJBZYw+ZVRtRsM2Qc32OUoW/2F4Wun5mrgv5k9ptZbs68AYH/TFNCV5nXFyHZYwxQws7/W4sfGr0Z26Gq1/jJwO7kUCTHRem3QLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=apZBW+Bo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sQhV1QSn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5871NKcW029405
	for <netdev@vger.kernel.org>; Sun, 7 Sep 2025 01:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=qOa7COGlojJV4RJA
	xAh8L4MjrE8hPpi1GIOZW8uuQFY=; b=apZBW+BoTcy0OCCKOPBLgFFHiVHCfjki
	PdnAGbhLbrR3/IDm3b4rn4wwIFm3Oa8jf5WooX+wQ8tLmITs7d47chPtscPMoeoq
	I8JLwbhgfjRQlrP8vYstrDfvWw0YX0o9EtzC2BhMp/sQ3Hty922NbrFB3vTGL4qU
	8VEAQzUjosVqQn4HY8xz04+kMCrKLfGJllvpGtXdHDgorVsW/dR3GLxHt07oaAmx
	b9c1lWq8D3tVXu2nCowNpLKx3ceOEMV/lEqqpWRb+GmSLMlo0K+2BEyVSxXDPdbd
	lWGGQeapd6BiKMIAZuQjVbSxJielUGay/7jYWVDZpwe8GVi2OnqDaw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 490yww00e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Sun, 07 Sep 2025 01:34:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 586LLgU1030767
	for <netdev@vger.kernel.org>; Sun, 7 Sep 2025 01:34:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd6w9x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Sun, 07 Sep 2025 01:34:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4k3SpzvHdTiXsb0t/Gm8s00x6QUDiYBF3mwXOAP4wqHkg/wrq2d2Ly58gfH7qu/CWatyujPX59ILUQS0Lc2b/Xj79obk1KBEWaA2i38aHwu1DPI0Ee7OCbYGSgOPoj3S+hzcihksRG/7NHrO5pKuTFK3d+mj40qDEsBHA54TM/kqFyHGCQ4bP/CKnRo+VocVk5aC2wrzCKU+qPtYIWFe7vMG4sgwi1CxnU72MBq1KrOTXc7zBHiNspNEtjDYXW554HGGqKyUxfA9OqtmnYyMHImp9l0ugsE340juEEOcf7FAXyScVIV8g6g5M02BYpAr00iRpfB/B5udtL2mC/y5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOa7COGlojJV4RJAxAh8L4MjrE8hPpi1GIOZW8uuQFY=;
 b=rfjjAWtDQvnZ0vIf22szu0ic2eAdwKjqOVs3nitXvu46peWkd13wtoA7+nS+lHTN/VuCs7lBLfc9v5xv7K+V42rWhrN9fUI5dcccToA1yxlqZCHCIDY2GixAm3Or3732eI1ge33RPsdaO+uy9XxIcLAjB//9dnjM3lrC0K9JzgeYTkFv0q77Mu+ekO4p1i6trMR3uhgH9oKKi0ocIwtfjFzO6KmB35wwyChYtyUVdSnILJj/RGXgOK3v3fRH0SZzt1Gcs0iI94ah+iuA7sRsmO6WJq9OrIW7y7IMsh0kY4AQm2jKeyJbuXmtfpLS0686cizcK8enYYIzkKytLxDi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOa7COGlojJV4RJAxAh8L4MjrE8hPpi1GIOZW8uuQFY=;
 b=sQhV1QSnO0EAsY6HMZI0qbHeFVQPRm7ZOAAljZHTS7QxzkyyH+HREYe71E7Vp8J4JC+eFmewKWmema7kYZuEw/I5FmE/fsCpwCZrsnSUQQrWNXGXu4eLc7CqO6vsDZEwNPZ46ab5UdAp5/vPN1bGDaHJBaZTyj80DU1hUzlX5CU=
Received: from PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5)
 by DS7PR10MB5069.namprd10.prod.outlook.com (2603:10b6:5:3a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Sun, 7 Sep
 2025 01:34:26 +0000
Received: from PH0PR10MB4504.namprd10.prod.outlook.com
 ([fe80::d0be:f934:6ec3:7fcf]) by PH0PR10MB4504.namprd10.prod.outlook.com
 ([fe80::d0be:f934:6ec3:7fcf%6]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 01:34:26 +0000
From: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
To: netdev <netdev@vger.kernel.org>
CC: Elijah Craig <elijah.craig@oracle.com>
Subject: octeontx2 (rvu_nicvf) NETDEV_TX_BUSY state handling
Thread-Topic: octeontx2 (rvu_nicvf) NETDEV_TX_BUSY state handling
Thread-Index: AQHcH5RmOu/c/zvqWkiWPitXjAQCFw==
Date: Sun, 7 Sep 2025 01:34:26 +0000
Message-ID:
 <PH0PR10MB4504BCA65DAAC15BB640FAFAAC0DA@PH0PR10MB4504.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_|DS7PR10MB5069:EE_
x-ms-office365-filtering-correlation-id: cbc6a822-eb31-4a61-8a3f-08ddedaeae95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?J69/2WDln4h4D5AG0x+TnlH7S9kvUtBhQxctsh7FABSXnwmz/bM0C2XTg3?=
 =?iso-8859-1?Q?v8rk4VecX4pBRp0GRaZYzwmNeipdpvN3SiioU7ckTeuGGZKkLYJWFXZ2SH?=
 =?iso-8859-1?Q?RmIQ5sSBPNxOoX1M6hmcyGl50sCw/85Fv9dBl1DjCqxpxv8+j32TF2D8Gp?=
 =?iso-8859-1?Q?eewibeSb0q3NYVeDijAhIJF//5aFJYNbmNu36td8JwTvWkvT7e4Ogwibbb?=
 =?iso-8859-1?Q?FWIPvOb/OyLURX1TSS0r1AuIm34Ysia9J8oWfsHdlVHQ34kyXhR36VDGN4?=
 =?iso-8859-1?Q?fjCYFD/iUFtoG8M3kUt0ndhdv5zEHCUqglnUnkTnb5jQIgUkR/0mVmROSr?=
 =?iso-8859-1?Q?442ReWAkUChFTVyR8a3cjT0oa3d/5bDTXikhUxEL+D65899ehfOiJzUzT2?=
 =?iso-8859-1?Q?jwpJI5EccIRnMuUDGgK1qd72mQ4+yYRVLW6xEPhZYnKqGH2XxC8yNzJVXt?=
 =?iso-8859-1?Q?7gQy7shwM4NE+yR3Pl73q8UbNnaLZA5ibTIRfh9OhV93LfsDxVS4TSUPgS?=
 =?iso-8859-1?Q?Xe7Ls2GKq4YouIVpn/Uw3LPliknU28ur9/G7AR7LLKBapScI+4eUCT0wVH?=
 =?iso-8859-1?Q?mg5xmuDzenAILLd1l/cFqhFtms9k7dGCpI20zrMDG3j7uPB7Zbr/9rpuGS?=
 =?iso-8859-1?Q?GQg+NaNiif4tCFhWbY2uIUpdp6jXglFoHGUZYGAzefgv6uUjxZsyRfIXF4?=
 =?iso-8859-1?Q?0z+tkV70pvkbpZIFFbHXNer9p+3NZqtZBBuySD40RIvgnWFbhFf77MF6VI?=
 =?iso-8859-1?Q?bl1Qe5Ky4t+pfx7BQdgeOJHwjShED7Qv2blm9XzxBpkTgUSmAIM7T1HJSf?=
 =?iso-8859-1?Q?+b8T610BNTLocL0rU0H9GiDqGVvOnex/nvHOEemjp2nPQ6SmbkuFd3Y/FK?=
 =?iso-8859-1?Q?Sabb9PMsV4ErNm4KjSkJPs7fsl/fEyhfEQcFulbUadYSMqp3DT0aJgGzRe?=
 =?iso-8859-1?Q?fuBEQ4tJZ3eKol+oUdXvs5QFs/DKq/Ss0AGMTpo6KkSB419Y4TeEtx7r3M?=
 =?iso-8859-1?Q?cUrlI+COncP/Sn0gIi36adSUJCrnp6pDZA+n1zxpQ7sqRosi0Il5dOQ/UX?=
 =?iso-8859-1?Q?S+zCYhUZ8eSyJ2+cscVIpqLpzI2FIhmECw42MGUXF9Y2h3M/ca8sIKYoMG?=
 =?iso-8859-1?Q?43IOdleD11ECxxXDNkODWHmhbc9jnhbx3WAQ1LFwVTxwfd2sPuJQEgXF2D?=
 =?iso-8859-1?Q?qh35RG//3Wt2zMU0j7zphTTE0eYVIVYCh/iXQjBOU19WzMdsyx2qqIw8D1?=
 =?iso-8859-1?Q?edxm3jEONz6W6HBknxwv+jIx0M1oyrIDY0UyEWRpz2QmgJ3ayCxQJQpG1G?=
 =?iso-8859-1?Q?HMupVV8xEVhL0wio4k9KLCcC5/M/oHJw7Jqg2vUyMTSgDLvpdqeBDBuSRE?=
 =?iso-8859-1?Q?2vyLSKtXZGN906Y1D3IAOwTTPHF4YWaaPCUEB1Q6BQDVPm94iEVCt4qX40?=
 =?iso-8859-1?Q?d+nY0OiAURt/iMIJeMn/CQqc2RZZZVae2BDRuBIKSCWQkco+7+XhaVcJLe?=
 =?iso-8859-1?Q?vrszamrzxbtF7luRXaB4QgpZB6mSSS7sIHKey+BcXGGQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4504.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?L7BSDXYWJDQtqo0btw5446E33FQcX3/7pGqxlaAsIkMnJi6NiA8po/qKbO?=
 =?iso-8859-1?Q?+R4hpeSPnPV+FWM25Z7eobH7IRtEEyNEfE3mptPLJunLhKHsXKbAlMcAv+?=
 =?iso-8859-1?Q?xKXJbV40OV8OFLzLDVbNdT2zSEDfouOGc7YR67kkvtI3Pvr6QWtmjVYU9b?=
 =?iso-8859-1?Q?o4TyjGDUTR6Ht2+e2MYsP/qGGFzAQTY7J/9anegCPVWy98oxW8fB3iwJUu?=
 =?iso-8859-1?Q?1lcmJanDR1zb16ocJc8dfTJAnfbyBALZYBnPPrVWcjDSN34OVIP5M8PEiG?=
 =?iso-8859-1?Q?aV+23DIX3gi5GeeRoX3hUjSxikN33715DonipIy9UtyVIWy268559jJGcv?=
 =?iso-8859-1?Q?TbPHX8NkdqKboZWHMOszqMKY1GFNBWme/RkAVsPXm2QE9U+8nzkAlzKvLt?=
 =?iso-8859-1?Q?7nnJfJGihPNNvIUAfSVmLH0ImBdB0yY4HTNXz5i8MPlUj1TBV4x79Pwmmg?=
 =?iso-8859-1?Q?lrbATlRqVj2JGCYXzUeznxl6AUAk504RE2vGtR+mKUfelYWN31uGQBDzz6?=
 =?iso-8859-1?Q?tQof+uh37H3lVaVbB6qukNXVuHAioNWtszSnBZ3GIMfZsqi+mTAp9DGOPI?=
 =?iso-8859-1?Q?IleuZteoP+tMJPLylBiVv8TwElrg3vYZIrmAXQFSX2uUGviWe4WQQQS6Tl?=
 =?iso-8859-1?Q?E+0q8K8C1tZrojdICq9RNhUTJs5IWAOdkw9ChAcb3y3NDfWcR91dbWP+sL?=
 =?iso-8859-1?Q?RH5b7wWIRTs08Oo6EHUmYNFelUJ71wifZMhxNIf1zNVvTjy7MG1QDxK7ar?=
 =?iso-8859-1?Q?o8CeelCvjwKE0kleTe/pTHsWSjPnriWG5I4YsIqO1adCx1fPZiPSyZDUTv?=
 =?iso-8859-1?Q?EPcLQLAD2PrrCI+r4YW0sCQnw00PMqE3V7ywbpXf3XJuCD5zVkH/a62Ngd?=
 =?iso-8859-1?Q?CMsA8N4AYZPmQWt5x3ocs6YvQP2BIwRp+ClQ4VeTxjVNU/DZtDKEkr2Xan?=
 =?iso-8859-1?Q?1rwjRXg2CeXthdBXcRW7LhOb/+9Obs9Z8a8YTsEkU7oMiswiZUggMczb4Y?=
 =?iso-8859-1?Q?FsbCefMKUO5nbPf8yTvw8xzxd/84+rDnpUoLGFk1codMg3e8GggDQUZ4MG?=
 =?iso-8859-1?Q?EdkB/SLEIJRO28/Lo7gm2TlR2Z7YtLqikrXV/VzfIHBf/Pk1WXweCyk/fS?=
 =?iso-8859-1?Q?FTOkNTo4pTJ2d61guvcgfxT1H9UOU4+wD+bl4w1oTKG0CuM0hKKYvquU9m?=
 =?iso-8859-1?Q?dXZUr8/mBxOu36CTVXvqborMtrsShYxWMqtBUlvab4QJuqL8UUCdvUWBvI?=
 =?iso-8859-1?Q?0E58em5ejNgqCOgEyqHfFK2w0RYTRieqKC6Y28yAZVHozRpLQfukh+FRhu?=
 =?iso-8859-1?Q?j7aHMeLGU+PWq4qXAtn6NZZbvVDe35TN6Aoh7DXV+m2v/wHyQCX+kZ3qDp?=
 =?iso-8859-1?Q?f8dt/DU7prBd3hM/TMAizrOFxCDKiTNatQUvMhV0LOzXhNy33WYQ0YcBfz?=
 =?iso-8859-1?Q?hdhHx8oH94l04lz6KBXsFivFJUwBPMh0CianMjakorVGL8EpBwzCPgCUWg?=
 =?iso-8859-1?Q?w/S9saOCGNAX6fOdAMjLDolwMkmaP4QR/f7emhtxabiepyVTFkOyy4YeQq?=
 =?iso-8859-1?Q?+1qsygbcyWBTb2aFaSXZWy15yM1/bbZszESxeFYMJvIflTD6CRxv0HZNg9?=
 =?iso-8859-1?Q?Sc0vd+VNrXax45Z0m9+Kh6dEwKGC8rUwR/XRhSDBUnXckVe1ZVjWCyNA?=
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
	KD7wYPieQyHOw3dfrRmsXkE+juIBsG7dUrTywN2cnd+5KxC5cu5Uh9aX0ilgxLJlc58MVvH5uQGJoTqHxJYwU4SqFuulBfkt8WGfX3IR0qubS0tDjcbDx6rAmU5+RAFCGfbx6rY9zePIhRhmwgtJo9DwzkZ12GZw5fkAgZvwf0dV/Cj6W17id/TQ3knm7hx6Mh8hZTbMHMASjwejnW4Kxc3j5tyhMCPJtVgFJkBaeT/yzibnnZomX83ztz7R3vLxbE2iDnbVhdFF/D5tq9Bb/p0eDonc/xqhsRYJstpFstWcsFdJ9i71DkdL6cLc3+M/GNesTxLr6vZWrEmyZFWz6KhHjLQTAU7W5KMvv7cBTYwo3xgwP3IP0w62MQuwQv4209ezvdtnnmWsVJWAQK32dAVZCtoQeGbYjycI7lHyIgg8qpf5M5WeW0quUgbjuEzzvTA7qQ9Ho8EXJbkERz9v7QSyJxCx4UJMwxDqf5opQW3446itPAiXJNoCtb3w1DFl2MFjQaB9y6yO24o9O8jp4g/JfE3/O/k2AodFRHg9veDuH3bJDN8Y82pUj3FrnYT2AbE3aks4cJ+M7cYgvnkOo4WA3r1Ec3ZdSzVd1jYj1yo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4504.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc6a822-eb31-4a61-8a3f-08ddedaeae95
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2025 01:34:26.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WbEsfVJHMC2BWBtGZbLBR1a2GlORD8C1A27tU5rQjlqeEOCqS1xm0KllOhNyxQGG5+NFxn4z3sy71qgzKUNLNt5lhcq9HVDR2N9iFbzAdcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_09,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509070013
X-Authority-Analysis: v=2.4 cv=P8Y6hjAu c=1 sm=1 tr=0 ts=68bce126 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=Fj4dLQn_6yKdJBUVTYoA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: jJbkFG1ElzZs7lf2G9P-2zPGPMPx_Fhg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDAwNyBTYWx0ZWRfX/Aqfdh9V7PGB
 20q0MHNIEET65hwIlVXroMK0dwQC7de1GJ2LuGypwpZEGTa3fuQ0D6TYtYnhTH4lYdxdiKFeF+u
 Q5mulch49v+g6yRa6oAmfqB7Qsb1HdFNPQj08BuEcYy3Gbb4s2yrmaAxelmw4bL/+kvyATJnwob
 7fJJmzs0vg6wTw8ZqunAuRfLvjEjSX5ftpCAIItvqP4/HN2++pPwbXrxY4SSAK+E1MYIjBa5/hq
 uWKlwmsMYAfT52fXsMuOtJGhBBzq5TRrWT8r+KHo3JBznYusEAZLXq+9cRnfH0HTsFHd3K6Tn5E
 aK9vdOiNw66r/yB1xiLwSWRYJFEG3XFRIsdcKVjYQNJBvUMkNTxDtmR61JnHNFTtJ2wTSfTKUwE
 3OwXhcM4
X-Proofpoint-ORIG-GUID: jJbkFG1ElzZs7lf2G9P-2zPGPMPx_Fhg

Hello All,=0A=
=0A=
Would you be able to help us understand the following behavior with octeont=
x2 driver ?=0A=
=0A=
otx2_sq_append_skb():=0A=
=0A=
        /* Check if there is enough room between producer=0A=
         * and consumer index.=0A=
         */=0A=
        free_desc =3D otx2_get_free_sqe(sq);=0A=
        if (free_desc < sq->sqe_thresh)=0A=
                return false;=0A=
=0A=
We get into a situation where free_desc goes below sq->sqe_thresh.=0A=
And remains stuck there. The reason for that is still under investigation. =
=0A=
=0A=
The help we needed was with how that state is handled below.=0A=
=0A=
otx2vf_xmit():=0A=
=0A=
        if (!otx2_sq_append_skb(vf, txq, sq, skb, qidx)) {=0A=
                netif_tx_stop_queue(txq);=0A=
=0A=
                /* Check again, incase SQBs got freed up */=0A=
                smp_mb();=0A=
                if (((sq->num_sqbs - *sq->aura_fc_addr) * sq->sqe_per_sqb)=
=0A=
                                                        > sq->sqe_thresh)=
=0A=
                        netif_tx_wake_queue(txq);=0A=
=0A=
                return NETDEV_TX_BUSY;=0A=
        }=0A=
=0A=
With ((sq->num_sqbs - *sq->aura_fc_addr) * sq->sqe_per_sqb) > sq->sqe_thres=
h  remaining true=0A=
txq is kept awake and NETDEV_TX_BUSY returned.=0A=
qdisc resends the packet again and the same sequence repeats (forever).=0A=
=0A=
This gets us into =0A=
i)   high cpu usage by ksoftirqd=0A=
ii)  the tx timeout watchdog timer expiry doesn't trigger  a NIC reset =0A=
     since txq continues to remain active.=0A=
=0A=
Pasting some values we had gathered with a trace in the hung state.=0A=
=0A=
 otx2_sq_append_skb cons_head 0x890 head 0x6f4 sqe_cnt 0x1000 free_desc 411=
 sqe_thresh 412=0A=
 otx2_sq_append_skb num_sqbs 0x85 aura_fc_addr 0x2 sqe_per_sqb 0x1f=0A=
=0A=
While you are there if you can assist us with the watchdog timer value that=
 is chosen.=0A=
=0A=
/* Time to wait before watchdog kicks off */=0A=
#define OTX2_TX_TIMEOUT         (100 * HZ)=0A=
=0A=
Why is it kept so high compared to other drivers ?=0A=
=0A=
We encountered this problem with Oracle Linux.=0A=
Looking at the latest upstream octeontx2 code it seemed to function the sam=
e way.=0A=
=0A=
We don't have a way to install the latest upstream kernel on the SmartNIC.=
=0A=
Currently we hit this problem once every 2 weeks or even less.=0A=
Pretty much random time it takes.=0A=
=0A=
Thanks for your help.=0A=
=0A=
Thanks,=0A=
Venkat =

