Return-Path: <netdev+bounces-118793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B31952CD3
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C652AB258AA
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4B81BCA1F;
	Thu, 15 Aug 2024 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XK7QrsIw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IImA80Qv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470711BCA0D;
	Thu, 15 Aug 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717390; cv=fail; b=YT4yGmkqJQAavkCrgHMeDV9qmD/xXok+1nYJcN2M75GShDwLz1yTZ7vCobA7XbA5G3nDtEnHr3v4AGs0YoOsyf8+K2qQAJInCFQz2+q3KSfe+bkAoNVnebvDh5/lSN8cizt0OfXI9J9w1YjJ9G+2ma6hx2g2DlmyFPkzkOlyKbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717390; c=relaxed/simple;
	bh=u4KLPbv7d7GLAUI810CoBFa+75vNgk9tLb8j67JbHhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=GoEJpqBSB9MPcoQZ9nzTR47tFisjF/EEVfwrEnZWtlM3f1xM6NBZRtTtQ3+1v6iqK8QkujqZz3FCbnMqtkuIXDkE3RIEefgMF25kBFc2K5WB0zQapB3gtEaGN7k5yNGyGYlx3Ehrxz/hf93JglkHuJdFSg5g1z9B/9mPWirsIto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XK7QrsIw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IImA80Qv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F7NxV5013659;
	Thu, 15 Aug 2024 10:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=v9xUdVpxiaPwTc
	Ofx5hA+MMyj/IKZHtcJLR626Pk2wI=; b=XK7QrsIw2cKraz5oFgs6Ox8kbtOyH0
	sTWv2OPLmGKjJTvl2JxlyvFiHDzItBLcO/eRLkXLAaFLNbn0urPyDtpBn+a0wNBS
	ow0s6FTHFtBLyHIoZ3Yw7Z2KqWMbkuBcrZcQHkvLi0uyEsXCNcFbwwlt2asqMhtN
	ubpxZI9n7tK2rBj0CldXF2Q+23CH5WEHqiLmEuHUmZtbz0FY5Tcy5anPKNjQPzHN
	UN6W32aEDLZOUaQlPiRhYhAfCaXp0geeCrSqg+Z5LFv+RdVLNwuB0eGaeUh7dMjJ
	qBUIP3N4lte5aWtzLOod79MZ/qaSsG1UeZUOHbOX3TFk1AFQuN7hoLnw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtt70c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 10:22:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47F9Vufm000746;
	Thu, 15 Aug 2024 10:22:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnavft7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 10:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZVdA9KYaZKR7xcGBGZLNfdVn7yAcVtADgO7S7e1M2tHv1X9yWm+US/db6mLGR8gCoZGW3IvDWvlPuFOqmqPdJPjBgjIBSi2dMfdtmRyQWDt0abAZj9MTKsJEirqmWrFerj8fon1cme+VL1Iw3WuofyOWzGnRWKJK74LI3+GCOWzbjsB56bauO7zmESYELlfBwdRsqB9oDDYHI1dNNwqrgCprxPl6ikt0dWViieIALDfM4XGHR1e24XhO2FWdXCBZiLvqNLHuWLqex7gWndNzgaXOXGnDXzOom7fFE8yjh5lJaDmSktqizRkOEHUKBky7yoS6B7Igjk7Zp1CM0ewxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9xUdVpxiaPwTcOfx5hA+MMyj/IKZHtcJLR626Pk2wI=;
 b=eaqxpaUo8vvGnSTtKs2KsobWEtiRd9RCCn/oXXPBomGNhyic0KxVnca+jvQHmZQFY4+Icy3yutw2i+Y9KTT3/NeIQJWuNWGsYIHAc9P8Bnk4S04XslqmDSGnaXp+5QF+sMnGbd6anjSd1/RVY7WrYWH21Z/oM/9RtCsKtIsIxBSV3CCSWg+gQ87ZngV8VKmdvBwiPvkUNv0TY7+wjVjcJ67iphKVFridmXYlLjpypYvvJ8IgwVZBuk50+KY511qVx0Ff9J1Qyf1ZxsAgAtf7Kd19xf3etc3+P2AT9ABTu2BvqqGdMEGtrHPSpb0Bgo9RQ+1BSLh0iKn5kOmUuvhRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9xUdVpxiaPwTcOfx5hA+MMyj/IKZHtcJLR626Pk2wI=;
 b=IImA80QvyabAJaDLAkgzo3sb/iPpdljzVv5wOJEe5JWbW2ohOSH5Bz7Kc093VGdDrRZs4IpyWK4U0ASRJ4TzFNmzerJ7i9ueTNes/0nxqZm+Udvanib/yeqm7nhZS2QgZS9QNdMuyFbJe3u1tfitPVeFPpsWAaVCRFFdYLNBXN4=
Received: from PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5)
 by CO1PR10MB4547.namprd10.prod.outlook.com (2603:10b6:303:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Thu, 15 Aug
 2024 10:22:12 +0000
Received: from PH8PR10MB6622.namprd10.prod.outlook.com
 ([fe80::510e:23a9:3022:5990]) by PH8PR10MB6622.namprd10.prod.outlook.com
 ([fe80::510e:23a9:3022:5990%6]) with mapi id 15.20.7875.015; Thu, 15 Aug 2024
 10:22:12 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang
 <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Linux kernel regressions list
 <regressions@lists.linux.dev>
Subject: Re: [PATCH RFC 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
In-Reply-To: <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>
Date: Thu, 15 Aug 2024 11:22:09 +0100
Message-ID: <m2r0aqrsq6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::12) To PH8PR10MB6622.namprd10.prod.outlook.com
 (2603:10b6:510:222::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6622:EE_|CO1PR10MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ad98e3-fcb7-4184-c87f-08dcbd1420a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PQ0eWnq95fDLTq8ayzBZ4NVt8cROwsk6kBAON50l8W90/h/qCEuJaqb3BUPN?=
 =?us-ascii?Q?p4lBNvGNVwQTFrD+UHEtRmad02w63QoIM7lvLwNjIFv8XFEM2iJSHczuBRSk?=
 =?us-ascii?Q?MdR9/2HwDpmlGcT+SzjV3uTaZ3qRRsXW2GwbkyEFHtT9Cv731c15BuqXwvMe?=
 =?us-ascii?Q?rH21ikOyY4awZDh6W+cG0GjjpU2PfLaQ4bazJXq/AJKfFt+wpx7nXya8WZnw?=
 =?us-ascii?Q?ne3R+bxs2juM1ORcQleEgXpWTPGTOeGyRvDGIt2TUgayuBStAD3QF0zSO50z?=
 =?us-ascii?Q?xa1QGTxDfs+bkYDpbCdTW+lVUTuWhT5lNIlqYfPYlv/K0NAPfENPUORfyjIx?=
 =?us-ascii?Q?uwysYboNbnduJfGBEHSfftgsMlIXYOLm6yllnmhT5Uz0JyeOTbpo0NrJVYku?=
 =?us-ascii?Q?e/S4TNyDAWiuflQPbAtJdzZmF/5HpFWVQlT4s5tJAH/SEfu5hIh+JX7dOgZB?=
 =?us-ascii?Q?z4xjAcwt6zd3S2xnrTWsPiF0H0uj2eydasftSWLet4DQRgctnt5IoTozWlYM?=
 =?us-ascii?Q?773IZJJcD6lurfQJwrw+TLej0gXQDVGC40xjroy5YGUzkqu9ZIeUXIMf13Wy?=
 =?us-ascii?Q?opGvmKq4XzTe+WUNI3HgSaVQbeViaUIXbeOB7Kil70b+j2yqRcNQTm83Yqym?=
 =?us-ascii?Q?PA3sQUVHpAFT/TPz/Eg5aUwGeFho9J7wZ61nwg3Mh/7lMRdw09vMWyWX0uSO?=
 =?us-ascii?Q?NQKlbld1XJePFIpPx7I9VGSIMHi9C79zjlZCiLXXnn7mjrlWmA9poxWs1Cd9?=
 =?us-ascii?Q?sM+np2RWYckFy8oZU6GUuxsDXoy1RP1UlUjVHDFplZE8aesXed6gosyvPe1s?=
 =?us-ascii?Q?X+spc38D88el8tyIBLGRTDY3MwZsW24TH8WSHXsgbP27XHz5Nxn1D0w+Rwyg?=
 =?us-ascii?Q?TR+7X2MtOL+R2rUY4nc8aiffvM81V2frahibYgRXyHz3xlEJfVrnytagF7ub?=
 =?us-ascii?Q?CZEGgKpAHOZvYGG+PRG2xTGnAwXVBS2f8cEuIjcemZSshKnW+2kIcQCpWjy8?=
 =?us-ascii?Q?7B4ZFqvKR56l+kFYmMqZcOyKcT3BBVzXgA9sB/SNACHOk4VOZkp5D/6NMESv?=
 =?us-ascii?Q?aJKRfa8DbaoFvOYRDWd/zQgOhOLASY5/jIsKScZRywCbAgADbDPnY5uXLbjD?=
 =?us-ascii?Q?dPXIB1KjlyXBkd6ipJJAxh091OtAsvIgUmoKzGmlReMOWuxYCvaNV8j775fw?=
 =?us-ascii?Q?nYYKJteOKEQYakdLfREtDTtSjfj949Y2pzq6fmH/6cWjPEllKYogG8RfWwSo?=
 =?us-ascii?Q?XvCOSWaPCZsYu37D65GuIF2ApKP6OSWyIhGTidT74BTq07ccGH9IClNfEGCQ?=
 =?us-ascii?Q?HIdSVqbYOSPw6YznBnW+VmuY31n4HOnFBQjJQJ6o09VUt6Dn2ppMU0vkTcXs?=
 =?us-ascii?Q?thgIHYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XgaktNNxrPAvmm5tYhBIV1zK5EdPkM1HfhQiyHKu957ISdJO5mvFfKE3PveD?=
 =?us-ascii?Q?DexpThKp0JCTsvciaXihNor5BT2aOMOlAtma321GlVTZcfGc0BFm97RzD/h8?=
 =?us-ascii?Q?TLWCOe2+c7P6I6n3N54m6BeqHB7xNwuLzTkovPPbB4cLnDAWkV1L7vvG7ujv?=
 =?us-ascii?Q?anc52FLO4l4Tdi7B72OLz/Ohqm7elru0+2meowncKmuBDckwxldIrsxwQoF2?=
 =?us-ascii?Q?mW8ITho5aMBFp9SzwIH2taLIBGTt4cr2eEsCw3g20jIrLLxb1J34tUbRLZ5n?=
 =?us-ascii?Q?pbEO2qOabGCMoD8LP4+Ajx97B98hh/Cg35wqNoJS4LZaE/1MuQsvRXKZC19w?=
 =?us-ascii?Q?idjruRGyqWntw9Z9icUF3QPdj15G40ClLJAihd8lnQQiyOU3p8yybKYZcxPr?=
 =?us-ascii?Q?Zfxfep+YdFZzXLE6+6pt4KtPCSCmKKLreW1c7I/gxS1e8/Oy5f4lb37mDGvF?=
 =?us-ascii?Q?pTzjX9Iz2NGiCplXGmVdZ/44noIHPE7G+Q778sIrQ7eGI9myTb28Y3Osy2k4?=
 =?us-ascii?Q?MOa/UuCnaSqADQWkiClr0xjzRMpb6Qh+tugdAxqMAkStERBcXqUVoyfCBiij?=
 =?us-ascii?Q?xB47J5CZcA3OHNo0uqJESJX3974kSB2pJnIfX9KErv2U3PRPW9lo6Fg0tXSw?=
 =?us-ascii?Q?3WyF9X3nuWUY9vWir7DNTPrVb0ftJ90YkdkeB+S88jHlPwm/cU1jtapbx8iy?=
 =?us-ascii?Q?IGIAtRW/rGscmX68c3EY4VgSTPdizY07nxiFGQcJKb0hX/fyVX2LbBP/WcHb?=
 =?us-ascii?Q?m19shc2uDg+ezsH/y6i98CaPa0lG2VNAtxYQpHXW9BWGWdhKjwkILf9b9q7L?=
 =?us-ascii?Q?qDV1lgb9E14VeLpDe+6+IJnPZZFhWie6eix3ycO+w6aird3DrArRwJ1UCn3T?=
 =?us-ascii?Q?ZLyozbe3yc0O0fzKsCsZEgGuNCVOWhTDVb+S0ix4FAEh/BYQvDeCsJjingLz?=
 =?us-ascii?Q?56EIt7n9cqhe7ouOJQkbhEXViHY0O154YBlpPjPyp2iBykUsAMmrvpQOMAOu?=
 =?us-ascii?Q?MUciA48L+7rVY5+gRfUAAzkobGV49+zlpPB2wkP0hIMeh4fsOisJSG5Bj4uf?=
 =?us-ascii?Q?Unr+wXbqvCLeIm+qDErYlOasW69uba6Hyr9+yW3R8AqYdlw/mdgG71jrX1aM?=
 =?us-ascii?Q?lHwmSwOA/DJoIYPjzsacL1PDf8cGntgu2Cr4S+WS7jrJ0KM4Y2dOzBLJud5i?=
 =?us-ascii?Q?DiLQtslnoD8Scsd4e3pvdMMRm7RDs3aEVoMbB83SfI4a8qR5fbr5AOF1h6uv?=
 =?us-ascii?Q?9rG2JyaQAwZdJYBQvhnuYP7e+jwG8Jc7qZfEA8ao9BVEXQTpd+gsPHvUr9Xh?=
 =?us-ascii?Q?iB8bjlPEJyBZpKvpVfoSPspbgv+OZhAnGSHRLI4vo/QdCid9659q/jX9N0Lj?=
 =?us-ascii?Q?u6PlbGi73+o9tCq17T/wssL/lU371lmAUSOzME0uhqqY+j+peWV/mW7JLhP+?=
 =?us-ascii?Q?yIcqEImMKNkUeUowoCbCy3ja74+oescjdz/Y+bLUhYVNXaMCn/obe9Q7wvDr?=
 =?us-ascii?Q?H26WKihiHK2kfrbWszZmdUbTix0rlUqPKZWbtVWHW3/cmWF/IvBDomsDjSdj?=
 =?us-ascii?Q?g+Ct+QIAHhybdVKDDsvZBmFUfFWeFqCHZjqesZ5DOTIlabRAdvqo1eiSF5Ek?=
 =?us-ascii?Q?cTrvAQG1EsxGm4PtrLSqbajkUWZonsX0bpIx4Ju1tU82rtrr+wSoy/oUilVN?=
 =?us-ascii?Q?wpWQJg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4AHlO7FUe+nZ/ovIREyzw4klCAL5E5UMWVZnag+ASQFtqBAmnLT1JTkuxuFzm6Zd1PxchoXGVw+7WL2gAbStJ12VKIUdcJnc7s1PKQM88bs0BT1Dn+AlZd8xRLSusm475TI6x23jjyrJXUQp737m8DIcR2WGuf74D9DC6kDtE6CBd5a5ZqMp60n1MRRCsMmUx2wt645Nb115QO3KI52Onruj1egv/4vTcH+TISpVIIfFTJYT6BgjtQZdfZm+kwdCdWRU22ev/XzrVdpR7V8aaHRhZDLKOFWJbIagHlEmNAOb2xrDXRwTXYP+k86gBMG9EkQFBBCAmDyN4JNExJdwnFT2GGb3FR2aBriXmn8lZinETqBiHbsx6q31a8THyhC1rrMXPHnVsyQG8whqa317icFH1SaSu5tK4dQDmnHe9jtr5EwjVd+UxpnUA7yGLJp9otj0guyb5SPEOtFpeFK9PgDxn6XiGsIjexeCH6Bl/OlIbBxPoIzFV/dYB5UadC8tIV9O+4SJnU0cFfR4eUVNqmAUVxGk9+X5kQzTiD6+YObfzVKhCFQMFVc89x+LM6YgPCFVBB32aDgVu1sdzcdkXZRuzFx00vPJ3aWEHy1M1hk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ad98e3-fcb7-4184-c87f-08dcbd1420a6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 10:22:12.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Bg+pHefb0G2rfohKRoB9K5aTLcm0765aCduijSIeszdvIO0CUoF0uoLZOLm1KdeuhxRagSfXT9TfWYQSeggfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_02,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408150074
X-Proofpoint-ORIG-GUID: AT6Yt0sejWlA5P0xXzhbPCrBXrqK47GZ
X-Proofpoint-GUID: AT6Yt0sejWlA5P0xXzhbPCrBXrqK47GZ


On Thursday, 2024-08-15 at 09:14:27 +02, Linux regression tracking (Thorsten Leemhuis) wrote:
> [side note: the message I have been replying to at least when downloaded
> from lore has two message-ids, one of them identical two a older
> message, which is why this looks odd in the lore archives:
> https://lore.kernel.org/all/20240511031404.30903-1-xuanzhuo@linux.alibaba.com/]
>

Yes, I saw that too, hence I responded to patch 1 in the series, rather
than the cover letter.

> On 14.08.24 08:59, Michael S. Tsirkin wrote:
>> Note: Xuan Zhuo, if you have a better idea, pls post an alternative
>> patch.
>> 
>> Note2: untested, posting for Darren to help with testing.
>> 
>> Turns out unconditionally enabling premapped 
>> virtio-net leads to a regression on VM with no ACCESS_PLATFORM, and with
>> sysctl net.core.high_order_alloc_disable=1
>> 
>> where crashes and scp failures were reported (scp a file 100M in size to VM):
>> [...]
>
> TWIMC, there is a regression report on lore and I wonder if this might
> be related or the same problem, as it also mentioned a "get_swap_device:
> Bad swap file entry" error:
> https://bugzilla.kernel.org/show_bug.cgi?id=219154
>

I took a look at the stack traces, they don't look similar to what I was
seeing, but I wasn't running with an ASAN enabled in the kernel.

Most of the traces that I was seeing would look like as in the e-mail
from Si-Wei:

  https://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com/

We could trigger it only when the sysctl value was set like:

- net.core.high_order_alloc_disable=1

And it would immediately panic on any relatively large download, e.g.
wget of a few RPMS, or similar.

Best I can suggest would be to try reverting them in a custom kernel
and see if it fixes this problem too.

Thanks,

Darren.

> To quote:
>
> """
> Hello,
>
> I've encountered repeated crashes or freezes when a KVM VM receives
> large amounts of data over the network while the system is under memory
> load and performing I/O operations. The crashes sometimes occur in the
> filesystem code (ext4 and btrfs, at least), but they also happen in
> other locations.
>
> This issue occurs on my custom builds using kernel versions v6.10 to
> v6.11-rc2, with virtio network and disk drivers, and either Ubuntu 22.04
> or Debian 12 user space.
>
> The same kernel build did not crash on an Azure VM, which does not use
> the virtio network driver. Since this issue only appears when receiving
> data, I suspect there could be an issue related to the virtio interface
> or receive buffer handling.
>
> This issue did not occur on the Debian backport kernel 6.9.7-1~bpo12+1
> amd64.
>
> Steps to Reproduce:
> 1. Setup a small VM on a KVM host.
>    I tested this on an x86_64 KVM VM with 1 CPU, 512 MB RAM, 2 GB SWAP
> (the smallest configuration from Vultr), using a Debian 12 user space,
> virtio disk, and virtio net.
> 2. Induce high memory and I/O load. Run the following command:
>    stress --vm 2 --hdd 1
>    (Adjust --vm to to occupy all the RAM)
>    This slows down the system but does not cause a crash.
> 3. Send large data to the VM.
>    I used `iperf3 -s` on the VM and sent data using `iperf3 -c` from
> another host. The system crashes within a few seconds to a few minutes.
> (The reverse direction `iperf3 -c -R` did not cause a crash.)
>
>
> The OOPS messages are mostly general protection faults, but sometimes I
> see "Bad pagetable" or other errors, such as:
> Oops: general protection fault, probably for non-canonical address
> 0x2f9b7fa5e2bde696: 0000 [#1] PREEMPT SMP PTI
> Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> Oops: Bad pagetable: 000d [#1] PREEMPT SMP PTI
>
> In some cases, dmesg contains something like:
> UBSAN: shift-out-of-bounds in lib/xarray.c:158:34
>
> When the system freezes without crash, I sometimes found BUGON messages
> in some cases, such as:
> get_swap_device: Bad swap file entry 3403b0f5b2584992
> BUG: Bad page map in process stress  pte:c42f93fac0299e1d pmd:0d9b2047
> BUG: Bad rss-counter-state mm:000000004df3dd9a type:MM_ANONPAGES val:2
> BUG: Bad rss-counter-state mm:000000004df3dd9a type:MM_SWAPENTS val:-1
>
> Thanks.
> """
>
> Ciao, Thorsten

