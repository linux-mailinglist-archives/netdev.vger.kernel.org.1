Return-Path: <netdev+bounces-185440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76622A9A5B6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5972A3B41E9
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10944207A2A;
	Thu, 24 Apr 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JC1Tguwe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aZ6wJCED"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0692C20A5E1;
	Thu, 24 Apr 2025 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482854; cv=fail; b=WO1/dopd4VIItTS6e/RrcbndiZSlN18h3tta3Y9PQbN8hW25/rbhEpDT3ctreN37Uf2D1CGwSnErZrgJJLhnOJYCTVeGuZFJuvEvZKqpoRpclFH8b3qaQDfuUNO3FgPnb9iGQ0Pj9JdFyugx1iiX0KKw8lQEr+dRgYrv1ommG4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482854; c=relaxed/simple;
	bh=LrIVc7bfPdLmgfDoQdveyTvE54xhKRw7KWUbO/3EASg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ESR4izMKmiSu5iusPBCzNBqZfLxsILNjnnYfZi3eoA9xe/GstiovBz6nsA+lWu736+cj4yYa2qT9pwbKSphIcvZhKopdniDpMfPD83Hcji39H5FIhI3AIISrgGxbHlz2ZDHq/Ote4Vl8Va63sAzEDEDO3+JAOeaQ5Fy9zU8MSgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JC1Tguwe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aZ6wJCED; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6ttR4005503;
	Thu, 24 Apr 2025 08:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aog4JoMrhgq7+h5K2ucK6aO98+XcuAAgabvG8owueYA=; b=
	JC1Tguwef7cUYpy/BG4D/IN+Lnw3DDMNIkp7pd6LOXKBEvqtZ/Q0ow0trUTqKIaZ
	vVixCaaHrJAQlytiAw3IMGDSLi+ygrKUfr0ICq1AWgLFHsTMo4EJeAhEhBvz8ESR
	tvk70RHxpAAwerne0M+Vf2fUGRKGJdRSnneJX+VK+j2kK2jdDevqluJakUWol/aj
	loabtboDlMz5jedzGkBXEqoe2JczAbyMaSaUG4WGARGl6p/OZ6iMlTckz7zG1Ike
	PQhF1XtRL0qW2aK7R9n74YrnbaQrpGMTMyxDitP4NjSLNneLOi7ybtObNI4ZAUJQ
	u5NYJ0Xu0oJrrUY+c7dnFQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467fmk86sf-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:20:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8832f030957;
	Thu, 24 Apr 2025 08:08:36 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012050.outbound.protection.outlook.com [40.93.20.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k06xrde-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbAIuWoEk5+7SoqYkJvGpJ7mPNJhYt/OnoU7V8RNeiTMEL9E85FhBwqlVzIqXdLF2V/BDmDRcuex4ThO3CEtQdiwG0GZPcjJ8EcGFwiFe6nKu7mgt10YqpgABOmE06TcQOJldsAI+LmeehS5yTBRMD+lf5Wgc++3osBU8M9TXARscPi12OBd8EWlifxoy07Mj4mJjagtqORG14K//u9Ml7J4Vw6TI9HjnWI/EhvDVkPJRB+9IJZzNFNZ8PNd82sNZnbk5BR+grswwTJN3xd5TfW9sT91OvJckTRVGG39Vfj+4b0ZLM9blgC5jaIJeZR4UlWsxPvI+YyHyZn8E6YZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aog4JoMrhgq7+h5K2ucK6aO98+XcuAAgabvG8owueYA=;
 b=DrYvIAGXAM+KwQ6Ssog4R5mEEUTb9weIt6V1KF6VjxDn1bqK01p9tzPyobrLckcO+6L3SqtjL8aJEk/cy1fjad6odDglS+xZUOsyAawPoh+vG9l2gsFjkzO23RDup4kRiKpb6fpJYajqWXd2L/4aC1yNo3dVZtzkag9Fw5Xy/SOXHAbyn8fNp3hpILIEUAxwBvUbHDrn1rtQBDib7Ehoo/bDmfBGYvd2X+Q7xKsGyeK4nUGwm00Z2q2fUO3YK3zvfS70viXCsAXxx78HMESYaeWiUx6Axi67DUaZxojH8G38SHYl36IN0JB4wv/C3Ig0w9YvEccj2E1G9Q+snFUt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aog4JoMrhgq7+h5K2ucK6aO98+XcuAAgabvG8owueYA=;
 b=aZ6wJCEDRefC2NYrLp7k5H4LldOnHuAb/WBXutrFEuq5uDREF3+UWT/v8YqwLuG8FqY9crpNb6vf/M2llivomRDH1AtM0973l4w8yvDqS090OWFvU8Iz3XmBPIQ4fjwE23tpw+cESHENQaGuKX2MEtZaO6rUQXILuiQ8vPE8FQc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 08:08:20 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:08:20 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Vlad Buslov <vladbu@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [RFC PATCH 3/7] mm/slab: revive the destructor feature in slab allocator
Date: Thu, 24 Apr 2025 17:07:51 +0900
Message-ID: <20250424080755.272925-4-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:100:55::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea955fb-4da6-4949-1bde-08dd83072d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EyRiB0O6IHR2jArXDG46wI7V+LYfklYOfnA5/oQuX99ay/bMRcnCC+QDBP83?=
 =?us-ascii?Q?1rcJOHTfaPfbkeCboIKz3d1KIeA9OAOy6mokZgNN484+YT0iGYjwleyoBirS?=
 =?us-ascii?Q?xolzxZNayZzTLB6HjULHZ+5dWh0bO+0qaQ92Ha5eniPLgd2MWB0q+9erMutE?=
 =?us-ascii?Q?msVxp4/vkEyGE91Gp2nRYT13lnvjbdo76IrAY5gCdugzMBvQSx2gut6AZ+SJ?=
 =?us-ascii?Q?ENBCGcPCspQuWoYNNudNV3Iq/aNi/zmO445dpdnN/Hy/eVPGoU1pBGbnv+9n?=
 =?us-ascii?Q?4ahrjpxuiMrH22EB5YXuyKZakYdB+utxW9h4aNYA62CXtV1Fhd/krfxzoaCw?=
 =?us-ascii?Q?VrbV8SuphVUrEf+qPCcBvR2NgyGG9FmDx71tdCQt3QGYgl30jxSb33RfemgP?=
 =?us-ascii?Q?XBa1UOU/ABArsZb5fVsYGBwJ1Xrji5ctQzjb7UvK8S0jhl8W2q7rR5HGTnUb?=
 =?us-ascii?Q?zL0Ve3V+mu2FsVAtbYIIBmFvzxqj2QZ43WqwcK2gl77U1DEJhCDrBSss4pOR?=
 =?us-ascii?Q?fwFWmu8PX8E1IZVmuSHVU++7pUs0++JfOGZ1xV3J8iQU+CRfF8pzmsm6Ok67?=
 =?us-ascii?Q?Xv03I5m+4CXz9AoyGm3Nq03RaBeWEKwosop5kkFnG9tm20TxZU81zdNzM7un?=
 =?us-ascii?Q?MUZU4L9GqH/yqCAcHRSDeKq+QyQ1ibPFvZA356cs3hbce67Sz9St1tE+SCN8?=
 =?us-ascii?Q?tn2IGu4le1kWNs8nWDnnki6yPW6A6SXi2KR9m00pNL3AS4oVGrVeVcnNDW0o?=
 =?us-ascii?Q?TsTbLtvPM9flJmJ3hmH5hXXoSrh5CYeeUASrAHOxqcgxb+T3Hg6qu8X9zHGb?=
 =?us-ascii?Q?oEk4RXOqaDnLVI2wy4k9gUGvRb5g7BVDlhejqCCY2+tSFCv5dqtXzj1IUouJ?=
 =?us-ascii?Q?1mH0+juE/zGcynTbmx+a0USc+tOgSebB52VfyUI96LfOC6dmgc+LFS49Wrvt?=
 =?us-ascii?Q?K21siLP3ENYfPM72RVDsc/Gpw69snYfTKNSrtNOEwjX/GIRHX6QaH5wn62eL?=
 =?us-ascii?Q?f9WsItN5qhtDmMj2jZLn4HHnUyV3xy/T/zN70hmU47oVvvGitv7+7G+uFwtA?=
 =?us-ascii?Q?fjwrZD6ECCSNqxaH3vdVhMWShkcSbScXLrfOtx2rmPySa+OLhoQhiRQGcwGM?=
 =?us-ascii?Q?8jm/tLfT5qEp6jb05NQPd6uiv7Ok/GABF6Udp4wsYQqnZizTPZTIWaEYDhIX?=
 =?us-ascii?Q?KtwuRzWVLCcxfDMnhboTj9y1UlZ1mX4BksdV0gVhE0/SETUwT8B3oAnfkXHD?=
 =?us-ascii?Q?Av1xKs0j2hQ2TsSnWav70IOOggC7L3l+3HSebpfXr3Z401avg/qsuwOorDSy?=
 =?us-ascii?Q?6SKJ7kvfTSUlAn00IcDCVeUve2VR1kYTQ5Le7IX3jBLhGjr8sdd5gP5EdayX?=
 =?us-ascii?Q?HDKeir9aZP15uVeD9kUY/BY5riB4+C6yh3Vfvfy/JO2skssUPeDZ7dyc776N?=
 =?us-ascii?Q?AsuXgqh6ems=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CG+PMCbKLvt5YpOcPcUeeRYJlbc5xhgWsoSUAA+/Np16JXZSxv3JIgDRTy/j?=
 =?us-ascii?Q?pv8iPaHtbYVMscLy3ZPMum5DkZoTusMM2KBArwPpHrhZ4pTW/mzPX3+HdxEy?=
 =?us-ascii?Q?1MFLakLxJg8KSYmGbcqt65y744pbJqXRsh7ahFao8HgQ8THR0Rn30Qbb2m8y?=
 =?us-ascii?Q?427jgfWuPLsVZHzSzFl60F45SnloyHAMZLAI5Brk6GRx55BbqOiqHVHDgWXR?=
 =?us-ascii?Q?nVq2+yBFMzaAn+hphIxXQSmZaFl7pE9OdLlFgx3mgJcFHqua2/hhgQGLTvgZ?=
 =?us-ascii?Q?GEcPoEFDuaFU+0J+HlCBCNRfZ5UIswQr9Wb2qO6oLfULIGUMcw9t8tIcl0A8?=
 =?us-ascii?Q?eSt+c98UifjC2j/RcUfv/28KE/qaWdxhyv/F/BIv9F5jhLeJLRNJtt0ypkKa?=
 =?us-ascii?Q?lMvOpQoG8eYD0qEEc5P0J0vJLcyAJofZ6V9j30lCazYgqPgVO+7iK2ZE42GR?=
 =?us-ascii?Q?BHbzsjCIQ9kayWfxariEs3zl4Q30d4aNkkM9OsVGFoeUsKJ5M1nEjYHtBWOU?=
 =?us-ascii?Q?xTeHMvEnUUys6TuxfDBckiOlj4hpKrBjac4wBK6n7wr42XIyJXNjHfCpinWP?=
 =?us-ascii?Q?qlLcPz3JfwGen4d5sfRZGivwRR8caLZwAIw3iq1UGgDJxpj9lqwUUWDJYSRu?=
 =?us-ascii?Q?TTMXZSgrMDsHD5o5EsDvjG4UbSwh7yCnF8Nxwig/LQ7Gnen+kTJZBBJdOo0O?=
 =?us-ascii?Q?3qlYiboIhC69dRunncg+oSTzKcm8Nj56q8/3zl5qPYByRKUGZSsR0MO7SJkU?=
 =?us-ascii?Q?98oLbWdq8N72dj+ZNhnl+BeTqVQdneclJLc0kyktUK1H/eqmhaGgjhUbyCH1?=
 =?us-ascii?Q?IVi71ZMKUU1MO+t61GmGWEcFxmmY9tjPfQyN0hvh4+eOzNW2q+OZ/82c+psp?=
 =?us-ascii?Q?JjpACgVdTubiuClfKIApxaonmcnJMZX4p+aUJbjrrTVMuCeCn+6qTBNqJ3rO?=
 =?us-ascii?Q?p2CPLxTzmVJJInZ4hYuJmXT3dd3Ei2APnmn3GgemDyxuSBRjH4N2HAV7Ab5C?=
 =?us-ascii?Q?HSZGFhIF7uwS19ICjerjiyrcBZ0fVikxsQfB6NM6KxogvgvhyHJgZCsVT6DW?=
 =?us-ascii?Q?TQesGIr/fpPXRbCDZgsw1brbyEdlSfSxv877iiIWE61aH67UYng9nXCt+dBp?=
 =?us-ascii?Q?tVfsGg6o9EpbbysqxfRl0/o+39Y5Qmmalh26Zy9YJsXTff/Z1TZhVKmT5AaD?=
 =?us-ascii?Q?zxwGPimnB0j6cohUaUOjDM43gvkbjodX6zYgIQz++UiDTwZHxRDTKeVSD4Ok?=
 =?us-ascii?Q?iRGVQ11PaNmkcfkRPnrn3FVCBV/ef1tlpWqz/Q8knoXsLQi/xkjwTbSG5vdF?=
 =?us-ascii?Q?qf1HDm2ctVvDVVmrXd9fRkY/HoobytBgHU/raohilOZd4Enoq5StK0nxDw4p?=
 =?us-ascii?Q?3W95aKbnNYpo84srQOEp1/hXkNcgkZtYCM9bI9xuwDxp+VCbqfsKRz4nG9rS?=
 =?us-ascii?Q?0I7QbiWcYzX8Ob3QZjUDrlce+lQ9x1IHeqtGDxGC/uN7hhVmXLw1NlfCxCwh?=
 =?us-ascii?Q?T///fsP/tCcEtuNCGhZ9jpZl0vOLdCHOBZFQNOqAjGThnSmDsGGd8YgwNFBv?=
 =?us-ascii?Q?YKKEmdZxlWDQ5bwCgwceJ3FB+ebG1/lgnajNyzNE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yt/gTetmstNudtAOjGqRgkevsxcjUiDpt48nk88vTWF0dOka8WFeQ05o5HUZQpVnGAMerUAoU8H/5cAFgSFxaVFK3xcX6Q+Fvdii9Np+cLEM+89ZiePpvZlrRNB8oPvzxp8g95cJpJZMsAF2okUzqcpCnnycn60oBnvfNifaHaKl97fRFoCdm9vrIBE7+nM9QKOXoWQgAMYbx2aZL7G8w6u/CtCQUkXPiYmnwtrHPegXel+iYSmPIhCDlUaDMv/uRCtMXus6+ksmYOhmteotuAPlkOHrsM9OKK7pyBtKC61sgQO0Szhfz9D/30BL9cMR8k12Vl3fw82NRu2PVvaG61E+OeemugiR0AogXJGlabiLlDwMvTjznfk9elwfpc4HVYcYZBymqOyvyI0WNJrGuSYXwfAySleyHjeMA0YuS5x34HLXlerIcx3qMAcHkq3urtf4hIWla04vexa9YeAxj+0BCbYq3gjcBTM++ERfMx7EyFYnO1mXQ3MfIJP4U3tKmcjBo2tkGt2sX80lWdl31+EYxWl9aL+XfYtWtvsN/4uu/x4mnFN9voBRJKrL5/9/yJwF3Ixp8s/vwivvDBv1YT4T2m0bSJCd9FG7cwmUlz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea955fb-4da6-4949-1bde-08dd83072d32
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:08:20.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0x24tZhiSF5/Q1sPEg4PyLt4AjdngpmlryWdU7pN1D1JoCidA3Ef8IAgrhn96TAlzh8ZYehoagGzTBaTkvLCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240053
X-Proofpoint-GUID: opq1G5kMpRkB9bMtpFthF1kXDRbuXE3r
X-Proofpoint-ORIG-GUID: opq1G5kMpRkB9bMtpFthF1kXDRbuXE3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1MyBTYWx0ZWRfXynVW9g7MjHg0 rvxKbH/9h8q3gsTDOkr1GJ1zzKr94/FSJxDf06BoSWUvOF3KQlxFM3zeIHpySHj7oopa1ivComv 9e3uDq5sRVnKG8VjQcniy6imGHGlMlhXDtrGZ+DdxjjQQrklz7lL6SpMuSaRUkkORfdFeGYrExr
 JTDiDDX/bTrnqvxKeU4PbfU1wn5Nouw+RU8yFBXh+eZ8sdig1CH3nr8Ksz/YN4hePXdZFPl4+BZ cau33f2A5Awsqy+Byt7w42MTSh+rn8SpruaqdH8dqeg0Z1bvHr56jOZ2XXDapFMK5uiyYT69J+Y CM9AYvxYbS3hTdcDC31zV7ouLSQ3/rXfxHgWwpJVDxTDph/5vRzQd0rUgLtcXeNjtS+eGTRUdIU rVEh/7O3

Commit c59def9f222d ("Slab allocators: Drop support for destructors")
removed support for destructors, based on the belief that the feature had
few users and its usefulness was questionable.

Mateusz Guzik suggests [1] that using a constructor-destructor pair
can be beneficial when object initialization and de-initialization
require global serialization. For example, mm_struct allocates per-CPU
variables that rely on a global lock for serialization.

With the constructor-destructor pair, the serialization occurs only when
a slab is allocated or freed, rather than each time an individual object
is allocated or freed.

Introduce the destructor feature. A user can enable it by specifying
the 'dtor' field in kmem_cache_args. When a cache uses a destructor,
cache merging is disabled and the destructor is called before freeing a slab.
In case of SLAB_TYPESAFE_BY_RCU, it's invoked after RCU grace period.
Unlike the constructor, the destructor does not fail and it mustn't.

init_on_alloc, init_on_free, placing free pointer within the object,
slab merging, __GFP_ZERO, object poisoning do not work for caches with
destructor, for the same reason as constructor.

Meanwhile, refactor __kmem_cache_alias() to remove the check for the the
mergeability of the cache. Instead, these checks are performed before
calling __kmem_cache_alias().

[1] https://lore.kernel.org/linux-mm/CAGudoHFc+Km-3usiy4Wdm1JkM+YjCgD9A8dDKQ06pZP070f1ig@mail.gmail.com

Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/slab.h | 10 ++++++++++
 mm/slab.h            |  9 +++++----
 mm/slab_common.c     | 41 +++++++++++++++++++++++++++--------------
 mm/slub.c            | 29 ++++++++++++++++++++++++-----
 4 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 1ef6d5384f0b..12a8a6b07050 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -336,6 +336,16 @@ struct kmem_cache_args {
 	 * %NULL means no constructor.
 	 */
 	int (*ctor)(void *);
+	/**
+	 * @dtor: A destructor for the objects.
+	 *
+	 * The destructor is invoked for each object when a slab page is freed.
+	 * In case of &SLAB_TYPESAFE_BY_RCU caches, dtor is called after RCU
+	 * grace period.
+	 *
+	 * %NULL means no destructor.
+	 */
+	void (*dtor)(void *);
 };
 
 struct kmem_cache *__kmem_cache_create_args(const char *name,
diff --git a/mm/slab.h b/mm/slab.h
index 30603907d936..cffe960f2611 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -279,6 +279,7 @@ struct kmem_cache {
 	gfp_t allocflags;		/* gfp flags to use on each alloc */
 	int refcount;			/* Refcount for slab cache destroy */
 	int (*ctor)(void *object);	/* Object constructor */
+	void (*dtor)(void *object);	/* Object destructor */
 	unsigned int inuse;		/* Offset to metadata */
 	unsigned int align;		/* Alignment */
 	unsigned int red_left_pad;	/* Left redzone padding size */
@@ -438,10 +439,10 @@ extern void create_boot_cache(struct kmem_cache *, const char *name,
 
 int slab_unmergeable(struct kmem_cache *s);
 struct kmem_cache *find_mergeable(unsigned size, unsigned align,
-		slab_flags_t flags, const char *name, int (*ctor)(void *));
+		slab_flags_t flags, const char *name);
 struct kmem_cache *
 __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
-		   slab_flags_t flags, int (*ctor)(void *));
+		   slab_flags_t flags);
 
 slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name);
 
@@ -638,7 +639,7 @@ static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
 {
 	if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
 				&init_on_alloc)) {
-		if (c->ctor)
+		if (c->ctor || c->dtor)
 			return false;
 		if (c->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON))
 			return flags & __GFP_ZERO;
@@ -651,7 +652,7 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
 {
 	if (static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
 				&init_on_free))
-		return !(c->ctor ||
+		return !(c->ctor || c->dtor ||
 			 (c->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)));
 	return false;
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 59938e44a8c2..f2f1f7bb7170 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -155,7 +155,7 @@ int slab_unmergeable(struct kmem_cache *s)
 	if (slab_nomerge || (s->flags & SLAB_NEVER_MERGE))
 		return 1;
 
-	if (s->ctor)
+	if (s->ctor || s->dtor)
 		return 1;
 
 #ifdef CONFIG_HARDENED_USERCOPY
@@ -172,22 +172,36 @@ int slab_unmergeable(struct kmem_cache *s)
 	return 0;
 }
 
-struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
-		slab_flags_t flags, const char *name, int (*ctor)(void *))
+/**
+ * Can this cache that's going to be created merged with others?
+ * We can't use struct kmem_cache here because it is not created yet.
+ */
+static bool is_mergeable(const char *name, slab_flags_t flags,
+			 struct kmem_cache_args *args)
 {
-	struct kmem_cache *s;
-
 	if (slab_nomerge)
-		return NULL;
-
-	if (ctor)
-		return NULL;
+		return false;
 
 	flags = kmem_cache_flags(flags, name);
-
 	if (flags & SLAB_NEVER_MERGE)
-		return NULL;
+		return false;
 
+	if (args->ctor || args->dtor)
+		return false;
+
+#ifdef CONFIG_HARDENED_USERCOPY
+	if (args->usersize)
+		return false;
+#endif
+	return true;
+}
+
+struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
+		slab_flags_t flags, const char *name)
+{
+	struct kmem_cache *s;
+
+	flags = kmem_cache_flags(flags, name);
 	size = ALIGN(size, sizeof(void *));
 	align = calculate_alignment(flags, align, size);
 	size = ALIGN(size, align);
@@ -321,9 +335,8 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		    object_size - args->usersize < args->useroffset))
 		args->usersize = args->useroffset = 0;
 
-	if (!args->usersize)
-		s = __kmem_cache_alias(name, object_size, args->align, flags,
-				       args->ctor);
+	if (is_mergeable(name, flags, args))
+		s = __kmem_cache_alias(name, object_size, args->align, flags);
 	if (s)
 		goto out_unlock;
 
diff --git a/mm/slub.c b/mm/slub.c
index 10b9c87792b7..b7e158da7ed3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2626,6 +2626,15 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	struct folio *folio = slab_folio(slab);
 	int order = folio_order(folio);
 	int pages = 1 << order;
+	void *p;
+
+	if (unlikely(s->dtor)) {
+		p = slab->freelist;
+		while (p != NULL) {
+			s->dtor(p);
+			p = get_freepointer(s, p);
+		}
+	}
 
 	__slab_clear_pfmemalloc(slab);
 	folio->mapping = NULL;
@@ -2717,7 +2726,7 @@ static struct slab *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);
 
-	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
+	WARN_ON_ONCE((s->ctor || s->dtor) && (flags & __GFP_ZERO));
 
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
@@ -5735,7 +5744,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	 * then we should never poison the object itself.
 	 */
 	if ((flags & SLAB_POISON) && !(flags & SLAB_TYPESAFE_BY_RCU) &&
-			!s->ctor)
+			!s->ctor && !s->dtor)
 		s->flags |= __OBJECT_POISON;
 	else
 		s->flags &= ~__OBJECT_POISON;
@@ -5757,7 +5766,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	s->inuse = size;
 
 	if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset) ||
-	    (flags & SLAB_POISON) || s->ctor ||
+	    (flags & SLAB_POISON) || s->ctor || s->dtor ||
 	    ((flags & SLAB_RED_ZONE) &&
 	     (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {
 		/*
@@ -6405,11 +6414,11 @@ void __init kmem_cache_init_late(void)
 
 struct kmem_cache *
 __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
-		   slab_flags_t flags, int (*ctor)(void *))
+		   slab_flags_t flags)
 {
 	struct kmem_cache *s;
 
-	s = find_mergeable(size, align, flags, name, ctor);
+	s = find_mergeable(size, align, flags, name);
 	if (s) {
 		if (sysfs_slab_alias(s, name))
 			pr_err("SLUB: Unable to add cache alias %s to sysfs\n",
@@ -6443,6 +6452,7 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 #endif
 	s->align = args->align;
 	s->ctor = args->ctor;
+	s->dtor = args->dtor;
 #ifdef CONFIG_HARDENED_USERCOPY
 	s->useroffset = args->useroffset;
 	s->usersize = args->usersize;
@@ -7003,6 +7013,14 @@ static ssize_t ctor_show(struct kmem_cache *s, char *buf)
 }
 SLAB_ATTR_RO(ctor);
 
+static ssize_t dtor_show(struct kmem_cache *s, char *buf)
+{
+	if (!s->dtor)
+		return 0;
+	return sysfs_emit(buf, "%pS\n", s->dtor);
+}
+SLAB_ATTR_RO(dtor);
+
 static ssize_t aliases_show(struct kmem_cache *s, char *buf)
 {
 	return sysfs_emit(buf, "%d\n", s->refcount < 0 ? 0 : s->refcount - 1);
@@ -7356,6 +7374,7 @@ static struct attribute *slab_attrs[] = {
 	&partial_attr.attr,
 	&cpu_slabs_attr.attr,
 	&ctor_attr.attr,
+	&dtor_attr.attr,
 	&aliases_attr.attr,
 	&align_attr.attr,
 	&hwcache_align_attr.attr,
-- 
2.43.0


