Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432107417BA
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 20:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjF1R65 (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 13:58:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:14120 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232464AbjF1R5q (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 13:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687975066; x=1719511066;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ddEXX1+WbwKlzeT/KLkPSUFr3LahD4h0zeJT18nrNaA=;
  b=HY1Z6CGV6HTi+0oFYry1BfsGb5C9A2gelxxhh6qBo/dL/u9pMe6HOvBb
   K3B/b00DXicM869Mz9sRVme0XbS2v34BVc70AN9y/kZ0Dy74JlposS5Mo
   8BpNfpwQ+slZ8+4qSkTxjKTiggqz6kX1aG4jPXQ93LduIgR4BEt/IWmWa
   pd/M4jaotuCy1biTfRCSe1EWPJ5IDoHaS4+bSEJPsIAHnUsX3X8otNDPN
   JvFe6dc58mzieUHI0hcOXNTGeI9Dlo7ZSVuNwhSq6Npzfm9whgyKrZ2Yu
   haD8nO0W2/EgSsQ50FsqHKRxS/umZjBNCeC2NRbsH50JZywS4bP+ibK1B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="346685814"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="346685814"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 10:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="717050484"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="717050484"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 28 Jun 2023 10:57:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 10:57:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 10:57:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 10:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gviFECU/mEuDNxg4Jw4gK8kMTcGIGq9xleGsSyn38wJt8KmMRRjjK8fazQWfNe/2j8KkA7lcnyQwmZ+pxLgUXoVCEvAgZRGPdXDZD1KQT2EsIELq1DRoGBkPxnG8uhVRgxapKZ8XP3JckQ5rS3TVbdl7NKq7FO2MPCPCIHwFV2Wab6qg3qPgPDfSWmB/ylgaTFS3bP40IfyoJFeZB22aODKTbr+GaArcKxm4dQ3xWc8kEHWvYLxpaKr3vXEluIark3gXuqwXuxyC03TlP3kPh/0+CcnzzEgjKBaqDHmk/YIsKNTE7uYRaEX4xZtKy3ReA4eyG7jAusKpqYGBatuvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9FIbIp7Uytdhe4NiwCjqLgvhqdbxyI2elvawo/YStM=;
 b=BBU7c6MVysMBEDPtZj0M+Rr1fC3Uqh6P7EXPqGXnBX5717CLIlnORr4HBBG8mGTITf0kK4AC6PfGZYF/mobwbVdhVGDYKmqJxMQ7+ndt/et5lsAu9QPlqF6eNP5mGXwubneZXyBXtwwbP5yMGhbxGS8UNLt75C6ebdf+UruQNWRhM7hrqmXboVowJC6gRkBHQHKS15e1OSvBaXe3Rm/dWT/gce2dm2RyM4X541DpNuy2h2M+wT7C6is8qTPOqXe53kNUMqmFr7QvHRX/bQuRX1Yka2Wm2lmyd9tcfHyySr/PasNNIjjvqgui0ARH8J5xjTEmfHkI+0nzCm7uO8C2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB7806.namprd11.prod.outlook.com (2603:10b6:8:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 17:57:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 17:57:39 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Shannon Nelson <shannon.nelson@amd.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     "brett.creeley@amd.com" <brett.creeley@amd.com>,
        "drivers@pensando.io" <drivers@pensando.io>,
        "nitya.sunkad@amd.com" <nitya.sunkad@amd.com>
Subject: RE: [PATCH net] ionic: remove WARN_ON to prevent panic_on_warn
Thread-Topic: [PATCH net] ionic: remove WARN_ON to prevent panic_on_warn
Thread-Index: AQHZqeJYVYOGpB+TjUe8QF/+3gn02q+gfp7Q
Date:   Wed, 28 Jun 2023 17:57:39 +0000
Message-ID: <CO1PR11MB50899225D4BCFFA435A96FB6D624A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20230628170050.21290-1-shannon.nelson@amd.com>
In-Reply-To: <20230628170050.21290-1-shannon.nelson@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DS7PR11MB7806:EE_
x-ms-office365-filtering-correlation-id: 92185614-7ee6-408e-986a-08db780129aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R1VDksjy5/XnloqZYCC0VRQ1ZW9q0sCkt4cJjvzBk9E8RwTswVs/X69z2fM0r2enN+Q9fFARwY/3jUsVLPIUDPlnUgphiu2Qybb1Lre6Q1JaGIjdI/s4AZLIHNAHZHfXTvnR8CaORlemRCy7DNnRpepJG2M3Trrn3zLHCded+hkccYtvngfC0z9VqEtF7C/UthZXbLtJhXKKVudOJLcy6Rbz25OwMBSS1QC/QXecxY6pgN/037l/oEEyJnepHp8Hfp6cKdB7GLTBz8aRUN+DaAVskvroeOFomvvS2dennNqOX0WWHG0zw2GE3SKBgmDWe0yUJJJT+7BJ9yY5CArSLDL+/ApBUxPAh0BmCZrUvYQSKnbaAzMgt0ahyK4sABMZWXYqSskEKEYDtOFOzWa+TuFs3RFIjXBRA1knkHSm3JHMeH5EggmWa56xGkea6MIsoFmOc0ljnlVclpOGSlX4IJasDQJFTbMtQQI3tB0P+Z+sc73gTTD7fWKKkx2VjAwZhi8SV/S3S1KyMveBK/VpNMhiT01NeNxH5sWWqOIj2cy/E3Wo0r7/OjoVqrqubgs8ktKWl3ef/cQbkYgkyP4/dDfBU0Yy0XwIE1zux4+8cSOLclRKnLBTof+unyDMjZhS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(26005)(66556008)(66476007)(38070700005)(6506007)(110136005)(7696005)(54906003)(478600001)(9686003)(186003)(2906002)(53546011)(83380400001)(71200400001)(5660300002)(52536014)(33656002)(122000001)(66946007)(82960400001)(55016003)(38100700002)(76116006)(64756008)(86362001)(316002)(8676002)(8936002)(41300700001)(4326008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6wlcvkmIFqkkSy/Ylr5hmV7Ecxk9CTpl2jX+RS01N6l+TzAeNBFBAUVOhRLC?=
 =?us-ascii?Q?8lSZtCP+zhSFMwWYo6Ce7aIKn2U609y0M5If+CuAqgMyRMXGqShT6solP49X?=
 =?us-ascii?Q?7xzeK4YaJCYz99vAUdPj0V0T29wUhqYqafki65OWege7NXoI9vZqzzlnIrFf?=
 =?us-ascii?Q?qNBAH5TeAfHH0SaWJtmC2XNwYwNlwl7iSx30EScOZ9WyQhDrf2ftx+qs4lmA?=
 =?us-ascii?Q?BGzrLVS1f7Iv2VH29K6j8291CnCRXAWIayzdVvf3LEGADoL1c1B2rL7hHSSV?=
 =?us-ascii?Q?6esiNzs/osEsIe1Ha8MuVQFubf2iMD2USjpIHoIO1DQeK4aTdGhdQFbXURE7?=
 =?us-ascii?Q?yQ73SKGrk8/4plit8/y2ci0Zt/Q4C6RmCQhfphPDPiMvBXZQEMfzztBQyvj3?=
 =?us-ascii?Q?tfgA4s27nciYoQ8iLdDrQMuKKh1aohyCOWl1AriCtr832VYNDlUKhfdnrtoi?=
 =?us-ascii?Q?Dpv/XULPKeCgj5vs4ShTYAyMibLxcU+hBfxEWIHaiI4PlQRYU+whr9GyggEe?=
 =?us-ascii?Q?bBTb9ygHJD1ehMSask6Dd0QK79hrTeLkxEth8m1L3ZojR8bsUDVA/jjK5Jbp?=
 =?us-ascii?Q?aqTG6HcGcNEeVEOFWJ28GqvSwfNhLpeRa17MT5XqkWwdfieMbm0zIpY4oZHU?=
 =?us-ascii?Q?kqYw9NBUaAUkdiaEkPInHVecZ/C+QxXR9NNrEL1XTEviU9tBAvsLNzNQ72GV?=
 =?us-ascii?Q?jX5ChgFFEGOR5U6VY9FVE045uBZBSjqi05Qm34BeLqGUsthi2vYiaFAM1swL?=
 =?us-ascii?Q?vNqYOSCOa4Twwz1nOP5xwTEylP5hLELzMJmtkXxV6D7o1mGSoIID70T7jKaP?=
 =?us-ascii?Q?sYyKvufqrYEFQaH9fqEQcli02Vi+3/ZOo5wEjRGyUCo3MF7By1aaGctOCDvl?=
 =?us-ascii?Q?mf2fD4AgG83X1cUN769szPoWySY1G3PXiwSWbhoF1FYFbnDRYj91EUKqDFcF?=
 =?us-ascii?Q?dKLT/0gyy5bjd792S5VJgr8+xfBSuft770GgXz54NRrUZYomgkcdAN5ZddS5?=
 =?us-ascii?Q?Cpi3Jmhp2lx4XAFdb7EL0lP0rqI8QdthbFf8St82QAqzTkoeAE0/nXT0EFPU?=
 =?us-ascii?Q?sElU2WYtJlh4rfeJTZcZwCIaglYLQqJ2BhW+J+Nb4+OgYzOzkCXncsvaTOpT?=
 =?us-ascii?Q?KBL2I8Gdzk7ja/52x0JzEJ+cWXDyvhejNThmpI2KB0XLsxcmDGplrFRF4S3O?=
 =?us-ascii?Q?/Te6owZFxJ/fXyJY48fsxUSckl9x3HYWxZMTJe3/a/k4UbtzMS+0F6g+RRxf?=
 =?us-ascii?Q?FwKK+Yfn1xXbsyDuyG+yV6jk34P1iHDs1F2p7l8urqajg/Da9KvamJTZoH5A?=
 =?us-ascii?Q?fGwx0Pc+4cMZ8AjLi1+nDrM3IWlU0Ob8fMvQR6sfSV9F3bxZM54Ti8b+lqxb?=
 =?us-ascii?Q?4+qtCP/mgvPLwXAs8tgUAP04mIIlbMoOZ/t+3TRknkxySgMq/qqfvDbpYi1D?=
 =?us-ascii?Q?4p6a1ZC5eTc3pvYvi4xD0j4FhsH9aJuPbaUSKWmjZc70WoAzC3RxrhwpRdtg?=
 =?us-ascii?Q?/Vv0+UtKnjT7NHWT3Yb4GbP5//M1/aZ6FJwiEpyc3yV3w8oWHzPwghyJZiyA?=
 =?us-ascii?Q?FbCAH08sB3/4gplTc6NfBgC84ma9qD2T9QG7eD//?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92185614-7ee6-408e-986a-08db780129aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 17:57:39.2377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6C/chXrxlOXGA6Ub1wOOfQkY87eFqIr3n68/XGdiYoy0I9nz4oMg6jjXAH21JpA4CyAhUTNxSYlyL7hjT5+XfFY0mfsuHjEoWSzpXMFq/fU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7806
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org



> -----Original Message-----
> From: Shannon Nelson <shannon.nelson@amd.com>
> Sent: Wednesday, June 28, 2023 10:01 AM
> To: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org
> Cc: brett.creeley@amd.com; drivers@pensando.io; nitya.sunkad@amd.com;
> Shannon Nelson <shannon.nelson@amd.com>
> Subject: [PATCH net] ionic: remove WARN_ON to prevent panic_on_warn
>=20
> From: Nitya Sunkad <nitya.sunkad@amd.com>
>=20
> Remove instances of WARN_ON to prevent problematic panic_on_warn use
> resulting in kernel panics.
>=20

This message could potentially use a bit more explanation since it doesn't =
look like you removed all the WARN_ONs in the driver, and it might help to =
explain why this particular WARN_ON was problematic. I don't think that wou=
ld be worth a re-roll on its own though.

> Fixes: 77ceb68e29cc ("ionic: Add notifyq support")
> Signed-off-by: Nitya Sunkad <nitya.sunkad@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 7c20a44e549b..d401d86f1f7a 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -475,7 +475,9 @@ static void ionic_qcqs_free(struct ionic_lif *lif)
>  static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
>  				      struct ionic_qcq *n_qcq)
>  {
> -	if (WARN_ON(n_qcq->flags & IONIC_QCQ_F_INTR)) {
> +	if (n_qcq->flags & IONIC_QCQ_F_INTR) {
> +		dev_warn(n_qcq->q.dev, "%s: n_qcq->flags and
> IONIC_QCQ_F_INTR set\n",
> +			 __func__);

What calls this function? It feels a bit weird that the only action this co=
de takes was in a WARN_ON state. Definitely agree this shouldn't be WARN_ON=
.

WARN_ON is something which should be used for a highly unexpected state tha=
t we are unsure of how to recover from (even if you go on to further protec=
t bad accesses in order to avoid completely hosing the system when not on a=
 panic_on_warn system).

This change makes sense to me.

Reviewed-by: Jacob Keller <Jacob.e.keller@intel.com>

Thanks,
Jake

>  		ionic_intr_free(n_qcq->cq.lif->ionic, n_qcq->intr.index);
>  		n_qcq->flags &=3D ~IONIC_QCQ_F_INTR;
>  	}
> --
> 2.17.1

