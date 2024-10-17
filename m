Return-Path: <netdev+bounces-136427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6019A1B4A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A781C21A55
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A681C2317;
	Thu, 17 Oct 2024 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="HLgHEIFa"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91BB157E9F
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148715; cv=fail; b=sDa/iKnPDqVjjt43gRDWl9lzUq/FB7oqbReXpyQyiIABYYJLd8yuajkAAyZxi18pcwqQ3jiCzgZYFii7aFmnpXTo9C1cPf36oCRPw8GlE/ufgB4x++bM0wvO62nbO5RTkcpSkH3wcKSvi9wOvYXRnuUYoNBmDXN35IfuSMlQdGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148715; c=relaxed/simple;
	bh=T+HLM7kYBiNhj32OMoMaS2Ud/Ymy2vZaxhbfZbD09JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tE1KU8MXHR8XSuDy4aUZinE2E3Gn612n/qsx3G7iAZD/m2N4k91Hd4mIYqjTaml5vySR5JfjSzCVtSqrNJ7yX7utQvbx5bQd+us/PM1p/VW4cDgu3ezdTbXwqAEjTVXk3Hemww1vUDd0wYgtobyNtDR1sSKCBasf2Jg/Duz3hrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=HLgHEIFa; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 93314242080
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:05:06 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2E00DB0006F;
	Thu, 17 Oct 2024 07:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOrqhFNSErBRwMiFuKlVIz6dohnk4MZK7k9tSFMsnO7/cO2jjcPGVHzYHtbL3SsakjbjrTMkq7step2iQQYtACSFq5pA3jmUvqC0Doa6WGIQ7wP/2ONZIK6VJMRp3XCyLPCLoAPnRTsa3TtVrOUb0mKyPk2awAJS3GxM5SikBMcMbnT+U/mlgJfi2dGkvZpz2vZp4zKinSwaioM8p69W7V5CgLTm6Q+Qdzs1uGxR4J5ugo5yvfkd24qFz/s74o4MB+Y5IhBrSaShIpOJTC/6KvvyAL5EDuJY8TNIZj/BpcQqRLKlDzp7ciH2YgBP4Cj2jz+E0shblCoQgV/epYDh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIfnBpyQ3DQM/afkECK6Vaqlj2HbGYLTwLExlShUpBg=;
 b=RXm5CNt70mRGulFt0Abm4LU43W5Phow9XMfhTRleCNlmWbovl1lrO20x1koibHAa1A2o2hQaJg66VMXU1OXpFHIdnVw5nOHgTx+vf/3xv0PX3YpMYXAGH6Cj5G8fLfoQXkKy86V8jlibScZt6aNn/X92MmnaEBJNonxa9a8MFVyS3c+TkgK5WEsVGAqHjYcJH0mQp8ewe4F59k18pZr2K19u/W8bkaauDkk4mEFdXFStQszMq2WP8DJHxf0VLkEA5LUZbDibclOlcFcsVaqV0gZZjX1SSfm5L1R2t0110V9ldrr/nZarIRAUH/tnf2uYQH5P6+usVNqP9oC7IWTsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIfnBpyQ3DQM/afkECK6Vaqlj2HbGYLTwLExlShUpBg=;
 b=HLgHEIFanc9syI7ykKufrpvBbmAF+ySyP5uR2pwRVbudse7S4iORf+7cljBHxeBQcWhuWc2AAyM8p23n3VNUR4mO35QNQ2FJqCDNjRwkY/n/iNEFd3q8Q3fq1v0JcGP6MB3ihes4CeUVQN4LDa4pldhYa7Fo23/Jxqoyu0uA9ZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM0PR08MB5363.eurprd08.prod.outlook.com (2603:10a6:208:188::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 07:04:57 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 07:04:57 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next v5 1/6] Add hlist_node to struct neighbour
Date: Thu, 17 Oct 2024 07:04:36 +0000
Message-ID: <20241017070445.4013745-2-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017070445.4013745-1-gnaaman@drivenets.com>
References: <20241017070445.4013745-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::29) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM0PR08MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0a28b4-9292-47a1-7269-08dcee7a0219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LlQ0Is9vVTEmtaDvf91GGcoQL5qgFk5fa+ZC+mWWrf2slivJKZ3KeHTf5Pv+?=
 =?us-ascii?Q?2A21mVH5tHSVRBSdlo3KWRlDLYqhwLDhVRyUmtGE3SLyZkMBR2GxFq+aHjem?=
 =?us-ascii?Q?d1lMMvviULc9nXsxTTHbCfSyaXcYkEf9cTs7jEbibG7sk0Iy2ezGl3QHhEBO?=
 =?us-ascii?Q?iYDiuuB2gzwpeNNtWiTxISahUgCfHN1mqKZjm+/I861cVCUB3PeaJ8yu8WQW?=
 =?us-ascii?Q?0r+QkI4xwoS7RTMrQW0qnbL04qS+s9KXFuZZag6MXdL+j9dtKeek/dMudPLy?=
 =?us-ascii?Q?G7tKQ09eLATmr5fk5PXU6AD4YDzDz1VBhy6evzhaJl1xMnBTHpw6PJ5iC9N2?=
 =?us-ascii?Q?OjdImTSeBq5pf50CskBRpb0bQk6S4MyMTWHF+VbnunoycK1e5olq6nCRnK93?=
 =?us-ascii?Q?2ujcQD8rDvMeO7fseHvC5tF3EUiaz1L8emd9eE403+IronPohgKg24/nHfnc?=
 =?us-ascii?Q?lEfgiT/WofZ5A71yeKcngePcLfXnFeiWvTOsrjBhVp2YTwtXy4p+iyfodEMA?=
 =?us-ascii?Q?EqpGzsjcIhlfiGNX4AzzBlKa3dU7vvrtWak9w3b0YIteJIbsmUNNvBFCiSTg?=
 =?us-ascii?Q?N1GDK1OHu497C2xvQYru0/1NCYJ5gQ7HPOp6YSeIgYXZNENGmT6GySOdV0FV?=
 =?us-ascii?Q?q+fRlpE0j8iszaCjsjlaB931n2BQe5V7xgfh8UMozh8ShmwMDKyg79v42ntP?=
 =?us-ascii?Q?HFXsRfkZGTV4TqTvFqVvGrsMpzb0jsO3J8lp0iChK+y+xEY06NFw77NTljDu?=
 =?us-ascii?Q?96O0oCjn6LAIRLWo2Jsc2m7o3Gerz3iSDExxYL0zGqhv9hcPG63Qpg1mpOdF?=
 =?us-ascii?Q?RhUQUfT5PsrK4u2RSlamDA9Gu+0eW91K5Df3wP23S4wRp1+VoGIyf7W17d6x?=
 =?us-ascii?Q?9FIxQMBdt0jiQqDakwvFL9epTjFETELDZF0ASmw8oXzIQZ27d2SM5GAYKkAS?=
 =?us-ascii?Q?HwbcDF+y80KIQfC64c2oYf7DLwG3STEIZZJoIq5W0B433GUHv7qaYOcDAGmP?=
 =?us-ascii?Q?iU53TuICLjesckWgvGCcHEQLuYKYEJGA3YLSaTKyXBy0nLRUCY9z1ChUwMu6?=
 =?us-ascii?Q?en5pbvJJivdY2i4b196oaMHKcEdLE4cl5j+m3JfyfIpecjp3hyjtOHJs5ThI?=
 =?us-ascii?Q?23cHX6g1kF8mJc20qUsEOzQseMEE2JYQAjht5QM2pBkEX49LdWB/1qQ695PS?=
 =?us-ascii?Q?Z715lw7jBHXqcBbmIw7BEHkeDau4jl51DyfhWXEtEQWIsFo23DydzYt/Q7sL?=
 =?us-ascii?Q?dfqNOPOyYh31jxALcjPR+34zczAXEByLvO2kKGQ+iTQ6nMlWWoNZyYhN9ZnG?=
 =?us-ascii?Q?50zB5tSj5SGFLTGVpZwL3ZHAlbNKm/PavXvPpdzwXc35v4bZiGhGXEwSy3kh?=
 =?us-ascii?Q?UnIVRY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ICBSjPChfNMNqAIkFBRy3HSAfCr1Oik0te7dm77TYC9XIH+4p0avyppa9h2i?=
 =?us-ascii?Q?W0kdRApXBPfkX0teJLQPq+Am8IxKktawlJMWaW9bnL1PCPnc7tVHk4a1k3S/?=
 =?us-ascii?Q?h/I2aJaGfx8wP0hz8lNxKEAuRixvKKNyGgDCfNpzJF7YB/QvtJGWsQqTgxI4?=
 =?us-ascii?Q?yPop6XNbBuUUh6X6NJ4fCX94pSEEWou+9ceXS6lZIrslMqyWp8pTAb8rx22A?=
 =?us-ascii?Q?zuqsdV6rwcyH2VQrLccm3IJJlvWGieFhSAKViP+PE6UpnOpENFgXBLVQG5i/?=
 =?us-ascii?Q?CgoB37RcXd7QkO8e7pNlHM5Nl4OYz+Ycwko/zZJKN22RIJ/kdz9JK4WBR73S?=
 =?us-ascii?Q?c0g+HhRC4IV00NNIqUDfz/HslNfstSSgOXXmSm70j7nXloGIEqyJ0s+liLG2?=
 =?us-ascii?Q?+f2ltvMlVkw/aZxn+kFzAjGVWk0RMN6pV0j3KvGoWFXSbGXWoS2Axksc/15/?=
 =?us-ascii?Q?Xp4om3K3zJOz2rh49Ka4ciMI2mpfDKz6CRl/d48SLl1knTV64gOhJL0WeXUm?=
 =?us-ascii?Q?Artp1CFw6sJIRmQZkGAsCppnNsS5VL+Cz49dnzSGldr++cnx1qCFdmiZ/gul?=
 =?us-ascii?Q?vmabCkFe0LmeDiLBnqNr9TCNJiF1PrOP9xttNDoQGmWV37UkT9FCaBCWkfZk?=
 =?us-ascii?Q?KyOnURJKXsHy1emO+vA1yKk3jds/WtLxPDdtWzQOAwTaRBBzRO6po0ATOV9a?=
 =?us-ascii?Q?UcbNAvrhfIp+5SgLeFDk8rghRRAFQyfez5TdjJLy0EE2lbrk7UPxCMyhz922?=
 =?us-ascii?Q?WMTYZH+yLQyfPTp/nRORE92WRMKCi6hwjCgS7RWsts9rBeVTEvgN4Omnd2ri?=
 =?us-ascii?Q?hM8uJ3W6cCw4VyHyDYpas2E5WYL1vNrY8jwh4jgX3MrN2Jx4bA4EfVSSvHAt?=
 =?us-ascii?Q?7nY1hd3q5a2pFXVKP40LTWC00T6XQLc46VFvL7jij8ZVPNGs9QXEJzqjjD1q?=
 =?us-ascii?Q?aeJAK49YnRUncbnBjemA9cw8XCFqtUVQbGmRzyy/B07BhGW67EKxFKzmhdkM?=
 =?us-ascii?Q?ym7doOcApQHzCGnC3CNa9gpaX9Rm46288E55XB76QWNjrS0IBGSTSG51FQGY?=
 =?us-ascii?Q?vtgWe/+q/uLcDgBoZ320tWPxfTJquyte643wrn1HX8QE5BhrqNJeuH4JQH8C?=
 =?us-ascii?Q?zEkvr1rOnH3e5y0Zx2FParFwqS6GQ27+YZRjMb5ODCpZ502uQo9OI93cykTz?=
 =?us-ascii?Q?8eOVMQAQ+/5WmBpu1+sOJTBAA6WxbDIXUz+sGdIrFy70M45SJkURuC+Tg/HD?=
 =?us-ascii?Q?Borf0F+6+glHNN046k0RYMXqHs2xiP3kj33yMpIrs73EXKrjoblLsj9LQamO?=
 =?us-ascii?Q?/T6CyFE/UTBI41Cr5/k3J8s3Of9EJM2OCyh0YjMkHfllVSkfoZKY5UbAMDoI?=
 =?us-ascii?Q?TnKncV535kaYuTN4E4IL37h+Wi/DaMKgUPYzErD3e0Vh/unJFBjmlOyWDSGz?=
 =?us-ascii?Q?q7IGLC2FmptcLULEU8vAknUzZx/xGbAAsEQwK7JL1WGvUfvtZm1AoBZn+l12?=
 =?us-ascii?Q?QBnvRP9Us3tHI6cUu8Z+/vwtXBMjdUAd+FXLtQxtUH+ojLRMJUygcyzdB9Q5?=
 =?us-ascii?Q?j/sc6uNJncJFmzQk06iMOLE5QO80m4ZtHEaaB2ZU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nP8IA9iDcilEsY++31IOPpnZ8R4N7onG9gw/FEFy190/b+AlLf6rojjlTo+VYK7MXvAv61QB4ApMK4CSTZZO4oaOIFp3ywdEYMjRE/go8eFViJZjK4Zc7th4HLO7ZviUR576P+qNwvZrMpH8zwwGic8CMUL1tAH7CGlb7Ayg9nwgEfS9ZfPjJCl3DGniQniFnLhYcrjgO+reH8dAmxhqMBPUqRnqItUcL8+nALuX3mFZj1H0qf/OzROif6bdOg1J0W2StVzUyaK4kpnAhU5qxg2x+Af8e6bN+aRWvuTzt28oXNPERsvQSi0fORLkVCsc7TEHy+UnW0d1sG48cd50GP0PfnbhwAlyVLxYciagTlZjFcyZVrcGPsnBfvzOiylWUDoN6tr4HQKyPXFz7j5gKvp1qQajXizE10qQqzJ6i7k65ZKPhqQA2L7tbq7mSOPW0ItEKdbz/n3u3kCl0VMVmfbCuuwz6lvmD/BYRg+M943fm2AZZL5yMBtXFQR5okpwrsCjLgzlxkB5efvcJNw6j++2zkdZFWSbPSUNQK6L+/mVzwUNHwPq7Dp5Six+Tw0jdwJ1nBSEEAoRs4OCBDRN4MZvYAuS1GDUao+1tGuQMzFJUNtUgonPs3rQkI4fc4yc
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0a28b4-9292-47a1-7269-08dcee7a0219
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:04:56.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcPBex0AQzWMd20jXLe3/rzb5ghQNpZsgOPbzUc8MsDJRMyvLpOQ2SyKgYorEfkSrkLc2ZPCfTeG+q9Zne4aJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5363
X-MDID: 1729148698-J8U93uoXb2em
X-MDID-O:
 eu1;fra;1729148698;J8U93uoXb2em;<gnaaman@drivenets.com>;3e2ef0aab6a0ad8a3f1c1b41b7049f4c
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a doubly-linked node to neighbours, so that they
can be deleted without iterating the entire bucket they're in.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  2 ++
 net/core/neighbour.c    | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 3887ed9e5026..0402447854c7 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -136,6 +136,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct neighbour __rcu	*next;
+	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -191,6 +192,7 @@ struct pneigh_entry {
 
 struct neigh_hash_table {
 	struct neighbour __rcu	**hash_buckets;
+	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
 	struct rcu_head		rcu;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 395ae1626eef..45c8df801dfb 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -217,6 +217,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 		neigh = rcu_dereference_protected(n->next,
 						  lockdep_is_held(&tbl->lock));
 		rcu_assign_pointer(*np, neigh);
+		hlist_del_rcu(&n->hash);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -403,6 +404,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			rcu_assign_pointer(*np,
 				   rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
 			neigh_mark_dead(n);
@@ -530,27 +532,47 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
+	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
 	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	struct neigh_hash_table *ret;
 	struct neighbour __rcu **buckets;
+	struct hlist_head *hash_heads;
+	struct neigh_hash_table *ret;
 	int i;
 
+	hash_heads = NULL;
+
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
 	if (!ret)
 		return NULL;
 	if (size <= PAGE_SIZE) {
 		buckets = kzalloc(size, GFP_ATOMIC);
+
+		if (buckets) {
+			hash_heads = kzalloc(hash_heads_size, GFP_ATOMIC);
+			if (!hash_heads)
+				kfree(buckets);
+		}
 	} else {
 		buckets = (struct neighbour __rcu **)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
 		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
+
+		if (buckets) {
+			hash_heads = (struct hlist_head *)
+				__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
+						 get_order(hash_heads_size));
+			kmemleak_alloc(hash_heads, hash_heads_size, 1, GFP_ATOMIC);
+			if (!hash_heads)
+				free_pages((unsigned long)buckets, get_order(size));
+		}
 	}
-	if (!buckets) {
+	if (!buckets || !hash_heads) {
 		kfree(ret);
 		return NULL;
 	}
 	ret->hash_buckets = buckets;
+	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
 		neigh_get_hash_rnd(&ret->hash_rnd[i]);
@@ -564,6 +586,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 						    rcu);
 	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
 	struct neighbour __rcu **buckets = nht->hash_buckets;
+	size_t hash_heads_size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
+	struct hlist_head *hash_heads = nht->hash_heads;
 
 	if (size <= PAGE_SIZE) {
 		kfree(buckets);
@@ -571,6 +595,13 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 		kmemleak_free(buckets);
 		free_pages((unsigned long)buckets, get_order(size));
 	}
+
+	if (hash_heads_size < PAGE_SIZE) {
+		kfree(hash_heads);
+	} else {
+		kmemleak_free(hash_heads);
+		free_pages((unsigned long)hash_heads, get_order(hash_heads_size));
+	}
 	kfree(nht);
 }
 
@@ -607,6 +638,8 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 						new_nht->hash_buckets[hash],
 						lockdep_is_held(&tbl->lock)));
 			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
+			hlist_del_rcu(&n->hash);
+			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
 	}
 
@@ -717,6 +750,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 			   rcu_dereference_protected(nht->hash_buckets[hash_val],
 						     lockdep_is_held(&tbl->lock)));
 	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
+	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -1002,6 +1036,7 @@ static void neigh_periodic_work(struct work_struct *work)
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3131,6 +3166,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 				rcu_assign_pointer(*np,
 					rcu_dereference_protected(n->next,
 						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 			} else
 				np = &n->next;
-- 
2.46.0


