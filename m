Return-Path: <netdev+bounces-100637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E18FB6A3
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0571F21C5C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93DF13D524;
	Tue,  4 Jun 2024 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SDamqt7x";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="44j7WlDN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A013D50E
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513798; cv=fail; b=lkU73l2AuYQ1pQ40mFJvxiL4tZLhAK6ucSZOEPJcJVlgQwoFcSrIBdc+hSf8AFIdPdyk4XN4LkCPgFcCcYo9998ZBazQB9Xn9o+XXJbdeiG8WYh4MFjIW6j5JDGvjfYrDRw1SvdL6ZbnZUu/026QlsDypi7uwO/0DbBpjUjRPUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513798; c=relaxed/simple;
	bh=YlyIgWcMP7eQnDr2uMAbBC3ddAJj/ncMckvQkEdt/SI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tBwKouPfNKLYcWoa2O7fIXGOu4C+Cts+kC1sakcf7Rlq7z+519x8x/H9OsnRoUAqY8k2TiXbcGNf9FsYNzOun9BOBtY3E+fYock3FofEuotXcVGmvwaYYHZ9ZE/AMbtPi3z5PBH2jkF3aozr+3w6cVDO9YhI+SAHjjD03jHL2oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SDamqt7x; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=44j7WlDN; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717513796; x=1749049796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YlyIgWcMP7eQnDr2uMAbBC3ddAJj/ncMckvQkEdt/SI=;
  b=SDamqt7xylr/eXo64xwbatBELfj7f+agVq+bls8zFSFAPzS19u3jChaP
   XJvpHWoBbD2SdH9vMgcoXs98C1wfGP1qa32VpcDRZvuor1KF33dEhjq9s
   2twgIl48yQ7rhxRxGT91A7u03+3PlYevFb8rB5RVyKtM36nRSRy57uhZP
   MZ4gbulPgso+ZBeLU1EhTITh+Pewdxj7FzGnxV7oX5m0MZNweAwI/6hYc
   F1OoQNTmsSKqRB+xCQ7UVd2pdQfC7b7zHAuULWhAsjB21qCuIt+zb7tMi
   Wml5jgJZ10UZkqGIULZ694jR6tgu7F7WCTRgjOnhah5fVj28ZlOk/35LI
   A==;
X-CSE-ConnectionGUID: l2PuMOA6RziXCldZZ9NQjA==
X-CSE-MsgGUID: Kf3Ofl3NRvmT3wZgYwcgzw==
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="194362088"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jun 2024 08:09:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Jun 2024 08:09:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 4 Jun 2024 08:09:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUenCyTI/xHbVFygGdp1clzs2VACfLs7boxURG8Ob5l0hTsaemRHd1354wVhy0DEtxDey+4sRdFy6Mf6pcJeYnykZWQfWXw5Msjntbu7xNkrcD+uce8vGIRk7Y3qI+t931Ip8vbSS2e9r+MHbA6Xi1GrQADPejQLhlJXMQLG2sAxrOIDfN4zqC62rCOmZPmHxXb8ALRjDduQktsZ6d3Iv1VFoXR2fvJ0jL9lBWb6zI9EQclXK3nYcDNo2ZMuKrhVuONAViegxG3AtRo6L8cwIS1jXSD3PPDLuKt4C1Tn6/XRzb/wlVWLVpwiSlMPJoVwPR1iCqDwAs4W2n3nCiCvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5JLKhV701yRSrYPwi/PoMBZv4PK3L4pTu2SlOF7INc=;
 b=fJmueqVxsNqp3UWEpGIrbrQDv0CcXDG+VFVfkHD0cKJpZIHTyd9lphb5cy/TjA6HFcH/ejQuPGxuPD+HD5931iAq84xU0z/hMJLnzY00zF/QNGt8S6+PHx7/D004R9BYqL3PL4jtBZ30NWOW54mJBwu7JbT5Cjri2239RhfHHTafy/d5kTHt/LG2YAY5NK+xNHkGmvOZmkJt3L7DXBu8ipjHQRb2aB4U4PLINMNLNAowiL/7sHLbjTkJKdQUiBcOEVCrKj70cQ8QRVWBcGXROKn1BAy+SseEjfGJv1gNTEHKwJoGfW36O12oDPhf9lePW+7uguYCW62X1vfGG3H+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5JLKhV701yRSrYPwi/PoMBZv4PK3L4pTu2SlOF7INc=;
 b=44j7WlDNLZxSD8h4YVosv64m33JoYgqqVQI7ihjrrpSpZ1MNLwLlYkT8eKqxKg8arI6KFPLC1uleJHdI55y6WSo6ZuHl9mHXBelaCc6E7pydqAvHYpmqSwWafmDDr/zmqi6VYVDYIu3e1GGcYPBXIeIJ2O3bMtexizDe05UQkvUjHEI84ctBkSSL9L0Vz4anxMhf0xOFo5JrLdQLWorX4JLz0zlTkha4Mfl42P7z9xUefuWNa49JDOzr/Jsw5fe7Uc2vVT4eyJntOOs8UktLud7O8Ap0zVxdFk9awCemSVmmvYTLrYEAOp1/OUy339my4xA6JkOaiYWFsjsUYaIEHQ==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by PH0PR11MB7469.namprd11.prod.outlook.com (2603:10b6:510:286::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 15:09:30 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 15:09:26 +0000
From: <Woojung.Huh@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <horms@kernel.org>,
	<Tristram.Ha@microchip.com>, <Arun.Ramadoss@microchip.com>,
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net v5 0/5] Add Microchip KSZ 9897 Switch CPU PHY + Errata
Thread-Topic: [PATCH net v5 0/5] Add Microchip KSZ 9897 Switch CPU PHY +
 Errata
Thread-Index: AQHatmD2OgUb1tL4IUCO2f6bbg5Nx7G3tMpw
Date: Tue, 4 Jun 2024 15:09:26 +0000
Message-ID: <BL0PR11MB2913A1716AF5AE02FA5E2F5DE7F82@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240604092304.314636-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240604092304.314636-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|PH0PR11MB7469:EE_
x-ms-office365-filtering-correlation-id: 1fc3c683-5365-41c7-d5fb-08dc84a8531c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?HFPiwzMoDNR+iWLo0FTth4GJZjeBYfzc4bLG0gpoZjLq0EXsp3OBf3YhqEL1?=
 =?us-ascii?Q?RiLYG6bIUXv1PhFeRNiIMPtPBjbDbojqo9euDoYFTQ+FZ9QOxhagZIr7W4VV?=
 =?us-ascii?Q?NgeHB81fxksE/ynbhk8zwi4IRmepYseMl5kFIE7TlNQiWFBUWg1hAnbWdQ31?=
 =?us-ascii?Q?opuohY05bM+4TgHRgOgVqvyatMaDeEaxCu3x/4I4JExo9jHf6NPUT3XCZWoy?=
 =?us-ascii?Q?XS/gKernEr+gWhw0RQoi53eR99qjeZz3NrUABobQ39J6OYSr30NWXmLIOFTO?=
 =?us-ascii?Q?lFRr1mEV7hoTe6GTQX6eO8wu6IpAHWhiYcWcnrC7Ns4c6GTGErbEw7E913ki?=
 =?us-ascii?Q?9q6jXzCqBEGzASL93C9+ZSIanhvaygdfTMCugQuQCMwb16syQEOEZzh7Gaoh?=
 =?us-ascii?Q?T8kWKixnCKvuX7TZbFgclFGFIVk+YSuQwT8nCN2ew/Wy16Nd8DExOszA9ilB?=
 =?us-ascii?Q?ohCDfLbqPzb/sdKpi3V+mGOLya+SlzDektjq6IoX023jfCj2v7rFYEh4qtvk?=
 =?us-ascii?Q?RxFrP9u/yY+hmHQVOeSVUVLpcg/gtRoXtEegdXarwW4RnzdjJf/K8fKyv0bj?=
 =?us-ascii?Q?YcQdQXZcWfkrYnncvPJTRAbxj8boiVEYADFuozkKLA+zIaGUmw4qd2Z1t+Nh?=
 =?us-ascii?Q?MdZpcX1ls61nlW8pjDxPBdmbPE+uI3mvdPF4/IQ7i/yaFJaT5KBH5LHxEJ8d?=
 =?us-ascii?Q?nzH3fwUjEG8LPBI5iijTw/f4vBjDpWMMcHkMjtFm8w7BvtLLVKdbE6PUQDAF?=
 =?us-ascii?Q?oUdEjKzGxTQI8MB4JRe1GdFASrMZGIHrpgb+vjtXmZdR/1Ie3aJWc6qdRmEJ?=
 =?us-ascii?Q?Y5dRCYiv8ki3i+2iviNF0b+PIOmfLt5IOJVvBsS8LZ43s2v4JuY3fV+VAO/6?=
 =?us-ascii?Q?fLNTQOHEX+YplbJcMunwpgnIQdV32wKvcDYU5peSA9VRGsMbgYytqjeyIcF6?=
 =?us-ascii?Q?MAw/q7BWycwfedk9wQuOdINfefjx6a1pSdfvfuCC9sbpzQdIhvZl5gnGRW5d?=
 =?us-ascii?Q?HMlcTSz/7GJaqWPrGS+PPWW/MQRVdsRxjGlKfh3uh2/+0swx5SM3XYzGCWas?=
 =?us-ascii?Q?7AlyLGyYCrdfq5RcAd8ihnMqki4HuKTe52aHRZ6kGSfmMz8nysHE2tJH+R99?=
 =?us-ascii?Q?d/4U+JtplQ+F+l+hC98AaudbIERCQm3OR4CR9/u++WMBLAQOKXAraIGl9BX3?=
 =?us-ascii?Q?rgxujmxDStVp5JRIr8c+483DOorMkijqqe/NmC/gowdbtEKJURmBb5hSQjEE?=
 =?us-ascii?Q?hS5T2Umh5JGTJKBu79wsYaKzFulJYWEp1OdTDtXrD39vebZ7mx4HMha0/lEX?=
 =?us-ascii?Q?R0hJL0u1SFi1V9C+gTxasRxmbHyNkx85s7qDzqzadDV9yA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FOq4Qq1dQYvxsr7o8cgql2jU/uDfUJhQ6GKLv3pUWOzd7JoomYrb2VU9lLbs?=
 =?us-ascii?Q?H5ngUP+6I/F4pvNg4IkcpVbQHo5VB1y9t3WlYAv2H3jHSjlH6Ho2SKPp3s+B?=
 =?us-ascii?Q?VRAXSvzP2jf4CvnRDt0BLGZD5bSpiZ/6+1/dfts43qLjx4c8lM61TamHq4T2?=
 =?us-ascii?Q?mcW2GT9LoNQ+Z354Ntfv1PrU5WGKtEfFNyEeOY6I2JBMH7iUzhFyNPC15Lsj?=
 =?us-ascii?Q?RK91mz2pMoSRrTzo+MppEP5eFg+yxfBefaMyR1ynzchPe/vIIcp0rtk8g1Bx?=
 =?us-ascii?Q?iwlref9z+F0Ai1bj/OZnzBeCUBiexpl7udirccNX9py9zu/nckf59xrdDE2X?=
 =?us-ascii?Q?PWBoJ0QM1UI/JS27JKc1gYFdY+XsdNOn7FgbN4FLA8KxC6vkLOikj6HmdKsB?=
 =?us-ascii?Q?/565mTtF0AAUd+iXrC00pW4B7fXU5fYEBgdUe4rAB+qz/kcN2Vt/3tWaMnsd?=
 =?us-ascii?Q?ngnrqKrrr+wV5dDGF7Bk7aMT9q1k/+1vkMY4gk8YOKC0063TqEKUexi63Mdm?=
 =?us-ascii?Q?vKc2zErTG2uvgXcd+SbewCvsEgNfCe471OARXruKrhVzskwUEvVlhOMuDpg1?=
 =?us-ascii?Q?ac746uRbfmM+YxsZMV1JPX7DAvCxVMaNhY5WttZ3kyf0hct6cYcTSNqAnw4o?=
 =?us-ascii?Q?irp0SWhn2q7BfK5VItdsE79OsmRBQYOWvTMwF3jLmadPv4GnfPdd0PgWYah+?=
 =?us-ascii?Q?HsZVjrvYBttUPI8//d3A4D6qtfj4tRxp5A6Kx/m4V+Iat1ip+6SUdsmiNyZF?=
 =?us-ascii?Q?N7hTBW8UobFsb1ogF1Lw9iiTja4UAY6WK0Fm6u264Qmxj1YllbFoBsaWGPPo?=
 =?us-ascii?Q?dYPxFffYtQaxSNdz/ZXfqu5NCdWXQHYgPHcJYwb1Sdl7J4OinSdJaLX175aY?=
 =?us-ascii?Q?5aQJUIKFjbyXhi/5vmsogEUfmELixvbT82OmZLJNzc9fCpKyfQe48LEcioUz?=
 =?us-ascii?Q?3TsLOcA5dP5tDFCw+u1PhtuSiPE/xZOZTd/IRfdxuOJ+buAkjjyGtMWN1r5f?=
 =?us-ascii?Q?d49g8WQfy/VFbgZK/9uD4N2cQvZqffzNsj5hkhdyGuv89QS06rhPnAWLSd7M?=
 =?us-ascii?Q?guA7NMmBdI24ldXf8WTPjJgnnS3MsJP+m5ub3LAw/SjBB30IPyD6opi08Xec?=
 =?us-ascii?Q?WHXMb+rl+oNBS1wtICk4gFmYiS8SGfr/B5S4DuM3MPOSMmwX4+TmynBViy99?=
 =?us-ascii?Q?L36+IEO42Z9GvhwISGJmsZh9hFmdH77bXGhkvikep+zPdGJJt65hQxVYJmjX?=
 =?us-ascii?Q?bQmWXldwaxpHaZzELzl5D4yOyO4+qy4i+tNol5L2mSmXKRQRSAHmIRVyh9uR?=
 =?us-ascii?Q?eFLtg/e47elReK4fFlaZFC4yfBrCKCOdhh/Ec4bneKdG/LPZLRlYMRGZZTXB?=
 =?us-ascii?Q?wBJcE9jWmVOlCAVvYb7sAPLloZ0fAUZVvmZ+5xO2LSMUFlnCFdV4VkNdHMnE?=
 =?us-ascii?Q?OIP0mpmc/vldz/1qpzfwy6qMEz6G7b/UvxZxy2b4NELjcHLwJJMv6d+RINkw?=
 =?us-ascii?Q?yTJcs91u2CiMci04MZCRacSvdbgswQH/tN76StRx8/7dQ5iZ0e4GMDvNkmHT?=
 =?us-ascii?Q?i2MeXIrR23utCyImNpYPu+T5vCs3YORiYgE6xaxw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc3c683-5365-41c7-d5fb-08dc84a8531c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 15:09:26.3450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWafjEWlidPt30tlr85ZNSuHLB0FSCGwvt0PqmQOg6R2V71LygvXij+qru37yZRL77LWb5wxi1rKNYMMyz9YWmqsfRPKTKpN3Sd97oseXso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7469

Hi Enguerrand,

Thanks for the patch.

Because some reviewers are out for vacation, I'll try my best to review
even though I'm not directly involved in this system.
Please pardon me if asking same question again.

Thanks.
Woojung

> -----Original Message-----
> From: Enguerrand de Ribaucourt <enguerrand.de-
> ribaucourt@savoirfairelinux.com>
> Sent: Tuesday, June 4, 2024 5:23 AM
> To: netdev@vger.kernel.org
> Cc: andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk; Woojung =
Huh
> - C21699 <Woojung.Huh@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; horms@kernel.org; Tristram Ha - C24268
> <Tristram.Ha@microchip.com>; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>
> Subject: [PATCH net v5 0/5] Add Microchip KSZ 9897 Switch CPU PHY + Errat=
a
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Back in 2022, I had posted a series of patches to support the KSZ9897
> switch's CPU PHY ports but some discussions had not been concluded with
> Microchip. I've been maintaining the patches since and I'm now
> resubmitting them with some improvements to handle new KSZ9897 errata
> sheets (also concerning the whole KSZ9477 family).
>=20
> I'm very much listening for feedback on these patches. Please let me know=
 if
> you
> have any suggestions or concerns. Thank you.
>=20
> ---
> v5:
>  - use macros for bitfields
>  - rewrap comments
>  - check ksz_pread* return values
>  - fix spelling mistakes
>  - remove KSZ9477 suspend/resume deletion patch
> v4: https://lore.kernel.org/all/20240531142430.678198-1-enguerrand.de-
> ribaucourt@savoirfairelinux.com/
>  - Rebase on net/main
>  - Add Fixes: tags to the patches
>  - reverse x-mas tree order
>  - use pseudo phy_id instead of match_phy_device
> v3: https://lore.kernel.org/all/20240530102436.226189-1-enguerrand.de-
> ribaucourt@savoirfairelinux.com/
>=20


