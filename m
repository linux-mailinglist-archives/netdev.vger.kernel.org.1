Return-Path: <netdev+bounces-38971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A836D7BD4E6
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F642815FB
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A46614A9C;
	Mon,  9 Oct 2023 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="XXTbex2q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75B14F98
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:10:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2094.outbound.protection.outlook.com [40.107.243.94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776B29F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 01:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4M5E6cwcmr8VwHH/DIdXzqp6/jXeD+DZ6o80ilp5vKLhrPkuF9QKKDCryp00Ay7xLc8I5buSIupPH6Iu0p+oJ3YhhcluJSd+m0lK1VbrVDYsCYElGYbM4PjNHPdM9MMOA5ZHvay8VwDv9L4BHBpXq5OcIEJ3NlYBiYNq9kq2XrW6TplMnyUS+WKtFW7kb9neLclLVSlMlEbgkwYNPNSjvKcCf0KtaQyoC30FG3SGodQrWbp9TOAjd/fm6a+p2ueRjBTq05lxvTl6Ip9wBQob+ZJ2kjf4bB+hc6QzpXCZCXCuNZ0y7khQHv3glM1TBZO88qxiYCWY8+8Jy+FzIDrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+McZolGZmHdJ2zf/o0c2mLB4LCzsyCNMtR1Gvaj0JC0=;
 b=bEJ1gpAFGggIzYgwdaTiVLXKUR0c+SFxrhjubtCCZSC7euMys/CQ3u7YREHeQ9IEQNzn18e42yjpT8YKOpdr23MFfbu2Wq2lmW+t8v/ya2YQaVI3fGUgvjijY1DlLY/M7+JKgmdPnp/1vPoyr+mntSfmQsVS4cxEzZlxvsaKZh7s/Qf3MvBWJOhd/rBQY9yvJc5OHaTvLJRN675cz9+IzX5sgcDVf+EKkFrkdpUSUR4Oho4e7SnW2yYasJj8CzwDpArxq93jjnxMsMTpsqEx6X7asGcGiqdnO1VjenQCbI0ZbM/SJhvs6yuZYz68WTmyz5lTBNRzJsfZbgiDqSzhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+McZolGZmHdJ2zf/o0c2mLB4LCzsyCNMtR1Gvaj0JC0=;
 b=XXTbex2q9fWZXrYrEICSBqLrwq5qR6nhSQptMASvfe5AwK+Zn0F8GhNnMf14nL7WzGsTtw2s1yV6VYeAiiqKA6tpRgpivGj3T4LKAQs3ZPdsbUd42MPnAV4Csg3y3hStlCD5gEDXqwpRFqdL3RDYto32ype0F3WZGFdLF7VlpRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 CH3PR13MB6438.namprd13.prod.outlook.com (2603:10b6:610:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 08:10:24 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 08:10:24 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Leon Romanovsky <leon@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shihong Wang <shihong.wang@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v2 1/1] nfp: add support CHACHA20-POLY1305 offload for ipsec
Date: Mon,  9 Oct 2023 10:09:46 +0200
Message-Id: <20231009080946.7655-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009080946.7655-1-louis.peens@corigine.com>
References: <20231009080946.7655-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|CH3PR13MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 278df20a-cee6-4135-5e89-08dbc89f30b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QTU1K+r6ztzh4fCthSvdFRFu0okLyD42TGxvKBv567fz3w4qbZl7gFSZ3n1Jgg1bg19dpxUSj2JtJwgjVF17e5/APNvMlRKDZ1XdnT7ehUcH+oc7c8ADEH4o7D6RKytFTrGX965omYvRD4WUEk+mwKpiYjbaUrazQQDmrCM2BX38pIIxron/whEpCqLG1ND6pEEoSYfmkvGbrGhAZo3u+i4Up/mVNT0yO8PaK9gDC3mC7eTG8kL8dr0K7xnfTK/TZduZg9S/T/VUZ45pSmqm4s5UF/xg81EjjP+l29/0FMuV66oJgj+hXSWW89z1rCb80if72MR60QPN3IpptijJxhWb8AOJNIAxzRh2hs3VgiU39Dgb/NY8PLqDadeKyUbGtz2SOY+ZRv66e3Kr2qcndCYP74fWHBDaeuRch6muP9sn28QfAX/4HMeDBW1+IHfdtPoqI9uwLJrDCQ14wR5RJ0V8H4w2OaRIkFCN8OJNFkrUOkl/mVQUq/YZutNlbX8By8dR7F+CXsEkTK7S9MBom84SQzFnn+vPd43CpvsZAkXVtwTN7UVYhbLSfUrTnhs7ZlVwoNSA0O0lwaCrlP5FClrCm4WAna0kDiKAAP+vvOWyA5u3qruSmOzKzef0SsOr5nsyQT05X25ZMDJLeKb+faDTOLsvPFbInJ6ZuFscfko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(83380400001)(107886003)(1076003)(2616005)(6506007)(52116002)(26005)(66476007)(110136005)(66946007)(54906003)(316002)(66556008)(8676002)(8936002)(5660300002)(4326008)(41300700001)(44832011)(6666004)(2906002)(6512007)(6486002)(478600001)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E/OsHeDryveskVXle0bGXld54YIDmAWjTpaa+Wt//TGDIc+BXgHG/B9t9Msn?=
 =?us-ascii?Q?puKKRal7CTbJWNxU9gWIuGitT9hpH+gcUVM88eqsYuDHGcelFXbkps2clsrE?=
 =?us-ascii?Q?lj2iuxApF0DskNfw8JfvsPdjoFthdJUXhr+5LN1PeWWmatR3iZYTLvXgpRCR?=
 =?us-ascii?Q?QcvWEl9hxR259GIytFzwtTw3/qmPw2lfbvCs6I4/OtjCdsJbG++z25f4xpQ6?=
 =?us-ascii?Q?LkVuQCZi9lwz+0xYnARVNAyKp10Fo0A6hsrqrnhRlFuZbVa+KlHraEQDT2YA?=
 =?us-ascii?Q?Vr25he4QNoV/eFEztgKpC/fY/tceHeW0CQYQUxwxMpw0fQFy1ibbMzysyr7t?=
 =?us-ascii?Q?DAXBDG9k6U8A3ODWRXJW+maZEXHlIHkl8yPnBgRRoImckyPqKDGTaua6k5Fc?=
 =?us-ascii?Q?R/IQGMDI891X1Erku6iDoEguanUuOqrzNWG9n2mPz/9I4mQlU6mzb4+FP1Gk?=
 =?us-ascii?Q?4/+MfIkeWTh4ct9ETBSaW4cGrbUlBLwXVVlThwW6JPhXbADO4KB+yGe3bcPW?=
 =?us-ascii?Q?2rpqgJK2bvDv7hUzyNL1QjzJ3gAQFlzvH3Z7haAb7/Iqvy/z5fpHgOzTlAVc?=
 =?us-ascii?Q?Wt5stHW+TMf1yBM2tSZmfrA9/KRgpVP3NiIztRO/bRNomNkiak1+O+huW5z3?=
 =?us-ascii?Q?KGPTE6EMjXfBRx+O/CVsTJ0E9bQhtlMvD4/gYWIBpuCy1KzhC0JC79nWXefd?=
 =?us-ascii?Q?jycC0nZ4fR8CCZTGCN4nS3BD8CS5IJcLpY9mj9jskSV+xOyctV64Jhjz3RW0?=
 =?us-ascii?Q?UsQ9U1l18IFArXkpJekc/WrkBFah9KXCBShe5jAH1QPzShijCAxckU5u4sso?=
 =?us-ascii?Q?YtjbN5deCWIEOYkSVhQsw66TrwpPREznF9eaMJPoPwxOX8RijtuXDuZH1iIU?=
 =?us-ascii?Q?7ByyIPPhn93r3FQvc1ypBcT0Qi7c6tBeXSwVqGpN5cqgyyPPoINPIWvdU1Ft?=
 =?us-ascii?Q?SGKsaAOF1xbSA0fATeDvl544ImpNfz8G6HX1FR22y5iDSZCDAvuVyK3cX3fj?=
 =?us-ascii?Q?ZNGSpBoF1DnRleWEhOgNsoIrdvmHSgu6TS7YBkcJGDs7e3hQ65rL4SeyPNMs?=
 =?us-ascii?Q?46z3ZkkQxRiCTAtRQzPFckJYJBMqeNI2dwoNh6fx3jbhx4Y3C8moHb476CNT?=
 =?us-ascii?Q?FrQQAQWvxJIY3sYa3eYEW2PmUsYTdjFd4m3aNd8EfPdFy+MZcHrv/RuZyQDr?=
 =?us-ascii?Q?lnGJiwB9gRPJxz9WTvqeLNph8Nm1kpbQMD3o+n3HCa9NO21B1vBFCMjSADIa?=
 =?us-ascii?Q?EZaG8ChFc5l9hFDrscRkM/A/J+o1zka98A2Oh9NOaN5Ph9hI/X/lxGOiLF0J?=
 =?us-ascii?Q?ZwPboe7BV9Nefs9HuxfN0CEyyesn0npyN4JGU7YAxfWV2nwABfDfDHb5ObQ2?=
 =?us-ascii?Q?ig0dVPdXrMZ+zjCgcjmlL420QiGotUGqQPXrX7Lg0kbQJtZdkDn8PH+KDDcD?=
 =?us-ascii?Q?u/lFHNGMBspXXexszwDzViRA/ma0dAQRAt8BwQZO3/lVCR5pDNFZS++rCHut?=
 =?us-ascii?Q?azQh85rYATGeENH5Hp6muogW3vSiauXwZcmuz4xlNyfAQW/g4Y3ZYyFlF+4P?=
 =?us-ascii?Q?B4twarqw8NaeAFCE3pzQ6D2op9xUQ2ua8AbU39wJ0W6tCCMs7fR9GkspiVOV?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278df20a-cee6-4135-5e89-08dbc89f30b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 08:10:24.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GdCCY3H/+uNmbQMdUoGQ8Pv1gnM5XL6Y1ppycFaDSpHt4Uda+V4ZMA0iHQ+Of6m2TpXXdZcg5XYhlOTg0jBg0PlVpEE+G/Zaq71+muxJ0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6438
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Shihong Wang <shihong.wang@corigine.com>

Add the configuration of CHACHA20-POLY1305 to the driver and send the
message to hardware so that the NIC supports the algorithm.

Signed-off-by: Shihong Wang <shihong.wang@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 45 +++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
index b1f026b81dea..cc54faca2283 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
@@ -378,6 +378,34 @@ static int nfp_net_xfrm_add_state(struct xfrm_state *x,
 	/* Encryption */
 	switch (x->props.ealgo) {
 	case SADB_EALG_NONE:
+		/* The xfrm descriptor for CHACAH20_POLY1305 does not set the algorithm id, which
+		 * is the default value SADB_EALG_NONE. In the branch of SADB_EALG_NONE, driver
+		 * uses algorithm name to identify CHACAH20_POLY1305's algorithm.
+		 */
+		if (x->aead && !strcmp(x->aead->alg_name, "rfc7539esp(chacha20,poly1305)")) {
+			if (nn->pdev->device != PCI_DEVICE_ID_NFP3800) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Unsupported encryption algorithm for offload");
+				return -EINVAL;
+			}
+			if (x->aead->alg_icv_len != 128) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "ICV must be 128bit with CHACHA20_POLY1305");
+				return -EINVAL;
+			}
+
+			/* Aead->alg_key_len includes 32-bit salt */
+			if (x->aead->alg_key_len - 32 != 256) {
+				NL_SET_ERR_MSG_MOD(extack, "Unsupported CHACHA20 key length");
+				return -EINVAL;
+			}
+
+			/* The CHACHA20's mode is not configured */
+			cfg->ctrl_word.hash = NFP_IPSEC_HASH_POLY1305_128;
+			cfg->ctrl_word.cipher = NFP_IPSEC_CIPHER_CHACHA20;
+			break;
+		}
+		fallthrough;
 	case SADB_EALG_NULL:
 		cfg->ctrl_word.cimode = NFP_IPSEC_CIMODE_CBC;
 		cfg->ctrl_word.cipher = NFP_IPSEC_CIPHER_NULL;
@@ -427,6 +455,7 @@ static int nfp_net_xfrm_add_state(struct xfrm_state *x,
 	}
 
 	if (x->aead) {
+		int key_offset = 0;
 		int salt_len = 4;
 
 		key_len = DIV_ROUND_UP(x->aead->alg_key_len, BITS_PER_BYTE);
@@ -437,9 +466,19 @@ static int nfp_net_xfrm_add_state(struct xfrm_state *x,
 			return -EINVAL;
 		}
 
-		for (i = 0; i < key_len / sizeof(cfg->ciph_key[0]) ; i++)
-			cfg->ciph_key[i] = get_unaligned_be32(x->aead->alg_key +
-							      sizeof(cfg->ciph_key[0]) * i);
+		/* The CHACHA20's key order needs to be adjusted based on hardware design.
+		 * Other's key order: {K0, K1, K2, K3, K4, K5, K6, K7}
+		 * CHACHA20's key order: {K4, K5, K6, K7, K0, K1, K2, K3}
+		 */
+		if (!strcmp(x->aead->alg_name, "rfc7539esp(chacha20,poly1305)"))
+			key_offset = key_len / sizeof(cfg->ciph_key[0]) >> 1;
+
+		for (i = 0; i < key_len / sizeof(cfg->ciph_key[0]); i++) {
+			int index = (i + key_offset) % (key_len / sizeof(cfg->ciph_key[0]));
+
+			cfg->ciph_key[index] = get_unaligned_be32(x->aead->alg_key +
+								  sizeof(cfg->ciph_key[0]) * i);
+		}
 
 		/* Load up the salt */
 		cfg->aesgcm_fields.salt = get_unaligned_be32(x->aead->alg_key + key_len);
-- 
2.34.1


