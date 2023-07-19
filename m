Return-Path: <netdev+bounces-18860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAB758E77
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD4D1C204E8
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ED1BE4C;
	Wed, 19 Jul 2023 07:13:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423FBA26
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:13:09 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F21997;
	Wed, 19 Jul 2023 00:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+lbw0AznvdtuxlTaau8PST1PkT2kUJrdrqu+N8u+gkrTij4ZpgVSfuNfogp3NS/jFFwszoYnixpr7ytPtxq8h3RByKcDccOq+/W2AVjn3Xq5OqsLOVS8sWCWYE5/LU/i40Yg81aVvarXZ04IvfrvjQVKUpuTydheUxIVcTT0yd0wyM3kOrNbJMyg+RAi+EquY5IS4PCrzzar1LAEMXBzlD7WooLyAOBfYsnQrOB2rCxwFT0ZMQ+jFYMBLFkqsX+MW/4HqwWfO4L9tLwA5v2nhShIVemGR0mtzPcN1RzBB3aL493BhFhr6fv+jE8LvUwady8OuaH7rkPHXKLZljNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8TndL2RuKScHdrS4BcgH9S0UDJd/iItYTTvtqnMI5M=;
 b=P+iHA6E2iKRwpYPID3K9L0FodivCPbZuaOFYlrQtayacK1WsfCKipkQQDW0qgqvIAQH+jEhx0cs2j2nJVL1+ITysQgKmMwbE5B1OsD0CewI2huXmmRJrkqkBZ/56Rfju6oEakpLsYYR3ZBWzDACgiGnkjTuDg8a/MSl2T6W6T5hy0bVcnt1DRzoW+3T6MbZyziA5U/O7/6CqSYbL7MuGWeuKWKUCQxPFFdycluqpsOASEFXgBidX95cRNhB3eXly5loa+ph3T2lbmUU/l6dm5s0XK203pH6jSa+IwiR/aQSoEfqMLDl1MLYlK0q6EJd+tVYFK9U2bD8b7Neran9NbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8TndL2RuKScHdrS4BcgH9S0UDJd/iItYTTvtqnMI5M=;
 b=lpMUJsIcuPMEwZY39aMhu5Ve+8uP0JMp/9WfrDKeehM5Fy4iQXlPJhHjmAlC30Xx9BIrx44Sni0qpTAvlDvMVZfOUoCRBGlhV2pCc7WnuG2TVMhyWh8PfFeOIQ9s2eN8a2CCmXYeXfs7f/1G27cf0MP9dFBL+rzycPw5XqyZPl+TK2m1fAMc+oa9HRby+N927D3rcHkM/t6lF4wvlFqIJsnli16t7M4mBc/M4nhwwLRYAOsVrJByWUqoCwf8qDI8J6Udhz5NfuZBWsltvBTqOGshQnuWD5WEyzxypj6hUoX2sQMN9LTVFdfO+Mcsdjc9PL1+aJQ3qn/WpP3Dnzxb0w==
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 JH0PR06MB6388.apcprd06.prod.outlook.com (2603:1096:990:b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33; Wed, 19 Jul 2023 07:13:02 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::75ed:803d:aa0a:703f]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::75ed:803d:aa0a:703f%7]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 07:13:02 +0000
From: =?iso-2022-jp?B?GyRCRU5JUls/GyhC?= <duminjie@vivo.com>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, "open list:FREESCALE DSPI DRIVER"
	<linux-spi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>
CC: opensource.kernel <opensource.kernel@vivo.com>,
	=?iso-2022-jp?B?GyRCRU5JUls/GyhC?= <duminjie@vivo.com>
Subject: [PATCH v1] spi: fsl-dspi: Use dev_err_probe() in dspi_request_dma()
Thread-Topic: [PATCH v1] spi: fsl-dspi: Use dev_err_probe() in
 dspi_request_dma()
Thread-Index: Adm6EHR22uF5gOmzXUOAvwE9PHYqrg==
Date: Wed, 19 Jul 2023 07:13:02 +0000
Message-ID: <20230719071239.4736-1-duminjie@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: TYCPR01CA0022.jpnprd01.prod.outlook.com (2603:1096:405::34)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB5288:EE_|JH0PR06MB6388:EE_
x-ms-office365-filtering-correlation-id: 4efcfcef-a0cb-4831-5b9c-08db882796ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Du50F3dtApTzf+wtCrWb9/LuEpMn0Xx9xZk4c8KTIuBEjkS9ECWO1XsQuh15E2CxTG5ZLdFlETuKyngYEc9miQqZx7XroXhNONBV4R+L01HOn0tHL8Us96uJie0T7llA1NDzMwaKRsHF1vEv1eRWfCb3KhZ/UyW/aDek+S0Y5bgtCdzoujiA0MO9nuCgL0XXETo6i2ipvymXzhdC6YHUVRqh0fM2I98ToR9TG0zxoxPf3Ya413zRwqlSNCWctXrplIUJgxyACu+BahA+QvkNkzTFSdR6zN6MT0lRDnAHsd8hXMkQzbB0ge9d+ODQ7KuTIah32tQ3ORdaEV46twp6L8H80sduxL8lWjjuIPIKwicLF46rWEB2D4/XKA4C6KWrzBTKo3aIv/Uer6i4wvRnD434JCSpZdDXAlouzXqkmquQc18olvuqKub+nsvr6cP6Dr0NXkzsF6kQ17onWzYZmb+5T+ZyIq22LdqlyyKnz0TxP/b38Sq+KTxVXakW3d4ql8wThdBW0IdEj2rvfqMqzl2ROgOAQDEL2FSnV0X+GURIVnp3RO++6YJwqeCUMas/tD85WBEBeKN1VVhxu4teAT0w3+5Rmk8yS76s6NvZqDzZjvRIMhTFkfS7553Ib2dW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199021)(52116002)(6486002)(54906003)(478600001)(71200400001)(110136005)(83380400001)(86362001)(85182001)(36756003)(2616005)(6506007)(2906002)(26005)(186003)(1076003)(38350700002)(107886003)(6512007)(38100700002)(66946007)(316002)(122000001)(66446008)(4326008)(66556008)(66476007)(41300700001)(64756008)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WHJTUXNVeEVzQ1dXVVJXZWtQSTd3WnNyMjIrNzQvNVAya1NmSm5aMlRS?=
 =?iso-2022-jp?B?dWdwN0JpS0sxd2F6RWdMdThDSk9uV1dKK2poZnAya01rcjR2cnVoZ213?=
 =?iso-2022-jp?B?OFIyK3JFZzJzZDJONzJVWWlWdmFZcnZ4OTgyUmNoQ0MxazBpb0pCY2Vr?=
 =?iso-2022-jp?B?M0FxWjR1V01Sd1RiTTE1bklBenlaaDFGT0xNSGEwUWsxd1hJT3pIbTRH?=
 =?iso-2022-jp?B?aFJmdDIrc3RzdXQzK29lNXk3RklVclJicjlqSVkwOWJZQWZhbWZQNGFO?=
 =?iso-2022-jp?B?V3lQaldGWlR0NHVLZHdtWXh3TGxsT0wvdjBCOS9xWnBrb3hiMnVBL2NO?=
 =?iso-2022-jp?B?MG1YQWZiYzJ4N0tUMVN5UEJMdENjd1NqVEtsQnc2V2Q0YWwwY1lvT0pI?=
 =?iso-2022-jp?B?Sjh0bDZvOGR1MVBCR2NzaWFsWlpDRXp4L1U5NTloempUTjFEL3pKVXcv?=
 =?iso-2022-jp?B?UVZoOTRFYTFSRnBtbHFUQ3hmbndGd2E5K2JFUzB5NUVIWWNwaGJ3dFdn?=
 =?iso-2022-jp?B?dzFPTWxncWRyOGpBa0xXb3FQMDBhcFZ6aDJRSlNCRVc5cExIcnRXbHpP?=
 =?iso-2022-jp?B?azA0WmNJZkJyeEIyUWNPUVdSVXpHOUpwL0VSWW1EQnFIdFFoMlpPUWgr?=
 =?iso-2022-jp?B?TmlYTE5acXpqSHBxL0RtM0lmb0tzWlRZc1ZqZkV3K1BzdTNzWHoyNFpm?=
 =?iso-2022-jp?B?YzNkSjhZa3dabnB1TVRiQXl0T0s3bkpLWXZlYXhVQkxzU1E5QjZ5aVlV?=
 =?iso-2022-jp?B?M0s3QzNOV25Wa3dEcDlQK3pmUjdMamVtenQ3cll2S216Sjd2ZE1hMGZq?=
 =?iso-2022-jp?B?dExKemFxK25oWm91T0NURjVFRzl1dHBVSVFQSkR4cHZ5Vnc4ZjRuVFQw?=
 =?iso-2022-jp?B?ekJTN3lRSlVFSm93WGc4SXZXZ3ZjREQ4NEZOeENnM3lpbjVucTRLdEgr?=
 =?iso-2022-jp?B?VTFEVFRuWVNHRE9JNWg4WlYxN29wa3VSOW1raThuQUIrbUZRYXhtUnNX?=
 =?iso-2022-jp?B?SEtMYzY1c2w5V1Mwdlk5SlJnN1dlZUxnOHZYc09tVTl3cGExelhWZHFp?=
 =?iso-2022-jp?B?Uy9YcU4zODRVWm9DSEZxMHlQZ1IrNStHeDZlL1d1SWZTWlZjb1Z3cG9u?=
 =?iso-2022-jp?B?VXBXcE5sTFZrTDBHSWV6QlAzUmlEOVJ5MFpSM0hXRUhZOWMycXhqVkx5?=
 =?iso-2022-jp?B?WmdWb1ZhOFVHbU5Nc0Q2b2VCS0RLSk5jS0V2N2l0UVZ5ckt6eW9lRnhV?=
 =?iso-2022-jp?B?TDMzOVhSTXB5MDhJc2ZBQVFpT29jYUpycHp2dmZQS2FwYVpON202SSt1?=
 =?iso-2022-jp?B?dUVPbS83UHVqeU5md2tWaUgyQUUyVHhnQ3Bvc1VRMFdBdmozT3FvMEZO?=
 =?iso-2022-jp?B?b2JML2tUVGZGSURQT292dXJwVVBrK0l3M1VReVZJNy94cnlKV1poN0Ni?=
 =?iso-2022-jp?B?YXJNY2pZUmxIbm1RQVRxS3B6MHRGZ21iSlJveEwxeXhYUWoySjBVZVRM?=
 =?iso-2022-jp?B?aHVJcXhvcGVNSUFFbGVWNkpoUzNpbFNzM1o4QklzOE9yQ01xTGtWZlFZ?=
 =?iso-2022-jp?B?Uk9KaUphRDdUY3grZlpIWE8vWGJocjk1ZHM1TlA0NlJrS0FzMzQ5Njhi?=
 =?iso-2022-jp?B?Wml5RlVPZ1ZMMXdZbThvRVhiczl4dGcxVG5QV2ZhVmRnTTc1a0NkUXNT?=
 =?iso-2022-jp?B?enorOFZ2WGdoaVNTNFBmbUdSVG40cUQxdkxVSVdhaHZWeFpyYUlTRVB0?=
 =?iso-2022-jp?B?V3h1aWt5WkNzdllLV3dEdEpsZmZOVUI3c2h0dFJTTEdnRDRJaDd1Y2V2?=
 =?iso-2022-jp?B?a0dpcUhQVTVlZWZtcFpmUG0zbExweVZFZWpwaGNJcXoweDVCTWZrRXhl?=
 =?iso-2022-jp?B?YzREbHd1Qnk1ZW9XMjd6YVNEd2RyMGk0WmpDYzN0NmYrUWIxcFVHRExq?=
 =?iso-2022-jp?B?Vit4OGR3M1ZKVlM0L1hqYXdvdm1PTHh6cFYvWnZMSnlXdnVPcEt5OTZP?=
 =?iso-2022-jp?B?V1MrYnl0ZjlZY3VCdllCcy9qWnVocGhJUTBNb0RnYWZsNFlYbnNZRWdp?=
 =?iso-2022-jp?B?NkJxVVdqQkF2dGw2OVVZd2tDcXM5aTIzL3A0QmQ2QVN4ZUJDSjdRckZ1?=
 =?iso-2022-jp?B?TGxEeTN4SjM3TTJxUmcxS3BYQmxzUnFSa3VlWDlpdThkU0h2YTZWZ0Zi?=
 =?iso-2022-jp?B?VTVUbHd4ejVOVDlEMzJBY3lDQW5uVTczUzE3WGlGYzlGUjBVazNqamNy?=
 =?iso-2022-jp?B?UGN5TXJTbms3UWxybkR3c2ZsZTd1TnIreWo4TEZveVRqNVRHaTY0U3hQ?=
 =?iso-2022-jp?B?THRSOQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efcfcef-a0cb-4831-5b9c-08db882796ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 07:13:02.0331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: On/cqDY06UhkZjyWM1C1ErOVoxpAEyqD8Nv+nJBCuyEHWoIU1BnrvHOl/2cB2CAzK0QIFAXiKZ7Vj46MRhTLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is possible for dma_request_chan() to return EPROBE_DEFER, which means
dev is not ready yet.
At this point dev_err() will have no output.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index ca41c8a8b..6aaa529b7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -503,15 +503,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, ph=
ys_addr_t phy_addr)
=20
 	dma->chan_rx =3D dma_request_chan(dev, "rx");
 	if (IS_ERR(dma->chan_rx)) {
-		dev_err(dev, "rx dma channel not available\n");
-		ret =3D PTR_ERR(dma->chan_rx);
-		return ret;
+		return dev_err_probe(dev, PTR_ERR(dma->chan_rx),
+							"rx dma channel not available\n");
 	}
=20
 	dma->chan_tx =3D dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->chan_tx)) {
-		dev_err(dev, "tx dma channel not available\n");
 		ret =3D PTR_ERR(dma->chan_tx);
+		dev_err_probe(dev, ret, "tx dma channel not available\n");
 		goto err_tx_channel;
 	}
=20
--=20
2.39.0


